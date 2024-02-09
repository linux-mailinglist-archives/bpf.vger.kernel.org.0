Return-Path: <bpf+bounces-21571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C5084EEC7
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906421F26621
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0164EBF;
	Fri,  9 Feb 2024 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG24dqux"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6D4C97
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444061; cv=none; b=hWKNuXKRhzubOsDQmmVFmtjIv+6HTyRd1SX6obzF7Fe/tHbkBf4QqB5nFf61mX/yEtVaNDalpo3cB9EyoffyDuvAUJn/hW58Pq6COGlsOKj2SWTyG4XBNC9D6FflhufnvJmw4QnmB9YwsdnkjUBq79sAlVcrzKglhgNuHwNfA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444061; c=relaxed/simple;
	bh=OEM1teVXmRXxwhKKimMVilsgKi4wDhaucDE3mY4mQR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IF3fsnfe+np7gUiHyVtL0wwmnRjfrJnbnfs0nbElIObEKWthcPF2dgiUuWW4oFqGtNY8fwWEH5Mzk8cxi4HLJnhTDfez/1RdR4q0YKvOInH8Aiy/EetX9M5teaji4+jyi6zWdxEQ2MDX18XOzEw2Xmxup+lokz8QiQzH6Mp7fhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG24dqux; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-604819d544cso5602797b3.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707444058; x=1708048858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2+/0CN+qJ6mOOyTUyPyVR80Te7x3h2sgw+aRJbrBg=;
        b=YG24dquxc5V/o/3av5Ip22wIeNrybWsCHMVFWHyxfeVskeyNYP4637Hq5kqnVNSyzv
         JkRmy8a32cnSDpnbioM1tHTzxlpHR1r1gHDop8xxYEQoZWupyoA6kS9QhG51Fhnv/x2z
         0hlBhfzLVcLi0gXZFl1AwpbfdMVv5i6FqRd5rkbGizxcwKvG4HDP51AS6Az4gcGZYqCn
         CulWW411Z4qxyRhDMoRhxl+tr3zyJxJy9ImtWOgJGOGHI0W+P5QlsuXhB2ylGOLEyhUf
         urne3d7Z+riiDogTtbdp4FoGsU1DcKtoAlVK3+6T1z+UEAyc6V8hVA7RmZRwhYzSBrfx
         3QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707444058; x=1708048858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY2+/0CN+qJ6mOOyTUyPyVR80Te7x3h2sgw+aRJbrBg=;
        b=HkLazTC2b7uChw0HNufsJFQSX7KmP8/zpb5+l3BT7GRwD+B0dmcIBRoGZaGlES0UiP
         soycgAWSKEDXgLWlBtIvRABVLX/szTnFAK1VPYUcu7JLeH0j0j3V5orR/30MOT03Bxmb
         4rzp1kuJK3DDv7K+eQLdMJrhyso5Ch689hKKqgnSS8O1iGpRD+zCLK6HzwGgJ4eZdOGO
         tqAUxEsM6ksvph1gtrJkokhpl4iHoz40HSQON0s5ZEExFMcXEgu2djS4N4MPOmQ3R+u6
         jKnO0MaRy6+d66tpx7nEuBMflQa7L9t2NsNiW/RvubCVWjRIykZLw+IJv6v4z/T0oQNB
         qcaA==
X-Gm-Message-State: AOJu0Yz0dTKJSqXCI335MNEEsbV0n2+/ta5zGldEctX2vst1JP3mFFsy
	MSIdpJv9rIjuWx/yTbjYvzDcfxv9LkNTyegnsG0I8LbSYCB3l9BYUBUfebTls+8=
X-Google-Smtp-Source: AGHT+IEu9OnTwWPsEwS23ix1xjm82Opf00CvsI0Huyz8SNwPQpBopcQZDRjz0l5AXP9osB8i8iDXiw==
X-Received: by 2002:a0d:e503:0:b0:604:44f2:6959 with SMTP id o3-20020a0de503000000b0060444f26959mr166646ywe.37.1707444058376;
        Thu, 08 Feb 2024 18:00:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzLEpsjpe1SjjGko9Utt1WGpz1bA2vFXg46Nactg/4+mWtzTPqtIpdLRs8V/lCl4NoV+PT3WUHCEIkf3ELno2aVAtArO2S9jCIkhHxBqNJh1d7Saz21pkYz1A+4O7OTsPjEomtThLfs037CtK6/TfQcb2V/UBeqRD66WrDDJfLYsUGXtugY1eRUVn2akEbTud9WJlRxOBWp2Z5Ow4Id21XRPSRYMNjx1Fo21jiotYkDZxAM7SLJ/F86ZqePa3h7HO109QWfLJ9D7TNy+jCR5QF/is9N8HXpBAZLxemCBND3mk=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id h123-20020a0dc581000000b006041f5a308esm134982ywd.133.2024.02.08.18.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:00:58 -0800 (PST)
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
Subject: [PATCH bpf-next v7 2/4] bpf: Move __kfunc_param_match_suffix() to btf.c.
Date: Thu,  8 Feb 2024 18:00:51 -0800
Message-Id: <20240209020053.1132710-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209020053.1132710-1-thinker.li@gmail.com>
References: <20240209020053.1132710-1-thinker.li@gmail.com>
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


