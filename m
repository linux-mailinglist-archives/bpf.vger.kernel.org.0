Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9444F0DD4
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 05:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353724AbiDDD51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 23:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiDDD50 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 23:57:26 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6A36174
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 20:55:30 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id x9so6003405ilc.3
        for <bpf@vger.kernel.org>; Sun, 03 Apr 2022 20:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuhnBhTZ4UsQrf7q8IR4oiDl1roBnrXu0OyBqipNpW0=;
        b=m8Z35JrTIP07X7858VpZNkh49TaC7PXJqmoDDohgs9RSJxFJPumBpt0h2UAgCUm8dI
         2yBYUGX2tLWRVb2zu9v+WA5872TimLuczY8nmgCDNkrimWP0HALUzGha+sZEIL6lOmmc
         wrFGNwZYrHupgFmvlWT/619ORiOQygfhhsfrROZQG2Zt+984VabE5K5eOs18wsk20L4U
         /50oqcaNOmAJwVAtIhJPOiOwC29eB0qnwHUHCQ8/JJb1BoAJaNNTXUFjT6EkMwPT3PnX
         WbkykQQs66icZLt53MnTg4miSgg7oFBxOuMvnmLXjlU5lTD7h0318VmIrOs+96AMxBC8
         6qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuhnBhTZ4UsQrf7q8IR4oiDl1roBnrXu0OyBqipNpW0=;
        b=ik2EBJefQHs/u6Pat4DgAApLztC9FHEe6W2zZtANEFO3ER9+jOaMq6oh0H4PAvzDtm
         yCZ3W0JHMUc8gZy0Qpy6sbmajdDl+ZJuhF5uMRo6hc75Q9J/PbZstR8wLBqi5n/unCPa
         NA7Cm/hbNgWqNmoKEhN6Ijy7SrBxl7Eg7V+i9iyMSFk2ojfpbELXad2JT1EFLo2trrZ+
         S0VdlFF8mKqMO8XO5GqLaJxDGJPJfGXACdyZPKVk93AY9mUiMddjdnM6ngFI8L4LvdtI
         8GDKUSlS4pHN9FYn3F+e/K4kNuOlSHIqxMEKfGXBOPCW/MDIXcaYcazQG6jI/TtUgfFK
         93Lg==
X-Gm-Message-State: AOAM530Oxd9ODwwVtroeTnw4V3jVBgSXx8iEbCR6l54vHj1FQ+tpALOQ
        sZ1ARv9V7iPjkzMGMNWJ0VB8zZV1XJj75oWk/hs=
X-Google-Smtp-Source: ABdhPJxtncFobDfhTVJSwEqfw6YG/oQcIOD72AqpC2cVZ9Dotwhlkgq8xgNqhdfnc5uqFrvxRTWmbPl9dCoDWrNuTC4=
X-Received: by 2002:a92:cd89:0:b0:2c9:bdf3:c5dd with SMTP id
 r9-20020a92cd89000000b002c9bdf3c5ddmr4322488ilb.252.1649044529829; Sun, 03
 Apr 2022 20:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220402002944.382019-1-andrii@kernel.org> <20220402002944.382019-2-andrii@kernel.org>
 <375b41da-6f7c-1520-9cad-13e12301575f@fb.com>
In-Reply-To: <375b41da-6f7c-1520-9cad-13e12301575f@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 3 Apr 2022 20:55:19 -0700
Message-ID: <CAEf4BzYBbBxZfUAN+sRxv6jKvneEL8b_Ugs4-t-e87xPFXOKCA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/7] libbpf: add BPF-side of USDT support
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

On Sun, Apr 3, 2022 at 5:23 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 4/1/22 8:29 PM, Andrii Nakryiko wrote:
> > Add BPF-side implementation of libbpf-provided USDT support. This
> > consists of single header library, usdt.bpf.h, which is meant to be used
> > from user's BPF-side source code. This header is added to the list of
> > installed libbpf header, along bpf_helpers.h and others.
> >
> > BPF-side implementation consists of two BPF maps:
> >   - spec map, which contains "a USDT spec" which encodes information
> >     necessary to be able to fetch USDT arguments and other information
> >     (argument count, user-provided cookie value, etc) at runtime;
> >   - IP-to-spec-ID map, which is only used on kernels that don't support
> >     BPF cookie feature. It allows to lookup spec ID based on the place
> >     in user application that triggers USDT program.
> >
> > These maps have default sizes, 256 and 1024, which are chosen
> > conservatively to not waste a lot of space, but handling a lot of common
> > cases. But there could be cases when user application needs to either
> > trace a lot of different USDTs, or USDTs are heavily inlined and their
> > arguments are located in a lot of differing locations. For such cases it
> > might be necessary to size those maps up, which libbpf allows to do by
> > overriding BPF_USDT_MAX_SPEC_CNT and BPF_USDT_MAX_IP_CNT macros.
> >
> > It is an important aspect to keep in mind. Single USDT (user-space
> > equivalent of kernel tracepoint) can have multiple USDT "call sites".
> > That is, single logical USDT is triggered from multiple places in user
> > application. This can happen due to function inlining. Each such inlined
> > instance of USDT invocation can have its own unique USDT argument
> > specification (instructions about the location of the value of each of
> > USDT arguments). So while USDT looks very similar to usual uprobe or
> > kernel tracepoint, under the hood it's actually a collection of uprobes,
> > each potentially needing different spec to know how to fetch arguments.
> >
> > User-visible API consists of three helper functions:
> >   - bpf_usdt_arg_cnt(), which returns number of arguments of current USDT;
> >   - bpf_usdt_arg(), which reads value of specified USDT argument (by
> >     it's zero-indexed position) and returns it as 64-bit value;
> >   - bpf_usdt_cookie(), which functions like BPF cookie for USDT
> >     programs; this is necessary as libbpf doesn't allow specifying actual
> >     BPF cookie and utilizes it internally for USDT support implementation.
> >
> > Each bpf_usdt_xxx() APIs expect struct pt_regs * context, passed into
> > BPF program. On kernels that don't support BPF cookie it is used to
> > fetch absolute IP address of the underlying uprobe.
> >
> > usdt.bpf.h also provides BPF_USDT() macro, which functions like
> > BPF_PROG() and BPF_KPROBE() and allows much more user-friendly way to
> > get access to USDT arguments, if USDT definition is static and known to
> > the user. It is expected that majority of use cases won't have to use
> > bpf_usdt_arg_cnt() and bpf_usdt_arg() directly and BPF_USDT() will cover
> > all their needs.
> >
> > Last, usdt.bpf.h is utilizing BPF CO-RE for one single purpose: to
> > detect kernel support for BPF cookie. If BPF CO-RE dependency is
> > undesirable, user application can redefine BPF_USDT_HAS_BPF_COOKIE to
> > either a boolean constant (or equivalently zero and non-zero), or even
> > point it to its own .rodata variable that can be specified from user's
> > application user-space code. It is important that
> > BPF_USDT_HAS_BPF_COOKIE is known to BPF verifier as static value (thus
> > .rodata and not just .data), as otherwise BPF code will still contain
> > bpf_get_attach_cookie() BPF helper call and will fail validation at
> > runtime, if not dead-code eliminated.
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/Makefile   |   2 +-
> >  tools/lib/bpf/usdt.bpf.h | 256 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 257 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/bpf/usdt.bpf.h
>
> [...]
>
> > diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> > new file mode 100644
> > index 000000000000..0941c915d58d
> > --- /dev/null
> > +++ b/tools/lib/bpf/usdt.bpf.h
> > @@ -0,0 +1,256 @@
> > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > +#ifndef __USDT_BPF_H__
> > +#define __USDT_BPF_H__
> > +
> > +#include <linux/errno.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_core_read.h>
> > +
> > +/* Below types and maps are internal implementation details of libbpf's USDT
> > + * support and are subjects to change. Also, usdt_xxx() API helpers should be
> > + * considered an unstable API as well and might be adjusted based on user
> > + * feedback from using libbpf's USDT support in production.
> > + */
> > +
> > +/* User can override BPF_USDT_MAX_SPEC_CNT to change default size of internal
> > + * map that keeps track of USDT argument specifications. This might be
> > + * necessary if there are a lot of USDT attachments.
> > + */
> > +#ifndef BPF_USDT_MAX_SPEC_CNT
> > +#define BPF_USDT_MAX_SPEC_CNT 256
> > +#endif
> > +/* User can override BPF_USDT_MAX_IP_CNT to change default size of internal
> > + * map that keeps track of IP (memory address) mapping to USDT argument
> > + * specification.
> > + * Note, if kernel supports BPF cookies, this map is not used and could be
> > + * resized all the way to 1 to save a bit of memory.
> > + */
> > +#ifndef BPF_USDT_MAX_IP_CNT
> > +#define BPF_USDT_MAX_IP_CNT (4 * BPF_USDT_MAX_SPEC_CNT)
> > +#endif
> > +/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This is
> > + * the only dependency on CO-RE, so if it's undesirable, user can override
> > + * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported or not.
> > + */
> > +#ifndef BPF_USDT_HAS_BPF_COOKIE
> > +#define BPF_USDT_HAS_BPF_COOKIE \
> > +     bpf_core_enum_value_exists(enum bpf_func_id___usdt, BPF_FUNC_get_attach_cookie___usdt)
> > +#endif
> > +
> > +enum __bpf_usdt_arg_type {
> > +     BPF_USDT_ARG_CONST,
> > +     BPF_USDT_ARG_REG,
> > +     BPF_USDT_ARG_REG_DEREF,
> > +};
> > +
> > +struct __bpf_usdt_arg_spec {
> > +     /* u64 scalar interpreted depending on arg_type, see below */
> > +     __u64 val_off;
> > +     /* arg location case, see bpf_udst_arg() for details */
> > +     enum __bpf_usdt_arg_type arg_type;
> > +     /* offset of referenced register within struct pt_regs */
> > +     short reg_off;
>
> Although USDT args are almost always passed via regs in pt_regs, other regs are
> occasionally used. In BCC repo this has come up a few times recently ([0][1]).
> Notably, in [1] we found a USDT in libpthread using a 'xmm' register on a recent
> Fedora, so it's not just obscure libs' probe targets.
>
> Of course, there's currently no way to fetch 'xmm' registers from BPF programs.
> Alexei and I had a braindump session where he concluded that it would be useful
> to have some arch-specific helper to pull non-pt_regs regs and a concise repro.
> Am poking at this, hope to have something in next week or two.
>
> Anyways, if this lib didn't assume that USDT arg regs were always some reg_off
> into pt_regs it would be easier to extend in the near future. This could be
> simply reserving negative reg_off values to signal some arch-specific non
> pt_regs register, or a more explicit enum to signal.

Yeah, I'm aware of that. It's still easy to extend, it's just going to
be a different bpf_usdt_arg_type.

>
>   [0]: https://github.com/iovisor/bcc/issues/3875
>   [1]: https://github.com/iovisor/bcc/pull/3880
>
> > +     /* whether arg should be interpreted as signed value */
> > +     bool arg_signed;
> > +     /* number of bits that need to be cleared and, optionally,
> > +      * sign-extended to cast arguments that are 1, 2, or 4 bytes
> > +      * long into final 8-byte u64/s64 value returned to user
> > +      */
> > +     char arg_bitshift;
>
> Could this field instead be 'arg_sz' holding size of arg in bytes? Could derive
> bitshift from size where it's needed in this patch, and future potential uses of
> size would already have it on hand. Folks writing new arch-specific parsing logic
> like your "libbpf: add x86-specific USDT arg spec parsing logic" patch wouldn't
> need to derive bitshift from size or care about what size is used for.
>
> I don't feel strongly about this, just noticed that, aside from this field and
> reg_off, it's very easy to conceptually map this struct's fields 1:1 to what
> USDT arg looks like without any knowledge of this lib's inner workings.

It could be arg_sz, yep, but here I'm optimizing for simplest and
fastest runtime (BPF-side) code at the expense of setup-time
(user-space) code. I think that's the right tradeoff, as setting this
up is one-time (and thus could be slow and arbitrarily complicated)
step, while fetching values at runtime can be very frequent operation,
so should be as simple and fast as possible.


>
> > +};
>
> [...]
>
> > +static inline __noinline
> > +int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
> > +{
> > +     struct __bpf_usdt_spec *spec;
> > +     struct __bpf_usdt_arg_spec *arg_spec;
> > +     unsigned long val;
> > +     int err, spec_id;
> > +
> > +     *res = 0;
> > +
> > +     spec_id = __bpf_usdt_spec_id(ctx);
> > +     if (spec_id < 0)
> > +             return -ESRCH;
> > +
> > +     spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > +     if (!spec)
> > +             return -ESRCH;
> > +
> > +     if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
> > +             return -ENOENT;
> > +
> > +     arg_spec = &spec->args[arg_num];
> > +     switch (arg_spec->arg_type) {
> > +     case BPF_USDT_ARG_CONST:
> > +             /* Arg is just a constant ("-4@$-9" in USDT arg spec).
> > +              * value is recorded in arg_spec->val_off directly.
> > +              */
> > +             val = arg_spec->val_off;
> > +             break;
> > +     case BPF_USDT_ARG_REG:
> > +             /* Arg is in a register (e.g, "8@%rax" in USDT arg spec),
> > +              * so we read the contents of that register directly from
> > +              * struct pt_regs. To keep things simple user-space parts
> > +              * record offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
> > +              */
> > +             err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> > +             if (err)
> > +                     return err;
> > +             break;
> > +     case BPF_USDT_ARG_REG_DEREF:
> > +             /* Arg is in memory addressed by register, plus some offset
> > +              * (e.g., "-4@-1204(%rbp)" in USDT arg spec). Register is
> > +              * identified lik with BPF_USDT_ARG_REG case, and the offset
> > +              * is in arg_spec->val_off. We first fetch register contents
> > +              * from pt_regs, then do another user-space probe read to
> > +              * fetch argument value itself.
> > +              */
> > +             err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> > +             if (err)
> > +                     return err;
> > +             err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
> > +             if (err)
> > +                     return err;
> > +             break;
>
> Assuming either of previous reg_off suggestions are taken, very straightforward
> to extend this for non-pt_regs regs.

So no-pt_regs register values are going to be fetched very differently
than BPF_USDT_ARG_REG case above with bpf_probe_read_kernel(). It will
be a separate case clause with call to a BPF helper that returns some
arch-specific register. So either way not much to reuse between the
two. As for BPF_USDT_ARG_REG_DEREF, I actually assume that those fancy
xmm registers can't be used for pointer dereference, tbh, but if we
see that it does, then having a helper function for fetching register
value is a trivial refactoring away.

>
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* cast arg from 1, 2, or 4 bytes to final 8 byte size clearing
> > +      * necessary upper arg_bitshift bits, with sign extension if argument
> > +      * is signed
> > +      */
> > +     val <<= arg_spec->arg_bitshift;
> > +     if (arg_spec->arg_signed)
> > +             val = ((long)val) >> arg_spec->arg_bitshift;
> > +     else
> > +             val = val >> arg_spec->arg_bitshift;
> > +     *res = val;
> > +     return 0;
> > +}
>
> [...]
