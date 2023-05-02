Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD09A6F481B
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjEBQNr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjEBQNk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 12:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60D03A9F
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683043971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9eeDMuJZPu6ODufcZPGNKxI5KHuttnVPRF879rkqTz8=;
        b=dA3G/QbXxtaCjHxl0P4jWMMPKQKi95saGdMSmmrpFB13vN0/1V9PMaJyQZ3ZlhHW2kmhvM
        Qh8EjZNjgLF1c8hCycXZzdMG9WyAiRoqWqj4gTYFfjQg7qIxoonppnCOaEncGOqz3CjPWm
        gAEY4uqy8eUisSv/UMBy8coR8GOY7a8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-7kzFejHSN_ej5l1qDM3SFQ-1; Tue, 02 May 2023 12:12:44 -0400
X-MC-Unique: 7kzFejHSN_ej5l1qDM3SFQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f3157128b4so109558065e9.0
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 09:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043963; x=1685635963;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eeDMuJZPu6ODufcZPGNKxI5KHuttnVPRF879rkqTz8=;
        b=loucJGkc1hlJfFsFX8RqQv/Rr/aBVtR/qTJwSpoem30fiG+tdcTiPzOPxhF44eHpZh
         zY1iecN7q8zZqXNWNGSRkodG1bzPq8RebXkoQzexmXg8dVV+qCp8s9GBeNT/a2n3Y4hz
         4zSdFb5WufPCJ4+NPAoLRsIwF4iTyB22nKSkcjba+VRUvzRULARtTHTrpP2CjXab05yP
         h0ib9HGH2ETqaXWEsjqXY9WhUrNjoprovCvqGmK58GNzliee2WnY3ykDCJiTnl06A4Nt
         FOyv9Kr4jTrkWasCzGbMfLLPAttS9NsxJKbqy8v0wF2D+AMnygpLhNEE5Tlvz3mTmfVj
         +RNw==
X-Gm-Message-State: AC+VfDz8GdJQGMEdw7kYu60uuDaQHV8B0LY5S+Z1KpS/Lt4UKv4/9fYx
        Ate2o1SzxLuFrxG04dE2zAI/BdAsp16DPM6YKsnjNjXVVxn7+NTKMUGUNUEjA9HUxyJhln8PGzf
        haWoAsaOSo3Sh
X-Received: by 2002:adf:e911:0:b0:2f6:661:c03c with SMTP id f17-20020adfe911000000b002f60661c03cmr13759771wrm.28.1683043963189;
        Tue, 02 May 2023 09:12:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50FlsdEb7AJE6SqMVbMDAUvRqWZ/pApIWnjC3i8JYXqQp98IhMaOQg4hPFsdc+YA9Dmgqv7g==
X-Received: by 2002:adf:e911:0:b0:2f6:661:c03c with SMTP id f17-20020adfe911000000b002f60661c03cmr13759744wrm.28.1683043962801;
        Tue, 02 May 2023 09:12:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id v3-20020adfedc3000000b003062c0ef959sm6522031wro.69.2023.05.02.09.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 09:12:42 -0700 (PDT)
Message-ID: <1f29fe90-1482-7435-96bd-687e991a4e5b@redhat.com>
Date:   Tue, 2 May 2023 18:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
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
        Theodore Ts'o <tytso@mit.edu>
References: <ad60d5d2-cfdf-df9f-aef1-7a0d3facbece@redhat.com>
 <ZFEVQmFGL3GxZMaf@nvidia.com>
 <1ffbbfb7-6bca-0ab0-1a96-9ca81d5fa373@redhat.com>
 <ZFEYblElll3pWtn5@nvidia.com>
 <f0acd8e4-8df8-dfae-b6b2-30eea3b14609@redhat.com>
 <3c17e07a-a7f9-18fc-fa99-fa55a5920803@linux.ibm.com>
 <ZFEqTo+l/S8IkBQm@nvidia.com> <ZFEtKe/XcnC++ACZ@x1n>
 <ZFEt/ot6VKOgW1mT@nvidia.com>
 <4fd5f74f-3739-f469-fd8a-ad0ea22ec966@redhat.com>
 <ZFE07gfyp0aTsSmL@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZFE07gfyp0aTsSmL@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02.05.23 18:06, Jason Gunthorpe wrote:
> On Tue, May 02, 2023 at 05:45:40PM +0200, David Hildenbrand wrote:
>> On 02.05.23 17:36, Jason Gunthorpe wrote:
>>> On Tue, May 02, 2023 at 11:32:57AM -0400, Peter Xu wrote:
>>>>> How does s390 avoid mmu notifiers without having lots of problems?? It
>>>>> is not really optional to hook the invalidations if you need to build
>>>>> a shadow page table..
>>>>
>>>> Totally no idea on s390 details, but.. per my read above, if the firmware
>>>> needs to make sure the page is always available (so no way to fault it in
>>>> on demand), which means a longterm pinning seems appropriate here.
>>>>
>>>> Then if pinned a must, there's no need for mmu notifiers (as the page will
>>>> simply not be invalidated anyway)?
>>>
>>> And what if someone deliberately changes the mapping?  memory hotplug
>>> in the VM, or whatever?
>>
>> Besides s390 not supporting memory hotplug in VMs (yet): if the guest wants
>> a different guest physical address, I guess that's the problem of the guest,
>> and it can update it:
>>
>> KVM_S390_ZPCIOP_REG_AEN is triggered from QEMU via
>> s390_pci_kvm_aif_enable(), triggered by the guest via a special instruction.
>>
>> If the hypervisor changes the mapping, it's just the same thing as mixing
>> e.g. MADV_DONTNEED with longterm pinning in vfio: don't do it. And if you do
>> it, you get to keep the mess you created for your VM.
>>
>> Linux will make sure to not change the mapping: for example, page migration
>> of a pinned page will fail.
>>
>> But maybe I am missing something important here.
> 
> It missses the general architectural point why we have all these
> shootdown mechanims in other places - plares are not supposed to make
> these kinds of assumptions. When the userspace unplugs the memory from
> KVM or unmaps it from VFIO it is not still being accessed by the
> kernel.

Yes. Like having memory in a vfio iommu v1 and doing the same (mremap, 
munmap, MADV_DONTNEED, ...). Which is why we disable MADV_DONTNEED 
(e.g., virtio-balloon) in QEMU with vfio.

> 
> Functional bug or not, it is inconsistent with how this is designed to
> work.

Sorry to say, I *really* don't see how that is supposed to work with a 
page that *cannot* be faulted back in on demand.

-- 
Thanks,

David / dhildenb

