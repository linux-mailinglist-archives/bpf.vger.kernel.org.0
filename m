Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21A367153B
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 08:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjARHm3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 02:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjARHkw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 02:40:52 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13259611C7
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 23:03:48 -0800 (PST)
Message-ID: <436be296-16e8-bc8f-bfed-0b2806d0cf49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674025425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s1zXZdcom0YKMisDKZt99jTOCAQbI157wBhpg+hGSzk=;
        b=hxAyxd5QVxqkOAGNUeOQ3wn+BSksFUKkhKMCN8EDzMURRluYgTfP0K/tgmkPKXUZpmv5Ye
        8lZusAi9q91ggJ3Md0swWs3asvj8m4E3SY59UA7djzQNxIvB+MBPjWmBSJZJ6EzBn7iWVw
        TXD8RMHqlvvb4/BnnZIbYeE2iYL+08A=
Date:   Tue, 17 Jan 2023 23:03:38 -0800
MIME-Version: 1.0
Subject: Re: Question: any hidden in __sk_buff
Content-Language: en-US
To:     dongdwdw <dongdwdw@linux.vnet.ibm.com>
References: <59346030-edd4-30cc-db9e-6fd600713532@linux.vnet.ibm.com>
Cc:     bpf@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <59346030-edd4-30cc-db9e-6fd600713532@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/17/23 5:26 PM, dongdwdw wrote:
> I am reading ebpf sample code recently. When I read socketx2_kern.c 
> socketx2_user.c, I got a question here.
> 
>          __u64 proto = load_half(skb, 12);
> 
> 
> I can not understand here: It means load 2 bytes from 12th bytes of skb address 
> ( it is a pointer of struct__skb_buff ). >
> struct __sk_buff {
> 
>              __u32 len;
>              __u32 pkt_type;
>              __u32 mark;
>              __u32 queue_mapping;
>              __u32 protocol;
>              __u32 vlan_present;
>              __u32 vlan_tci;
>              __u32 vlan_proto;
> 
>              ******
> 
> }
> 
> But I found the structure as above. So the reading start point should be at 
> queue_mapping. But it actually reads protocol info here. *And I did found the 
> result is protocol info*. Why?
> 
> The v*alue of pkt_type, mark, and queue_mapping are all 0.* But when to read 
> starting from queue_mapping's offset, the info is about protocol. It is a little 
> tricky to me. I can not understand this. From my pointview, the protocol info 
> should start at 16 bytes.
> 
> Is there any background that is hidden from me? I search a lot and cannot find 
> any detailed info about this. Please help explain this. Thanks so much.

If you search for load_half, it is defined in bpf_legacy.h:
/* Functions to emit BPF_LD_ABS and BPF_LD_IND instructions.... */

A search on ABS under Documentation/bpf leads to 
Documentation/bpf/instruction-set.rst:

~~~~ snippet ~~~~

   BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BPF 
Packet access instructions`_
   BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BPF 
Packet access instructions`_

... ...

Legacy BPF Packet access instructions
-------------------------------------

eBPF previously introduced special instructions for access to packet data that 
were carried over from classic BPF. However, these instructions are deprecated 
and should no longer be used.

~~~~ snippet ~~~~

Instead of samples/bpf, tools/testing/selftests/bpf/progs is a much better place 
to look for examples. eg. The test_tc_*.c that uses skb->protocol.
