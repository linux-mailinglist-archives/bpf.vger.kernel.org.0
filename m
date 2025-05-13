Return-Path: <bpf+bounces-58084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194BFAB49AB
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 04:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73BC19E6C50
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 02:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C92913B293;
	Tue, 13 May 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="npbZ+C/4"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E64C6C
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104410; cv=none; b=bTyTQ+VgjwdP+nOnmjPRK13dA/NZfMqBYD268Vv/DwR3MgECg+dfjK1d2lr9NhyM693N/JwauDuOpNxUGTw/Rs14ecpsMoHsV0ZpnwInmeIU2pTJ+MdxWVp1/OysscgyoamDLPIHso2K+ZekpsqPYz/c+wRWFdEEaP/nhUjK0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104410; c=relaxed/simple;
	bh=4a/WLj6LUMcbI9hfPJ9/MgW4QYU3fTe+pmt4VfTNdUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qt/X0V+Kgxa5uCxdtLXlXUo7kN07gfVO4XyzLnfnusGqaKMiP+8glW2gcq+Yl+5tT5ZXDtN6HhmSLVujyAnwSWWPcev/7/jxL2hXiJDidxv9O2Om+a8DAIuZuR8dwiRjfnRoCBMx4xedI6B2UB9zZkLCYgtQnk/uCm+khpVKjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=npbZ+C/4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3fa6129-933a-4747-8165-884e38c58e3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747104404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALj/N2Qbm9XKZXq30SO78AvXdRiW3pmiMoKjGnyl7wo=;
	b=npbZ+C/41DschfnE0HSAs5zKmA6LlyV9E81GxBjvCfCnjofRMQfsCaFCa2EW9GP09CUSNE
	1kS8+0Jxcs/oojRo2JYrSAf7JvjqA/2NdzxIBD5ViEgBvCouSJGf0nsuE5JCMxlWSQ/B2/
	vi16pumV1g+n6YUY8aatpbSdsdQxtP8=
Date: Tue, 13 May 2025 10:46:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Fix bpf_prog nested call in
 trace_mmap_lock_acquire_returned
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Liam Howlett <Liam.Howlett@oracle.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
References: <20250512145901.691685-1-chen.dylane@linux.dev>
 <CAADnVQJNmS-3gDQ4=GRGzk00S-n9KOs2temi+P-7Nac_gnx5DQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQJNmS-3gDQ4=GRGzk00S-n9KOs2temi+P-7Nac_gnx5DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/13 07:59, Alexei Starovoitov 写道:
> On Mon, May 12, 2025 at 7:59 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> syzkaller reported an issue:
>>
>>   bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>>   __bpf_prog_run include/linux/filter.h:718 [inline]
>>   bpf_prog_run include/linux/filter.h:725 [inline]
>>   __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>>   bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>>   __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
>>   __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
>>   __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>>   trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>>   __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>>   __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>>   mmap_read_trylock include/linux/mmap_lock.h:204 [inline]
>>   stack_map_get_build_id_offset+0x535/0x6f0 kernel/bpf/stackmap.c:157
>>   __bpf_get_stack+0x307/0xa10 kernel/bpf/stackmap.c:483
>>   ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
>>   bpf_get_stack+0x32/0x40 kernel/bpf/stackmap.c:496
>>   ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1941 [inline]
>>   bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1931
>>   bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>>   __bpf_prog_run include/linux/filter.h:718 [inline]
>>   bpf_prog_run include/linux/filter.h:725 [inline]
>>   __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>>   bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>>   __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
>>   __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
>>   __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>>   trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>>   __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>>   __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>>   mmap_read_lock include/linux/mmap_lock.h:185 [inline]
>>   exit_mm kernel/exit.c:565 [inline]
>>   do_exit+0xf72/0x2c30 kernel/exit.c:940
>>   do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
>>   __do_sys_exit_group kernel/exit.c:1113 [inline]
>>   __se_sys_exit_group kernel/exit.c:1111 [inline]
>>   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
>>   x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> mmap_read_trylock is used in stack_map_get_build_id_offset, if user
>> wants to trace trace_mmap_lock_acquire_returned tracepoint and get user
>> stack in the bpf_prog, it will call trace_mmap_lock_acquire_returned
>> again in the bpf_get_stack, which will lead to a nested call relationship.
>>
>> Reported-by: syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/bpf/8bc2554d-1052-4922-8832-e0078a033e1d@gmail.com
>> Fixes: 2f1aaf3ea666 ("bpf, mm: Fix lockdep warning triggered by stack_map_get_build_id_offset()")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/stackmap.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 3615c06b7dfa..eec51f069028 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -130,6 +130,10 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
>>                           : build_id_parse_nofault(vma, build_id, NULL);
>>   }
>>
>> +static inline bool mmap_read_trylock_no_trace(struct mm_struct *mm)
>> +{
>> +       return down_read_trylock(&mm->mmap_lock) != 0;
>> +}
>>   /*
>>    * Expects all id_offs[i].ip values to be set to correct initial IPs.
>>    * They will be subsequently:
>> @@ -154,7 +158,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>           * build_id.
>>           */
>>          if (!user || !current || !current->mm || irq_work_busy ||
>> -           !mmap_read_trylock(current->mm)) {
>> +           !mmap_read_trylock_no_trace(current->mm)) {
> 
> This is not a fix.
> It doesn't address the issue.
> Since syzbot managed to craft such corner case,
> let's remove WARN_ON_ONCE from get_bpf_raw_tp_regs() for now.
> 
> In the long run we may consider adding a per-tracepoint
> recursion count for particularly dangerous tracepoints like this one,

This looks more general.

> but let's not do it just yet.
> Removing WARN_ON_ONCE should do it.

Will change it in v2.

> 
> pw-bot: cr


-- 
Best Regards
Tao Chen

