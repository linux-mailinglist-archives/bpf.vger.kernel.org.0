Return-Path: <bpf+bounces-62455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9305AF9CAA
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C658724E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698A28F935;
	Fri,  4 Jul 2025 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAXq+4U3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0328E5F8
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670251; cv=none; b=KWW+5+VIFiEdB+7TXPAw/RxO19uisFYjVJk+vU/w4Dux2ZFSIF54a+DrO5QEKJcGsZvmet+GPYZ3Os3B9mmN5La/PGh3o7uc77bCJyQxcBVTCDi1v3H2NyewlkzMKiY+LN9zJp4OHE3emWfn5DoKLjeTGMmWC51Qp8HjkAc1fAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670251; c=relaxed/simple;
	bh=eiLj48MI09PVYNagxJIWCKyFIkZSaVb9FgIIyi+ojNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tilVj4khckKQWUdlpR5JJIgpDSgHnToYMZajbrPCurcvfAOWLDPOPn2cRwfV34eyIzB0bgZQejCydI0wPXXSn5nY4hpiwa3yezgbAGfWyv+WTbrmk9Rd7wyXb/pi5Z+c5sys69+uSUQsT+Mx4VJKZNKkOjpZZO9MqsO10+Iov/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAXq+4U3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748e63d4b05so747799b3a.2
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670250; x=1752275050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gf79WXTUNzwevev8ZbRfYx8Ji3Z3z2id8+ZRsSEPpys=;
        b=kAXq+4U32XcOIQ5CMjK7+iKNXrt741Bb7JzqryR6OQHKGN1jct9cprPz1D0Tt+QUsb
         bqQiIcVt6pJB/BhCbq3inQECz7uWh21jca4gq/xA6JYQzscVAaaeDMlwB+VTBPLZqXxo
         70jQHFdu0uik1LVh7J7UvVqQE3oGfIW2wp4PQnDXJIgqmtisYjomBo6IknJ9opsq7Fak
         aSNxmtw9f+kRUvXYzlmzLiBxQn5wyf0yr7rBhMu/xy5r7ewBJ8clkjbE1R5aGbtQwVD9
         1jnWCeOqpZ9JJYMg2SeV+/dLDPCPtLb4dpeRI6wMlbe6xzBriPTDHyQkGwdBTc8CJEsx
         SpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670250; x=1752275050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gf79WXTUNzwevev8ZbRfYx8Ji3Z3z2id8+ZRsSEPpys=;
        b=Jwk+VkivdEhprZARyWpt5jRba8J9+wZ7AS3NEywflHTDWSUKaRqhLCrlb2rexkB9h1
         PrRWIEh5xjT7rYgMYGGbh/Lp+LNh5xJ5CUuka7TwTe8swdxxdKJv6tOYB7yMYZtF6Cuo
         KocBnAEZ/dBxt1UcNRd5MRAKvaT+XHL5AVQtT5bWlK39qb6SaVVQ6iotc6jrAt/SO0vj
         W+gT+KVuEH9ZjxCO/knJVAgOVoFJ+cuBmaj/1LZkkYSG3xFJ4Rk/C9STmkmNaWnT100H
         ojtsSR1LXEP/7y+x+JezoGN2dn5D4PYyVW72SlfCzxpluttTY1eQw9ojMUFxe1wDHFfs
         hn4A==
X-Gm-Message-State: AOJu0Yyu6gualL6ydrzs491uiiaw/BY1oRPzPSJAjz2q0jsl/mEebCG+
	dY6TAx3cvvBkxHFeIuyaCkywfLD57OLoIYu5uzCEk4Po6PlU8GgPOv3VUFVK5A==
X-Gm-Gg: ASbGncvYDd4/BPZIiYZBaj+TYN0YU2vXo/b/rcDbo+TmvVjZ4nnisbTQAWjxT/g593J
	amXuneC0zNYxyKES/mYJFLFYlh5/ZlFXD66nRj1Y8BaD1QxDeVvvQNADw0yhFk/HfCbDjrkdJl6
	6dnH7Bsn2vTiK5xqeeHcMsYLxj0aZ3bQLomzC5gs2+RmqLa5mZ4yk5Dc3o+A2nM2WAo7E7mu2L9
	O1QYdNmYwmnKDHnnjpa9lItK1aj1zW2DB0qcvkDGvHO+Kpzl79MBsDVf3iXxBL35Jghn6jiZGG4
	87tw/zDMRPFOuwWHdiH10yAJotoS0TybDTKMxk6BNaEsVKLGGIAJgrNGig==
X-Google-Smtp-Source: AGHT+IEiNXzZpfXGmsc/8wAHBzHAoAOLuzk9Z/sVr9ebYe5ZRH76AIr7bbKrwZvvsX0w18BZg6QYBQ==
X-Received: by 2002:a05:6a20:939e:b0:216:1ea0:a526 with SMTP id adf61e73a8af0-2260c04c9d3mr6149033637.40.1751670249657;
        Fri, 04 Jul 2025 16:04:09 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 6/8] selftests/bpf: test cases for __arg_untrusted
Date: Fri,  4 Jul 2025 16:03:52 -0700
Message-ID: <20250704230354.1323244-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
References: <20250704230354.1323244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check usage of __arg_untrusted parameters with PTR_TO_BTF_ID:
- combining __arg_untrusted with other tags is forbidden;
- non-kernel (program local) types for __arg_untrusted are forbidden;
- passing of {trusted, untrusted, map value, scalar value, values with
  variable offset} to untrusted is ok;
- passing of PTR_TO_BTF_ID with a different type to untrusted is ok;
- passing of untrusted to trusted is forbidden.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_global_ptr_args.c      | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 4ab0ef18d7eb..4bd436a35826 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -179,4 +179,85 @@ int BPF_PROG(trusted_acq_rel, struct task_struct *task, u64 clone_flags)
 	return subprog_trusted_acq_rel(task);
 }
 
+__weak int subprog_untrusted_bad_tags(struct task_struct *task __arg_untrusted __arg_nullable)
+{
+	return task->pid;
+}
+
+SEC("tp_btf/sys_enter")
+__failure
+__msg("arg#0 untrusted cannot be combined with any other tags")
+int untrusted_bad_tags(void *ctx)
+{
+	return subprog_untrusted_bad_tags(0);
+}
+
+struct local_type_wont_be_accepted {};
+
+__weak int subprog_untrusted_bad_type(struct local_type_wont_be_accepted *p __arg_untrusted)
+{
+	return 0;
+}
+
+SEC("tp_btf/sys_enter")
+__failure
+__msg("arg#0 reference type('STRUCT local_type_wont_be_accepted') has no matches")
+int untrusted_bad_type(void *ctx)
+{
+	return subprog_untrusted_bad_type(bpf_rdonly_cast(0, 0));
+}
+
+__weak int subprog_untrusted(const volatile struct task_struct *restrict task __arg_untrusted)
+{
+	return task->pid;
+}
+
+SEC("tp_btf/sys_enter")
+__success
+__log_level(2)
+__msg("r1 = {{.*}}; {{.*}}R1_w=trusted_ptr_task_struct()")
+__msg("Func#1 ('subprog_untrusted') is global and assumed valid.")
+__msg("Validating subprog_untrusted() func#1...")
+__msg(": R1=untrusted_ptr_task_struct")
+int trusted_to_untrusted(void *ctx)
+{
+	return subprog_untrusted(bpf_get_current_task_btf());
+}
+
+char mem[16];
+u32 off;
+
+SEC("tp_btf/sys_enter")
+__success
+int anything_to_untrusted(void *ctx)
+{
+	/* untrusted to untrusted */
+	subprog_untrusted(bpf_core_cast(0, struct task_struct));
+	/* wrong type to untrusted */
+	subprog_untrusted((void *)bpf_core_cast(0, struct bpf_verifier_env));
+	/* map value to untrusted */
+	subprog_untrusted((void *)mem);
+	/* scalar to untrusted */
+	subprog_untrusted(0);
+	/* variable offset to untrusted (map) */
+	subprog_untrusted((void *)mem + off);
+	/* variable offset to untrusted (trusted) */
+	subprog_untrusted((void *)bpf_get_current_task_btf() + off);
+	return 0;
+}
+
+__weak int subprog_untrusted2(struct task_struct *task __arg_untrusted)
+{
+	return subprog_trusted_task_nullable(task);
+}
+
+SEC("tp_btf/sys_enter")
+__failure
+__msg("R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("Caller passes invalid args into func#{{.*}} ('subprog_trusted_task_nullable')")
+int untrusted_to_trusted(void *ctx)
+{
+	return subprog_untrusted2(bpf_get_current_task_btf());
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


