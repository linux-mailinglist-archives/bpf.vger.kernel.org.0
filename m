Return-Path: <bpf+bounces-67513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E837B449DD
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C8D188D1B5
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE152EDD7D;
	Thu,  4 Sep 2025 22:41:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528582C11F6;
	Thu,  4 Sep 2025 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025704; cv=none; b=mSgMwxRw+oAIPse+XI1Qn1l8ZNZ7BkLdOAyBEEnG57PO8TC1tNmyQUkhsKHeBbxPbO5dzTnJXWpa51htxJ5IEBkEDfw7TEessaAcz1/Z08bbAwCRSapFcWTUxEU9FW2hVrtVZoy5aMBZOG1XXyJpDtka68y9ln65p0bT2WwTYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025704; c=relaxed/simple;
	bh=Mj6Jjm963g701aOuSUlznTI+56UIdzaERdh/LLHF/sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+/Sv+kXznJq0POqUCor3AvuyqkyjITeYfL7j7K/71FCnongW248RLI+hjhKpxK07QbX21ch6bindNP83zjt9RNWNcSe62h/DYcyYHEpgtn471wZvPNwjynf3ljYr8W1k8c3sZ8ykTMNQiU4G0nQLbfyuX6SFiHSpQv88mxLkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so1252680a12.0;
        Thu, 04 Sep 2025 15:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025702; x=1757630502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rR4c0cCihXaXaXcaj5qDsV34pNbLqiDLA3QR0PlKsxE=;
        b=e0k3PBHMwYvrv0OrMPGTi+xIkH47O611/E8gxSHHmtgUnCNs8QclVIgmFkHkVUMlfl
         EUdyjv2V2h6XcdXC2jNt8MIHYaeJ8ncnI7BON5jk3KytDSn/6ZM18DL7Y7st2gUReOMo
         pykfNGjtFfJ5TtrXAnJjXSgT654sdcYgnEcsPX6flyEFzvmo63WNzRCQ6G7FBVA5y5fh
         5/c3a4R0l6iF+aIC+AuMQTexd50Sg0Jp0IHCrcbMJ94SPYBPsrhStRIfsUkW2Wlft/jt
         SZwUjO7pOEG4J6WDDzSQxaCqvdkMtT05E1+V6AaV2MiSLNMMxyB23dh1I30KnN/sAk4d
         8ZVA==
X-Forwarded-Encrypted: i=1; AJvYcCVMHyFjej0wNvW5YJbzkT58evhDv+EM2PWcOHd8BOo1ae4n0RM57zKmSIO38VUfy9YiqmXziq7vNoOFLe9i@vger.kernel.org, AJvYcCW2+nyldFb93zggnZYJbF+UgfMN+G4Ndb1i49bPfS2Uxp8zpQQCyNGZboyEIwX4qMec1zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hVjQbbhkIsn2rzI6Vc8rz9TpoTfH3/f65cttb15zoHfbV4mK
	qfA96uoVtI8wG4ylbGMiZg8A05FksCCLxH6A4y7lpkfhYBYRQsKKp4+c
X-Gm-Gg: ASbGncuVCOSEEGVV/FuXOzejxBnl8/xQ3cHxCZVC5iK+zsCO0XP47wTdVOeALr5ZtjI
	OAqnub9SADGwJ7FvROLCi5/92HvmMzafohGD2ZzbKkmedf+eeNvuxCtn+w4iM116PlXy1HHZnxB
	cLhDBuHizWyqa1z5u4TSqF1+nMtysH+qUtsy7krIlNyiHOh0GDFNwuwU4evveqI/6Bhu3Inh3+T
	REIam88Lw0YNkr+OX7AUU7lD1dQqdv7llXSp6SKMgJ0k8+RS5y8VfV1eXF+YqIqevKlz1A5grYE
	boQgzNpr8sL9BJ0pjhCFswToQEy6ev1gP9OlhtMpNWG4CYNnR1CZur0Fc32Z5EAGJkVI64FRW6n
	wNh1/hDhRUCbrd8QkL+Nyvo8XOQ/3XM/su4lrZCun3zd5vQqnolqovHQoJJXsYj/kQyEyOLpRY5
	xX
X-Google-Smtp-Source: AGHT+IHoMBjZfiTNVOrOgH9FY3AjAhMRFIb4aYNAy7tLQn5JeC09PbAj5AVSpkaWolafSIL16kKoZA==
X-Received: by 2002:a17:902:f642:b0:240:11ba:3842 with SMTP id d9443c01a7336-24944a9a70emr261529115ad.35.1757025702562;
        Thu, 04 Sep 2025 15:41:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:499:89f8:cf94:6e72? ([2620:10d:c090:500::4:2ac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24d4d0fc0acsm1303535ad.69.2025.09.04.15.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 15:41:42 -0700 (PDT)
Message-ID: <405dca16-1d88-46de-a86f-67f9aa5e17f1@kernel.org>
Date: Thu, 4 Sep 2025 15:41:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 1/3] bpf: refactor max_depth computation in
 bpf_get_stack()
To: Arnaud Lecomte <contact@arnaud-lcm.com>, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250903233910.29431-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: Song Liu <song@kernel.org>
In-Reply-To: <20250903233910.29431-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/3/25 4:39 PM, Arnaud Lecomte wrote:
> A new helper function stack_map_calculate_max_depth() that
> computes the max depth for a stackmap.
>
> Changes in v2:
>   - Removed the checking 'map_size % map_elem_size' from
>     stack_map_calculate_max_depth
>   - Changed stack_map_calculate_max_depth params name to be more generic
>
> Changes in v3:
>   - Changed map size param to size in max depth helper
>
> Changes in v4:
>   - Fixed indentation in max depth helper for args
>
> Changes in v5:
>   - Bound back trace_nr to num_elem in __bpf_get_stack
>   - Make a copy of sysctl_perf_event_max_stack
>     in stack_map_calculate_max_depth
>
> Changes in v6:
>   - Restrained max_depth computation only when required
>   - Additional cleanup from Song in __bpf_get_stack
>
> Changes in v7:
>   - Removed additional cleanup from v6
>
> Link to v6: https://lore.kernel.org/all/20250903135323.97847-1-contact@arnaud-lcm.com/
>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Song Liu <song@kernel.org>


> ---
>   kernel/bpf/stackmap.c | 38 +++++++++++++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..ed707bc07173 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *map)
>   		sizeof(struct bpf_stack_build_id) : sizeof(u64);
>   }
>   
> +/**
> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
> + * @size:  Size of the buffer/map value in bytes
> + * @elem_size:  Size of each stack trace element
> + * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
> + *
> + * Return: Maximum number of stack trace entries that can be safely stored
> + */
> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 flags)
> +{
> +	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 max_depth;
> +	u32 curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
> +
> +	max_depth = size / elem_size;
> +	max_depth += skip;
> +	if (max_depth > curr_sysctl_max_stack)
> +		return curr_sysctl_max_stack;
> +
> +	return max_depth;
> +}
> +
>   static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>   {
>   	u64 elem_size = sizeof(struct stack_map_bucket) +
> @@ -300,20 +322,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
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
> -
> +	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
>   	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>   				   false, false);
>   
> @@ -406,8 +425,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   			    struct perf_callchain_entry *trace_in,
>   			    void *buf, u32 size, u64 flags, bool may_fault)
>   {
> -	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>   	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
> +	u32 trace_nr, copy_len, elem_size, max_depth;
>   	bool crosstask = task && task != current;
>   	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>   	bool user = flags & BPF_F_USER_STACK;
> @@ -438,10 +457,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   		goto clear;
>   	}
>   
> -	num_elem = size / elem_size;
> -	max_depth = num_elem + skip;
> -	if (sysctl_perf_event_max_stack < max_depth)
> -		max_depth = sysctl_perf_event_max_stack;
> +	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>   
>   	if (may_fault)
>   		rcu_read_lock(); /* need RCU for perf's callchain below */

