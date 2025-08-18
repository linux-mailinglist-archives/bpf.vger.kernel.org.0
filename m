Return-Path: <bpf+bounces-65888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A1B2A878
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 16:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12DE687607
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EA0335BDD;
	Mon, 18 Aug 2025 13:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D672192F4;
	Mon, 18 Aug 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524986; cv=none; b=Q8XvheK6vTKkVBh3hLt0VCC/OQDh1MT5fGLQNgqMz0MJCidQUX8tbI9ieXJrjpNfB+me3elkpTzo8lxL48oqu/uHFfcsjR+ZOeGCu8xt/5HLocoqsnK90aAjv3z1SOyJZGdv1XWxUJNNiNKKWdkCnsllZt4xaYE5SB3lO9VW19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524986; c=relaxed/simple;
	bh=LV+zhdbyyEIYjj0nARVB8R+2AH6pHyLPKHDXfrn4wjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZfPwdsRQD4UB2YPx06kQivO+h+5Tntn6u9vn7Xg7E/+Qmq4Pea6uuoNhXnmImJpXaKG56paacCybiaPEObw+OjeZv+HKfaogWSj9zieMtUv7Ck7M1fBtzRE9Pzxts12dYF8r7kv6OCK/eO3KwX0u1UtMe8pmBWrmJmW6b7iZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.17.112.211] (unknown [15.248.3.83])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 644AB40B1F;
	Mon, 18 Aug 2025 13:49:35 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 15.248.3.83) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.17.112.211]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <07d849b2-67c2-40b2-9cd3-75b8f3a4e0a6@arnaud-lcm.com>
Date: Mon, 18 Aug 2025 14:49:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
To: song@kernel.org, jolsa@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <20250813204606.167019-1-contact@arnaud-lcm.com>
 <20250813205506.168069-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <20250813205506.168069-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175552497619.9428.7858426650122712005@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Hey,
Just forwarding the patch to the associated maintainers with `stackmap.c`.
Have a great day,
Cheers

On 13/08/2025 21:55, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
> when copying stack trace data. The issue occurs when the perf trace
>   contains more stack entries than the stack map bucket can hold,
>   leading to an out-of-bounds write in the bucket's data array.
>
> Changes in v2:
>   - Fixed max_depth names across get stack id
>
> Changes in v4:
>   - Removed unnecessary empty line in __bpf_get_stackid
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
>   kernel/bpf/stackmap.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index b9cc6c72a2a5..318f150460bb 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -246,7 +246,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>   }
>   
>   static long __bpf_get_stackid(struct bpf_map *map,
> -			      struct perf_callchain_entry *trace, u64 flags)
> +			      struct perf_callchain_entry *trace, u64 flags, u32 max_depth)
>   {
>   	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
>   	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> @@ -262,6 +262,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   
>   	trace_nr = trace->nr - skip;
>   	trace_len = trace_nr * sizeof(u64);
> +	trace_nr = min(trace_nr, max_depth - skip);
> +
>   	ips = trace->ip + skip;
>   	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>   	id = hash & (smap->n_buckets - 1);
> @@ -321,19 +323,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   	   u64, flags)
>   {
> -	u32 max_depth = map->value_size / stack_map_data_size(map);
> -	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 elem_size = stack_map_data_size(map);
>   	bool user = flags & BPF_F_USER_STACK;
>   	struct perf_callchain_entry *trace;
>   	bool kernel = !user;
> +	u32 max_depth;
>   
>   	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>   			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>   		return -EINVAL;
>   
> -	max_depth += skip;
> -	if (max_depth > sysctl_perf_event_max_stack)
> -		max_depth = sysctl_perf_event_max_stack;
> +	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
>   
>   	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>   				   false, false);
> @@ -342,7 +342,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   		/* couldn't fetch the stack trace */
>   		return -EFAULT;
>   
> -	return __bpf_get_stackid(map, trace, flags);
> +	return __bpf_get_stackid(map, trace, flags, max_depth);
>   }
>   
>   const struct bpf_func_proto bpf_get_stackid_proto = {
> @@ -374,6 +374,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   	bool kernel, user;
>   	__u64 nr_kernel;
>   	int ret;
> +	u32 elem_size, max_depth;
>   
>   	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
>   	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> @@ -392,12 +393,13 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   		return -EFAULT;
>   
>   	nr_kernel = count_kernel_ip(trace);
> -
> +	elem_size = stack_map_data_size(map);
>   	if (kernel) {
>   		__u64 nr = trace->nr;
>   
>   		trace->nr = nr_kernel;
> -		ret = __bpf_get_stackid(map, trace, flags);
> +		max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		ret = __bpf_get_stackid(map, trace, flags, max_depth);
>   
>   		/* restore nr */
>   		trace->nr = nr;
> @@ -409,7 +411,8 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   			return -EFAULT;
>   
>   		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> -		ret = __bpf_get_stackid(map, trace, flags);
> +		max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		ret = __bpf_get_stackid(map, trace, flags, max_depth);
>   	}
>   	return ret;
>   }

