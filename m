Return-Path: <bpf+bounces-62262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B4CAF73B6
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF227B43F7
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB972EA483;
	Thu,  3 Jul 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z85v4I1/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5E2EA461;
	Thu,  3 Jul 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545059; cv=none; b=r5R+PZM6o5t/4Ew8J1pRih9Vor19pfFOJCEK0G8qXKTijayoRTGkaeJruqf8okdhOiyp9deJzcfTKWWVpn7OtdQsiL/AY13k/N+YxDMfYhs+xPMY0Tsj+gwMGxccuhvDgQt2GybqzSCMy7ZwLNdLdJdO0ZpIzM87MVX0him9Uc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545059; c=relaxed/simple;
	bh=riTJJ7GS+XGjt+PMc7tEQ67eI533L9DAfcyCSOU104A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kChSRy8PMgDTGAI+wi4GDRn3s9G6TJBrBaVN9bCGjBHIXHGA3SJs0amXAB/wkNqOPRearrTDmKElUaJPoa+cAUhIgIu7eNH7+DXy3UNkKFGLHcKpHORIJU7MYdcTRmjeFqqae3bFQXetCb/iqjGPSNDr3E2GqZvOF4oLZKBD6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z85v4I1/; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-748e63d4b05so3582088b3a.2;
        Thu, 03 Jul 2025 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545055; x=1752149855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enw74RGNYkSSq6fVi/NS1y3MQoKg1WZClxqzEbAxtug=;
        b=Z85v4I1/w8DwRtqKRCq/SVq3VZUCV1HfgAUUzwjX9g3Q5ivayVAUHeAuBr1s1lfnje
         9secgvsI7Aqlcf3R3t4vny+ucEDBi7G9DTlMFS+tCYl9fFW0tMrOTZzXubIyossP2uGO
         Lt7Bz4WNp7p82/KuzNmeaaKk4D160ZECuHSCCPDXUgtvaD5Zje/fr6pd2F1MMTkOiIhn
         CiKKrI2zhKvYfIWIl9Nzx+8cMiV2z84fYAuIWCSLSgRfcwXVGyHimzeoyk2iNjB6Bpbo
         NtJmvrmXJaTQDStyF5tO8dPyz6GTprlrf0i1Dru1neIKDL+kn+t/y1e4pIPiGWtZbFiH
         4/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545055; x=1752149855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enw74RGNYkSSq6fVi/NS1y3MQoKg1WZClxqzEbAxtug=;
        b=l0X7m1Xx0xQOQ5mD5QZHGsRKhkej1DbisOwDn45znoS7awmiXIyID59rwr8uAWG4Gi
         I0JkWSIkpc46xTRuPbxoYnRnbbAV6BQxbgHsjBfYXCCmZAaHXNvLUd41XTmbEwTLTlj1
         s/eZw8tCdsZB0mYwfaw2nPSS1snXmiuUMWyLzXdND7m1xdhYHmGtEu3sBkC4XOycYJ8I
         v2Q6IwQNCBz+xs2oKnEgLFbf1w0jX5GV6wH0mZ8p5x5DFSG72A5obJijmtvs8alsKDuM
         SKWwazmfPTAkD6slNTuOVdXOVlKSARM0WnFr1jCtllwHjeuEwMBgh7+V7bGAA3jL+HbK
         bwGg==
X-Forwarded-Encrypted: i=1; AJvYcCVgphAvcpA0mvLfKRQyBvHyrranbbt/KPlYqbm/XrbeywgCN6jWV3o/dDpMWplAgtBf5svguxuC26ITAVQ+SKG3bKwh@vger.kernel.org, AJvYcCVsexMJQLBlyr3VpRa/2Sgvj1aYZ4ckQd9NTUj0tCRnvFRS56tpw+OkmqprTv3VF9uc2zMmVl4We2bs4iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7DkFgbID5CXHCFkFoSY6bhvMzsqor7CcpiywRELavYtlJPqg
	NmDnJQagXDVjdOpTiErUZEdKMOSsGcwb9BKNeRW9idaSWrdwPx/Na6Oq
X-Gm-Gg: ASbGncvIT0CWdgEelG199XQ9VsDdJGehaHdoK0u4eOKEqm9xN8yFqxkQnzp8uNgIrsH
	ZH/8WM+gR26DbhPwbZmK6QmTxHrxQkFlv4q869b9a9eF5XPcZXv2Xaj+XR3t6x74K7FM08ET287
	+qkX9/N4T6/3unT3VWuZvKh5Mx1MmZ3SSdK0/6MPbuZHFNT266ff0vGZPsnPwasgVe/MTvr4k37
	/SaNbo/naiF1/wVXwAojm9HQG1/YIct0lufuy4T+6aAK7dglgQTDBFrmTkML997jJMGrmHiX3GA
	L51E7qYrVJTARav7X+6Iu4pgQkq6mm1EpGEHK9iBlyTc1G8ZG/NgSHS504A3/WmEWbZPeQLKXnJ
	tTzM=
X-Google-Smtp-Source: AGHT+IEQJQLFrBGT5NBzSNn4/3BL0aVjMHD3jm10eW3DLG/DVSGDgTEu21IAQFv99xrfkFg6/s85ow==
X-Received: by 2002:a05:6a00:174b:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-74b5138c735mr7925298b3a.19.1751545054876;
        Thu, 03 Jul 2025 05:17:34 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:34 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 07/18] bpf: refactor the modules_array to ptr_array
Date: Thu,  3 Jul 2025 20:15:10 +0800
Message-Id: <20250703121521.1874196-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
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
index 5e6d83750d39..bb3ab1aa3a9d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -314,6 +314,16 @@ struct bpf_map {
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
index 56500381c28a..8ce061b079ec 100644
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
index 0a06ea6638fe..167fd1dcc28b 100644
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


