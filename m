Return-Path: <bpf+bounces-20825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295718442F9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6ECB3227F
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C412F596;
	Wed, 31 Jan 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7duCC0B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5E12F587
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712937; cv=none; b=A23OM+E8aiLQwC9ZqTsiVq49okEhpT25NW1jsS2/Vzk2hbtWTm0Ov03mY4kuqaJFz1+tgfID2YjEnhjNvmK9rZph2lAqs+LYcrChhZFSyZKWRXkjs4xCOcm67hCAg+w2rtnKJdPZon9+IMc/0o0h4P8A/yU1FhPpIpoIZr9VA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712937; c=relaxed/simple;
	bh=SV/alju8O5rBWg2UnQnqw7IiLPn/TxUJ41GVbFTyf4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhmelPKtHPFvijmjZCiKYEvQHQQyMTxDzSdKPDu07PT8WtMZ3GfYEFkqbeBtZ/bwo6pzweIil2gsVUVG8spyIkI6m3sRnwVmobXc0bMMrxIda5nxbWLeNj3sWLmvCN0QhwQ9Rtvh+nasY7Uj568tvHEum4u/MWqMlzsx9HuR2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7duCC0B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d70b0e521eso37298705ad.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712935; x=1707317735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJRiE60KIROO/fALmRIpLzxZTaCorFhBQTkcmFOCFCI=;
        b=T7duCC0Be+Bg+g8faX/7ZE9OhX2fZSacltNWZBCr91KvTd3QuxudJOLVM7YCMGv6CJ
         0sD9WFxOlFVnrRv+dhtmQJKzsfK6f8PCuyn/P20bdQZALgD/1Fdgvsr2xKDZjaoOHI02
         3dKBXS6bMMDnmTWIlueE42vdFP3Tan1b7KPYTyXzrx3dZRN1IPDDoghKfasL0/wRXdSo
         FKt6eMYHYL2zRw5/oxlqqASwOOESeNLOdIGSpGt8s4l4g+V/sGSmBY9ijrsDLhhYpoET
         SfvcAC4WqXzHXBdWG5p8N9z8NQdjOQo/gOzpkenEwKRDZ6KxG4G3lMiRKJYVdkfeR8kR
         3sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712935; x=1707317735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJRiE60KIROO/fALmRIpLzxZTaCorFhBQTkcmFOCFCI=;
        b=FgeV29iA2R1DmaBIw4HC3QzqpplwJk62+f1wH/WwBYoyE07UIyir1ozBRhPuZA68j0
         lgYg/N7XKFQCgUjwPxeIxsyUG11a6HvF/SqcQMs5HDNUwoCycBi6i22GnyasC6qzfT0j
         X5dw9O0CVWg8kr2If0XabOdjfKxfDYLQjSHk3orsXtHqR2Y3OtLfRNIFiEfAjw8vzEgt
         mUl8ZhVrPj5rEapNbRMMifMCcPt2EvKdG/+EbZz/TWi5O0+sCcN2qpCE0w/kukYmuogA
         2fnnc6eYnxW8Gsmb8pZQxBJQ6TuhPAbOMlZzUjfy6NxV925r+zUWyOewlx3sVtWTGCE9
         qn6Q==
X-Gm-Message-State: AOJu0Yza+YKy6BD2bMcnhxbuwNwKeTsH3HpEYz5RYmN+DPqOT2+h2pwR
	yWwwB1U3pBK2WYzQoC8JMTe8hF+7Qo+VUl/6/EM3xSQtQUCOyQNM
X-Google-Smtp-Source: AGHT+IGbub3XqlbAoeJVByIc2rBgT48fA193T5TVQRWPHoeuHi3pIhtFZlwGVhP9nWE1J93dcwACAg==
X-Received: by 2002:a17:902:ec82:b0:1d9:55b:6a17 with SMTP id x2-20020a170902ec8200b001d9055b6a17mr2421501plg.18.1706712934897;
        Wed, 31 Jan 2024 06:55:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV5VVvoAn+a6x8Ee8D/mwZSJvaRAnlQrcUaLqhT8qnecMo5BSQwtx/E6eiatMqHLHnIwkAjxwfPvOEnn1ABGXA+1H1FXLQFev9DO61xogKyK+i+mQxsknC6qTs83hMNTQjZvyV4muw4F/i2Ydp1avx8PzltjYnC6cMKBkkKl5SJFAmx/L1PsrDpfBKQUZbEAdkUQMSe59IuNDR+EnFUXkka9xEcbvH5DS2D7oiLA2WE36xXRA1sWY5aCm/om6O5rx5haAi6O14j9Bt3E3WTdTCkeV9ihiuk3+ZX6lSVlP/nCscGSHVSD9ctUyhGYMRF87GPpB+hrerdsaBmPMSPQLWlxTZFtjAM/l6EtRkrXuwdcvkNgMjuVzoTXLanQ903Ttats2fSbMz4tOl+qR3tVCNej6ra
Received: from localhost.localdomain ([183.193.177.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902a50500b001d8fe6cd0aasm3901335plq.286.2024.01.31.06.55.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:55:34 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 1/4] bpf: Add bpf_iter_cpumask kfuncs
Date: Wed, 31 Jan 2024 22:54:51 +0800
Message-Id: <20240131145454.86990-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240131145454.86990-1-laoar.shao@gmail.com>
References: <20240131145454.86990-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three new kfuncs for bpf_iter_cpumask.
- bpf_iter_cpumask_new
  KF_RCU is defined because the cpumask must be a RCU trusted pointer
  such as task->cpus_ptr.
- bpf_iter_cpumask_next
- bpf_iter_cpumask_destroy

These new kfuncs facilitate the iteration of percpu data, such as
runqueues, psi_cgroup_cpu, and more.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cpumask.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 2e73533a3811..c6019368d6b1 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -422,6 +422,85 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 	return cpumask_weight(cpumask);
 }
 
+struct bpf_iter_cpumask {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_cpumask_kern {
+	struct cpumask *mask;
+	int cpu;
+} __aligned(8);
+
+/**
+ * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a specified cpumask
+ * @it: The new bpf_iter_cpumask to be created.
+ * @mask: The cpumask to be iterated over.
+ *
+ * This function initializes a new bpf_iter_cpumask structure for iterating over
+ * the specified CPU mask. It assigns the provided cpumask to the newly created
+ * bpf_iter_cpumask @it for subsequent iteration operations.
+ *
+ * On success, 0 is returen. On failure, ERR is returned.
+ */
+__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpumask *mask)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(struct bpf_iter_cpumask));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=
+		     __alignof__(struct bpf_iter_cpumask));
+
+	kit->mask = bpf_mem_alloc(&bpf_global_ma, cpumask_size());
+	if (!kit->mask)
+		return -ENOMEM;
+
+	cpumask_copy(kit->mask, mask);
+	kit->cpu = -1;
+	return 0;
+}
+
+/**
+ * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
+ * @it: The bpf_iter_cpumask
+ *
+ * This function retrieves a pointer to the number of the next CPU within the
+ * specified bpf_iter_cpumask. It allows sequential access to CPUs within the
+ * cpumask. If there are no further CPUs available, it returns NULL.
+ *
+ * Returns a pointer to the number of the next CPU in the cpumask or NULL if no
+ * further CPUs.
+ */
+__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+	const struct cpumask *mask = kit->mask;
+	int cpu;
+
+	if (!mask)
+		return NULL;
+	cpu = cpumask_next(kit->cpu, mask);
+	if (cpu >= nr_cpu_ids)
+		return NULL;
+
+	kit->cpu = cpu;
+	return &kit->cpu;
+}
+
+/**
+ * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
+ * @it: The bpf_iter_cpumask to be destroyed.
+ *
+ * Destroy the resource assiciated with the bpf_iter_cpumask.
+ */
+__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+
+	if (!kit->mask)
+		return;
+	bpf_mem_free(&bpf_global_ma, kit->mask);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
@@ -450,6 +529,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.39.1


