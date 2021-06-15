Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5D3A89F1
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFOUHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOUHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 16:07:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1B1C061574;
        Tue, 15 Jun 2021 13:05:42 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m9so22313193ybo.5;
        Tue, 15 Jun 2021 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5VCAx2ejRAPyd939YDrkTNPfYVoGPr0KKSHqvl1T2Q=;
        b=R+bYyRXxw9FK0m8+JK8As/RPSVy//Gu6HNaVpkGVnrFTkj4PXKmhfB3/KwfbIDX65H
         Cym9a8oNlEfZetkPHxWZT049sv+hWUcKxXV6DZPmQ5rouYkl4L9HU3HJ8rrvUol078vk
         DqyQF4QrXOXQztCC8+0UadtPD8aet/xh9d0CASts5IuJ93jjw5/HzIzm1xQizwARAyC6
         IhkXkOUAnkmbxUcI2HX5miuKC05kuVnQz0Eu66+w6iHg0scyX7+EFNVOwZ4xkUJtR6T9
         RE+ZOFRhOd1ORwjSrL/RDiy7TEKE2xN9j3Q1gulHSyExo+Ry8emhVr4JJAhBiECxay/T
         XMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5VCAx2ejRAPyd939YDrkTNPfYVoGPr0KKSHqvl1T2Q=;
        b=KvUoDyVgJ9TQmvuiwN7sUTcgWEC1Ki1G3OyKQ4gBJxBl41XHnmLSM3LMG7vQ70vUxz
         FcLA5Xihky1q0NFpXAH3tIiamFBdyHyMsygOnhFdgst0d53ZebNkQg8j/GdeOtTsIb8/
         7EUpYmWH4v8xD+HUwV2wrjo9edjTRrvjkOlchy5Mdr6g5skgGnWveyk7vxk9QXS1s/A/
         I62UL8Ckve3MyCq7YxVp9rMCiBFOOW9auuC5eWGOW30NNbUY/+mh/mh5JsXfSir5MI7e
         1+e/Z4JifEm/pSkrM5YMQb6mFfdX5woQynxKtcFSv0g6xyrmyWbBzJ3JisAM//TDndvm
         DcaQ==
X-Gm-Message-State: AOAM533xP/PH7z1G9R6kyxSE3M40EPVvt1ap0dCr/HtCaR8/53IX3jEc
        Xttgd6n86jtHksazSq5mlo7SzfofeuBzq2pg2Kc=
X-Google-Smtp-Source: ABdhPJzALElWNASnknAITECzJwW1pwNkzMGctnek8KmOMf3vb/rh2vAAwGmM6XmtZYO23NhSe+ZKQTpC3KkB88Pzo1M=
X-Received: by 2002:a25:df82:: with SMTP id w124mr1176142ybg.425.1623787541395;
 Tue, 15 Jun 2021 13:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org> <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org> <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
 <YL4dGFsfb0ZzgxlR@kernel.org> <CAEf4BzYLXyjkmO6ZySUxFHu1HcctPQK3j3vAPXVWFJ8qvGe8kw@mail.gmail.com>
 <YL9pxDFIYQEUODM5@kernel.org> <YMj5CzF92pTjcbhO@kernel.org>
 <CAEf4BzaDNim+kFQx64i9EZogctGZNFigQBsog7eC6DjrfjTbEA@mail.gmail.com> <YMkBpBfqW+AcpyNN@kernel.org>
In-Reply-To: <YMkBpBfqW+AcpyNN@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Jun 2021 13:05:30 -0700
Message-ID: <CAEf4Bza1XwHhjW6yzf9JTMQKkUFO3z23hb36B3HCHaJVR5gk4g@mail.gmail.com>
Subject: Re: Parallelizing vmlinux BTF encoding. was Re: [RFT] Testing 1.22
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 12:38 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Jun 15, 2021 at 12:13:55PM -0700, Andrii Nakryiko escreveu:
> > On Tue, Jun 15, 2021 at 12:01 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > > Em Tue, Jun 08, 2021 at 09:59:48AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Mon, Jun 07, 2021 at 05:53:59PM -0700, Andrii Nakryiko escreveu:
> > > > > I think it's very fragile and it will be easy to get
> > > > > broken/invalid/incomplete BTF. Yonghong already brought up the case
>
> > > > I thought about that as it would be almost like the compiler generating
> > > > BTF, but you are right, the vmlinux prep process is a complex beast and
> > > > probably it is best to go with the second approach I outlined and you
> > > > agreed to be less fragile, so I'll go with that, thanks for your
> > > > comments.
>
> > > So, just to write some notes here from what I saw so far:
>
> > > 1. In the LTO cases there are inter-CU references, so the current code
> > > combines all CUs into one and we end up not being able to parallelize
> > > much. LTO is expensive, so... I'll leave it for later, but yeah, I don't
> > > think the current algorithm is ideal, can be improved.
>
> > Yeah, let's worry about LTO later.
>
> > > 2. The case where there's no inter CU refs, which so far is the most
> > > common, seems easier, we create N threads, all sharing the dwarf_loader
> > > state and the btf_encoder, as-is now. we can process one CU per thread,
> > > and as soon as we finish it, just grab a lock and call
> > > btf_encoder__encode_cu() with the just produced CU data structures
> > > (tags, types, functions, variables, etc), consume them and delete the
> > > CU.
> > >
> > > So each thread will consume one CU, push it to the 'struct btf' class
> > > as-is now and then ask for the next CU, using the dwarf_loader state,
> > > still under that lock, then go back to processing dwarf tags, then
> > > lock, btf add types, rinse, repeat.
> >
> > Hmm... wouldn't keeping a "local" per-thread struct btf and just keep
> > appending to it for each processed CU until we run out of CUs be
> > simpler?
>
> I thought about this as a logical next step, I would love to have a
> 'btf__merge_argv(struct btf *btf[]), is there one?
>
> But from what I've read after this first paragraph of yours, lemme try
> to rephrase:
>
> 1. pahole calls btf_encoder__new(...)
>
>    Creates a single struct btf.
>
> 2. dwarf_loader will create N threads, each will call a
> dwarf_get_next_cu() that is locked and will return a CU to process, when
> it finishes this CU, calls btf_encoder__encode_cu() under an all-threads
> lock. Rinse repeat.
>
> Until all the threads have consumed all CUs.
>
> then btf_encoder__encode(), which should be probably renamed to
> btf_econder__finish() will call btf__dedup(encoder->btf) and write ELF
> or raw file.
>
> My first reaction to your first paragraph was:
>
> Yeah, we can have multiple 'struct btf' instances, one per thread, that
> will each contain a subset of DWARF CU's encoded as BTF, and then I have
> to merge the per-thread BTF and then dedup. O think my rephrase above is
> better, no?

I think I understood what you want to do from the previous email, so
you didn't have to re-phrase it, it's pretty clear already. I just
don't feel like having per-thread struct btf adds any complexity at
all and gives more flexibility and more parallelism. The next most
expensive thing after loading DWARF is string deduplication
(btf__add_str()), so it would be good to do that at per-thread level
as well as much as possible.

>
> > So each thread does as much as possible locally without any
> > locks. And only at the very end we merge everything together and then
> > dedup. Or we can even dedup inside each worker before merging final
> > btf, that probably would give quite a lot of speed up and some memory
> > saving. Would be interesting to experiment with that.
> >
> > So I like the idea of a fixed pool of threads (can be customized, and
> > I'd default to num_workers == num_cpus), but I think we can and should
> > keep them independent for as long as possible.
>
> Sure, this should map the whatever the user passes to -j in the kernel
> make command line, if nothing is passed as an argument, then default to
> getconf(_NPROCESSORS_ONLN).
>

Yep, cool. I've been told that `make -j` puts no upper limit on number
of jobs, so we shouldn't follow make model completely :-P

> There is a nice coincidence here where we probably don't care about -J
> anymore and want to deal only with -j (detached btf) that is the same as
> what 'make' expects to state how many "jobs" (thread pool size) the user
> wants 8-)
>
> > Another disadvantage of generating small struct btf and then lock +
> > merge is that we don't get as efficient string re-use, we'll churn
> > more on string memory allocation. Keeping bigger local struct btfs
> > allow for more efficient memory re-use (and probably a tiny bit of CPU
> > savings).
>
> I think we're in the same page, the contention for adding the CU to a
> single 'struct btf' (amongst all DWARF loading threads) after we just
> produced it should be minimal, so we grab all the advantages: locality
> of reference, minimal contention as DWARF reading/creating the pahole
> internal, neutral, data structures should be higher than adding
> types/functions/variables via the libbpf BTF API.

I disagree, I think contention might be noticeable because merging
BTFs is still a relatively expensive/slow operation. But feel free to
start with that, I just thought that doing per-thread struct btf
wouldn't add any complexity, which is why I mentioned that.

>
> I.e. we can leave paralellizing the BTF _encoding_ for later, what we're
> trying to do now is to paralellize the DWARF _loading_, right?

We are trying to speed up DWARF-to-BTF generation in general, not
specifically DWARF loading. DWARF loading is an obvious most expensive
part, string deduplication is the next one, if you look at profiling
data. The third one will be btf__dedup, which is why I mentioned that
it might be faster still to do pre-dedup in each thread at the very
end, right before we do final dedup. Each individual dedup will
probably significantly reduce total size of data/strings, so I have a
feeling that it will result in a very nice speed-ups in the end.

So just my 2 cents.

>
> > So please consider that, it also seems simpler overall.
>
> > > The ordering will be different than what we have now, as some smaller
> > > CUs (object files with debug) will be processed faster so will get its
> > > btf encoding slot faster, but that, at btf__dedup() time shouldn't make
> > > a difference, right?
>
> > Right, order doesn't matter.
>
> > > I think I'm done with refactoring the btf_encoder code, which should be
> > > by now a thin layer on top of the excellent libbpf BTF API, just getting
> > > what the previous loader (DWARF) produced and feeding libbpf.
>
> > Great.
>
> > > I thought about fancy thread pools, etc, researching some pre-existing
> > > thing or doing some kthread + workqueue lifting from the kernel but will
> > > instead start with the most spartan code, we can improve later.
>
> > Agree, simple is good. Really curious how much faster we can get. I
> > think anything fancy will give a relatively small improvement. The
> > biggest one will come from any parallelization.
>
> And I think that is possible, modulo elfutils libraries saying no, I
> hope that will not be the case.

You can't imagine how eagerly I'm awaiting this bright future of
faster BTF generation step in the kernel build process. :)

>
> - Arnaldo
