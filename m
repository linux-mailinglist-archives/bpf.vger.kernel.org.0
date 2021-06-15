Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5585C3A890E
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFOTDk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 15:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhFOTDj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 15:03:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B5C2610C8;
        Tue, 15 Jun 2021 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623783694;
        bh=1mPxf9elKVhtryFbnAOffsjMg3tuReN/dnXxsnzb7DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJhrZSyIqybbjoVBu695QPnebyyHIfnqiRROhEvusZ/3zC6tTwPeMHMYH0gTMfFfP
         526S+dvdJc/vT3fk99Wl71KD5W2Qd2DC43i4GWr9c8Aj/rd1isKrROqzLRAwCFCTf+
         RF3rHsc4pF9C/rwCyC8w5zc8oHy0zi9bWhh2nFArB48rerYP9J/t2nh6d+ldbfA6dL
         NfkDuBtt3ZLlO81/RdqKRd/QsW8bJ8j9d9rfJyzpQKeWlui3uJHBuUQfQGdPHb01eL
         Dmp0eQ5sPLAk6rdOJ95lwh6Fh6eoPm2TGYzchWy6XuB14h3yko+I47IiaU8l1P3Ocu
         QIqbWSn+Bd9Xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 45A6840B1A; Tue, 15 Jun 2021 16:01:31 -0300 (-03)
Date:   Tue, 15 Jun 2021 16:01:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parallelizing vmlinux BTF encoding. was Re: [RFT] Testing 1.22
Message-ID: <YMj5CzF92pTjcbhO@kernel.org>
References: <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
 <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org>
 <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org>
 <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
 <YL4dGFsfb0ZzgxlR@kernel.org>
 <CAEf4BzYLXyjkmO6ZySUxFHu1HcctPQK3j3vAPXVWFJ8qvGe8kw@mail.gmail.com>
 <YL9pxDFIYQEUODM5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9pxDFIYQEUODM5@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jun 08, 2021 at 09:59:48AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jun 07, 2021 at 05:53:59PM -0700, Andrii Nakryiko escreveu:
> > I think it's very fragile and it will be easy to get
> > broken/invalid/incomplete BTF. Yonghong already brought up the case
 
> I thought about that as it would be almost like the compiler generating
> BTF, but you are right, the vmlinux prep process is a complex beast and
> probably it is best to go with the second approach I outlined and you
> agreed to be less fragile, so I'll go with that, thanks for your
> comments.

So, just to write some notes here from what I saw so far:

1. In the LTO cases there are inter-CU references, so the current code
combines all CUs into one and we end up not being able to parallelize
much. LTO is expensive, so... I'll leave it for later, but yeah, I don't
think the current algorithm is ideal, can be improved.

2. The case where there's no inter CU refs, which so far is the most
common, seems easier, we create N threads, all sharing the dwarf_loader
state and the btf_encoder, as-is now. we can process one CU per thread,
and as soon as we finish it, just grab a lock and call
btf_encoder__encode_cu() with the just produced CU data structures
(tags, types, functions, variables, etc), consume them and delete the
CU.

So each thread will consume one CU, push it to the 'struct btf' class
as-is now and then ask for the next CU, using the dwarf_loader state,
still under that lock, then go back to processing dwarf tags, then
lock, btf add types, rinse, repeat.

The ordering will be different than what we have now, as some smaller
CUs (object files with debug) will be processed faster so will get its
btf encoding slot faster, but that, at btf__dedup() time shouldn't make
a difference, right?

I think I'm done with refactoring the btf_encoder code, which should be
by now a thin layer on top of the excellent libbpf BTF API, just getting
what the previous loader (DWARF) produced and feeding libbpf.

I thought about fancy thread pools, etc, researching some pre-existing
thing or doing some kthread + workqueue lifting from the kernel but will
instead start with the most spartan code, we can improve later.

There it is, dumped my thoughts on this, time to go do some coding
before I get preempted...

- Arnaldo
 
> - Arnaldo
> 
> > for static variables. There might be some other issues that exist
> > today, or we might run into when we further extend BTF. Like some
> > custom linker script that will do something to vmlinux.o that we won't
> > know about.
> > 
> > And also this will be purely vmlinux-specific approach relying on
> > extra and custom Kbuild integration.
> > 
> > While if you parallelize DWARF loading and BTF generation, that will
> > be more reliably correct (modulo any bugs of course) and will work for
> > any DWARF-to-BTF cases that might come up in the future.
> > 
> > So I wouldn't even bother with individual .o's, tbh.
> > 
> > >
> > > If this isn't the case, we can process vmlinux as is today and go on
> > > creating N threads and feeding each with a DW_TAG_compile_unit
> > > "container", i.e. each thread would consume all the tags below each
> > > DW_TAG_compile_unit and produce a foo.BTF file that in the end would be
> > > combined and deduped by libbpf.
> > >
> > > Doing it as my first sketch above would take advantage of locality of
> > > reference, i.e. the DWARF data would be freshly produced and in the
> > > cache hierarchy when we first encode BTF, later, when doing the
> > > combine+dedup we wouldn't be touching the more voluminous DWARF data.
> > 
> > Yep, that's what I'd do.
> > 
> > >
> > > - Arnaldo
> > >
> > > > confident about BTF encoding part: dump each CU into its own BTF, use
> > > > btf__add_type() to merge multiple BTFs together. Just need to re-map
> > > > IDs (libbpf internally has API to visit each field that contains
> > > > type_id, it's well-defined enough to expose that as a public API, if
> > > > necessary). Then final btf_dedup().
> > >
> > > > But the DWARF loading and parsing part is almost a black box to me, so
> > > > I'm not sure how much work it would involve.
> > >
> > > > > I'm doing 'pahole -J vmlinux && btfdiff' after each cset and doing it
> > > > > very piecemeal as I'm doing will help bisecting any subtle bug this may
> > > > > introduce.
> > >
> > > > > > allow to parallelize BTF generation, where each CU would proceed in
> > > > > > parallel generating local BTF, and then the final pass would merge and
> > > > > > dedup BTFs. Currently reading and processing DWARF is the slowest part
> > > > > > of the DWARF-to-BTF conversion, parallelization and maybe some other
> > > > > > optimization seems like the only way to speed the process up.
> > >
> > > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > > > Thanks!
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
