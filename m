Return-Path: <bpf+bounces-44523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8539C413A
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 15:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341D6282EE9
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D71A08DF;
	Mon, 11 Nov 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHb+9qJb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB661BC58;
	Mon, 11 Nov 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336498; cv=none; b=Xi2aDDn8ytBuR2vt932FfVbo8J9tVrubZrYM+Q43OyV5maO1iLmk92EVCDsZJxz3beqzY6ImA6Px54LPi0oojYC5qPV+g0u14ZtLFbFfWZs45zzPgaj8mE9QKYgf++3cNW+scZr8pn6bX2fpNzptuo71ZHNUeECNFlxJGCG5YTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336498; c=relaxed/simple;
	bh=fwBFnUI7zZAzmO8sGg3BYlDlfcXoixbrHRm+40n+lk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZKy5nr1tbAarD0wu5DW6ilpMggxC0evDJDCeFT7zi/mnH/CfhqdnXfjrJTUyfcGeSk4IjEzDErWnvDiqIaphpC3NEaDyu/hxmiCt4NEijlmFoFLc5Q8WKUsZrR8h4oqIKR5EYUT+wcOZjSfJ0ue2IPJN1kkjnJ2lZc19uZNsfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHb+9qJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33DDC4CECF;
	Mon, 11 Nov 2024 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731336497;
	bh=fwBFnUI7zZAzmO8sGg3BYlDlfcXoixbrHRm+40n+lk8=;
	h=From:Date:Subject:To:Cc:From;
	b=MHb+9qJbPFk1ZvtJbEhgbvy/3dWUgRZNdD9IbJDZJh9o0OKScN3QKwPovXbuL07UE
	 jo6QDtCZqvGPNsBi3mF8/By6cKGPsKyh57GYVpnmKsh7mrCz4XA3ddzD/pGppySn97
	 /4i9ovM3kg96GOdibKIZMwOekArm5kBpCspSSK05KGSy1MRDaGuZwPjasCr+IkjO1S
	 Oe1GttwMyxzg9D+sEBiA/73PqWwy9jZFiEgMJny7wDD0JYi7RkqcXxvDHL5FQYOkvg
	 6pYtcAX+DyprUfKFz2G11DjVlC3wNWN5b+TWy4uVCt3GrT+B+wFA4rllo2PK5Jsiys
	 a95zJCh0spvmQ==
From: Simon Horman <horms@kernel.org>
Date: Mon, 11 Nov 2024 14:47:51 +0000
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
Message-Id: <20241111-nf-bpf-fmt-v1-1-5f061b6fe35b@kernel.org>
X-B4-Tracking: v=1; b=H4sIABYZMmcC/x2MSwqAMAwFryJZG2iL4Ocq4kJrollYpRUpSO9uc
 HYD894LiaJQgqF6IdIjSc6gYusK/D6HjVBWdXDGNVbBwLhcjHzcSN60zvez7ZhBB1cklvyfjaB
 doHzDVMoH7c0P0mUAAAA=
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 llvm@lists.linux.dev
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

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/netfilter/nf_bpf_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 3d64a4511fcf..06b084844700 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -43,7 +43,7 @@ get_proto_defrag_hook(struct bpf_nf_link *link,
 	hook = rcu_dereference(*ptr_global_hook);
 	if (!hook) {
 		rcu_read_unlock();
-		err = request_module(mod);
+		err = request_module("%s", mod);
 		if (err)
 			return ERR_PTR(err < 0 ? err : -EINVAL);
 


