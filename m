Return-Path: <bpf+bounces-52081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AB8A3DB99
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 14:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BD57AAB43
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCADB1FA243;
	Thu, 20 Feb 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPwg/LWw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2E15ECD7;
	Thu, 20 Feb 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059125; cv=none; b=TAppI4Iyv0XrDpfc2UOraSHJ3Y+Cwk8mqUapbd4jfDteJlm1/pWQv9V2BguuQIZ/vvkM8RmEcznogbQ27TZQ92cAGUXnXG0ORaamY+e8u4rldpKxucQ3YMstAVEvJwN6hqBpF/Go6ilvOPRxj503BM+7vxyY4BLCIIRULTqU7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059125; c=relaxed/simple;
	bh=o+7AbNx28kTmjaHrZMgZVOwFZ65jE+f8pFCru/Rt8rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHB2a1AAaKOEQAyTkIRtI9hwM2gZ/s8qg4qFsorBkIcHTXwQYII8H2BAnCnFJE2QZxOzNOjjtDFlnCfQ+RlBEK1u8Y7Gsz7tE8oPueNkPUtzO/q4zpi/+ygFS+oYh5Y3QdIZP6IGvNycLzTpjoeIH4P50P3f4xWd4NxuwchL7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPwg/LWw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740059124; x=1771595124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+7AbNx28kTmjaHrZMgZVOwFZ65jE+f8pFCru/Rt8rs=;
  b=BPwg/LWwgiSBgsxqOA6/OUQnuL5plM7J2KSv7mq6ItIlL+mPen90GO9o
   FGnf7qfg2BD2ZWECNry2YMDN3hT4bmDHxoX8kPiWndw03rM/iQmkd/At1
   jo259SrxwlFPRpuCyubn0hvM9kY/5wpxg7rZJSLS91H7ehgmh+t6aceCd
   zm96P2ikXKWgyuG4nyIyD1lo2Cf/Zwa1EZNDMoZVH4e+SMQcvpK1r/E59
   gSRFRSHF92ssi+cPgbpsTrJPFxUpgEAUd+vfkwhGAc3r/l5C/VSvcQQ7U
   YSWQ/IzWN5DlC1XOQsMf4dG3C3GzQLplUdN3tXLoW30i/Yy4vinxbMmWg
   w==;
X-CSE-ConnectionGUID: lxHjjGenTcaLxuZ44tu3Zg==
X-CSE-MsgGUID: GPG7nXR+RGK9fSvpcTnvag==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51479217"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="51479217"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 05:45:23 -0800
X-CSE-ConnectionGUID: 8DUjGMx9QfW4BQF02X/Ywg==
X-CSE-MsgGUID: lkilHUjkQPWQRUiQdQg1UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119146253"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 20 Feb 2025 05:45:20 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	martin.lau@linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next 1/3] bpf: call btf_is_projection_of() conditionally
Date: Thu, 20 Feb 2025 14:45:01 +0100
Message-Id: <20250220134503.835224-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently verifier thinks when sk_buff is used as kfunc's argument it is
coming as pointer to context (KF_ARG_PTR_TO_CTX) but in kfuncs that are
going to be introduced for sk_buff's refcount handling we want it to be
interpreted as KF_ARG_PTR_TO_BTF_ID.

Make it possible by calling btf_is_projection_of() conditionally.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/linux/btf.h   |  4 ++--
 kernel/bpf/btf.c      | 11 ++++++-----
 kernel/bpf/verifier.c |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ebc0c0c9b944..1307ea17542a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -585,7 +585,7 @@ struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
 bool btf_is_projection_of(const char *pname, const char *tname);
 bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			   const struct btf_type *t, enum bpf_prog_type prog_type,
-			   int arg);
+			   int arg, bool check_proj);
 int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
@@ -661,7 +661,7 @@ static inline struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf
 static inline bool
 btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		     const struct btf_type *t, enum bpf_prog_type prog_type,
-		     int arg)
+		     int arg, bool check_proj)
 {
 	return false;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 69f5752e880b..62bdf6980cfb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5909,7 +5909,7 @@ bool btf_is_projection_of(const char *pname, const char *tname)
 
 bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			  const struct btf_type *t, enum bpf_prog_type prog_type,
-			  int arg)
+			  int arg, bool check_proj)
 {
 	const struct btf_type *ctx_type;
 	const char *tname, *ctx_tname;
@@ -5969,8 +5969,9 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	 * int socket_filter_bpf_prog(struct __sk_buff *skb)
 	 * { // no fields of skb are ever used }
 	 */
-	if (btf_is_projection_of(ctx_tname, tname))
-		return true;
+	if (check_proj)
+		if (btf_is_projection_of(ctx_tname, tname))
+			return true;
 	if (strcmp(ctx_tname, tname)) {
 		/* bpf_user_pt_regs_t is a typedef, so resolve it to
 		 * underlying struct and check name again
@@ -6133,7 +6134,7 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
 				     enum bpf_prog_type prog_type,
 				     int arg)
 {
-	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg))
+	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg, true))
 		return -ENOENT;
 	return find_kern_ctx_type_id(prog_type);
 }
@@ -7739,7 +7740,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		if (!btf_type_is_ptr(t))
 			goto skip_pointer;
 
-		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i)) {
+		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i, true)) {
 			if (tags & ~ARG_TAG_CTX) {
 				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
 				return -EINVAL;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e57b7c949860..6492bfa4bc7a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11997,7 +11997,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	 * type to our caller. When a set of conditions hold in the BTF type of
 	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
 	 */
-	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
+	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog),
+				 argno, false))
 		return KF_ARG_PTR_TO_CTX;
 
 	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
-- 
2.43.0


