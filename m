Return-Path: <bpf+bounces-68365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC66B56E6F
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 04:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF406189C0B7
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 02:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60AF22A813;
	Mon, 15 Sep 2025 02:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NluA4ifb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28721FF55
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904461; cv=none; b=fwrVFeSCZyWrd/VbHgxsEkEBcS7JTFXuLmv+aWStXXoWA6vbl6631uH2H4gnoW6q7IyEdVAQkX9XuwAH3DWf+NGyJ+G49sD11lpFW0ahvvcqkRdF0MDKzJfxD/CaSiB+lQceLlWtntfcQ8Br6EIRVb85uhGUwQo+GlkCda8ApAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904461; c=relaxed/simple;
	bh=6wGHJ8gUn9lp5JjA7feK6dZ/5XTNPN/FtYTr4J6VqtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S12ulx9Gv8vjl/W4rBqcx7Zj/yMGv5rDMmC++UrQtDQBuq6Nri465SLqdLpSD8dPNPnV+HFKZPoz1gs7tWVLEdwRSBvHCfvKCKzMaJeY9+Fi7Q2XwIECrE8rvawIyNwnFMZ4dkATjI6wBQWYnjN7+sV3euLW512ySeNi88Xy9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NluA4ifb; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso21898655e9.3
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757904457; x=1758509257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO+5t/+2oiP/51Pa1dGNthdPbfnyIftKtdFLAJTFMUQ=;
        b=NluA4ifbIueakcIQz8M5P7EU8KQeBIJqMJdFNjZCKnh6Llys3xiqlHNCW3eaZN8tjN
         rpPCXAFlv15VLT0Zt5ciZvvj4nrmvHJzt81tx/UPgG6bNj/rsxlEYLWLXhlkAwWMV74q
         Qa0Xpac3fIJVufNNqUSe/slqJyXCNonowUymtwB7qbt6YuKs3moDN4hNV0PLaAkx73iu
         GacY7HNwa3sR+fcIwG+MwGpdz/DwThxux/hkLSHiU60sxzrT5D6VXFqKMEwcmREk4Lvc
         YxLqwsYNAsEUr5ZZCSoOJZEd1hh33IAXTi64WoGty/KmffcP5NJo7+Q9uSdespkrv5+v
         wUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757904457; x=1758509257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dO+5t/+2oiP/51Pa1dGNthdPbfnyIftKtdFLAJTFMUQ=;
        b=hbQR5m+0Mx8uQhNUxPC74b8PeZcWNDc1L2JZBBGNH+WKU+El3DQZCq+NQRueQXqumc
         apRjiFXyoDGsRLy595n9F0XKBN5YR7Xc0grL9CB7EAkIIqDciUaMbBZhHU8c2oc/6HhR
         jC7I6lVLV6X1UQXQt8DahmaQjIgTR+aeGdGF8Q0n6Xd7uop8DsMytPtLV6SvV9rqONhv
         urzYA+ppu2LagRssofe074J0+rDOIFKf3ONA2F0VUGWivzLHmtFW36VKCSkd39+dLB+u
         yg1X8jIbkqgbYHAYjAOJoWRYn+umau8bXr1t9vRfa4MsTjeOx3DU/obEf+95fx00oWIw
         lWrA==
X-Gm-Message-State: AOJu0YwI1frdupHHPviYUZ2rTl/3YMBVlCG1ntaVaZ/XNYXueLZiq7K0
	MQPyzErCrYLc+2iyVd1PRiUfAUDOfJ24lzxmoDsomK/OV97GTBfIDq6rFA977FZV
X-Gm-Gg: ASbGncuegXig6Ni9YsrlT3xMGApk0lh79Cwj4BupdTM4qH4zPMd9fOw1SCxOz+VMg7Z
	To1PShIO4TD8WeI7j2RO42cIUEXE60qIyWvCSQBYBnB/cdAaUL5mfZls+eFXgy5TH0NntzB2Hab
	OhRmVIBOeUx90tgkguLJoUfBH9Yoso0AVHFKoW3bo/g/NFir2qN3zu4Mo9BUzPxhPRIs/D42Yat
	JyG1MrwgOoBWA0xxweg4ItenMvOXMb8zaOECXLyPQUlQWGb155jZPeJWno4k/YFLcVkz/EkFo2F
	Dc5SCa5bgooCsRd4KHsjoVO0B33gden0ydRfel9/BvnrGdDIZ/aOPKxWW/DCUa0seGyyQLcWqlo
	GNtVCkIpFzH2IcORxA59XQPfgM5Sjf0aNCdcF+x72n5PxzuFpvVLCO/s=
X-Google-Smtp-Source: AGHT+IH5got3PTji6fbdw5fPKuVM7Fla6NfDpylILmh8iIC02Iw1SYop/Mg1dK5WdcbeF7Gys48c1A==
X-Received: by 2002:a05:600c:138a:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-45f211e575dmr114374145e9.8.1757904457360;
        Sun, 14 Sep 2025 19:47:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e41b6dbdbsm142927875e9.22.2025.09.14.19.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:47:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Add tests for KF_RET_RCU
Date: Mon, 15 Sep 2025 02:47:31 +0000
Message-ID: <20250915024731.1494251-4-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915024731.1494251-1-memxor@gmail.com>
References: <20250915024731.1494251-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3204; i=memxor@gmail.com; h=from:subject; bh=6wGHJ8gUn9lp5JjA7feK6dZ/5XTNPN/FtYTr4J6VqtI=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBox34hYTM97tzD7gFTjnR5sDUMPcLslrX8CGst2 29fMZB9jKKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMd+IQAKCRBM4MiGSL8R yt0yEACUkYEWj4RSvdQFStt3YoNvADLOE5CZqAhLJSDOuCjSffSUqrIALeIyThqqLM0MYan3j8Q KyVQD0eRuioeRu45DVj1XUHnh2KG04hU/Itl4Ar96UsTe/4EXo+L2u1w6Sx9N6HFeL1zo+/nw9F OzWHbkHd5DRGaqGsRYciRP0CnvfKUILbGLi2P8BpVYi2t8ImODGOvYtrsE+KizquWKwsvp7c0r5 HnQx674phhf0Fd0fWA6208R0oHflpIuLZUOb04qw30qFEcla2tiR4d6Z0fS+P+PXa7/mL9o4RI/ Ko+ppmxz1R5lPElesJdTHJPez+x18tSCyaqSZwz9gHlsPLK2UORVQB/10hJPXMiBqcTgC9h7M+z +S4CyBIP+z5zD87pRPWVkQXA4HJdB2NFEehTdhmosfMwKdDZSDjfQF1w1fm8Ginot9+zrpxBk5I PTL1rmBOkhHvFMW8t9YUt/5FzLN914n4nLCbbL4HUiU9VSQlF4jARzNg0lpS30nc7b7J4LGbp/W AS3cGraR2Edmi/U2WF6qs7qXHpV0OeSxfWtA0+7qQ1KdwY/g2Zu2c62KSGkVpmj/Szlt0r+o8Ux A7CsFTekHJFK8AojwsSeXrvMeiWSNInt3xM9aK8l5u7GyFiHnM2zHEfDHCD84C8j/5B37JxSIOD G61Edig/EfUexGA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a couple of test cases to ensure RCU protection is kicked in
automatically, and the return type is as expected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/iters_testmod.c       | 23 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  6 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 3 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index 9e4b45201e69..ab4a519e8004 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -123,3 +123,26 @@ int iter_next_ptr_mem_not_trusted(const void *ctx)
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
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2beb9b2fcbd8..fac0e08fa803 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -218,6 +218,11 @@ __bpf_kfunc void bpf_kfunc_rcu_task_test(struct task_struct *ptr)
 {
 }
 
+__bpf_kfunc struct task_struct *bpf_kfunc_ret_rcu_test(void)
+{
+	return NULL;
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -623,6 +628,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
+BTF_ID_FLAGS(func, bpf_kfunc_ret_rcu_test, KF_RET_NULL | KF_RET_RCU)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 286e7faa4754..3281f1e446cc 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -158,6 +158,7 @@ void bpf_kfunc_trusted_vma_test(struct vm_area_struct *ptr) __ksym;
 void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
 void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
 void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
+struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
 
 int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ksym;
 
-- 
2.51.0


