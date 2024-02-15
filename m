Return-Path: <bpf+bounces-22107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A0856F1E
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 22:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF411C225FD
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 21:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97D13B7A1;
	Thu, 15 Feb 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YZrEj8E+"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424BC13B2BF
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031562; cv=none; b=OsFwAk5wAKaM3I1MygRcOnF9J7nvZejcqMaDNfOGb3ZZw5/uPulyfZxGKWc9BwRgDy6odin+Cf9pmwwUtcw2vO6wpaKLcSRtPXCqndw/OCOAMNPtqNDP1mHtosKxG1EnOAWYADnrx+CE4/x4TTb7vpUGpVnqHcrfypK09Sf7vCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031562; c=relaxed/simple;
	bh=S5AlSuY/Wf1hMZPoK1f7AYH9IvXMqT4heQG0cEqo5GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYdXz/0tZdvvgu8xShWioGBnNAuU8TgGz19dwah2w3tMwJkM0zKGVlKsh/afl4Edibv7Ca3likhFGLBwVpLTGw0bKi0+j3ARrdz9CITL9gJxORaL0TWLv+Ezp2fibOG1AHd7EXrw5A2Qo3flgy/S000ER1APxL/YUxawNDK6kcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YZrEj8E+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708031558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKNEBeFh7zh+iQKBPTYYoSGcAWTfBE1UjemENCtGIH8=;
	b=YZrEj8E+ydqSaSe+cduye7Sbq5/ttVCvXuaKURnFeFBJeBSNVp5zXAwWNAxpcQBW7Mg0xD
	t0o6RGIoHSrjj0qfllC0VSfy6nutJLAN1t3NHa+4a+3K4L6LeKliISufk2o125FOJxB/IF
	YDYkOPCxzPJ+oHXdI2fAdJiRnujJYmU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf 2/2] selftests/bpf: Test racing between bpf_timer_cancel_and_free and bpf_timer_cancel
Date: Thu, 15 Feb 2024 13:12:18 -0800
Message-Id: <20240215211218.990808-2-martin.lau@linux.dev>
In-Reply-To: <20240215211218.990808-1-martin.lau@linux.dev>
References: <20240215211218.990808-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This selftest is based on a Alexei's test adopted from an internal
user to troubleshoot another bug. During this exercise, a separate
racing bug was discovered between bpf_timer_cancel_and_free
and bpf_timer_cancel. The details can be found in the previous
patch.

This patch is to add a selftest that can trigger the bug.
I can trigger the UAF everytime in my qemu setup with KASAN. The idea
is to have multiple user space threads running in a tight loop to exercise
both bpf_map_update_elem (which calls into bpf_timer_cancel_and_free)
and bpf_timer_cancel.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/timer.c  | 35 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/timer.c     | 34 +++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 760ad96b4be0..d66687f1ee6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -4,10 +4,29 @@
 #include "timer.skel.h"
 #include "timer_failure.skel.h"
 
+#define NUM_THR 8
+
+static void *spin_lock_thread(void *arg)
+{
+	int i, err, prog_fd = *(int *)arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	for (i = 0; i < 10000; i++) {
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		if (!ASSERT_OK(err, "test_run_opts err") ||
+		    !ASSERT_OK(topts.retval, "test_run_opts retval"))
+			break;
+	}
+
+	pthread_exit(arg);
+}
+
 static int timer(struct timer *timer_skel)
 {
-	int err, prog_fd;
+	int i, err, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	pthread_t thread_id[NUM_THR];
+	void *ret;
 
 	err = timer__attach(timer_skel);
 	if (!ASSERT_OK(err, "timer_attach"))
@@ -43,6 +62,20 @@ static int timer(struct timer *timer_skel)
 	/* check that code paths completed */
 	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
 
+	prog_fd = bpf_program__fd(timer_skel->progs.race);
+	for (i = 0; i < NUM_THR; i++) {
+		err = pthread_create(&thread_id[i], NULL,
+				     &spin_lock_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			break;
+	}
+
+	while (i) {
+		err = pthread_join(thread_id[--i], &ret);
+		if (ASSERT_OK(err, "pthread_join"))
+			ASSERT_EQ(ret, (void *)&prog_fd, "pthread_join");
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index 8b946c8188c6..f615da97df26 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -51,7 +51,8 @@ struct {
 	__uint(max_entries, 1);
 	__type(key, int);
 	__type(value, struct elem);
-} abs_timer SEC(".maps"), soft_timer_pinned SEC(".maps"), abs_timer_pinned SEC(".maps");
+} abs_timer SEC(".maps"), soft_timer_pinned SEC(".maps"), abs_timer_pinned SEC(".maps"),
+	race_array SEC(".maps");
 
 __u64 bss_data;
 __u64 abs_data;
@@ -390,3 +391,34 @@ int BPF_PROG2(test5, int, a)
 
 	return 0;
 }
+
+static int race_timer_callback(void *race_array, int *race_key, struct bpf_timer *timer)
+{
+	bpf_timer_start(timer, 1000000, 0);
+	return 0;
+}
+
+SEC("syscall")
+int race(void *ctx)
+{
+	struct bpf_timer *timer;
+	int err, race_key = 0;
+	struct elem init;
+
+	__builtin_memset(&init, 0, sizeof(struct elem));
+	bpf_map_update_elem(&race_array, &race_key, &init, BPF_ANY);
+
+	timer = bpf_map_lookup_elem(&race_array, &race_key);
+	if (!timer)
+		return 1;
+
+	err = bpf_timer_init(timer, &race_array, CLOCK_MONOTONIC);
+	if (err && err != -EBUSY)
+		return 1;
+
+	bpf_timer_set_callback(timer, race_timer_callback);
+	bpf_timer_start(timer, 0, 0);
+	bpf_timer_cancel(timer);
+
+	return 0;
+}
-- 
2.34.1


