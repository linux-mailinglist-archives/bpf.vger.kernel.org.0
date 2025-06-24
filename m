Return-Path: <bpf+bounces-61338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187D5AE5A60
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06106442131
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BF1CAA96;
	Tue, 24 Jun 2025 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew7c9z3P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973D192D87
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734778; cv=none; b=Uw201NdQqX9f1GupWN0876QjOH8Q65gmlAjTBY3y64/5GOEYWBFpiF/ZDRiaH3J99QwLbDTP7uY59JjsOmroX58DSofhigJDp+RFOAnA/xniBYpohgK3kAFE1EjHwT7tv3EO/PjCqJ7wlAhMLroAFtXeaLcdbjZwq7fcymtzVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734778; c=relaxed/simple;
	bh=t2BRcr2+6gJr3KgAcNgxMy3UcbJhiQrwP9oBAKjG6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mpr1Vdaj6P5LCwblG6109i+hIftgJSmc1JESmpGSdk4HFz6qIsU/uRtASpH7QE0xj5zufQLbuFEE9zJ32NzfxnO1xkaBKsjguWZxHpCS/Fkgn0b1JzcVn/QtM26daTSWKMvrokggaHfJJg47+YvCoBu2lbUCLMg9n2lBqU7JJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew7c9z3P; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so7338378a12.1
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734775; x=1751339575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/hTuWeeMXLcMNlg+KK9mgTVa/gu4Le9bSuoKeSo/Ak=;
        b=Ew7c9z3P8NpYHU3iQldNHNSRYuHjnwQwD4ArzXc6xa+Zp2KlyIXX/N1Jwlh3Be4Ol3
         CpTUTb5w6zoii/jhB3vjNn402/x4j+vH/UVQKgrF4fhfamtxoQWkjz2I1ZEqB7Ytt6AI
         6pAWzUm8JOWwbdmzRcQvcn/hH5W517HouoY5a4lIG6Ho+Qg3H73qVfLMEhTQTjTqghQE
         jikNTsQRWp37EM8H6KvwndBk+MGvLdfBVxMwiwt1j3Yzax6NBSScRikTlftGBJNUoWZx
         wep72/7EmXyvkuH3+LOT973UFhev1g9UXzrFyoEFWz5vIZQgvv5A4Q8b7R9a25rQSMlA
         9D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734775; x=1751339575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/hTuWeeMXLcMNlg+KK9mgTVa/gu4Le9bSuoKeSo/Ak=;
        b=grKYPraFRougp59VZfB7Xiea0/AC5+N024Wh8GtTvxjaStqA/s07ieNX3LHZhhhF9k
         2bPTrQP8svUcw0B551SUfmQetsooOYElXlQDrcSfoYzZBKEcttajAaJBWwPJ4SR4tC6s
         TRGP+fnEbIm4Vf1JoU0pKmahLY9g8kf1YR2/II/l/g/kYhaq+pstzBTXnGBQoooFhAhP
         0Nti1AOITeDhTH7hluVZYUvNVbshilOVFky7oBlc8/kkPJOh2DwdqV5aUBYBEONhWQqL
         7uEBVrPi4Vs5WYmjEfc/hWW79HQvA2E6nQFOF6jPMe+AvRyN+DaH0OmY7T5i76VC1Cbd
         6ULg==
X-Gm-Message-State: AOJu0Yzfzu+yXS9woT9dRO6SRfpV8I/V587eiFQ2JfMvBg382VosKSPR
	F8k8eS6slXkOelU38eiJAn0KDMPUhgFFoMAsA57ib/Yisslb8qGhoRx7A1scSP1TgI3Z4w==
X-Gm-Gg: ASbGncuYrnMOO/zVCehQcJ9+C48caytqoJrYjQrviN7gAk1Kq2GL+4aLZXEi+QhdgFb
	zqz+A7O1F0MdztkfsqCJSZGiLSL9hVLxahVlU6NAnoDRhdicmCivDh3dUvC4tJfA6k+SWlSdF+o
	mi8cZjdioOCzaNQOIy9+BeRtMuUAIt5Ji3ko3NlQAUS66ADsMa33wFRo6LPqYOcdusd9EPH5Dw2
	8r03N5VM7UmUSVs89ipvNLJbDtPavEe15+fiZYEwqhU/Efd7ddS8wAT4r1oyAsQKg/WqY4JODaI
	zq9GZ9gywmf680NaH1AlXT5PZ4UNL5wdnshLkywtavrd4wzSq84=
X-Google-Smtp-Source: AGHT+IFJVhrCIGjyPV0nn8HwscwWYl2gvyCpGkUdjX9TscjB3PVqmZnYNzrmEk5D8sdL9FmcNH8sNg==
X-Received: by 2002:a05:6402:5241:b0:607:77ed:19da with SMTP id 4fb4d7f45d1cf-60a1cd1a899mr12442922a12.1.1750734774963;
        Mon, 23 Jun 2025 20:12:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4a61b8sm346393a12.75.2025.06.23.20.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:12:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/12] bpf: Refactor bprintf buffer support
Date: Mon, 23 Jun 2025 20:12:41 -0700
Message-ID: <20250624031252.2966759-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4083; h=from:subject; bh=t2BRcr2+6gJr3KgAcNgxMy3UcbJhiQrwP9oBAKjG6WA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWdXAGZufG0sXf1qzhje+9cXBSx0KqK77OawF/6 x2mr+K2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVnQAKCRBM4MiGSL8Ryu+LD/ 9phmxyP0zhTda9S5hOAx9H7rozgMUZBfivYG9ARjEuAseUMg38kPexRdWoeg3WpE/x/Rhwl3+oqGXp o08C7WwleUqcOkcjQYh98P0zXcsOfP9ebnm/VoXGXc75bDQBvCLMe7IfgjU2AWAo2wXmwgOjz+Gqtb OXff/JYzgYRBkRBdSGl/diwoETliz2EVCRRIl+tkG/uk+2alK+0YdA8+AjCBm+9p9KaimJ4vtaTkYr RDzC2cGcnU7ugmV5cnGxM1LK6kquVOZF+BcXqjgH813CXgnascY1x6jigxumyaQBlk1m5bb16YR8JJ nXKh9ZBXLMpj08QsdtrVrC9MoCZeav+JjkYEmw70BietO4rrs8uPGiK3gNHYt2M+xzbiat+Ir9odOF Xd03bHEx4Jk2QSv4w+SNOVwvQ6hX9knSHIBwj/LEhlXeWgoGLjzsMVPn+oOC+nsZoPYtxCLny0Ief6 dcVt9uGWuiE58AEJAU67F0zbLPqaqkqrGGlm6gnL4E9CmhVwdgkvh+CyRN6cRGZ5JZ7BKCZYuPI2/p THDuVQ+cVOVFM26x9jNAOKHtHDnZXLhagZLmBo31b2b+XSmW3BxNVjBHySw58QBj/TRwlPYnVK9SyU 7QpdjoNkZo+247T6mQnYFG8zw6si99+WsX9rcLpFXphfwYS8CJGBVMhLcl1w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Refactor code to be able to get and put bprintf buffers and use
bpf_printf_prepare independently. This will be used in the next patch to
implement BPF streams support, particularly as a staging buffer for
strings that need to be formatted and then allocated and pushed into a
stream.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 15 ++++++++++++++-
 kernel/bpf/helpers.c | 26 +++++++++++---------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dd556e89cce..4fff0cee8622 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3550,6 +3550,16 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 #define MAX_BPRINTF_VARARGS		12
 #define MAX_BPRINTF_BUF			1024
 
+/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
+ * arguments representation.
+ */
+#define MAX_BPRINTF_BIN_ARGS	512
+
+struct bpf_bprintf_buffers {
+	char bin_args[MAX_BPRINTF_BIN_ARGS];
+	char buf[MAX_BPRINTF_BUF];
+};
+
 struct bpf_bprintf_data {
 	u32 *bin_args;
 	char *buf;
@@ -3557,9 +3567,12 @@ struct bpf_bprintf_data {
 	bool get_buf;
 };
 
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data);
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
+int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
+void bpf_put_buffers(void);
+
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..67d48f9fb173 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -763,22 +763,13 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 	return -EINVAL;
 }
 
-/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
- * arguments representation.
- */
-#define MAX_BPRINTF_BIN_ARGS	512
-
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
-struct bpf_bprintf_buffers {
-	char bin_args[MAX_BPRINTF_BIN_ARGS];
-	char buf[MAX_BPRINTF_BUF];
-};
 
 static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
-static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
+int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
@@ -794,16 +785,21 @@ static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
 	return 0;
 }
 
-void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
+void bpf_put_buffers(void)
 {
-	if (!data->bin_args && !data->buf)
-		return;
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
 	this_cpu_dec(bpf_bprintf_nest_level);
 	preempt_enable();
 }
 
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
+{
+	if (!data->bin_args && !data->buf)
+		return;
+	bpf_put_buffers();
+}
+
 /*
  * bpf_bprintf_prepare - Generic pass on format strings for bprintf-like helpers
  *
@@ -818,7 +814,7 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
 	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
@@ -834,7 +830,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (get_buffers && try_get_buffers(&buffers))
+	if (get_buffers && bpf_try_get_buffers(&buffers))
 		return -EBUSY;
 
 	if (data->get_bin_args) {
-- 
2.47.1


