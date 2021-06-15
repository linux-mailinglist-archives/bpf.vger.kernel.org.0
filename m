Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C093A8A21
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 22:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFOU2H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 16:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOU2H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 16:28:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0759613B3;
        Tue, 15 Jun 2021 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623788762;
        bh=hh3vY7ei/sP5ZbWNcTCtJxQJhKZcnhNL6eMimVeGefo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJiDRE54txxkMgWORfKnTLTjausW5HP+NumUVzVkJuTzLx9oGQEi0NeldC2yN/A98
         WDGwgOKqcCrDas3GdHmf49HedavB4YPNVVmeSocLdB3euzNhaqnd8sn7BQEjsDv4N4
         O9+X3SAyzUak6o5vehZKcNcwh6QKNfT6BnI7LxvrOOw2SUkP9UvLJZVKw4GZgsPG+1
         iC0kfmZSUP58ffRVlkfS5Iv5T9FzQOH0mEGKV8BbX1GdE9O7tp11W1Wbp+rBI50Uvs
         tqUFJ/vFBpevOFguJJm7vyoHEgLZzNqIyRrXJ3HliF7czZB4R2ClM9HuLZBgf54jbG
         zfe0AKEA8Jp5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B99C140B1A; Tue, 15 Jun 2021 17:25:58 -0300 (-03)
Date:   Tue, 15 Jun 2021 17:25:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parallelizing vmlinux BTF encoding. was Re: [RFT] Testing 1.22
Message-ID: <YMkM1o4AD2qnK0Mr@kernel.org>
References: <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org>
 <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
 <YL4dGFsfb0ZzgxlR@kernel.org>
 <CAEf4BzYLXyjkmO6ZySUxFHu1HcctPQK3j3vAPXVWFJ8qvGe8kw@mail.gmail.com>
 <YL9pxDFIYQEUODM5@kernel.org>
 <YMj5CzF92pTjcbhO@kernel.org>
 <CAEf4BzaDNim+kFQx64i9EZogctGZNFigQBsog7eC6DjrfjTbEA@mail.gmail.com>
 <YMkBpBfqW+AcpyNN@kernel.org>
 <CAEf4Bza1XwHhjW6yzf9JTMQKkUFO3z23hb36B3HCHaJVR5gk4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza1XwHhjW6yzf9JTMQKkUFO3z23hb36B3HCHaJVR5gk4g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jun 15, 2021 at 01:05:30PM -0700, Andrii Nakryiko escreveu:
> On Tue, Jun 15, 2021 at 12:38 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Jun 15, 2021 at 12:13:55PM -0700, Andrii Nakryiko escreveu:
> > > On Tue, Jun 15, 2021 at 12:01 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > > > Em Tue, Jun 08, 2021 at 09:59:48AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Mon, Jun 07, 2021 at 05:53:59PM -0700, Andrii Nakryiko escreveu:
> > > > > > I think it's very fragile and it will be easy to get
> > > > > > broken/invalid/incomplete BTF. Yonghong already brought up the case
> >
> > > > > I thought about that as it would be almost like the compiler generating
> > > > > BTF, but you are right, the vmlinux prep process is a complex beast and
> > > > > probably it is best to go with the second approach I outlined and you
> > > > > agreed to be less fragile, so I'll go with that, thanks for your
> > > > > comments.
> >
> > > > So, just to write some notes here from what I saw so far:
> >
> > > > 1. In the LTO cases there are inter-CU references, so the current code
> > > > combines all CUs into one and we end up not being able to parallelize
> > > > much. LTO is expensive, so... I'll leave it for later, but yeah, I don't
> > > > think the current algorithm is ideal, can be improved.
> >
> > > Yeah, let's worry about LTO later.
> >
> > > > 2. The case where there's no inter CU refs, which so far is the most
> > > > common, seems easier, we create N threads, all sharing the dwarf_loader
> > > > state and the btf_encoder, as-is now. we can process one CU per thread,
> > > > and as soon as we finish it, just grab a lock and call
> > > > btf_encoder__encode_cu() with the just produced CU data structures
> > > > (tags, types, functions, variables, etc), consume them and delete the
> > > > CU.
> > > >
> > > > So each thread will consume one CU, push it to the 'struct btf' class
> > > > as-is now and then ask for the next CU, using the dwarf_loader state,
> > > > still under that lock, then go back to processing dwarf tags, then
> > > > lock, btf add types, rinse, repeat.
> > >
> > > Hmm... wouldn't keeping a "local" per-thread struct btf and just keep
> > > appending to it for each processed CU until we run out of CUs be
> > > simpler?
> >
> > I thought about this as a logical next step, I would love to have a
> > 'btf__merge_argv(struct btf *btf[]), is there one?
> >
> > But from what I've read after this first paragraph of yours, lemme try
> > to rephrase:
> >
> > 1. pahole calls btf_encoder__new(...)
> >
> >    Creates a single struct btf.
> >
> > 2. dwarf_loader will create N threads, each will call a
> > dwarf_get_next_cu() that is locked and will return a CU to process, when
> > it finishes this CU, calls btf_encoder__encode_cu() under an all-threads
> > lock. Rinse repeat.
> >
> > Until all the threads have consumed all CUs.
> >
> > then btf_encoder__encode(), which should be probably renamed to
> > btf_econder__finish() will call btf__dedup(encoder->btf) and write ELF
> > or raw file.
> >
> > My first reaction to your first paragraph was:
> >
> > Yeah, we can have multiple 'struct btf' instances, one per thread, that
> > will each contain a subset of DWARF CU's encoded as BTF, and then I have
> > to merge the per-thread BTF and then dedup. O think my rephrase above is
> > better, no?
> 
> I think I understood what you want to do from the previous email, so
> you didn't have to re-phrase it, it's pretty clear already. I just
> don't feel like having per-thread struct btf adds any complexity at
> all and gives more flexibility and more parallelism. The next most
> expensive thing after loading DWARF is string deduplication
> (btf__add_str()), so it would be good to do that at per-thread level
> as well as much as possible.

So you think a per-thread dedup at the end of each thread is good, ok,
no locking, good.

But what about that question I made:

> > I thought about this as a logical next step, I would love to have a
> > 'btf__merge_argv(struct btf *btf[]), is there one?

I haven't checked, is there alredy an libbpf BTF API that can merge an
array or pre-deduped BTF, deduping it one more time?

Anyway, so you suggest I start by having each dwarf_loader thread tied
to a separate btf_encoder (a shim layer on top of a 'struct btf' and
then at the end dedup each one, then combine the N 'struct btf' into
one, then dump it into an ELF or raw file?

- Arnaldo
 
> > > So each thread does as much as possible locally without any
> > > locks. And only at the very end we merge everything together and then
> > > dedup. Or we can even dedup inside each worker before merging final
> > > btf, that probably would give quite a lot of speed up and some memory
> > > saving. Would be interesting to experiment with that.
> > >
> > > So I like the idea of a fixed pool of threads (can be customized, and
> > > I'd default to num_workers == num_cpus), but I think we can and should
> > > keep them independent for as long as possible.
> >
> > Sure, this should map the whatever the user passes to -j in the kernel
> > make command line, if nothing is passed as an argument, then default to
> > getconf(_NPROCESSORS_ONLN).
> >
> 
> Yep, cool. I've been told that `make -j` puts no upper limit on number
> of jobs, so we shouldn't follow make model completely :-P
> 
> > There is a nice coincidence here where we probably don't care about -J
> > anymore and want to deal only with -j (detached btf) that is the same as
> > what 'make' expects to state how many "jobs" (thread pool size) the user
> > wants 8-)
> >
> > > Another disadvantage of generating small struct btf and then lock +
> > > merge is that we don't get as efficient string re-use, we'll churn
> > > more on string memory allocation. Keeping bigger local struct btfs
> > > allow for more efficient memory re-use (and probably a tiny bit of CPU
> > > savings).
> >
> > I think we're in the same page, the contention for adding the CU to a
> > single 'struct btf' (amongst all DWARF loading threads) after we just
> > produced it should be minimal, so we grab all the advantages: locality
> > of reference, minimal contention as DWARF reading/creating the pahole
> > internal, neutral, data structures should be higher than adding
> > types/functions/variables via the libbpf BTF API.
> 
> I disagree, I think contention might be noticeable because merging
> BTFs is still a relatively expensive/slow operation. But feel free to
> start with that, I just thought that doing per-thread struct btf
> wouldn't add any complexity, which is why I mentioned that.
> 
> >
> > I.e. we can leave paralellizing the BTF _encoding_ for later, what we're
> > trying to do now is to paralellize the DWARF _loading_, right?
> 
> We are trying to speed up DWARF-to-BTF generation in general, not
> specifically DWARF loading. DWARF loading is an obvious most expensive
> part, string deduplication is the next one, if you look at profiling
> data. The third one will be btf__dedup, which is why I mentioned that
> it might be faster still to do pre-dedup in each thread at the very
> end, right before we do final dedup. Each individual dedup will
> probably significantly reduce total size of data/strings, so I have a
> feeling that it will result in a very nice speed-ups in the end.
> 
> So just my 2 cents.
> 
> >
> > > So please consider that, it also seems simpler overall.
> >
> > > > The ordering will be different than what we have now, as some smaller
> > > > CUs (object files with debug) will be processed faster so will get its
> > > > btf encoding slot faster, but that, at btf__dedup() time shouldn't make
> > > > a difference, right?
> >
> > > Right, order doesn't matter.
> >
> > > > I think I'm done with refactoring the btf_encoder code, which should be
> > > > by now a thin layer on top of the excellent libbpf BTF API, just getting
> > > > what the previous loader (DWARF) produced and feeding libbpf.
> >
> > > Great.
> >
> > > > I thought about fancy thread pools, etc, researching some pre-existing
> > > > thing or doing some kthread + workqueue lifting from the kernel but will
> > > > instead start with the most spartan code, we can improve later.
> >
> > > Agree, simple is good. Really curious how much faster we can get. I
> > > think anything fancy will give a relatively small improvement. The
> > > biggest one will come from any parallelization.
> >
> > And I think that is possible, modulo elfutils libraries saying no, I
> > hope that will not be the case.
> 
> You can't imagine how eagerly I'm awaiting this bright future of
> faster BTF generation step in the kernel build process. :)
> 
> >
> > - Arnaldo

-- 

- Arnaldo
