Return-Path: <bpf+bounces-60016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17D8AD1366
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D80C188A4F7
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8619DFA2;
	Sun,  8 Jun 2025 16:55:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCD7156C40
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401749; cv=none; b=vFyhW+173heoyzU3yx0icHWc4wJznwQgxRlwvHXolOO4FVPJGQQcMjJuGg8VCgf/63bjablBiH9NDr5F4YpMtfvKbtdUCouGs/T+rTRUpMcALX5gx9UGojtxF6m7Z8TFA8fRwbm2iDuVPaKM3Dn6d7KciwXp9bRkYZ2SD0/fMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401749; c=relaxed/simple;
	bh=HtrJi9UZfgTNlKG2puzEmq01J1Qpzl4gIE5zDoT1qvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1lMqBL0xF0k/Owzeuzz9ejRkP9dU7iQ5KkdSMAg23XaExV0mYD74PFmHxiINuFc41+ut5gjx5O6lrG7tb6SnloenOGZ3kzH9SXbRNvBNIryQ1ny1r389UTH6aZ5wrG1dP9P2HPThe+/Ct69nIlIV5ksa++cWLnAz/4jchev0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 625F191DF888; Sun,  8 Jun 2025 09:55:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than 4K
Date: Sun,  8 Jun 2025 09:55:34 -0700
Message-ID: <20250608165534.1019914-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The bpf selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow failed on
arm64 with 64KB page:
   xdp_adjust_tail/xdp_adjust_frags_tail_grow:FAIL

In bpf_prog_test_run_xdp(), the xdp->frame_sz is set to 4K, but later on
when constructing frags, with 64K page size, the frag data_len could
be more than 4K. This will cause problems in bpf_xdp_frags_increase_tail(=
).

Limiting the data_len to be 4K for each frag fixed the above test failure=
.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 net/bpf/test_run.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index aaf13a7d58ed..5529ec007954 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1214,6 +1214,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
 	u32 repeat =3D kattr->test.repeat;
 	struct netdev_rx_queue *rxqueue;
 	struct skb_shared_info *sinfo;
+	const u32 frame_sz =3D 4096;
 	struct xdp_buff xdp =3D {};
 	int i, ret =3D -EINVAL;
 	struct xdp_md *ctx;
@@ -1255,7 +1256,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
 		headroom -=3D ctx->data;
 	}
=20
-	max_data_sz =3D 4096 - headroom - tailroom;
+	max_data_sz =3D frame_sz - headroom - tailroom;
 	if (size > max_data_sz) {
 		/* disallow live data mode for jumbo frames */
 		if (do_live)
@@ -1301,7 +1302,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
 			frag =3D &sinfo->frags[sinfo->nr_frags++];
=20
 			data_len =3D min_t(u32, kattr->test.data_size_in - size,
-					 PAGE_SIZE);
+					 frame_sz);
 			skb_frag_fill_page_desc(frag, page, 0, data_len);
=20
 			if (copy_from_user(page_address(page), data_in + size,
--=20
2.47.1


