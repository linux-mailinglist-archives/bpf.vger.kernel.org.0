Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642C50AE59
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 05:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349869AbiDVDLC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 23:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443645AbiDVDLB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 23:11:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28874D26F;
        Thu, 21 Apr 2022 20:08:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l127so6741286pfl.6;
        Thu, 21 Apr 2022 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=m+1GIKGybOnQbLN7cTlm8oMOflp0sBv16OQu4gOE9/A=;
        b=HhLHzeyKk42cFKoOn7VUEL+GOFJ4MyDXeKtwA7YC7n93roXgDOD0HxWBwDIgBFfGIp
         Ol46OR12jbghpPJakhFT3gfgC3XdhnlinzyFzJhfv3IojCZajPnNT0rLzAurjv1uLve1
         IPgHB096FxAJPhITRnl7pp+WRXnu/xsd4J3wGzLWpyFUgd8vMZLOmDJZL8YkIQapeOFG
         bmXAOUE7nX0l+FSReIRqXLTo1KjVQORz4s5U6uaRL7QU3iSnq4AQlV2FlfkmJe03bWal
         83zKi0tPeia3eOXtXjAQulaXl8puWqi/mfwwG9nzMLzYRbFM3t6NNIzxaTWF1BhjOAtL
         xcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=m+1GIKGybOnQbLN7cTlm8oMOflp0sBv16OQu4gOE9/A=;
        b=SzdMAjSOCbc6yqdBSAWRzOD6BbFzabQSztm1C49RpSPYPyt8V/hYWb6sIU2Kfm8lrx
         FBveXBwpcLmuvqrP/RcYVhWXNDw6t+Zp0ieasVyrl0cfkCsbKw8Q+UW1MC/eSpXexnKA
         O6EXlhT4akrvICb1VsKPP/vBmCF+eN2UIlWtkgIZhI8R0qFDb12mGt9Vy/p0IX7yHvfv
         hq062hJOZYJp/xUCwaC+cO2Qy2VDk8MkwlE7MUcNF02gS4FQz80Bwchp+8n4nj7Dk7LY
         mUw9ytD/PuXHIzL7lNde4nH/khLvfi/fFYjPrz900Cr2y6Mm2q43Wag6/mquyz//hI0J
         KEgA==
X-Gm-Message-State: AOAM531FY2E/on0bk4dHxClsa5ZBTKJntuuCmZ49XKlyz4dWgVmnwepD
        rqKPt4FI+2+7juFLJY2nh/8=
X-Google-Smtp-Source: ABdhPJymAPQnihsodA6Yo6u41bnrJj6QjIfanBQZi3kmHKziRMS4Dfda7m/OupZYvSfD+U5q7NjunQ==
X-Received: by 2002:a63:135a:0:b0:3aa:2cf6:ffd7 with SMTP id 26-20020a63135a000000b003aa2cf6ffd7mr2100607pgt.351.1650596889254;
        Thu, 21 Apr 2022 20:08:09 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm541646pfh.177.2022.04.21.20.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 20:08:08 -0700 (PDT)
Date:   Fri, 22 Apr 2022 13:08:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>
References: <20220415164413.2727220-1-song@kernel.org>
        <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
        <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
        <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
        <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
        <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
        <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
        <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
        <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
        <1650511496.iys9nxdueb.astroid@bobo.none>
        <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
        <1650530694.evuxjgtju7.astroid@bobo.none>
        <25437eade8b2ecf52ff9666a7de9e36928b7d28f.camel@intel.com>
        <CAHk-=wiQcg=7++Odg08=eZZgdX4NKcPqiqGKXHNXqesTtfkmmA@mail.gmail.com>
        <1650584815.0dtcbd4qky.astroid@bobo.none>
        <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
In-Reply-To: <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
MIME-Version: 1.0
Message-Id: <1650596505.bxrmjmgjur.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Excerpts from Edgecombe, Rick P's message of April 22, 2022 12:29 pm:
> On Fri, 2022-04-22 at 10:12 +1000, Nicholas Piggin wrote:
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index e163372d3967..70933f4ed069 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -2925,12 +2925,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>                         if (nr !=3D nr_pages_request)
>>                                 break;
>>                 }
>> -       } else
>> -               /*
>> -                * Compound pages required for remap_vmalloc_page if
>> -                * high-order pages.
>> -                */
>> -               gfp |=3D __GFP_COMP;
>> +       }
>> =20
>>         /* High-order pages or fallback path if "bulk" fails. */
>> =20
>> @@ -2944,6 +2939,13 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>                         page =3D alloc_pages_node(nid, gfp, order);
>>                 if (unlikely(!page))
>>                         break;
>> +               /*
>> +                * Higher order allocations must be able to be
>> treated as
>> +                * indepdenent small pages by callers (as they can
>> with
>> +                * small page allocs).
>> +                */
>> +               if (order)
>> +                       split_page(page, order);
>> =20
>>                 /*
>>                  * Careful, we allocate and map page-order pages, but
>=20
> FWIW, I like this direction. I think it needs to free them differently
> though? Since currently assumes they are high order pages in that path.

Yeah I got a bit excited there, but fairly sure that's the bug.
I'll do a proper patch.

> I also wonder if we wouldn't need vm_struct->page_order anymore, and
> all the places that would percolates out to. Basically all the places
> where it iterates through vm_struct->pages with page_order stepping.
>=20
> Besides fixing the bisected issue (hopefully), it also more cleanly
> separates the mapping from the backing allocation logic. And then since
> all the pages are 4k (from the page allocator perspective), it would be
> easier to support non-huge page aligned sizes. i.e. not use up a whole
> additional 2MB page if you only need 4k more of allocation size.

Somewhat. I'm not sure about freeing pages back for general use when
they have page tables pointing to them. That will be a whole different
kettle of fish I suspect. Honestly I don't think fragmentation has
proven to be that bad of a problem yet that we'd want to do something
like that yet.

But there are other reasons to decople them in general. Some ppc32 I
think had a different page size that was not a huge page which it could
use to map vmalloc memory, for example.

In any case I have no objections to making that part of it more
flexible.

Thanks,
Nick
