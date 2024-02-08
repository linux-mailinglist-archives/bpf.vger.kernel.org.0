Return-Path: <bpf+bounces-21490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC08F84DC6F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743DD2882AF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A366BB2A;
	Thu,  8 Feb 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqzC83I4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44746931C
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383393; cv=none; b=bkJVt6VqrTlinvMvemtyr3T1HIOyCc55w5gO9uWAgom7FECynol7C/7QTWqV64Tmdbhsw9S5QOnFpHfIDLxLgWaeQ6JJrqFG7v7s0xdp5DiN+itIYcTxtl3pr5ioSf7P4ZE6MgjuwTXu3/UY337hqzRjQS3XHujMBcPywSUjp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383393; c=relaxed/simple;
	bh=UgSHNW8lssCl1G9AZjbvSGCwOQyWHiD28zM9BeFYB5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XAfFJ7wurWbNgnlLcWJXUotVkpb8Fsmb6Jhc2T2b9pFlWMVHmw72VeBHmnneTnmgQyCFzBgjvjKe4yfBRvNvegSt38e6nYgJITXLcwmJif39OpDuhtbNFwvQ3/vtI0K55NjPrn/PDEDvWy3bA3Uwm3ZLB6K0lJD4iYZhjKz1KHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqzC83I4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8df34835aso533109a12.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707383391; x=1707988191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YloBOO91rudoAeMOs6kzXhUv6qEy0P5+n2VgX0+i3jU=;
        b=iqzC83I4+TvyscLMBM3tkEq1vTMzq/49g72hkBjDtKydDexy1ZOQT3Wl98fWl1obay
         wTgXQzy8i1tqItX69ZeAypbiPEyRy/T0oIsHeKONOJ520ypVE903GzPgLxl+WstedVn/
         K8R86WAbd2fif8RDUi701MHq7eLWjTZvUvUgFXPcHIAPqA7I4iFbW+4+5/sdGTM86eGy
         75RcZ7VXRpBx1XH0pNR6Bzs5W/S/bU2dDA5tS/6f5/+7CzhUwv/4AGikqnR95207qxvD
         Myv7U3ZpP6embgnn//CLB+ZUQ3PVEasBC9Lr3/oVYtxuOHld8WUQJAqs5TftzN76IEYk
         Xkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383391; x=1707988191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YloBOO91rudoAeMOs6kzXhUv6qEy0P5+n2VgX0+i3jU=;
        b=ptxXNlXOIFXKqyimcvrWx1w/iQbgu1ewKvfBqzjxVxLHk0l0LK0mulwmaquaUTcRoE
         w0l9BLNw/5rz8Q8gHrpqKSTqS1dRDrSq/TGleG3dc32xT7qReDChHTV+aCvh+/hpUr6k
         Umu+Vy+4sh7gC32lbNygagcxoOev1+SYUN4x8c+l8wl7tvNpNfnGRMAPyBGjUPI1whxN
         St9AQRmly5S2kOGYSOwubfH9F0U8ycu0BguERwGBoEKFBMA8VnFCK6I9hoAfXbW5hNSd
         IXj6BERjTXtEHLkmtpFpklULT27CfphlP14RRel5C0TxOOMcV9QeywAeNBormxPfBQUn
         M2lw==
X-Gm-Message-State: AOJu0Yw97UionbhOrj/X8pc4Ih+MafbKOkdriQtIKnpkek6QJTXyRYmH
	ynPHpXvs9hYj/PeWmrPtKyrwJ80abhp33F5UfMXOGPAMVnFFYAq9
X-Google-Smtp-Source: AGHT+IE/mr2Gzl5E5wsnkIlFJyIFMkFDTK7ALA1ZbzjDVl5XynftVF0AsvDOSflbXyZIkJAsm/BufA==
X-Received: by 2002:a17:90a:e2ca:b0:296:1fc8:5e66 with SMTP id fr10-20020a17090ae2ca00b002961fc85e66mr3252644pjb.6.1707383390736;
        Thu, 08 Feb 2024 01:09:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkj4V24dSIQVZyAUpnRKbSXSm/IOk2Q9lCnujpmHaiv2OUPFa9udHASLd6ahGzXn7s+kVfp7yqx5zzY/kVApD0TpyTbkHnHPkww5M5xxu0xASBrMDvye/hF4H1eazhKBFA/5vT3Xt/ZChs7GJBdyyMKzW3YrFpPMBl0ZUjf5QmJo9JSQH1NuCGcKdCUIl9Es3e4HjxCmWwFU/ybFE7UM6BPjXGE2WWfwYG2l1l4CM1pmZAup6V75bcerxR9aOl8ZILYbJBTVj91OJ4PRvSwdgx1z+6NZtJQGY4yXJW7bevWDbGc7e34cz5mKYBkN9euHYol2EoMKirsCKR0ekB31izQR705D2Mk4ReWheSdOmjfLzXwfFFzQNEKe5lOijGs5hK8QdeycJ/2XG+4wIZHtIX2ulrs9v2PNPKP6VI
Received: from localhost.localdomain ([39.144.103.18])
        by smtp.gmail.com with ESMTPSA id gg18-20020a17090b0a1200b0029685873233sm952361pjb.45.2024.02.08.01.09.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2024 01:09:50 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add negtive test cases for task iter
Date: Thu,  8 Feb 2024 17:09:05 +0800
Message-Id: <20240208090906.56337-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240208090906.56337-1-laoar.shao@gmail.com>
References: <20240208090906.56337-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Incorporate a test case to assess the handling of invalid flags or
task__nullable parameters passed to bpf_iter_task_new(). Prior to the
preceding commit, this scenario could potentially trigger a kernel panic.
However, with the previous commit, this test case is expected to function
correctly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 tools/testing/selftests/bpf/prog_tests/iters.c |  1 +
 tools/testing/selftests/bpf/progs/iters_task.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index bf84d4a1d9ae..3c440370c1f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -193,6 +193,7 @@ static void subtest_task_iters(void)
 	ASSERT_EQ(skel->bss->procs_cnt, 1, "procs_cnt");
 	ASSERT_EQ(skel->bss->threads_cnt, thread_num + 1, "threads_cnt");
 	ASSERT_EQ(skel->bss->proc_threads_cnt, thread_num + 1, "proc_threads_cnt");
+	ASSERT_EQ(skel->bss->invalid_cnt, 0, "invalid_cnt");
 	pthread_mutex_unlock(&do_nothing_mutex);
 	for (int i = 0; i < thread_num; i++)
 		ASSERT_OK(pthread_join(thread_ids[i], &ret), "pthread_join");
diff --git a/tools/testing/selftests/bpf/progs/iters_task.c b/tools/testing/selftests/bpf/progs/iters_task.c
index c9b4055cd410..e4d53e40ff20 100644
--- a/tools/testing/selftests/bpf/progs/iters_task.c
+++ b/tools/testing/selftests/bpf/progs/iters_task.c
@@ -10,7 +10,7 @@
 char _license[] SEC("license") = "GPL";
 
 pid_t target_pid;
-int procs_cnt, threads_cnt, proc_threads_cnt;
+int procs_cnt, threads_cnt, proc_threads_cnt, invalid_cnt;
 
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
@@ -26,6 +26,16 @@ int iter_task_for_each_sleep(void *ctx)
 	procs_cnt = threads_cnt = proc_threads_cnt = 0;
 
 	bpf_rcu_read_lock();
+	bpf_for_each(task, pos, NULL, ~0U) {
+		/* Below instructions shouldn't be executed for invalid flags */
+		invalid_cnt++;
+	}
+
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_PROC_THREADS) {
+		/* Below instructions shouldn't be executed for invalid task__nullable */
+		invalid_cnt++;
+	}
+
 	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_ALL_PROCS)
 		if (pos->pid == target_pid)
 			procs_cnt++;
-- 
2.39.1


