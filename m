Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E115D6F478D
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjEBPqe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 11:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjEBPqd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 11:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D31994
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683042346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jXCvdd7DNygReOZu9LsiaslZNiW9u3JpZSmEUHzOZk=;
        b=BRDgSKTa7nEr1bdpIOCLfMzyYKhcvH67DYXXiOtVdse65imeItlGx7cPyskdmJrDhtUxSx
        VShIzmQG6kdkGrYEMu2AfQB3BQOzWFWF9jLSeXsOv5mwaf1gkvt9MdUPwHcUJ8mNWtDaZo
        HLLzommqUg5nvKfIH/iccKV8E99Fj1Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-_4_aT0MxNU-ES5vkpOVOZw-1; Tue, 02 May 2023 11:45:45 -0400
X-MC-Unique: _4_aT0MxNU-ES5vkpOVOZw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f32b3835e9so13191185e9.1
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 08:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042344; x=1685634344;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jXCvdd7DNygReOZu9LsiaslZNiW9u3JpZSmEUHzOZk=;
        b=jq3TYc/SfxpoGcYaUc0RTTobKukZhYKeaIjm3WEwFOol4YaJoFH3gJcnmWCTL1aoX1
         QVGQYxVI3EYDdyuS0OTv8pvCx1AYd8nvxFC82PcuvC1v6Ilh2e1Z4JHo/BrCYX4HYmu4
         X8kf3hptNz53jXlbqAIC4JPI96kEjT7Lzx6giCediCY6YtdKhXbxpUKKV65CL56guvPa
         imWDAQtgWvAGBCYEpQo+YiwB9M+PlTiP2XR64kFs7KpvtsttY9YMubLvI/3qD67k7b6v
         k3BXnCrGsmsAeFpcgNRUl07uJFzKozITLNNmzdQ1t/bbYYjlEP3gjjfTrXewwbBGijSs
         CNtA==
X-Gm-Message-State: AC+VfDyRX70jhnM/bqI0n7Vn6MCiLA21OTl9YlOlimkl+HR/n/gkTzLG
        i3kejezw+arTsQhiVSKcEgoTY/dPpPUHA9QYb2i1WPE1S/P9+Vesyu1IF/iTZ7/bQB8tEVGa1uO
        4hzlfT/YVqlvu
X-Received: by 2002:a7b:c3c4:0:b0:3f3:3a81:32b with SMTP id t4-20020a7bc3c4000000b003f33a81032bmr5684936wmj.15.1683042343898;
        Tue, 02 May 2023 08:45:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iCnNxLty4fpwGjWmlTk0Cw9dYjc5Qp9Xj7jiPRTTMbQu6pqQFr0IF1EjCkXU8IZxvcKndbQ==
X-Received: by 2002:a7b:c3c4:0:b0:3f3:3a81:32b with SMTP id t4-20020a7bc3c4000000b003f33a81032bmr5684921wmj.15.1683042343556;
        Tue, 02 May 2023 08:45:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bc8d9000000b003f0b1b8cd9bsm35846962wml.4.2023.05.02.08.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 08:45:42 -0700 (PDT)
Message-ID: <4fd5f74f-3739-f469-fd8a-ad0ea22ec966@redhat.com>
Date:   Tue, 2 May 2023 17:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>
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
        Theodore Ts'o <tytso@mit.edu>
References: <ce3aa7b9-723c-6ad3-3f03-3f1736e1c253@redhat.com>
 <ff99f2d8-804d-924f-3c60-b342ffc2173c@linux.ibm.com>
 <ad60d5d2-cfdf-df9f-aef1-7a0d3facbece@redhat.com>
 <ZFEVQmFGL3GxZMaf@nvidia.com>
 <1ffbbfb7-6bca-0ab0-1a96-9ca81d5fa373@redhat.com>
 <ZFEYblElll3pWtn5@nvidia.com>
 <f0acd8e4-8df8-dfae-b6b2-30eea3b14609@redhat.com>
 <3c17e07a-a7f9-18fc-fa99-fa55a5920803@linux.ibm.com>
 <ZFEqTo+l/S8IkBQm@nvidia.com> <ZFEtKe/XcnC++ACZ@x1n>
 <ZFEt/ot6VKOgW1mT@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
In-Reply-To: <ZFEt/ot6VKOgW1mT@nvidia.com>
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

On 02.05.23 17:36, Jason Gunthorpe wrote:
> On Tue, May 02, 2023 at 11:32:57AM -0400, Peter Xu wrote:
>>> How does s390 avoid mmu notifiers without having lots of problems?? It
>>> is not really optional to hook the invalidations if you need to build
>>> a shadow page table..
>>
>> Totally no idea on s390 details, but.. per my read above, if the firmware
>> needs to make sure the page is always available (so no way to fault it in
>> on demand), which means a longterm pinning seems appropriate here.
>>
>> Then if pinned a must, there's no need for mmu notifiers (as the page will
>> simply not be invalidated anyway)?
> 
> And what if someone deliberately changes the mapping?  memory hotplug
> in the VM, or whatever?

Besides s390 not supporting memory hotplug in VMs (yet): if the guest 
wants a different guest physical address, I guess that's the problem of 
the guest, and it can update it:

KVM_S390_ZPCIOP_REG_AEN is triggered from QEMU via 
s390_pci_kvm_aif_enable(), triggered by the guest via a special instruction.

If the hypervisor changes the mapping, it's just the same thing as 
mixing e.g. MADV_DONTNEED with longterm pinning in vfio: don't do it. 
And if you do it, you get to keep the mess you created for your VM.

Linux will make sure to not change the mapping: for example, page 
migration of a pinned page will fail.

But maybe I am missing something important here.

-- 
Thanks,

David / dhildenb

