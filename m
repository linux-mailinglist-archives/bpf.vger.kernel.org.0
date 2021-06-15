Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC563A8942
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFOTQN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFOTQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 15:16:13 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E32AC061574;
        Tue, 15 Jun 2021 12:14:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id c8so20372714ybq.1;
        Tue, 15 Jun 2021 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SudovuSbRB8a1R0CoP80ub18BBPWPYzhOZ+M0gmp2g=;
        b=ubcV+VVGnd0ooW/94gfv23V9u55S/tS/VcGQgXgSviYEL75nJeh7cZIT07wNyDy9dI
         oyI9CNoJw0CVhEcDgHvfxvvqc5NbXsrPBef4YpRxNHKuzPSi54GVwx5blsAh8rPSn5jA
         whadNm+3ZjGLSJRy86aeRuZTiIdYG/CSYc7zo1DD3G13m1pZX18PESRYX+bxWDMzDU+s
         pVApBOTQkE6TjL6dO0ervk0Ys44uF9b2Wycu9ZWuuF796aJLZ+tCxaKmDu53xxa/Jzsj
         ZnApRoHrF2moqHqH4UD/tmIKKJlVp8or2BZGNLxydD+h13nwiqZCcQNMs6y/uP56+7t6
         GZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SudovuSbRB8a1R0CoP80ub18BBPWPYzhOZ+M0gmp2g=;
        b=Boyg9T4qjDppdOxKmQ9GiAN9tGB1iZILDDkd6GUbLCba0/oBombfDhJMeK/kz+8X1Q
         AnP9XR8S4rhKLepo/HQVFz3OH/rNza9d+JOhVw8Bjjy4qj4a0ZFX+AOWsAVug7PTqzEp
         p1Fyvdu9bV9asbS02BgujjT8o2upFJAKW4ESMxihhXPf415JxorNACKyGc1txWVZ+rYc
         GoIm0ScNk8K4HB4bPb+ebiMxGKIQySKbhSS/2qNU8QjoKF4mRaW7EYdfGwHnPHwF2sW4
         PCskZV7SL4HF9YWZnEpN8xY+cwEK9k+Nt5vSmSTPsk6TgnR9gE1KTJwpm4Ec5cfkSDUi
         MRGw==
X-Gm-Message-State: AOAM532SLPVoHnLutlaKLf5bGDuc1aSSpUjGoMwK3ehhtsBb5vyiLvuw
        hbLv32I2hV1Zzd7a6an6CDU9qUOAeZo3BQihiBQ=
X-Google-Smtp-Source: ABdhPJywQGwvIDOJjVigX/y2AKjIQaM2Ab2tlWcsp1N5Yx5nt+fNoWLzGfFc7BE/YL6K2G/GHwiz+M/CEutVC59SHvQ=
X-Received: by 2002:a25:4182:: with SMTP id o124mr911895yba.27.1623784446368;
 Tue, 15 Jun 2021 12:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com> <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org> <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org> <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
 <YL4dGFsfb0ZzgxlR@kernel.org> <CAEf4BzYLXyjkmO6ZySUxFHu1HcctPQK3j3vAPXVWFJ8qvGe8kw@mail.gmail.com>
 <YL9pxDFIYQEUODM5@kernel.org> <YMj5CzF92pTjcbhO@kernel.org>
In-Reply-To: <YMj5CzF92pTjcbhO@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Jun 2021 12:13:55 -0700
Message-ID: <CAEf4BzaDNim+kFQx64i9EZogctGZNFigQBsog7eC6DjrfjTbEA@mail.gmail.com>
Subject: Re: Parallelizing vmlinux BTF encoding. was Re: [RFT] Testing 1.22
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 12:01 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 08, 2021 at 09:59:48AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jun 07, 2021 at 05:53:59PM -0700, Andrii Nakryiko escreveu:
> > > I think it's very fragile and it will be easy to get
> > > broken/invalid/incomplete BTF. Yonghong already brought up the case
>
> > I thought about that as it would be almost like the compiler generating
> > BTF, but you are right, the vmlinux prep process is a complex beast and
> > probably it is best to go with the second approach I outlined and you
> > agreed to be less fragile, so I'll go with that, thanks for your
> > comments.
>
> So, just to write some notes here from what I saw so far:
>
> 1. In the LTO cases there are inter-CU references, so the current code
> combines all CUs into one and we end up not being able to parallelize
> much. LTO is expensive, so... I'll leave it for later, but yeah, I don't
> think the current algorithm is ideal, can be improved.
>

Yeah, let's worry about LTO later.

> 2. The case where there's no inter CU refs, which so far is the most
> common, seems easier, we create N threads, all sharing the dwarf_loader
> state and the btf_encoder, as-is now. we can process one CU per thread,
> and as soon as we finish it, just grab a lock and call
> btf_encoder__encode_cu() with the just produced CU data structures
> (tags, types, functions, variables, etc), consume them and delete the
> CU.
>
> So each thread will consume one CU, push it to the 'struct btf' class
> as-is now and then ask for the next CU, using the dwarf_loader state,
> still under that lock, then go back to processing dwarf tags, then
> lock, btf add types, rinse, repeat.

Hmm... wouldn't keeping a "local" per-thread struct btf and just keep
appending to it for each processed CU until we run out of CUs be
simpler? So each thread does as much as possible locally without any
locks. And only at the very end we merge everything together and then
dedup. Or we can even dedup inside each worker before merging final
btf, that probably would give quite a lot of speed up and some memory
saving. Would be interesting to experiment with that.

So I like the idea of a fixed pool of threads (can be customized, and
I'd default to num_workers == num_cpus), but I think we can and should
keep them independent for as long as possible.

Another disadvantage of generating small struct btf and then lock +
merge is that we don't get as efficient string re-use, we'll churn
more on string memory allocation. Keeping bigger local struct btfs
allow for more efficient memory re-use (and probably a tiny bit of CPU
savings).

So please consider that, it also seems simpler overall.


>
> The ordering will be different than what we have now, as some smaller
> CUs (object files with debug) will be processed faster so will get its
> btf encoding slot faster, but that, at btf__dedup() time shouldn't make
> a difference, right?

Right, order doesn't matter.

>
> I think I'm done with refactoring the btf_encoder code, which should be
> by now a thin layer on top of the excellent libbpf BTF API, just getting
> what the previous loader (DWARF) produced and feeding libbpf.

Great.

>
> I thought about fancy thread pools, etc, researching some pre-existing
> thing or doing some kthread + workqueue lifting from the kernel but will
> instead start with the most spartan code, we can improve later.

Agree, simple is good. Really curious how much faster we can get. I
think anything fancy will give a relatively small improvement. The
biggest one will come from any parallelization.

>
> There it is, dumped my thoughts on this, time to go do some coding
> before I get preempted...
>
> - Arnaldo
>
> > - Arnaldo
> >
> > > for static variables. There might be some other issues that exist
> > > today, or we might run into when we further extend BTF. Like some
> > > custom linker script that will do something to vmlinux.o that we won't
> > > know about.
> > >
> > > And also this will be purely vmlinux-specific approach relying on
> > > extra and custom Kbuild integration.
> > >
> > > While if you parallelize DWARF loading and BTF generation, that will
> > > be more reliably correct (modulo any bugs of course) and will work for
> > > any DWARF-to-BTF cases that might come up in the future.
> > >
> > > So I wouldn't even bother with individual .o's, tbh.
> > >
> > > >
> > > > If this isn't the case, we can process vmlinux as is today and go on
> > > > creating N threads and feeding each with a DW_TAG_compile_unit
> > > > "container", i.e. each thread would consume all the tags below each
> > > > DW_TAG_compile_unit and produce a foo.BTF file that in the end would be
> > > > combined and deduped by libbpf.
> > > >
> > > > Doing it as my first sketch above would take advantage of locality of
> > > > reference, i.e. the DWARF data would be freshly produced and in the
> > > > cache hierarchy when we first encode BTF, later, when doing the
> > > > combine+dedup we wouldn't be touching the more voluminous DWARF data.
> > >
> > > Yep, that's what I'd do.
> > >
> > > >
> > > > - Arnaldo
> > > >
> > > > > confident about BTF encoding part: dump each CU into its own BTF, use
> > > > > btf__add_type() to merge multiple BTFs together. Just need to re-map
> > > > > IDs (libbpf internally has API to visit each field that contains
> > > > > type_id, it's well-defined enough to expose that as a public API, if
> > > > > necessary). Then final btf_dedup().
> > > >
> > > > > But the DWARF loading and parsing part is almost a black box to me, so
> > > > > I'm not sure how much work it would involve.
> > > >
> > > > > > I'm doing 'pahole -J vmlinux && btfdiff' after each cset and doing it
> > > > > > very piecemeal as I'm doing will help bisecting any subtle bug this may
> > > > > > introduce.
> > > >
> > > > > > > allow to parallelize BTF generation, where each CU would proceed in
> > > > > > > parallel generating local BTF, and then the final pass would merge and
> > > > > > > dedup BTFs. Currently reading and processing DWARF is the slowest part
> > > > > > > of the DWARF-to-BTF conversion, parallelization and maybe some other
> > > > > > > optimization seems like the only way to speed the process up.
> > > >
> > > > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > >
> > > > > > Thanks!
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
