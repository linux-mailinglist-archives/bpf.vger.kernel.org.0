Return-Path: <bpf+bounces-78976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1709D221C0
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 03:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D41D302DB2C
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 02:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687F1A9FAB;
	Thu, 15 Jan 2026 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mmvpT/fI"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA511CAF
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768443584; cv=none; b=dm+6v1quZTMb95s+hOEDzVxhPofvkjw+Mz+vb97veL9GUlW7qDO+nbSfC0u6Nj/4IT2Et8nSPUlUbreSIJzqdZYZcY0veK7caYFIBkEG6jtLa559NldYInkOpoDF2OrK8XylrqmfEEM5OLgR/eJyLDkQHgEh2jdRfz8HCox981I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768443584; c=relaxed/simple;
	bh=2+woLfAOr82Zu4vEfSDri7rx/uLY2IvKY9gx9tjJbBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INqnfI0Gb3xM+p4U34EZ7uyq0kQrheC4jkp/SQ3xNKHjp4yx5c6TqY2NiNYeeWTyMswzlZI8JuSvrrCmVOJrdBlYtYfuG2m3nWoX5naLt+45Et9h4JK02YjYTe7HEKp/DQRgxwtm1hxAoVxCqXE9FMHnRezUIqjEsY/Q0eM/fhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mmvpT/fI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbed37ce-4688-4ecc-b572-c48764b6368d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768443571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHRp8SFnQHpQZrbKCWKPuTC6cJKjVHvwHQJMSVyOfLQ=;
	b=mmvpT/fIiau0YrjLBEdsCdVt+suzyY/H1UEwBV4vTXlkwO/w75tiMcX0e/dBXnH3n4tAnT
	TbGfhrBY2DlE3TxecYYSHkTZuob2qjiJu/lb+sSpKBynKhZKeemeSMevxUs2q9uV47gy1U
	UmS/+6hG2QcJsY45Hzxnou1ER2Uaf7g=
Date: Thu, 15 Jan 2026 10:18:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: The same symbol is printed twice when use tracepoint to get stack
To: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <e876fdea-ad0c-49dd-80ec-bd835ebfe0a4@linux.dev>
 <31e5d219-07f4-46c0-bef1-53af20d473f1@oracle.com> <aWgFSJIpsP2M6mYA@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aWgFSJIpsP2M6mYA@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/15 05:06, Jiri Olsa 写道:
> On Wed, Jan 14, 2026 at 05:35:45PM +0000, Alan Maguire wrote:
>> On 14/01/2026 15:09, Tao Chen wrote:
>>> Hi guys,
>>>
>>> When using tracepoints to retrieve stack information, I observed that perf_trace_sched_migrate_task was printed twice. And the issue also occurs with tools using libbpf.
>>>
>>
>> You may need the fix Jiri provided for x86_64 [1]. Eugene mentioned that
>> the issue persists for arm64 however [2].
> 
> yep, there's also follow patchset up for kprobe multi [1]
> 
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/20260112214940.1222115-1-jolsa@kernel.org/
> 
>>
>> Alan
>>
>> [1] https://lore.kernel.org/bpf/20251104215405.168643-2-jolsa@kernel.org/
>> [2] https://lore.kernel.org/all/a38fed68-67bc-98ce-8e12-743342121ae3@oracle.com/
>>   
>>> sudo bpftrace -e '
>>> tracepoint:sched:sched_migrate_task {
>>> printf("Task %s migrated by:\n", args->comm);
>>> print(kstack);
>>> }'
>>>
>>> Task kcompactd0 migrated by:
>>>
>>>          perf_trace_sched_migrate_task+9
>>>          perf_trace_sched_migrate_task+9
>>>          set_task_cpu+353
>>>          detach_task+77
>>>          detach_tasks+281
>>>          sched_balance_rq+452
>>>          sched_balance_newidle+504
>>>          pick_next_task_fair+84
>>>          __pick_next_task+66
>>>          pick_next_task+43
>>>          __schedule+332
>>>          schedule+41
>>>          schedule_hrtimeout_range+239
>>>          do_poll.constprop.0+668
>>>          do_sys_poll+499
>>>          __x64_sys_ppoll+220
>>>          x64_sys_call+5722
>>>          do_syscall_64+126
>>>          entry_SYSCALL_64_after_hwframe+118
>>>
>>> Task jbd2/sda2-8 migrated by:
>>>
>>>          perf_trace_sched_migrate_task+9
>>>          perf_trace_sched_migrate_task+9
>>>          set_task_cpu+353
>>>          try_to_wake_up+365
>>>          default_wake_function+26
>>>          autoremove_wake_function+18
>>>          __wake_up_common+118
>>>          __wake_up+55
>>>          __jbd2_log_start_commit+195
>>>
>>> env:
>>> bpftrace v0.21.2
>>> ubuntu24.04，6.14.0-36-generic
>>>
>>> The issue is as follows:
>>> https://github.com/bpftrace/bpftrace/issues/4949
>>>
>>>
>>> It seems that there is no special handling in the kernel.
>>> Does anyone has thoughts on this issue. Thanks.
>>>
>>> BPF_CALL_4(bpf_get_stack_raw_tp, struct bpf_raw_tracepoint_args *, args,
>>>             void *, buf, u32, size, u64, flags)
>>> {
>>>          struct pt_regs *regs = get_bpf_raw_tp_regs();
>>>          int ret;
>>>
>>>          if (IS_ERR(regs))
>>>                  return PTR_ERR(regs);
>>>
>>>          perf_fetch_caller_regs(regs);
>>>          ret = bpf_get_stack((unsigned long) regs, (unsigned long) buf,
>>>                              (unsigned long) size, flags, 0);
>>>          put_bpf_raw_tp_regs();
>>>          return ret;
>>> }
>>>
>>

Alan, Jiri

Thanks for your reply, i see.

-- 
Best Regards
Tao Chen

