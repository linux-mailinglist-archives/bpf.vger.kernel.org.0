Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2950AE49
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 04:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443654AbiDVDAu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 23:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443657AbiDVDAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 23:00:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1F44E3B4;
        Thu, 21 Apr 2022 19:57:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t12so7880653pll.7;
        Thu, 21 Apr 2022 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=3akMlXOUHfEXtXPyGToH9wq3lIamzLSDaqQsdoOPBaE=;
        b=fj0BjRtmrJOPRlZkkgocJ2n+e/8Kra1AXR5yavLbvZan9HY/TyLWEDLmQVGT248Fje
         J05n/BwlqZq2uALqmAJYNXFOfE9vP8l+CVESL9EU6dcZMu1iKTGnv/DYiTqA4Ns2L3tI
         MCJYRvnkRyPgQt7lAkeMRQjmdfQYYWe0IK9v8CmmrpM/z9WxYpLjvagSCKj3xB2DajAR
         o2z739Rn7/8D1i6/yZvJoguRSrnrpu6pZf9tCNol1xS+yf8cirYhot3HdGOxJ9YBl74M
         BvM4nCRpGzvtV0osDgft7c6Fg4z3zb6Su/9ZjHocFxAIWZXs7WauqWII42yaM8cf0C7i
         VKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=3akMlXOUHfEXtXPyGToH9wq3lIamzLSDaqQsdoOPBaE=;
        b=U7acP15suX/p/ZZVXVvyJn3dvhUk0E3lNAp1BFrPs2yR+2CzFHaMzYuqlQJ7tsmnbO
         bTAYp4A02GKNHuJzd14nK29K99Tz72GEm0viHpy7w0YPySgKhmd+fI0x+txDwMiSqNo8
         r07QpHFoDOZM7LZE4poYP3rvBj1Lgi/9J6f4XL16dWQEt2io/fWp511ID2GHxxpoGlit
         S0Wk8ubJo+vZy+yCbrVDheasBsQEYJ98gSMlBtAuoY9lcMiJk9L+Pxwpu3bOORrb5U0g
         JVUk/bRO0Je8mZt3oPRU7YhT1i9luRwWbUHYzrJ+Il5SOZ1dbDuC3/WoWMAyhMc1MIUR
         rXmA==
X-Gm-Message-State: AOAM533YVkD+N2sRVii88NeLPGFK5h2Jk+Xd6R2SHrFqV8RVeXHpJnao
        s3rI05SgFNnBFonke/K5lOo=
X-Google-Smtp-Source: ABdhPJyGcqex7zhr8Wcclsv89p55uMKajRS3jAC1lbdwmN6wB79bjt0F+KYldNdsHZJ/ABVvYlDxQw==
X-Received: by 2002:a17:902:bd88:b0:14f:8ddf:e373 with SMTP id q8-20020a170902bd8800b0014f8ddfe373mr2481863pls.89.1650596245032;
        Thu, 21 Apr 2022 19:57:25 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a714600b001d7f3bb11d7sm551214pjs.53.2022.04.21.19.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:57:24 -0700 (PDT)
Date:   Fri, 22 Apr 2022 12:57:19 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
        <1650582120.hf4z0mkw8v.astroid@bobo.none>
        <CAHk-=wh_7npMESkkeJ0dZC=EDPhn8+iyg528rE_GjnKpsUkT=A@mail.gmail.com>
        <1650590628.043zdepwk1.astroid@bobo.none>
        <CAHk-=wjiV5LHnbFs+ObSK-cDdCc7pEV+mMUJcZJPnj4RnOGd2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjiV5LHnbFs+ObSK-cDdCc7pEV+mMUJcZJPnj4RnOGd2Q@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1650595194.2p2xfw4sgk.astroid@bobo.none>
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

Excerpts from Linus Torvalds's message of April 22, 2022 12:31 pm:
> On Thu, Apr 21, 2022 at 6:51 PM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> > See
>> >
>> >     https://lore.kernel.org/all/20220415164413.2727220-3-song@kernel.o=
rg/
>> >
>> > for [PATCH 2/4] in the series for this particular issue.
>>
>> I was being facetious. The problem is you can't do ^ because x86 is
>> buggy.
>=20
> No, we probably *can* do that PATCH 2/4. I suspect x86 really isn't
> that buggy. The bugs are elsewhere (including other vmalloc_huge()
> uses).

I thought Rick seemed to be concerned about other issues but if
not then great, I would happily admit to being mistaken.

>=20
> Really. Why can't you just admit that the major bug was in the
> hugepage code itself?

Uh, I did. But not the concept. You admit you were going stupid
and freaking about about vmalloc_to_page which is really not
some insurmountable problem.

>=20
> You claim:
>=20
>> Because it can be transparent. The bug was (stupidly) using compound
>> pages when it should have just used split higher order pages.
>=20
> but we're in -rc3 for 5.18, and you seem to be entirely ignoring the
> fact that that stupid bug has been around for a *YEAR* now.

I'm not ignoring that at all. Again I completely agree that path is
unlikely to have been tested (or at least not reported) on
powerpc or s390.

> Guess what? It was reported within *days* of the code having  been
> enabled on x86.

Is that supposed to be a gotcha? If I was cc'ed on it I might have
fixed it a month ago, but why would it be unusual for major new
coverage of such a big feature to expose a bug?

> But for about a year, youv'e been convinced that powerpc is fine,
> because nobody ever reported it.
>=20
> And you *still* try to make this about how it's some "x86 bug",
> despite that bug not having been x86-specific AT ALL.

I think we're talking past one another. I never said that bug
was x86 specific, it was only just brought to my attention now
and I (presume that I) fixed it within 10 minutes of looking at
it.

That's not what I understood to be the only x86 problem though,
but again as I said I'll admit I misunderstood that if it's not
the case.

[snip]

> For example, your "two-liner fix" is not at all obvious.

It is pretty obvious. Something wanted to use a tail page and
ran afoul of the compound page thing. Splitting the page just
gives us an array of conguous small pages.

> That broken code case used to have a comment that remap_vmalloc_page()
> required compound pages, and you just removed that whole thing as if
> it didn't matter, and split the page.

The new comment is a superset, I agree the old comment is
under-done. remap_vmalloc_page() wanted to get_page the sub
pages and without compound or split huge page they have a ref
count of 0 so that blows up.

split page just makes the pages behave exactly as they would
if allocated individually (i.e., the small page case).

Yes a stupid thinko on my part when I added that, but that's
all it is, it's an obvious thing.

> (I also think the comment meant 'vmap_pages_range()', but whatever).

remap_vmalloc_range I think. But clearly the same issue applies
to any caller which may use the struct pages for stuff.

> And the thing is, I'm not entirely convinced that comment was wrong
> and could just be ignored. The freeing code in __vunmap() will do
>=20
>                 int i, step =3D 1U << page_order;
>=20
>                 for (i =3D 0; i < area->nr_pages; i +=3D step) {
>                         struct page *page =3D area->pages[i];
>=20
>                         BUG_ON(!page);
>                         mod_memcg_page_state(page, MEMCG_VMALLOC, -step);
>                         __free_pages(page, page_order);
>=20
> which now looks VERY VERY wrong.
>=20
> You've split the pages, they may be used as individual pages (possibly
> by other things), and then you now at freeing time treat them as a
> single compound page after all..

Oh yeah I'll take a look at the freeing side too, as I said
totally untested but that's obviously the issue.

>=20
> So your "trivial two-liner" that tried to fix a bug that has been
> there for a year now, itself seems quite questionable.
>=20
> Maybe it works, maybe it doesn't. My bet is "it doesn't".
>=20
> And guess what? I bet it worked just fine in your testing on powerpc,
> because you probably didn't actually have any real huge-page vmalloc
> cases except for those filesystem big-hash cases that never get
> free'd.
>=20
> So that "this code was completely buggy for a year on powerpc" never
> seemed to teach you anything about the code.
>=20
> And again - none of this is at all x86-specific. NOT AT ALL.
>=20
> So how about you admit you were wrong to begin with.
>=20
> That hugepage code needs more care before we re-enable it.
>=20
> Your two-liner wasn't so obvious after all, was it?
>=20
> I really think we're much safer saying "hugepage mappings only matter
> for a couple of things, and those things will *not* do sub-page games,
> so it's simple and safe".
>=20
> .. and that requires that opt-in model.
>=20
> Because your "it's transparent" argument has never ever actually been
> true, now has it?

Of course it has. You admit you didn't understand the design and
freaked out about vmalloc_to_page when drivers playing games with
struct page is a non issue.

I'm not a moron, clearly if it wasn't intended to be transparent to
callers it could not have just been enabled unconditionally. What's
so difficult to you about the concept that the arch code is really
the only thing that has to know about its page table arrangement?

You're now fixating on this bug as though that invalidates the whole
concept of huge vmalloc being transparent to callers. That's being
disingenous though, it's just a bug. That's all it is. You merge
fixes for hundreds of bugs everywhere in the tree every day. You're
using it as a crutch because you can't admit you were wrong about it
being transparent to drivers and thinking it has to be opt-in.

Anyway blah whatever. I admit to everything, I did it, I'm bad I did
a huge booboo a year ago, huge vmalloc is stupid, x86 is wonderful,
everything else is garbage, Linus is great. Okay?

I'll polish up the patch (*and* test it with a specifically written
test case just for your), and then we can see if it solves that drm
bug and we can go from there.

Thanks,
Nick
