Return-Path: <bpf+bounces-74190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6964C4C31D
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 08:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0341883AC7
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAAC2E6127;
	Tue, 11 Nov 2025 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUN8D2pK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3902D8780;
	Tue, 11 Nov 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847686; cv=none; b=M4Mekz4fJ/6HMqjebF/uFrejfXFbEQCQ7roDHQ4/zMFOEwwLQUG/hh+7vEqQa+l+JHJdyxlFGfr80oRr6D73PvxY4oBrPftsblLh5XHZH50+TcuFRi04oOIZy8+tOfpPRZsUleUTFOGZVtSvgEE0q2ytN/q/STLcMECmkwRDCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847686; c=relaxed/simple;
	bh=cab3bFbXC1ctOtMaRskBvsdtCVCk3ww3mrmpzidCyhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ9QsJvFP6fqPEsb78PYi4iCF3j3AuR03hhNTuGxW10R8iJXNmR5EXwyb20pKIpYhCTCThOW6cGX39N2o1kSRy5r/GOGM9RdSJS9yfnEgDzU5QtJ0cuB6HrAE9ri6rDFpv+tuBx0XKuoS0VjNtrXHwLYs6nAGoPDbixkzaQD+1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUN8D2pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF60AC116B1;
	Tue, 11 Nov 2025 07:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762847685;
	bh=cab3bFbXC1ctOtMaRskBvsdtCVCk3ww3mrmpzidCyhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RUN8D2pKjUTFlWlrN27hScipRg8okNOcXZCebtbIACpvVOO+GnlGvC5zIAfjNos4Z
	 yfnVKR4dhj+HccU5SKFwZDK9p4YRqJHvUyhajiPyPyGSC9quYW9RZKc2xibHxMtli8
	 68xXpXzacZKY2oGiGYebk/ysm5RWVfDy5Nw/U+B6aChpW0sNBvWdRPVvYgVNVg+cbP
	 vNJiLemRuikhXcSHE/zXKjISiwwrrzJ/XgEyOa3Xpj39N3CrKrr7BsRnPUuGO7tOnF
	 beW2BTlMXW9eDWT5sXtcsW5A5Lu1zWGA1o25O0K9+s0YaKZuP77N57htvnq4M1CIiq
	 J/4RpPuuBUPPg==
Message-ID: <58b50903-7969-46bd-bd73-60629c00f057@kernel.org>
Date: Tue, 11 Nov 2025 08:54:37 +0100
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
 Martin KaFai Lau <martin.lau@linux.dev>, KP Singh <kpsingh@kernel.org>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
 <20251107102853.1082118-5-dtatulea@nvidia.com>
 <d0fc4c6a-c4d7-4d62-9e6f-6c05c96a51de@kernel.org>
 <4eusyirzvomxwkzib5tqfyrcgjcxoplrsf7jctytvyvrfvi5fr@f3lvd5h2kb2p>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <4eusyirzvomxwkzib5tqfyrcgjcxoplrsf7jctytvyvrfvi5fr@f3lvd5h2kb2p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/2025 19.51, Dragos Tatulea wrote:
> On Mon, Nov 10, 2025 at 12:06:08PM +0100, Jesper Dangaard Brouer wrote:
>>
>>
>> On 07/11/2025 11.28, Dragos Tatulea wrote:
>>> XDP uses the BPF_RI_F_RF_NO_DIRECT flag to mark contexts where it is not
>>> allowed to do direct recycling, even though the direct flag was set by
>>> the caller. This is confusing and can lead to races which are hard to
>>> detect [1].
>>>
>>> Furthermore, the page_pool already contains an internal
>>> mechanism which checks if it is safe to switch the direct
>>> flag from off to on.
>>>
>>> This patch drops the use of the BPF_RI_F_RF_NO_DIRECT flag and always
>>> calls the page_pool release with the direct flag set to false. The
>>> page_pool will decide if it is safe to do direct recycling. This
>>> is not free but it is worth it to make the XDP code safer. The
>>> next paragrapsh are discussing the performance impact.
>>>
>>> Performance wise, there are 3 cases to consider. Looking from
>>> __xdp_return() for MEM_TYPE_PAGE_POOL case:
>>>
>>> 1) napi_direct == false:
>>>     - Before: 1 comparison in __xdp_return() + call of
>>>       page_pool_napi_local() from page_pool_put_unrefed_netmem().
>>>     - After: Only one call to page_pool_napi_local().
>>>
>>> 2) napi_direct == true && BPF_RI_F_RF_NO_DIRECT
>>>     - Before: 2 comparisons in __xdp_return() + call of
>>>       page_pool_napi_local() from page_pool_put_unrefed_netmem().
>>>     - After: Only one call to page_pool_napi_local().
>>>
>>> 3) napi_direct == true && !BPF_RI_F_RF_NO_DIRECT
>>>     - Before: 2 comparisons in __xdp_return().
>>>     - After: One call to page_pool_napi_local()
>>>
>>> Case 1 & 2 are the slower paths and they only have to gain.
>>> But they are slow anyway so the gain is small.
>>>
>>> Case 3 is the fast path and is the one that has to be considered more
>>> closely. The 2 comparisons from __xdp_return() are swapped for the more
>>> expensive page_pool_napi_local() call.
>>>
>>> Using the page_pool benchmark between the fast-path and the
>>> newly-added NAPI aware mode to measure [2] how expensive
>>> page_pool_napi_local() is:
>>>
>>>     bench_page_pool: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
>>>     bench_page_pool: Type:tasklet_page_pool01_fast_path Per elem: 15 cycles(tsc) 7.537 ns (step:0)
>>>
>>>     bench_page_pool: time_bench_page_pool04_napi_aware(): in_serving_softirq fast-path
>>>     bench_page_pool: Type:tasklet_page_pool04_napi_aware Per elem: 20 cycles(tsc) 10.490 ns (step:0)
>>>
>>
>> IMHO fast-path slowdown is significant.  This fast-path is used for the
>> XDP_DROP use-case in drivers.  The fast-path is competing with the speed
>> of updating an (per-cpu) array and a function-call overhead. The
>> performance target for XDP_DROP is NIC *wirespeed* which at 100Gbit/s is
>> 148Mpps (or 6.72ns between packets).
>>
>> I still want to seriously entertain this idea, because (1) because the
>> bug[1] was hard to find, and (2) this is mostly an XDP API optimization
>> that isn't used by drivers (they call page_pool APIs directly for
>> XDP_DROP case).
>> Drivers can do this because they have access to the page_pool instance.
>>
>> Thus, this isn't a XDP_DROP use-case.
>>   - This is either XDP_REDIRECT or XDP_TX use-case.
>>
>> The primary change in this patch is, changing the XDP API call
>> xdp_return_frame_rx_napi() effectively to xdp_return_frame().
>>
>> Looking at code users of this call:
>>   (A) Seeing a number of drivers using this to speed up XDP_TX when
>> *completing* packets from TX-ring.
>>   (B) drivers/net/xen-netfront.c use looks incorrect.
>>   (C) drivers/net/virtio_net.c use can easily be removed.
>>   (D) cpumap.c and drivers/net/tun.c should not be using this call.
>>   (E) devmap.c is the main user (with multiple calls)
>>
>> The (A) user will see a performance drop for XDP_TX, but these driver
>> should be able to instead call the page_pool APIs directly as they
>> should have access to the page_pool instance.
>>
>> Users (B)+(C)+(D) simply needs cleanup.
>>
>> User (E): devmap is the most important+problematic user (IIRC this was
>> the cause of bug[1]).  XDP redirecting into devmap and running a new
>> XDP-prog (per target device) was a prime user of this call
>> xdp_return_frame_rx_napi() as it gave us excellent (e.g. XDP_DROP)
>> performance.
>>
> Thanks for the analysis Jesper.

Thanks for working on this! It is long over due, that we clean this up.
I think I spotted another bug in veth related to
xdp_clear_return_frame_no_direct() and when NAPI exits.

>> Perhaps we should simply measure the impact on devmap + 2nd XDP-prog
>> doing XDP_DROP.  Then, we can see if overhead is acceptable... ?
>>
> Will try. Just to make sure we are on the same page, AFAIU the setup
> would be:
> XDP_REDIRECT NIC1 -> veth ingress side and XDP_DROP veth egress side?

No, this isn't exactly what I meant. But the people that wrote this
blogpost ([1] https://loopholelabs.io/blog/xdp-for-egress-traffic ) is
dependent on the performance for that scenario with veth pairs.

When doing redirect-map, then you can attach a 2nd XDP-prog per map
target "egress" device.  That 2nd XDP-prog should do a XDP_DROP as that
will allow us to measure the code path we are talking about. I want test
to hit this code line [2].
[2] https://elixir.bootlin.com/linux/v6.17.7/source/kernel/bpf/
devmap.c#L368.

The xdp-bench[3] tool unfortunately support program-mode for 2nd XDP-
prog, so I did this code change:

diff --git a/xdp-bench/xdp_redirect_devmap.bpf.c 
b/xdp-bench/xdp_redirect_devmap.bpf.c
index 0212e824e2fa..39a24f8834e8 100644
--- a/xdp-bench/xdp_redirect_devmap.bpf.c
+++ b/xdp-bench/xdp_redirect_devmap.bpf.c
@@ -76,6 +76,8 @@ int xdp_redirect_devmap_egress(struct xdp_md *ctx)
         struct ethhdr *eth = data;
         __u64 nh_off;

+       return XDP_DROP;
+
         nh_off = sizeof(*eth);
         if (data + nh_off > data_end)
                 return XDP_DROP;

[3] https://github.com/xdp-project/xdp-tools/tree/main/xdp-bench

And then you can run thus command:
  sudo ./xdp-bench redirect-map --load-egress mlx5p1 mlx5p1

Toke (and I) will appreciate if you added code for this to xdp-bench.
Supporting a --program-mode like 'redirect-cpu' does.


> 
>>> ... and the slow path for reference:
>>>
>>>     bench_page_pool: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
>>>     bench_page_pool: Type:tasklet_page_pool02_ptr_ring Per elem: 30 cycles(tsc) 15.395 ns (step:0)
>>
>> The devmap user will basically fallback to using this code path.
>>
> Yes, if the page_pool is not NAPI aware.
> 
> Thanks,
> Dragos


