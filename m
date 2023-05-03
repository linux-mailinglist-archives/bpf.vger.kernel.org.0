Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAA6F5B84
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjECPu3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjECPu1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 11:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5995FF9
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683128979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4VP89Zv90qrgsob/vJ4a462qWannnDrJro4rCmwa5M=;
        b=Sln4Meck3wZl9xDXzZjqNARUMKjAMEV1n3snFP+qEtLlUBXtYABCtKk89yQF4W3gM1XQxM
        PQw4XppS5BS4WzdekMB4+DUu/fRhBVUQeimkq2/R5fBVIXUwG9uuAT8XjlMtI+jPk/wYLO
        h+2i+b3tO/jgxQOC8t4vACZERG+4ilA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-z0AgMNaLNUGjXfXKrGANeA-1; Wed, 03 May 2023 11:49:38 -0400
X-MC-Unique: z0AgMNaLNUGjXfXKrGANeA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94f2d9389afso516524866b.2
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 08:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128977; x=1685720977;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4VP89Zv90qrgsob/vJ4a462qWannnDrJro4rCmwa5M=;
        b=JkBP7PAXjzkIbkRkejsGdJQCt5obgk1whVV+7JePGFQq+iB8FwqfJ2f0DvSc8G0AMp
         8Arz+cY6sBYtXFF3f57vWHyPbriHOI6CTGUGze80cqyQRX93QPI/C2H34BT+7z151Biy
         mIh1YlR6JAD7yuetL1jC0HDkWZl2KY1W431Ci0RQpsBUvr8sxayTvBzJw1uNvLuBbRlY
         Z7RQEQRdNYuqX7kjRICVO3uW4GggwfHaBjTaszKL6y0NU+iLvJspejr8fk2/oZHmI7Ce
         OEwCPbR4RbDizV8B+cSsqaizoui+1LWj2GRJSL4qVqrI0MyK/uHY7fOIfHrRaH4qZeCZ
         stjg==
X-Gm-Message-State: AC+VfDyCCl+YRCz088GXeuy3uqW8QnoxBGnrvHUixzbfHHvqB4EGd7QP
        c2pVsXSW5WXQLGjpf18SgDeKbk677CdPEZSpBA+z3j2ZWHeiP/A4B1PPDvqyBx/sL/3zwK7G5Sc
        laej2wj+URzLL
X-Received: by 2002:a17:907:c21:b0:933:3814:e0f4 with SMTP id ga33-20020a1709070c2100b009333814e0f4mr4712161ejc.16.1683128977008;
        Wed, 03 May 2023 08:49:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6e5zv7cZWE/jkHWJTvri6PxUa3jx686lEP7V5PP9ooaEOwZDZGGsjXhQil4vBJmqj+KSXbvg==
X-Received: by 2002:a17:907:c21:b0:933:3814:e0f4 with SMTP id ga33-20020a1709070c2100b009333814e0f4mr4712134ejc.16.1683128976703;
        Wed, 03 May 2023 08:49:36 -0700 (PDT)
Received: from [192.168.42.222] (cgn-cgn9-185-107-14-3.static.kviknet.net. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id th7-20020a1709078e0700b009596e7e0dbasm13598187ejc.162.2023.05.03.08.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 08:49:36 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3a5a28c4-01a3-793c-6969-475aba3ff3b5@redhat.com>
Date:   Wed, 3 May 2023 17:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     brouer@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
        lorenzo@kernel.org, linyunsheng@huawei.com, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org
Subject: Re: [PATCH RFC net-next/mm V3 1/2] page_pool: Remove workqueue in new
 shutdown scheme
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <168269854650.2191653.8465259808498269815.stgit@firesoul>
 <168269857929.2191653.13267688321246766547.stgit@firesoul>
 <20230502193309.382af41e@kernel.org> <87ednxbr3c.fsf@toke.dk>
In-Reply-To: <87ednxbr3c.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 03/05/2023 13.18, Toke Høiland-Jørgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
>> On Fri, 28 Apr 2023 18:16:19 +0200 Jesper Dangaard Brouer wrote:
>>> This removes the workqueue scheme that periodically tests when
>>> inflight reach zero such that page_pool memory can be freed.
>>>
>>> This change adds code to fast-path free checking for a shutdown flags
>>> bit after returning PP pages.
>>
>> We can remove the warning without removing the entire delayed freeing
>> scheme. I definitely like the SHUTDOWN flag and patch 2 but I'm a bit
>> less clear on why the complexity of datapath freeing is justified.
>> Can you explain?
> 
> You mean just let the workqueue keep rescheduling itself every minute
> for the (potentially) hours that skbs will stick around? Seems a bit
> wasteful, doesn't it? :)

I agree that this workqueue that keeps rescheduling is wasteful.
It actually reschedules every second, even more wasteful.
NIC drivers will have many HW RX-queues, with separate PP instances, 
that each can start a workqueue that resched every sec.

Eric have convinced me that SKBs can "stick around" for longer than the
assumptions in PP.  The old PP assumptions came from XDP-return path.
It is time to cleanup.

> 
> We did see an issue where creating and tearing down lots of page pools
> in a short period of time caused significant slowdowns due to the
> workqueue mechanism. Lots being "thousands per second". This is possible
> using the live packet mode of bpf_prog_run() for XDP, which will setup
> and destroy a page pool for each syscall...

Yes, the XDP live packet mode of bpf_prog_run is IMHO abusing the
page_pool API.  We should fix that somehow, at least the case where live
packet mode is only injecting a single packet, but still creates a PP
instance. The PP in live packet mode IMHO only makes sense when
repeatedly sending packets that gets recycles and are pre-inited by PP.

This use of PP does exemplify why is it problematic to keep the workqueue.

I have considered (and could be convinced) delaying the free via
call_rcu, but it also create an unfortunate backlog of work in the case
of live packet mode of bpf_prog_run.

--Jesper

