Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8AD6F5A1D
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjECOcv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 10:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjECOcg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 10:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C36A74
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683124303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwgVjcmprHBa8NpoaXgJYiwFaH2ANM6d4RKcdmTha7o=;
        b=Gu58W2LOoq0lh+3plcO641WrX3cE77msvg057OIztmEBE6szTd38IcT0cgnoUGf8bNgT8l
        ilYRkMciSQz+nN19CXZNzVOx/ujoQHpMT3mhLGPU3dPRTZQUyJWoZpn66zbZMlQuo04/h+
        QtDd+QsBQlAQwXaALccBO5ZS8LyjzmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-VcltH4y1Pq-4Bp7JiP5oNg-1; Wed, 03 May 2023 10:31:40 -0400
X-MC-Unique: VcltH4y1Pq-4Bp7JiP5oNg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f171d38db3so32366835e9.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 07:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124299; x=1685716299;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwgVjcmprHBa8NpoaXgJYiwFaH2ANM6d4RKcdmTha7o=;
        b=F/ZT+c9vq3FVHXgP9iq/uzKuWb3v6NanqQxDBFo6685dwn4GX2JobMpHaPVo6teGNq
         7apuJuuD9bcu0dT6nuBC4BkwLX5PH7aO8mvNyn5WNBeCGD3Zg5JpKIpwYeVn1mdB3xhJ
         M2bHO5ujOFUvpUBcHmzAKsR6wcWzbdOGAaBvQf5PH+BIIgXkqSS4XR6qluMbVV5ody8D
         YRfq0XmY6SGGt26cd6gK/BLRk+qoY+tzUJ18Nn02q0vSOq/d68kutL66ugpqA8u24jGP
         IEoo0KaQeYaXYJ69HOxLGsbBf6pxMZD5G07kN3FLcLLoCGC1tfOR4xzL4ABDGxBYkzcI
         B98Q==
X-Gm-Message-State: AC+VfDyHGA/fsuWelgFv5buaXntWTTwOiloewWsnOi2MCQ2asZ5pUBfs
        /A8yYpPE0tg7HN90bQQmLjS0rHgkD6EH9OLrPFwIk5EfnU9vTERXvozIHYbrLcwmubM9iVR9ft5
        El2tqmpVs2Pov
X-Received: by 2002:a05:600c:2212:b0:3f1:6ebe:d598 with SMTP id z18-20020a05600c221200b003f16ebed598mr14513934wml.7.1683124299684;
        Wed, 03 May 2023 07:31:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4p6NwKtGvfJuosY5ZRZTEXkZFFMya7KCf1fgffm+RPeC5ZQYEbm68OqBiXftYqckyaEdvrXA==
X-Received: by 2002:a05:600c:2212:b0:3f1:6ebe:d598 with SMTP id z18-20020a05600c221200b003f16ebed598mr14513907wml.7.1683124299231;
        Wed, 03 May 2023 07:31:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:6a00:9109:6424:1804:a441? (p200300cbc7116a00910964241804a441.dip0.t-ipconnect.de. [2003:cb:c711:6a00:9109:6424:1804:a441])
        by smtp.gmail.com with ESMTPSA id n3-20020a7bc5c3000000b003f0b1b8cd9bsm2116716wmk.4.2023.05.03.07.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 07:31:38 -0700 (PDT)
Message-ID: <aa326283-468f-6c40-4c47-de7cf7cc5994@redhat.com>
Date:   Wed, 3 May 2023 16:31:36 +0200
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
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <cover.1683067198.git.lstoakes@gmail.com>
 <7ac8bb557517bcdc9225b4e4893a2ca7f603fcc4.1683067198.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 1/3] mm/mmap: separate writenotify and dirty tracking
 logic
In-Reply-To: <7ac8bb557517bcdc9225b4e4893a2ca7f603fcc4.1683067198.git.lstoakes@gmail.com>
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

On 03.05.23 00:51, Lorenzo Stoakes wrote:
> vma_wants_writenotify() is specifically intended for setting PTE page table
> flags, accounting for existing page table flag state and whether the
> filesystem performs dirty tracking.
> 
> Separate out the notions of dirty tracking and PTE write notify checking in
> order that we can invoke the dirty tracking check from elsewhere.
> 
> Note that this change introduces a very small duplicate check of the
> separated out vm_ops_needs_writenotify() and vma_is_shared_writable()
> functions. This is necessary to avoid making vma_needs_dirty_tracking()
> needlessly complicated (e.g. passing flags or having it assume checks were
> already performed). This is small enough that it doesn't seem too
> egregious.
> 
> We check to ensure the mapping is shared writable, as any GUP caller will
> be safe - MAP_PRIVATE mappings will be CoW'd and read-only file-backed
> shared mappings are not permitted access, even with FOLL_FORCE.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Mika Penttilä <mpenttil@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   include/linux/mm.h |  1 +
>   mm/mmap.c          | 53 ++++++++++++++++++++++++++++++++++------------
>   2 files changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..7b1d4e7393ef 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2422,6 +2422,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
>   #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>   					    MM_CP_UFFD_WP_RESOLVE)
>   
> +bool vma_needs_dirty_tracking(struct vm_area_struct *vma);
>   int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
>   static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
>   {
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5522130ae606..fa7442e44cc2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1475,6 +1475,42 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
>   }
>   #endif /* __ARCH_WANT_SYS_OLD_MMAP */
>   
> +/* Do VMA operations imply write notify is required? */

Nit: comment is superfluous, this is already self-documenting code.

> +static bool vm_ops_needs_writenotify(const struct vm_operations_struct *vm_ops)
> +{
> +	return vm_ops && (vm_ops->page_mkwrite || vm_ops->pfn_mkwrite);
> +}
> +
> +/* Is this VMA shared and writable? */

Nit: dito

> +static bool vma_is_shared_writable(struct vm_area_struct *vma)
> +{
> +	return (vma->vm_flags & (VM_WRITE | VM_SHARED)) ==
> +		(VM_WRITE | VM_SHARED);
> +}
> +
> +/*
> + * Does this VMA require the underlying folios to have their dirty state
> + * tracked?
> + */

Nit: dito

> +bool vma_needs_dirty_tracking(struct vm_area_struct *vma)
> +{
> +	/* Only shared, writable VMAs require dirty tracking. */
> +	if (!vma_is_shared_writable(vma))
> +		return false;
> +
> +	/* Does the filesystem need to be notified? */
> +	if (vm_ops_needs_writenotify(vma->vm_ops))
> +		return true;
> +
> +	/* Specialty mapping? */
> +	if (vma->vm_flags & VM_PFNMAP)
> +		return false;
> +
> +	/* Can the mapping track the dirty pages? */
> +	return vma->vm_file && vma->vm_file->f_mapping &&
> +		mapping_can_writeback(vma->vm_file->f_mapping);
> +}
> +
>   /*
>    * Some shared mappings will want the pages marked read-only
>    * to track write events. If so, we'll downgrade vm_page_prot
> @@ -1483,21 +1519,18 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
>    */
>   int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>   {
> -	vm_flags_t vm_flags = vma->vm_flags;
> -	const struct vm_operations_struct *vm_ops = vma->vm_ops;
> -
>   	/* If it was private or non-writable, the write bit is already clear */
> -	if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
> +	if (!vma_is_shared_writable(vma))
>   		return 0;
>   
>   	/* The backer wishes to know when pages are first written to? */
> -	if (vm_ops && (vm_ops->page_mkwrite || vm_ops->pfn_mkwrite))
> +	if (vm_ops_needs_writenotify(vma->vm_ops))
>   		return 1;
>   
>   	/* The open routine did something to the protections that pgprot_modify
>   	 * won't preserve? */
>   	if (pgprot_val(vm_page_prot) !=
> -	    pgprot_val(vm_pgprot_modify(vm_page_prot, vm_flags)))
> +	    pgprot_val(vm_pgprot_modify(vm_page_prot, vma->vm_flags)))
>   		return 0;
>   
>   	/*
> @@ -1511,13 +1544,7 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>   	if (userfaultfd_wp(vma))
>   		return 1;
>   
> -	/* Specialty mapping? */
> -	if (vm_flags & VM_PFNMAP)
> -		return 0;
> -
> -	/* Can the mapping track the dirty pages? */
> -	return vma->vm_file && vma->vm_file->f_mapping &&
> -		mapping_can_writeback(vma->vm_file->f_mapping);
> +	return vma_needs_dirty_tracking(vma);
>   }
>   
>   /*

We now have duplicate vma_is_shared_writable() and 
vm_ops_needs_writenotify() checks ...


Maybe move the VM_PFNMAP and "/* Can the mapping track the dirty pages? 
*/" checks into a separate helper and call that from both, 
vma_wants_writenotify() and vma_needs_dirty_tracking() ?


In any case

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

