Return-Path: <bpf+bounces-46693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A909EE2C8
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BE6188B29A
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE420FAB1;
	Thu, 12 Dec 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVbORYD3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923B20E71A
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995261; cv=none; b=bXgAqs5dO3h0LoJvngyNFMOJHoWUkptPZ6jyA4k9JEeegNCkRF/fb9s4Zenq/OPVS+Uu9SvdZaDs0tmZuASKaRkDWkx6eNao5NWF9SUU3S1JRPu6t4YvxZDV1NjtumhWgf2Ac/m6FJu0otVTGGR7lm1N8+dyjs59fQ3dXW9DDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995261; c=relaxed/simple;
	bh=1oDcL8+7hvRn/6dep5ZEiIZP2yXEHeKuPEWR9CGCQwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmHPMJpzjT/cgx2etjnrjjmqkjIe8UwituOGgIHv3CsF582LZU5bKI7+tqT+omP6K/sprMH5kED8NE5obdSZ5S0M0RU80UukDNrgeyAO+q/uPiwRDGfgGzTI4IO0KpmwV98G9tSrdST3sZkE/k8BddF37MevrQY+2NPRvUpTSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVbORYD3; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-385dece873cso136458f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 01:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733995257; x=1734600057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I9W/q+keB/2iUFNVghuBzeUL6f/13avU+yXVLx4iGw=;
        b=ZVbORYD3LlcJtPn/J7izLikY389fC1htbkvuRxImEljxrAjDTJALgAOMS0uAhcVjxy
         0wZEEcakBjsFex0xkMs1PcFrvN0/WUvrgGED9Egh1B+Xr1fhS7nrL63d1sXf/YPaY++s
         0QZUJsXcpYiUG5ot3NBY0poWijsyiN2hrI/6kW5IzSaNhs1bmjOleuVof2YF11fls0Vf
         zTh61XlCoaCXMDP1tju5KuNdrv55JAYfObETGUmiEJ+f5oR0Ac48M3Rh5PZSIc26Zwko
         vAV0YEJiWf8d1Z8yZ+zJkO0jFu/2Pu7EC6lZNxmeWTOQFY3o2kid18ZNwZtN0PjrtVRl
         51gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995257; x=1734600057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+I9W/q+keB/2iUFNVghuBzeUL6f/13avU+yXVLx4iGw=;
        b=K49WX7VRvPhvMEjsqZw7eVIucspZQ4JP4y1oNhACYkrQYZODT5Qgv4kXlfw02DQVFl
         M79RqlqJdC572bXsdkjNRcSU6+tr6Po1pAknm++Y44cjEGmTWkRwcnzU5eubwzPOWMvj
         3LcRpOdAccFUkQIsoAFxnEFLDOYnLk0HeBgV2K2VIGKpZYv+t6EoeKRW0fB5Zuu/XHCp
         KWcxXQHsgjndqDkw2Fz88JFb0HV2CN3pKYco8YINUIk8JDhRQ/J7cGpOWcMgZ79I78EY
         bytEsaOygqZAW18RHg39m/2f9ET051gZNXXHY0/GsO6peTPY6b1G0lNuwO6pGiLAu0H6
         YqFQ==
X-Gm-Message-State: AOJu0YwcSO/nuZMcDPh4NDRrGXtWk6GhH4mK1U5o3A2HiX7Fw1IfhH3v
	zYy9uduFlQkHGoRTGgfCbVZV35sK+uAIlRghX4ekKhwxkN2szgRZ3WJOjTYIbwM=
X-Gm-Gg: ASbGncsapUbYGjRCBHC0HFhnFdUQu3oy4MSieBdKt9C7bbybtzCp+1miziQITd+qdaw
	GUhLFevTiG+MEy4mdUVTrSHK1kkLCWpbaNGQPXQJbSL6pd2SeZYBf0GAaaW6X+zROP97UWv2Aln
	mjtM7ujijvslD+piZnYVwv30c12VxmHS4OhLeTyH/CQXrjJDNDNNKBu5SSm92yUFJI5UA7akDTb
	N9hqYFrl67IymFEtp0nAM2c1im1NmPV+8mEy0u4lE/qwGar9/Ltzn6mcoQnW+ZftoHs6OoMzonu
	ezs6EBnG
X-Google-Smtp-Source: AGHT+IGpxAxYwdCCDqZ6KhhmKaPRDy+boI36UGA4m+XdKKXHGakN3CJXQEyPsHgI+eKuFOv10Sz3nw==
X-Received: by 2002:a5d:598c:0:b0:385:f349:ffe7 with SMTP id ffacd0b85a97d-3864ce8959dmr5356086f8f.2.1733995257111;
        Thu, 12 Dec 2024 01:20:57 -0800 (PST)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f533sm3520997f8f.3.2024.12.12.01.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:20:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Robert Morris <rtm@mit.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v1 1/2] bpf: Check size for BTF-based ctx access of pointer members
Date: Thu, 12 Dec 2024 01:20:49 -0800
Message-ID: <20241212092050.3204165-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212092050.3204165-1-memxor@gmail.com>
References: <20241212092050.3204165-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153; h=from:subject; bh=1oDcL8+7hvRn/6dep5ZEiIZP2yXEHeKuPEWR9CGCQwE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnWqguI4z2HD03WqlGC28rCPFYv/yuKld4gvnJFLZr Nmh4Z+aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1qoLgAKCRBM4MiGSL8RyghiEA CVgSUM9oAhssxQvTUyqXrVlfg11JDKoR+m72xG3EMTDymgB/nd+1TbmxRXftYTDLTPlXbJMl98K/OJ UuRfRBSceBjaLlIcpqvPZLfpyKIyRsdpBwUY0iSMVYPsHoRtXbIn3T31gf9Yw49tL1E2RYVIJMXmuH Dj6AzrPzibi4N6cGP1Pa6jUK//aQyM3suS5KEst9oQz14D0vKWJjeFYeE12+vkGiLrcJBibNFRJza3 V/bx4Ug+QfD+ILcMmopsZeMsqh/4ktu9VLQgrHDx+TUXvZ6czroyS2XHwCu6TWEpcxVQjtqcg1F02Z t7p7XkFPe7VPfdvy9lzGvyh5MNur+dWm53/uHf/vWKQ3XkVnam6EU3n+FzHZPoGnj9CU6X9RjG3fxu OabO4HgGEVz8b0vTCqVNwKpd+lo2vT8q4D1jUOXPvHCDSzL84HbOgoQFGB7e68kYYpFBxsa0Z/zZfp Ww83YH1pkbDQQCK+Yr03YCx1CuZvyBlcAARmoJ2d9u07iZiEiPfwky7sAH6oYeKmzBv+1fehMVkA4l YaxHg+YR+Z5vL3gqIq0ksTPjOx3wf3VgIIblaXrXcc6K89gsErTCUNvrcAc3328xhDRsy1gt5lp4xv p85PgLnYEZb93Txz/0vhOhRHgjSGlPTIQqcq8pTQy4gsTMWBfBdoEn9QR7gQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Robert Morris reported the following program type which passes the
verifier in [0]:

SEC("struct_ops/bpf_cubic_init")
void BPF_PROG(bpf_cubic_init, struct sock *sk)
{
	asm volatile("r2 = *(u16*)(r1 + 0)");     // verifier should demand u64
	asm volatile("*(u32 *)(r2 +1504) = 0");   // 1280 in some configs
}

The second line may or may not work, but the first instruction shouldn't
pass, as it's a narrow load into the context structure of the struct ops
callback. The code falls back to btf_ctx_access to ensure correctness
and obtaining the types of pointers. Ensure that the size of the access
is correctly checked to be 8 bytes, otherwise the verifier thinks the
narrow load obtained a trusted BTF pointer and will permit loads/stores
as it sees fit.

Perform the check on size after we've verified that the load is for a
pointer field, as for scalar values narrow loads are fine. Access to
structs passed as arguments to a BPF program are also treated as
scalars, therefore no adjustment is needed in their case.

Existing verifier selftests are broken by this change, but because they
were incorrect. Verifier tests for d_path were performing narrow load
into context to obtain path pointer, had this program actually run it
would cause a crash. The same holds for verifier_btf_ctx_access tests.

  [0]: https://lore.kernel.org/bpf/51338.1732985814@localhost

Fixes: 9e15db66136a ("bpf: Implement accurate raw_tp context access via BTF")
Reported-by: Robert Morris <rtm@mit.edu>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c                                            | 6 ++++++
 tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_d_path.c         | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..a63a03582f02 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6543,6 +6543,12 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		return false;
 	}
 
+	if (size != sizeof(u64)) {
+		bpf_log(log, "func '%s' size %d must be 8\n",
+			tname, size);
+		return false;
+	}
+
 	/* check for PTR_TO_RDONLY_BUF_OR_NULL or PTR_TO_RDWR_BUF_OR_NULL */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
 		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
index a570e48b917a..bfc3bf18fed4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
@@ -11,7 +11,7 @@ __success __retval(0)
 __naked void btf_ctx_access_accept(void)
 {
 	asm volatile ("					\
-	r2 = *(u32*)(r1 + 8);		/* load 2nd argument value (int pointer) */\
+	r2 = *(u64 *)(r1 + 8);		/* load 2nd argument value (int pointer) */\
 	r0 = 0;						\
 	exit;						\
 "	::: __clobber_all);
@@ -23,7 +23,7 @@ __success __retval(0)
 __naked void ctx_access_u32_pointer_accept(void)
 {
 	asm volatile ("					\
-	r2 = *(u32*)(r1 + 0);		/* load 1nd argument value (u32 pointer) */\
+	r2 = *(u64 *)(r1 + 0);		/* load 1nd argument value (u32 pointer) */\
 	r0 = 0;						\
 	exit;						\
 "	::: __clobber_all);
diff --git a/tools/testing/selftests/bpf/progs/verifier_d_path.c b/tools/testing/selftests/bpf/progs/verifier_d_path.c
index ec79cbcfde91..87e51a215558 100644
--- a/tools/testing/selftests/bpf/progs/verifier_d_path.c
+++ b/tools/testing/selftests/bpf/progs/verifier_d_path.c
@@ -11,7 +11,7 @@ __success __retval(0)
 __naked void d_path_accept(void)
 {
 	asm volatile ("					\
-	r1 = *(u32*)(r1 + 0);				\
+	r1 = *(u64 *)(r1 + 0);				\
 	r2 = r10;					\
 	r2 += -8;					\
 	r6 = 0;						\
@@ -31,7 +31,7 @@ __failure __msg("helper call is not allowed in probe")
 __naked void d_path_reject(void)
 {
 	asm volatile ("					\
-	r1 = *(u32*)(r1 + 0);				\
+	r1 = *(u64 *)(r1 + 0);				\
 	r2 = r10;					\
 	r2 += -8;					\
 	r6 = 0;						\
-- 
2.43.5


