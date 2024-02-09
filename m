Return-Path: <bpf+bounces-21578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26EF84EEE2
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222B71C21F51
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB01879;
	Fri,  9 Feb 2024 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j04qDAf5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF615C9
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446279; cv=none; b=U+XnM6LHTffuERZY8i0vdeu/xiRhqQoF3P3e/1877678+WvTNRlfG+dgM3qPm3AO4VRNJ0MlkwpO7Jsq8kKlq1V+twiq78sVzYSU1FkRvC/pBrMYMdKi962gBVyFOCne6lax5+RRBbisEMQcNoqqA79FxZ3S4IrPNHJ3e0KGSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446279; c=relaxed/simple;
	bh=OEM1teVXmRXxwhKKimMVilsgKi4wDhaucDE3mY4mQR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JD1CEfQTP/BQAGVsYETQaYks9HjopQJWjQlG3bzexU7dxMb4VOpRiNzdSzEqpy3v5R8f3lXS2ojsOWQV5JjKBPnWNuMRF8pD8207ijHTGvQTrO5DsTYQlFrSN/mqRgJy/eznsZDdLwYaw5AkYew5bx4HtL3ZfPa0qzdDpcUbBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j04qDAf5; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60495209415so6246197b3.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707446276; x=1708051076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2+/0CN+qJ6mOOyTUyPyVR80Te7x3h2sgw+aRJbrBg=;
        b=j04qDAf5Iry4wm1xAvSSqURyaCI4Qb8+5NsYgAfkTuo4oeo9z4N06gzY+PuAKR24ay
         m5vKqGRfEHMwoANHf0QCXkMPFpePY6iXZq69ysZIs8pbAmfmEJDLkMzW4czL33pRceod
         FQrs7OSOy6fcYgA0BDycMemnfPho7zMK0EDVVWbpZeCz1pPIvvpm0o43BPVqhzi6ERH2
         B8vKgs3VMTMvNF2xnErHv6sPFeyPXDYtj/oWD/IXx1Q2qv+H/+FIYYmlSNRFxfm5cCyU
         tQy2uIku9LqQ04FoU+A6aK31pRddEJ+X2HxeCLgyXi2D4ee2BSyxWUg8suavfziMAMG1
         GXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707446276; x=1708051076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY2+/0CN+qJ6mOOyTUyPyVR80Te7x3h2sgw+aRJbrBg=;
        b=GTdbCKqfwbaUqn15XbiKCD2x+aOOsZxjdeZbFPs8UduHtmRvdXlVUhN8o5GTU5SnWq
         2YY6bAdYvDKlx6g+kBUBugQQduFuzkhdeOby7NELQVZOyZ6xKNGnOb9Wt75bmGyi550A
         BKimE7mMyTMbjUaCOkLISk5ifC/p2awxHZBDxePLo0apcri5toiE8Il1fB+W+Y4DK4ur
         WVPJAUiSJEuXTAvEwdbW9dAVQ8NAN4xysKq+9XFFG+fvJ13mzqjZZyH+WGGtPF3l3YpI
         a5gnz7IZgWhh7CFfmwx5L7hEjdKt6MAHPIj/ZmziKjaM2OBy3A/+K5HdLana++89iLsX
         SVuA==
X-Gm-Message-State: AOJu0YxHlVo/OOb2Ep8yIIQTa3XOwrw2zLSbWdQnlpRUQUfjlgLg218S
	0VBRA4ysd+W1ixke9d0rjYXaxqr1/edmYsaaqK1eiKVbOuKqVqMTs7khcWVPGvg=
X-Google-Smtp-Source: AGHT+IH8Hz9z7QwtDDiEwFW6dy7/q3oAytQaTCjEYyAY5Lw9MackGR8UWQyseZLMwqqpD9TGztw5vA==
X-Received: by 2002:a81:bb4e:0:b0:604:a856:3ba5 with SMTP id a14-20020a81bb4e000000b00604a8563ba5mr276299ywl.46.1707446276143;
        Thu, 08 Feb 2024 18:37:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJ1kl1+9otbxtQUeDjrEs/07/6+0vGMwC1kGX0zVylAax1jkjCsf8d0uAHUXLXXC5C3o0a6JfwDP1e+/fMz5/NYr2ghysP88+APVqnU7m6B5WZUkrx1edvXVer4RvJSAHzCBkuoecem1EklmnHwz1LRgnfFPsllCMt5BxlO4Ei9cLsVEU7HOytLrzGG1OIgLiwH7j4Cq3izIwVlEh22WvwSd28GFUT11ZTjA4x3/h5QtPceO7G1M+3Y0B3aTm1J63Vf+vKTnHP93hfBo0qj8qJ1LM/RlZckbAzVbKD5EFUAb0=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id i2-20020a0df802000000b005ff846d1f1dsm144949ywf.134.2024.02.08.18.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:37:55 -0800 (PST)
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
Subject: [PATCH bpf-next v8 2/4] bpf: Move __kfunc_param_match_suffix() to btf.c.
Date: Thu,  8 Feb 2024 18:37:48 -0800
Message-Id: <20240209023750.1153905-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209023750.1153905-1-thinker.li@gmail.com>
References: <20240209023750.1153905-1-thinker.li@gmail.com>
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
index 7c6c9fefdbd6..db53bb76387e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8904,3 +8904,21 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
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
index ddaf09db1175..c92d6af7d975 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10682,24 +10682,6 @@ static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -10710,7 +10692,7 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
 	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
 		return false;
 
-	return __kfunc_param_match_suffix(btf, arg, "__sz");
+	return btf_param_match_suffix(btf, arg, "__sz");
 }
 
 static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
@@ -10723,47 +10705,47 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
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


