Return-Path: <bpf+bounces-30267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E728CBC49
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 09:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752C3282257
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6147A15A;
	Wed, 22 May 2024 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPCVS+oe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347F7E0E9
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364002; cv=none; b=UqtvjK0rFB7v4T9Ff8SptVzeC1l0tPwF11+ArbuugqF+T1nQyi/PoddcZkwokEsJU8wjR41TCV4LnjzR8tBn/w73sOVzej3wqMu99ZMbKGxhvR3vP1535pXiktd3x07pO703iWWt8jyi/QFZ+cBiNL5QqAB25dRy70yPz8Ynts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364002; c=relaxed/simple;
	bh=BplKZYfeeazDK99PAqPgmY6zYovd79dQEeEk9ZldFUI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4/Cgw3OjYsm9kOhdYMjrrPciql6M6VBhUvdH8royy/XOdOpj4lx7r5pCrBpTYTktc6Q6CnLP1qA4YDV0iyfe15QXks3rZC0JKHIv2GLUpGNo873U/g/eLrX6JfM4iejr1iFjxVHhJ2MoDDZ+z4X/hmOZGQ6vDXn8FTEHd+wyY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPCVS+oe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202cea9941so37760845e9.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716363999; x=1716968799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxBn75YmCs9vqdfjX1FgL8PF2TgRSpEiRdEachISmco=;
        b=jPCVS+oeFkD3sPU5d/G3b3x1m2s27VrbxPd1IpBy0PWofH6JmB5l9N/I6rLiuLkQeC
         9DEyXQoCml1GEcaHxXhuQhr3ipt7TEnigld8kEIxuMPb9uFCowEOuyHzVAJ3zgn50Xoe
         CEL71ryLs2uHUqQeKx8YpPu1+g8IxVRItLUQBzbcaKCE89EdZ3UWRz3N611HaHg6dNCd
         9hG8F8GIkJKpaZKHcu04I+hnDojqA1ZIwlzNr/wfvB9gPYO3VWyoUYVovZz5j9ApeSCd
         LBeWh32GqGI0NopKROby2lkGABtm+uwxsgoW0KA6xzHbZq4sQ/CuHMj6avvysnxhRxzm
         Nd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716363999; x=1716968799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxBn75YmCs9vqdfjX1FgL8PF2TgRSpEiRdEachISmco=;
        b=wDA4Xi1cdiBbmpiJTJiggxxqCAVhFc8bP96601ydgWOCH8nwO5fHvmg9NiUY2Q1KFc
         iU5g7diBaFTha/DuA0QWPzuUbaNR3G8ssx5E23oC7C6NGWpEu3AOuoPJ2lR1wPcaAsl1
         g0pA7k1oJkXPnghyJw0a1iqiicHR0J9byeGcxJaNFn9agNgG80SqjQ+IjE5Pq5FvG36d
         eGpOigYn+gbQb8l0QS2N3QiNI39LIKRWNefAurSHkr7RLrKzCmzjxod5gT4kyZG/oa2Q
         gVJdmeOEu/h6MatUxHElQP9Snx5tdTQAuS8Q1P/9+NIROTBThs3oRmv7bOhpilIC9ASz
         6gwQ==
X-Gm-Message-State: AOJu0YxNiG/b2iWkRn1VEHXFGgfmsBdSltCaFvwLEysmEIGJmmMM4wpK
	EaXSH1o8++wvJlbvmCXZEfU5ojQHEG7twQwZn8+JLt3xXtfk+y93U8g9AQ==
X-Google-Smtp-Source: AGHT+IHek0hOr+yExBhavF5sliVFIgXlYV/8zqmD02DSpQxRytCqhIomK2CJEklnO7kNtn9ihRCpZg==
X-Received: by 2002:a7b:cb0b:0:b0:420:104e:27ec with SMTP id 5b1f17b1804b1-420fd31096cmr8627975e9.15.1716363998793;
        Wed, 22 May 2024 00:46:38 -0700 (PDT)
Received: from krava ([212.20.115.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20488sm523072165e9.25.2024.05.22.00.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 00:46:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 May 2024 09:46:36 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf 4/5] selftests/bpf: extend multi-uprobe tests with
 child thread case
Message-ID: <Zk2i3Ohmnv52Zn08@krava>
References: <20240521163401.3005045-1-andrii@kernel.org>
 <20240521163401.3005045-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521163401.3005045-5-andrii@kernel.org>

On Tue, May 21, 2024 at 09:34:00AM -0700, Andrii Nakryiko wrote:
> Extend existing multi-uprobe tests to test that PID filtering works
> correctly. We already have child *process* tests, but we need also child
> *thread* tests. This patch adds spawn_thread() helper to start child
> thread, wait for it to be ready, and then instruct it to trigger desired
> uprobes.
> 
> Additionally, we extend BPF-side code to track thread ID, not just
> process ID. Also we detect whether extraneous triggerings with
> unexpected process IDs happened, and validate that none of that happened
> in practice.
> 
> These changes prove that fixed PID filtering logic for multi-uprobe
> works as expected. These tests fail on old kernels.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 107 ++++++++++++++++--
>  .../selftests/bpf/progs/uprobe_multi.c        |  17 ++-
>  2 files changed, 115 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 38fda42fd70f..677232d31432 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <unistd.h>
> +#include <pthread.h>
>  #include <test_progs.h>
>  #include "uprobe_multi.skel.h"
>  #include "uprobe_multi_bench.skel.h"
> @@ -27,7 +28,10 @@ noinline void uprobe_multi_func_3(void)
>  
>  struct child {
>  	int go[2];
> +	int c2p[2]; /* child -> parent channel */
>  	int pid;
> +	int tid;
> +	pthread_t thread;
>  };
>  
>  static void release_child(struct child *child)
> @@ -38,6 +42,10 @@ static void release_child(struct child *child)
>  		return;
>  	close(child->go[1]);
>  	close(child->go[0]);
> +	if (child->thread)
> +		pthread_join(child->thread, NULL);
> +	close(child->c2p[0]);
> +	close(child->c2p[1]);
>  	if (child->pid > 0)
>  		waitpid(child->pid, &child_status, 0);
>  }
> @@ -63,7 +71,7 @@ static struct child *spawn_child(void)
>  	if (pipe(child.go))
>  		return NULL;
>  
> -	child.pid = fork();
> +	child.pid = child.tid = fork();
>  	if (child.pid < 0) {
>  		release_child(&child);
>  		errno = EINVAL;
> @@ -89,6 +97,66 @@ static struct child *spawn_child(void)
>  	return &child;
>  }
>  
> +static void *child_thread(void *ctx)
> +{
> +	struct child *child = ctx;
> +	int c = 0, err;
> +
> +	child->tid = syscall(SYS_gettid);
> +
> +	/* let parent know we are ready */
> +	err = write(child->c2p[1], &c, 1);
> +	if (err != 1)
> +		pthread_exit(&err);
> +
> +	/* wait for parent's kick */
> +	err = read(child->go[0], &c, 1);
> +	if (err != 1)
> +		pthread_exit(&err);
> +
> +	uprobe_multi_func_1();
> +	uprobe_multi_func_2();
> +	uprobe_multi_func_3();
> +
> +	err = 0;
> +	pthread_exit(&err);
> +}
> +
> +static struct child *spawn_thread(void)
> +{
> +	static struct child child;
> +	int c, err;
> +
> +	/* pipe to notify child to execute the trigger functions */
> +	if (pipe(child.go))
> +		return NULL;
> +	/* pipe to notify parent that child thread is ready */
> +	if (pipe(child.c2p)) {
> +		close(child.go[0]);
> +		close(child.go[1]);
> +		return NULL;
> +	}
> +
> +	child.pid = getpid();
> +
> +	err = pthread_create(&child.thread, NULL, child_thread, &child);
> +	if (err) {
> +		err = -errno;
> +		close(child.go[0]);
> +		close(child.go[1]);
> +		close(child.c2p[0]);
> +		close(child.c2p[1]);
> +		errno = -err;
> +		return NULL;
> +	}
> +
> +	err = read(child.c2p[0], &c, 1);
> +	if (!ASSERT_EQ(err, 1, "child_thread_ready"))
> +		return NULL;
> +
> +	return &child;
> +}
> +
>  static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child)
>  {
>  	skel->bss->uprobe_multi_func_1_addr = (__u64) uprobe_multi_func_1;
> @@ -103,15 +171,22 @@ static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child
>  	 * passed at the probe attach.
>  	 */
>  	skel->bss->pid = child ? 0 : getpid();
> +	skel->bss->expect_pid = child ? child->pid : 0;
> +
> +	/* trigger all probes, if we are testing child *process*, just to make
> +	 * sure that PID filtering doesn't let through activations from wrong
> +	 * PIDs; when we test child *thread*, we don't want to do this to
> +	 * avoid double counting number of triggering events
> +	 */
> +	if (!child || !child->thread) {
> +		uprobe_multi_func_1();
> +		uprobe_multi_func_2();
> +		uprobe_multi_func_3();
> +	}
>  
>  	if (child)
>  		kick_child(child);
>  
> -	/* trigger all probes */
> -	uprobe_multi_func_1();
> -	uprobe_multi_func_2();
> -	uprobe_multi_func_3();
> -
>  	/*
>  	 * There are 2 entry and 2 exit probe called for each uprobe_multi_func_[123]
>  	 * function and each slepable probe (6) increments uprobe_multi_sleep_result.
> @@ -126,8 +201,12 @@ static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child
>  
>  	ASSERT_EQ(skel->bss->uprobe_multi_sleep_result, 6, "uprobe_multi_sleep_result");
>  
> -	if (child)
> +	ASSERT_FALSE(skel->bss->bad_pid_seen, "bad_pid_seen");
> +
> +	if (child) {
>  		ASSERT_EQ(skel->bss->child_pid, child->pid, "uprobe_multi_child_pid");
> +		ASSERT_EQ(skel->bss->child_tid, child->tid, "uprobe_multi_child_tid");
> +	}
>  }
>  
>  static void test_skel_api(void)
> @@ -210,6 +289,13 @@ test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi
>  		return;
>  
>  	__test_attach_api(binary, pattern, opts, child);
> +
> +	/* pid filter (thread) */
> +	child = spawn_thread();
> +	if (!ASSERT_OK_PTR(child, "spawn_thread"))
> +		return;
> +
> +	__test_attach_api(binary, pattern, opts, child);
>  }
>  
>  static void test_attach_api_pattern(void)
> @@ -495,6 +581,13 @@ static void test_link_api(void)
>  		return;
>  
>  	__test_link_api(child);
> +
> +	/* pid filter (thread) */
> +	child = spawn_thread();
> +	if (!ASSERT_OK_PTR(child, "spawn_thread"))
> +		return;
> +
> +	__test_link_api(child);
>  }
>  
>  static void test_bench_attach_uprobe(void)
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> index 419d9aa28fce..86a7ff5d3726 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> @@ -22,6 +22,10 @@ __u64 uprobe_multi_sleep_result = 0;
>  
>  int pid = 0;
>  int child_pid = 0;
> +int child_tid = 0;
> +
> +int expect_pid = 0;
> +bool bad_pid_seen = false;
>  
>  bool test_cookie = false;
>  void *user_ptr = 0;
> @@ -36,11 +40,19 @@ static __always_inline bool verify_sleepable_user_copy(void)
>  
>  static void uprobe_multi_check(void *ctx, bool is_return, bool is_sleep)
>  {
> -	child_pid = bpf_get_current_pid_tgid() >> 32;
> +	__u64 cur_pid_tgid = bpf_get_current_pid_tgid();
> +	__u32 cur_pid;
>  
> -	if (pid && child_pid != pid)
> +	cur_pid = cur_pid_tgid >> 32;
> +	if (pid && cur_pid != pid)
>  		return;
>  
> +	if (expect_pid && cur_pid != expect_pid)
> +		bad_pid_seen = true;
> +
> +	child_pid = cur_pid_tgid >> 32;
> +	child_tid = (__u32)cur_pid_tgid;
> +
>  	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
>  	__u64 addr = bpf_get_func_ip(ctx);
>  
> @@ -97,5 +109,6 @@ int uretprobe_sleep(struct pt_regs *ctx)
>  SEC("uprobe.multi//proc/self/exe:uprobe_multi_func_*")
>  int uprobe_extra(struct pt_regs *ctx)
>  {
> +	/* we need this one just to mix PID-filtered and global uprobes */
>  	return 0;
>  }
> -- 
> 2.43.0
> 
> 

