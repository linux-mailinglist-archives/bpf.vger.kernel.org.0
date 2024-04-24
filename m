Return-Path: <bpf+bounces-27748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352AC8B163E
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671C11C229C7
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473816DEA4;
	Wed, 24 Apr 2024 22:35:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8374420
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998154; cv=none; b=Kf5Pc+mMteADcki5ztqk9RpX6NG+D3Qb3Q3TV6q9XWLbsHnj7luv4YFlc0m/Qw7btt25WozfNEBW1O+KNREpMI9fdCQ7bDnSENRz8yLjKsHbfCZ3IqFjWrU58gb2VzS1OfYglgs3qorNUxlW6qoJlYlUjGkKeJIjPAQgYt08yok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998154; c=relaxed/simple;
	bh=eEBV1vuNFlLQkvjxmToNQpnyFyd8I66s8AOZen6ncJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1IjjjoU8ayw1o/NjdusMAWM7Oe4j0FP8PIwGVq4t2gswF2+Xg2cDQTDYvIxfCyjSeXbUt/GaIFPjaNNtjFRdI+EywtMV1LBpLwcdqFoUCD2OyJFChWmr77+H7+yiNfj1RNAv/m6v7Cxyf2geGfaTCHUAKaYv4U9R+qJ/5Fa/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2104D367AE08; Wed, 24 Apr 2024 15:35:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Nick Desaulniers <ndesaulniers@google.com>,
	Xin Liu <liuxin350@huawei.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_encoder: Fix dwarf int type with greater-than-16 byte issue
Date: Wed, 24 Apr 2024 15:35:38 -0700
Message-ID: <20240424223538.2682496-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Nick Desaulniers and Xin Liu separately reported that int type might
have greater-than-16 byte size ([1] and [2]). More specifically, the
reported int type sizes are 1024 and 64 bytes.

The libbpf and bpf program does not really support any int type greater
than 16 bytes. Therefore, with current pahole, btf encoding will fail
with greater-than-16 byte int types.

Since for now bpf does not support '> 16' bytes int type, the simplest
way is to sanitize such types, similar to existing conditions like
'!byte_sz' and 'byte_sz & (byte_sz - 1)'. This way, pahole won't
call libbpf with an unsupported int type size. The patch [3] was
proposed before. Now I resubmitted this patch as there are another
failure due to the same issue.

  [1] https://github.com/libbpf/libbpf/pull/680
  [2] https://lore.kernel.org/bpf/20240422144538.351722-1-liuxin350@huawe=
i.com/
  [3] https://lore.kernel.org/bpf/20230426055030.3743074-1-yhs@fb.com/

Cc: Xin Liu <liuxin350@huawei.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e1e3529..19e9d90 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -393,7 +393,7 @@ static int32_t btf_encoder__add_base_type(struct btf_=
encoder *encoder, const str
 	 * these non-regular int types to avoid libbpf/kernel complaints.
 	 */
 	byte_sz =3D BITS_ROUNDUP_BYTES(bt->bit_size);
-	if (!byte_sz || (byte_sz & (byte_sz - 1))) {
+	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16) {
 		name =3D "__SANITIZED_FAKE_INT__";
 		byte_sz =3D 4;
 	}
--=20
2.43.0


