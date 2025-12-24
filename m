Return-Path: <bpf+bounces-77425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6F0CDD0A1
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23520302F814
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8BA30DD38;
	Wed, 24 Dec 2025 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeYYOWS4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3733D6FC
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604321; cv=none; b=rdMidFu6RWtYLXHO/EIp+PF45bqNeaEXqRpq8OcxCxUL0yeEJ0sWO6oH6n1kG9fQAQFUZ2NWhlYWhA8RxRm5O8h4UjNydUEgpuRTs490lGgYfH93IG4MH/E7EH3AsFVHqxwC29gw1W8VUnq9TOhjLpMYyrMubZPw37Hwf/VkSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604321; c=relaxed/simple;
	bh=g4ia34kjOIvmFjHoWZ35eoNLjOCDI5ZbctaKhOKcnlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzVh/6pIfeEn1eLX7rKg2ThIJ5SDLRAzZztJasBHL5fL7s8Qetm4/XKk+WKru5hUATTUOjbYntH8MWaruTdS7yeO3ArKs9rQemrSQnDcQ63A96O4bRW9CgIdBiBp/BoIyxYp+v7R0SfSwLCoz9MOwJrXGWTvJPbD7EyhgA/rF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeYYOWS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB85DC4CEF7;
	Wed, 24 Dec 2025 19:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766604320;
	bh=g4ia34kjOIvmFjHoWZ35eoNLjOCDI5ZbctaKhOKcnlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeYYOWS4Htkj5Z6SRJE2VLqYgvWstfOQ2oTwJLHycjgUDP/VP1Oph6ugTvPDqjGIH
	 w1hkFw/+/XgUMUOE2O6t/UV5ghVULkl3yq9W9+2qjA53Xa0U8tK7oA9r+rNA4n32V5
	 tM6ZP0TGTEis+OfeH0hZ9+Ewc+w0lM4LbGl8ciGTCvwXOSVNwbH22etBaFZv3OPV6V
	 tLZGNFBfHhbBw6hAFOMvHlLN4pIbWt+cN9AIS9q2EEwvZyxPf8gGKLxLsoMDU3abIs
	 iaJSRaSWtfKCu3LBez3b5B7v3AykIUqspQwpy64SIspa2mt2pQ3/A4jgImXwFvftGx
	 u59zSPMQh9ZYg==
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
Subject: [PATCH bpf-next 1/7] bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
Date: Wed, 24 Dec 2025 11:24:30 -0800
Message-ID: <20251224192448.3176531-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224192448.3176531-1-puranjay@kernel.org>
References: <20251224192448.3176531-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the verifier to make trusted args the default requirement for
all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
return true.

This works because:
1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
   own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
2. Struct_ops callback arguments are already marked as PTR_TRUSTED during
   initialization and pass is_trusted_reg()
3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
   call sites (always checked with || alongside is_kfunc_trusted_args)

This simple change makes all kfuncs require trusted args by default
while maintaining correct behavior for all existing special cases.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 35 +++++++++++++++++------------------
 kernel/bpf/verifier.c        | 14 +++-----------
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index e38941370b90..22b5a970078c 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -241,25 +241,23 @@ both are orthogonal to each other.
 The KF_RELEASE flag is used to indicate that the kfunc releases the pointer
 passed in to it. There can be only one referenced pointer that can be passed
 in. All copies of the pointer being released are invalidated as a result of
-invoking kfunc with this flag. KF_RELEASE kfuncs automatically receive the
-protection afforded by the KF_TRUSTED_ARGS flag described below.
+invoking kfunc with this flag.
 
-2.4.4 KF_TRUSTED_ARGS flag
---------------------------
+2.4.4 KF_TRUSTED_ARGS (default behavior)
+-----------------------------------------
 
-The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
-indicates that the all pointer arguments are valid, and that all pointers to
-BTF objects have been passed in their unmodified form (that is, at a zero
-offset, and without having been obtained from walking another pointer, with one
-exception described below).
+All kfuncs now require trusted arguments by default. This means that all
+pointer arguments must be valid, and all pointers to BTF objects must be
+passed in their unmodified form (at a zero offset, and without having been
+obtained from walking another pointer, with exceptions described below).
 
-There are two types of pointers to kernel objects which are considered "valid":
+There are two types of pointers to kernel objects which are considered "trusted":
 
 1. Pointers which are passed as tracepoint or struct_ops callback arguments.
 2. Pointers which were returned from a KF_ACQUIRE kfunc.
 
 Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
-KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
+kfuncs, and may have a non-zero offset.
 
 The definition of "valid" pointers is subject to change at any time, and has
 absolutely no ABI stability guarantees.
@@ -327,13 +325,14 @@ added later.
 2.4.7 KF_RCU flag
 -----------------
 
-The KF_RCU flag is a weaker version of KF_TRUSTED_ARGS. The kfuncs marked with
-KF_RCU expect either PTR_TRUSTED or MEM_RCU arguments. The verifier guarantees
-that the objects are valid and there is no use-after-free. The pointers are not
-NULL, but the object's refcount could have reached zero. The kfuncs need to
-consider doing refcnt != 0 check, especially when returning a KF_ACQUIRE
-pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should very likely
-also be KF_RET_NULL.
+The KF_RCU flag allows kfuncs to opt out of the default trusted args
+requirement and accept RCU pointers with weaker guarantees. The kfuncs marked
+with KF_RCU expect either PTR_TRUSTED or MEM_RCU arguments. The verifier
+guarantees that the objects are valid and there is no use-after-free. The
+pointers are not NULL, but the object's refcount could have reached zero. The
+kfuncs need to consider doing refcnt != 0 check, especially when returning a
+KF_ACQUIRE pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should
+very likely also be KF_RET_NULL.
 
 2.4.8 KF_RCU_PROTECTED flag
 ---------------------------
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2de1a736ef69..049a485fde35 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12040,11 +12040,6 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
-static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta);
-}
-
 static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_SLEEPABLE;
@@ -13253,9 +13248,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
-		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
-		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
-			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
+		if ((register_is_null(reg) || type_may_be_null(reg->type)) &&
+		    !is_kfunc_arg_nullable(meta->btf, &args[i]) &&
+		    !is_kfunc_arg_optional(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
 		}
@@ -13320,9 +13315,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
-				break;
-
 			if (!is_trusted_reg(reg)) {
 				if (!is_kfunc_rcu(meta)) {
 					verbose(env, "R%d must be referenced or trusted\n", regno);
-- 
2.47.3


