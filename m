Return-Path: <bpf+bounces-42759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66A9A9B58
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87622812CC
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 07:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7041547EB;
	Tue, 22 Oct 2024 07:42:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF1F152160;
	Tue, 22 Oct 2024 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582950; cv=none; b=kr2mapSr8H3SWQoQYanFEb8wRjLLDDlbnC4xTvylsZSBdAwRWNfhtdjRr+WNOu4y6ZJv2gNJ9+ekP8bS6mEdXj9s8HqiG0cZWO1iyQbvRY+wsrFy4qlrCoawMMH5Ljy3Mu2NCnDwkH87cvZK15CqFhjV9qR2BycdhFp8HEWZUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582950; c=relaxed/simple;
	bh=Sns24Kn2/dehSLQImOAaNKLYhQYfH0psondXhJgNDFw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ny6f9V825piJJPKTsh9bGD+wwZpP2770zpyXrh2sSuZ8Ag/eo1cQT+/Q5wFwv0FYmgyBuLco37zGctJpFLO/CIEGFIcdzlBCc+f7b2JLyYDkgE2HpzpFB70FWjNvbc5LdPcX9j/n3L+5ClwR+8YxHbqMnapFo8zFDq8VeVzro9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XXkdS2Xz2z20qWg;
	Tue, 22 Oct 2024 15:41:32 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id D7580140361;
	Tue, 22 Oct 2024 15:42:22 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 22 Oct
 2024 15:42:22 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <andrii.nakryiko@gmail.com>, <mhiramat@kernel.org>, <oleg@redhat.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH v4 0/2] uprobes: Improve scalability by reducing the contention on siglock
Date: Tue, 22 Oct 2024 07:31:39 +0000
Message-ID: <20241022073141.3291245-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)

The profiling result of BPF selftest on ARM64 platform reveals the
significant contention on the current->sighand->siglock is the
scalability bottleneck. The reason is also very straightforward that all
producer threads of benchmark have to contend the spinlock mentioned to
resume the TIF_SIGPENDING bit in thread_info that might be removed in
uprobe_deny_signal().

The contention on current->sighand->siglock is unnecessary, this series
remove them thoroughly. I've use the script developed by Andrii in [1]
to run benchmark. The CPU used was Kunpeng916 (Hi1616), 4 NUMA nodes,
64 cores@2.4GHz running the kernel on next tree + the optimization in
[2] for get_xol_insn_slot().

before-opt
----------
uprobe-nop      ( 1 cpus):    0.907 ± 0.003M/s  (  0.907M/s/cpu)
uprobe-nop      ( 2 cpus):    1.676 ± 0.008M/s  (  0.838M/s/cpu)
uprobe-nop      ( 4 cpus):    3.210 ± 0.003M/s  (  0.802M/s/cpu)
uprobe-nop      ( 8 cpus):    4.457 ± 0.003M/s  (  0.557M/s/cpu)
uprobe-nop      (16 cpus):    3.724 ± 0.011M/s  (  0.233M/s/cpu)
uprobe-nop      (32 cpus):    2.761 ± 0.003M/s  (  0.086M/s/cpu)
uprobe-nop      (64 cpus):    1.293 ± 0.015M/s  (  0.020M/s/cpu)

uprobe-push     ( 1 cpus):    0.883 ± 0.001M/s  (  0.883M/s/cpu)
uprobe-push     ( 2 cpus):    1.642 ± 0.005M/s  (  0.821M/s/cpu)
uprobe-push     ( 4 cpus):    3.086 ± 0.002M/s  (  0.771M/s/cpu)
uprobe-push     ( 8 cpus):    3.390 ± 0.003M/s  (  0.424M/s/cpu)
uprobe-push     (16 cpus):    2.652 ± 0.005M/s  (  0.166M/s/cpu)
uprobe-push     (32 cpus):    2.713 ± 0.005M/s  (  0.085M/s/cpu)
uprobe-push     (64 cpus):    1.313 ± 0.009M/s  (  0.021M/s/cpu)

uprobe-ret      ( 1 cpus):    1.774 ± 0.000M/s  (  1.774M/s/cpu)
uprobe-ret      ( 2 cpus):    3.350 ± 0.001M/s  (  1.675M/s/cpu)
uprobe-ret      ( 4 cpus):    6.604 ± 0.000M/s  (  1.651M/s/cpu)
uprobe-ret      ( 8 cpus):    6.706 ± 0.005M/s  (  0.838M/s/cpu)
uprobe-ret      (16 cpus):    5.231 ± 0.001M/s  (  0.327M/s/cpu)
uprobe-ret      (32 cpus):    5.743 ± 0.003M/s  (  0.179M/s/cpu)
uprobe-ret      (64 cpus):    4.726 ± 0.016M/s  (  0.074M/s/cpu)

after-opt
---------
uprobe-nop      ( 1 cpus):    0.985 ± 0.002M/s  (  0.985M/s/cpu)
uprobe-nop      ( 2 cpus):    1.773 ± 0.005M/s  (  0.887M/s/cpu)
uprobe-nop      ( 4 cpus):    3.304 ± 0.001M/s  (  0.826M/s/cpu)
uprobe-nop      ( 8 cpus):    5.328 ± 0.002M/s  (  0.666M/s/cpu)
uprobe-nop      (16 cpus):    6.475 ± 0.002M/s  (  0.405M/s/cpu)
uprobe-nop      (32 cpus):    4.831 ± 0.082M/s  (  0.151M/s/cpu)
uprobe-nop      (64 cpus):    2.564 ± 0.053M/s  (  0.040M/s/cpu)

uprobe-push     ( 1 cpus):    0.964 ± 0.001M/s  (  0.964M/s/cpu)
uprobe-push     ( 2 cpus):    1.766 ± 0.002M/s  (  0.883M/s/cpu)
uprobe-push     ( 4 cpus):    3.290 ± 0.009M/s  (  0.823M/s/cpu)
uprobe-push     ( 8 cpus):    4.670 ± 0.002M/s  (  0.584M/s/cpu)
uprobe-push     (16 cpus):    5.197 ± 0.004M/s  (  0.325M/s/cpu)
uprobe-push     (32 cpus):    5.068 ± 0.161M/s  (  0.158M/s/cpu)
uprobe-push     (64 cpus):    2.605 ± 0.026M/s  (  0.041M/s/cpu)

uprobe-ret      ( 1 cpus):    1.833 ± 0.001M/s  (  1.833M/s/cpu)
uprobe-ret      ( 2 cpus):    3.384 ± 0.003M/s  (  1.692M/s/cpu)
uprobe-ret      ( 4 cpus):    6.677 ± 0.004M/s  (  1.669M/s/cpu)
uprobe-ret      ( 8 cpus):    6.854 ± 0.005M/s  (  0.857M/s/cpu)
uprobe-ret      (16 cpus):    6.508 ± 0.006M/s  (  0.407M/s/cpu)
uprobe-ret      (32 cpus):    5.793 ± 0.009M/s  (  0.181M/s/cpu)
uprobe-ret      (64 cpus):    4.743 ± 0.016M/s  (  0.074M/s/cpu)

Above benchmark results demonstrates a obivious improvement in the
scalability of trig-uprobe-nop and trig-uprobe-push, the peak throughput
of which are from 4.5M/s to 6.4M/s and 3.3M/s to 5.1M/s individually.

v4->v3:
1. Rebase v3 [3] to the lateset tip/perf/core.
2. Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
3. Acked-by: Oleg Nesterov <oleg@redhat.com>

v3->v2:
Renaming the flag in [2/2], s/deny_signal/signal_denied/g.

v2->v1:
Oleg pointed out the _DENY_SIGNAL will be replaced by _ACK upon the
completion of singlestep which leads to handle_singlestep() has no
chance to restore the removed TIF_SIGPENDING [3] and some case in
question. So this revision proposes to use a flag in uprobe_task to
track the denied TIF_SIGPENDING instead of new UPROBE_SSTEP state.

[1] https://lore.kernel.org/all/20240731214256.3588718-1-andrii@kernel.org
[2] https://lore.kernel.org/all/20240727094405.1362496-1-liaochang1@huawei.com
[3] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@huawei.com/ 

Liao Chang (2):
  uprobes: Remove redundant spinlock in uprobe_deny_signal()
  uprobes: Remove the spinlock within handle_singlestep()

 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1


