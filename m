Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3608050ADDB
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 04:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443415AbiDVCmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 22:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443360AbiDVCmF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 22:42:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085394BB9B
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 19:39:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l7so13681051ejn.2
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 19:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXY8vM5gipgpM7Xccl9ZLsPXwuvlwZprON91blgLX0g=;
        b=SHuGY33SCY7YguKUvgEG1+A1IUipTd1k1koT2htJ9P/On9R5tGcTGxcMT4d6PfouzG
         QKx1bjmMcYClZerXPl5o9F4get9HAK/EKDkkAVbgwOsdhJ89By/t46O2k21cbxYy58Tb
         5EsDmv65Gc3MTSJ4RKWX/wea8jAy1CewCz1Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXY8vM5gipgpM7Xccl9ZLsPXwuvlwZprON91blgLX0g=;
        b=LJ0Pzfoi9uAmOcsoepakqbvvTzcXaQcTVcjkPe1OQHAqNBOVXQdnPWDAUvqNKe/2bd
         XZ5pGwzHTbYpXUqKGnJNTFgwKxVwGeEowbHQzl177bvAGpbRViC9mubOB+JTj/g3LfXx
         PAb1Pg1KAvdLhRwtDXqekNVHMUFWHkP08fXRq8hqKyDO9YBAT8g/SaANQe965q48nkMw
         87XuX5R6Gc75DU7YYKhS63t4Vn7BYB+0MTk/v/IBAXZK20iEQyG+Z6PZlQFonJhqsOuq
         eYJA0ufU2t5U80P7x0lv4GMd6orQgwmPUsrvQlRAG3tzBdwzY8te14mkWnsllmH//fVw
         xAAw==
X-Gm-Message-State: AOAM531zB8UpkWkED9agWkshfmm1jJoUPsXdFFltYtuh8Ic3ymVEYtkx
        4EBdZVD3IMd2GV+gwjPBdT2M2+cRGrVlwfWGBPU=
X-Google-Smtp-Source: ABdhPJz5xOtM2OoBzbOS5hUdyeTY8rXf4aSJj32YHEBuh69U6wT7sv0gybAAoxgQ3pU33a4v44vvzA==
X-Received: by 2002:a17:907:2ce5:b0:6f0:1d2c:118d with SMTP id hz5-20020a1709072ce500b006f01d2c118dmr2097317ejc.715.1650595152411;
        Thu, 21 Apr 2022 19:39:12 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id n14-20020a50934e000000b0042053e79386sm306702eda.91.2022.04.21.19.39.12
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 19:39:12 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id s18so13730433ejr.0
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 19:39:12 -0700 (PDT)
X-Received: by 2002:a2e:91d9:0:b0:24d:c221:4941 with SMTP id
 u25-20020a2e91d9000000b0024dc2214941mr1494670ljg.164.1650594682049; Thu, 21
 Apr 2022 19:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <1650511496.iys9nxdueb.astroid@bobo.none> <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
 <1650530694.evuxjgtju7.astroid@bobo.none> <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
 <1650582120.hf4z0mkw8v.astroid@bobo.none> <CAHk-=wh_7npMESkkeJ0dZC=EDPhn8+iyg528rE_GjnKpsUkT=A@mail.gmail.com>
 <1650590628.043zdepwk1.astroid@bobo.none>
In-Reply-To: <1650590628.043zdepwk1.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 19:31:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiV5LHnbFs+ObSK-cDdCc7pEV+mMUJcZJPnj4RnOGd2Q@mail.gmail.com>
Message-ID: <CAHk-=wjiV5LHnbFs+ObSK-cDdCc7pEV+mMUJcZJPnj4RnOGd2Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 6:51 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> > See
> >
> >     https://lore.kernel.org/all/20220415164413.2727220-3-song@kernel.org/
> >
> > for [PATCH 2/4] in the series for this particular issue.
>
> I was being facetious. The problem is you can't do ^ because x86 is
> buggy.

No, we probably *can* do that PATCH 2/4. I suspect x86 really isn't
that buggy. The bugs are elsewhere (including other vmalloc_huge()
uses).

Really. Why can't you just admit that the major bug was in the
hugepage code itself?

You claim:

> Because it can be transparent. The bug was (stupidly) using compound
> pages when it should have just used split higher order pages.

but we're in -rc3 for 5.18, and you seem to be entirely ignoring the
fact that that stupid bug has been around for a *YEAR* now.

Guess what? It was reported within *days* of the code having  been
enabled on x86.

But for about a year, youv'e been convinced that powerpc is fine,
because nobody ever reported it.

And you *still* try to make this about how it's some "x86 bug",
despite that bug not having been x86-specific AT ALL.

Nick, please take a long look at yourself in the mirror.

And stop this whole mindless "it's x86".

The *ONLY* thing x86-64 did was to show that the code that had been
enabled on powerpc for a year had gotten almost no testing there.

And don't bother mentioning s390. It got even less coverage there.

So exactly *because* bugs were uncovered in days by x86 enabling this,
I'm not rushing to re-enable it until I think it's gone through more
thinking and testing.

And in particular, I really *really* want to limit the fallout.

For example, your "two-liner fix" is not at all obvious.

That broken code case used to have a comment that remap_vmalloc_page()
required compound pages, and you just removed that whole thing as if
it didn't matter, and split the page.

(I also think the comment meant 'vmap_pages_range()', but whatever).

And the thing is, I'm not entirely convinced that comment was wrong
and could just be ignored. The freeing code in __vunmap() will do

                int i, step = 1U << page_order;

                for (i = 0; i < area->nr_pages; i += step) {
                        struct page *page = area->pages[i];

                        BUG_ON(!page);
                        mod_memcg_page_state(page, MEMCG_VMALLOC, -step);
                        __free_pages(page, page_order);

which now looks VERY VERY wrong.

You've split the pages, they may be used as individual pages (possibly
by other things), and then you now at freeing time treat them as a
single compound page after all..

So your "trivial two-liner" that tried to fix a bug that has been
there for a year now, itself seems quite questionable.

Maybe it works, maybe it doesn't. My bet is "it doesn't".

And guess what? I bet it worked just fine in your testing on powerpc,
because you probably didn't actually have any real huge-page vmalloc
cases except for those filesystem big-hash cases that never get
free'd.

So that "this code was completely buggy for a year on powerpc" never
seemed to teach you anything about the code.

And again - none of this is at all x86-specific. NOT AT ALL.

So how about you admit you were wrong to begin with.

That hugepage code needs more care before we re-enable it.

Your two-liner wasn't so obvious after all, was it?

I really think we're much safer saying "hugepage mappings only matter
for a couple of things, and those things will *not* do sub-page games,
so it's simple and safe".

.. and that requires that opt-in model.

Because your "it's transparent" argument has never ever actually been
true, now has it?

           Linus
