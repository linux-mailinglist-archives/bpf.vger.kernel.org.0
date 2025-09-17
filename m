Return-Path: <bpf+bounces-68614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A7B7EB57
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B11C01DE3
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9239F2F7441;
	Wed, 17 Sep 2025 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuaGroSc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639532F39B1
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079683; cv=none; b=D6nuioSaF6qMRZ3xQ+O8jmSNoTnOrcWJAD1oAkwKGJ4HZstCj2CpdoBrP4fVZUNQyl+5DKEnrM0UxaPRRZxOgvmcby9E056ZaZAJq071yfTUu5wMUJBIrdwDjxrktxNa81D22I/BTY+pmBfUt6VfXIEOIQwhCnvgyrFgjr5Ice8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079683; c=relaxed/simple;
	bh=maKGmv+T2xxKComfhNNqYTf/OstBm/DZXLe5h5G7wMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2zmCj71zURoo+Z5SCB43AoTvqchqNa6S71MdqkxXzCTvKqBXvlZQjztXt6Ay1tr69QFBSMI4rgWWkNCvqvz8Y/v33yzaPbyaEyjLub2pNvvJc8TQ7nZwQDcFy/TIm5oMwZtQOkJ89s806geLFAhrcPQIRZtPboRYzAcKFssPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuaGroSc; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3ebc706eb7bso1481656f8f.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758079679; x=1758684479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JB/dfOQCpA7zFqQV5rdCfPyQRoQl8tmJDL/RziaZBc=;
        b=ZuaGroScWMmqDPM1DxfP0FLKw4Kk7DJ2ijoDkdYrXHwNqDg2h/CiLZLqhb5tOHj2lT
         6szLa+YsUnTa/IkC7tm5+3pEi65X8rb4n7xJ2jkKyS3S7TivQwTrL8cPFM1z2NuwtWAB
         vlI2B0rr9Zdxsuzop2+n2gnGtgUoC2miPzykcvEbxJrnnYxvkwbrwCIz1IC4ZFZT+/NY
         PAHMDj0kgu4laZhjTOufSeSNkDZFojJ63oypGOOu6Jm2nQRWVdRoVtQiRp2B1O3BI9En
         oXrgRzjeZEvwiJBc4gQYPESy/xlbQ+Dn02D/NLiDIE1jegRzfhFvtM/k6mGmq3TYEALS
         tHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758079679; x=1758684479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JB/dfOQCpA7zFqQV5rdCfPyQRoQl8tmJDL/RziaZBc=;
        b=A+4Qxq99Igl4UcB2BSSpPUvRW7gydcImOVh5Q2nkakUVzjyr+E6NufVsGnDIa6Npwm
         AVszUeHNjF12F7mZ2tye5cIu4N7HgjtaGcqhYknrdG0hNhHi7d/tOVYpC5GYNrusZaIx
         XYDZAtkpT57/mrLZXfJjhDl62EcrP89hoytKUOnERY0/z70XDI0a0BdCvtjdd3fy+Zeg
         j6yhxHw/38+OTTfdLeL2hoKO+V+ia55d9aHPeLmUI65ieLJ0+Lhysofl7tpTPQ1Rg37P
         26NzwJ3Xx0OIpQKveedPuhaWXH+JAyu6vHu05NJOhfchSjtv1kc+dOCgXoyBpqrV1Byn
         52GA==
X-Gm-Message-State: AOJu0YwoK8hebZE9b1LmGdj7wfCO/46B1uV30bXQFSh7+tDAT8gWpb6Q
	wpr0zEVqg04s7m6rXKpa6os9j+mGYzXfdDzuJP6RX3nZwcIjvJi2UcvStyqKbnaS
X-Gm-Gg: ASbGnct95s6NDju1U9OQoPxtv/z3LCfW5BqiQpk+WtdNYqm68UPIuznI0KYRR/Aij8G
	gj9kftk7ITotJy9MFB+SBGqCto/U4MDbtoXuT6S1sbrMdOMRONQlARyCGundSzhQ7SuyJoTGb1C
	09aKMpmHyifmfnm7Gq65ceS2tUmxcbtRogkDuPZNIroDvs6tIzOk7nG6zPiG4p5s6tmyqU/IYg4
	NvyxBCLT3GyxlWY7ADTa0it/r12AH+PvyKyXRp8vdddoMAOs82nnx8eyszXEcV8+pRPil32L/z2
	51oKQmzIymJLitDXQiX3JDRuz/Nmo5w58SZNi9YfhPokqhYPjRARwIU/LTDQLlelkkOkbAWv3I9
	HWhzsT8iMa4SS5C6KcvCQ3K2aCgEQEwu2Iy7/IyZzXFsx
X-Google-Smtp-Source: AGHT+IF0kpFEKZh8QredQb04vxspzfvEhnISwueobX2P9lBky/lpUvzWJSZlIgC3TNFHWTS1278M/w==
X-Received: by 2002:a05:6000:178e:b0:3e0:2a95:dc9e with SMTP id ffacd0b85a97d-3ecdfa3b817mr431633f8f.57.1758079679295;
        Tue, 16 Sep 2025 20:27:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3eb9a95d225sm9154059f8f.54.2025.09.16.20.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 20:27:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for KF_RCU_PROTECTED
Date: Wed, 17 Sep 2025 03:27:55 +0000
Message-ID: <20250917032755.4068726-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917032755.4068726-1-memxor@gmail.com>
References: <20250917032755.4068726-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4082; i=memxor@gmail.com; h=from:subject; bh=maKGmv+T2xxKComfhNNqYTf/OstBm/DZXLe5h5G7wMQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBoyiqtQBwtdca3uIT2H8q/dBaAhDfUGWpqG9hN5 TCKtfcYK4iJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMoqrQAKCRBM4MiGSL8R yiRrD/sGP4PZEAjWa7a5GywFHuP8MSqdcxrNLZFmCsC+GWQrF3Kef0iiMeN/cw5U017DQTlQ+Js QG6U1U7jbY6BjwRxKzRTa39ht9RdjC0K0oGs6RagFjNjw//CfLPc+cfzyRtloaRSVy1xkZ/acWP 6KOoICPUHGPAcXpED2h52Xqk/RwDfW2Wc9Fdw3aEPtw5BXH5AHlMEp4wuARPxeyaU/5OwrRPUe0 5jSLMxAOARf+QAEaHicaJsfzpccHxKhpymZ+mbhUZ3ZMOWnMy7AoI7gNIilomoDUgTyTjja7vAW ZKPOI0Vkf16hqj3odK7lGt6YGF0hF2nZTJ/0OdQz8st3HRUVavjXasE1tNpA7EMEhE4OXQMEQGZ mTbPtO+f5GqWi0hKIukjtD158023MxMwrCt0OUtUNXMPBFLh4GKiwGN86N+gACNVVhK9Trz3Q0k s1ptY5bs5/bFwL5/9vF/3wxBUbRv8uErYH9uIOKgnAO0qJv6cO0betTOBZ8TPv4J/I/V3IpHg/5 uJMjsnE6SJkBCNoe5IzEaKHx7n8hH3SbN3V707Z+BwK5YovBMC0HBbklzVRdUd15PsA57mhFXH7 PvtQd5UeW1SS3dEG1YA7uNvOy9I4tqSTwAfGBtMUyNsC6MKlPaKmDdFGaE5FLIZEBCrEBAKAjjX 0jonAqtoFmq/Daw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a couple of test cases to ensure RCU protection is kicked in
automatically, and the return type is as expected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/iters_testmod.c       | 46 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 12 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
 3 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index 9e4b45201e69..5379e9960ffd 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -123,3 +123,49 @@ int iter_next_ptr_mem_not_trusted(const void *ctx)
 	bpf_iter_num_destroy(&num_it);
 	return 0;
 }
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_kfunc_ret_rcu_test requires RCU critical section protection")
+int iter_ret_rcu_test_protected(const void *ctx)
+{
+	struct task_struct *p;
+
+	p = bpf_kfunc_ret_rcu_test();
+	return p->pid;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("R1 type=rcu_ptr_or_null_ expected=")
+int iter_ret_rcu_test_type(const void *ctx)
+{
+	struct task_struct *p;
+
+	bpf_rcu_read_lock();
+	p = bpf_kfunc_ret_rcu_test();
+	bpf_this_cpu_ptr(p);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_kfunc_ret_rcu_test_nostruct requires RCU critical section protection")
+int iter_ret_rcu_test_protected_nostruct(const void *ctx)
+{
+	void *p;
+
+	p = bpf_kfunc_ret_rcu_test_nostruct(4);
+	return *(int *)p;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("R1 type=rdonly_rcu_mem_or_null expected=")
+int iter_ret_rcu_test_type_nostruct(const void *ctx)
+{
+	void *p;
+
+	bpf_rcu_read_lock();
+	p = bpf_kfunc_ret_rcu_test_nostruct(4);
+	bpf_this_cpu_ptr(p);
+	bpf_rcu_read_unlock();
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2beb9b2fcbd8..d6ce51df9ed4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -218,6 +218,16 @@ __bpf_kfunc void bpf_kfunc_rcu_task_test(struct task_struct *ptr)
 {
 }
 
+__bpf_kfunc struct task_struct *bpf_kfunc_ret_rcu_test(void)
+{
+	return NULL;
+}
+
+__bpf_kfunc int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size)
+{
+	return NULL;
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -623,6 +633,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
+BTF_ID_FLAGS(func, bpf_kfunc_ret_rcu_test, KF_RET_NULL | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_kfunc_ret_rcu_test_nostruct, KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 286e7faa4754..4df6fa6a92cb 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -158,6 +158,8 @@ void bpf_kfunc_trusted_vma_test(struct vm_area_struct *ptr) __ksym;
 void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
 void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
 void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
+struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
+int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
 
 int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ksym;
 
-- 
2.51.0


