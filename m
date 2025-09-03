Return-Path: <bpf+bounces-67293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B1CB42348
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BEB7BE4C2
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208A30F52B;
	Wed,  3 Sep 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mAf7f9Zx"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302063126D4
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908299; cv=none; b=mDhHmigv+7aBVqkMRoW8jIUuS0hJy7YeS2clCOnMoBLks1FJ00cXnWel0vjI1QvrbxxaSr0M0jLM/eV2NnqwbNBqbn58SwSEwiwXaabs13w+I4CiseS5kzVW7elcGLO8IN6HD7u4kgdpWLX8DZzpjMl9WXE9Jmg6R/Nag0VadbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908299; c=relaxed/simple;
	bh=p5twsK8Mmp0yM6i0hUeBNJK3J+rQ+MbpzlKK73keVsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIBN1uJa0pwHv22ExYKf7LE1vHLD35RZOel7pOSz8rNzLrEhNIEbn/1iaHh66jnxhP6AL/us2Qwymxcx79Vfya8Z84QgLhhIKd9xQmm/L8mbtP4msJgDilmbynE0LDink1gnpdW4FWq6mEWeAGBMG/vLyN2MbKZymYh4Mcs3jwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mAf7f9Zx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756908294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6TeDD67Qh1OAuLPGmY11rXf+iL5BktX/sszIPcOpVnM=;
	b=mAf7f9Zx1rp5SgshLcLuhdw0Dret9DikZEmePRM8jWvqNeb8+nZqr3A7ZlracHJWiAn1Dy
	7xqzCsqW+NWcQe6ZzMrunlMx6GGLcAG7zjDmF6QMjT0EIgwd+9DKoy8JSAQkfuQP5v1c1g
	tZaNx4csUH+/QcCl2MewMpmdmTYGdP4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v3 0/2] selftests/bpf: Introduce experimental bpf_in_interrupt()
Date: Wed,  3 Sep 2025 22:04:36 +0800
Message-ID: <20250903140438.59517-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Filtering pid_tgid is meanlingless when the current task is preempted by
an interrupt.

To address this, introduce 'bpf_in_interrupt()' helper function, which
allows BPF programs to determine whether they are executing in interrupt
context.

'get_preempt_count()':

* On x86, '*(int *) bpf_this_cpu_ptr(&__preempt_count)'.
* On arm64, 'bpf_get_current_task_btf()->thread_info.preempt.count'.

Then 'bpf_in_interrupt()' will be:

* If !PREEMPT_RT, 'get_preempt_count() & (NMI_MASK | HARDIRQ_MASK
  | SOFTIRQ_MASK)'.
* If PREEMPT_RT, '(get_preempt_count() & (NMI_MASK | HARDIRQ_MASK))
  | (bpf_get_current_task_btf()->softirq_disable_cnt & SOFTIRQ_MASK)'.

'bpf_in_interrupt()' runs well when PREEMPT_RT is enabled. But it's
difficult for me to test it well because I'm not familiar with
PREEMPT_RT.

Changes:
v2 -> v3:
* Address comments from Alexei:
  * Move bpf_in_interrupt() to bpf_experimental.h.
  * Add support for arm64.
v2: https://lore.kernel.org/bpf/20250825131502.54269-1-leon.hwang@linux.dev/

v1 -> v2:
* Fix a build error reported by test bot.

Leon Hwang (2):
  selftests/bpf: Introduce experimental bpf_in_interrupt()
  selftests/bpf: Add case to test bpf_in_interrupt()

 .../testing/selftests/bpf/bpf_experimental.h  | 54 +++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/timer.c  | 30 +++++++++++
 .../selftests/bpf/progs/timer_interrupt.c     | 48 +++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/timer_interrupt.c

--
2.51.0


