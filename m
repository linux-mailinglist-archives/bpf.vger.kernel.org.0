Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5394D9E59
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 16:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiCOPKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiCOPKF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 11:10:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0C11263A
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 08:08:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF3ED212C6;
        Tue, 15 Mar 2022 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647356930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYXhE0ZFBNnzZXAPHy+5sLeYKqp/NVtaP8iMQEwu2rk=;
        b=Ma9RM6cwVHsPif4mo689gzQsQn5oSNwmC7RY+NyMbJEsxtaF52u1HTReWHKxBGA52bXT0i
        6zU0K/D1HaTxT/oM+YS0KkSWkYAj4C8w3WHuVWidSOQKAbTk61hdgQjpwLjzqrM5mPGRET
        1vrRJFv0Q5HWW/7oyyoR+QcjBrrUG/o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA50213B66;
        Tue, 15 Mar 2022 15:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fYSaKQKsMGIKHQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 15 Mar 2022 15:08:50 +0000
Message-ID: <c9170221-69ee-1195-b35b-11405c23a8bd@suse.com>
Date:   Tue, 15 Mar 2022 17:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: direct packet access from SOCKET_FILTER program
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
References: <4d91422a-3c2e-4d8d-407b-f4367e9ff966@suse.com>
 <9c62401d-4076-9a45-3632-abb5f4ca4a47@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <9c62401d-4076-9a45-3632-abb5f4ca4a47@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 15.03.22 г. 17:04 ч., Yonghong Song wrote:
> 
> 
> On 3/15/22 4:09 AM, Nikolay Borisov wrote:
>> Hello,
>>
>> It would seem direct packet access is forbidden from SOCKET_FILTER 
>> programs, is this intentional ?
>>
>> I.e I'm getting:
>>
>> libbpf: prog 'socket_filter': BPF program load failed: Permission denied
>> libbpf: prog 'socket_filter': -- BEGIN PROG LOAD LOG --
>> 0: R1=ctx(id=0,off=0,imm=0) R10=fp0
>> ; int socket_filter(struct __sk_buff *skb)
>> 0: (bf) r6 = r1                       ; R1=ctx(id=0,off=0,imm=0) 
>> R6_w=ctx(id=0,off=0,imm=0)
>> 1: (b7) r0 = 0                        ; R0_w=inv0
>> ; uint8_t *tail = (uint8_t *)(long)skb->data_end;
>> 2: (61) r2 = *(u32 *)(r6 +80)
>> invalid bpf_context access off=80 size=4
>> processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 
>> peak_states 0 mark_read 0
> 
> Yes, this is intentional. SOCKET_FILTER programs cannot access skb->data
> and skb->data_end among other fields. See:
> https://github.com/torvalds/linux/blob/master/net/core/filter.c#L7864-L7879

Right, my question is why is this the case? I don't see a reason why 
sk_filter_is_valid_access is not modified similarly to 
tc_cls_act_is_valid_access where data/data_end where the info->
reg_type = PTR_TO_PACKET(_END).

> 
>>
>>
>> Regards
> 
