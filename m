Return-Path: <bpf+bounces-18831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADAA8225BC
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734C21C21B7F
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88C17994;
	Tue,  2 Jan 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RosBZsYq"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39D17984
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d79553a-a3f8-47c2-b1a7-d8c529a59a81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704239821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JALpgn0VNtb1UGJIRfsmGce4W2nzWe0TJ9n6zzc5X18=;
	b=RosBZsYqsmyXLQpVSG725dMALlQ1tmYMrw8IrqBl0HJfFPAlr5TM8/ojhelUnC/bsL0s1/
	RXWa6EylLu8bDgazHVY5lhMeh4BjU3G1+ynk7P17ZUyqG2KDTrHe0xDq8a2cq2gYpEslsm
	otkwhhCOmPp8ZXLpdi8sRo2pdoyupVk=
Date: Tue, 2 Jan 2024 15:56:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Funky verifier packet range error (> check works, != does not).
Content-Language: en-GB
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
References: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
 <CAEf4BzbowzKU+8tZTSnxPTG-x-2ypT-EshZxS+G+c3DeLtsA0w@mail.gmail.com>
 <CAHo-Oox+=KLhtdgwv7MFx7Yn9TYAy86_Z-b5Hw_BQ=BnLGrbGw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAHo-Oox+=KLhtdgwv7MFx7Yn9TYAy86_Z-b5Hw_BQ=BnLGrbGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/2/24 2:45 PM, Maciej Żenczykowski wrote:
> On Tue, Jan 2, 2024 at 1:46 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Fri, Dec 29, 2023 at 5:31 PM Maciej Żenczykowski
>> <zenczykowski@gmail.com> wrote:
>>> I have a relatively complex program that fails to load on 6.5.6 with a
>>>
>>> if (data + 98 != data_end) return TC_ACT_SHOT;
>>>
>> How realistic is such code in practice? Is there a situation in which
>> it's critical to ensure that the packet has exactly X bytes in [data,
>> data_end) range? Even in that case we can have data in frags, though,
>> right? So I'm just wondering if we are discussing some rather
>> theoretical situation?
> So, as I mentioned I hit this while debugging some other complex code,
> so the example 98 isn't a particularly good value
> (when I actually hit this I think I was trying to match some ping packets).
>
> However, elsewhere in the same program I need to match and reply to
> IPv6 NS packets
> (for an IPv6 address the kernel doesn't own, to workaround a pair of
> kernel bugs / missing features in ipv6 neigh proxy).
>
> In practice the NS I receive and need to handle are always:
>    14 ethernet + 40 ipv6 + 8 icmp6 + 16 target + 8 byte link address
> option = 86 bytes long
> (and if they're not, then my current code can't parse them anyway)
> so it's natural to do something like:
>
> handle_ns_with_laddr(struct __sk_buff *skb) {
>    if (skb->data + 86 != skb->data_end) return;

So you want to test the precise packet length, right?
Does the following work?
    if (skb->data + 86 > skb->data_end) return;
    /* skb->data + 86 <= sbk->data_end, so you can access up to 86 bytes */

>    struct ethernet_ipv6_ns *pkt = data;
>    if (pkt->ether.h_proto != htons(ETH_P_IPV6)) return;
>    if (pkt->ip6.nexthdr != IPPROTO_ICMPV6) return;
>    ...etc...
> }
>
> Yeah, there's lots of caveats in the above (lack of pull, etc), but it
> is enough to handle the case I need handled...
>
> Obviously I could rewrite the above as:
>    if (skb->data + 86 > skb->data_end) return;
>    if (skb->data + 86 < skb->data_end) return;
>
> though I guess a too smart compiler could optimize that back down to == ...

I didn't try. but yes, it is possible.

>
>>> check, that loads fine if I change the above != to (a you would think
>>> weaker) > check.
>>>
>>> It's not important, hit this while debugging, and I don't know if the
>>> cause is the verifier treating != differently than > or the compiler
>>> optimizing != somehow... but my gut feeling is on the former: some
>>> verifier logic special cases > without doing something similar for the
>>> stronger != comparison.
>>>
>>> ...
>>> 453: (85) call bpf_trace_printk#6     ; R0_w=scalar()
>>> ; if (data + 98 != data_end) return TC_ACT_SHOT;
>>> 454: (bf) r1 = r6                     ; R1_w=pkt(off=0,r=42,imm=0)
>>> R6=pkt(off=0,r=42,imm=0)
>>> 455: (07) r1 += 98                    ; R1_w=pkt(off=98,r=42,imm=0)
>>> ; if (data + 98 != data_end) return TC_ACT_SHOT;
>>> 456: (5d) if r1 != r9 goto pc-23      ; R1_w=pkt(off=98,r=42,imm=0)
>>> R9=pkt_end(off=0,imm=0)
>>> *** IMHO here r=42 should be bumped to 98 ***
>>> 457: (bf) r3 = r6                     ; R3_w=pkt(off=0,r=42,imm=0)
>>> R6=pkt(off=0,r=42,imm=0)
>>> 458: (07) r3 += 34                    ; R3_w=pkt(off=34,r=42,imm=0)
>>> ; uint64_t cs = bpf_csum_diff(NULL, 0, data + 14 + 20, 98 - 14 - 20, 0xFFFF);
>>> 459: (b7) r1 = 0                      ; R1_w=0
>>> 460: (b7) r2 = 0                      ; R2_w=0
>>> 461: (b7) r4 = 64                     ; R4_w=64
>>> 462: (b7) r5 = 65535                  ; R5_w=65535
>>> 463: (85) call bpf_csum_diff#28
>>> invalid access to packet, off=34 size=64, R3(id=0,off=34,r=42)
>>> R3 offset is outside of the packet
>>>
>>> Side note: bpf_csum_diff() is super non user-friendly, but that's for
>>> another thread...
>>>
>>> Happy New Year,
>>> Maciej
>>>

