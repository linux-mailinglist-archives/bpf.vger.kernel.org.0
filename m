Return-Path: <bpf+bounces-21183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8E84916E
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 00:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22171F21A4B
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E1B66F;
	Sun,  4 Feb 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsSSPCK0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616F8BED
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707087759; cv=none; b=dElrNPYp8NFFN1MsPavlucjIChFCPp8yQkBXMP0Kc9oFj9PolP03o/H9d1bP0WYQ8c3FrhLpOsFA9O2plFkjAAYgNhwVHkS5SeyZrkZ1OoISnCHuijPnCHuCEKOwLbjXBaAMD1cjavfxHLs2vSNWaeOvOHBJCHll4HHnaynI6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707087759; c=relaxed/simple;
	bh=kcoCOUAvN8uaN3f2XE2jamXmVxpANNdQmyUVm3sohRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P5NymiXBNxcW7UnrHEk+gZ7C5P2VVXZUE9hv1UAg09ZWceyFAjpm2sg0jXN3gkBE0uHJljJ3kfQYxWLaL05Pw9vsc/V+L+oayy3E0U4eP3M5Z2NI4CzMDD4yhFTbJfd8bsC9qxacBkjUHwXjPiWyj+9v5cd/jFh1H0z8lrpo9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsSSPCK0; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a3796032418so50055966b.3
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 15:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707087755; x=1707692555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTTEhJ9kCTPFs/k8C02v/lZcWvhwj/Gv3hSJ8xCLEBQ=;
        b=QsSSPCK0v8UJUvfg9dUv6Ee5Jpv9YTR9KZxzyjV1UDKhdpz+r+WcuiSJI5eANiWvHF
         hI7r9AGCJChiCpbyh7HUkMfLKFpIAB9cnZ0uNg5YzxVSsWpf36jbIQqsS6ru4zWBEOk9
         ivmakC+pT23paSkvjUFjk2DZbxgjhsWBZ/tP6e9fYKyrKwD7OYsQajD8DLtXZNRY6ziD
         ilbiFa74pyUY+Eba8tqm16HERc6BwXALoMmFb2v5Mfzae4tiNiszwtGVN6ICIoev7ESi
         yFjmToGKx2oJiu4ScdLkfPieNnWSPvFXQ7sDdskH6cn+aj+aGaDv35cgf+pdgpvINIF/
         qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707087755; x=1707692555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTTEhJ9kCTPFs/k8C02v/lZcWvhwj/Gv3hSJ8xCLEBQ=;
        b=tYL3oepozHVb6m8YY6cALXuz4iPZwanD+A157w5QbRG/O3Fm7j57B9V3uYxDsDfEH+
         e4nfNlMKSc1uorQMVOvCwugc4DB7PeFhg7RH5rIaxS10v8d2efagcoxzRZ4jhTZ4rgwY
         XY2wkWEmGsOAY9t8/e2M+xI2u4cBfySTvOZCea7t53lJVkrEdYSA+xBqCXp8qxOL8yT1
         qItCBP4WAvSURwmdO1zNKLEIwxccfVMmh3Okhoh66qWPizWr/vNroC2io2/ODwkwLbKy
         5k047yKeFWkgQavOQemORhhJDVF914QZ00HcLQluHV4KA53LPKA7gGpNG9L01he43aNS
         gTaQ==
X-Gm-Message-State: AOJu0YzOswYHTPrWB+J0Xla5GOKEK9j7vWG3onlX8WyG0zePCnHaFWwu
	M6o2M5fTbdTeixP2Gbkr/uDlxAAs7txzAjQCyV4zKiCUIUv9HbNTQ1IBsLpc7D4=
X-Google-Smtp-Source: AGHT+IFNhq28ooP3hyY7GaqGcUjBhpElF7ZXXEhh2E2ULTk5qTA6Yvjp5IuNrhv112OofDuhlTg6JA==
X-Received: by 2002:a17:906:185:b0:a36:1c9e:9169 with SMTP id 5-20020a170906018500b00a361c9e9169mr5874893ejb.2.1707087755484;
        Sun, 04 Feb 2024 15:02:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX/gZeidEhsuONbmBPzfSvKXRZaO9E4sJ3o9581q7FdlyTlchs0qblVEmlSwNsyBnLLPpMBZadncIk0PHyV0HcGqwH7rYAHy06VGJIF/9uh1fp+sBUzqzxCVPeCMcBmwMTnNTTKAplVmR+3bkrIsi4A57HeVQ6qEN9GwFWgB+VAKtdsVv3u1ZGwsmhZe4Qp7pRE5iFJyG5U6u59UnZByvLR2IbKR41991I7NA==
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ps11-20020a170906bf4b00b00a3785efe1c4sm1334332ejb.85.2024.02.04.15.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:02:34 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for RCU lock transfer between subprogs
Date: Sun,  4 Feb 2024 23:02:31 +0000
Message-Id: <20240204230231.1013964-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204230231.1013964-1-memxor@gmail.com>
References: <20240204230231.1013964-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980; i=memxor@gmail.com; h=from:subject; bh=kcoCOUAvN8uaN3f2XE2jamXmVxpANNdQmyUVm3sohRs=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwBeBaq0ENkEcVtJiSPaqy+6EPTy47UoSai95i e3wpfKfn3qJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcAXgQAKCRBM4MiGSL8R yml7EAC+5FYgCOGk+p9bK4VEy/NtTzyfLEMvM7SISGIf8siEAcW5c9z7mBRz7l+yq+fykL8YIO9 X1H8q0LpUpAG3XlEY6PPQu7VJfSOmBx0f5elapb08mYs3ONRiW6ovCtMlTiCCe3+34YgCvM8KeM T4gv07NtlPl+QqmnWLMIT4grNn64znksE9LBMCDXBcnluZqjIxBHOPr3O0mS8B8WLpWsjlapD/m bCGteH92TjIY2BNGAe0yyR3o7qMXKJaQaT6Qz97M+kn+CbwhErGfJVZimi9MkoPJse26qiqBo/2 Tt/FHEosZLYG+5ub3N8DLpqFfvOM4FT9tJ/ae6Ki4yA1NqWgIUE7TqB2qiNoWpEftn0ZXp3Pgz9 H8BkzqdcpwHYUsYf35MQL8d/THAqnJEKTT1y1EC+Uo7CZDAtpnqCXIx3yvv3LeQvY0/szt/GEzV uIvVcLo8a8i7BZJvM/JynzSSA5iWAHty67d9Knhwod98jmnJ8ObyeyygdIPjmPv33Rh7BhqxHR+ CBAm7HAN88b0EetclfYHMsPyRfPRkTM4MPrue+DqBA39pcjYytaMnbH+74mb0S4rKUUorKYsVgH Pz455TfGpwJjsJAjRjJe/GVGs2nmHS/rS2l7Mi6FvpP+uazD1xWzcokBj0/r78+iwWCV2Y526SJ MCjn7mZ3A99q86g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests covering the following cases:
- A static subprog called from within a RCU read section works
- A static subprog taking an RCU read lock which is released in caller works
- A static subprog releasing the caller's RCU read lock works

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  3 +
 .../selftests/bpf/progs/rcu_read_lock.c       | 64 +++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index 3f1f58d3a729..328a25e031d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -29,6 +29,9 @@ static void test_success(void)
 	bpf_program__set_autoload(skel->progs.non_sleepable_1, true);
 	bpf_program__set_autoload(skel->progs.non_sleepable_2, true);
 	bpf_program__set_autoload(skel->progs.task_trusted_non_rcuptr, true);
+	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog, true);
+	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_lock, true);
+	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_unlock, true);
 	err = rcu_read_lock__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 14fb01437fb8..687df026feb0 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -319,3 +319,67 @@ int cross_rcu_region(void *ctx)
 	bpf_rcu_read_unlock();
 	return 0;
 }
+
+__noinline
+static int static_subprog(void *ctx)
+{
+	volatile int ret = 0;
+
+	if (bpf_get_prandom_u32())
+		return ret + 42;
+	return ret + bpf_get_prandom_u32();
+}
+
+__noinline
+static int static_subprog_lock(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	if (bpf_get_prandom_u32())
+		return ret + 42;
+	return ret + bpf_get_prandom_u32();
+}
+
+__noinline
+static int static_subprog_unlock(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_unlock();
+	if (bpf_get_prandom_u32())
+		return ret + 42;
+	return ret + bpf_get_prandom_u32();
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_subprog(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	if (bpf_get_prandom_u32())
+		ret += static_subprog(ctx);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_subprog_lock(void *ctx)
+{
+	volatile int ret = 0;
+
+	ret += static_subprog_lock(ctx);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_subprog_unlock(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	ret += static_subprog_unlock(ctx);
+	return 0;
+}
-- 
2.40.1


