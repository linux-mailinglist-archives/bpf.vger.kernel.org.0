Return-Path: <bpf+bounces-22619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F1E861D47
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 21:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8CF1C23587
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B8146019;
	Fri, 23 Feb 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrQwImDP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4ED1F176;
	Fri, 23 Feb 2024 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718973; cv=none; b=ln+So0qDLdUDo5hwtiP8GkZK4dVaAlV7Wc4qmo8usdLkCwraSiC20fRROakNY19hDEQjoIVRiRiqEV1FmqBWIMwRxg/NteH6101dCWFIYLyQBnvAbyq5Agd9rqYMFnO/jJymzUwAwJns+YjRyZD9XIg7npoKF/vUepwuJr2rkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718973; c=relaxed/simple;
	bh=284eWIcvw4+7+zPk8+Y8q0oSwuL4Yf9oRwDLuca9624=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WyPla35RbLc2t61DAn2s8qvMFfRJWZGSti5xjWTEKw5yoA/6ftPz3cA5wzbZY4+pMBp+/W3PaC/zXY/VJyQaqYR+OBf6nVj2vbTasR2/YtY2lVTPaIjd2sF07CX+LPXmM8BkVXfLFu9tKRrfiSPKhnICFbLLV5BpdOKnT7zEM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrQwImDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CD3C433C7;
	Fri, 23 Feb 2024 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708718972;
	bh=284eWIcvw4+7+zPk8+Y8q0oSwuL4Yf9oRwDLuca9624=;
	h=From:To:Cc:Subject:Date:From;
	b=OrQwImDPx+1r315DWGUn++VbhArOv8dxVNRiojGwfMymkK2cfM9hAx4qS2qiqReMn
	 P5GVuoTzhCXZvAXtopdnwG8BEmWUCwoqvI90HpbAJFnHiYOYtLSkKJ9iggibBFokCV
	 3aIbteOVcjyrGYk6IU0x0/MhZWBN5DnrPSqAd6jy4QO5IM576JLJPb9z6wDgtGH5eC
	 DASbD80M92UHswJ/IvcKuspdZcc1rPxezmuRpjde8LHAyDHZ9hkKYixow7W3/VqgKr
	 RjFoxyvmnzvuS5p8GyxNseMh/gHZp+5GevM9aZcETdohvDF1ygOD+Qg7LP6tAiTTeV
	 s4HbsM+TmS/nA==
From: Namhyung Kim <namhyung@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-devel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] perf tools issues with BPF
Date: Fri, 23 Feb 2024 12:09:29 -0800
Message-ID: <20240223200931.3011166-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I'd like to discuss a few BPF issues of perf tools (and the
kernel). The perf tools already make use of BPF programs for various
tracing and filtering work.  While these are all great, there is still
room for improvement.


1. Allowing unprivileged access to BPF for perf events.

The perf_event subsystem allows non-root (!CAP_PERFMON) users to have
events with restrictions in order to measure performance counts for
their processes.  On the other hand, the BPF event filter [1] can be
used to accept or reject samples based on the content of the
sample. It's almost the same as the classic BPF socket filter.  But
without CAP_BPF, normal users cannot use the BPF filter for their perf
events.

I noticed there's ongoing work with the BPF token for unprivileged use
cases but it seems to focus on “trusted” container use cases, and
I'm not sure if this would fit well for the perf use case.  Note that
this case would need to allow random users and therefore, needs
limited functionality to access the given sample data only.


2. Enhancing stack trace

Sometimes it can fail to get build-ID and offset for user stack traces
because of mmap_lock contention.  As BPF programs can run in atomic
context, it cannot wait for the lock to get the build-ID and offset.
Also there’s a chance to get page faults in the user page which also
makes the stack trace stop.

I wonder if we can enhance this situation using the deferred stack
trace proposed for S-Frame [2] last year.  IIUC it wasn’t designed
for BPF in mind but I think it can be useful for stack trace with FP.
Also it would be able to avoid duplication of the same user stacks if
the process runs in the kernel context for a while.  The question is
how to defer and to connect them.

Another (minor) issue with stack trace is to add one more (missing)
helper.  IIUC are 3 stack trace helpers: bpf_get_stack(),
bpf_get_stackid() and bpf_get_task_stack().  But I find that it'd be
useful if there's a helper (bpf_get_task_stackid) to return a single
ID value for a stack trace of the given task.

My use case is perf lock contention tool [3] to get the stack trace of
the owner of contended mutexes.  Currently it just returns the TID of
the owner, but it'd be nice to get the stack trace directly when it
went to sleep.


3. Lock symbol improvements

Actually this is not specific to BPF but for general tracing.  As I
said ‘perf lock contention’ uses BPF on a couple of tracepoints to
track lock contentions in the kernel.  But one of the problems is that
there's no symbol information for the lock.  While the lockdep saves
it in the lock data structure, it's not allowed to do that in
production.  As the tracepoint has the address of the lock instance,
it can check kallsyms for global locks but dynamic locks are not
handled.

Currently it blindly tries to match the address with some well-known
locks (including mmap_lock) from the task struct or global per-cpu
symbols in BPF.  I'm curious if there's a better way to do it.  I was
thinking about BPF iterators to get the address of well-known locks
but it cannot handle all cases and might be racy.

Looking forward to more discussion on the perf and tracing topic.

Thanks,
Namhyung


[1] https://lore.kernel.org/r/20230314234237.3008956-1-namhyung@kernel.org/
[2] https://lore.kernel.org/r/d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org/
[3] https://lore.kernel.org/r/20230207002403.63590-1-namhyung@kernel.org/

