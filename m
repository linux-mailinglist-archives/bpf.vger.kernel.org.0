Return-Path: <bpf+bounces-21292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62184AFB5
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 09:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96F21F21A85
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206E12B14C;
	Tue,  6 Feb 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aan7Sb2f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B7C129A65
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207308; cv=none; b=YFYsojANf246Vtm9HYm608F45RV89tb+6+BLvJ8I6iPMWMUtSpuNy4di+/u/3e5PDm44SEJ/bk3isS2PPwW//3Y0vXM1ZFkrl/wND91fRmh5Ql6helYQQdDIe7dd7jWbo/6A/TFVBeDoyVCwei29vprwQyFuR/uodje85HFSUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207308; c=relaxed/simple;
	bh=N2+OfDASSUkYC4v52Y0rIqaWTwox1VG+qGu5cFGHnN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKE4r2vnAjrLCKkHXuq5vZ/NQa0Mw6hUr5JFNfowJp81/q88Kuhvf65sI5rNxU5stBI7+5RUNvRRyareTHwWK2MWW+orhYLd2J5MVHCLiOkCewbedSt27yhXRyQYzaOqNX32pl1h1pSpZXCvfhWOZqeXTYTu7F+GLE2kCftwCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aan7Sb2f; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5961a2726aaso3105368eaf.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 00:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207306; x=1707812106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE0q5tBiZvTz92JBreV2ZnEqPmGuVdzUjDYXOxGofSw=;
        b=aan7Sb2feA3nLudhNGHtO9CurkuayYVAgquFxbqBAwzB9bBS28A2TSi8gtSPEvKf9n
         yK+WZdLx6EqF4stRFTSPbL6g6XvFxoMdtTCSNRYiQDMrr3o8wsPD3IUE4kjw8I3j4ZmO
         PeasGiFybrddH00ksXzeQ/7cGvZBfXtBAxk71IgHarKlDAIyo0BBo4YwcpKm0C/Fbuf4
         6nR8v+cu5QNDcW9kY3x7nKqnfbbChl+BlepCPNQAhzZ6ISrqy7O3IGGQTBtckfAEMqIW
         cDjDvLKw9ImtIbdzcXdEvaXNKYITW4j0jKxw/leJORKmK8EuDiJ+jhtqAUpgO5U1oyrc
         gORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207306; x=1707812106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iE0q5tBiZvTz92JBreV2ZnEqPmGuVdzUjDYXOxGofSw=;
        b=wy2h529QLQiF+Y23/ymnjQSPsH1nB4/qMg6PyilTEKmNxvzNxOKU+z2Kc+EQwTo0r3
         yUH+5EMqhJ/9LOocxYPiuVstRAC5iq0rpskestWWRcurk2xr7hcZwI+/R6DheeUUAz7i
         1htSYtbj8MiMu9HyGx3tEd7UaXpPATby6tPtUzJ6c/rgHs6kCwbOexw+vqRoEd6g5UCT
         Bm/rjPaQEM3JhKUG3xI3bAFMp6neiWviTCFWSwOkLqNMVeerMMkPmSKrWRY5PS5Se80C
         dedx8qp5o/KZuYWWmth5t9qna3t2F9XJ2YmkS2C6W6tGno1qfTCdAIvD3qtC1+pYe/zM
         JlaQ==
X-Gm-Message-State: AOJu0YwdOK6YDkLuAdUfELoT6JxnA5pVcqqJZV5zYDK/bfQOQbhMXRC6
	bMDWiHMWZbH3ibl67FNN3RXNnnV7hk0ag0pdyM840Sjvu3WSqY6p
X-Google-Smtp-Source: AGHT+IFDHS2TMqmI4fRgXhv1ncvNpqWR7f0pNyN5K76Rs8hqvczo2qJ7wJh6IW+Z4sqPtUy4uSVnCg==
X-Received: by 2002:a05:6870:e30f:b0:219:4426:53ca with SMTP id z15-20020a056870e30f00b00219442653camr1763556oad.4.1707207306093;
        Tue, 06 Feb 2024 00:15:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXixA90J/n5xdB7Ldmg8k/tzBeVu4WMKpsL6by2O/XGj1Z5Tain3D/Bjc+C2faslMtcNJim0ciNYCdCRE9kwyc6Vo5doCrepJUEPhh42zLWrn4l4z2Esgy9VjM3pTxXPb8SX8KCg202wMYqXC/hwEzBgYf1kFD/6QnjwqPHKB8cTlIp/vLC3Lyc2V34Vpz4wuCELG9p510Lb8iAfCkYGfXf5071SOj3HkVvkNwFCAZAFEszTSD6YU133+SyHGMX/yVXYIJNb72wq8zGLk6yvZVJ+TQxQESNHRh7UPjrowcUkoWfXKnaM9OOIdv2sSIJYkZZNfhDggFK9mTh8rN65D9PQ7wjoJKEC6baU2YR0vn9C5s+VmqYf4S31ryBVIuD5JlWbj2m2Ijoedr0rRnaBgMy82ow6DYbg2WoybXfa5PXRd51pkz05A==
Received: from localhost.localdomain ([39.144.105.129])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005d7c02994c4sm1381660pgm.60.2024.02.06.00.14.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:15:05 -0800 (PST)
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
Subject: [PATCH v6 bpf-next 2/5] bpf, docs: Add document for cpumask iter
Date: Tue,  6 Feb 2024 16:14:13 +0800
Message-Id: <20240206081416.26242-3-laoar.shao@gmail.com>
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

This patch adds the document for the newly added cpumask iterator
kfuncs.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


