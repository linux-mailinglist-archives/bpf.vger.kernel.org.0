Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA676F1B69
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 17:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbjD1PY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjD1PY0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 11:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659465B8C
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682695415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNqQu/Hbgh8GgG/TaR2UQBBPYePy9tTL0DFgLY8LdrU=;
        b=ML+bEd2uqQF2mEPpifoZPqZcHUoCUQjeUJuAhtGvXo0DjrvcggrLWnMSMMMuoQn4c7XHHB
        KNmAn4P4foC4wDMAIOrh3ur6oYsg0KQ8ox/SvOptb0JVUw4tZjAezMAYmHVyJRD+UBdisz
        OAEUKvOl3Bft8brNPq0qj3Mnw0A2I0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-QyjydFHvNgikyG4map-rlw-1; Fri, 28 Apr 2023 11:23:34 -0400
X-MC-Unique: QyjydFHvNgikyG4map-rlw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f443ca3357so3719590f8f.2
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 08:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682695413; x=1685287413;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNqQu/Hbgh8GgG/TaR2UQBBPYePy9tTL0DFgLY8LdrU=;
        b=hhbjk6Y/cDu8nHWPfW/nlenWg5G/SogUWeJm/gUwmST7+n0wwqocz0fl7WUSHTbzpz
         k9RgRkUF8I/oIlgKlI5Bp1U6PZf8WzVBUR7Y/TLFj/zQCPm6Brl53bf+mxxv+Tzdw2g9
         cPHUsrUL4LbPygzMmu8buf1xz13MLBHsUaUT8fS4XHlSuqiM0A+8tOgiMrpCMH1cCJGM
         5hxDTWGwSTk4c0aPUXy+RVntN4E+1hM0dvumBgytgXpoZs1FW3J6yrQVDm4d43bWwTH0
         m0xDv1p99H2dvyzsRR/5wzQSj43mHqxwYZmUb15zg5U6++KtJCsw7I5Mvi+5UFRe2z7H
         w6lA==
X-Gm-Message-State: AC+VfDxu5wgAx6J5dWlroaEg64CXmufeC6t60mDUAl5Rw6SwMEXoOB8Y
        cd7nkg8wZkEOw67SVPVf7H4S7BKHxoxstqnbw+HURdw6sq+7AqM54msubZnAOrpxqvnqwL7Ftyg
        Xf3acFlqitEu+
X-Received: by 2002:a05:6000:1148:b0:304:7159:d3e4 with SMTP id d8-20020a056000114800b003047159d3e4mr4054742wrx.44.1682695412806;
        Fri, 28 Apr 2023 08:23:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7m7lYREqwJwCW0J3nLemNcIH2KdfBgyx6gX0Qrhp/YfT+ZQtoJy3PoVU25XYCmL9JQIphxhg==
X-Received: by 2002:a05:6000:1148:b0:304:7159:d3e4 with SMTP id d8-20020a056000114800b003047159d3e4mr4054718wrx.44.1682695412463;
        Fri, 28 Apr 2023 08:23:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:9300:1711:356:6550:7502? (p200300cbc72693001711035665507502.dip0.t-ipconnect.de. [2003:cb:c726:9300:1711:356:6550:7502])
        by smtp.gmail.com with ESMTPSA id a18-20020a056000101200b002e61e002943sm21368158wrx.116.2023.04.28.08.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 08:23:31 -0700 (PDT)
Message-ID: <400da248-a14e-46a4-420a-a3e075291085@redhat.com>
Date:   Fri, 28 Apr 2023 17:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
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
Organization: Red Hat
Subject: Re: [PATCH v5] mm/gup: disallow GUP writing to file-backed mappings
 by default
In-Reply-To: <094d2074-5b69-5d61-07f7-9f962014fa68@redhat.com>
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

>>
>> Security is the primary case where we have historically closed uAPI
>> items.
> 
> As this patch
> 
> 1) Does not tackle GUP-fast
> 2) Does not take care of !FOLL_LONGTERM
> 
> I am not convinced by the security argument in regard to this patch.
> 
> 
> If we want to sells this as a security thing, we have to block it
> *completely* and then CC stable.

Regarding GUP-fast, to fix the issue there as well, I guess we could do 
something similar as I did in gup_must_unshare():

If we're in GUP-fast (no VMA), and want to pin a !anon page writable, 
fallback to ordinary GUP. IOW, if we don't know, better be safe.

Of course, this would prevent hugetlb/shmem from getting pinned writable 
during gup-fast. Unless we're able to whitelist them somehow in there.


For FOLL_LONGTERM it might fairly uncontroversial. For everything else 
I'm not sure if there could be undesired side-effects.

-- 
Thanks,

David / dhildenb

