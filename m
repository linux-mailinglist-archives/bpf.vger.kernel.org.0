Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5650AD73
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 03:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443189AbiDVBye (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443188AbiDVByd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 21:54:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CF945065;
        Thu, 21 Apr 2022 18:51:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b7so7633276plh.2;
        Thu, 21 Apr 2022 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=B98v3XXzVP/BYJh6cWCGdbXJ00k6Ughw5NECZ647UGw=;
        b=N2SgEMtzALmub/c6fZYQwOcFuwvHCu7LAlV/LZKgwlFkF3FGU/23TtVcOk25zhJNpr
         GUhtQBIa/kdbMfrH+6Evy/nv+FSOvfXCm0uIWcb1kF4coTY7gISR85lLyb2otpis/QHs
         MRNFjjzmK3GWPWR1aXR57sr9if9ZoXd2ziJVCE7GawNffjJdDmGHDuWZlw3C6zpOAUe+
         uWVMFNUUwPUNKth9h3eWtBdxsGW34JpBzXF7/e76KoeNL7Zk6icw9dZJ6Rbb1qsrwEKB
         qUElhQ3rbx7AxSDcrH2AvUxV2iG1tmzrKq4pdlEHzYX68681OUgLergZCe93FgKpt2RR
         Lu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=B98v3XXzVP/BYJh6cWCGdbXJ00k6Ughw5NECZ647UGw=;
        b=sjexkbfUy89Je1EBWvAYQc6NY29C3ecHyxD5YDf9TCo1dKmXbz2TTKFHmOW1OQkoSr
         ACqntmkYopyksBn0694S7NVXwkmWHcpgvLDJNAkfBAIAPmzt1f9ABbza1c0MFOSV7FIw
         2pSI+kR6+kGZP5+6GfQL0y0AuKsQvGkgNCUKW45M2n7Tg8QZumT42sC6NMKzyOqe7ySz
         45rKWf/GNbD/fy8/Q+mxCvczOGT4XaLL9TOy9Dajb7Bcmr4LZPGkhGkbYPur79ir9m9V
         JCnNAUFacHIGvqjX/OQJu/NuYDzi/mcljTuW2TZTX3+OBYtD3i8WdEXGuevFt1t5+gcy
         5M6Q==
X-Gm-Message-State: AOAM532GK+Dbynfx5je+Ps31dt4mhMIR3roQkmuD2hlFZjnuXCLoJf5H
        cHFA1cLaaeBP2Zow6JPa1GY=
X-Google-Smtp-Source: ABdhPJy4GEqG7iiHbr0f7xWhcJ2Q73XWGGVDik/zxxvkxkJbAb/vAvwoEN/IPb2lzmIineD8ehqbNw==
X-Received: by 2002:a17:90b:1e0e:b0:1d2:8906:cffe with SMTP id pg14-20020a17090b1e0e00b001d28906cffemr2725064pjb.220.1650592301486;
        Thu, 21 Apr 2022 18:51:41 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00509fbf03c91sm402098pfi.171.2022.04.21.18.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 18:51:40 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:51:35 +1000
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
In-Reply-To: <CAHk-=wh_7npMESkkeJ0dZC=EDPhn8+iyg528rE_GjnKpsUkT=A@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1650590628.043zdepwk1.astroid@bobo.none>
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

Excerpts from Linus Torvalds's message of April 22, 2022 10:49 am:
> On Thu, Apr 21, 2022 at 4:30 PM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> VM_FLUSH_RESET_PERMS was because bpf uses the arch module allocation
>> code which was not capable of dealing with huge pages in the arch
>> specific direct map manipulation stuff was unable to deal with it.
>> An x86 bug.
>=20
> .. and a power one? The only thing really special in  __module_alloc()
> on power is that same VM_FLUSH_RESET_PERMS.
>=20
> Why had you otherwise disabled it there on powerpc too?

Right, it is for that (and possibly other similar ro->nx stuff for
module loading and instruction patching etc).

That's why we don't do huge vmalloc for executable mappings (yet).

I don't understand why you're trying to claim that limitation is a
bug in power or warrants disabling the whole thing for data mappings
as well.

>=20
>> > And that bug was an issue on power too.
>>
>> I missed it, which bug was that?
>=20
> See above. At least it's very strongly implied by how the powerpc
> __module_alloc() function also used
>=20
>                     VM_FLUSH_RESET_PERMS | VM_NO_HUGE_VMAP,
>=20
> because there isn't much else going on.

So that's not a bug though. To be clear, VM_FLUSH_RESET_PERMS is
clearly never to be used in driver code, it's a low-level arch
specific detail. So the flag itself does not have to be usable
by any old random code.

>=20
>> No I don't notice. More work to support huge allocations for
>> executable mappings, sure. But the arch's implementation explicitly
>> does not support that yet. That doesn't make huge vmalloc broken!
>> Ridiculous. It works fine.
>=20
> There are several other reports of problems that weren't related to
> permissions (at least not obviously so).
>=20
> You were pointed at one of them in this thread:
>=20
>     https://lore.kernel.org/all/14444103-d51b-0fb3-ee63-c3f182f0b546@molg=
en.mpg.de/

Right, I agree see the patch I posted.

>=20
> and yes, it also happened on x86-64, but my point this whole time has
> been that x86-64 gets A *LOT* MORE TEST COVERAGE.
>=20
> See the difference? The fact that it has workedc for you on powerpc
> doesn't mean that it's fine on powerpc.  It only means that powerpc
> gets about one thousandth of the test coverage that x86-64 gets.

Surely it's not unreasonable that there will be *some* bugs when
coverage is expanded.

I'm not saying the code I write is perfect and bug-free when I say
it's fine on power, I'm saying that in concept it is fine.

>=20
>> You did just effectively disable it on x86 though.
>=20
> I disabled it *EVERYWHERE*.
>=20
> What is so hard to understand about that?
>=20
> Why are you so convinced this is about x86?

Well the x86 bugs in its direct mapping stuff seem to be. If they
go away when not using huge mappings for modules then fine, I'm
just not really across all the issues but it sounded like there
were more than just this module case.

>=20
> It's not.
>=20
>> There really aren't all these "issues" you're imagining. They
>> aren't noticable now, on power or s390, because they have
>> non-buggy HAVE_ARCH_HUGE_VMALLOC implementations.
>=20
> So I really think you've not tested it.
>=20
> How many of those powerpc or s390 machines do you think test drivers
> that do vmalloc_to_page() and then do something with that 'struct page
> *'?

Probably quite a few, but the intersection of those with ones that
also allocate huge vmalloc *and* modify struct page fields to trip
that bug was probably empty.

> Seriously. Why are you so convinced that "oh, any vmalloc() can be
> converted to large pages"?

Because it can be transparent. The bug was (stupidly) using compound
pages when it should have just used split higher order pages.

But the whole idea of it is that it's supposed to be transparent to
drivers. I don't get why you're freaking out about vmalloc_to_page(),
a huge mapping is pretty much just like a small mapping except the
pages are contiguous and the page tables are a bit different.

> I really think the only reason you think that is because it ran on
> machines that basically have almost no drivers in use, and are all
> very homogenous, and just didn't happen to hit the bugs.
>=20
> IOW, I think you are probably entirely right that x86 has its own set
> of excitement (the bpf thread has this thing about how x86 does RO
> differently from other architectures), and there are likely x86
> specific bugs *TOO*.
>=20
> But let's just pick a random driver that uses vmalloc (literally
> random - I just grepped for it and started looking at it):
>=20
>    drivers/infiniband/hw/qib/qib_file_ops.c
>=20
> and it unquestionably does absolutely disgusting things, and if
> looking at the code makes you go "nobody should do that", then I won't
> disagree all that much.
>=20
> But as an example of what it does, it basically does things like this:
>=20
>         rcd->subctxt_uregbase =3D vmalloc_user(...);
>=20
> and then you can mmap it in user space in mmap_kvaddr():
>=20
>                 addr =3D rcd->subctxt_uregbase;
>                 size =3D PAGE_SIZE * subctxt_cnt;
>         ...
>         vma->vm_pgoff =3D (unsigned long) addr >> PAGE_SHIFT;
>         vma->vm_ops =3D &qib_file_vm_ops;
>=20
> and then the page fault routine is:
>=20
>     static const struct vm_operations_struct qib_file_vm_ops =3D {
>             .fault =3D qib_file_vma_fault,
>     };
>=20
> and that function qib_file_vma_fault() does things like this:
>=20
>         page =3D vmalloc_to_page((void *)(vmf->pgoff << PAGE_SHIFT));
>         if (!page)
>                 return VM_FAULT_SIGBUS;
>=20
>         get_page(page);
>         vmf->page =3D page;
>=20
>         return 0;
>=20
> and let me just claim
>=20
>  (a) I bet you have never EVER tested this kind of insane code on powerpc
>=20
>  (b) do you think this will work great if vmalloc() allocates large pages=
?

Yes of course it will, with said 2-line bugfix.

> Can you now see what I'm saying?
>=20
> Can you now admit that the whole "nmake vmalloc() do large pages
> without explicit opt-in" was a HORRIBLE MISTAKE.

No, can you admit that vmalloc_to_page is not some some crazy problem?
The drivers are doing fairly horrible things sure, but *nothing* can
look at the PTEs without going through accessors (except arch code
obviously, which has to adapt before enabling). vmalloc_to_page() just
gives you a struct page! Why would a driver care that it now happens
to be contiguous with the next one or not??

>> If you're really going to insist on this will you apply this to fix
>> (some of) the performance regressions it introduced?
>=20
> No.
>=20
> That patch is disgusting and there is no excuse for applying something
> crap like that.
>=20
> What I applied was the first in a series of patches that do it sanely.
> That whole "a sane way forward" thing.
>=20
> See
>=20
>     https://lore.kernel.org/all/20220415164413.2727220-3-song@kernel.org/
>=20
> for [PATCH 2/4] in the series for this particular issue.


I was being facetious. The problem is you can't do ^ because x86 is
buggy.

>=20
> But I'm not applying anything else than the "disable this mess" before
> we have more discussion and consensus.
>=20
> And dammit, you had better just admit that this wasn't some x86-only thin=
g.
>=20
> Powerpc and s390 were BROKEN GARBAGE AND JUST DIDN'T HAVE THE TEST COVERA=
GE.

Everybody writes bugs, nobody has 100% test coverage. I missed
something, big whoop. That doesn't invalidate the entire concept
of the feature.

>=20
> Seriously.
>=20
> And the thing is, your opt-out approach was just POINTLESS. The actual
> cases that are performance-critical are likely in the single digits.
>=20
> It's probably just that big-hash case and maybe a *couple* of other
> cases (ie the bpf jit really wants to use it).
>=20
> So opt-in is clearly the correct thing to do.
>=20
> Do you now understand why I applied that "users must opt-in" patch?

No, opt-in for correctness is stupid and unecessary because callers=20
shouldn't have to know about it. That's the whole point of the huge
vmalloc is that it's supposed to be transparent to non-arch code.

That drm screen buffer thing involved in the bug -- why wouldn't that
want to use huge pages?

>=20
> Do you now understand that this is not some "x86" thing?
>=20

If the only bug is that compound page thing and x86 is otherwise fine
then sure, and patch 1 was unnecessary to begin with.

Thanks,
Nick
