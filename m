Return-Path: <bpf+bounces-74275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 255F3C51356
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C80E44F8895
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23272FE580;
	Wed, 12 Nov 2025 08:50:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1812FDC4B;
	Wed, 12 Nov 2025 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937413; cv=none; b=T4ztP0kXk6tBNG8NE+s1n+Bd6giid4ElaRqIoIVdyosYsVlu1vcdxrXW9xgJUsiXcRjXldKdwHr4ZZ/f28jTRx96F8z9X0yvGbpZnPHRD8ZzLYK1RLa/FX2FSknCxlC1bGO6pGW13/dXcSoEfawbDE/Fd8WatNnjqlyIBQohnlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937413; c=relaxed/simple;
	bh=oSXNIlCJ4nUuItwxkksnV1j0nQ9O8xQlEqMORgnbj3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SV115SZZHzyFO1dlO7Zz5LWEcOmKOWSJ4UVGbElR5pchX+cWXrtvFhQFZZ9gNH3OxmWFttqGiE8FwHy4v9fX1jawPJLue7CSjCtTTWLg7HiCyozO6BFcOFwmENdYlUOrBP0finnje5ZqH+8XdX0ka5/hv1gWI0fiWR1tjcanIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.17.112.36] (unknown [15.248.2.224])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 73D8540037;
	Wed, 12 Nov 2025 08:40:35 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 15.248.2.224) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.17.112.36]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <3f79436c-d343-46ff-8559-afb7da24a44d@arnaud-lcm.com>
Date: Wed, 12 Nov 2025 08:40:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack to
 fix OOB write
To: Brahmajit Das <listout@listout.xyz>,
 syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <20251111081254.25532-1-listout@listout.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <176293683631.16609.1825395533128077628@Plesk>
X-PPP-Vhost: arnaud-lcm.com

I am a not sure this is the right solution and I am scared that by
forcing this clamping, we are hiding something else.
If we have a look at the code below:
```

|

	if (trace_in) {
		trace = trace_in;
		trace->nr = min_t(u32, trace->nr, max_depth);
	} else if (kernel && task) {
		trace = get_callchain_entry_for_task(task, max_depth);
	} else {
		trace = get_perf_callchain(regs, kernel, user, max_depth,
					crosstask, false, 0);
	} ``` trace should be (if I remember correctly) clamped there. If not, 
it might hide something else. I would like to have a look at the return 
for each if case through gdb. |

On 11/11/2025 08:12, Brahmajit Das wrote:
> syzbot reported a stack-out-of-bounds write in __bpf_get_stack()
> triggered via bpf_get_stack() when capturing a kernel stack trace.
>
> After the recent refactor that introduced stack_map_calculate_max_depth(),
> the code in stack_map_get_build_id_offset() (and related helpers) stopped
> clamping the number of trace entries (`trace_nr`) to the number of elements
> that fit into the stack map value (`num_elem`).
>
> As a result, if the captured stack contained more frames than the map value
> can hold, the subsequent memcpy() would write past the end of the buffer,
> triggering a KASAN report like:
>
>      BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x...
>      Write of size N at addr ... by task syz-executor...
>
> Restore the missing clamp by limiting `trace_nr` to `num_elem` before
> computing the copy length. This mirrors the pre-refactor logic and ensures
> we never copy more bytes than the destination buffer can hold.
>
> No functional change intended beyond reintroducing the missing bound check.
>
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
> Changes in v3:
> Revert back to num_elem based logic for setting trace_nr. This was
> suggested by bpf-ci bot, mainly pointing out the chances of underflow
> when  max_depth < skip.
>
> Quoting the bot's reply:
> The stack_map_calculate_max_depth() function can return a value less than
> skip when sysctl_perf_event_max_stack is lowered below the skip value:
>
>      max_depth = size / elem_size;
>      max_depth += skip;
>      if (max_depth > curr_sysctl_max_stack)
>          return curr_sysctl_max_stack;
>
> If sysctl_perf_event_max_stack = 10 and skip = 20, this returns 10.
>
> Then max_depth - skip = 10 - 20 underflows to 4294967286 (u32 wraps),
> causing min_t() to not limit trace_nr at all. This means the original OOB
> write is not fixed in cases where skip > max_depth.
>
> With the default sysctl_perf_event_max_stack = 127 and skip up to 255, this
> scenario is reachable even without admin changing sysctls.
>
> Changes in v2:
> - Use max_depth instead of num_elem logic, this logic is similar to what
> we are already using __bpf_get_stackid
> Link: https://lore.kernel.org/all/20251111003721.7629-1-listout@listout.xyz/
>
> Changes in v1:
> - RFC patch that restores the number of trace entries by setting
> trace_nr to trace_nr or num_elem based on whichever is the smallest.
> Link: https://lore.kernel.org/all/20251110211640.963-1-listout@listout.xyz/
> ---
>   kernel/bpf/stackmap.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 2365541c81dd..cef79d9517ab 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -426,7 +426,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   			    struct perf_callchain_entry *trace_in,
>   			    void *buf, u32 size, u64 flags, bool may_fault)
>   {
> -	u32 trace_nr, copy_len, elem_size, max_depth;
> +	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>   	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>   	bool crosstask = task && task != current;
>   	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> @@ -480,6 +480,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	}
>   
>   	trace_nr = trace->nr - skip;
> +	num_elem = size / elem_size;
> +	trace_nr = min_t(u32, trace_nr, num_elem);
>   	copy_len = trace_nr * elem_size;
>   
>   	ips = trace->ip + skip;

Thanks,
Arnaud


