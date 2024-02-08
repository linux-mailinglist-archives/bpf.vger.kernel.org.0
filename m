Return-Path: <bpf+bounces-21483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D384DA61
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8329B1F227F6
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B26994C;
	Thu,  8 Feb 2024 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9X8OWrI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E6692E5
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375072; cv=none; b=h56VZt11rfhU9WwIMCo6SDFcMI7b6+5pNlENSGZiw0U0N2UYukaPPIfPZzKhueE+0DENZj8ChqL/aVh5Q+dAUL54prRNjFiTeO/PgHAcndS0/tZL8hkcHNw7uEBsSsNKEc/Rer6GeWRBFJ0GPht+DMy1EDhkTSsHIajm2zonMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375072; c=relaxed/simple;
	bh=0/bZcVG4/tQ4p0L1j4bI5UOfaU/N5VdSk50NN1ei9As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=baaOykheYtft94UTgWYLVJzpyis13ClhtHpjaOR3m6oYJRU57q6I8PDkFofQvX8Lx47rVZIu6N3F3zFo3+AARIK1j7+ppaSKOyfAkr+2TJJkf21T+aqqWRh2AOD32DO2lwXcDBdSLjE8vBePCOs1EJJ2mtIaMyLFcaVMaHPnjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9X8OWrI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-604a3d33c4dso5329137b3.1
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 22:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707375069; x=1707979869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp/j5+8XDQjoFjshzlpayUstaTLunC9tsar6Rjql3D0=;
        b=U9X8OWrILQ3v2XwT09RH3qx/H86M4NFUjUwL8m0EJXqwnTkZitPWhV5kDOqnub5h9R
         L8XoTqRojijMtsGCC2OBGFWJDkc7hi0sn+0C3bFYeOBHY2mar57TdWQBRounOtxi0LlL
         qMixNR2r2Zjg1xGlGVN/0zmpTryQnsPAzIuhLC7y87mMXKkK5BIcCxMkHGu8OBtkP5Nz
         DOXIPTzUAZGDkANSAmTCSn5Bb49UGVdFREzjCSCMA8bX+yh5OAPYDSNh1y2JAaHxj2eZ
         9QhtPSnhvrKl8PxfHKYsAkUHGWxLkfUyqQyhXuHieMGCvkO6fXK/YMHJpRvopRtcrLuA
         pnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707375069; x=1707979869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp/j5+8XDQjoFjshzlpayUstaTLunC9tsar6Rjql3D0=;
        b=nb+PAUlbnyxhB/9mMnqlyTZxt8xUOxQRLPbelyEbh4fLZaocZg/x1oWQ0hbJopRv7Z
         K+wHfA4ncIr1wm3IiG4CcWULwcVmXmppS9goFe+uC03VQL2PXC53B9a9or7KbcTN0oSj
         rHDNKJq8ofE94i/6Pi0NyT+YRNBLZZ2P2vhn2e5G4zLzzhUnRRrdxMSMpCzQ7gpU5lMO
         Aez2vd2edUR/Ics8H/+URsvZQCvDo2+6e7RdQNfrvzqt15J/Dti/vrkgcjhdgu/h2Xtu
         xTd2OnZDIBZeSjgx4roHz1u77OrX2t/boPnQyEa2EZvpvZAW5MyGBqfmZcb2zeoq/vXR
         BaIA==
X-Gm-Message-State: AOJu0YyeCetIwnV3T4WipHJK0Vt8imE3HMQ3E2MPcdM35RkfG//4nPsk
	uY0CRAzicvZF1/yF+GG/t93niYjizpSEp1yYgaCsDfQFRKKIpVFQvU8iysw+ZRk=
X-Google-Smtp-Source: AGHT+IFr1dp0ixb3vSwrAPPVFQJpMW+8MVN4HghdVgNupC8q9RlYRK8Sg+roebENthscp1mRur5YaA==
X-Received: by 2002:a81:4ec7:0:b0:604:a32c:9998 with SMTP id c190-20020a814ec7000000b00604a32c9998mr1719348ywb.22.1707375069163;
        Wed, 07 Feb 2024 22:51:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv9IsyXJQA7zLs+Wz7kZj+sKUgMcz7+Zqg1h5xca1QkQ/E0LNlC+LSIZz0SsHwv7fu3bQGPC45/YZcSWpK4yrVve0U8/8TdhW/lOKeCgFQkRQAAKhFdZs6odEPjt97HMFjc75MPqG1kDG8j4btvN8R+kTmMt5B3TObB+AaiahKPHxa7oAlEvNaJ7F3QIE8mUIQsqL5bNEpr4knynAszUua+MoIAs3IrlEQzyC2jWzqjhoN3qd/RpFV/bDRqp+8wS5GjWb4jBuLqL8dvgD7UPAeQK+yA1kivz3PLkT6GF0vkVI=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1d02:e957:f461:9a61])
        by smtp.gmail.com with ESMTPSA id u203-20020a8184d4000000b0060467650c64sm596917ywf.62.2024.02.07.22.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 22:51:08 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 2/4] bpf: Move __kfunc_param_match_suffix() to btf.c.
Date: Wed,  7 Feb 2024 22:51:01 -0800
Message-Id: <20240208065103.2154768-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208065103.2154768-1-thinker.li@gmail.com>
References: <20240208065103.2154768-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Move __kfunc_param_match_suffix() to btf.c and rename it as
btf_param_match_suffix(). It can be reused by bpf_struct_ops later.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/btf.h   |  4 ++++
 kernel/bpf/btf.c      | 18 ++++++++++++++++++
 kernel/bpf/verifier.c | 38 ++++++++++----------------------------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1ee8977b8c95..df76a14c64f6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -495,6 +495,10 @@ static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
 	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
 }
 
+bool btf_param_match_suffix(const struct btf *btf,
+			    const struct btf_param *arg,
+			    const char *suffix);
+
 struct bpf_verifier_log;
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index aa72674114af..e3508b8008a2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8907,3 +8907,21 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 }
 EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
 #endif
+
+bool btf_param_match_suffix(const struct btf *btf,
+			    const struct btf_param *arg,
+			    const char *suffix)
+{
+	int suffix_len = strlen(suffix), len;
+	const char *param_name;
+
+	/* In the future, this can be ported to use BTF tagging */
+	param_name = btf_name_by_offset(btf, arg->name_off);
+	if (str_is_empty(param_name))
+		return false;
+	len = strlen(param_name);
+	if (len <= suffix_len)
+		return false;
+	param_name += len - suffix_len;
+	return !strncmp(param_name, suffix, suffix_len);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64fa188d00ad..7edd70eec7dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10675,24 +10675,6 @@ static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RCU_PROTECTED;
 }
 
-static bool __kfunc_param_match_suffix(const struct btf *btf,
-				       const struct btf_param *arg,
-				       const char *suffix)
-{
-	int suffix_len = strlen(suffix), len;
-	const char *param_name;
-
-	/* In the future, this can be ported to use BTF tagging */
-	param_name = btf_name_by_offset(btf, arg->name_off);
-	if (str_is_empty(param_name))
-		return false;
-	len = strlen(param_name);
-	if (len < suffix_len)
-		return false;
-	param_name += len - suffix_len;
-	return !strncmp(param_name, suffix, suffix_len);
-}
-
 static bool is_kfunc_arg_mem_size(const struct btf *btf,
 				  const struct btf_param *arg,
 				  const struct bpf_reg_state *reg)
@@ -10703,7 +10685,7 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
 	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
 		return false;
 
-	return __kfunc_param_match_suffix(btf, arg, "__sz");
+	return btf_param_match_suffix(btf, arg, "__sz");
 }
 
 static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
@@ -10716,47 +10698,47 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
 		return false;
 
-	return __kfunc_param_match_suffix(btf, arg, "__szk");
+	return btf_param_match_suffix(btf, arg, "__szk");
 }
 
 static bool is_kfunc_arg_optional(const struct btf *btf, const struct btf_param *arg)
 {
-	return __kfunc_param_match_suffix(btf, arg, "__opt");
+	return btf_param_match_suffix(btf, arg, "__opt");
 }
 
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
-	return __kfunc_param_match_suffix(btf, arg, "__k");
+	return btf_param_match_suffix(btf, arg, "__k");
 }
 
 static bool is_kfunc_arg_ignore(const struct btf *btf, const struct btf_param *arg)
 {
-	return __kfunc_param_match_suffix(btf, arg, "__ign");
+	return btf_param_match_suffix(btf, arg, "__ign");
 }
 
 static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
 {
-	return __kfunc_param_match_suffix(btf, arg, "__alloc");
+	return btf_param_match_suffix(btf, arg, "__alloc");
 }
 
 static bool is_kfunc_arg_uninit(const struct btf *btf, const struct btf_param *arg)
 {
-	return __kfunc_param_match_suffix(btf, arg, "__uninit");
+	return btf_param_match_suffix(btf, arg, "__uninit");
 }
 
 static bool is_kfunc_arg_refcounted_kptr(const struct btf *btf, const struct btf_param *arg)
 {
-	return __kfunc_param_match_suffix(btf, arg, "__refcounted_kptr");
+	return btf_param_match_suffix(btf, arg, "__refcounted_kptr");
 }
 
 static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param *arg)
 {
-	return __kfunc_param_match_suffix(btf, arg, "__nullable");
+	return btf_param_match_suffix(btf, arg, "__nullable");
 }
 
 static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param *arg)
 {
-	return __kfunc_param_match_suffix(btf, arg, "__str");
+	return btf_param_match_suffix(btf, arg, "__str");
 }
 
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
-- 
2.34.1


