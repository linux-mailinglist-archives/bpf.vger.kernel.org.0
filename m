Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC80E6F469C
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjEBPFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjEBPFI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 11:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96DC2119
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683039860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3VqBpjJe45pWSOeflD2EoRODS2Pv6RFfC5l84cign8=;
        b=jFwZ0LXdVTeNa/8H79/LhzRAnj7moh+/qTtPIhQqa7joqSk9B3cU/rHZUxQbQU0cRtFrrx
        cv05qD+TK5K7cQlna5RFlcwi+Y7SRyid2aOe1mVEk2rh2tMVJP1XKNE3EYOehwaJwRUkC5
        9Hm2q5IVAwI4MNO9eDUA1sDE45ci0/o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-OpNi3w6yOmie_oT_EjHiSw-1; Tue, 02 May 2023 11:04:11 -0400
X-MC-Unique: OpNi3w6yOmie_oT_EjHiSw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f33f8ffa05so12724505e9.1
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 08:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683039846; x=1685631846;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3VqBpjJe45pWSOeflD2EoRODS2Pv6RFfC5l84cign8=;
        b=ew+LlpQ/d5CEWyXIRIEFWuDpngxygXjdT+lb/pfqEwocqbpLTCTN8EpDMqlJC0kUpg
         4m1btXY48wV6d9cqojvHpgNIQV+5SnQtS4XAAO8rqvEmp40Tc3QxScJAbpvsc51P7LSf
         Oz5lFrlR+cpryf+tVoJ1FApPVE1NkJHbNRWRQBz8VSTvyME5KqsCBFhbRqMZL8CjAgJx
         /zOhgHu5DzaO46628oIYro9ViKXHukXZjZ1Fpkuo8PT0ZbVYO6cElH3dhNEgEE1HGw8Z
         Lj2PFlqRKvWSw4m/AvE12gty3hb16QNpfCahmbAyknPO2vZMuj2mhWVkhVEGZrH5nVCD
         06Rw==
X-Gm-Message-State: AC+VfDzoub0uXxwUm7QyFhNyB9kwajEYCecFlFvPJRm24lNBqQNGNAcu
        iENuyNogHLF8gOf48eo7iCNVDiE1Z14h38oTX+Lmh/N1viXQijapXVsd2WYKW0u/62jMUk4ALEJ
        KJA9alwgF36/7
X-Received: by 2002:a05:600c:2155:b0:3f1:733b:8aba with SMTP id v21-20020a05600c215500b003f1733b8abamr12323014wml.35.1683039846152;
        Tue, 02 May 2023 08:04:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fR4SIsKy+pjVJlia2+ofkHkmOsp+3kyFCIl6F1FN9R8Gs5f1OzLPjrCnv9OT8frSEFeaEqg==
X-Received: by 2002:a05:600c:2155:b0:3f1:733b:8aba with SMTP id v21-20020a05600c215500b003f1733b8abamr12322948wml.35.1683039845716;
        Tue, 02 May 2023 08:04:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id u5-20020a7bc045000000b003f32c9ea20fsm11140277wmc.11.2023.05.02.08.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 08:04:05 -0700 (PDT)
Message-ID: <1d82794a-4c12-cdc3-a868-f013bf9fe46f@redhat.com>
Date:   Tue, 2 May 2023 17:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
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
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>
References: <cover.1682981880.git.lstoakes@gmail.com>
 <ff543d504d2bf83f60b1fb478149b4b3d6298119.1682981880.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 2/3] mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing
 to file-backed mappings
In-Reply-To: <ff543d504d2bf83f60b1fb478149b4b3d6298119.1682981880.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 02.05.23 01:11, Lorenzo Stoakes wrote:
> Writing to file-backed mappings which require folio dirty tracking using
> GUP is a fundamentally broken operation, as kernel write access to GUP
> mappings do not adhere to the semantics expected by a file system.
> 
> A GUP caller uses the direct mapping to access the folio, which does not
> cause write notify to trigger, nor does it enforce that the caller marks
> the folio dirty.
> 
> The problem arises when, after an initial write to the folio, writeback
> results in the folio being cleaned and then the caller, via the GUP
> interface, writes to the folio again.
> 
> As a result of the use of this secondary, direct, mapping to the folio no
> write notify will occur, and if the caller does mark the folio dirty, this
> will be done so unexpectedly.
> 
> For example, consider the following scenario:-
> 
> 1. A folio is written to via GUP which write-faults the memory, notifying
>     the file system and dirtying the folio.
> 2. Later, writeback is triggered, resulting in the folio being cleaned and
>     the PTE being marked read-only.
> 3. The GUP caller writes to the folio, as it is mapped read/write via the
>     direct mapping.
> 4. The GUP caller, now done with the page, unpins it and sets it dirty
>     (though it does not have to).
> 
> This results in both data being written to a folio without writenotify, and
> the folio being dirtied unexpectedly (if the caller decides to do so).
> 
> This issue was first reported by Jan Kara [1] in 2018, where the problem
> resulted in file system crashes.
> 
> This is only relevant when the mappings are file-backed and the underlying
> file system requires folio dirty tracking. File systems which do not, such
> as shmem or hugetlb, are not at risk and therefore can be written to
> without issue.
> 
> Unfortunately this limitation of GUP has been present for some time and
> requires future rework of the GUP API in order to provide correct write
> access to such mappings.
> 
> However, for the time being we introduce this check to prevent the most
> egregious case of this occurring, use of the FOLL_LONGTERM pin.
> 
> These mappings are considerably more likely to be written to after
> folios are cleaned and thus simply must not be permitted to do so.
> 
> This patch changes only the slow-path GUP functions, a following patch
> adapts the GUP-fast path along similar lines.
> 
> [1]:https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Mika Penttilä <mpenttil@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   mm/gup.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ff689c88a357..0f09dec0906c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -959,16 +959,51 @@ static int faultin_page(struct vm_area_struct *vma,
>   	return 0;
>   }
>   
> +/*
> + * Writing to file-backed mappings which require folio dirty tracking using GUP
> + * is a fundamentally broken operation, as kernel write access to GUP mappings
> + * do not adhere to the semantics expected by a file system.
> + *
> + * Consider the following scenario:-
> + *
> + * 1. A folio is written to via GUP which write-faults the memory, notifying
> + *    the file system and dirtying the folio.
> + * 2. Later, writeback is triggered, resulting in the folio being cleaned and
> + *    the PTE being marked read-only.
> + * 3. The GUP caller writes to the folio, as it is mapped read/write via the
> + *    direct mapping.
> + * 4. The GUP caller, now done with the page, unpins it and sets it dirty
> + *    (though it does not have to).
> + *
> + * This results in both data being written to a folio without writenotify, and
> + * the folio being dirtied unexpectedly (if the caller decides to do so).
> + */
> +static bool writeable_file_mapping_allowed(struct vm_area_struct *vma,
> +					   unsigned long gup_flags)
> +{
> +	/* If we aren't pinning then no problematic write can occur. */
> +	if (!(gup_flags & (FOLL_GET | FOLL_PIN)))
> +		return true;

I think we should really not look at FOLL_GET here. Just check for 
FOLL_PIN (as said, even FOLL_LONGTERM would be sufficient, but I 
understand the reasoning to keep it, although I would drop it :P ). It 
also better matches your comment regarding pinning ...

See the comment in is_valid_gup_args() regarding "LONGTERM can only be 
specified when pinning". (well, there we also check that FOLL_PIN has to 
be set ... ;) )

> +
> +	/* We limit this check to the most egregious case - a long term pin. */
> +	if (!(gup_flags & FOLL_LONGTERM))
> +		return true;
> +
> +	/* If the VMA requires dirty tracking then GUP will be problematic. */
> +	return vma_needs_dirty_tracking(vma);


... should that be "!vma_needs_dirty_tracking(vma)" ?

If the fs needs dirty tracking, it should be disallowed.

Maybe that explains why it's still working for Matthew in his s390x 
test. ... or I am too tired and messed up :)

-- 
Thanks,

David / dhildenb

