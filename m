Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E56B8DAA
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 09:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCNImJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCNIlw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 04:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCBB12870
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678783221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sD9LoUVikuufWarTa4hDwA4KAYgIH+8Oq0l3DREwlbw=;
        b=bvcedFVHjyDCUu0utnxP/PHEt4zH5iY3G+nbsDMBlqpkKhwcBG4aBSk9b4eHiqFjoAqegn
        4XYzhzMjNo4EkYjna51wWzKI+VNxz46JoxlZYpVjlH1HOV0enbXOx6ilqYM+8A0ymFF6mf
        oSPxqYkjnuP1dfWdGyPlumvpMZMzbc4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-Gkl14g1MNKi_h4o-gtx3iQ-1; Tue, 14 Mar 2023 04:39:40 -0400
X-MC-Unique: Gkl14g1MNKi_h4o-gtx3iQ-1
Received: by mail-ed1-f72.google.com with SMTP id j21-20020a508a95000000b004fd82403c91so2004042edj.3
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 01:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678783179;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sD9LoUVikuufWarTa4hDwA4KAYgIH+8Oq0l3DREwlbw=;
        b=z0UsxRYge/UYHvztEPsxrD+UL3Oe5hFfRaN9KTXwBZ8auxJRo9/LLMP825TQ5GxJbp
         ki/lIdRo/7gtiEklZ0p074n3fQ+Nsy05PDyo/dNjDAMEGWFWd746LDDzrJRZeK3C4D+e
         foW3yHqTz36p/E5VNQboEVRWD11bHU2yypsqFeMX+MEujBmzQMs2Pwijj6cIkzctO2xC
         N3QU1uVNCqrdERqBGFUXa982w4YmYppJcup6XqY/yGLvpIIwq0dwFp/W5wJ2SVQpeve+
         TGFzsWOulOrFHnAFpSP+qDehNDBHhSvWo4p+n2P3TXex2iPiSNNnTL6IfD54YLClGr1r
         agpQ==
X-Gm-Message-State: AO0yUKUwewxvdNRfmXvynqIBkqCfI6yM2DRLhFe4eUZBBoYbFTgjKLsM
        m+eEX7pOKEbs0YfEG7dFxl5hCDcKei8frCTmOlOgoUlfOVs3obVWPV7eOLt7ooIYf0F8VHLAu5C
        plAUo0Hu7DhPP
X-Received: by 2002:a17:906:3e1b:b0:92a:55a1:63cb with SMTP id k27-20020a1709063e1b00b0092a55a163cbmr1565726eji.69.1678783178872;
        Tue, 14 Mar 2023 01:39:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set+FiggjlYxyAID/QDMx5a5yjPuf8P3jq28udhfgIjtV+hTh9l6ZNW/bhi7Z3RwIiHSLLN7gGA==
X-Received: by 2002:a17:906:3e1b:b0:92a:55a1:63cb with SMTP id k27-20020a1709063e1b00b0092a55a163cbmr1565708eji.69.1678783178599;
        Tue, 14 Mar 2023 01:39:38 -0700 (PDT)
Received: from ?IPV6:2a06:4000:52:0:aade:4726:c0f0:4625? ([2a06:4000:52:0:aade:4726:c0f0:4625])
        by smtp.gmail.com with ESMTPSA id a38-20020a509ea9000000b004c06f786602sm631838edf.85.2023.03.14.01.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:39:37 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3a103f0b-7c90-b9f5-0337-22ef46eba1a5@redhat.com>
Date:   Tue, 14 Mar 2023 09:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        kuniyu@amazon.com, liuhangbin@gmail.com, xiangxia.m.yue@gmail.com,
        jiri@nvidia.com, andy.ren@getcruise.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>,
        Willem de Bruijn <willemb@google.com>,
        Simon Sundberg <Simon.Sundberg@kau.se>
Subject: Re: [PATCH net-next] net: introduce budget_squeeze to help us tune rx
 behavior
Content-Language: en-US
To:     Jason Xing <kerneljasonxing@gmail.com>,
        Kui-Feng Lee <sinquersw@gmail.com>
References: <20230311163614.92296-1-kerneljasonxing@gmail.com>
 <cb09d3eb-8796-b6b8-10cb-35700ea9b532@gmail.com>
 <CAL+tcoB9Gq44dKyZ2yvZdDHXp30=Hc_trbuuWDEeUZiNy9wRAw@mail.gmail.com>
In-Reply-To: <CAL+tcoB9Gq44dKyZ2yvZdDHXp30=Hc_trbuuWDEeUZiNy9wRAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 14/03/2023 02.57, Jason Xing wrote:
> On Tue, Mar 14, 2023 at 5:58 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>> On 3/11/23 08:36, Jason Xing wrote:
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> When we encounter some performance issue and then get lost on how
>>> to tune the budget limit and time limit in net_rx_action() function,
>>> we can separately counting both of them to avoid the confusion.
>>>
>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>> ---
>>> note: this commit is based on the link as below:
>>> https://lore.kernel.org/lkml/20230311151756.83302-1-kerneljasonxing@gmail.com/
>>> ---
[...]
>>> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
>>> index 97a304e1957a..4d1a499d7c43 100644
>>> --- a/net/core/net-procfs.c
>>> +++ b/net/core/net-procfs.c
>>> @@ -174,14 +174,17 @@ static int softnet_seq_show(struct seq_file *seq, void *v)
>>>         */
>>>        seq_printf(seq,
>>>                   "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x "
>>> -                "%08x %08x\n",
>>> -                sd->processed, sd->dropped, sd->time_squeeze, 0,
>>> +                "%08x %08x %08x %08x\n",
>>> +                sd->processed, sd->dropped,
>>> +                0, /* was old way to count time squeeze */
>>
>> Should we show a proximate number?  For example,
>> sd->time_squeeze + sd->bud_squeeze.
> 
> Yeah, It does make sense. Let the old way to display untouched.
>

Yes, I don't think we can/should remove this squeeze stat because
several tools e.g. my own[1] captures these stats (and I know Willem
also have his own tool).
I like the sd->time_squeeze + sd->budget_squeeze suggestion.

  [1] 
https://github.com/netoptimizer/network-testing/blob/master/bin/softnet_stat.pl


>>
>>
>>> +                0,
>>>                   0, 0, 0, 0, /* was fastroute */
>>>                   0,   /* was cpu_collision */
>>>                   sd->received_rps, flow_limit_count,
>>>                   0,   /* was len of two backlog queues */
>>>                   (int)seq->index,
>>> -                softnet_input_pkt_queue_len(sd), softnet_process_queue_len(sd));
>>> +                softnet_input_pkt_queue_len(sd), softnet_process_queue_len(sd),
>>> +                sd->time_squeeze, sd->budget_squeeze);
>>>        return 0;
>>>    }
>>>

We recently had a very long troubleshooting session around a latency
issue (Cc Simon) where we used the tool[1].  The issue was NIC hardware
RX queue was backlogged, but we didn't see any squeeze events, which
confused us. (This happens because budget was 300 and two NICs using 64
budget each doesn't exceed 300).

We were/are missing another counter to tell us net_rx_action() "repoll"
is happening (as code !list_empty(&repoll)).  That were the case and it
would have "told" us that hardware RX ring was full (larger than 64).

We worked around this limitation by using the tracepoint for napi_poll,
and manually deduced that 64 bulking must mean that "repoll" were happening.

Oneliner bpftrace script:

  bpftrace -e 'tracepoint:napi:napi_poll { 
@napi_rx_bulk[str(args->dev_name)] = lhist(args->work, 0, 64, 4); }'

We used this script (that also measures softirq latency):

 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/napi_monitor.bt 


I do wonder is it would be valuable to *also* add a tracepoint to
net_rx_action, that expose sd->time_squeeze, sd->budget_squeeze and
repoll-not-empty.

--Jesper

