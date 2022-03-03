Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC64CC3DA
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 18:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiCCRc3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 12:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiCCRcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C13F019F458
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646328686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PD/UAjee6iu7MwOt5iw3w8GxURRgj+hEeLghI5ezEhk=;
        b=MKeOFCRZSTdD3Qd9HrIe/8b5IMN8E8bb6FjK7ivXuz0eHRtEQdisiX4oPqOhUOsZX6Uvnr
        IHQEDuwPrs4OnCd9YjXC/pZsj2xwEPEL80iuQDPCVkrlNAlt4pAOUufIM7ZJzpU95Mwt1I
        ZWNtGyOdIPLBwp3ddDo8ilgUDsFFgVM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-S6UssoCONKCRCKEi7LExfQ-1; Thu, 03 Mar 2022 12:31:25 -0500
X-MC-Unique: S6UssoCONKCRCKEi7LExfQ-1
Received: by mail-lf1-f69.google.com with SMTP id m13-20020a19520d000000b00443423ff116so1814069lfb.11
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 09:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=PD/UAjee6iu7MwOt5iw3w8GxURRgj+hEeLghI5ezEhk=;
        b=y4U0kP9zWTV97x4z6zpAXsGC7waV1TVsQ5HrtpiYcGytjG0NBB5/02zfdhEIQ4rVWJ
         95lPO4ZV03YShXm2e8TPSDtJrHhz04nH4sflUZsbj1qyuImmXKhTQ0gM0fSN7nGJYdAh
         thnFyIdlYzBJ1+03LkXo0UVzpyIsE9OsJ/4wnb6JI/+9SgGJSSzBlZOUz9b8hLD3OAcK
         vwmTzwWb1Xbxm+p352rvXRnAsqBhHaAs6436rVB1qS/5zJJbAMqTZ13SoCTNDJ63Pw40
         gHoa8IniYeWUh9ku2wf3L/TzgVGUx7TOiMCfo1cZx7Ww0kUZg2/Yq3+swmpv5StfMoA/
         dUrQ==
X-Gm-Message-State: AOAM531OmI5n7A4DOso7F7HmRfw5FFoeMoKd0BWoLRrbAK6T26DCMYoh
        P4KmR7FZXu0jqOW7VQCaSAXYFqHvt9CVD9r++Ay0m29/9HTVOt0SJgudtxLgmHLqeLsgf8Jx/zh
        tMcrCUlVrSWBr
X-Received: by 2002:a05:651c:982:b0:244:c35d:b1ef with SMTP id b2-20020a05651c098200b00244c35db1efmr23622381ljq.243.1646328683854;
        Thu, 03 Mar 2022 09:31:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/Gh7tK0NZRXBQYXef7sfppQ2gPtfiE4IrUcAU3T88og4oObHpepdwCcLciftgBpuziddT9A==
X-Received: by 2002:a05:651c:982:b0:244:c35d:b1ef with SMTP id b2-20020a05651c098200b00244c35db1efmr23622347ljq.243.1646328683552;
        Thu, 03 Mar 2022 09:31:23 -0800 (PST)
Received: from [10.30.0.98] (195-67-91-243.customer.telia.com. [195.67.91.243])
        by smtp.gmail.com with ESMTPSA id g10-20020a19ac0a000000b00441e497867fsm539781lfc.93.2022.03.03.09.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 09:31:22 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <d6621a7b-12ad-1e3d-848f-fff576be2dfd@redhat.com>
Date:   Thu, 3 Mar 2022 18:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH net] xdp: xdp_mem_allocator can be NULL in
 trace_mem_connect().
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <YiC0BwndXiwxGDNz@linutronix.de> <875yovdtm4.fsf@toke.dk>
 <YiDM0WRlWuM2jjNJ@linutronix.de>
In-Reply-To: <YiDM0WRlWuM2jjNJ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 03/03/2022 15.12, Sebastian Andrzej Siewior wrote:
> On 2022-03-03 14:59:47 [+0100], Toke Høiland-Jørgensen wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>>
>>> Since the commit mentioned below __xdp_reg_mem_model() can return a NULL
>>> pointer. This pointer is dereferenced in trace_mem_connect() which leads
>>> to segfault. It can be reproduced with enabled trace events during ifup.
>>>
>>> Only assign the arguments in the trace-event macro if `xa' is set.
>>> Otherwise set the parameters to 0.
>>>
>>> Fixes: 4a48ef70b93b8 ("xdp: Allow registering memory model without rxq reference")
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> Hmm, so before the commit you mention, the tracepoint wasn't triggered
>> at all in the code path that now sets xdp_alloc is NULL. So I'm
>> wondering if we should just do the same here? Is the trace event useful
>> in all cases?
> 
> Correct. It says:
> |              ip-1230    [003] .....     3.053473: mem_connect: mem_id=0 mem_type=PAGE_SHARED allocator=0000000000000000 ifindex=2
> 
>> Alternatively, if we keep it, I think the mem.id and mem.type should be
>> available from rxq->mem, right?
> 
> Yes, if these are the same things. In my case they are also 0:
> 
> |              ip-1245    [000] .....     3.045684: mem_connect: mem_id=0 mem_type=PAGE_SHARED allocator=0000000000000000 ifindex=2
> |        ifconfig-1332    [003] .....    21.030879: mem_connect: mem_id=0 mem_type=PAGE_SHARED allocator=0000000000000000 ifindex=3
> 
> So depends on what makes sense that tp can be skipped for xa == NULL or
> remain with
>                 __entry->mem_id         = rxq->mem.id;
>                 __entry->mem_type       = rxq->mem.type;
> 	       __entry->allocator      = xa ? xa->allocator : NULL;
> 
> if it makes sense.
> 

I have two bpftrace scripts [1] and [2] that use this tracepoint.
It is scripts to help driver developers detect memory leaks when using 
page_pool from their drivers.

I'm a little pressured on time, so I've not evaluated if your change 
makes sense.
In the scripts I do use both mem.id and mem.type.


[1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/mem/bpftrace/xdp_mem_track01.bt

[2] 
https://github.com/xdp-project/xdp-project/blob/master/areas/mem/bpftrace/xdp_mem_track02.bt

--Jesper

