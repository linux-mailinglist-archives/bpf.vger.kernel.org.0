Return-Path: <bpf+bounces-26345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B447E89E708
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197D4B21DF8
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AC2387;
	Wed, 10 Apr 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV7CZFVC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FC1C2D
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709726; cv=none; b=NHXZhiQTMzPxUR8LXBWOkyL/2uORVB0wHNY64x93a5QUCtC0wmdoaM5r1cveE/4GBNUeexioxzO92quWCHEuIHuUxPSlnzNoruhKrKYzT6/psUHiT8p11vHuuT0kST6ZYj4o0OmghxLwruj8LWvJf8hEWUcIBV6iG94psxVQxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709726; c=relaxed/simple;
	bh=DypjCVY43yhA5fiSymfCfD24cW9KiO9HvaU5WeMouKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXFVxLfnNeljUN3B+Qgysk3PAUgFtJAS9jvEgIigzssMuxKrIK5gpMJTn0P++EnY/ozL8bo8Fb3MyhKMQxXgvX6gakZ3eKml/OJFe04yVXM7ptRJ+MgrsrHDywf05ptmZuCKBSz70U5O17exfxGF2AS1M9yO90HwfogTxygyzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV7CZFVC; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c3d2d0e86dso2553056b6e.2
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709723; x=1713314523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCXoxIZdu3IbIezcXli4tuWerfrPR0dwNVTGMo9uTDs=;
        b=lV7CZFVCiNAdYYjw4SGXVN87bRs4wqrUeAhbKdtg71H/VHIQBmNcF1SyDEq4g6R/HG
         i5IDHZKrt5Av+qnwrG0LZnCT7rDjVNwUAC5FSCw48qy/Veojm88+Lt7L7W0uxZ5nB0nI
         tjTHjWy4gSeKW35dFHO5ah4USmBdB+2lNIpj7TNuYNA/qDKh89fTRaFRtFyXBeyTcfDh
         JkEEmDPddc4dfSXR556z6ukNX4BmmzuaEJAIEk2L1b1Dn0GQFv5CYNNvHtVNif5kp43Q
         ++wGg2kJCS8CPzh69f4+Bz/bn8oBKLKL60qd15eV11FIQGLiJKUXGhd3InLurnPog/pJ
         WnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709723; x=1713314523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCXoxIZdu3IbIezcXli4tuWerfrPR0dwNVTGMo9uTDs=;
        b=BNe9sElzhsC4xaRxOvQ0f69tTQ6/x4SDQwXGRiSWk2X1td0h3QzeNE9a4pzJHljGbV
         DmXH8Y8aiKeIRCeAyyBL27AIbjdkPJComkW0MP3B9HhEhoz6FPFeisaZrASbhabnoiu/
         S6Jg1q0jMtklkhUoutriH73CyHRWJW3KpQrOTZNeMKI/Ny0BJXz4+IohgDG95o9HlMoV
         AfoOBggilk1QiRdP4qJjwUE6OYcsyS4f1yBzFxBooE92A81RcGMvXEurYOFlsKI0/4wQ
         bl/Zn083CbJm5M/HMb+XGsJAibSk6ry6BcOckSRdLz2Df8yLFU4XGq4pp5k0d3zAhmAW
         8Guw==
X-Gm-Message-State: AOJu0YxuHuCqB7WqWfdEMxLyz7Ed0xHQM8Es4boiZLRIjTUFRrCwsLEC
	GZcVnaVYRo183hcGmAsSs07R8ak/KlQ7RY4QUVxTna3PnWImahhcQK5HaANc
X-Google-Smtp-Source: AGHT+IGnVOHmpS5mgkpWD3BGDO34/rvCjq5eDlNltxWbIkW79D0e5R9dbgGW7qV9H3Bgvu07KNdkbA==
X-Received: by 2002:a05:6808:144c:b0:3c6:78d:a5f0 with SMTP id x12-20020a056808144c00b003c6078da5f0mr1331929oiv.6.1712709723405;
        Tue, 09 Apr 2024 17:42:03 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:42:03 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 09/11] selftests/bpf: Test global kptr arrays.
Date: Tue,  9 Apr 2024 17:41:48 -0700
Message-Id: <20240410004150.2917641-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that BPF programs can declare global kptr arrays.

An array with only one element is special case, that it treats the element
like a non-array kptr field. Nested arrays are also tested to ensure they
are handled properly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |   3 +
 .../selftests/bpf/progs/cpumask_success.c     | 147 ++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index ecf89df78109..bba601e235f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -18,6 +18,9 @@ static const char * const cpumask_success_testcases[] = {
 	"test_insert_leave",
 	"test_insert_remove_release",
 	"test_global_mask_rcu",
+	"test_global_mask_array_one_rcu",
+	"test_global_mask_array_rcu",
+	"test_global_mask_array_l2_rcu",
 	"test_cpumask_weight",
 };
 
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 7a1e64c6c065..9d76d85680d7 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -11,6 +11,9 @@
 char _license[] SEC("license") = "GPL";
 
 int pid, nr_cpus;
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array[2];
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array_l2[2][1];
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array_one[1];
 
 static bool is_test_task(void)
 {
@@ -460,6 +463,150 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_array_one_rcu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local, *prev;
+
+	if (!is_test_task())
+		return 0;
+
+	/* Kptr arrays with one element are special cased, being treated
+	 * just like a single pointer.
+	 */
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	prev = bpf_kptr_xchg(&global_mask_array_one[0], local);
+	if (prev) {
+		bpf_cpumask_release(prev);
+		err = 3;
+		return 0;
+	}
+
+	bpf_rcu_read_lock();
+	local = global_mask_array_one[0];
+	if (!local) {
+		err = 4;
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_array_rcu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local;
+
+	if (!is_test_task())
+		return 0;
+
+	/* Check if two kptrs in the array work and independently */
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	bpf_rcu_read_lock();
+
+	local = bpf_kptr_xchg(&global_mask_array[0], local);
+	if (local) {
+		err = 1;
+		goto err_exit;
+	}
+
+	/* global_mask_array => [<mask>, NULL] */
+	if (!global_mask_array[0] || global_mask_array[1]) {
+		err = 2;
+		goto err_exit;
+	}
+
+	local = create_cpumask();
+	if (!local) {
+		err = 9;
+		goto err_exit;
+	}
+
+	local = bpf_kptr_xchg(&global_mask_array[1], local);
+	if (local) {
+		err = 10;
+		goto err_exit;
+	}
+
+	/* global_mask_array => [<mask 1>, <mask 2>] */
+	if (!global_mask_array[0] || !global_mask_array[1] ||
+	    global_mask_array[0] == global_mask_array[1]) {
+		err = 11;
+		goto err_exit;
+	}
+
+err_exit:
+	if (local)
+		bpf_cpumask_release(local);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_array_l2_rcu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local;
+
+	if (!is_test_task())
+		return 0;
+
+	/* Check if two kptrs in the array work and independently */
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	bpf_rcu_read_lock();
+
+	local = bpf_kptr_xchg(&global_mask_array_l2[0][0], local);
+	if (local) {
+		err = 1;
+		goto err_exit;
+	}
+
+	/* global_mask_array => [[<mask>], [NULL]] */
+	if (!global_mask_array_l2[0][0] || global_mask_array_l2[1][0]) {
+		err = 2;
+		goto err_exit;
+	}
+
+	local = create_cpumask();
+	if (!local) {
+		err = 9;
+		goto err_exit;
+	}
+
+	local = bpf_kptr_xchg(&global_mask_array_l2[1][0], local);
+	if (local) {
+		err = 10;
+		goto err_exit;
+	}
+
+	/* global_mask_array => [[<mask 1>], [<mask 2>]] */
+	if (!global_mask_array_l2[0][0] || !global_mask_array_l2[1][0] ||
+	    global_mask_array_l2[0][0] == global_mask_array_l2[1][0]) {
+		err = 11;
+		goto err_exit;
+	}
+
+err_exit:
+	if (local)
+		bpf_cpumask_release(local);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
 {
-- 
2.34.1


