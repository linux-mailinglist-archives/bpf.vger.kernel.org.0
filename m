Return-Path: <bpf+bounces-22207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11031858F2A
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 12:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E631C214A9
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61569DF0;
	Sat, 17 Feb 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+xMLNTQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F663407
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708170134; cv=none; b=Tc0QLhqN+grD4LAcCvnSReZkOlMUr2xBg4xABzcujDYIFgbWqUB+OtyhU5hEKgDY63v/AdCPDYDc4pcsvtLgJ3M/f5GAPVlvAFiE/VjAlM/c5EqzMg4Y9tcKl1U/OFM/u/xUY4OtnLke+hY9KOk9DoetQtae0IKrNbNuI1vGiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708170134; c=relaxed/simple;
	bh=UgSHNW8lssCl1G9AZjbvSGCwOQyWHiD28zM9BeFYB5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltlHnqORNbmEi3btT2I+xlnvZidhgWotkysTNfV7j2kf3ngV4Kvfb+ZKYFRUiNvF5T/6R9YSJdyy51gNQiNRAdt36ef59FW8l2MuMDx99na2VI3xYwdZj4G7LWJZKZRKhRQ4EXC4t/MvFwF9/rlZO4JCBA9p1KQD9VpT697fhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+xMLNTQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so2135626a12.3
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 03:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708170132; x=1708774932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YloBOO91rudoAeMOs6kzXhUv6qEy0P5+n2VgX0+i3jU=;
        b=l+xMLNTQKWv65yX26EJu0H3Aiq85/tZE2IR1Amq6LGZqh1BikQ/oaZ/lrqoQ0jmxAt
         KRBVO+tgZiaekcywa6QupM2b3dwSXvvVVOAhQOEpL2IZhtGYs4PbxZU9Bx05YdPQvuG3
         q/boZqzZERi0QoG4MHeOySPszW2ddy2bmYH5yBW10kHrikA/UooS3av/ReHm5S+R3d8K
         Bo2OrNstgPKJH3uoP7vaEQXVpCjFZRR0cjt0Yi/LPKMF6MD9/13G+CrBOZOER0bu3cb1
         JdpoFc0nUYX023p0hwazoTKHDdP73fwVjLvN/UAID52SbiEYYkE0sDubPxA8tEYvJZk+
         OSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708170132; x=1708774932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YloBOO91rudoAeMOs6kzXhUv6qEy0P5+n2VgX0+i3jU=;
        b=MOnTKORYIZhiThcPBbCTA8E8W152neAOo7afxz+Aalf1jMlYec4dqtxWwx9XkzENqz
         RZQl3GbIIRYp+ito5Ei4LFAn2gdNZkkARlGHvtK698sRiYJ6ZNL5FShA+cKBtwwGI7RS
         k1WiHehKG/jxIgnh1Kc4JChHUbRT1RtmFx9F2W/JNq901DCD0/z+ym21fLg9BF2BsS4u
         ilLmQzLoDcpvFgsOs11KzkXiG84Kya5K997j7tEMDE6wvQeZjdzSkoboOSi8SM/elCmb
         nhzVxp2n5olIAg999WCXk5GSXNQdFl3QdHTSrewu9XMz0XxdT8PmpLkVfsK1BCGVmx8B
         hZOw==
X-Gm-Message-State: AOJu0Yy6tJJEdBy0/Q+EAkiq4FdShS4AYwKhRIbHgAd5bvCCwoB9kwHb
	PBXt84tb644SDCx78O9oPt75qvKsr159r29daJ8CyB+hx6akXFxw
X-Google-Smtp-Source: AGHT+IF/yoqSp/2RH0+qFwygpin4L5kwHoBYuTDn4Av3jI5DpmmcXUAOYAlaypFCt0gkKWi9JbHe8Q==
X-Received: by 2002:a17:902:c949:b0:1db:d13d:6bf3 with SMTP id i9-20020a170902c94900b001dbd13d6bf3mr607597pla.62.1708170132631;
        Sat, 17 Feb 2024 03:42:12 -0800 (PST)
Received: from localhost.localdomain ([39.144.45.19])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902f21400b001d8f6ae51aasm1307201plc.64.2024.02.17.03.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Feb 2024 03:42:12 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add negtive test cases for task iter
Date: Sat, 17 Feb 2024 19:41:52 +0800
Message-Id: <20240217114152.1623-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240217114152.1623-1-laoar.shao@gmail.com>
References: <20240217114152.1623-1-laoar.shao@gmail.com>
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


