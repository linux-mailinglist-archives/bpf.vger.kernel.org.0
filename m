Return-Path: <bpf+bounces-8873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3D878BC30
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 02:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BBE280F27
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440787FA;
	Tue, 29 Aug 2023 00:40:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B17E8
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 00:40:13 +0000 (UTC)
Received: from out-251.mta1.migadu.com (out-251.mta1.migadu.com [IPv6:2001:41d0:203:375::fb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC01DF
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:40:12 -0700 (PDT)
Message-ID: <f464186c-0353-9f9e-0271-e70a30e2fcdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693269610; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoM9afWB4mL62fZAPn0G3oWtG9o7pvznwXovwDq6dL8=;
	b=ry9+8bbJoMfVMI3sexs1PfaCSPH6m2T9aDiiuZIAlOWQDvbdxodx7iumBbqBwvrfPVJbeN
	ZLe8QtVwyXJ803F/KbLX3fOgpCfXSCX5x2GZ9RxeIEtISAECg7vJCklg+KpeoSKQ9RERUw
	ZC58OgI1CTQ06goBNxtqUJo2xw6sHFs=
Date: Mon, 28 Aug 2023 20:40:07 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [QUESTION] bpf/tc verifier error: invalid access to map value,
 min value is outside of the allowed memory range
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Justin Iurman <justin.iurman@uliege.be>
References: <e3783201-3b28-3661-eee3-3b5fecad0964@uliege.be>
 <98af45809e7276431b7d053bfe8b26d98b2f9394.camel@gmail.com>
 <ffa8d7aa2e77fb843a4b94c3be45bc9297e7b3a2.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ffa8d7aa2e77fb843a4b94c3be45bc9297e7b3a2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/28/23 6:25 AM, Eduard Zingerman wrote:
> On Mon, 2023-08-28 at 15:46 +0300, Eduard Zingerman wrote:
>> On Thu, 2023-08-24 at 22:32 +0200, Justin Iurman wrote:
>>> Hello,
>>>
>>> I'm facing a verifier error and don't know how to make it happy (already
>>> tried lots of checks). First, here is my env:
>>>    - OS: Ubuntu 22.04.3 LTS
>>>    - kernel: 5.15.0-79-generic x86_64 (CONFIG_DEBUG_INFO_BTF=y)
>>>    - clang version: 14.0.0-1ubuntu1.1
>>>    - iproute2-5.15.0 with libbpf 0.5.0
>>>
>>> And here is a simplified example of my program (basically, it will
>>> insert in packets some bytes defined inside a map):
>>>
>>> #include "vmlinux.h"
>>> #include <bpf/bpf_endian.h>
>>> #include <bpf/bpf_helpers.h>
>>>
>>> #define MAX_BYTES 2048
>>>
>>> struct xxx_t {
>>> 	__u32 bytes_len;
>>> 	__u8 bytes[MAX_BYTES];
>>> };
>>>
>>> struct {
>>> 	__uint(type, BPF_MAP_TYPE_ARRAY);
>>> 	__uint(max_entries, 1);
>>> 	__type(key, __u32);
>>> 	__type(value, struct xxx_t);
>>> 	__uint(pinning, LIBBPF_PIN_BY_NAME);
>>> } my_map SEC(".maps");
>>>
>>> char _license[] SEC("license") = "GPL";
>>>
>>> SEC("egress")
>>> int egress_handler(struct __sk_buff *skb)
>>> {
>>> 	void *data_end = (void *)(long)skb->data_end;
>>> 	void *data = (void *)(long)skb->data;
>>> 	struct ethhdr *eth = data;
>>> 	struct ipv6hdr *ip6;
>>> 	struct xxx_t *x;
>>> 	__u32 offset;
>>> 	__u32 idx = 0;
>>>
>>> 	offset = sizeof(*eth) + sizeof(*ip6);
>>> 	if (data + offset > data_end)
>>> 		return TC_ACT_OK;
>>>
>>> 	if (bpf_ntohs(eth->h_proto) != ETH_P_IPV6)
>>> 		return TC_ACT_OK;
>>>
>>> 	x = bpf_map_lookup_elem(&my_map, &idx);
>>> 	if (!x)
>>> 		return TC_ACT_OK;
>>>
>>> 	if (x->bytes_len == 0 || x->bytes_len > MAX_BYTES)
>>> 		return TC_ACT_OK;
>>>
>>> 	if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
>>> 		return TC_ACT_OK;
>>>
>>> 	if (bpf_skb_store_bytes(skb, offset, x->bytes, 8/*x->bytes_len*/,
>>> BPF_F_RECOMPUTE_CSUM))
>>> 		return TC_ACT_SHOT;
>>>
>>> 	/* blah blah blah... */
>>>
>>> 	return TC_ACT_OK;
>>> }
>>>
>>> Let's focus on the line where bpf_skb_store_bytes is called. As is, with
>>> a constant length (i.e., 8 for instance), the verifier is happy.
>>> However, as soon as I try to use a map value as the length, it fails:
>>>
>>> [...]
>>> ; if (bpf_skb_store_bytes(skb, offset, x->bytes, x->bytes_len,
>>> 34: (bf) r1 = r7
>>> 35: (b7) r2 = 54
>>> 36: (bf) r3 = r8
>>> 37: (b7) r5 = 1
>>> 38: (85) call bpf_skb_store_bytes#9
>>>    R0=inv0 R1_w=ctx(id=0,off=0,imm=0) R2_w=inv54
>>> R3_w=map_value(id=0,off=4,ks=4,vs=2052,imm=0)
>>> R4_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R5_w=inv1
>>> R6_w=inv1 R7=ctx(id=0,off=0,imm=0)
>>> R8_w=map_value(id=0,off=4,ks=4,vs=2052,imm=0) R10=fp0 fp-8=mmmm????
>>> invalid access to map value, value_size=2052 off=4 size=0
>>> R3 min value is outside of the allowed memory range
>>>
>>> I guess "size=0" is the problem here, but don't understand why. What
>>> bothers me is that it looks like it's about R3 (i.e., x->bytes), not R4.
>>> Anyway, I already tried to add a bunch of checks for both, but did not
>>> succeed. Any idea?
>>
>> Hi Justin, John,
>>
>> The following fragment of C code:
>>
>> 	if (x->bytes_len == 0 || x->bytes_len > MAX_BYTES)
>> 		return TC_ACT_OK;
>>
>> 	if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
>> 		return TC_ACT_OK;
>>
>> 	if (bpf_skb_store_bytes(skb, offset, x->bytes, x->bytes_len,
>> 				BPF_F_RECOMPUTE_CSUM))
>> 		return TC_ACT_SHOT;
>>
>> Gets compiled to the following BPF:
>>
>>      ; r8 is `x` at this point
>>      ; if (x->bytes_len == 0 || x->bytes_len > MAX_BYTES)
>>      17: (61) r2 = *(u32 *)(r8 +0)           ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>>                                              ; R8_w=map_value(off=0,ks=4,vs=2052,imm=0)
>>      18: (bc) w1 = w2                        ; R1_w=scalar(id=2,umax=4294967295,var_off=(0x0; 0xffffffff))
>>                                              ; R2_w=scalar(id=2,umax=4294967295,var_off=(0x0; 0xffffffff))
>>      19: (04) w1 += -2049                    ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>>      20: (a6) if w1 < 0xfffff800 goto pc+16  ; R1_w=scalar(umin=4294965248,umax=4294967295,
>>                                              ;             var_off=(0xfffff800; 0x7ff),s32_min=-2048,s32_max=-1)
>>
>>      ; if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
>>      21: (bf) r1 = r6                        ; R1_w=ctx(off=0,imm=0) R6=ctx(off=0,imm=0)
>>      22: (b4) w3 = 0                         ; R3_w=0
>>      23: (b7) r4 = 0                         ; R4_w=0
>>      24: (85) call bpf_skb_adjust_room#50    ; R0=scalar()
>>      25: (55) if r0 != 0x0 goto pc+11        ; R0=0
>>
>>      ; if (bpf_skb_store_bytes(skb, offset, x->bytes, x->bytes_len,
>>      26: (61) r4 = *(u32 *)(r8 +0)           ; R4_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>>                                              ; R8=map_value(off=0,ks=4,vs=2052,imm=0)
>>      27: (07) r8 += 4                        ; R8_w=map_value(off=4,ks=4,vs=2052,imm=0)
>>      28: (bf) r1 = r6                        ; R1_w=ctx(off=0,imm=0) R6=ctx(off=0,imm=0)
>>      29: (b4) w2 = 54                        ; R2_w=54
>>      30: (bf) r3 = r8                        ; R3_w=map_value(off=4,ks=4,vs=2052,imm=0) R8_w=map_value(off=4,ks=4,vs=2052,imm=0)
>>      31: (b7) r5 = 1                         ; R5_w=1
>>      32: (85) call bpf_skb_store_bytes#9
>>
>> Note the following instructions:
>> - (17): x->bytes_len access;
>> - (18,19,20): a curious way in which clang translates the (_ == 0 || _ > MAX_BYTES);
>> - (26): x->bytes_len is re-read.
>>
>> Several observations:
>> - because of (20) verifier can infer range for w1, but this range is
>>    not propagated to w2;
>> - even if it was propagated verifier does not track range for values
>>    stored in "general memory", only for values in registers and values
>>    spilled to stack => known range for w2 does not imply known range
>>    for x->bytes_len.
>>
>> I can make it work with the following modification:
>>
>>      int egress_handler(struct __sk_buff *skb)
>>      {
>>      	void *data_end = (void *)(long)skb->data_end;
>>      	void *data = (void *)(long)skb->data;
>>      	struct ethhdr *eth = data;
>>      	struct ipv6hdr *ip6;
>>      	struct xxx_t *x;
>>      	__s32 bytes_len;   // <------ signed !
>>      	__u32 offset;
>>      	__u32 idx = 0;
>>      
>>      	offset = sizeof(*eth) + sizeof(*ip6);
>>      	if (data + offset > data_end)
>>      		return TC_ACT_OK;
>>      
>>      	if (bpf_ntohs(eth->h_proto) != ETH_P_IPV6)
>>      		return TC_ACT_OK;
>>      
>>      	x = bpf_map_lookup_elem(&my_map, &idx);
>>      	if (!x)
>>      		return TC_ACT_OK;
>>      
>>      	bytes_len = x->bytes_len; // <----- use bytes_len everywhere below !
>>      
>>      	if (bytes_len <= 0 || bytes_len > MAX_BYTES)
>>      		return TC_ACT_OK;
>>      
>>      	if (bpf_skb_adjust_room(skb, bytes_len, BPF_ADJ_ROOM_NET, 0))
>>      		return TC_ACT_OK;
>>      
>>      	if (bpf_skb_store_bytes(skb, offset, x->bytes, bytes_len,
>>      				BPF_F_RECOMPUTE_CSUM))
>>      		return TC_ACT_SHOT;
>>      
>>      	/* blah blah blah... */
>>      
>>      	return TC_ACT_OK;
>>      }
>>
>> After such change the following BPF is generated:
>>
>>      ; bytes_len = x->bytes_len;
>>      17: (61) r9 = *(u32 *)(r8 +0)         ; R8_w=map_value(off=0,ks=4,vs=2052,imm=0)
>>                                            ; R9_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>>
>>      ; if (bytes_len <= 0 || bytes_len > MAX_BYTES)
>>      18: (c6) if w9 s< 0x1 goto pc+18      ; R9_w=scalar(umin=1,umax=2147483647,var_off=(0x0; 0x7fffffff))
>>      19: (66) if w9 s> 0x800 goto pc+17    ; R9_w=scalar(umin=1,umax=2048,var_off=(0x0; 0xfff))
>>      ; if (bpf_skb_adjust_room(skb, bytes_len, BPF_ADJ_ROOM_NET, 0))
>>      20: (bf) r1 = r6                      ; R1_w=ctx(off=0,imm=0) R6=ctx(off=0,imm=0)
>>      21: (bc) w2 = w9                      ; R2_w=scalar(id=2,umin=1,umax=2048,var_off=(0x0; 0xfff))
>>                                            ; R9_w=scalar(id=2,umin=1,umax=2048,var_off=(0x0; 0xfff))
>>      22: (b4) w3 = 0                       ; R3_w=0
>>      23: (b7) r4 = 0                       ; R4_w=0
>>      24: (85) call bpf_skb_adjust_room#50          ; R0=scalar()
>>      25: (55) if r0 != 0x0 goto pc+11      ; R0=0
>>
>>      ; if (bpf_skb_store_bytes(skb, offset, x->bytes, bytes_len,
>>      26: (07) r8 += 4                      ; R8_w=map_value(off=4,ks=4,vs=2052,imm=0)
>>      27: (bf) r1 = r6                      ; R1_w=ctx(off=0,imm=0) R6=ctx(off=0,imm=0)
>>      28: (b4) w2 = 54                      ; R2_w=54
>>      29: (bf) r3 = r8                      ; R3_w=map_value(off=4,ks=4,vs=2052,imm=0)
>>                                            ; R8_w=map_value(off=4,ks=4,vs=2052,imm=0)
>>      30: (bc) w4 = w9                      ; R4_w=scalar(id=2,umin=1,umax=2048,var_off=(0x0; 0xfff))
>>                                            ; R9=scalar(id=2,umin=1,umax=2048,var_off=(0x0; 0xfff))
>>      31: (b7) r5 = 1                       ; R5_w=1
>>      32: (85) call bpf_skb_store_bytes#9
>>      
>> Note the following:
>> - (17): x->bytes_len is in w9;
>> - (18,19): range check is done w/o -= 2049 trick and verifier infers
>>    range for w9 as [1,2048];
>> - (30): w9 is reused as a parameter to bpf_skb_store_bytes with
>>    correct range.
>>
>> I think that main pain point here is "clever" (_ == 0 || _ > MAX_BYTES)
>> translation, need to think a bit if it is possible to dissuade clang
>> from such transformation (via change in clang).
>>
>> Alternatively, I think that doing (_ == 0 || _ > MAX_BYTES) check in
>> inline assembly as two compare instructions should also work.
> 
> In terms of compiler/verifier improvements another option would be to
> teach verifier to track +-scalar relations between registers, so that
> -2049 trick would be understood by verifier, e.g.:
> 
>       ; r8 is `x` at this point
>       ; if (x->bytes_len == 0 || x->bytes_len > MAX_BYTES)
>       17: (61) r2 = *(u32 *)(r8 +0)
>       18: (bc) w1 = w2                         <--- w1.id = w2.id
>       19: (04) w1 += -2049                     <--- don't clear w1.id,
>                                                     instead track that it is w1.(id - 2049)
>       20: (a6) if w1 < 0xfffff800 goto pc+16   <--- propagate range info for w2
> 
> In a sense, extend scalar ID to be a pair [ID, scalar offset].
> But that might get complicated.
> 
> Yonghong,
> what do you think, does it make sense to investigate this or am I
> talking gibberish?

This has been discussed in the past and we intend not to
further complicate with verifier for this. That is why
in llvm we try to maintain original
   (bytes_len <= 0 || bytes_len > MAX_BYTES)

So 'signed' should work with llvm transformation.
If 'unsigned' does not work (bytes_len == 0 || bytes_len > MAX_BYTES),
could you investigate in llvm side to see whether we can improve
such a pattern?

Also in bpf_helpers.h, we have

/* Variable-specific compiler (optimization) barrier. It's a no-op which 
makes
  * compiler believe that there is some black box modification of a given
  * variable and thus prevents compiler from making extra assumption 
about its
  * value and potential simplifications and optimizations on this variable.
  *
  * E.g., compiler might often delay or even omit 32-bit to 64-bit 
casting of
  * a variable, making some code patterns unverifiable. Putting 
barrier_var()
  * in place will ensure that cast is performed before the barrier_var()
  * invocation, because compiler has to pessimistically assume that embedded
  * asm section might perform some extra operations on that variable.
  *
  * This is a variable-specific variant of more global barrier().
  */
#ifndef barrier_var
#define barrier_var(var) asm volatile("" : "+r"(var))
#endif

barrier_var() intends to be used by bpf developers
to prevent some llvm transformations, it is possible
that the original code can work with introducting
barrier_var() in some places.

