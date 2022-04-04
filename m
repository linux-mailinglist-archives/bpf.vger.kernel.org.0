Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9304F0DF9
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 06:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355561AbiDDEUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 00:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiDDEUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 00:20:12 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C167C24948
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 21:18:12 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r2so9821017iod.9
        for <bpf@vger.kernel.org>; Sun, 03 Apr 2022 21:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VklP/sywurcgQG6jMlsArV9OkE6Bg4p7d5DTbowlAYw=;
        b=NJaJAK8nyHi48EueUru/4vKrd57+8heKf5dB4GVruGELaitd/GLAp4h1oSuhBBfK1c
         RRYEjI9Qs5+16dWQBBFWXi2jiy2AsaiFoGQoLhGRATlgTutczvUOqgoRMEjscnJgWPii
         g5T2V/iiU7cXMzZ/1iVNO5GYy7B7AMhG2hchq6bKToqeXv71DVGLCfXPhuKPGSGQEQkq
         DYIQsoQ0n9/hnmZNFbtGfnJTuJr8DFlVG7WM3FWh61pWO45wzWmAvBfL+gGdVNh5jbQh
         FzDfNsYeleny2AqkATSmF4xfJYxusgf+yTZvjmd2QHcHE+7oDAZ39kJQllJ+sf+8FAw7
         Velw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VklP/sywurcgQG6jMlsArV9OkE6Bg4p7d5DTbowlAYw=;
        b=fcCwQimXVzDYqxeIILAy2SG90X+RKeCpPMLyfd4C0sZvdgaHAZObku2ixGPFI8X4Gt
         Brf2Ml0XhkwkQSc/CCxtWJqNI9837gd+UrQTebDLbNBMlxNplXdm5etbDbvh2rpiAVFN
         tpqC385jcvMS6riQqMSN26l5xpC2c+9RIjc8BhMNCrbq5Spg2yfQlZA/7iS3qg+5O7qI
         KbERouoNnt02wy/4rsHdb99ZNo1NITlYVDqfWh8hN9ssTmiCElfHgXQVlhnYA3bZfDUu
         uZJp4HbpsPU5xisz7XWVzwLw8h03B7QqDpMcI05ablV2ISOedfkacwHCI3h6yMfIfMUi
         WSvQ==
X-Gm-Message-State: AOAM533f7RdySTVLoKd662Ag/6VJqieG2jmjnVYWnq+nEsKAgvoCr0YI
        wxPgIcZOCupT1oyws+3yEHkb4ahZlfXH0EtZr1fN7srO8sA=
X-Google-Smtp-Source: ABdhPJxWjNevkXObkN/XY/dN8cKcBOvyt6zTBIk9j9SK6EVPXzrxvFvwwW20YT+MN9AByMsQYu6n77cb5yVm9P+sJn4=
X-Received: by 2002:a05:6602:735:b0:64c:adf1:ae09 with SMTP id
 g21-20020a056602073500b0064cadf1ae09mr4435770iox.79.1649045891933; Sun, 03
 Apr 2022 21:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220402002944.382019-1-andrii@kernel.org> <20220402002944.382019-3-andrii@kernel.org>
 <22359fb1-33a2-ee2c-4300-a07b175825e6@fb.com>
In-Reply-To: <22359fb1-33a2-ee2c-4300-a07b175825e6@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 3 Apr 2022 21:18:00 -0700
Message-ID: <CAEf4BzYdhnGE7HZLrjF0E2-XFwVrQf7G=uVaWJd7p2qaQMsvTg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/7] libbpf: wire up USDT API and bpf_link integration
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 3, 2022 at 8:12 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 4/1/22 8:29 PM, Andrii Nakryiko wrote:
> > Wire up libbpf USDT support APIs without yet implementing all the
> > nitty-gritty details of USDT discovery, spec parsing, and BPF map
> > initialization.
> >
> > User-visible user-space API is simple and is conceptually very similar
> > to uprobe API.
> >
> > bpf_program__attach_usdt() API allows to programmatically attach given
> > BPF program to a USDT, specified through binary path (executable or
> > shared lib), USDT provider and name. Also, just like in uprobe case, PID
> > filter is specified (0 - self, -1 - any process, or specific PID).
> > Optionally, USDT cookie value can be specified. Such single API
> > invocation will try to discover given USDT in specified binary and will
> > use (potentially many) BPF uprobes to attach this program in correct
> > locations.
> >
> > Just like any bpf_program__attach_xxx() APIs, bpf_link is returned that
> > represents this attachment. It is a virtual BPF link that doesn't have
> > direct kernel object, as it can consist of multiple underlying BPF
> > uprobe links. As such, attachment is not atomic operation and there can
> > be brief moment when some USDT call sites are attached while others are
> > still in the process of attaching. This should be taken into
> > consideration by user. But bpf_program__attach_usdt() guarantees that
> > in the case of success all USDT call sites are successfully attached, or
> > all the successfuly attachments will be detached as soon as some USDT
> > call sites failed to be attached. So, in theory, there could be cases of
> > failed bpf_program__attach_usdt() call which did trigger few USDT
> > program invocations. This is unavoidable due to multi-uprobe nature of
> > USDT and has to be handled by user, if it's important to create an
> > illusion of atomicity.
>
> It would be useful to be able to control the behavior in response to attach
> failure in bpf_program__attach_usdt. Specifically I'd like to be able to
> choose between existing "all attaches succeed or entire operation fails" and
> "_any_ attach succeeds or entire operation fails". Few reasons for this:
>
>  * Tools like BOLT were not playing nicely with USDTs for some time ([0],[1])
>  * BCC's logic was changed to support more granular 'attach failure' logic ([2])
>  * At FB I still see some multi-probe USDTs with incorrect-looking locations on
>    some of the probes
>
> Note that my change for 2nd bullet was to handle ".so in shortlived process"
> usecase, which this lib handles by properly supporting pid = -1. But it's since
> come in handy to avoid 3rd bullet's issue from causing trouble.
>
> Production tracing tools would be less brittle if they could control this attach
> failure logic.
>

So, we have bpf_usdt_opts for that and can add this in the future. The
reason I didn't do it from the outset is that no other attach API
currently has this partial success behavior. For example, multi-attach
kprobe that we recently added is also an all-or-nothing API. So I
wanted to start out with this stricter approach and only allow to
change that if/when we have a clear case where this is objectively not
enough. The BOLT case you mentioned normally should have been solved
by fixing BOLT tooling itself, not by sloppier attach behavior in
kernel or libbpf.

For the [2], if you re-read comments, I've suggested to allow adding
one USDT at a time instead of the "partial failure is ok" option,
which you ended up doing. So your initial frustration was from
suboptimal BCC API. After you added init_usdt() call that allowed to
generate code for each individual binary+USDT target, you had all the
control you needed, right? So here, bpf_program__attach_usdt() is a
logical equivalent of that init_usdt() call from BCC, so should be all
good. If bpf_program__attach_usdt() fails for some process/binary that
is now gone, you can just ignore and continue attaching for other
binaries, right?

>   [0]: https://github.com/facebookincubator/BOLT/commit/ea49a61463c65775aa796a9ef7a1199f20d2a698
>   [1]: https://github.com/facebookincubator/BOLT/commit/93860e02a19227be4963a68aa99ea0e09771052b
>   [2]: https://github.com/iovisor/bcc/pull/2476
>
> > USDT BPF programs themselves are marked in BPF source code as either
> > SEC("usdt"), in which case they won't be auto-attached through
> > skeleton's <skel>__attach() method, or it can have a full definition,
> > which follows the spirit of fully-specified uprobes:
> > SEC("usdt/<path>:<provider>:<name>"). In the latter case skeleton's
> > attach method will attempt auto-attachment. Similarly, generic
> > bpf_program__attach() will have enought information to go off of for
> > parameterless attachment.
> >
> > USDT BPF programs are actually uprobes, and as such for kernel they are
> > marked as BPF_PROG_TYPE_KPROBE.
> >
> > Another part of this patch is USDT-related feature probing:
> >   - BPF cookie support detection from user-space;
> >   - detection of kernel support for auto-refcounting of USDT semaphore.
> >
> > The latter is optional. If kernel doesn't support such feature and USDT
> > doesn't rely on USDT semaphores, no error is returned. But if libbpf
> > detects that USDT requires setting semaphores and kernel doesn't support
> > this, libbpf errors out with explicit pr_warn() message. Libbpf doesn't
> > support poking process's memory directly to increment semaphore value,
> > like BCC does on legacy kernels, due to inherent raciness and danger of
> > such process memory manipulation. Libbpf let's kernel take care of this
> > properly or gives up.
> >
> > Logistically, all the extra USDT-related infrastructure of libbpf is put
> > into a separate usdt.c file and abstracted behind struct usdt_manager.
> > Each bpf_object has lazily-initialized usdt_manager pointer, which is
> > only instantiated if USDT programs are attempted to be attached. Closing
> > BPF object frees up usdt_manager resources. usdt_manager keeps track of
> > USDT spec ID assignment and few other small things.
> >
> > Subsequent patches will fill out remaining missing pieces of USDT
> > initialization and setup logic.
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/Build             |   3 +-
> >  tools/lib/bpf/libbpf.c          | 100 +++++++-
> >  tools/lib/bpf/libbpf.h          |  31 +++
> >  tools/lib/bpf/libbpf.map        |   1 +
> >  tools/lib/bpf/libbpf_internal.h |  19 ++
> >  tools/lib/bpf/usdt.c            | 426 ++++++++++++++++++++++++++++++++
> >  6 files changed, 571 insertions(+), 9 deletions(-)
> >  create mode 100644 tools/lib/bpf/usdt.c
>
> [...]
>
> > +static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > +{
> > +     char *path = NULL, *provider = NULL, *name = NULL;
> > +     const char *sec_name;
> > +     int n, err;
> > +
> > +     sec_name = bpf_program__section_name(prog);
> > +     if (strcmp(sec_name, "usdt") == 0) {
> > +             /* no auto-attach for just SEC("usdt") */
> > +             *link = NULL;
> > +             return 0;
> > +     }
> > +
> > +     n = sscanf(sec_name, "usdt/%m[^:]:%m[^:]:%m[^:]", &path, &provider, &name);
>
> TIL %m

yep it's pretty nifty in some cases. In general, sscanf() is pretty
great for a lot of pretty complicated cases without the need to go for
a full-blown regex engine.

>
> > +     if (n != 3) {
> > +             pr_warn("invalid section '%s', expected SEC(\"usdt/<path>:<provider>:<name>\")\n",
> > +                     sec_name);
> > +             err = -EINVAL;
> > +     } else {
> > +             *link = bpf_program__attach_usdt(prog, -1 /* any process */, path,
> > +                                              provider, name, NULL);
> > +             err = libbpf_get_error(*link);
> > +     }
> > +     free(path);
> > +     free(provider);
> > +     free(name);
> > +     return err;
> > +}
>
> [...]
>
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > new file mode 100644
> > index 000000000000..9476f7a15769
> > --- /dev/null
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -0,0 +1,426 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > +#include <ctype.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <libelf.h>
> > +#include <gelf.h>
> > +#include <unistd.h>
> > +#include <linux/ptrace.h>
> > +#include <linux/kernel.h>
> > +
> > +#include "bpf.h"
> > +#include "libbpf.h"
> > +#include "libbpf_common.h"
> > +#include "libbpf_internal.h"
> > +#include "hashmap.h"
> > +
> > +/* libbpf's USDT support consists of BPF-side state/code and user-space
> > + * state/code working together in concert. BPF-side parts are defined in
> > + * usdt.bpf.h header library. User-space state is encapsulated by struct
> > + * usdt_manager and all the supporting code centered around usdt_manager.
> > + *
> > + * usdt.bpf.h defines two BPF maps that usdt_manager expects: USDT spec map
> > + * and IP-to-spec-ID map, which is auxiliary map necessary for kernels that
> > + * don't support BPF cookie (see below). These two maps are implicitly
> > + * embedded into user's end BPF object file when user's code included
> > + * usdt.bpf.h. This means that libbpf doesn't do anything special to create
> > + * these USDT support maps. They are created by normal libbpf logic of
> > + * instantiating BPF maps when opening and loading BPF object.
> > + *
> > + * As such, libbpf is basically unaware of the need to do anything
> > + * USDT-related until the very first call to bpf_program__attach_usdt(), which
> > + * can be called by user explicitly or happen automatically during skeleton
> > + * attach (or, equivalently, through generic bpf_program__attach() call). At
> > + * this point, libbpf will instantiate and initialize struct usdt_manager and
> > + * store it in bpf_object. USDT manager is per-BPF object construct, as each
> > + * independent BPF object might or might not have USDT programs, and thus all
> > + * the expected USDT-related state. There is no coordination between two
> > + * bpf_object in parts of USDT attachment, they are oblivious of each other's
> > + * existence and libbpf is just oblivious, dealing with bpf_object-specific
> > + * USDT state.
> > + *
> > + * Quick crash course on USDTs.
> > + *
> > + * From user-space application's point of view, USDT is essentially just
> > + * a slightly special function call that normally has zero overhead, unless it
>
> Maybe better to claim 'low overhead' instead of 'zero' here and elsewhere?
> Or elaborate about the overhead more explicitly. Agreed that it's so low as to
> effectively be zero in most cases, but someone somewhere is going to put the nop
> in a 4096-bytes-of-instr tight loop, see changed iTLB behavior, and get
> frustrated.

Hm.... but it is literally zero overhead because that nop is pretty
much free. If you put USDT into a loop, you'll be seeing an overhead
of a loop itself, not of that nop. What's more, if you have input
arguments that are already prepared/calculated, there is no movement
of them, no stack frame creation and jump (as opposed to function
calls), USDT macro just record their location without changing the
properties of the code. So I stand by zero-overhead.

>
> A contrived scenario to be sure, but no other USDT documentation I can find
> claims zero overhead, rather 'low', guessing for a good reason.

The only real overhead of USDT will be if someone calculates some
expression just to pass its result into USDT. That's when USDT
semaphores come in, but that's a bit different from USDT invocation
overhead itself.

Think about ftrace preamble in almost every kernel function (we use
that for fentry/fexit and kprobe utilizes it for faster jump, if
kernel supports it). It's 5-byte nop, but I don't think anyone claims
that there is "low overhead" of ftrace when nothing is attached to the
kernel function. It is considered to be *zero overhead*, unless
someone attaches and replaces those 5 bytes with a call, jump, or
interrupt. USDT is similarly "zero overhead".

I think it's important to emphasize that this is objectively zero
overhead and encourage applications to utilize this technology,
instead of inadvertently scaring them away with vague "low overhead".

>
>
> > + * is being traced by some external entity (e.g, BPF-based tool). Here's how
> > + * a typical application can trigger USDT probe:
> > + *
> > + * #include <sys/sdt.h>  // provided by systemtap-sdt-devel package
> > + * // folly also provide similar functionality in folly/tracing/StaticTracepoint.h
> > + *
> > + * STAP_PROBE3(my_usdt_provider, my_usdt_probe_name, 123, x, &y);
> > + *
> > + * USDT is identified by it's <provider-name>:<probe-name> pair of names. Each
> > + * individual USDT has a fixed number of arguments (3 in the above example)
> > + * and specifies values of each argument as if it was a function call.
> > + *
> > + * USDT call is actually not a function call, but is instead replaced by
> > + * a single NOP instruction (thus zero overhead, effectively). But in addition
>
> This zero overhead claim bothers me less since NOP is directly mentioned.

Well, I already wrote up my tirade above and I'm living it anyways ;)

>
> > + * to that, those USDT macros generate special SHT_NOTE ELF records in
> > + * .note.stapsdt ELF section. Here's an example USDT definition as emitted by
> > + * `readelf -n <binary>`:
>
> [...]
>
> > + * Arguments is the most interesting part. This USDT specification string is
> > + * providing information about all the USDT arguments and their locations. The
> > + * part before @ sign defined byte size of the argument (1, 2, 4, or 8) and
> > + * whether the argument is singed or unsigned (negative size means signed).
> > + * The part after @ sign is assembly-like definition of argument location.
> > + * Technically, assembler can provide some pretty advanced definitions, but
>
> Perhaps it would be more precise to state that argument specifiers can be 'any
> operand accepted by Gnu Asm Syntax' (per [0]).
>
> [0]: https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation

Yep, will update and live the reference to that page.

>
> > + * libbpf is currently supporting three most common cases:
> > + *   1) immediate constant, see 5th and 9th args above (-4@$5 and -4@-9);
> > + *   2) register value, e.g., 8@%rdx, which means "unsigned 8-byte integer
> > + *      whose value is in register %rdx";
> > + *   3) memory dereference addressed by register, e.g., -4@-1204(%rbp), which
> > + *      specifies signed 32-bit integer stored at offset -1204 bytes from
> > + *      memory address stored in %rbp.
>
> [...]
