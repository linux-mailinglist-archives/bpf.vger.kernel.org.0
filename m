Return-Path: <bpf+bounces-78927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B74D1FA16
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDE35301994E
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA1318EE9;
	Wed, 14 Jan 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ecua977+"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10A316918
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403383; cv=none; b=AP1qCyO4HZeR/5kQO7Ug7sKfbJ06ITZE1oyOfGarNDE5SGLpgS+MtI/rjBbr3JZ2uhyapz79H3qW7mrrPUEKEjJtWcmlRl1SMKlxpUu/NZltKdqFw+ExsCU0QFbPZgZr5zEzTdAMp+jziLuQHO2anobnh/MhXSWadQrWZkjR6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403383; c=relaxed/simple;
	bh=NjQcw3R1HG1lqH+BXR/8hfFLHfGLdskGN3ZJqE7vtCU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=tQ+lgzLtxK6Zy3OLDKFgkh6gWCtNRGPHtR4b2O0XyI7i1wQAngfVdAuHrI2nLHAX7WHnJEVPIqG1roqMUGQ1RyHn8oI8hwbQux3bf4vmIYaaBwr9YEvQwbvSd7FYUqED9SbiZkaYy/kmLA32bXgQtCvHTR9N6fDGhthP62KwLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ecua977+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e876fdea-ad0c-49dd-80ec-bd835ebfe0a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768403370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Aj0QrLht9aaTuQ/P2tUQw70XaX1PNaO97a64PoVhs7M=;
	b=Ecua977+S4zE7pTvHGcXdg6R2bH1vPX6s2W/t55EmuipkpWvJYgBhlwELl2Hi8UD2PMWae
	LsoRoJStxI7Pkbt2aU0FPWVEYRZV4hW2d0k6tdCKdEb1n9Vo4yWa35wxcQPVMIIjNXFGEp
	A+NBTAI7B9G2l8/xQBVhYHDTifwPuaU=
Date: Wed, 14 Jan 2026 23:09:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
Subject: The same symbol is printed twice when use tracepoint to get stack
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi guys,

When using tracepoints to retrieve stack information, I observed that 
perf_trace_sched_migrate_task was printed twice. And the issue also 
occurs with tools using libbpf.

sudo bpftrace -e '
tracepoint:sched:sched_migrate_task {
printf("Task %s migrated by:\n", args->comm);
print(kstack);
}'

Task kcompactd0 migrated by:

         perf_trace_sched_migrate_task+9
         perf_trace_sched_migrate_task+9
         set_task_cpu+353
         detach_task+77
         detach_tasks+281
         sched_balance_rq+452
         sched_balance_newidle+504
         pick_next_task_fair+84
         __pick_next_task+66
         pick_next_task+43
         __schedule+332
         schedule+41
         schedule_hrtimeout_range+239
         do_poll.constprop.0+668
         do_sys_poll+499
         __x64_sys_ppoll+220
         x64_sys_call+5722
         do_syscall_64+126
         entry_SYSCALL_64_after_hwframe+118

Task jbd2/sda2-8 migrated by:

         perf_trace_sched_migrate_task+9
         perf_trace_sched_migrate_task+9
         set_task_cpu+353
         try_to_wake_up+365
         default_wake_function+26
         autoremove_wake_function+18
         __wake_up_common+118
         __wake_up+55
         __jbd2_log_start_commit+195

env:
bpftrace v0.21.2
ubuntu24.04，6.14.0-36-generic

The issue is as follows:
https://github.com/bpftrace/bpftrace/issues/4949


It seems that there is no special handling in the kernel.
Does anyone has thoughts on this issue. Thanks.

BPF_CALL_4(bpf_get_stack_raw_tp, struct bpf_raw_tracepoint_args *, args,
            void *, buf, u32, size, u64, flags)
{
         struct pt_regs *regs = get_bpf_raw_tp_regs();
         int ret;

         if (IS_ERR(regs))
                 return PTR_ERR(regs);

         perf_fetch_caller_regs(regs);
         ret = bpf_get_stack((unsigned long) regs, (unsigned long) buf,
                             (unsigned long) size, flags, 0);
         put_bpf_raw_tp_regs();
         return ret;
}

-- 
Best Regards
Tao Chen


