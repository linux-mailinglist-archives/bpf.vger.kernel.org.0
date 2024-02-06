Return-Path: <bpf+bounces-21291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB784AFB4
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 09:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243BB1F21C08
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE31B12AAD3;
	Tue,  6 Feb 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOHjQHk8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13372129A65
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207295; cv=none; b=gSd5LRKXbDykDtFRfnBlxtcjuo13Dls5xyJ03ajGIUP1VR+w/WMIhYvOoFb1v3++jc2+1u9dhRKIsUgOfmOwpk2qalFKOomDEWEJqjOFoCauCLh9Sc/DSiv2+u4vdw/f58sqFA987tGN8kdsXjfnTMoA+bSjH3xS0si2FYsE258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207295; c=relaxed/simple;
	bh=lcbLJ1orewuBSkMenb5BgjRxDmygmGPKl6bxMmSn81w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EUf5hDwOgQX9HI5Ug/F5WoxXhYzgZk7S6t4xVfkBpYzPPkQSfr8iqXKMWavHidvjUhtN/n0SB/Ds/8CjnlGMbNeVGAPtJ2BrTLgB+CALa1Wq8vqEq79cxOAxYoWq6yHnCSdo5GcdFYtfdy46mVnM3LrcV42STx3mm5oVFzLyHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOHjQHk8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so238830a12.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 00:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207293; x=1707812093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOTZXeoZhfUUL3cXZa8MjKcdeM1tbf5usBwd0h2B3GE=;
        b=JOHjQHk8BDb2xVYxCJDlTkHbm2607Y7O8eyVGb97Gc7seDvqWu2rH54CGlhNA9DY0c
         ygqBs+tmwq/9KXyyTXk+gYtnOdu6dkcXl8cA2wAFTf4tKjaHjEYw7iepKc6B2bm1uEM3
         7uWfSPYALUWQqETiS/RWmqlMNMPx0g9k5EXymvSAtkJcit3FdUgtajaE+F+sxS9eZTeT
         EJd7rWyKxBDDnX6+LTSHCOU6K+DN+XXy3uFPK0eB5DqdRcSkBxd9z1a0QII3Iw/8aqsW
         OHo2NZuStKGKgn8yBwiOWpI14fsegwxkoSUa9wl8Vea3iIEG21CZuxl3MM/p1LZUNXcz
         YD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207293; x=1707812093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOTZXeoZhfUUL3cXZa8MjKcdeM1tbf5usBwd0h2B3GE=;
        b=wC7B+cvoT4CqB76V40qMHiuZEbXsFCrmR4Zmne2cEBlP5UUll3Sbi59wP/fUoxxWZX
         rfJcHal1ooxm9M8yxZpcnMvqrzlu38rXVEiOdfW5uqeH4QuKIjaGzGr06XXw5jTdY1/X
         lY6mw5G/2VT6ebuWKbaly6QU15NdgRjc9FaTiNomBDZMrHlDJhdQ602xhQLl6n7HM8nC
         NMDHlCCQLlcpyRNzDU1TBQtlwUifv4QAQ6t4kjszij6fie5+2y3kTAvDzJWTaJbYn7Rk
         v6EsKCjmcdSC6whUXgiwElG5490N7zntffdWHoDTQjLxiprWg4AadnXD0r2OqRTnZdVp
         wQzA==
X-Gm-Message-State: AOJu0Yw1wfgrGOFh0W8VeWTZrP65MYSR27v9CLW73gIzxkJTQgmK8FzW
	YAikV8IHBbVdiNxOTTwqtUVmlyVuCnSA6FtAnLGVKCdH9jIFV7Cc
X-Google-Smtp-Source: AGHT+IEh2U0ykbLU/g3mVA2Aocy8z6lycqpxFBQsC3hHexq5xoLoJnoA9dtGWodmR5EoslTqROOQJA==
X-Received: by 2002:a05:6a20:3c89:b0:19e:858d:c677 with SMTP id b9-20020a056a203c8900b0019e858dc677mr975193pzj.31.1707207293231;
        Tue, 06 Feb 2024 00:14:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVjM6bphcvtEAe8WJX+xkWZx2xhx6czmIpK6UUSDBLaSlRCvEV7PsWU//a4mre+DilOFztuCypGt4vM3dKlDhHLH04le1q+7Psc1kwvpaYBo/4JkCUNSQp1x+n19ocfPHiUvqgsmnGkMPgABZ/R2pQO+PuGx0sK25ZpfKm7uaUErZZ7vHbqFFpnLdfEYbhpeoSBB0UW4edDp9zKvPz6I4vSEZyFTELgIXECHR9hU0rmosFWtUu4aW3osGnY6TmOAHAc1jeQpGDT6TpCv2AfQiJyuFzKrft7+Qw4isfKP3wEqLl0GSp2AFUrhJz5MTltE5Mr4G2pYo3tHtToZWDtLIZfwSrS+08CuZcvNqMVPyIEwPEk+mTiUkXTzL2eJFcTqT+ppsPrIT0couENKG+XnrV3cA7dMPsTaCR6ZI4mB+QvBClqqyCoFg==
Received: from localhost.localdomain ([39.144.105.129])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005d7c02994c4sm1381660pgm.60.2024.02.06.00.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:14:52 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
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
Subject: [PATCH v6 bpf-next 1/5] bpf: Add bpf_iter_cpumask kfuncs
Date: Tue,  6 Feb 2024 16:14:12 +0800
Message-Id: <20240206081416.26242-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240206081416.26242-1-laoar.shao@gmail.com>
References: <20240206081416.26242-1-laoar.shao@gmail.com>
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
 kernel/bpf/cpumask.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index dad0fb1c8e87..ed6078cfa40e 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -422,6 +422,82 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
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
+ * bpf_iter_cpumask_new() - Initialize a new CPU mask iterator for a given CPU mask
+ * @it: The new bpf_iter_cpumask to be created.
+ * @mask: The cpumask to be iterated over.
+ *
+ * This function initializes a new bpf_iter_cpumask structure for iterating over
+ * the specified CPU mask. It assigns the provided cpumask to the newly created
+ * bpf_iter_cpumask @it for subsequent iteration operations.
+ *
+ * On success, 0 is returned. On failure, ERR is returned.
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
+ * This function returns a pointer to a number representing the ID of the
+ * next CPU in CPU mask. It allows sequential access to CPUs within the
+ * cpumask. If there are no further CPUs available, it returns NULL.
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
+ * Destroy the resource associated with the bpf_iter_cpumask.
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
 
 BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
@@ -450,6 +526,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.39.1


