Return-Path: <bpf+bounces-8523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E820078797B
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 22:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAAD1C20EB8
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9145666;
	Thu, 24 Aug 2023 20:41:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3E7F
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 20:41:19 +0000 (UTC)
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 13:41:18 PDT
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3810E0
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 13:41:18 -0700 (PDT)
Received: from [192.168.1.33] (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 5AB72200C27F;
	Thu, 24 Aug 2023 22:32:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 5AB72200C27F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1692909174;
	bh=xuG4RB5tWho+FbiXmtQLG7wgRJFfDr4pLgSp6JuDUEI=;
	h=Date:To:From:Subject:Cc:From;
	b=y4UbK0bkYA+Wbs56VCd4yPgP5UrztDkTJGZZ7QQLyaeBYBeMI+6+V08GfQfq98Hev
	 I+cqKIpXruIY9/57uvVEZHYtj9fUWFdg+sFXnS57iagms3d8VCKGBn7xJJdrI21aYv
	 J5hcmpcv+jUe2577JzRYLkVDdaxt3w00wX0BxY2gVIqKSBCaw9W7PcXTQZWpb8HBuo
	 Psyl+7jHWq1ABp00E9bfxmRDs9QR4yle6McM/2Txe1tv1+o/mplwArNlXJmd66GvED
	 74vbWZzZd3PsRkE4KdVAv4u7KfGT7V5XW3LjOcx4W6a+5oJMyFiOQaWBk2lTsIc/8n
	 b1Gs/RRYAWEVw==
Message-ID: <e3783201-3b28-3661-eee3-3b5fecad0964@uliege.be>
Date: Thu, 24 Aug 2023 22:32:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: bpf@vger.kernel.org
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
Subject: [QUESTION] bpf/tc verifier error: invalid access to map value, min
 value is outside of the allowed memory range
Cc: justin.iurman@uliege.be
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

I'm facing a verifier error and don't know how to make it happy (already 
tried lots of checks). First, here is my env:
  - OS: Ubuntu 22.04.3 LTS
  - kernel: 5.15.0-79-generic x86_64 (CONFIG_DEBUG_INFO_BTF=y)
  - clang version: 14.0.0-1ubuntu1.1
  - iproute2-5.15.0 with libbpf 0.5.0

And here is a simplified example of my program (basically, it will 
insert in packets some bytes defined inside a map):

#include "vmlinux.h"
#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#define MAX_BYTES 2048

struct xxx_t {
	__u32 bytes_len;
	__u8 bytes[MAX_BYTES];
};

struct {
	__uint(type, BPF_MAP_TYPE_ARRAY);
	__uint(max_entries, 1);
	__type(key, __u32);
	__type(value, struct xxx_t);
	__uint(pinning, LIBBPF_PIN_BY_NAME);
} my_map SEC(".maps");

char _license[] SEC("license") = "GPL";

SEC("egress")
int egress_handler(struct __sk_buff *skb)
{
	void *data_end = (void *)(long)skb->data_end;
	void *data = (void *)(long)skb->data;
	struct ethhdr *eth = data;
	struct ipv6hdr *ip6;
	struct xxx_t *x;
	__u32 offset;
	__u32 idx = 0;

	offset = sizeof(*eth) + sizeof(*ip6);
	if (data + offset > data_end)
		return TC_ACT_OK;

	if (bpf_ntohs(eth->h_proto) != ETH_P_IPV6)
		return TC_ACT_OK;

	x = bpf_map_lookup_elem(&my_map, &idx);
	if (!x)
		return TC_ACT_OK;

	if (x->bytes_len == 0 || x->bytes_len > MAX_BYTES)
		return TC_ACT_OK;

	if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
		return TC_ACT_OK;

	if (bpf_skb_store_bytes(skb, offset, x->bytes, 8/*x->bytes_len*/, 
BPF_F_RECOMPUTE_CSUM))
		return TC_ACT_SHOT;

	/* blah blah blah... */

	return TC_ACT_OK;
}

Let's focus on the line where bpf_skb_store_bytes is called. As is, with 
a constant length (i.e., 8 for instance), the verifier is happy. 
However, as soon as I try to use a map value as the length, it fails:

[...]
; if (bpf_skb_store_bytes(skb, offset, x->bytes, x->bytes_len,
34: (bf) r1 = r7
35: (b7) r2 = 54
36: (bf) r3 = r8
37: (b7) r5 = 1
38: (85) call bpf_skb_store_bytes#9
  R0=inv0 R1_w=ctx(id=0,off=0,imm=0) R2_w=inv54 
R3_w=map_value(id=0,off=4,ks=4,vs=2052,imm=0) 
R4_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R5_w=inv1 
R6_w=inv1 R7=ctx(id=0,off=0,imm=0) 
R8_w=map_value(id=0,off=4,ks=4,vs=2052,imm=0) R10=fp0 fp-8=mmmm????
invalid access to map value, value_size=2052 off=4 size=0
R3 min value is outside of the allowed memory range

I guess "size=0" is the problem here, but don't understand why. What 
bothers me is that it looks like it's about R3 (i.e., x->bytes), not R4. 
Anyway, I already tried to add a bunch of checks for both, but did not 
succeed. Any idea?

Thanks,
Justin

