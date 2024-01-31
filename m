Return-Path: <bpf+bounces-20826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EB844274
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C2C1F2B4A6
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411DE12F59A;
	Wed, 31 Jan 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwuHe6I2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195512DDBE
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712941; cv=none; b=nkvNLb0RDLTtNBKRp5BJA5VHY71SjdYaRIXsl/XA9wQDMz152oNItrI/5p4MleqBYZpHZm++KUw3X9z4N1LawlMNQr8jw1C1dCxDgEUlzyk73qlpJl/p/VV9PGMDX5kv8vYrZ2uKUW5qa8u1KiFDf9KuokFd9FU+XdT/P1sx74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712941; c=relaxed/simple;
	bh=HV8zE7fC7esadDPJK8IeoUfZuj4hhuaCLWwcNh2tp/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b43BipUkAHz+i2+AFdhbXFsANOmL+Tu86EcgjauzSMN3HcMQcmzCPa7Ti8wURPg1AJYUFru1nEnh1Z4J9IHniB5jRL4mVcp5CTv8D9iTtCAEegOAFX63FWKvsAhlpy37XdkaLfeKqcbPeIgQMxR3luCOiQxgxzxRwC8gbGHfOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwuHe6I2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d918008b99so11836615ad.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712939; x=1707317739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlM6tuTN+NL34agtMlc0l/gUFiWkbI8BqHZCZ22lzIo=;
        b=VwuHe6I2+wKO+hc8k8viUNkBv4a2qOunIzrao36HgcyduTjChw+oXuBTueGoOR4qLi
         WyZWyNZfIAb9KjEv+Uzn9GiLYnv3rO2wA85Nbt5ELZBw51oEaLsw/3TnIIF3als2hodr
         LdCzdYel98rH7ysOHG6vNnMkd+PyHwhx1d2WXiH+GV4sf4mRXQiCRU4JhJeCiSmzzGdz
         Hma6xQUNW1bJv/aPTFe4AuyEyaW/VCnJMjepJ1Dbjzxkf+BHYta3d2FxLTwFUMrH+dQQ
         ZDr1Rx6yQLggH0ZWr1wWyvf3R5KiCuKvpikOdOJwqValgSPrdA9g0VLyC3P1whTLteTX
         /37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712939; x=1707317739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlM6tuTN+NL34agtMlc0l/gUFiWkbI8BqHZCZ22lzIo=;
        b=dIm1x5VeguFplIXSlQPOYNPrlznGfde0vjaJ9nK2nYGEMUGUDNmDWk+JTn56rm/Ovj
         hQy7vrRGpucDVkpwJ8fKmO1UwaDmOtnYvJLiervviqiEKHXsAnkgTDoTZMJ27zSAFhcJ
         2yhGbjMl+HJt+x5qpiYBR3iZx+2I/6N5MskToGtevRdYm0NkJmWJKOIeGOa+TPCWM19O
         Nv4SLb/Q2VPnZj/CBwUzZBXfDznlldyiQ5XGKsoKgAnNKG4wYfgsIqYMyVwSd+IM4Gok
         ioAIpoUIFEjDApvo6PC5fciGuE1BjikpjICp6eVSmYbdpWJzaH+7wTWX+Q+PVVQ0XDss
         zcsA==
X-Gm-Message-State: AOJu0Yz2YvviRHdLsrnp/22/QTieqYOQ/QrPLjJq9JUx8wIbl8joKJ2Z
	jQU6+vEyr5I8r5WpFBRPXA4YZaq42KPWblwmHGscvB0yRmCSz0Ad
X-Google-Smtp-Source: AGHT+IFVXBYWAjado0VmaeEJ/cJY/PU3kBrUI0MSG8RqhFs2+HfWIueR33o2o1AubOlRc1Toq0BfmA==
X-Received: by 2002:a17:903:41c9:b0:1d9:3d72:b296 with SMTP id u9-20020a17090341c900b001d93d72b296mr673384ple.35.1706712939574;
        Wed, 31 Jan 2024 06:55:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWa7LvZOpYtqTuThTfyh+h3cWraMODUEpQxZP6hZhJrXQIGdtZpCMKWJ4qLl6cHA0NDQWzKXZ4AXu/ulmVA6ln4h6bFc6SSXNnW4u7APEGATE5h0IcPaES4pC3fie578ZUtFcF55jWwyoOeyIwX6fxsyg2aFMfoVWH/GZyit1eeWlOEwZTsJ1cuvbqk6UHCzQHLQK1PXK4goVJoY+tYWmxFTpogAL29C0VXqXUcdSAX/rnx+F0GBDSLKf8UcxdppQ0MjEZOdh1A82JSc2jGSOvMCo/MthnwW53ojmsmeUAZOiVgmh0se5KFHrIwziKg8XJWd48mijWXQVmDNX2jxPwBcVjajCx3HEPzinYo42rfsiqealgqCH7ql6DzI+/MitXWaj1QH94Sk5THaSCM7c/U4+mk
Received: from localhost.localdomain ([183.193.177.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902a50500b001d8fe6cd0aasm3901335plq.286.2024.01.31.06.55.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:55:38 -0800 (PST)
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
Subject: [PATCH v5 bpf-next 2/4] bpf, docs: Add document for cpumask iter
Date: Wed, 31 Jan 2024 22:54:52 +0800
Message-Id: <20240131145454.86990-3-laoar.shao@gmail.com>
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

This patch adds the document for the newly added cpumask iterator
kfuncs.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/bpf/cpumasks.rst | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.rst
index b5d47a04da5d..5cedd719874c 100644
--- a/Documentation/bpf/cpumasks.rst
+++ b/Documentation/bpf/cpumasks.rst
@@ -372,6 +372,66 @@ used.
 .. _tools/testing/selftests/bpf/progs/cpumask_success.c:
    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/cpumask_success.c
 
+3.3 cpumask iterator
+--------------------
+
+The cpumask iterator facilitates the iteration of per-CPU data, including
+runqueues, system_group_pcpu, and other such structures. To leverage the cpumask
+iterator, one can employ the bpf_for_each() macro.
+
+Here's an example illustrating how to determine the number of running tasks on
+each CPU.
+
+.. code-block:: c
+
+        /**
+         * Here's an example demonstrating the functionality of the cpumask iterator.
+         * We retrieve the cpumask associated with the specified pid, iterate through
+         * its elements, and ultimately expose per-CPU data to userspace through a
+         * seq file.
+         */
+        const struct rq runqueues __ksym __weak;
+        u32 target_pid;
+
+        SEC("iter/cgroup")
+        int BPF_PROG(cpu_cgroup, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+        {
+                u32 nr_running = 0, nr_cpus = 0, nr_null_rq = 0;
+                struct task_struct *p;
+                struct rq *rq;
+                int *cpu;
+
+                /* epilogue */
+                if (cgrp == NULL)
+                        return 0;
+
+                p = bpf_task_from_pid(target_pid);
+                if (!p)
+                        return 1;
+
+                BPF_SEQ_PRINTF(meta->seq, "%4s %s\n", "CPU", "nr_running");
+                bpf_for_each(cpumask, cpu, p->cpus_ptr) {
+                        rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+                        if (!rq) {
+                                nr_null_rq += 1;
+                                continue;
+                        }
+                        nr_cpus += 1;
+
+                        if (!rq->nr_running)
+                                continue;
+
+                        nr_running += rq->nr_running;
+                        BPF_SEQ_PRINTF(meta->seq, "%4u %u\n", *cpu, rq->nr_running);
+                }
+                BPF_SEQ_PRINTF(meta->seq, "Summary: nr_cpus %u, nr_running %u, nr_null_rq %u\n",
+                               nr_cpus, nr_running, nr_null_rq);
+
+                bpf_task_release(p);
+                return 0;
+        }
+
+----
 
 4. Adding BPF cpumask kfuncs
 ============================
-- 
2.39.1


