Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F016F1BBD
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346092AbjD1PgC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbjD1Pfm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 11:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695081FEF
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682696097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1I3bxKpOJ94ZKtbze6sl4BqpXL9nzWwU/RAx5bKUL4=;
        b=Pc9IkMm4VffnZVzGgIeXHUehP6WrLfgggW5O85nEtXh9X7dF5P49Ln64E4DgJd18snl1cy
        FgXClWpwLlaGZ9sSutO+CWqKx14HD4vS7fyggDrkgiUEly9QowgItjVVdgKp/beSELGzcS
        rXuqskVI6GmjEtI+7MZirTESS3/5fEI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-mRQ9VoOaMk-GsHXDWst7Og-1; Fri, 28 Apr 2023 11:34:47 -0400
X-MC-Unique: mRQ9VoOaMk-GsHXDWst7Og-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f250e9e090so23293285e9.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 08:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682696079; x=1685288079;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1I3bxKpOJ94ZKtbze6sl4BqpXL9nzWwU/RAx5bKUL4=;
        b=YWUJtFKG6V7Q0myFRh9pB/1FNm/Pq62+nL1WzPbtLlOF0v4KNE1cOpdC4JR0Abnn4R
         3CY8km/5I4PY5WsUwC7nZbMQt9M2c01rTk9rXkkQqbWcCxsN8R4r9mw4Tb+V3QdLtyiq
         xUOvhJ4C5k/W3AxJ4/h64OPgfuRL9F3x4hjR2r0iRX2e7mDf/KQ7QSNox+TLgE0MqRzi
         lP///SGZXozpCggYqtuunWmHxrs/H/rkjoBF+k4VmWoeDOCwrNqiIkoFMx8TPzopDgRx
         am6XB6x+S8dkLF655GDn9yMxB+TGt1cbB+WwXjx+SSn4E7r+TU+ElI3+sVKfncogmbPN
         LfRg==
X-Gm-Message-State: AC+VfDwCSjb2Skj16tr2ZaI/V7SJUSJqnzZg4L34c7LllXn9iJoZvBL1
        eonBE2TnIh1VQ8d9KpJxZ2c4voMlD+Bgb2Mux2e5fU+q35Y/JY9+ET3h7WQIC9t0u2MKW4WVLcy
        V6fO/IVzxGn2P
X-Received: by 2002:a7b:c408:0:b0:3f1:643e:3872 with SMTP id k8-20020a7bc408000000b003f1643e3872mr4562565wmi.2.1682696079112;
        Fri, 28 Apr 2023 08:34:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Z+53Bygi3DB3brEFB63AzkuIarkk5LoZoC423ssWGGEMwrQKBO68KVGzpDBEWIV0h6613fA==
X-Received: by 2002:a7b:c408:0:b0:3f1:643e:3872 with SMTP id k8-20020a7bc408000000b003f1643e3872mr4562508wmi.2.1682696078744;
        Fri, 28 Apr 2023 08:34:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:9300:1711:356:6550:7502? (p200300cbc72693001711035665507502.dip0.t-ipconnect.de. [2003:cb:c726:9300:1711:356:6550:7502])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c000900b003f0aa490336sm27987597wmc.26.2023.04.28.08.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 08:34:38 -0700 (PDT)
Message-ID: <62ec50da-5f73-559c-c4b3-bde4eb215e08@redhat.com>
Date:   Fri, 28 Apr 2023 17:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] mm/gup: disallow GUP writing to file-backed mappings
 by default
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
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
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <6b73e692c2929dc4613af711bdf92e2ec1956a66.1682638385.git.lstoakes@gmail.com>
 <afcc124e-7a9b-879c-dfdf-200426b84e24@redhat.com>
 <ZEvZtIb2EDb/WudP@nvidia.com>
 <094d2074-5b69-5d61-07f7-9f962014fa68@redhat.com>
 <400da248-a14e-46a4-420a-a3e075291085@redhat.com>
 <077c4b21-8806-455f-be98-d7052a584259@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <077c4b21-8806-455f-be98-d7052a584259@lucifer.local>
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

On 28.04.23 17:33, Lorenzo Stoakes wrote:
> On Fri, Apr 28, 2023 at 05:23:29PM +0200, David Hildenbrand wrote:
>>>>
>>>> Security is the primary case where we have historically closed uAPI
>>>> items.
>>>
>>> As this patch
>>>
>>> 1) Does not tackle GUP-fast
>>> 2) Does not take care of !FOLL_LONGTERM
>>>
>>> I am not convinced by the security argument in regard to this patch.
>>>
>>>
>>> If we want to sells this as a security thing, we have to block it
>>> *completely* and then CC stable.
>>
>> Regarding GUP-fast, to fix the issue there as well, I guess we could do
>> something similar as I did in gup_must_unshare():
>>
>> If we're in GUP-fast (no VMA), and want to pin a !anon page writable,
>> fallback to ordinary GUP. IOW, if we don't know, better be safe.
> 
> How do we determine it's non-anon in the first place? The check is on the
> VMA. We could do it by following page tables down to folio and checking
> folio->mapping for PAGE_MAPPING_ANON I suppose?

PageAnon(page) can be called from GUP-fast after grabbing a reference. 
See gup_must_unshare().

> 
>>
>> Of course, this would prevent hugetlb/shmem from getting pinned writable
>> during gup-fast. Unless we're able to whitelist them somehow in there.
> 
> We could degrade those to non-fast assuming not FOLL_FAST_ONLY. But it'd be
> a pity.

-- 
Thanks,

David / dhildenb

