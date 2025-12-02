Return-Path: <bpf+bounces-75881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C2C9BB04
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3155E4E38E1
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA632145E;
	Tue,  2 Dec 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="holVvdBa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CC214228;
	Tue,  2 Dec 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684051; cv=none; b=j14jQEHXp5DAtfi72eTQestreE0sG4z2B0bAP8atpI7Djwke7RxwefALg9ZMMaL2kyNelSFD/iv0X3KYjHxc221KFoCpGLAiSgN2raSQHYgDBCOsYErYQWGSEKufqBXBLS6NLKnKuaKEWWPchoZ7UJkmlgE+4R6gl/MC2HxFGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684051; c=relaxed/simple;
	bh=BCmyooWFB1Onrmk3rzggEaz2JopyodojzKz/ahsp6bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udMrMthuagDcgE8+CB9X7+zVVP9z7Rnt3DmE65ghL/M7WcT1ybODxg/iwA+gyx3GrkzR44hsHGCWUZ7nHjIhUK8ipH9hU8+Yu2l6z+186BIMjfENYbpCYNx1MmXWXXAn0pTUXrs1g7uIPO5tA1noGjBIzV65CcchyGylmB9dcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=holVvdBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E39C4CEF1;
	Tue,  2 Dec 2025 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764684048;
	bh=BCmyooWFB1Onrmk3rzggEaz2JopyodojzKz/ahsp6bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=holVvdBafg2LNLuu6NFrMBIbSwkdQT0MkXb61FPS6B5SeFoYHf3X6rlzQf8NOYfIR
	 tmxI5AaiAlQwoH6v6Wt7grVdLa8ktM2McaahHyE/MhMlK5wOYrTS+IvuLnAwV3YhCF
	 wyDz16p7uzBw3/VwH3N+Ir1sow0rb/DkAnhh+CqSaPxURgVLM6yb5nDL/U+CfmQAgk
	 Ow6JrkK7foB5fhvesTQbtwGqPdaNs08CTkIRDYTen9PynzRpd/Z5nqZVgojliwiwZS
	 dB6CUB2ad30FAJw6ksnw9pje0Lhn4C5Sa7G7UYstMD1V78emfa93bKFngjCQXeMpwm
	 P6ZfAjN+j6d2A==
Message-ID: <cfc0a5b0-f906-4b23-a47e-dbf56291915b@kernel.org>
Date: Tue, 2 Dec 2025 15:00:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] xdp: Delegate fast path return decision to page_pool
To: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
 Toshiaki Makita <toshiaki.makita1@gmail.com>,
 David Ahern <dsahern@kernel.org>, Toke Hoiland Jorgensen <toke@redhat.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>, KP Singh <kpsingh@kernel.org>,
 kernel-team <kernel-team@cloudflare.com>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
 <20251107102853.1082118-5-dtatulea@nvidia.com>
 <d0fc4c6a-c4d7-4d62-9e6f-6c05c96a51de@kernel.org>
 <4eusyirzvomxwkzib5tqfyrcgjcxoplrsf7jctytvyvrfvi5fr@f3lvd5h2kb2p>
 <58b50903-7969-46bd-bd73-60629c00f057@kernel.org>
 <wrhhvaolxu275zw3fxgvykg7tndzp4pl4u3mnw3z4t5yfbkpix@i2abs45et7tr>
 <ad6c4448-8fb3-4a5c-91b0-8739f95cf65b@nvidia.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <ad6c4448-8fb3-4a5c-91b0-8739f95cf65b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 01/12/2025 11.12, Dragos Tatulea wrote:
> 
> 
> [...]
>>> And then you can run thus command:
>>>   sudo ./xdp-bench redirect-map --load-egress mlx5p1 mlx5p1
>>>
>> Ah, yes! I was ignorant about the egress part of the program.
>> That did the trick. The drop happens before reaching the tx
>> queue of the second netdev and the mentioned code in devmem.c
>> is reached.
>>
>> Sender is xdp-trafficgen with 3 threads pushing enough on one RX queue
>> to saturate the CPU.
>>
>> Here's what I got:
>>
>> * before:
>>
>> eth2->eth3             16,153,328 rx/s         16,153,329 err,drop/s            0 xmit/s
>>    xmit eth2->eth3               0 xmit/s       16,153,329 drop/s                0 drv_err/s         16.00 bulk-avg
>> eth2->eth3             16,152,538 rx/s         16,152,546 err,drop/s            0 xmit/s
>>    xmit eth2->eth3               0 xmit/s       16,152,546 drop/s                0 drv_err/s         16.00 bulk-avg
>> eth2->eth3             16,156,331 rx/s         16,156,337 err,drop/s            0 xmit/s
>>    xmit eth2->eth3               0 xmit/s       16,156,337 drop/s                0 drv_err/s         16.00 bulk-avg
>>
>> * after:
>>
>> eth2->eth3             16,105,461 rx/s         16,105,469 err,drop/s            0 xmit/s
>>    xmit eth2->eth3               0 xmit/s       16,105,469 drop/s                0 drv_err/s         16.00 bulk-avg
>> eth2->eth3             16,119,550 rx/s         16,119,541 err,drop/s            0 xmit/s
>>    xmit eth2->eth3               0 xmit/s       16,119,541 drop/s                0 drv_err/s         16.00 bulk-avg
>> eth2->eth3             16,092,145 rx/s         16,092,154 err,drop/s            0 xmit/s
>>    xmit eth2->eth3               0 xmit/s       16,092,154 drop/s                0 drv_err/s         16.00 bulk-avg
>>
>> So slightly worse... I don't fully trust the measurements though as I
>> saw the inverse situation in other tests as well: higher rate after the
>> patch.

Remember that you are also removing some code (the
xdp_set_return_frame_no_direct and xdp_clear_return_frame_no_direct).
Thus, I was actually hoping we would see a higher rate after the patch.
This is why I wanted to see this XDP-redirect test, instead of the
page_pool micro-benchmark.


> I had a chance to re-run this on a more stable system and the conclusion
> is the same. Performance is ~2 % worse:
> 
> * before:
> eth2->eth3        13,746,431 rx/s   13,746,471 err,drop/s 0 xmit/s
>    xmit eth2->eth3          0 xmit/s 13,746,471 drop/s     0 drv_err/s 16.00 bulk-avg
> 
> * after:
> eth2->eth3        13,437,277 rx/s   13,437,259 err,drop/s 0 xmit/s
>    xmit eth2->eth3          0 xmit/s 13,437,259 drop/s     0 drv_err/s 16.00 bulk-avg
> 
> After this experiment it doesn't seem like this direction is worth
> proceeding with... I was more optimistic at the start.

I do think it is worth proceeding.  I will claim that your PPS results
are basically the same. Converting PPS number to nanosec per packet:

  13,746,471 = (1/13746471*10^9) = 72.74 nanosec
  13,437,259 = (1/13437259*10^9) = 74.42 nanosec
  Difference is  = (74.42-72.75) =  1.67 nanosec

In my experience it is very hard to find a system stable enough to
measure a 2 nanosec difference. As you also note you had to spend effort
finding a stable system.  Thus, I claim your results show no noticeable
performance impact.

My only concern (based on your perf symbols) is that you might not be
testing the right/expected code path.  If mlx5 is running with a
page_pool memory mode that have elevated refcnf on the page, then we
will not be exercising the slower page_pool ptr_ring return path as much
as expected.  I guess, I have to do this experiment in my own testlab on
other NIC drivers that doesn't use elevated refcnt as default.


>>>> Toke (and I) will appreciate if you added code for this to xdp-bench.
>>> Supporting a --program-mode like 'redirect-cpu' does.
>>>
>>>
>> Ok. I will add it.
>>
> Added it here:
> https://github.com/xdp-project/xdp-tools/pull/532
>

Thanks, I'll take a look, and I'm sure Toke have opinions on the cmdline
options and the missing man-page update.

--Jesper

