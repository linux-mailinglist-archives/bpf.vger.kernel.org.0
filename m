Return-Path: <bpf+bounces-59099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09915AC605C
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D674E188935E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65BC218AB0;
	Wed, 28 May 2025 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPjcONJ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6321EF0A6;
	Wed, 28 May 2025 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404200; cv=none; b=GJQ4/yuVT/bu9EQOxao/DFo3dNKBFdHWCni1bJ9Tb0yLnP3LIK2nG4Km9JazQddfxW2AlojUIcbxneH14yIsN++C/KMcq2Lxod0FVcRW7J3CH6xW3Wzx6ktKZfA7KMZAYV/ZPOxZV5ExNuRXkx+SgyT8QnBMaAZiFMpUKpUGlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404200; c=relaxed/simple;
	bh=6PlYWOy3amN0lotfPfL/VKwZ5CAcJfl9znOLLpFy40k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0oHVzE6k8NuC/dDDKjrT99DdknkTXz6ofP7ydhQ/aD/2u79X4IARXMYoWYj6a7PLidv9LYYsGlNsc1ob0Yda0OoQZODQhGiw7oOHxQEAewzuVGhSTOMUBhysqxb77s700NCQkQ7k0Sb5RvXtuALLjpxdm2tK0xQk4BK+xxSetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPjcONJ4; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-742c9563fafso2876534b3a.0;
        Tue, 27 May 2025 20:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404198; x=1749008998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBEP94FNiEfzTaba1ZYVkx6Mjhh8FN4Fehm643kC5no=;
        b=cPjcONJ4uRUbhQtl9IK0c+kCa25QEPCAl3ErQCbXoRsZMxvu1t9vIwZyHPUyjB88w/
         CmP0BAjABk29sF3YuUc8hkclRElNO748Z7+KiCRbE8BNNS5SCYyMjnZB/4a11llaegK+
         zVENj7IzPdha/PPNzTWjkNSircJZW1va4j5VFx6FMTT8yzeZM87fpTkHXiLJmDSnDt0R
         dn85k1KoNl/YHy1y3qlcIwUp+q/U4pXDJKJg+TzcXRLMQiBAdfRap0nXTm5xKjr4UcXw
         E0+XXQK9ohnm93n3nqzEbqfj2q9RKs8XnRODikFPzrnxY5EIj711lf2o7A5tFtATGT0D
         C/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404198; x=1749008998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBEP94FNiEfzTaba1ZYVkx6Mjhh8FN4Fehm643kC5no=;
        b=ctAR1HdjhqWMOhoWnRrCTqeawSKl5QwD78Bq3Tzs/aBZhmSwZDIiFvfPXwYf1d94Pe
         S0IIPFzQ48nA/YbVdNQagltWj3awUeiXiblrTpueknB/5Pdj8vGN9bWSayMxei+2spWF
         kxdmeiReZVF+9BsZMNm83q/yLy6Objznoa0rcvLETQC1Lx6WpEfMHOM2S/2KlinXJwiv
         +RsVDgfLdnrxzAzl8yoGN+hYejqTPSJrBnEds4tUMCoAbILgSAbw5hnwfyaAV9cuH4ts
         G+a04dmRkT9TMZKMb1g154czL8PPRnMmnvIkjcO/GwLkJ2S6w92KRKfwY/aM/NbZVud3
         67pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJdPwRvcqA3qj9Def4vfQxHMufxvWn3Mwwx5GvX/9R8u0RJkd2xzz3DiSSaHy5NoGq9oo+C83hhpQRey4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlusfdYpGSZdaEKi4qNYRX+fQTyB1UVKxbnGYWlECjNl+sSydm
	Yd5kSW5h32MKJU94De4I01DQxOvg+hYvtADTfVVgkNA388kG1cY9dWMC
X-Gm-Gg: ASbGncvmIhdOrXuXgpQJYE8dHSZS0mJRSZEQQN1ZK5ivE0ezMl6xOTvHPod2dDeO1f2
	Nupxad0vzh92lNhkmZ0U3s14fT2hsZQJmISLHga0u8Ez3rXKIY8FUUgiMmUYbOz9Tj+rRj4uMUc
	NLqFnCSQhksNWsMzoM2fc7ZjS2/mcQm2Z7iSh6IAEyZtr26ad0f7bIIaNw5ty9OTu17qIThK3AL
	DkhFUxJQpDm6A/hxjOwk15d0UvChXDbp8DVpjnVPd1UVprzTdTDV56rnvmhMczU9fd8w9YQZV44
	AF4k6jkQIdYcCk0+/Vy1rW++cDtophI8i8mJzADEwTG9GIpdllnuNE5vnjFczR2VFzJY
X-Google-Smtp-Source: AGHT+IEeiWx5NKO1Aq4jkogMNl0g4N1L39Hs4Nq2xJgLb9lD2vlJsx2wdh2oOQ8VcI8whFVdzgpnYA==
X-Received: by 2002:a17:903:2f8a:b0:234:a139:1206 with SMTP id d9443c01a7336-234d2c2e18amr10836605ad.40.1748404198179;
        Tue, 27 May 2025 20:49:58 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:57 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 10/25] bpf: refactor the modules_array to ptr_array
Date: Wed, 28 May 2025 11:46:57 +0800
Message-Id: <20250528034712.138701-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the struct modules_array to more general struct ptr_array, which
is used to store the pointers.

Meanwhile, introduce the bpf_try_add_ptr(), which checks the existing of
the ptr before adding it to the array.

Seems it should be moved to another files in "lib", and I'm not sure where
to add it now, and let's move it to kernel/bpf/syscall.c for now.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h      | 10 +++++++++
 kernel/bpf/syscall.c     | 36 ++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 48 ++++++----------------------------------
 3 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index abf504e95ff2..c35da9d91125 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -315,6 +315,16 @@ struct bpf_map {
 	s64 __percpu *elem_count;
 };
 
+struct ptr_array {
+	void **ptrs;
+	int cnt;
+	int cap;
+};
+
+int bpf_add_ptr(struct ptr_array *arr, void *ptr);
+bool bpf_has_ptr(struct ptr_array *arr, struct module *mod);
+int bpf_try_add_ptr(struct ptr_array *arr, void *ptr);
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4b5f29168618..e22a23aa03d1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -619,6 +619,42 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 	return ret;
 }
 
+int bpf_add_ptr(struct ptr_array *arr, void *ptr)
+{
+	void **ptrs;
+
+	if (arr->cnt == arr->cap) {
+		arr->cap = max(16, arr->cap * 3 / 2);
+		ptrs = krealloc_array(arr->ptrs, arr->cap, sizeof(*ptrs), GFP_KERNEL);
+		if (!ptrs)
+			return -ENOMEM;
+		arr->ptrs = ptrs;
+	}
+
+	arr->ptrs[arr->cnt] = ptr;
+	arr->cnt++;
+	return 0;
+}
+
+bool bpf_has_ptr(struct ptr_array *arr, struct module *mod)
+{
+	int i;
+
+	for (i = arr->cnt - 1; i >= 0; i--) {
+		if (arr->ptrs[i] == mod)
+			return true;
+	}
+	return false;
+}
+
+int bpf_try_add_ptr(struct ptr_array *arr, void *ptr)
+{
+	if (bpf_has_ptr(arr, ptr))
+		return -EEXIST;
+	if (bpf_add_ptr(arr, ptr))
+		return -ENOMEM;
+	return 0;
+}
 
 static int btf_field_cmp(const void *a, const void *b)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 132c8be6f635..8f134f291b81 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2779,43 +2779,9 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
 	}
 }
 
-struct modules_array {
-	struct module **mods;
-	int mods_cnt;
-	int mods_cap;
-};
-
-static int add_module(struct modules_array *arr, struct module *mod)
-{
-	struct module **mods;
-
-	if (arr->mods_cnt == arr->mods_cap) {
-		arr->mods_cap = max(16, arr->mods_cap * 3 / 2);
-		mods = krealloc_array(arr->mods, arr->mods_cap, sizeof(*mods), GFP_KERNEL);
-		if (!mods)
-			return -ENOMEM;
-		arr->mods = mods;
-	}
-
-	arr->mods[arr->mods_cnt] = mod;
-	arr->mods_cnt++;
-	return 0;
-}
-
-static bool has_module(struct modules_array *arr, struct module *mod)
-{
-	int i;
-
-	for (i = arr->mods_cnt - 1; i >= 0; i--) {
-		if (arr->mods[i] == mod)
-			return true;
-	}
-	return false;
-}
-
 static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
 {
-	struct modules_array arr = {};
+	struct ptr_array arr = {};
 	u32 i, err = 0;
 
 	for (i = 0; i < addrs_cnt; i++) {
@@ -2825,7 +2791,7 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 		scoped_guard(rcu) {
 			mod = __module_address(addrs[i]);
 			/* Either no module or it's already stored  */
-			if (!mod || has_module(&arr, mod)) {
+			if (!mod || bpf_has_ptr(&arr, mod)) {
 				skip_add = true;
 				break; /* scoped_guard */
 			}
@@ -2836,7 +2802,7 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 			continue;
 		if (err)
 			break;
-		err = add_module(&arr, mod);
+		err = bpf_add_ptr(&arr, mod);
 		if (err) {
 			module_put(mod);
 			break;
@@ -2845,14 +2811,14 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 
 	/* We return either err < 0 in case of error, ... */
 	if (err) {
-		kprobe_multi_put_modules(arr.mods, arr.mods_cnt);
-		kfree(arr.mods);
+		kprobe_multi_put_modules((struct module **)arr.ptrs, arr.cnt);
+		kfree(arr.ptrs);
 		return err;
 	}
 
 	/* or number of modules found if everything is ok. */
-	*mods = arr.mods;
-	return arr.mods_cnt;
+	*mods = (struct module **)arr.ptrs;
+	return arr.cnt;
 }
 
 static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
-- 
2.39.5


