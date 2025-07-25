Return-Path: <bpf+bounces-64324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B113B11775
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 06:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6CE1CE074B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 04:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F93923C50A;
	Fri, 25 Jul 2025 04:34:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116618BBAE
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418083; cv=none; b=D1ql4FbYm+4NNr4wHbppgkeoM547IGiNnsJ44krwW68PSVDYfwe115sZPfbU3H80+36oBjXFaMKOwYM64NEr5fgj03ERsw9IT299+ssBlPU/Cn3NHBKPp4JL6hHeOfcbnjb8MK2ETjfgIgXdhqqgLefoAYKOilFuRH7DFBFWhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418083; c=relaxed/simple;
	bh=DaMG/r65719Nw2Om2znT75jlHD1MlbnwdZtfCkU7E88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8i209ju5ZRgLPhT3XdklWUfQE2PK/070NCSTvEHeqUOC/Qh3Zrj/5ok3n1eBEaLpK8fSy1uE+tOol+DUk3sNW5gDKvDpIY1WN/lz4DpP80v6hRIxjzWYn2DmxlqPx6z9ZihzHQcSJQSsuAxFe5UKSB6vQ1qCNcSEGDPeSPp+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 85801C48A525; Thu, 24 Jul 2025 21:34:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Fix test dynptr/test_dynptr_copy_xdp failure
Date: Thu, 24 Jul 2025 21:34:35 -0700
Message-ID: <20250725043435.208974-1-yonghong.song@linux.dev>
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

For arm64 64K page size, the bpf_dynptr_copy() in test dynptr/test_dynptr=
_copy_xdp
will succeed, but the test will failure with 4K page size. This patch mad=
e a change
so the test will fail expectedly for both 4K and 64K page sizes.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/dynptr_success.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
index 7d7081d05d47..3094a1e4ee91 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -611,11 +611,12 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 	struct bpf_dynptr ptr_buf, ptr_xdp;
 	char data[] =3D "qwertyuiopasdfghjkl";
 	char buf[32] =3D {'\0'};
-	__u32 len =3D sizeof(data);
+	__u32 len =3D sizeof(data), xdp_data_size;
 	int i, chunks =3D 200;
=20
 	/* ptr_xdp is backed by non-contiguous memory */
 	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+	xdp_data_size =3D bpf_dynptr_size(&ptr_xdp);
 	bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
=20
 	/* Destination dynptr is backed by non-contiguous memory */
@@ -673,7 +674,7 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 			goto out;
 	}
=20
-	if (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len * chunks) !=3D -E2=
BIG)
+	if (bpf_dynptr_copy(&ptr_xdp, xdp_data_size - 3000, &ptr_xdp, 0, len * =
chunks) !=3D -E2BIG)
 		err =3D 1;
=20
 out:
--=20
2.47.3


