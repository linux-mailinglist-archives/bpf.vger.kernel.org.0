Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ACF4D9E99
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbiCOPYy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbiCOPYy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 11:24:54 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A962D1D8
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 08:23:37 -0700 (PDT)
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nU91J-000CmP-R7; Tue, 15 Mar 2022 16:23:33 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nU91J-000DIn-LU; Tue, 15 Mar 2022 16:23:33 +0100
Subject: Re: direct packet access from SOCKET_FILTER program
To:     Yonghong Song <yhs@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        bpf@vger.kernel.org
References: <4d91422a-3c2e-4d8d-407b-f4367e9ff966@suse.com>
 <9c62401d-4076-9a45-3632-abb5f4ca4a47@fb.com>
 <c9170221-69ee-1195-b35b-11405c23a8bd@suse.com>
 <d65063e0-5709-0b0c-9d82-526426680b4c@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <06628370-b776-74a6-cbc0-5421989c64eb@iogearbox.net>
Date:   Tue, 15 Mar 2022 16:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d65063e0-5709-0b0c-9d82-526426680b4c@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26482/Tue Mar 15 09:26:17 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/15/22 4:14 PM, Yonghong Song wrote:
> On 3/15/22 8:08 AM, Nikolay Borisov wrote:
>> On 15.03.22 г. 17:04 ч., Yonghong Song wrote:
>>> On 3/15/22 4:09 AM, Nikolay Borisov wrote:
>>>>
>>>> It would seem direct packet access is forbidden from SOCKET_FILTER programs, is this intentional ?
>>>>
>>>> I.e I'm getting:
>>>>
>>>> libbpf: prog 'socket_filter': BPF program load failed: Permission denied
>>>> libbpf: prog 'socket_filter': -- BEGIN PROG LOAD LOG --
>>>> 0: R1=ctx(id=0,off=0,imm=0) R10=fp0
>>>> ; int socket_filter(struct __sk_buff *skb)
>>>> 0: (bf) r6 = r1                       ; R1=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
>>>> 1: (b7) r0 = 0                        ; R0_w=inv0
>>>> ; uint8_t *tail = (uint8_t *)(long)skb->data_end;
>>>> 2: (61) r2 = *(u32 *)(r6 +80)
>>>> invalid bpf_context access off=80 size=4
>>>> processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>
>>> Yes, this is intentional. SOCKET_FILTER programs cannot access skb->data
>>> and skb->data_end among other fields. See:
>>> https://github.com/torvalds/linux/blob/master/net/core/filter.c#L7864-L7879
>>
>> Right, my question is why is this the case? I don't see a reason why sk_filter_is_valid_access is not modified similarly to tc_cls_act_is_valid_access where data/data_end where the info->
>> reg_type = PTR_TO_PACKET(_END).
> 
> The sk_filter program is to mimic classic bpf which is used for
> tcpdump. Daniel/Alexei should have more context why we don't
> want to extend it.

It was not enabled given all the complexity that comes with spectre mitigations
and sock filter programs are typically used in unprivileged scenarios. It could
potentially be enabled iff the application has both cap_bpf + cap_perfmon permissions.

Cheers,
Daniel
