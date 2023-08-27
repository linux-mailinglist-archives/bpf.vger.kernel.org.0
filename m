Return-Path: <bpf+bounces-8806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42FF78A050
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 18:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FCC280F3A
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947911199;
	Sun, 27 Aug 2023 16:56:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F6100AE
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 16:56:43 +0000 (UTC)
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9647FA9
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 09:56:41 -0700 (PDT)
Received: from [192.168.1.33] (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6CCD8200AA5B;
	Sun, 27 Aug 2023 18:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6CCD8200AA5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1693155398;
	bh=GNH00vcRol0t8Qz+U/UQEB9Ql0F0TwgndyDwS0ZX6tQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=krlH9lrBhbbkSjrbNuPWOb+vrx15uejxQogliS9alfHdfgyqgV4sRmtB57Raq46Mm
	 J3rEIgKotzUacw/LrTED9BCXTGmsIVNFtt6+N8GrnIDoT5BKK4Kr7V/fKJeIq2d+aF
	 bA7kxxpUJlx/42DdUzkhg2Pr+shIWHR7CbJnuchU2fCCi1VVemuwBdfoa31B7/NxkT
	 NGdix2etNCvWW6EuTY5DtH+k4MwVhyv0E5KrtmSBC/V752AehRHrDWdxvZUF2K4soa
	 tc6UIy/qFBE2zmImtUPtS6I4OGF+kyGu/tH18PEjJR7WiHGPh589FkDow/Cpm3l0jE
	 ME9FUvrzgcp5g==
Message-ID: <4a968667-5061-83bf-a302-3d455065b461@uliege.be>
Date: Sun, 27 Aug 2023 18:56:36 +0200
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
Cc: justin.iurman@uliege.be
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <64e94c084c7a7_1b2e6208d@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

FYI, with bytes_len on the stack (no direct access) and a min check 
above 1, it works (I thought I already tried it, but I suspect I did on 
direct access only). What's funny though is that the verifier still 
fails on the exact same code with a recent kernel.

So, "bytes_len == 0" or "bytes_len < 1" doesn't work, but "bytes_len < 
2" works (which is weird). Fortunately, I need a min value of 8, which 
makes the hack OK, but I'm still trying to understand what's going on 
here. And, as mentioned, it does not work with direct access (i.e., 
"x->bytes_len < 2").

Thanks,
Justin

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

