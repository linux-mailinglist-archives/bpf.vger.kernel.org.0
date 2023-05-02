Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1016F45E7
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjEBOQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 10:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjEBOQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 10:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45DB1BC
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683036921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eO6gdENCN2fXl+gir0RoO36SF1UR1xjrvPR5SmtqcoE=;
        b=bNU0A4//q8/YtaSoMieUskdfi0ajSNE32MZZh5dTlyVRmxPnMPle/dyH/ze1rHUBSBJgz8
        vbQzFJzWUYzNo+MP25VpqDyXUnBtOsnqgv1GFvuIbDnFYSjivMgmcAZ6TBYB0S37jNKzlZ
        PahkzVbsFy6TKrcSAZy/hjuB36dE4ZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-L7PE8_4ZPQCXioQFxZrB7g-1; Tue, 02 May 2023 10:15:20 -0400
X-MC-Unique: L7PE8_4ZPQCXioQFxZrB7g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f33f8ffa37so7091385e9.2
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 07:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683036919; x=1685628919;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eO6gdENCN2fXl+gir0RoO36SF1UR1xjrvPR5SmtqcoE=;
        b=iOFGfmO45s1NeQGRgYEr7/oJk+mgvUuRVMcplex1bKOKUFcDMMMsl8xPaEfGr5ym2J
         k+8Cn6SV0gcZ7HMqG3+LWgPebDopdAPKJKKZ8BQFUYMpuhCRFjY2QIbMfz3ZA+eRu3L+
         CAM5iaye7Qb9dt71jmm0O77Y/Y07Sb3gPUEND0DxQLHwFmhaxZJzAnFeFmrrETmlr0xi
         91RVDLsBiwzA1rZCU2U5hvIDWIrv2k9zxI9MW8FKVaKv3pfLXJL5zCZS+/M7qXNMQnNp
         kZDg4PWQMySreenavHsaODZJ0R+JJDck82dJmXzC6bWxNPoxLJ0hIvDz4KOCl9qFvzdf
         5vAQ==
X-Gm-Message-State: AC+VfDyysA0XPZZCjeBSKeQX7ClMwHOIVyo+v1JnDQHTlB+CsAZn9xq9
        m7nIPtgukx1VQXN7UoeX6c1rxw+otlCIdpp5HOXnIOkDNYlrMDiK0uJradndXv9slNxax+R199i
        sEue49m8z67EC
X-Received: by 2002:a05:600c:2183:b0:3ed:ec34:f1 with SMTP id e3-20020a05600c218300b003edec3400f1mr12040824wme.35.1683036919248;
        Tue, 02 May 2023 07:15:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7b/XcsbsQnzRZmP99SuxpW9CijxoRkII9q7oYHBTDMbDugyRQH6OJnCz/4C+NcU01RLhcYbw==
X-Received: by 2002:a05:600c:2183:b0:3ed:ec34:f1 with SMTP id e3-20020a05600c218300b003edec3400f1mr12040766wme.35.1683036918841;
        Tue, 02 May 2023 07:15:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id v11-20020a1cf70b000000b003f25b40fc24sm21090046wmh.6.2023.05.02.07.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 07:15:17 -0700 (PDT)
Message-ID: <f0acd8e4-8df8-dfae-b6b2-30eea3b14609@redhat.com>
Date:   Tue, 2 May 2023 16:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>
References: <7d56b424-ba79-4b21-b02c-c89705533852@lucifer.local>
 <a6bb0334-9aba-9fd8-6a9a-9d4a931b6da2@linux.ibm.com>
 <ZFEL20GQdomXGxko@nvidia.com>
 <c4f790fb-b18a-341a-6965-455163ec06d1@redhat.com>
 <ZFER5ROgCUyywvfe@nvidia.com>
 <ce3aa7b9-723c-6ad3-3f03-3f1736e1c253@redhat.com>
 <ff99f2d8-804d-924f-3c60-b342ffc2173c@linux.ibm.com>
 <ad60d5d2-cfdf-df9f-aef1-7a0d3facbece@redhat.com>
 <ZFEVQmFGL3GxZMaf@nvidia.com>
 <1ffbbfb7-6bca-0ab0-1a96-9ca81d5fa373@redhat.com>
 <ZFEYblElll3pWtn5@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
In-Reply-To: <ZFEYblElll3pWtn5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02.05.23 16:04, Jason Gunthorpe wrote:
> On Tue, May 02, 2023 at 03:57:30PM +0200, David Hildenbrand wrote:
>> On 02.05.23 15:50, Jason Gunthorpe wrote:
>>> On Tue, May 02, 2023 at 03:47:43PM +0200, David Hildenbrand wrote:
>>>>> Eventually we want to implement a mechanism where we can dynamically pin in response to RPCIT.
>>>>
>>>> Okay, so IIRC we'll fail starting the domain early, that's good. And if we
>>>> pin all guest memory (instead of small pieces dynamically), there is little
>>>> existing use for file-backed RAM in such zPCI configurations (because memory
>>>> cannot be reclaimed either way if it's all pinned), so likely there are no
>>>> real existing users.
>>>
>>> Right, this is VFIO, the physical HW can't tolerate not having pinned
>>> memory, so something somewhere is always pinning it.
>>>
>>> Which, again, makes it weird/wrong that this KVM code is pinning it
>>> again :\
>>
>> IIUC, that pinning is not for ordinary IOMMU / KVM memory access. It's for
>> passthrough of (adapter) interrupts.
>>
>> I have to speculate, but I guess for hardware to forward interrupts to the
>> VM, it has to pin the special guest memory page that will receive the
>> indications, to then configure (interrupt) hardware to target the interrupt
>> indications to that special guest page (using a host physical address).
> 
> Either the emulated access is "CPU" based happening through the KVM
> page table so it should use mmu_notifier locking.
> 
> Or it is "DMA" and should go through an IOVA through iommufd pinning
> and locking.
> 
> There is no other ground, nothing in KVM should be inventing its own
> access methodology.

I might be wrong, but this seems to be a bit different.

It cannot tolerate page faults (needs a host physical address), so 
memory notifiers don't really apply. (as a side note, KVM on s390x does 
not use mmu notifiers as we know them)

It's kind-of like DMA, but it's not really DMA.  It's the CPU delivering 
interrupts for a specific device. So we're configuring the interrupt 
controller I guess to target a guest memory page.

But I have way too little knowledge about zPCI and the code in question 
here. And if it could be converted to iommufd (and if that's really the 
right mechanism to use here).

Hopefully Matthew knows the details and if this really needs to be 
special :)

-- 
Thanks,

David / dhildenb

