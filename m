Return-Path: <bpf+bounces-64637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA424B15133
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0F3BB484
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED28A2236EE;
	Tue, 29 Jul 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BL7klXIw"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DB60B8A
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806101; cv=none; b=kNGTmTnAKJ3SOyW9oaOhZ4qvcvR0lFgSIp7tRByyiqP9VbnoVZdbQwuFrLVtclNJKWVoB/NGmFcmgBGws3l8kK6Q5dPzYKvS7IorVdYnxcA4viRbi101tvm9Yttsrn8hdMOxHbvNvCKvqtIwVuRbAREVord4XbrNZBlUJ3oL/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806101; c=relaxed/simple;
	bh=nDqeQMc8QqMQMtEDcuoFQP9TMB98dTtaqGokDpWfztk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/AB/mu9krtc66qz/+3zkKKdeUWki2Dnqwk1FBVRqBgX6NAIP+jU00F9x865TQR1bwZTtDc9S6ZjcB5ApiGlD3t/2N/hTjxwhzrqoN2MBRjMX8A0RIufOTFFvNCSkbKx3fRL/biPLNehazMvYgHvZ41++PXnRU9Va1ct66Iwzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BL7klXIw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <004ec202-cbe7-4108-b6ac-1d947a5a54b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753806096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9G2bi5xpjlgjXNQuSwtBt852L0RAw8ifsZlb20kBVRI=;
	b=BL7klXIwM+YKx/GyuZN35hC2nFMgEIv6OBY20CuauyUfCTI3IB9oKTjeoIRbqlzVBVseMX
	soIxFpS371NGC0Q8xVa0UYdXMcJkeIxpA6lony/FLfPn6GuXob57f0/8/UKp8KqrbY6y9W
	fknkW98KoCcGS+5DVvKNaXoFXLlci4k=
Date: Tue, 29 Jul 2025 09:21:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix stackmap overflow check in __bpf_get_stackid()
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>, song@kernel.org
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
References: <20250729091901.26436-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250729091901.26436-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/29/25 2:19 AM, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
> when copying stack trace data. The issue occurs when the perf trace
>   contains more stack entries than the stack map bucket can hold,
>   leading to an out-of-bounds write in the bucket's data array.
> For build_id mode, we use sizeof(struct bpf_stack_build_id)
>   to determine capacity, and for normal mode we use sizeof(u64).
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
> Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
>   kernel/bpf/stackmap.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..0f9f6e4b6fe9 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -230,7 +230,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
>   	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
>   	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> -	u32 hash, id, trace_nr, trace_len, i;
> +	u32 hash, id, trace_nr, trace_len, i, max_depth;
>   	bool user = flags & BPF_F_USER_STACK;
>   	u64 *ips;
>   	bool hash_matches;
> @@ -241,6 +241,16 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   
>   	trace_nr = trace->nr - skip;
>   	trace_len = trace_nr * sizeof(u64);
> +
> +	/* Clamp the trace to max allowed depth */
> +	if (stack_map_use_build_id(map))
> +		max_depth = smap->map.value_size / sizeof(struct bpf_stack_build_id);
> +	else
> +		max_depth = smap->map.value_size / sizeof(u64);

Replace the above with
	max_depth = smap->map.value_size / stack_map_data_size(map)
?

> +
> +	if (trace_nr > max_depth)
> +		trace_nr = max_depth;
> +
>   	ips = trace->ip + skip;
>   	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>   	id = hash & (smap->n_buckets - 1);


