Return-Path: <bpf+bounces-68611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD1B7E6DF
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E65E325771
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5820B2F3C05;
	Wed, 17 Sep 2025 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWmn7KJ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F8149E17
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079222; cv=none; b=Hfffbjq7UYgveGvmLEtwfa0m1iVVdCaGdnckH1tk4qSzIDyI04Cps/BuSl8+/nJj66G8QJbJMSPem/c68T9UX2sUiNCf2AgsP1DiP3K3Um/YBFJvBuixYuwdEk3FAgLKusMwGNL3177f+j8NtxgeWpjxi7Ck3g2ZoGeadc9dMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079222; c=relaxed/simple;
	bh=maKGmv+T2xxKComfhNNqYTf/OstBm/DZXLe5h5G7wMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq3rJlQ4UafhAy1xWAOCqsg/+gVKAupIA+HXEhYlGwrj8Pemag5iu/MeCJ0k22Mm6+PjTaaK3LS2fXwW5HjbxYeFDNtiX64qs20hgcOz2/PO7EyTrervU0U6GJxVNaobzEqZLm/DGHPYZU4H4KrDhZtI+icZs+ryt9V8rMR+F+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWmn7KJ/; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-45f29d2357aso24658145e9.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758079219; x=1758684019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JB/dfOQCpA7zFqQV5rdCfPyQRoQl8tmJDL/RziaZBc=;
        b=NWmn7KJ/L9/2Cq4lf04cHw/X8N9Glciu8zSDNDiYTvsrivVJ2PKVe+hKRBOf9dQqmQ
         EKZ9H3v8lSUsKABa7lDq+lZkU7x31M8QEWLu5sUr9a5zBpEbm+SBz20T+73xpRmNNUyx
         82YH5HUGjYxcNoIQ7MEmeSsHdgQU/qRO1u6HTNVIbr/PyqUJwFO8nRcwaA5tkWffnihl
         0vrZji+faa5w6SEEAGotouNBPzg8HtTUAKbJy1E+EWGBrtdEvzB03mc1VilpNkDXdAb3
         NM/ztQGFhlNvft7IKUV1lSBZFX4fM5OsWDQoduHqoL/owT17u/+ujOzxDKhZoF4hYcKv
         BMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758079219; x=1758684019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JB/dfOQCpA7zFqQV5rdCfPyQRoQl8tmJDL/RziaZBc=;
        b=G0Vqm278fXxksv3XIW+GtCuqU5MCHOrNpoS681F5G0S/AEClmPSQNDg3iadJ9RtBTh
         ut2iEC6/keNibAeS7z2IjV7iKm2I/LqgQxbEpyxmkI3QZV4KI1OqSAcuFilTYxOy8iOF
         iSESzrOqQtqYKcggB5GcMgFbJDZsP7jpt0rELyorvzEpJJ42ZSDorWen2UY7LVAkiE4E
         z7xFSK2mgKkOFl4dQBRXfxqVanby/SSny8nW2JADnNU55TYvUqXSxREyk/hQcl6+6pcw
         X4FxI87d7pthSt7g1A4S56TOTRK6FElobkUPqFUPfDZ82s1lIqp/RWCQHL85S3usnHTD
         JADA==
X-Gm-Message-State: AOJu0Yy7aKS+be+Eopw734fZysHjRa1BLGno8FH0tSjUD3VUd6EFlPyF
	PrxstbhrRvjblcuwfMh1XhelIi2fBv5cL5912h1vbU0owmIM3FPVkJhfkZTuVphr
X-Gm-Gg: ASbGnct+UlPwugiW1uVhCdavlBnG05oEZjMAqtBGd/LhpJSSrZoUk0NH5jzgMSz+Btj
	WIWcll2WOlrgQn/qzPTIONdyGNBn9eio1/v8+Bl1mi7STYvcRfvMABP+vUCEFY2au/FFctyRT/3
	I1+KVehfG/eDe7gmI67v4DHVC/s2lMv4XNUXOEI0fM5K1uhh8nEOT6BgSTBqPB9YiRTtxCMBywN
	NzhkZFVl6z2DoZ2G5tlUO6oS2ZnZtKrb0vJMJdjuhoxxQhiKnSmOPg4T1VDvvk7DOJkoAOEVfcE
	lWcbufI+XycE9PBlOSmqChXZLqbRRZzKdXi9f3hXhWGKpI5TcGyi68N6BNlxK/e+aBlZwvnjQh7
	TFuzccdsguCuxbWs+ArFp2qzRetxSd39YlVc4BEPiFTYQ
X-Google-Smtp-Source: AGHT+IFD6z8BE8W9lSQtOWy5tV0Ny0mea7cAXLqbC5SecFBBUbTZ8DgUaBThrZxKx5Nc5QFxS7AXAQ==
X-Received: by 2002:a05:600c:1d1f:b0:45b:64bc:56ea with SMTP id 5b1f17b1804b1-46205adf8f2mr3506275e9.23.1758079219010;
        Tue, 16 Sep 2025 20:20:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46137a252fasm17041705e9.7.2025.09.16.20.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 20:20:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for KF_RCU_PROTECTED
Date: Wed, 17 Sep 2025 03:20:14 +0000
Message-ID: <20250917032014.4060112-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917032014.4060112-1-memxor@gmail.com>
References: <20250917032014.4060112-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4082; i=memxor@gmail.com; h=from:subject; bh=maKGmv+T2xxKComfhNNqYTf/OstBm/DZXLe5h5G7wMQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBoyiifQBwtdca3uIT2H8q/dBaAhDfUGWpqG9hN5 TCKtfcYK4iJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMoonwAKCRBM4MiGSL8R yvRuEACbPEgpPUuZz29pKtImkVUuFTqEa9doZqJDvK2JXgE/SQWKmXE3CkP/IVt3A2j1cMDEUgT KdvXlmt6TOJYdd5XjtiODBAa4tA4TmXxYkgVd4S10LJrRMGvCZVexY4QSNwEoTwhugn4WCblcvV RsDKj2QHfmteZC8BBs32FNRJnhhJVxerQc8zeovxroGrS8kR2h7ZCvoTbQ/e9aBZOLCJe2moTWl gBgwJdVX+X42XKeA8yNBt0q8mBcEuHWYOFNtMLLbhJcy5KsvQ800HBmCXcLVFWolwxoZIIr0M8s UF6HHPGQ82P/gIs6LVMQpbDxaRTVcC1byeuNSttbkKm2UZTUK8yLwiosbOvb8vj0RSUMWYWLSm1 3IX/5ySHpvQEsRTKiAFUBrYkgIrJRxspfUFnSkMXQIr/OPoMXKYLj1Bb2C/xq70FtncfyFA4XQh C5FT1KWUOp5oDRb+YZXwZCDha7cXbes46u3nzm7K+NgXJwXDRmeI3rk38l/07bF0rJT47kFLDut zTeLW6Xv99ROiubIRd9D39xT11ra/jzc3c0gw+LkCtURNjg2Z9tgwYbKOtWdvFme5SsQmHe5Ec2 cX26hseognUdtW0urA5lFsi90jb/nQ6SRa+FUwAqM72GU8V8dNYZgsDnaX99XHfqikz3z9Lk27K Qzq2u3agWcW/8Mg==
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


