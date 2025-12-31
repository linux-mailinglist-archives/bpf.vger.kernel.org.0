Return-Path: <bpf+bounces-77608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7BFCEC566
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FE33016709
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D96B2868B4;
	Wed, 31 Dec 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBaokqso"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC1283686
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201121; cv=none; b=XP8sxKyCBpPmDf5Xse80NBkIvcFjr3tUwvCZ2wCr43S4ajsH36NWZo4ywVJv0eKx2HWrBOuNTw035wykAClEat7xdPMLsk8mW5KCZM1OneCATY73a4z7chKDpinkvItZ3T6Syt17faXKGS3nibu/znKPJMJ3IQWxQpDkOcY5kwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201121; c=relaxed/simple;
	bh=EeIUCkniL/XYGdmDYf57muJwBa/5z8kso2X0jMa6UXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVkpcoROv78EFPL/2IcBGuFoW6+LDl5JAl9QrMGQia06rjUpBlgy7Qz6LPzY51YLB6O6/x1HUG8CJ5j2Saw9YS07Ybt1GUteAtY7vUdiBfXsCBYm4ZsiRQp5yiGLaF0dl/K/794unOd4lYKBvR6nF4HOmOl3607ilLoSxNf9U/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBaokqso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EFEC113D0;
	Wed, 31 Dec 2025 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201120;
	bh=EeIUCkniL/XYGdmDYf57muJwBa/5z8kso2X0jMa6UXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBaokqsoPCvKJ1QiEfh2dRF667E8g5wyJeIfO8xIzWusJxGLjBkj/HYJAsxSSXCZx
	 nyZLEx9Bsyl0B4erKqhjKWWSMapcHNT+SdiEtfgLgaSatZqTdt+sJ+txvKMdPe1Ruf
	 6KNsMzXxVCYWDcwci5AgZ6rYw7Sdx5hTByh+Gnv8ohyzc88g6b6wSkr2I88suv4Vm7
	 +FTC1MrE9pNhLhLSTQyIRxdt6i30Tqa9TttKGuWqN+nfi1bQAUAdAITrsg+rC7bSCn
	 Bj3qWGSa6jtSDHCMpvtBKTc2NbDmRYWcfJirKm0O9pOZrwdglaQdIqwVs1F3zADc3g
	 kAJjFQNDjqzVA==
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 8/9] bpf: xfrm: drop dead NULL check in bpf_xdp_get_xfrm_state()
Date: Wed, 31 Dec 2025 09:08:54 -0800
Message-ID: <20251231171118.1174007-9-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231171118.1174007-1-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
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


