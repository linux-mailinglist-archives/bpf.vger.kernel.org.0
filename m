Return-Path: <bpf+bounces-66779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F28B39391
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2493A6775
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47481DC075;
	Thu, 28 Aug 2025 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RhVAbjTt"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC14A02
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361052; cv=none; b=Ca8Qqyj4HmTD81BXmh1ghWQ2zO2Dp/pFaC6OngnfhqLhIkUcw0thUZnOgLxxSJ3qXZSGh7CYaV9UpB7c/QSGLeqFwRQP3XbEWzFah0knPn9dyfBT26UuKP+WsQ+OeyvMTYHtcr4UGjKXVhLpd6jfpuGgEMrn+EsBQR72PLwXgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361052; c=relaxed/simple;
	bh=zxW/iHEZjYoXSMBuvx8VQfr6AZp0nBTpJ4j1Hg9kp2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BOJktGA325Xwmnc1cNFWljyeDLM2v2pNnQ+avnohldrl+5TrZQoMOfpKNtaHVaAk/caFYhQqXoDpp5/W1cVucZzjkp4pfI+8eP5Q2Azn+QlFOy6f5ZgoX4vocgFMY2o9/beRvpIuBCS7NrxQIJ4yHrbtZjrPqJ407qyn40q8rAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RhVAbjTt; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756361046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v+daTrA2lk2ON5RtGrAg2zg1F0Uu28Z3Kg8udtbYQtE=;
	b=RhVAbjTtGEoFxTSg8f6W07+BEPquG3TcX7nc0U50ZBpy7xnZ1xfKhIqqPzWU6VrZfDJJLV
	kNgfCd7BJRHcotwFgmatLPgHfnuED/ul/MX9xvhwwENOo72s5JEa9Qa0wsWB3ci3o0dsiz
	J+MVVyMHZyfcQw6h4gZAWO87zwpKnOA=
From: Menglong Dong <menglong.dong@linux.dev>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Menglong Dong <menglong.dong@linux.dev>
Subject: [PATCH v4 0/3] sched: make migrate_enable/migrate_disable inline
Date: Thu, 28 Aug 2025 14:03:51 +0800
Message-ID: <20250828060354.57846-1-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In this series, we make migrate_enable/migrate_disable inline to obtain
better performance in some case.

In the first patch, we add the macro "COMPILE_OFFSETS" to all the
asm-offset.c to avoid circular dependency in the 2nd patch.

In the 2nd patch, we generate the offset of nr_pinned in "struct rq" with
rq-offsets.c, as the "struct rq" is defined internally and we need to
access the "nr_pinned" field in migrate_enable and migrate_disable. Then,
we move the definition of migrate_enable/migrate_disable from
kernel/sched/core.c to include/linux/sched.h.

In the 3rd patch, we fix some typos in include/linux/preempt.h.

One of the beneficiaries of this series is BPF trampoline. Without this
series, the migrate_enable/migrate_disable is hot when we run the
benchmark for FENTRY, FEXIT, MODIFY_RETURN, etc:

  54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k]
                 bpf_prog_2dcccf652aac1793_bench_trigger_fentry
  10.43% [kernel] [k] migrate_enable
  10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
  8.06% [kernel] [k] __bpf_prog_exit_recur
  4.11% libc.so.6 [.] syscall
  2.15% [kernel] [k] entry_SYSCALL_64
  1.48% [kernel] [k] memchr_inv
  1.32% [kernel] [k] fput
  1.16% [kernel] [k] _copy_to_user
  0.73% [kernel] [k] bpf_prog_test_run_raw_tp

Before this patch, the performance of BPF FENTRY is:

  fentry         :  113.030 ± 0.149M/s
  fentry         :  112.501 ± 0.187M/s
  fentry         :  112.828 ± 0.267M/s
  fentry         :  115.287 ± 0.241M/s

After this patch, the performance of BPF FENTRY increases to:

  fentry         :  143.644 ± 0.670M/s
  fentry         :  149.764 ± 0.362M/s
  fentry         :  149.642 ± 0.156M/s
  fentry         :  145.263 ± 0.221M/s

Changes since V3:
* some modification on the 2nd patch, as Alexei advised:
 - rename CREATE_MIGRATE_DISABLE to INSTANTIATE_EXPORTED_MIGRATE_DISABLE
 - add document for INSTANTIATE_EXPORTED_MIGRATE_DISABLE

Changes since V2:
* some modification on the 2nd patch, as Peter advised:
  - don't export runqueues, define migrate_enable and migrate_disable in
    kernel/sched/core.c and use them for kernel modules instead
  - define the macro this_rq_pinned()
  - add some comment for this_rq_raw()

Changes since V1:
* use PERCPU_PTR() for this_rq_raw() if !CONFIG_SMP in the 2nd patch

Menglong Dong (3):
  arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
  sched: make migrate_enable/migrate_disable inline
  sched: fix some typos in include/linux/preempt.h

 Kbuild                               |  13 ++-
 arch/alpha/kernel/asm-offsets.c      |   1 +
 arch/arc/kernel/asm-offsets.c        |   1 +
 arch/arm/kernel/asm-offsets.c        |   2 +
 arch/arm64/kernel/asm-offsets.c      |   1 +
 arch/csky/kernel/asm-offsets.c       |   1 +
 arch/hexagon/kernel/asm-offsets.c    |   1 +
 arch/loongarch/kernel/asm-offsets.c  |   2 +
 arch/m68k/kernel/asm-offsets.c       |   1 +
 arch/microblaze/kernel/asm-offsets.c |   1 +
 arch/mips/kernel/asm-offsets.c       |   2 +
 arch/nios2/kernel/asm-offsets.c      |   1 +
 arch/openrisc/kernel/asm-offsets.c   |   1 +
 arch/parisc/kernel/asm-offsets.c     |   1 +
 arch/powerpc/kernel/asm-offsets.c    |   1 +
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/s390/kernel/asm-offsets.c       |   1 +
 arch/sh/kernel/asm-offsets.c         |   1 +
 arch/sparc/kernel/asm-offsets.c      |   1 +
 arch/um/kernel/asm-offsets.c         |   2 +
 arch/xtensa/kernel/asm-offsets.c     |   1 +
 include/linux/preempt.h              |  11 +--
 include/linux/sched.h                | 113 +++++++++++++++++++++++++++
 kernel/bpf/verifier.c                |   1 +
 kernel/sched/core.c                  |  63 ++++-----------
 kernel/sched/rq-offsets.c            |  12 +++
 26 files changed, 180 insertions(+), 57 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

-- 
2.51.0


