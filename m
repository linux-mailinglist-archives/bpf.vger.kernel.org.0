Return-Path: <bpf+bounces-76988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E5CCBF11
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 14:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04BC30AB7FD
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B029335092;
	Thu, 18 Dec 2025 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joh7WqP5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A227145F
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063243; cv=none; b=HyQnDDXEtywIjo4mOdJwhnP1m6z3CbaGsH09MiOGrvfruUiBJ6D8ahxrMsZMRlG6vYHs+6ycCxViKJme9LyCdD6C+wS6v4LTQvwiMWYHcIW021c414WsuPp1lDzAD6oneugWF+nceCAUKj5gdokIMojpFfm78jqcQOBNLnSyveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063243; c=relaxed/simple;
	bh=zbKUAm5oIbrYUr4Pq0Qw8fCPvshez5LuSrD/UJz2biw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjXLl11th0p80CpN5G2PJCc9ipi4Y1oZvHiiYw0BwEtB0TmH4Rq4pg8eSiiHWjquyQTpB/w4HNelItEOFa2sbIHnNVL7w/+WVilIscnkwd11wxlhk9rQetbif0pTLI23xrtHafI5zwoaf7mC1XXHdT9nUTQZM35S0rGAGRGQ/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joh7WqP5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a102494058so8848495ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 05:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766063241; x=1766668041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfWGrzFwQxVXKLSf8bK35Njw60Z0UXLSaG1EWbBTvoM=;
        b=joh7WqP5+e0bTINEg1VVmEsk5qcgnr/knqedVyFaR1w8zUYQkGUOcSWEiToU0S+F9Q
         Cn0UXcvFiZYfBR4q0PX5kqURxbWjLTxZtRX+eupKzm+BnP5no0+o1lFhhF/lQ8at2BQ3
         Ap98lWv0QSYAKSvLi8VXIKN3obLOlQrIOUg629vBgt54Sq8B8uusGtfGeuUrmYqkfMcM
         2BM7Jt4mQcx8S0A7UQVIFhn/vbnLcTR16ff5/EaoTdOViNjNW1zC/vdmPktiwaMJXbFw
         nARbCmklIBasTWFaxXVTK5o/0Qckp8NGkbsRyZGn/mhcbrqEynh81AabOMq0vU47QEn9
         L0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063241; x=1766668041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xfWGrzFwQxVXKLSf8bK35Njw60Z0UXLSaG1EWbBTvoM=;
        b=lZKxzwvaPZaOJa4JlozN9+Cc1t/Iv1byvmMKnxv5TsdDxaM9irftCc/Z1KkHPPdjn3
         UkmkWDVAv9sObKw5rOfObiKcI38LCGDJHs2kDHnQ/87k75YDuNoIimMDPBSUT7pCUeCD
         KixTaDzcoPNsLVkRaEBME4G3r6PN3AeUBXAEMfdWfS/lVOrK5fYE5LKbZPt2X7TEP7HB
         TNtyX4fDMRMIO28oB5oW6Z7mrjT4ZRFjPyYdzqgjMb73dQ2CJxMrV3YFGqn4MUMh9hQb
         AKVyzsGo33Irz8fWllgYmeczVyu/1CqB+25HzYMYG6KQEW4HfJG6r3UsbG6xoXKm6IC6
         ajbA==
X-Gm-Message-State: AOJu0Yysr+qk4LxASpSSz4Ajval3ejuKCd7wsLIOCvkCxOFst8/fJOn7
	8ICWAyGOkUs4Xgq4lWobAROOZ/j9daUnVUX8suiGjB57Cc3UOsIgvFBb
X-Gm-Gg: AY/fxX7H5Ioc/sCwv6B2jN/n4/+7jyoRt+CS9709jRqM5RZnyGneHycr5QcMsJ6rFe2
	tp3nmIDj1zsHktTt2nvywEAWuy4itynCbGbx9bTzHgqSE9mlrvYPewcs+Kh7ry6z2jfw5Lbk4Yc
	awvWZk6UD5LZaRM5gS8UxJLkMFP+bEavXGczCU02hDhLYAd5HAwVC9l5Ez/dGq2ckT1UJm7vXZH
	EDTtsh7RbjkRbMAxySFZVSdsZ14HQ7x6NmEGywn0umOuuiZKJRZzcYvovaU1Ean8rUQPMeivxl0
	iydk4Iw7rBL7xk4N7u4zuUebsMSlr/ioqlBnJzD4sRzI5GS/xz3byukjui4eOBw068jslwKohA2
	nA9GXgjgojdMfv2mu4ZuiOC9zm2kk0e/5DBu96kTdW/S7f+TR+jI7b8JFpth3fWaOnG+KWyu7rC
	6BO1YLLZDuDG3IKbGyYVjb8zCw7NkJss/LWtk=
X-Google-Smtp-Source: AGHT+IE2dPr6IKueNkbs60vHXI/kEmriix+hjdpYj9PL6qm8QcZvc/lPn2FJdvkRkQDLRAi3HNJglg==
X-Received: by 2002:a17:903:2452:b0:2a0:acb8:9e80 with SMTP id d9443c01a7336-2a2cac7e29cmr28263405ad.29.1766063241197;
        Thu, 18 Dec 2025 05:07:21 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926cd2sm25539905ad.77.2025.12.18.05.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:07:20 -0800 (PST)
From: liujing40 <liujing.root@gmail.com>
X-Google-Original-From: liujing40 <liujing40@xiaomi.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mhiramat@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liujing40@xiaomi.com
Subject: [PATCH 1/2] bpf: Prepare for kprobe multi link fallback patch
Date: Thu, 18 Dec 2025 21:06:28 +0800
Message-Id: <20251218130629.365398-2-liujing40@xiaomi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218130629.365398-1-liujing40@xiaomi.com>
References: <20251218130629.365398-1-liujing40@xiaomi.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This moves some functions and structs around to make the following patch
easier to read.

Signed-off-by: Jing Liu <liujing40@xiaomi.com>
---
 kernel/trace/bpf_trace.c | 304 +++++++++++++++++++--------------------
 1 file changed, 152 insertions(+), 152 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fe28d86f7c35..1fd07c10378f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2291,67 +2291,6 @@ struct bpf_kprobe_multi_run_ctx {
 	unsigned long entry_ip;
 };
 
-struct user_syms {
-	const char **syms;
-	char *buf;
-};
-
-#ifndef CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS
-static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
-#define bpf_kprobe_multi_pt_regs_ptr()	this_cpu_ptr(&bpf_kprobe_multi_pt_regs)
-#else
-#define bpf_kprobe_multi_pt_regs_ptr()	(NULL)
-#endif
-
-static unsigned long ftrace_get_entry_ip(unsigned long fentry_ip)
-{
-	unsigned long ip = ftrace_get_symaddr(fentry_ip);
-
-	return ip ? : fentry_ip;
-}
-
-static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
-{
-	unsigned long __user usymbol;
-	const char **syms = NULL;
-	char *buf = NULL, *p;
-	int err = -ENOMEM;
-	unsigned int i;
-
-	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
-	if (!syms)
-		goto error;
-
-	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
-	if (!buf)
-		goto error;
-
-	for (p = buf, i = 0; i < cnt; i++) {
-		if (__get_user(usymbol, usyms + i)) {
-			err = -EFAULT;
-			goto error;
-		}
-		err = strncpy_from_user(p, (const char __user *) usymbol, KSYM_NAME_LEN);
-		if (err == KSYM_NAME_LEN)
-			err = -E2BIG;
-		if (err < 0)
-			goto error;
-		syms[i] = p;
-		p += err + 1;
-	}
-
-	us->syms = syms;
-	us->buf = buf;
-	return 0;
-
-error:
-	if (err) {
-		kvfree(syms);
-		kvfree(buf);
-	}
-	return err;
-}
-
 static void kprobe_multi_put_modules(struct module **mods, u32 cnt)
 {
 	u32 i;
@@ -2360,12 +2299,6 @@ static void kprobe_multi_put_modules(struct module **mods, u32 cnt)
 		module_put(mods[i]);
 }
 
-static void free_user_syms(struct user_syms *us)
-{
-	kvfree(us->syms);
-	kvfree(us->buf);
-}
-
 static void bpf_kprobe_multi_link_release(struct bpf_link *link)
 {
 	struct bpf_kprobe_multi_link *kmulti_link;
@@ -2469,6 +2402,152 @@ static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 #endif
 };
 
+static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
+{
+	struct bpf_kprobe_multi_run_ctx *run_ctx;
+
+	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
+	return run_ctx->entry_ip;
+}
+
+struct modules_array {
+	struct module **mods;
+	int mods_cnt;
+	int mods_cap;
+};
+
+static int add_module(struct modules_array *arr, struct module *mod)
+{
+	struct module **mods;
+
+	if (arr->mods_cnt == arr->mods_cap) {
+		arr->mods_cap = max(16, arr->mods_cap * 3 / 2);
+		mods = krealloc_array(arr->mods, arr->mods_cap, sizeof(*mods), GFP_KERNEL);
+		if (!mods)
+			return -ENOMEM;
+		arr->mods = mods;
+	}
+
+	arr->mods[arr->mods_cnt] = mod;
+	arr->mods_cnt++;
+	return 0;
+}
+
+static bool has_module(struct modules_array *arr, struct module *mod)
+{
+	int i;
+
+	for (i = arr->mods_cnt - 1; i >= 0; i--) {
+		if (arr->mods[i] == mod)
+			return true;
+	}
+	return false;
+}
+
+static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
+{
+	struct modules_array arr = {};
+	u32 i, err = 0;
+
+	for (i = 0; i < addrs_cnt; i++) {
+		bool skip_add = false;
+		struct module *mod;
+
+		scoped_guard(rcu) {
+			mod = __module_address(addrs[i]);
+			/* Either no module or it's already stored  */
+			if (!mod || has_module(&arr, mod)) {
+				skip_add = true;
+				break; /* scoped_guard */
+			}
+			if (!try_module_get(mod))
+				err = -EINVAL;
+		}
+		if (skip_add)
+			continue;
+		if (err)
+			break;
+		err = add_module(&arr, mod);
+		if (err) {
+			module_put(mod);
+			break;
+		}
+	}
+
+	/* We return either err < 0 in case of error, ... */
+	if (err) {
+		kprobe_multi_put_modules(arr.mods, arr.mods_cnt);
+		kfree(arr.mods);
+		return err;
+	}
+
+	/* or number of modules found if everything is ok. */
+	*mods = arr.mods;
+	return arr.mods_cnt;
+}
+
+struct user_syms {
+	const char **syms;
+	char *buf;
+};
+
+#ifndef CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS
+static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
+#define bpf_kprobe_multi_pt_regs_ptr()	this_cpu_ptr(&bpf_kprobe_multi_pt_regs)
+#else
+#define bpf_kprobe_multi_pt_regs_ptr()	(NULL)
+#endif
+
+static unsigned long ftrace_get_entry_ip(unsigned long fentry_ip)
+{
+	unsigned long ip = ftrace_get_symaddr(fentry_ip);
+
+	return ip ? : fentry_ip;
+}
+
+static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
+{
+	unsigned long __user usymbol;
+	const char **syms = NULL;
+	char *buf = NULL, *p;
+	int err = -ENOMEM;
+	unsigned int i;
+
+	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
+	if (!syms)
+		goto error;
+
+	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
+	if (!buf)
+		goto error;
+
+	for (p = buf, i = 0; i < cnt; i++) {
+		if (__get_user(usymbol, usyms + i)) {
+			err = -EFAULT;
+			goto error;
+		}
+		err = strncpy_from_user(p, (const char __user *) usymbol, KSYM_NAME_LEN);
+		if (err == KSYM_NAME_LEN)
+			err = -E2BIG;
+		if (err < 0)
+			goto error;
+		syms[i] = p;
+		p += err + 1;
+	}
+
+	us->syms = syms;
+	us->buf = buf;
+	return 0;
+
+error:
+	if (err) {
+		kvfree(syms);
+		kvfree(buf);
+	}
+	return err;
+}
+
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
 {
 	const struct bpf_kprobe_multi_link *link = priv;
@@ -2520,15 +2599,6 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
 	return *cookie;
 }
 
-static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
-{
-	struct bpf_kprobe_multi_run_ctx *run_ctx;
-
-	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx,
-			       session_ctx.run_ctx);
-	return run_ctx->entry_ip;
-}
-
 static __always_inline int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 			   unsigned long entry_ip, struct ftrace_regs *fregs,
@@ -2597,6 +2667,12 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 				   fregs, true, data);
 }
 
+static void free_user_syms(struct user_syms *us)
+{
+	kvfree(us->syms);
+	kvfree(us->buf);
+}
+
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
 {
 	const char **str_a = (const char **) a;
@@ -2627,82 +2703,6 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
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
-static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
-{
-	struct modules_array arr = {};
-	u32 i, err = 0;
-
-	for (i = 0; i < addrs_cnt; i++) {
-		bool skip_add = false;
-		struct module *mod;
-
-		scoped_guard(rcu) {
-			mod = __module_address(addrs[i]);
-			/* Either no module or it's already stored  */
-			if (!mod || has_module(&arr, mod)) {
-				skip_add = true;
-				break; /* scoped_guard */
-			}
-			if (!try_module_get(mod))
-				err = -EINVAL;
-		}
-		if (skip_add)
-			continue;
-		if (err)
-			break;
-		err = add_module(&arr, mod);
-		if (err) {
-			module_put(mod);
-			break;
-		}
-	}
-
-	/* We return either err < 0 in case of error, ... */
-	if (err) {
-		kprobe_multi_put_modules(arr.mods, arr.mods_cnt);
-		kfree(arr.mods);
-		return err;
-	}
-
-	/* or number of modules found if everything is ok. */
-	*mods = arr.mods;
-	return arr.mods_cnt;
-}
-
 static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
 {
 	u32 i;
-- 
2.25.1


