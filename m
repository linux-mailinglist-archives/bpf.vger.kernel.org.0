Return-Path: <bpf+bounces-64326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCAEB11777
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 06:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D936E1CE06EB
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 04:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87323F412;
	Fri, 25 Jul 2025 04:34:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8423B63B
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418084; cv=none; b=meqOcsFXK40Tchc8y28GnfFrR55284hw15CGPmJAAVsVR8UBcuQwrkxgYDkxu3OWC6BvllK0YR2ciA9DUH3oCPZoZuNyqGHMZb0O2iRwZEYOwuvD/aE2NeNidMHB0GN9M9yyTco+Uhj3agWRKTCfGpHLXQwBtAf2/Z+Ig1gbUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418084; c=relaxed/simple;
	bh=dLvJFapkl/9Ii+9bFVeUE1Zm7UW6Xkrs2Cm3Zx0/tjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+MJclxf+uaX0D5KWg5N7ytIFWv2gZBUTHS6SvCAebXtrXYa1OWShMUHBhnXT/U+7jd/lxOjhRJWhrrX10gSdRjcrwwxOL0bv1rWGP5tm99GqcmDBmHYfO7Hi6Hb8jq3VAUMbTRX+SBoLvtBdDTTCg2H2M/9X/3XneaCvpI2h0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9E564C48A546; Thu, 24 Jul 2025 21:34:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Fix test dynptr/test_dynptr_memset_xdp_chunks failure
Date: Thu, 24 Jul 2025 21:34:40 -0700
Message-ID: <20250725043440.209266-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250725043425.208128-1-yonghong.song@linux.dev>
References: <20250725043425.208128-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For arm64 64K page size, the xdp data size was set to be more than 64K
in one of previous patches. This will cause failure for bpf_dynptr_memset=
().
Since the failure of bpf_dynptr_memset() is expected with 64K page size,
return success.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/dynptr_success.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
index 3094a1e4ee91..8315273cb900 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -9,6 +9,8 @@
 #include "bpf_misc.h"
 #include "errno.h"
=20
+#define PAGE_SIZE_64K 65536
+
 char _license[] SEC("license") =3D "GPL";
=20
 int pid, err, val;
@@ -821,8 +823,17 @@ int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp=
)
 	data_sz =3D bpf_dynptr_size(&ptr_xdp);
=20
 	err =3D bpf_dynptr_memset(&ptr_xdp, 0, data_sz, DYNPTR_MEMSET_VAL);
-	if (err)
+	if (err) {
+		/* bpf_dynptr_memset() eventually called bpf_xdp_pointer()
+		 * where if data_sz is greater than 0xffff, -EFAULT will be
+		 * returned. For 64K page size, data_sz is greater than
+		 * 64K, so error is expected and let us zero out error and
+		 * return success.
+		 */
+		if (data_sz >=3D PAGE_SIZE_64K)
+			err =3D 0;
 		goto out;
+	}
=20
 	bpf_for(i, 0, max_chunks) {
 		offset =3D i * sizeof(buf);
--=20
2.47.3


