Return-Path: <bpf+bounces-42394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D859A3A4F
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ACB283754
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9CE200BBE;
	Fri, 18 Oct 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttm/+w35"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36B13A88A;
	Fri, 18 Oct 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244586; cv=none; b=odsrilnzM3z9zfAYqJ8XEY3gfQrB6l8HB48t0+pZrkgQX+fPWfHueAhLMiadRr2nozgbeRRGd5mK1myE+mhVjkTDce1PgekRPfwo02ooM9ldquBOIrc3PoGUqwy74bV3Xlu5hFacPgwood8u4cBo/lxZVPhwJDQDSS14mTzysDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244586; c=relaxed/simple;
	bh=fLIrvQDX07IoKF46VFq158a7yUx1ZCpiEymxP3YbaIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VNbUqM2lKi0j+r2uGLXkYhIJiUytPquwoBznAGqPgqa/OT6oPvAHZAuwUgCztZs4DFrdgG25ayd5B7hRKZIg1WjG6GhgRyUecLDgqm8w//nYdnneMbuy8c1+0HCuHlkwIR9VkT2/Oo1y/lM/w5jGY/c7pqobmlg16Q/hG7Wsfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttm/+w35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FA3C4CEC3;
	Fri, 18 Oct 2024 09:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729244585;
	bh=fLIrvQDX07IoKF46VFq158a7yUx1ZCpiEymxP3YbaIA=;
	h=From:Date:Subject:To:Cc:From;
	b=Ttm/+w35PWgvY/wiDeBn0di87HB3K+xVy0Vh0d9yNyLgBhdSyEM/eEpRfmvfytQH+
	 dHZKqYioESVaFmBpLh3TIR2h7oeg8XGERgD5c4WcnribPvm4CRQ75jYhPnKxUuViah
	 YujFEaJwXZ6upg3U8XeU1JulArdlnjC8kIXN0AQuoxs2DX+lH0q/jsdEQgqAhbeyos
	 umf+0WZAoZ46QYHNocYMECj8PDWZjcrLm47xQ7misCSIDt/2BXE7/8vG+knhT5nqDu
	 xL73qKWGuDr/YG7ZFlGhestMkJ60RepDaEMASv4Z113IJC7R9hHhcbLIS0GttO2Mn1
	 yez06pSMnbE/A==
From: Simon Horman <horms@kernel.org>
Date: Fri, 18 Oct 2024 10:42:58 +0100
Subject: [PATCH nf-next] netfilter: bpf: Pass string literal as format
 argument of request_module()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-nf-mod-fmt-v1-1-b5a275d6861c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKEtEmcC/x2MQQqAIBAAvyJ7bkEtMPpKdKhcaw9qaEQg/j3pO
 DAzBTIlpgyTKJDo4cwxNFCdgP1cw0HItjFoqQcl1YjBoY8Wnb/RaNsbKVe92Q1acCVy/P6zGZo
 X6L1hqfUDXk1BCWUAAAA=
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.14.0

Both gcc-14 and clang-18 report that passing a non-string literal as the
format argument of request_module() is potentially insecure.

E.g. clang-18 says:

.../nf_bpf_link.c:46:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
   46 |                 err = request_module(mod);
      |                                      ^~~
.../kmod.h:25:55: note: expanded from macro 'request_module'
   25 | #define request_module(mod...) __request_module(true, mod)
      |                                                       ^~~
.../nf_bpf_link.c:46:24: note: treat the string as an argument to avoid this
   46 |                 err = request_module(mod);
      |                                      ^
      |                                      "%s",
.../kmod.h:25:55: note: expanded from macro 'request_module'
   25 | #define request_module(mod...) __request_module(true, mod)
      |                                                       ^

It is always the case where the contents of mod is safe to pass as the
format argument. That is, in my understanding, it never contains any
format escape sequences.

But, it seems better to be safe than sorry. And, as a bonus, compiler
output becomes less verbose by addressing this issue as suggested by
clang-18.

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/netfilter/nf_bpf_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 5257d5e7eb09..6b9c9d71906d 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -42,7 +42,7 @@ get_proto_defrag_hook(struct bpf_nf_link *link,
 	hook = rcu_dereference(*ptr_global_hook);
 	if (!hook) {
 		rcu_read_unlock();
-		err = request_module(mod);
+		err = request_module("%s", mod);
 		if (err)
 			return ERR_PTR(err < 0 ? err : -EINVAL);
 


