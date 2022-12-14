Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16664C18B
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 01:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiLNA53 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 19:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiLNA52 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 19:57:28 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD77248D2
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:57:26 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id fc4so40930473ejc.12
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxmmiJhaPv0LUvpIVqR7CtlcQHZsZRUCA61/d3CMmyU=;
        b=JPONAZKUf4K6bZDxFyofJoVxmNmQPnxpbyokoaxmzaSTdmuFC5/ngzFKYAxNGKrpwZ
         i1Fpd3hwt5R6ICEGTYiFiB2Nb3RCiSZzQs+d9SQnfqKjnnYCZ64ErroaGwE+8fucKbvX
         zogduQTHFL2WE0VR7XwdD2QyOT5aJzJbcKCk43zeKRdHeRIbV7TKE9R6/u1LTsQcsZxY
         ivQQ7L8EYuvtiSfnAwKbEiF1Nf9BmRP2E1ReKnQsLM3xUzy1ox0RxpdRBiSHlTJNPnDp
         MEaonwp8DC8JE01rMibha4VeA+U3cRsHElE+L5zCnYlwKqLuYOmTGGX/VJMsRgrHfn6Y
         B6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxmmiJhaPv0LUvpIVqR7CtlcQHZsZRUCA61/d3CMmyU=;
        b=Ka1L6jwgDT1m7SuDPOARatC6gzKmRYfCFgpyFvRk5k+snOB9BfZFDdtCJNC4d/jgCN
         E/HyVBrASEVOnvEP7DOS/4nG70ycTIlh6qJnsIotroPIq/sFU2oQ6dJ9dahOd7rQqO+5
         sFsbjXgCtN6EsdNua1ukvnU/rd5lsn3JqJjTxNsrb7opkM5xZTsEdl8l9hi/yoyaJ9PE
         zAUbz0OlIl4PVMONmvLkzXSDebJYknfRY1FRwkzT3n/OSpDPdWyzE3vdZx8nkdMkGJFW
         4fvv61qIi7oVb5glEUaMcR1s0vIxXuwR4FNLjOlI7YS0IKQE1xInLeKcTp3tg03A3l9Q
         vAOw==
X-Gm-Message-State: ANoB5pn+4GufdiYInXQ1eUzQFqBgsLsCqnTZJtdDGWYKtGCR1bQe1TXt
        ehFNSQnQiPlsTbG0hptUjyS4WKpMJY6hu1s1x1Fo6xpl2Kg=
X-Google-Smtp-Source: AA0mqf5FlM0gJYn5qSz4r8dvy5bizmPpw91vSVdb+cWnrTg7vyD2cnQ6O5RQLGk28aea+GzKD5knelI5HMj4Kw/DPUc=
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id
 b1-20020a17090630c100b007b7eaa9c1cbmr11166435ejb.745.1670979445397; Tue, 13
 Dec 2022 16:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com> <CAJnrk1aAULjB_nXmMXd-t16oR6dN4bfLna_PCfafeBgCEoKhdQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aAULjB_nXmMXd-t16oR6dN4bfLna_PCfafeBgCEoKhdQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Dec 2022 16:57:13 -0800
Message-ID: <CAEf4BzbRQLEjAFUkzzStv0c0=O+r9iZ8hq33sJB2RtSuGrGAEA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] Dynptr convenience helpers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 3:50 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, Dec 12, 2022 at 12:12 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 8, 2022 at 5:30 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Dec 8, 2022 at 4:42 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 7, 2022 at 5:54 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Dec 07, 2022 at 12:55:31PM -0800, Joanne Koong wrote:
> > > > > > This patchset is the 3rd in the dynptr series. The 1st can be found here [0]
> > > > > > and the 2nd can be found here [1].
> > > > > >
> > > > > > In this patchset, the following convenience helpers are added for interacting
> > > > > > with bpf dynamic pointers:
> > > > > >
> > > > > >     * bpf_dynptr_data_rdonly
> > > > > >     * bpf_dynptr_trim
> > > > > >     * bpf_dynptr_advance
> > > > > >     * bpf_dynptr_is_null
> > > > > >     * bpf_dynptr_is_rdonly
> > > > > >     * bpf_dynptr_get_size
> > > > > >     * bpf_dynptr_get_offset
> > > > > >     * bpf_dynptr_clone
> > > > > >     * bpf_dynptr_iterator
> > > > >
> > > > > This is great, but it really stretches uapi limits.
> > > >
> > > > Stretches in what sense? They are simple and straightforward getters
> > > > and trim/advance/clone are fundamental modifiers to be able to work
> > > > with a subset of dynptr's overall memory area.
> > > >
> > > > > Please convert the above and those in [1] to kfuncs.
> > > > > I know that there can be an argument made for consistency with existing dynptr uapi
> > > >
> > > > yeah, given we have bpf_dynptr_{read,write} and bpf_dynptr_data() as
> > > > BPF helpers, it makes sense to have such basic things like is_null and
> > > > trim/advance/clone as BPF helpers as well. Both for consistency and
> > > > because there is nothing unstable about them. We are not going to
> > > > remove dynptr as a concept, it's pretty well defined.
> > > >
> > > > Out of the above list perhaps only move bpf_dynptr_iterator() might be
> > > > a candidate for kfunc. Though, personally, it makes sense to me to
> > > > keep it as BPF helper without GPL restriction as well, given it is
> > > > meant for networking applications in the first place, and you don't
> > > > need to be GPL-compatible to write useful networking BPF program, from
> > > > what I understand. But all the other ones is something you'd need to
> > > > make actual use of dynptr concept in real-world BPF programs.
> > > >
> > > > Can we please have those as BPF helpers, and we can decide to move
> > > > slightly fancier bpf_dynptr_iterator() (and future dynptr-related
> > > > extras) into kfunc?
> > >
> > > Sorry, uapi concerns are more important here.
> >
> > What about the overall user experience and adoption?
> >
> > There is no clean way to ever move from unstable kfunc to a stable helper.
> >
> > BPF helpers also have the advantage of working on all architectures,
> > whether that architecture supports kfuncs or not, whether it supports
> > JIT or not.
>
> Oh interesting, I didn't realize some architectures do not support kfuncs.
>
> Out of curiosity, can you elaborate on "no clean way to move from
> unstable kfunc to a stable helper"? If for example we needed to move
> something from kfunc -> helper, could we not just remove the code
> where we added it as a kfunc (eg defining a BTF_ID for it) and add it
> as a helper instead?

We could in the kernel. And make user life horrible.

If, say, bpf_dynptr_is_null() is defined as kfunc, it will be exposed
(actually would have to be found in the kernel and definition would be
copy/pasted by user manually) to user's BPF application as:

extern bool bpf_dynptr_is_null(const struct bpf_dynptr *p) __ksym;

When we "stabilize it" and make it helper, it turns into the following
definition supplied by libbpf in its bpf_helper_defs.h header
(auto-generated from include/uapi/linux/bpf.h):

static bool (*bpf_dynptr_is_null)(const struct bpf_dynptr *p) = (void *) 777;

From C source code perspective both will be called exactly the same,
but BPF assembly generated for them will be different. For kfunc it
will be a specially patched by libbpf `call -1;` instruction with
embedded BTF object ID and BTF type ID corresponding to this kfunc.
For BPF helper it will be simply `call 777;`. Both are processed by
verifier very differently.

From BPF program's standpoint it's impossible to support both ways of
calling the same bpf_dynptr_is_null(), because we get naming conflict,
and there is no single BPF assembly instruction that would support
both ways.

You'd have to get really creative to transparently call this helper
without caring whether it is kfunc or BPF helper. Or you'd have to
compile and distribute two variants of the same BPF object file. Both
suck. BPF CO-RE is nice and all, but we do it due to necessity, not
because it's fun and easy. So if we migrate kfunc to become BPF
helper, we'd most probably would need to make a new name for a helper
that's different from kfunc.

And it's currently not that easy to detect whether kfunc is available
or not (see [0]).

  [0] https://lore.kernel.org/bpf/de495e3a-cf06-ff85-1a4a-185621c9211a@linux.dev/



>
> >
> > BPF helpers are also nicely self-discoverable and documented in
> > include/uapi/linux/bpf.h, in one place where other BPF helpers are.
> > This is a big deal, especially for non-expert BPF users (a vast
> > majority of BPF users).
> >
> > > non-gpl and consistency don't even come close.
> > > We've been doing everything new as kfuncs and dynptr is not special.
> >
> > I think dynptr is quite special. It's a very generic and fundamental
> > concept, part of core BPF experience. It's a more dynamic counterpart
> > to an inflexible statically sized `void * + size` pair of arguments
> > sent to helpers for input or output memory regions. Dynptr has no
> > inherent dependencies on BTF, kfuncs, trampolines, JIT, nothing.
> >
> > By requiring kfunc-based helpers we are significantly raising the
> > obstacles towards adopting dynptr across a wide range of BPF
> > applications.
> >
> > And the only advantage in return is that we get a hypothetical chance
> > to change something in the future. But let's see if that will ever be
> > necessary for the helpers Joanne is adding:
> >
> > 1. Generic accessors to check validity of *any* dynptr, and it's
> > inherent properties like offset, available size, read-only property
> > (just as useful somethings as bpf_ringbuf_query() is for ringbufs,
> > both for debugging and for various heuristics in production).
> >
> > bpf_dynptr_is_null(struct bpf_dynptr *ptr)
> > long bpf_dynptr_get_size(struct bpf_dynptr *ptr)
> > long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
> > bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
> >
> > There is nothing to add or remove here. No flags, no change in semantics.
> >
> > 2. Manipulators to copy existing dynptr's view and narrow it down to a
> > subset (e.g., for when you have a large memory blog, but need to
> > calculate hashes over smaller subset, without destroying original
> > dynptr, because it will be used later for some other access). We can
> > debate whether clone should get offset or not, but it doesn't change
> > much (except usability in common cases). Again, nothing to add or
> > remove otherwise, and pretty fundamental for real use of full power of
> > dynptr.
> >
> > long bpf_dynptr_clone(struct bpf_dynptr *ptr, struct bpf_dynptr
> > *clone, u32 offset)
> > long bpf_dynptr_trim(struct bpf_dynptr *ptr, u32 len)
> > long bpf_dynptr_advance(struct bpf_dynptr *ptr, u32 len)
> >
> > 3. This one is the only one I feel less strongly about, but mostly
> > because I can implement the same (even though less ergonomically, of
> > course) with bpf_loop() and bpf_dynptr_{clone,advance}.
> >
> > long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
> > void *callback_ctx, u64 flags)
> >
> >
> > All of the above don't add or change any semantics to dynptr as a
> > concept. There is nothing that we'd need to change.
> >
> >
> > >
> > > > > helpers, but we got burned on them once and scrambled to add 'flags' argument.
> > > > > kfuncs are unstable and can be adjusted/removed at any time later.
> >
> > It's unfair to block these helpers just because we recided to add
> > flags to one of the previous ones (before the final release). And even
> > if we didn't managed to do it in time, the worst things would probably
> > be another variant of BPF helper. Definitely something to avoid, but
> > not end of the world. But as I pointed out above, this set of helpers
> > won't be change, as they just complete already established dynptr
> > ecosystem of helpers.
> >
> > > >
> > > > I don't see why we would remove any of the above list ever? They are
> > > > generic and fundamental to dynptr as a concept, they can't restrict
> > > > what dynptr can do in the future.
> > >
> > > It's not about removing them, but about changing them.
> > >
> > > Just for example the whole discussion of whether frags should
> > > be handled transparently and how write is handled didn't inspire
> > > confidence that there is a strong consensus on semantics
> > > of these new dynptr accessors.
> >
> > So let's start with acknowledging that skb and xdp buffer abstractions
> > as logically contiguous memory area are inherently complex and
> > non-perfect due to the way that kernel handles them for performance
> > and flexibility reasons.
> >
> > Let's also note that verifier knows specific flavor of dynptr and thus
> > can enforce additional restrictions based on specifically SKB/XDP
> > flavor vs LOCAL/RINGBUF. So just because there is no perfect way to
> > handle all the SKB/XDP physical non-contiguity, doesn't mean that the
> > dynptr concept itself is flawed or not well thought out. It's just
> > that for SKB/XDP there is no perfect solution. Dynptr doesn't change
> > anything here, rather it actually simplifies a bunch of stuff,
> > especially for common scenarios.
> >
> > I'd argue that for wider SKB/XDP dynptr adoption in the networking
> > world, those dynptr constructor helpers should be helpers and not
> > kfuncs as well. But I'd wish someone with more networking tie-ins
> > would argue this instead of me.
>
> I'm not that familiar with the semantics of bpf kfuncs, so to clarify:
> from a user API perspective, is there any difference in calling the
> function from the bpf program as a helper vs. kfunc?

I think I addressed that above, but let me know if not.

>
> >
> > >
> > > Scrambling to add flags to dynptr helpers was another red flag.
> > >
> > > All signs are pointing out that we're not ready do fix dynptr api.
> >
> > I disagree, it's an overly harsh generalization.
> >
> > > It will evolve and has to evolve without uapi pain.
> > >
> > > kfuncs only. For everything. Please.
> >
> > This is yet another generalized blanket statement I disagree with.
> > Over the years I've got an impression that the BPF subsystem is
> > generally a  proud proponent of pragmatic, flexible, and common sense
> > engineering approaches, so this hard-and-fast rule with no room for
> > nuance sounds weird.
> >
> > There are things that belong in fundamental and core BPF concepts, and
> > it makes sense to keep them as stable abstractions and helpers. And
> > there are various things (like interfacing into kernel mechanics, its
> > types and systems) which totally make sense to keep unstable.
>
> I agree with all of your points. I know Alexei is on PTO these next
> two weeks, so I will in the meantime table this and work on the dynptr
> memory allocation patchset and a dynptr documentation write-up.
>
> Thanks for the discussion!

SGTM.
