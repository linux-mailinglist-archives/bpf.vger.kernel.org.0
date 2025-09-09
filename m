Return-Path: <bpf+bounces-67865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD9B4FBA0
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E7C3439B6
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E270533CEA4;
	Tue,  9 Sep 2025 12:47:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26E33A031;
	Tue,  9 Sep 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422074; cv=none; b=VbikPFQzjsi4Bm7cloU2fy8C6JLMLOxp74KAV/taK60rTjRvK/kM1TVX6yjXuUgh/yNXnPXXt3MQC+DreWcXTTEenp8K/9ZMz9Swk9FBGOHUWeOfsmgzh6UD6WRqadHctR2EY0o7fbITyZ54ZUOb4OHhnCyPGcLEWbZ8eTijy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422074; c=relaxed/simple;
	bh=cZWQkyz3vu7VXbwXXQdVxbPtlayMfh+bVyv92bVf5dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBypzs5KTUhOkj/QjkCW6PElFhkMCC/lEkqO6FLJSejhiWED9kC4qEhn8wsXPAdAFoeOHFnLJsVe6UyLMJwv257xwzlgnqza6tClpALQ+hr8cGoN2N2pZelLUkYNPHT5fK9hb068EYQaGadGhNZJqE+1fzZhlf7bX03+6X9Rc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [192.168.6.146] (54-240-197-233.amazon.com [54.240.197.233])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 0E19140CDC;
	Tue,  9 Sep 2025 12:47:43 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 54.240.197.233) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[192.168.6.146]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <93e5fc13-db88-4485-86bb-38a2cefbbf99@arnaud-lcm.com>
Date: Tue, 9 Sep 2025 13:47:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 3/3] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
To: alexei.starovoitov@gmail.com, yonghong.song@linux.dev, song@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250905134625.26531-1-contact@arnaud-lcm.com>
 <20250905134833.26791-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <20250905134833.26791-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175742206390.4717.5302255015320900576@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Hi,
Can you confirm you received this one Alexei as I got an undelivered 
email reply.
Cheers,
Arnaud

On 05/09/2025 14:48, Arnaud lecomte wrote:
> From: Arnaud Lecomte <contact@arnaud-lcm.com>
>
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
> when copying stack trace data. The issue occurs when the perf trace
>   contains more stack entries than the stack map bucket can hold,
>   leading to an out-of-bounds write in the bucket's data array.
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
> Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
> Changes in v2:
>   - Fixed max_depth names across get stack id
>
> Changes in v4:
>   - Removed unnecessary empty line in __bpf_get_stackid
>
> Changes in v6:
>   - Added back trace_len computation in __bpf_get_stackid
>
> Changes in v7:
>   - Removed usefull trace->nr assignation in bpf_get_stackid_pe
>   - Added restoration of trace->nr for both kernel and user traces
>     in bpf_get_stackid_pe
>
> Link to v7: https://lore.kernel.org/all/20250903234325.30212-1-contact@arnaud-lcm.com/
> ---
>   kernel/bpf/stackmap.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 9f3ae426ddc3..9b57b8307565 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -369,6 +369,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   {
>   	struct perf_event *event = ctx->event;
>   	struct perf_callchain_entry *trace;
> +	u32 elem_size, max_depth;
>   	bool kernel, user;
>   	__u64 nr_kernel;
>   	int ret;
> @@ -390,15 +391,16 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   		return -EFAULT;
>   
>   	nr_kernel = count_kernel_ip(trace);
> +	elem_size = stack_map_data_size(map);
> +	__u64 nr = trace->nr; /* save original */
>   
>   	if (kernel) {
> -		__u64 nr = trace->nr;
> -
>   		trace->nr = nr_kernel;
> +		max_depth =
> +			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		trace->nr = min_t(u32, nr_kernel, max_depth);
>   		ret = __bpf_get_stackid(map, trace, flags);
>   
> -		/* restore nr */
> -		trace->nr = nr;
>   	} else { /* user */
>   		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
>   
> @@ -407,8 +409,15 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   			return -EFAULT;
>   
>   		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> +		max_depth =
> +			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		trace->nr = min_t(u32, trace->nr, max_depth);
>   		ret = __bpf_get_stackid(map, trace, flags);
>   	}
> +
> +	/* restore nr */
> +	trace->nr = nr;
> +
>   	return ret;
>   }
>   

