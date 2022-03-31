Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE65C4ED361
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 07:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiCaFq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 01:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiCaFqz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 01:46:55 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C741005
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 22:45:08 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 9so24254783iou.5
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 22:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwwYNFwO3ufp01x1PUGjg/3mx0xmJJhvzyuWhGXB+0k=;
        b=Hynnh/fc0fM4R8bG4t4QLKVSfFJMJQJoDF4SaaPBOYHOnAcvJip5hu39ofe0P0NZw7
         rWQvFeDRHPhQ3VJfrJnvzz74NOITRIiwJAP48WL5RLq7QrnotlOvWfPyTSHH+YrYIJob
         TRWS/enMv/H82MPTC7Xyrs4BrhI4itqTCRmwp3fWyh2aGJgBGT9Zv+md1LUDowMY48w2
         nCbNreGE88CvgPAA85ba0iCa0eEyXqbiM7LIoRtZJ/WX/u98Q6gLILpG2nBWf/k3YmTq
         NcnKSDZl5rMZl4rcdAc4lZ95lyLakck1MTu65vlz48hge89uUA/bCqajgkMSaynl3ov0
         AimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwwYNFwO3ufp01x1PUGjg/3mx0xmJJhvzyuWhGXB+0k=;
        b=TgPWpk9kPHSeWgiqKxgsVqnNFGGdu4xFLyVBBVtWrIweYmmk0h20680svgmRP1tync
         DsnfH60oMJv3mG+lMYYu9hBhBY2G4wtzbn/8IiCUrIswHW3flTNQTkMBgu4YPwy4wTeA
         PUfoCa/l3CAYQlSafWiqxDPuRUOwiwHmWI5ZCTeg8LOjLJtc/0eeWW9ohBfPoFdpZt47
         G5w0/i5buUEhukBmr9s3k5GUb4c0nG/yW4nbv664Y3dqhzvA1clXOcW2IEjtwz4jREuN
         ke+mNaZwZevFhmU/+ZKWgl6z5LoNy2q1HzoNily2Ka3qQbWYEBFuDaZAvSaQJ9gXIFTF
         SRdQ==
X-Gm-Message-State: AOAM530ajzJMItPcBGDMdvtWboHW4bFxY7B1JgiOO5yfvfio0J+xeev6
        nL79VPbLxuSsh8bsMTGVY63D5GoPvKKayk+2PNE=
X-Google-Smtp-Source: ABdhPJxvf/dPIk2bHjVgV45RveW2e6dlDzmwF8xI07+dd618/T4n4K+F+Uotjo0LV7yTKF6XZJsKls5vZvJcWtZy0B8=
X-Received: by 2002:a05:6638:3395:b0:323:8a00:7151 with SMTP id
 h21-20020a056638339500b003238a007151mr2091284jav.93.1648705508014; Wed, 30
 Mar 2022 22:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
 <176471e1-1221-8eb3-300e-986e3a6eaef8@gmail.com>
In-Reply-To: <176471e1-1221-8eb3-300e-986e3a6eaef8@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Mar 2022 22:44:57 -0700
Message-ID: <CAEf4BzZSmhcDet8ax1hn-7HDPsXGacM09Zrf2dFvTDKjPbadGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] libbpf: add BPF-side of USDT support
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
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

On Tue, Mar 29, 2022 at 8:11 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> On 2022/3/25 1:29 PM, Andrii Nakryiko wrote:
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
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/Makefile   |   2 +-
> >  tools/lib/bpf/usdt.bpf.h | 228 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 229 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/bpf/usdt.bpf.h
> >
> > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> > index b8b37fe76006..b4fbe8bed555 100644
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -239,7 +239,7 @@ install_lib: all_cmd
> >
> >  SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h            \
> >           bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h         \
> > -         skel_internal.h libbpf_version.h
> > +         skel_internal.h libbpf_version.h usdt.bpf.h
> >  GEN_HDRS := $(BPF_GENERATED)
> >
> >  INSTALL_PFX := $(DESTDIR)$(prefix)/include/bpf
> > diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> > new file mode 100644
> > index 000000000000..8ee084b2e6b5
> > --- /dev/null
> > +++ b/tools/lib/bpf/usdt.bpf.h
> > @@ -0,0 +1,228 @@
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
> > +/* Below types and maps are internal implementation details of libpf's USDT
>
> typo: libpf -> libbpf
>
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
> > +#define BPF_USDT_MAX_IP_CNT 1024
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
> > +     __u64 val_off;
> > +     enum __bpf_usdt_arg_type arg_type;
> > +     short reg_off;
> > +     bool arg_signed;
> > +     char arg_bitshift;
> > +};
> > +
> > +/* should match USDT_MAX_ARG_CNT in usdt.c exactly */
> > +#define BPF_USDT_MAX_ARG_CNT 12
> > +struct __bpf_usdt_spec {
> > +     struct __bpf_usdt_arg_spec args[BPF_USDT_MAX_ARG_CNT];
> > +     __u64 usdt_cookie;
> > +     short arg_cnt;
> > +};
> > +
> > +__weak struct {
> > +     __uint(type, BPF_MAP_TYPE_ARRAY);
> > +     __uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
> > +     __type(key, int);
> > +     __type(value, struct __bpf_usdt_spec);
> > +} __bpf_usdt_specs SEC(".maps");
> > +
> > +__weak struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(max_entries, BPF_USDT_MAX_IP_CNT);
> > +     __type(key, long);
> > +     __type(value, struct __bpf_usdt_spec);
>
> type should be int.

yep, fixed that locally already, thanks

>
> > +} __bpf_usdt_specs_ip_to_id SEC(".maps");
> > +
> > +/* don't rely on user's BPF code to have latest definition of bpf_func_id */
> > +enum bpf_func_id___usdt {
> > +     BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
> > +};
> > +
> > +static inline int __bpf_usdt_spec_id(struct pt_regs *ctx)
> > +{
> > +     if (!BPF_USDT_HAS_BPF_COOKIE) {
> > +             long ip = PT_REGS_IP(ctx);
> > +             int *spec_id_ptr;
> > +
> > +             spec_id_ptr = bpf_map_lookup_elem(&__bpf_usdt_specs_ip_to_id, &ip);
> > +             return spec_id_ptr ? *spec_id_ptr : -ESRCH;
> > +     }
> > +
> > +     return bpf_get_attach_cookie(ctx);
> > +}
> > +
> > +/* Return number of USDT arguments defined for currently traced USDT. */
> > +__hidden __weak
> > +int bpf_usdt_arg_cnt(struct pt_regs *ctx)
> > +{
> > +     struct __bpf_usdt_spec *spec;
> > +     int spec_id;
> > +
> > +     spec_id = __bpf_usdt_spec_id(ctx);
> > +     if (spec_id < 0)
> > +             return -EINVAL;
> > +
> > +     spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > +     if (!spec)
> > +             return -EINVAL;
> > +
> > +     return spec->arg_cnt;
> > +}
> > +
> > +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
> > + * Returns 0 on success; negative error, otherwise.
> > + * On error *res is guaranteed to be set to zero.
> > + */
> > +__hidden __weak
> > +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
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
> > +     if (arg >= spec->arg_cnt)
> > +             return -ENOENT;
> > +
> > +     arg_spec = &spec->args[arg];
> > +     switch (arg_spec->arg_type) {
> > +     case BPF_USDT_ARG_CONST:
> > +             val = arg_spec->val_off;
> > +             break;
> > +     case BPF_USDT_ARG_REG:
> > +             err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> > +             if (err)
> > +                     return err;
> > +             break;
> > +     case BPF_USDT_ARG_REG_DEREF:
> > +             err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> > +             if (err)
> > +                     return err;
> > +             err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
> > +             if (err)
> > +                     return err;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     val <<= arg_spec->arg_bitshift;
> > +     if (arg_spec->arg_signed)
> > +             val = ((long)val) >> arg_spec->arg_bitshift;
> > +     else
> > +             val = val >> arg_spec->arg_bitshift;
> > +     *res = val;
> > +     return 0;
> > +}
> > +
> > +/* Retrieve user-specified cookie value provided during attach as
> > + * bpf_usdt_opts.usdt_cookie. This serves the same purpose as BPF cookie
> > + * returned by bpf_get_attach_cookie(). Libbpf's support for USDT is itself
> > + * utilizaing BPF cookies internally, so user can't use BPF cookie directly
> > + * for USDT programs and has to use bpf_usdt_cookie() API instead.
> > + */
> > +__hidden __weak
> > +long bpf_usdt_cookie(struct pt_regs *ctx)
> > +{
> > +     struct __bpf_usdt_spec *spec;
> > +     int spec_id;
> > +
> > +     spec_id = __bpf_usdt_spec_id(ctx);
> > +     if (spec_id < 0)
> > +             return 0;
> > +
> > +     spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > +     if (!spec)
> > +             return 0;
> > +
> > +     return spec->usdt_cookie;
> > +}
> > +
> > +/* we rely on ___bpf_apply() and ___bpf_narg() macros already defined in bpf_tracing.h */
> > +#define ___bpf_usdt_args0() ctx
> > +#define ___bpf_usdt_args1(x) ___bpf_usdt_args0(), ({ long _x; bpf_usdt_arg(ctx, 0, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args2(x, args...) ___bpf_usdt_args1(args), ({ long _x; bpf_usdt_arg(ctx, 1, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args3(x, args...) ___bpf_usdt_args2(args), ({ long _x; bpf_usdt_arg(ctx, 2, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args4(x, args...) ___bpf_usdt_args3(args), ({ long _x; bpf_usdt_arg(ctx, 3, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args5(x, args...) ___bpf_usdt_args4(args), ({ long _x; bpf_usdt_arg(ctx, 4, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args6(x, args...) ___bpf_usdt_args5(args), ({ long _x; bpf_usdt_arg(ctx, 5, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args7(x, args...) ___bpf_usdt_args6(args), ({ long _x; bpf_usdt_arg(ctx, 6, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args8(x, args...) ___bpf_usdt_args7(args), ({ long _x; bpf_usdt_arg(ctx, 7, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args9(x, args...) ___bpf_usdt_args8(args), ({ long _x; bpf_usdt_arg(ctx, 8, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args10(x, args...) ___bpf_usdt_args9(args), ({ long _x; bpf_usdt_arg(ctx, 9, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args11(x, args...) ___bpf_usdt_args10(args), ({ long _x; bpf_usdt_arg(ctx, 10, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args12(x, args...) ___bpf_usdt_args11(args), ({ long _x; bpf_usdt_arg(ctx, 11, &_x); (void *)_x; })
> > +#define ___bpf_usdt_args(args...) ___bpf_apply(___bpf_usdt_args, ___bpf_narg(args))(args)
> > +
> > +/*
> > + * BPF_USDT serves the same purpose for USDT handlers as BPF_PROG for
> > + * tp_btf/fentry/fexit BPF programs and BPF_KPROBE for kprobes.
> > + * Original struct pt_regs * context is preserved as 'ctx' argument.
> > + */
> > +#define BPF_USDT(name, args...)                                                  \
> > +name(struct pt_regs *ctx);                                               \
> > +static __attribute__((always_inline)) typeof(name(0))                            \
> > +____##name(struct pt_regs *ctx, ##args);                                 \
> > +typeof(name(0)) name(struct pt_regs *ctx)                                \
> > +{                                                                        \
> > +        _Pragma("GCC diagnostic push")                                           \
> > +        _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")                   \
> > +        return ____##name(___bpf_usdt_args(args));                       \
> > +        _Pragma("GCC diagnostic pop")                                            \
> > +}                                                                        \
> > +static __attribute__((always_inline)) typeof(name(0))                            \
> > +____##name(struct pt_regs *ctx, ##args)
> > +
> > +#endif /* __USDT_BPF_H__ */
