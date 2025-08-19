Return-Path: <bpf+bounces-65951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0C2B2B678
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B8B6210EF
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEB1286400;
	Tue, 19 Aug 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWeyFbNZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4021E0BE;
	Tue, 19 Aug 2025 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568133; cv=none; b=l7iPGa15VyzJGiDUWCjrH86PUSlw919Sy9ZchBMeJ45pBlUE++qQXWBo5nDFnTdyoltn3HpXqw8FnApDmPr0ePHNeVfWgOcSkCNOo9xHYWwxjIq+WBk5wLhwNoHFzY7qxhbpMurZdVEt7EQOPMdTPnmc2/rt57J4O1bpFi6HOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568133; c=relaxed/simple;
	bh=2sw21zVSwhEYRqGZ8q+Z8Q5Mnxv7CisFlVLCd5MLW2I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DlW5ljEv9BzSReN8M3tLb/Tx6LBZM/qd6UxdgPujb9ss687ETme4wdHmudZzydOawv8KfMzm2D28o27/1L38nDrudoMUjFKU37uX84Otx01D/E0Pc9O3mNEJzlK3mrrHyL7HjG6I8KXAT8G2G0D/2UxF3t4xeBV4PRXzXL3w6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWeyFbNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09A7C4CEEB;
	Tue, 19 Aug 2025 01:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755568132;
	bh=2sw21zVSwhEYRqGZ8q+Z8Q5Mnxv7CisFlVLCd5MLW2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWeyFbNZAO5N8CoZ1MxTh2MgzzfOIozoncaBhN8kdUfs+Tp8+lnotAZHqiwlaiHh9
	 WOfxZ05kU9s/VPDzOy1bBbb+RjcnKaYHZ3molkpXYt1QVQPJw5NB0A8YEdjggCHD7r
	 atQaVU7Sc1htlv22cmdN2fgdaMFYiPHpmG7czdYifDW4MJbtJcULKr1h1X3aNujlgw
	 8FKoCgcYrytyq7wH1Ss+Wd4mig2H1Ysi90oQZJVyoru0rO4UMOFIqXNfLnrgfd/26K
	 +G+YzInlTWD3ljxAR+fpaVy/71aAQsUhaMLgTmpzqnUuQgDUyzX93CQRXF78u+uFGU
	 I6C+q2KiiWIOQ==
Date: Tue, 19 Aug 2025 10:48:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, hca@linux.ibm.com,
 revest@chromium.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 0/4] fprobe: use rhashtable for
 fprobe_ip_table
Message-Id: <20250819104850.1a903746f2eca854490e770b@kernel.org>
In-Reply-To: <20250817024607.296117-1-dongml2@chinatelecom.cn>
References: <20250817024607.296117-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 17 Aug 2025 10:46:01 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> For now, the budget of the hash table that is used for fprobe_ip_table is
> fixed, which is 256, and can cause huge overhead when the hooked functions
> is a huge quantity.
> 
> In this series, we use rhltable for fprobe_ip_table to reduce the
> overhead.
> 
> Meanwhile, we also add the benchmark testcase "kprobe-multi-all" and, which
> will hook all the kernel functions during the testing. Before this series,
> the performance is:
>   usermode-count :  889.269 ± 0.053M/s
>   kernel-count   :  437.149 ± 0.501M/s
>   syscall-count  :   31.618 ± 0.725M/s
>   fentry         :  135.591 ± 0.129M/s
>   fexit          :   68.127 ± 0.062M/s
>   fmodret        :   71.764 ± 0.098M/s
>   rawtp          :  198.375 ± 0.190M/s
>   tp             :   79.770 ± 0.064M/s
>   kprobe         :   54.590 ± 0.021M/s
>   kprobe-multi   :   57.940 ± 0.044M/s
>   kprobe-multi-all:   12.151 ± 0.020M/s
>   kretprobe      :   21.945 ± 0.163M/s
>   kretprobe-multi:   28.199 ± 0.018M/s
>   kretprobe-multi-all:    9.667 ± 0.008M/s
> 
> With this series, the performance is:
>   usermode-count :  888.863 ± 0.378M/s
>   kernel-count   :  429.339 ± 0.136M/s
>   syscall-count  :   31.215 ± 0.019M/s
>   fentry         :  135.604 ± 0.118M/s
>   fexit          :   68.470 ± 0.074M/s
>   fmodret        :   70.957 ± 0.016M/s
>   rawtp          :  202.650 ± 0.304M/s
>   tp             :   80.428 ± 0.053M/s
>   kprobe         :   55.915 ± 0.074M/s
>   kprobe-multi   :   54.015 ± 0.039M/s
>   kprobe-multi-all:   46.381 ± 0.024M/s
>   kretprobe      :   22.234 ± 0.050M/s
>   kretprobe-multi:   27.946 ± 0.016M/s
>   kretprobe-multi-all:   24.439 ± 0.016M/s
> 
> The benchmark of "kprobe-multi-all" increase from 12.151M/s to 46.381M/s.
> 
> I don't know why, but the benchmark result for "kprobe-multi-all" is much
> better in this version for the legacy case(without this series). In V2,
> the benchmark increase from 6.283M/s to 54.487M/s, but it become
> 12.151M/s to 46.381M/s in this version. Maybe it has some relation with
> the compiler optimization :/
> 
> The result of this version should be more accurate, which is similar to
> Jiri's result: from 3.565 ± 0.047M/s to 11.553 ± 0.458M/s.

Hi Menglong,

BTW, fprobe itself is maintained in linux-trace tree, not bpf-next.
This improvement can be tested via tracefs.

echo 'f:allfunc *' >> /sys/kernel/tracing/dynamic_events

So, can you split this series in fprobe performance improvement[1/4] for
linux-trace and others ([2/4]-[4/4]) for bpf-next?

I'll pick the first one.

Thank you,

> 
> Changes since V4:
> 
> * remove unnecessary rcu_read_lock in fprobe_entry
> 
> Changes since V3:
> 
> * replace rhashtable_walk_enter with rhltable_walk_enter in the 1st patch
> 
> Changes since V2:
> 
> * some format optimization, and handle the error that returned from
>   rhltable_insert in insert_fprobe_node for the 1st patch
> * add "kretprobe-multi-all" testcase to the 4th patch
> * attach a empty kprobe-multi prog to the kernel functions, which don't
>   call incr_count(), to make the result more accurate in the 4th patch
> 
> Changes Since V1:
> 
> * use rhltable instead of rhashtable to handle the duplicate key.
> 
> Menglong Dong (4):
>   fprobe: use rhltable for fprobe_ip_table
>   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
>   selftests/bpf: skip recursive functions for kprobe_multi
>   selftests/bpf: add benchmark testing for kprobe-multi-all
> 
>  include/linux/fprobe.h                        |   3 +-
>  kernel/trace/fprobe.c                         | 151 +++++++-----
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_trigger.c      |  54 ++++
>  .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
>  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
>  .../selftests/bpf/progs/trigger_bench.c       |  12 +
>  tools/testing/selftests/bpf/trace_helpers.c   | 233 ++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
>  9 files changed, 398 insertions(+), 286 deletions(-)
> 
> -- 
> 2.50.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

