Return-Path: <bpf+bounces-59420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA3ACA7F0
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 03:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB4173CD6
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 01:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F07127E18;
	Mon,  2 Jun 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrr8pvLp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8651684A4;
	Mon,  2 Jun 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824206; cv=none; b=JyzW3jmJ2TXMpl6T8Nu6YZztkE9uHUyysANq2WEq9aaSdGqaNvnMQJ2GHgS+tL16KwPeE8i8D1SDmIRf61gWMpnzJ/19txkprrCcw19xG37VTvgM2nKW3xSOufCKjl07m7btUQa+RMrbqzPQMVSg8sIafht9xMZ3/W1NkjbBm70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824206; c=relaxed/simple;
	bh=S9HzM07U1RDivk5UFSgGZdF+ElLyL6x0aAWqge4J4uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE+4k/kAj0Hs2CuAH7MPfY5DPj/jEJ542rGiXbNs56b39BfKeZJtG6QgPj59YSC/mw5NFXrStLh/RbaO271zN/q+VFQQx4dB4cp1Qo/fkvaSOc8Ap4DACOQs6BVmKJLl+dJ2NxDQYo3bSp8zQvJC6gBc0K0lbceB+2PQKyckZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrr8pvLp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33677183so29901725ad.2;
        Sun, 01 Jun 2025 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748824204; x=1749429004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngVqkWKuuyrv3pS34wegFZrDD9qRIPEFwg45t/mtRWA=;
        b=Lrr8pvLprOcVLRTv3s8nPeWIQeWc5/cRhpeZt7H8P/OCByhecVUD/g4sLFanNz0XlZ
         e2F77Y6YYa9+TduoytWwJ44rrBKf8e45nkVPsHsLWWLgXTp+BpXVXQ7g5mkNSP08AG2/
         k1d8Na0h8CeK5coKh3yqppZLiFEJaRSV06iPRggL8YfQeMBEfyIrYOe4jizIs5FNo+o7
         v9s2QoDklDrSpYH3ZFJNEszAyuabJ0/hAuYs7XANYD38+qcsbWiSdWhHOskvGeZMYV/U
         FF/bqAm7PH7cjS4jRKVphMFvyVV/17LR1A5/bUHknJAcbZaUaJ8Z+b1kacZkdZGkRnEd
         5oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748824204; x=1749429004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngVqkWKuuyrv3pS34wegFZrDD9qRIPEFwg45t/mtRWA=;
        b=vg9DppgmO1nxIgGjhX+Y5egJ0HbfsLaDTx4ttKaei8wxuZC69PG2QvqG8KzVcIsxp3
         I1bKQlQPjPYWwhRMvcIz3LLwnLSuoUKHK4XRux+5tqZ0ejqrDl/tiquNEeYyXoZtWF8d
         8YIRzLu+8s2tmYltV7toBHPCTEGLN0/2NNQpQYWcaPhC+Z4T53jHzrwqrdcgRiY6cyA7
         TnkL3LMuWsjyHMskQ2xGl073h2SMpBjLer6mLxtS+ca3ptGn/YKgGGC+aUAoApKsQcTE
         TZmFDSn3XCkkVLO+Q+6oMb07XQDc7qWjYMNJZuQqThhWcMLs7k1kkKCHtTNvO0JMcxWK
         IaIg==
X-Forwarded-Encrypted: i=1; AJvYcCU6HLGV7N8jxffl41qQCxcDTxgx6/NYcPSrspusIVD4CF6CliZRNH+PPI5P9vWjdo+NWXA=@vger.kernel.org, AJvYcCW/HPIV/7eAgdxx6oU4LQjj9HQ3YXmuJNe1oYK0lDcRiYpL/fU/1tCEKpfPvTR03Q5IfFPhN3YEpjQnMcgl@vger.kernel.org, AJvYcCX2f6y8fpYSQ5cA2jaknlc54Bhhmcxm1O5DPuzIvHj5FsrJ+tI3E5uePUF+zbu5XZjiGuVoUBD2il1Ad0wegBlxKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zh3u9NCoYlB7QlfDz7uucoa83kFfYtJcTQjatui7KTVMSoqq
	WNmjQ+L5zbivkuZajWoQ+teMsAmmH69/mVjSFC+0Pb4RVTNTUhCzOBXl
X-Gm-Gg: ASbGncvrvj/L7JaggzjDlNS2yFokTCurvD5UnyiJoOSPT2chOwqHAuyYAdkB57EFUQD
	/Bw6D0HBaneXxavi9v8sWF2AI8/GytAjtR6MMDzve+fQfW3Pztfco64dxdh0wAbpGDA31Zm5Qbw
	7wg3VY1er1TsHu41/tX7+aanbAjKjA5J5iJ2XzI+JNNFFbPjZaqmpl5FSQa3VoEJW1hPN8Jzsa0
	f0z2m2gE+YGWoc4/hfRzR8Lqx8rbnOilYDlGcxm5waQTTY0OU02zPdak4v1Ns4rFcHFTlOWdnWg
	5uBxdnczqIwdJWhT9hMwvsIRvJXEk8YcEVlb1PxdELmm8BCQj7wtpXTdysZoHy8BrjsUyROe3ft
	OecqrYI1dV7w+5hQ=
X-Google-Smtp-Source: AGHT+IE6g4HtxWXwhqVCpk3sHq5jE7Vpsz3jkUldBiQJBorAXshRGs4uBBpiBBUSwxmB1I7WUlgKCA==
X-Received: by 2002:a17:902:e851:b0:234:c65f:6c0c with SMTP id d9443c01a7336-235390e105fmr153686125ad.15.1748824203722;
        Sun, 01 Jun 2025 17:30:03 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf471asm59935235ad.164.2025.06.01.17.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 17:30:03 -0700 (PDT)
Date: Sun, 1 Jun 2025 17:30:01 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com, 
	leo.yan@arm.com, bpf@vger.kernel.org, andrii@kernel.org, ihor.solodrai@linux.dev, 
	song@kernel.org, jolsa@kernel.org
Subject: perf regression. Was: [PATCH V4 01/16] perf: Fix the throttle logic
 for a group
Message-ID: <djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520181644.2673067-2-kan.liang@linux.intel.com>

On Tue, May 20, 2025 at 11:16:29AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The current throttle logic doesn't work well with a group, e.g., the
> following sampling-read case.
> 
> $ perf record -e "{cycles,cycles}:S" ...
> 
> $ perf report -D | grep THROTTLE | tail -2
>             THROTTLE events:        426  ( 9.0%)
>           UNTHROTTLE events:        425  ( 9.0%)
> 
> $ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> 0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
> ... sample_read:
> .... group nr 2
> ..... id 0000000000000327, value 000000000cbb993a, lost 0
> ..... id 0000000000000328, value 00000002211c26df, lost 0
> 
> The second cycles event has a much larger value than the first cycles
> event in the same group.
> 
> The current throttle logic in the generic code only logs the THROTTLE
> event. It relies on the specific driver implementation to disable
> events. For all ARCHs, the implementation is similar. Only the event is
> disabled, rather than the group.
> 
> The logic to disable the group should be generic for all ARCHs. Add the
> logic in the generic code. The following patch will remove the buggy
> driver-specific implementation.
> 
> The throttle only happens when an event is overflowed. Stop the entire
> group when any event in the group triggers the throttle.
> The MAX_INTERRUPTS is set to all throttle events.
> 
> The unthrottled could happen in 3 places.
> - event/group sched. All events in the group are scheduled one by one.
>   All of them will be unthrottled eventually. Nothing needs to be
>   changed.
> - The perf_adjust_freq_unthr_events for each tick. Needs to restart the
>   group altogether.
> - The __perf_event_period(). The whole group needs to be restarted
>   altogether as well.
> 
> With the fix,
> $ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> 0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
> ... sample_read:
> .... group nr 2
> ..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
> ..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 66 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 20 deletions(-)

This patch breaks perf hw events somehow.

After merging this into bpf trees we see random "watchdog: BUG: soft lockup"
with various stack traces followed up:
[   78.620749] Sending NMI from CPU 8 to CPUs 0:
[   76.387722] NMI backtrace for cpu 0
[   76.387722] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O L      6.15.0-10818-ge0f0ee1c31de #1163 PREEMPT
[   76.387722] Tainted: [O]=OOT_MODULE, [L]=SOFTLOCKUP
[   76.387722] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   76.387722] RIP: 0010:_raw_spin_lock_irqsave+0xc/0x40
[   76.387722] Call Trace:
[   76.387722]  <IRQ>
[   76.387722]  hrtimer_try_to_cancel.part.0+0x24/0xe0
[   76.387722]  hrtimer_cancel+0x21/0x40
[   76.387722]  cpu_clock_event_stop+0x64/0x70
[   76.387722]  __perf_event_account_interrupt+0xcf/0x140
[   76.387722]  __perf_event_overflow+0x36/0x340
[   76.387722]  ? hrtimer_start_range_ns+0x2c1/0x420
[   76.387722]  ? kvm_sched_clock_read+0x11/0x20
[   76.387722]  perf_swevent_hrtimer+0xaf/0x100
[   76.387722]  ? cpu_clock_event_add+0x6e/0x90
[   76.387722]  ? event_sched_in+0xc3/0x190
[   76.387722]  ? update_load_avg+0x87/0x3d0
[   76.387722]  ? _raw_spin_unlock+0xe/0x20
[   76.387722]  ? sched_balance_update_blocked_averages+0x59b/0x6a0
[   76.387722]  ? ctx_sched_in+0x184/0x210
[   76.387722]  ? kvm_sched_clock_read+0x11/0x20
[   76.387722]  ? sched_clock_cpu+0x55/0x190
[   76.387722]  ? perf_exclude_event+0x50/0x50
[   76.387722]  __hrtimer_run_queues+0x111/0x290
[   76.387722]  hrtimer_interrupt+0xff/0x240
[   76.387722]  __sysvec_apic_timer_interrupt+0x4f/0x110
[   76.387722]  sysvec_apic_timer_interrupt+0x6c/0x90

After reverting:
commit e800ac51202f ("perf: Only dump the throttle log for the leader")
commit 9734e25fbf5a ("perf: Fix the throttle logic for a group")
everything is back to normal.

There are many ways to reproduce.
Any test that sets up perf hw event followed up by tests that IPIs all cpus.
One way:
selftests/bpf/test_progs -t stacktrace_build_id_nmi
selftests/bpf/test_progs -t unpriv_bpf_disabled

Please take a look.

