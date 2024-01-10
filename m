Return-Path: <bpf+bounces-19311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC1C829385
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 07:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0DA1F22005
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 06:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306032C68;
	Wed, 10 Jan 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJpvh3Ma"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0266FB8
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b9e9e83b0so2101808a91.2
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 22:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704866445; x=1705471245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS8GvLbbeGDbJvqofqy/MGxYvoochU4qZXHFlO0ftOs=;
        b=EJpvh3MaiI1O6cqosESToL0QJvh4Qh/1UhjrMlee/5dQ+0yTKQ+Ddpt2uAyLkLpBwS
         mZVC4E45cp4GNclP3sZTEmyxsv4gqezyW4d2Xf7EqntLkkJouHOh++NKduNqNDlggNYC
         vbmtUxm9YsP9ictLRTNAO910BVz4frIpN3sdqph099HL1teGeTF7YcnjAcq+KsUvlYVU
         hUe8nhbZ3ER2CihF/n0UIXvn36UxCCtC/tDzLl1ZjQ+Ew6zAtpHUkbTqNNhK5gClV9/T
         jBhCeG1PfX5uS9OGctwKkrChA6DbZNyxCX4qCpYxhJKO0RGJvoCcgEWxGr+aP/qH6wjA
         D1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704866445; x=1705471245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS8GvLbbeGDbJvqofqy/MGxYvoochU4qZXHFlO0ftOs=;
        b=k6yiz1lbWkWG6JqEKpdZFgxupF5YWIGgeRSFWhYj9x8A/rO4XUbuAruxluzKflZScH
         b8AD5Q+dqgD8ZmVVeCy8U8jHGgRej55TV0mrD8M4BA5S2CjsZAdiOLSutWfkteXyZHAx
         xamR6h3lns5Z3vWYZmR+szWPLotKB6iK0q1wNaHFimoA7sgV3pgXk+lBO/v6t5iheiOT
         ULm28XLkU6aPjUW5tIZpGQkQ4/jrj3IemiJEiThDD96WNb1HohRJIsNmCz7FgjYjr8VU
         /8OY9Dnxtd3uQdUXEdmJDZvlsihKUJRw/wV19z8TjBwuHoFe9QbvKUMhxZ41CQ5AhDGj
         65VA==
X-Gm-Message-State: AOJu0YzCon5P6ozc9xyxGa8NDhGNOC4u8cRNNnqOibLH64KqU7Qe4ZX7
	Vb8TkpQELtwWkyIsQ/armf4=
X-Google-Smtp-Source: AGHT+IHVGYuIVLfUfIt42CR8x7Z+EiLMu7bPdJwStupgTpoWbieRVe5rTjfi3nFHbKLAG4hKbwqSUA==
X-Received: by 2002:a17:90b:fd8:b0:28c:ef28:b451 with SMTP id gd24-20020a17090b0fd800b0028cef28b451mr197251pjb.83.1704866445301;
        Tue, 09 Jan 2024 22:00:45 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id sx4-20020a17090b2cc400b0028ce9c709e4sm540923pjb.26.2024.01.09.22.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:00:44 -0800 (PST)
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
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: Add bpf_iter_cpumask kfuncs
Date: Wed, 10 Jan 2024 06:00:36 +0000
Message-Id: <20240110060037.4202-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240110060037.4202-1-laoar.shao@gmail.com>
References: <20240110060037.4202-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three new kfuncs for bpf_iter_cpumask.
- bpf_iter_cpumask_new
- bpf_iter_cpumask_next
- bpf_iter_cpumask_destroy

These new kfuncs facilitate the iteration of percpu data, such as
runqueues, psi_cgroup_cpu, and more.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cpumask.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 2e73533a3811..366ebe604b1d 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -422,6 +422,72 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
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
+ * @it: Pointer to the newly created bpf_iter_cpumask structure.
+ * @mask: The cpumask to be iterated over.
+ *
+ * This function initializes a new bpf_iter_cpumask structure for iterating over
+ * the specified CPU mask. It assigns the provided cpumask to the newly created
+ * bpf_iter_cpumask @it for subsequent iteration operations.
+ *
+ * On success, 0 is returen. On failure, ERR is returned.
+ */
+__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, struct cpumask *mask)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(struct bpf_iter_cpumask));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=
+		     __alignof__(struct bpf_iter_cpumask));
+
+	kit->mask = mask;
+	kit->cpu = -1;
+	return 0;
+}
+
+/**
+ * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
+ * @it: The bpf_iter_cpumask structure for iteration.
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
+	struct cpumask *mask = kit->mask;
+	int cpu;
+
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
+ * @it: Pointer to the bpf_iter_cpumask structure to be destroyed.
+ */
+__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
+{
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
@@ -450,6 +516,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.30.1 (Apple Git-130)


