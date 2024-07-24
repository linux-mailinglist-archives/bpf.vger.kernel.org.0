Return-Path: <bpf+bounces-35559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808593B7ED
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1741C2861E1
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91816CD3E;
	Wed, 24 Jul 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stfSPRpC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09D4A39;
	Wed, 24 Jul 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852429; cv=none; b=eKzCQW6XXRy+uSKyYevUjJyK9dVJ7cMfyGmleKxgAA8Hi1iGE70T1gfedvkQeto78BscUdCFNhlQb1q9NVXkSULk1pOFGB1H8N2+L8m68H+iZ3qyooFN99MYQ2XF5IfNda+3nZ66/hwqTI9/1hiG7wvZ0NSLn7SyyrV4WA7TaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852429; c=relaxed/simple;
	bh=TaHGd58bO3ZHT52k7f+ccpp3n+4y1ijQEF7ZM3jN7hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP3oHGcJUsRTkuiNceqoBKxdRFNMg1CXr+MYkkuPSjlVXv2rYuivL+M3nY1x28WRZJpVZBHNT8S9AihsPLg+XlQvOXI/84to/eJG1obVCSOQ8YA7fv+Gc+WMD6f+/q2xi3RGUxCdtRs9j5lG4R22c0bE0izFzuIOdnqX32+4s50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stfSPRpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D062C32781;
	Wed, 24 Jul 2024 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852429;
	bh=TaHGd58bO3ZHT52k7f+ccpp3n+4y1ijQEF7ZM3jN7hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stfSPRpCpfDI5PdUAjjj2rjtb11Oxh4bE76/sqnszCPZwSz3VUNDXvCA7T3yCVyGj
	 Vr95v1MNjLI/Ttqvep8yqzG/l3Ix3W6DbREnXKzn/xcyinK9KKLgVS1DOSS6QmK86r
	 xqFZb8oO8fGaptbY2apFtNAjO0mQ1ASYoze/N1OkUb1mcvoQ/wDTjarII0cx6l0Fgs
	 xApvvrXb2RY72SB5bu7IQu2xJXd1hbJlVmCwAjvIQ3w6bB5SwwQ8p6u9VQNc8pv7fw
	 LT2QJlmgbcMVi0NOcFbNSKIhFjwLJZyw01iwkSI7kc4HLJ0MurliADxWXwxWjtyQwO
	 3NFMZkO2HrQaw==
Date: Wed, 24 Jul 2024 13:20:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/8] perf bpf-filter: Make filters map a single entry
 hashmap
Message-ID: <ZqFiC4z_EZtsB4Su@google.com>
References: <20240703223035.2024586-1-namhyung@kernel.org>
 <20240703223035.2024586-2-namhyung@kernel.org>
 <ZqFWwGTvzzLPhtxs@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqFWwGTvzzLPhtxs@x1>

On Wed, Jul 24, 2024 at 04:32:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 03, 2024 at 03:30:28PM -0700, Namhyung Kim wrote:
> > And the value is now an array.  This is to support multiple filter
> > entries in the map later.
> > 
> > No functional changes intended.
> 
> Hey how can we test this feature these days?

There's a 'perf record sample filtering (by BPF) tests'.

  $ ./perf test -vv filtering
   95: perf record sample filtering (by BPF) tests:
  --- start ---
  test child forked, pid 1042594
  Checking BPF-filter privilege
  try 'sudo perf record --setup-filter pin' first.
  bpf-filter test [Skipped permission]
  ---- end(-2) ----
   95: perf record sample filtering (by BPF) tests                     : Skip

> 
> With this first patch applied:
> 
> root@number:~# perf record -a -W -e cycles:p --filter 'period > 100 || weight > 0' sleep 1
> Error: cpu_atom/cycles/p event does not have PERF_SAMPLE_WEIGHT
>  Hint: please add -W option to perf record
> failed to set filter "BPF" on event cpu_atom/cycles/p with 95 (Operation not supported)
> root@number:~# perf record -a -W -e cpu_core/cycles/p --filter 'period > 100 || weight > 0' sleep 1
> Error: cpu_core/cycles/p event does not have PERF_SAMPLE_WEIGHT
>  Hint: please add -W option to perf record
> failed to set filter "BPF" on event cpu_core/cycles/p with 95 (Operation not supported)
> root@number:~# perf record -a -W -e cpu_atom/cycles/p --filter 'period > 100 || weight > 0' sleep 1
> Error: cpu_atom/cycles/p event does not have PERF_SAMPLE_WEIGHT
>  Hint: please add -W option to perf record
> failed to set filter "BPF" on event cpu_atom/cycles/p with 95 (Operation not supported)
> root@number:~#

Do you say it's failing after the first patch?  It looks like the atom
CPU doesn't support PERF_SAMPLE_WEIGHT and should fail already.

The above test doesn't check the weight field FYI.

> 
> Interesting, it is taking a long time on the BPF prog load:
> 
> bpf(BPF_MAP_UPDATE_ELEM, {map_fd=49, key=0x7ffcc85a545c, value=0x7fee34bc2000, flags=BPF_ANY}, 32) = 0
> bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_PERF_EVENT, insn_cnt=335, insns=0xd1e6480, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(6, 9, 9), prog_flags=0, prog_name="perf_sample_fil", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=50, func_info_rec_size=8, func_info=0xd1b9c80, func_info_cnt=1, line_info_rec_size=16, line_info=0xd1e5300, line_info_cnt=135, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 148^Cstrace: Process 2110180 detached
>  <detached ...>
> 
> <HERE it takes an unusual time, even returning after I cancelled the strace session>
> 
> root@number:~# 
> root@number:~# Error: cpu_atom/cycles/p event does not have PERF_SAMPLE_WEIGHT
>  Hint: please add -W option to perf record
> failed to set filter "BPF" on event cpu_atom/cycles/p with 11 (Resource temporarily unavailable)
> 
> root@number:~#
> 
> 
> root@number:~# uname -a
> Linux number 6.9.9-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 11 19:26:10 UTC 2024 x86_64 GNU/Linux
> root@number:~#
> 
> root@number:~# perf -v
> perf version 6.10.g5510fb5c79e9
> root@number:~# 
> 
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -10
> 5510fb5c79e9f500 (HEAD -> perf-tools-next) perf annotate: Set instruction name to be used with insn-stat when using raw instruction
> b35a86e53eb496ea perf annotate: Add support to use libcapstone in powerpc
> f2dc60d11290d53e perf annotate: Use capstone_init and remove open_capstone_handle from disasm.c
> c5bcba602eeee554 perf annotate: Make capstone_init non-static so that it can be used during symbol disassemble
> eef369c562510092 perf annotate: Update instruction tracking for powerpc
> 282701f1d77a3bdb perf annotate: Add more instructions for instruction tracking
> 758ee468ce5721e4 perf annotate: Add some of the arithmetic instructions to support instruction tracking in powerpc
> e8e7c1b6a9572bab perf annotate: Add support to identify memory instructions of opcode 31 in powerpc
> 3b3a0f04c1c6cd10 perf annotate: Add parse function for memory instructions in powerpc
> a159d2acd44e707f perf annotate: Update parameters for reg extract functions to use raw instruction on powerpc
> ⬢[acme@toolbox perf-tools-next]$ 
> 
> Ideas?

I don't know.. is it changed with this patch?

Thanks,
Namhyung

