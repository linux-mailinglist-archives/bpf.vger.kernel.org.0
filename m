Return-Path: <bpf+bounces-26667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C398A37A9
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F907B24100
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E7155341;
	Fri, 12 Apr 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNDzOdIk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B31514E3
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956110; cv=none; b=M2qVjH2+8PQaM+Fspht/rCdNd1memRRi+KZj8Yia3R+sQUw6JlZK8I+QpCZ8fWSYJOqLT6oykSBBZ5t8yq8DrcPVBY6jvWrZ2mXaNTSA5tZSdfa+X67Z4asquuTDlKVksX3U58VIXrT/xjAsYgnYpg6gIiuNyXPXMp+XbnJgCaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956110; c=relaxed/simple;
	bh=DypjCVY43yhA5fiSymfCfD24cW9KiO9HvaU5WeMouKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mel0wQscHeaN5UmtpVKc/9TIXzpjWxpTjnnLDBH9MUtS3xvR5QuRWVRndqut/ms5P5m195qPIek1tN6TDbAT7JLKB642yeV/enBp8m1z/vn5tgLUdItnihI7DU/CdzoQr3OF0SL8u8vd81ExjhW16UnVAceEgEoNPFEQvKcefec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNDzOdIk; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23335730db1so690692fac.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956108; x=1713560908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCXoxIZdu3IbIezcXli4tuWerfrPR0dwNVTGMo9uTDs=;
        b=VNDzOdIkq+x9mGeRLERSTSFIgh2OzF+t3arbOxZo+/wO4DDuBw2zRKGKf+y0TuqpsQ
         rtyznMNsQ10EDKMqXx6buUvjFz7NNdoV8RJ5qgtBbU6MM04jWTZkyw3N1G5FhbMzobHU
         UZEuHMOfWNP1AP+I1iQSAU/509xqOGjJjbXhJhwiTqrizt5fFYUYuQuxXSoCv5N7ZLvv
         HPUk+p3J7miV1pcka74VEr0n/DQE6PufALLwjcf6psbFpwEBBMFPIJoBvPraxTwygtV6
         H1nnf5gaLhSFdLGs+W0WWKuwUMFP0aKqq7FCNwzyy1PYodX4//PqUDYk678EDg53JUd2
         iGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956108; x=1713560908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCXoxIZdu3IbIezcXli4tuWerfrPR0dwNVTGMo9uTDs=;
        b=MgpypTdc29GjoGXhdADCQBzOSwZcpH/lxhaZHjFC8XSNsTX5az5YBxlwT0Y+jAt28X
         dwobtgAZf9ZxNwg6jYGPZz7Xjln9Ki7yrvpHsV0E78zOJy72RZx8O1xPQxIbHvPCgGW6
         O8ZXhVuIHVzXjmY6sMRtK2TfLY7A+bIwB8XXs1ycSuEUHkpFEK3KPN2NvHIaEC/68ct2
         KfTWWre8nw4UE8s7W0xtowDAJFTyZx4RjuxvU1ZP2i05bfBRnGF87LQAdXX7SIhiRbml
         dD/0xiw5BqpzYk+fyGGfNBvntADWIAB2Nn8u6yU3pfIOcTqzsryZzvYh/VXEE4ovhtSc
         +Ahg==
X-Gm-Message-State: AOJu0YwbK2kh4GmvLTlRDvXwQTG2C6ZYokPpSogxZ3tFcD5xZfnEVvNh
	8bi6RkXZPPPj/eN1gSRxTY/aG7r7fV8Rm8gtzOEgmKBBOM2Q07mKKVW58g==
X-Google-Smtp-Source: AGHT+IFJmX4GGhdtvZJs8ItRxeeTrOdyyAooH2GE3Fy6oyarkGCwZlktl6YEUjvyzwlefXk7LDWn9Q==
X-Received: by 2002:a05:6870:e40b:b0:22e:c8ea:ca06 with SMTP id n11-20020a056870e40b00b0022ec8eaca06mr4444199oag.17.1712956108336;
        Fri, 12 Apr 2024 14:08:28 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 09/11] selftests/bpf: Test global kptr arrays.
Date: Fri, 12 Apr 2024 14:08:12 -0700
Message-Id: <20240412210814.603377-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
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


