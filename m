Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499B53A8B14
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 23:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFOV3S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOV3S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 17:29:18 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC5C06175F;
        Tue, 15 Jun 2021 14:27:11 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id h15so22535110ybm.13;
        Tue, 15 Jun 2021 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BD7mD8Ed5kG2YWIb/+Z+wONkj5tJURWksNlPU+c+ko=;
        b=epeLv1OrJsKIaxuMADeW3BNF4ao2gV2p5bnT5cpEWcTjKg8P7g61jrFwy8LJoD1Hq4
         c6P5cCxJfzJufKFcgN/J7xFx02Nr9QKveSSAH397iaAH072MDp+xAQt3JfH5xQssYLxL
         +ZyBUZJC5qjZjRFubrP1gO3kUom6rA3truw5B7FRsRfxcYhmxyAnsYuYXYj0Ese7Ycz5
         boJBf/ZrgoBw+1P+m0x7FtZqtFkUL3Znv8lwvfdBBn08A3NB622ac5M/icnWszl4yJWn
         AARdtixUsdQFnp7dN7U9GaQA8N6SQAVkPFMRQrjVmU8osSEBA7eKTbTHPmnv8FPQOG2/
         RwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BD7mD8Ed5kG2YWIb/+Z+wONkj5tJURWksNlPU+c+ko=;
        b=O9CPz39wngHvM+/+s2pRTYczbn+74XhC4+kA5ZOzwjKeAcWIT/EvZg5C3lE3eE6Kli
         nQuxFDLJv3fGyGseoSlShP9CXxDv1tNgVfFjuJsxAN7o8qASAVDC6nPhM/+G+YmlSgX0
         WJbpbv+A1DIgrVDYZgbqQpJoY1KkJKguLsxMx/f3BUJjbRTlRAVa/ifB73Hz4I82PFQH
         KMC/rcpZNZWGm8fmaqAMrTmyixAVV0YKKThSiaOzdqqzGgvXtd4ShJxz5JoAft0G7KZQ
         LPDWCdaED7C805us/LDhTkGHiI+Rt322CDEAghz2kqJ9pnQND819paAotrz97TlUqduv
         IzWw==
X-Gm-Message-State: AOAM530LTWUTOGQEsKp/aoe+xJbfHLmRbBrHSVCeKjP2hX4Tg8cF/+0e
        LYSN491l4CR93fAN1zNICc3+eHh+8lBMzz/7gqI=
X-Google-Smtp-Source: ABdhPJy6+VF+aAWAcUj5+f+AJxjO3pmvMW07c2eXvnRu1VIITYtHFvQJk40mblTGnKolUEgmT/zuYNWPGW1uuMkVetM=
X-Received: by 2002:a25:6612:: with SMTP id a18mr1695113ybc.347.1623792430625;
 Tue, 15 Jun 2021 14:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org> <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
 <YL4dGFsfb0ZzgxlR@kernel.org> <CAEf4BzYLXyjkmO6ZySUxFHu1HcctPQK3j3vAPXVWFJ8qvGe8kw@mail.gmail.com>
 <YL9pxDFIYQEUODM5@kernel.org> <YMj5CzF92pTjcbhO@kernel.org>
 <CAEf4BzaDNim+kFQx64i9EZogctGZNFigQBsog7eC6DjrfjTbEA@mail.gmail.com>
 <YMkBpBfqW+AcpyNN@kernel.org> <CAEf4Bza1XwHhjW6yzf9JTMQKkUFO3z23hb36B3HCHaJVR5gk4g@mail.gmail.com>
 <YMkM1o4AD2qnK0Mr@kernel.org>
In-Reply-To: <YMkM1o4AD2qnK0Mr@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Jun 2021 14:26:59 -0700
Message-ID: <CAEf4Bzah0km_0LXMD=VF5qGUWOGnC_WVtOQunar3eLwsR+ZTYw@mail.gmail.com>
Subject: Re: Parallelizing vmlinux BTF encoding. was Re: [RFT] Testing 1.22
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 1:26 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 15, 2021 at 01:05:30PM -0700, Andrii Nakryiko escreveu:
> > On Tue, Jun 15, 2021 at 12:38 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Tue, Jun 15, 2021 at 12:13:55PM -0700, Andrii Nakryiko escreveu:
> > > > On Tue, Jun 15, 2021 at 12:01 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > > > Em Tue, Jun 08, 2021 at 09:59:48AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > Em Mon, Jun 07, 2021 at 05:53:59PM -0700, Andrii Nakryiko escreveu:
> > > > > > > I think it's very fragile and it will be easy to get
> > > > > > > broken/invalid/incomplete BTF. Yonghong already brought up the case
> > >
> > > > > > I thought about that as it would be almost like the compiler generating
> > > > > > BTF, but you are right, the vmlinux prep process is a complex beast and
> > > > > > probably it is best to go with the second approach I outlined and you
> > > > > > agreed to be less fragile, so I'll go with that, thanks for your
> > > > > > comments.
> > >
> > > > > So, just to write some notes here from what I saw so far:
> > >
> > > > > 1. In the LTO cases there are inter-CU references, so the current code
> > > > > combines all CUs into one and we end up not being able to parallelize
> > > > > much. LTO is expensive, so... I'll leave it for later, but yeah, I don't
> > > > > think the current algorithm is ideal, can be improved.
> > >
> > > > Yeah, let's worry about LTO later.
> > >
> > > > > 2. The case where there's no inter CU refs, which so far is the most
> > > > > common, seems easier, we create N threads, all sharing the dwarf_loader
> > > > > state and the btf_encoder, as-is now. we can process one CU per thread,
> > > > > and as soon as we finish it, just grab a lock and call
> > > > > btf_encoder__encode_cu() with the just produced CU data structures
> > > > > (tags, types, functions, variables, etc), consume them and delete the
> > > > > CU.
> > > > >
> > > > > So each thread will consume one CU, push it to the 'struct btf' class
> > > > > as-is now and then ask for the next CU, using the dwarf_loader state,
> > > > > still under that lock, then go back to processing dwarf tags, then
> > > > > lock, btf add types, rinse, repeat.
> > > >
> > > > Hmm... wouldn't keeping a "local" per-thread struct btf and just keep
> > > > appending to it for each processed CU until we run out of CUs be
> > > > simpler?
> > >
> > > I thought about this as a logical next step, I would love to have a
> > > 'btf__merge_argv(struct btf *btf[]), is there one?
> > >
> > > But from what I've read after this first paragraph of yours, lemme try
> > > to rephrase:
> > >
> > > 1. pahole calls btf_encoder__new(...)
> > >
> > >    Creates a single struct btf.
> > >
> > > 2. dwarf_loader will create N threads, each will call a
> > > dwarf_get_next_cu() that is locked and will return a CU to process, when
> > > it finishes this CU, calls btf_encoder__encode_cu() under an all-threads
> > > lock. Rinse repeat.
> > >
> > > Until all the threads have consumed all CUs.
> > >
> > > then btf_encoder__encode(), which should be probably renamed to
> > > btf_econder__finish() will call btf__dedup(encoder->btf) and write ELF
> > > or raw file.
> > >
> > > My first reaction to your first paragraph was:
> > >
> > > Yeah, we can have multiple 'struct btf' instances, one per thread, that
> > > will each contain a subset of DWARF CU's encoded as BTF, and then I have
> > > to merge the per-thread BTF and then dedup. O think my rephrase above is
> > > better, no?
> >
> > I think I understood what you want to do from the previous email, so
> > you didn't have to re-phrase it, it's pretty clear already. I just
> > don't feel like having per-thread struct btf adds any complexity at
> > all and gives more flexibility and more parallelism. The next most
> > expensive thing after loading DWARF is string deduplication
> > (btf__add_str()), so it would be good to do that at per-thread level
> > as well as much as possible.
>
> So you think a per-thread dedup at the end of each thread is good, ok,
> no locking, good.
>
> But what about that question I made:
>
> > > I thought about this as a logical next step, I would love to have a
> > > 'btf__merge_argv(struct btf *btf[]), is there one?
>

Right, sorry, got too excited about parallelisation, forgot to reply to this.

I thought about this a bit in the context of BPF static linker work.
This is a bit problematic as a general API, because merging two BTFs
is not just appending types one after the other and calling it a day.
For DATASEC, for instance, you need to take few DATASEC with the same
name and combine them into a single DATASEC, otherwise resulting BTF
is non-sensical. While you are doing that, you need to re-adjust
variable offsets, take into account original data section alignment
requirements, etc. This operation can't be done safely in BTF only,
you need to know original ELF information (e.g., that ELF section
alignment). This is all done by static linker explicitly because only
static linker has enough information to do that. It goes even further,
extern VARs and FUNCs have to be resolved and de-duplicated (e.g.,
extern can be replaced with globals), etc. There is too much attached
semantics to some of BTF data.

So as a general API I don't see how it can be done nicely. Unless we
say that we'll error out if any VAR or DATASEC is found, or any extern
FUNC. Which sounds like a not-so-great idea right now.

But pahole has a bit simpler case, because BTF vars and DATASEC(s) are
generated at the very end, so it shouldn't be so complicated for
pahole. libbpf provides a generic btf__add_type() API that copies over
any type and associated strings (field names, func/struct names, etc).
That's quite a reduction in amount of code written. The only thing is
that after that IDs have to be updated and adjusted, because libbpf
doesn't have enough info to do this. So take a look at btf__add_type()
as a starting point.

Next, libbpf internally has btf_type_visit_type_ids() which will
provide a callback for each place in any btf_type that contains an ID.
This is the best way to adjust those IDs. We can probably expose those
APIs as public API because they are well-defined and have
straightforward semantics. So let me know.


> I haven't checked, is there alredy an libbpf BTF API that can merge an
> array or pre-deduped BTF, deduping it one more time?

btf__dedup() can be called multiple times on any struct btf, so once
you merge (see above), you can just dedup the merged btf to make it
small again.

>
> Anyway, so you suggest I start by having each dwarf_loader thread tied
> to a separate btf_encoder (a shim layer on top of a 'struct btf' and
> then at the end dedup each one, then combine the N 'struct btf' into
> one, then dump it into an ELF or raw file?

Yes, exactly.

>
> - Arnaldo
>
> > > > So each thread does as much as possible locally without any
> > > > locks. And only at the very end we merge everything together and then
> > > > dedup. Or we can even dedup inside each worker before merging final
> > > > btf, that probably would give quite a lot of speed up and some memory
> > > > saving. Would be interesting to experiment with that.
> > > >
> > > > So I like the idea of a fixed pool of threads (can be customized, and
> > > > I'd default to num_workers == num_cpus), but I think we can and should
> > > > keep them independent for as long as possible.
> > >
> > > Sure, this should map the whatever the user passes to -j in the kernel
> > > make command line, if nothing is passed as an argument, then default to
> > > getconf(_NPROCESSORS_ONLN).
> > >
> >
> > Yep, cool. I've been told that `make -j` puts no upper limit on number
> > of jobs, so we shouldn't follow make model completely :-P
> >
> > > There is a nice coincidence here where we probably don't care about -J
> > > anymore and want to deal only with -j (detached btf) that is the same as
> > > what 'make' expects to state how many "jobs" (thread pool size) the user
> > > wants 8-)
> > >
> > > > Another disadvantage of generating small struct btf and then lock +
> > > > merge is that we don't get as efficient string re-use, we'll churn
> > > > more on string memory allocation. Keeping bigger local struct btfs
> > > > allow for more efficient memory re-use (and probably a tiny bit of CPU
> > > > savings).
> > >
> > > I think we're in the same page, the contention for adding the CU to a
> > > single 'struct btf' (amongst all DWARF loading threads) after we just
> > > produced it should be minimal, so we grab all the advantages: locality
> > > of reference, minimal contention as DWARF reading/creating the pahole
> > > internal, neutral, data structures should be higher than adding
> > > types/functions/variables via the libbpf BTF API.
> >
> > I disagree, I think contention might be noticeable because merging
> > BTFs is still a relatively expensive/slow operation. But feel free to
> > start with that, I just thought that doing per-thread struct btf
> > wouldn't add any complexity, which is why I mentioned that.
> >
> > >
> > > I.e. we can leave paralellizing the BTF _encoding_ for later, what we're
> > > trying to do now is to paralellize the DWARF _loading_, right?
> >
> > We are trying to speed up DWARF-to-BTF generation in general, not
> > specifically DWARF loading. DWARF loading is an obvious most expensive
> > part, string deduplication is the next one, if you look at profiling
> > data. The third one will be btf__dedup, which is why I mentioned that
> > it might be faster still to do pre-dedup in each thread at the very
> > end, right before we do final dedup. Each individual dedup will
> > probably significantly reduce total size of data/strings, so I have a
> > feeling that it will result in a very nice speed-ups in the end.
> >
> > So just my 2 cents.
> >
> > >
> > > > So please consider that, it also seems simpler overall.
> > >
> > > > > The ordering will be different than what we have now, as some smaller
> > > > > CUs (object files with debug) will be processed faster so will get its
> > > > > btf encoding slot faster, but that, at btf__dedup() time shouldn't make
> > > > > a difference, right?
> > >
> > > > Right, order doesn't matter.
> > >
> > > > > I think I'm done with refactoring the btf_encoder code, which should be
> > > > > by now a thin layer on top of the excellent libbpf BTF API, just getting
> > > > > what the previous loader (DWARF) produced and feeding libbpf.
> > >
> > > > Great.
> > >
> > > > > I thought about fancy thread pools, etc, researching some pre-existing
> > > > > thing or doing some kthread + workqueue lifting from the kernel but will
> > > > > instead start with the most spartan code, we can improve later.
> > >
> > > > Agree, simple is good. Really curious how much faster we can get. I
> > > > think anything fancy will give a relatively small improvement. The
> > > > biggest one will come from any parallelization.
> > >
> > > And I think that is possible, modulo elfutils libraries saying no, I
> > > hope that will not be the case.
> >
> > You can't imagine how eagerly I'm awaiting this bright future of
> > faster BTF generation step in the kernel build process. :)
> >
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
