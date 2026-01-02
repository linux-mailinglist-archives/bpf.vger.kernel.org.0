Return-Path: <bpf+bounces-77697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC291CEF20E
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFAC6301510B
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5562FE571;
	Fri,  2 Jan 2026 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHWTpwTT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C62FE58C
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376871; cv=none; b=BVpQSmRhmoqecO5EaLoHC56VYzeII5oJ4iwSUYS2umLmM1XMWirdcJc2dX/XHafRJLDwMIUeQaQMcvlJ5SKGX30n8R9djDMNo7nJoGff61LkroeIRsxAImBcb8EoykjQVjmtiidB1CVR0r1rpgl73e4GAmL1D2KprmK9demhbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376871; c=relaxed/simple;
	bh=9UHjbZ7FjU21FqG0IcPANNqfa/OIayt1doeJFFvuW4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/s99YuZtcoyyQl7g6wRhtwkk0zPGyJ717THvz18y3ifIhW/5ladkx9B/+9chEJCrPXIVCWYNVPM4Ddjlxal2Z4Z6qbH+FCFCTRMDpM7/02M+jLuz61pwe1zqUsomt/dSbfD7NxRxG2s3KL4R49FqK5hoEg+hF58t5IaU8E5aAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHWTpwTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0274C19425;
	Fri,  2 Jan 2026 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376869;
	bh=9UHjbZ7FjU21FqG0IcPANNqfa/OIayt1doeJFFvuW4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHWTpwTTTil1+l555MwTpuKcPLY0m1A0m0wqhprxMUUe4T5nlCg5ec/cxm3DucBIB
	 YEORpElnVLP/VTusQXzbO6QBTwhNeQQxsXUxNuYGP9e3n+RS5u/9ugusiS9rproFJg
	 M00uKxlonc65VaTNoc/5MXuvjrlDr++1R48yZ7N6w0vI/UwiYPEhNvZgdhDDToydEm
	 orXsTAE5htdfIK7oVB25bFW0ShxIL4hef1+B2X8purDuL2s429ehn/mLpGKX5DWBeG
	 r6zbCEHNV+i6k3kqhaha1vY8qFylXmGfltS2Wyguss9ckR8BzWu/T5VVi8iRaLUHXj
	 37++8tkqZi3Gw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 04/10] bpf: xfrm: drop dead NULL check in bpf_xdp_get_xfrm_state()
Date: Fri,  2 Jan 2026 10:00:30 -0800
Message-ID: <20260102180038.2708325-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
References: <20260102180038.2708325-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As KF_TRUSTED_ARGS is now considered the default for all kfuncs, the
opts parameter in bpf_xdp_get_xfrm_state() can never be NULL. Verifier
will detect this at load time and will not allow passing NULL to this
function. This matches the documentation above the kfunc that says this
parameter (opts) Cannot be NULL.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 net/xfrm/xfrm_state_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 2248eda741f8..4180c317f9bc 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -68,7 +68,7 @@ bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32
 	struct net *net = dev_net(xdp->rxq->dev);
 	struct xfrm_state *x;
 
-	if (!opts || opts__sz < sizeof(opts->error))
+	if (opts__sz < sizeof(opts->error))
 		return NULL;
 
 	if (opts__sz != BPF_XFRM_STATE_OPTS_SZ) {
-- 
2.47.3


