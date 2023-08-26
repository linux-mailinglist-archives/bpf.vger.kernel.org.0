Return-Path: <bpf+bounces-8747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B087896D3
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22F3281980
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E790DDAC;
	Sat, 26 Aug 2023 12:54:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50457320C
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 12:54:45 +0000 (UTC)
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB055173F
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 05:54:42 -0700 (PDT)
Received: from [192.168.1.33] (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id EE9BA200BE59;
	Sat, 26 Aug 2023 14:54:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be EE9BA200BE59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1693054480;
	bh=EcwrP0sLNU9S2Q1vwgJmmN3JDTx+bNJN7mLwNnq8l+Y=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=d2j8sy0lXirwPaDP/t5WoWZ+eN8ZdvebAq0q8bQsA+ArgVB2198M12hF5oMJ9VK2M
	 J8OqPKralHQRrLtgiL8nyNxHD0vs//XT/65rlVj/Fr/pt/5kCE29aBpKDJk9FJ7HRp
	 ZbETO08hSIlb+oCpASDqUFA26sl7NBX002yWmyG+nKER0VQACdMrZsm0/Bs2IIldsn
	 HSsz2lCkmTG+LmD0xjvEPW9xmPDQxO+YHMP+5+B/tAYYCEpPt+7MkYXYSrzsvOt3ZX
	 gXntF4HLCeFdrv6iTwrI3S6HS/WVQcJwus133I5BTI7FIjlCvNtINb1QljfPhFP4Tp
	 kfPjEwe+W6HIA==
Message-ID: <f9c2ab1f-42a9-f5eb-f9bf-63402c6a8a62@uliege.be>
Date: Sat, 26 Aug 2023 14:54:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [QUESTION] bpf/tc verifier error: invalid access to map value,
 min value is outside of the allowed memory range
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
References: <e3783201-3b28-3661-eee3-3b5fecad0964@uliege.be>
 <64e94c084c7a7_1b2e6208d@john.notmuch>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
Cc: justin.iurman@uliege.be
In-Reply-To: <64e94c084c7a7_1b2e6208d@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/26/23 02:49, John Fastabend wrote:
> Justin Iurman wrote:
>> Hello,
>>
>> I'm facing a verifier error and don't know how to make it happy (already
>> tried lots of checks). First, here is my env:
>>    - OS: Ubuntu 22.04.3 LTS
>>    - kernel: 5.15.0-79-generic x86_64 (CONFIG_DEBUG_INFO_BTF=y)
>>    - clang version: 14.0.0-1ubuntu1.1
>>    - iproute2-5.15.0 with libbpf 0.5.0
>>
>> And here is a simplified example of my program (basically, it will
>> insert in packets some bytes defined inside a map):
>>
>> #include "vmlinux.h"
>> #include <bpf/bpf_endian.h>
>> #include <bpf/bpf_helpers.h>
>>
>> #define MAX_BYTES 2048
>>
>> struct xxx_t {
>> 	__u32 bytes_len;
>> 	__u8 bytes[MAX_BYTES];
>> };
>>
>> struct {
>> 	__uint(type, BPF_MAP_TYPE_ARRAY);
>> 	__uint(max_entries, 1);
>> 	__type(key, __u32);
>> 	__type(value, struct xxx_t);
>> 	__uint(pinning, LIBBPF_PIN_BY_NAME);
>> } my_map SEC(".maps");
>>
>> char _license[] SEC("license") = "GPL";
>>
>> SEC("egress")
>> int egress_handler(struct __sk_buff *skb)
>> {
>> 	void *data_end = (void *)(long)skb->data_end;
>> 	void *data = (void *)(long)skb->data;
>> 	struct ethhdr *eth = data;
>> 	struct ipv6hdr *ip6;
>> 	struct xxx_t *x;
>> 	__u32 offset;
>> 	__u32 idx = 0;
>>
>> 	offset = sizeof(*eth) + sizeof(*ip6);
>> 	if (data + offset > data_end)
>> 		return TC_ACT_OK;
>>
>> 	if (bpf_ntohs(eth->h_proto) != ETH_P_IPV6)
>> 		return TC_ACT_OK;
>>
>> 	x = bpf_map_lookup_elem(&my_map, &idx);
>> 	if (!x)
>> 		return TC_ACT_OK;
>>
>> 	if (x->bytes_len == 0 || x->bytes_len > MAX_BYTES)
>> 		return TC_ACT_OK;
>>
>> 	if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
>> 		return TC_ACT_OK;
>>
>> 	if (bpf_skb_store_bytes(skb, offset, x->bytes, 8/*x->bytes_len*/,
> 
> You will see lots of folks & that value with something to
> ensure compiler/verifier get a solid upper/lower bounds.
> This is slightly kernel dependent the newer kernels are
> better at tracking bounds.
> 
> This should do what you want more or less,
> 
>    x->bytes_len &= 0x7ff

John,

Thanks for this. My bad, I should have explicitly listed the checks I 
already tried. In fact, what you mentioned above, as well as having the 
length on the stack, are part of my unsuccessful attempts. For instance, 
having the length on the stack combined with the min/max check gives the 
same result as x->bytes_len &= 0xfff:

R4_w=inv(id=2,umax_value=2048,var_off=(0x0; 0xfff))

... which is looking good (but still, no min value, which seems to be 
the issue here). More of it, when the length is on the stack:

; if (bpf_skb_store_bytes(skb, offset, x->bytes, len,
29: (bf) r1 = r7
30: (b7) r2 = 54
31: (bf) r3 = r8
32: (bf) r4 = r9
33: (b7) r5 = 1
34: (85) call bpf_skb_store_bytes#9
  R0=inv0 R1_w=ctx(id=0,off=0,imm=0) R2_w=inv54 
R3_w=map_value(id=0,off=4,ks=4,vs=2052,imm=0) 
R4_w=inv(id=2,umax_value=2048,var_off=(0x0; 0xfff)) R5_w=inv1 R6_w=inv1 
R7=ctx(id=0,off=0,imm=0) R8_w=map_value(id=0,off=4,ks=4,vs=2052,imm=0) 
R9=inv(id=2,umax_value=2048,var_off=(0x0; 0xfff)) R10=fp0 fp-8=mmmm????
invalid access to map value, value_size=2052 off=4 size=0
R3 min value is outside of the allowed memory range

So, whatever I try, it wouldn't set the min value. Besides, it complains 
about R3 (x->bytes), while it's clearly a problem with R4 (x->bytes_len, 
or in this case "len" on the stack). As a proof, if I set x->bytes_len 
to, e.g., 8 then it works.

I'll try with a more recent kernel version and see if it makes a 
difference. Are you aware of any other hack/solution for this verifier 
error, just in case?

Thanks,
Justin

