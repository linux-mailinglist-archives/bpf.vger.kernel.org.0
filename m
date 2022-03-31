Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AE4EE2EF
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiCaUyR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 16:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiCaUyR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 16:54:17 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25DE13A1E9
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 13:52:28 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id q7so636555ild.8
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHIkE9WhuvaA+DT/OWfPvpdDDi93fvEWmSJ23UOBvSI=;
        b=Di7mezMXjkA30nQVXODPGrRb2PiHjXsX7xDBb0e9KWruzoopQIEdmbLtn7PMtnz7HI
         ssGCx5Aak8IyJBsZjvkDbV/nksdmbG9BnwjVdGImbtXt4R+5WrV8zlw7qsCv0WgPlrrS
         KbSpgUBOFd7+XLNdcyRMhOWLwOCdyVVIF6HaKpFaXggIja0vk/aDTaoe/NC1r/G1eKoc
         AtVDGHspD4NfpdeADnCqrKo2fdEJWmsLRdV3Vuf8s7//vF5sUXnC+trg7P4idZqtPz5l
         7qfE2bqjEMQXyxgN9YwxJL3A0Zh/pfsS6V9pZ1S2pLnRT6oQlmuXg3hyZLajQsGCfa/J
         JaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHIkE9WhuvaA+DT/OWfPvpdDDi93fvEWmSJ23UOBvSI=;
        b=O9iMm5kyGX+DaVU/yW0TxGx27pdcMqA+4lZEwy2D2us6LctUzIMz7flBd459EYCye4
         k6UyF1yBHqcGOFtV4za4SCIrQpQgNxbxlIBXtwY2zM06g+i7jBDV5H+RSW7qxLct0sVe
         Sra8SSjLr8scmn8WVsb5cK8IfrAWuqKlRKFFLsfFhsbYg+ptu394JYjS0kt/0vdFQAgl
         dzhBQwmSuGK20+UR6mH2PewwRJAWyXbn3COYquAafdk7ZsPzG9C5Yzs+WwZuo9vP4ut+
         3jwwLZRjstpHt2g61fedFIoN+d8QNaKc+tQ4WNnVKzsLVGa9DumEq9thSR1gmLQSFs5z
         M1Hw==
X-Gm-Message-State: AOAM530crK9jKD2X/LfDjf9oxxbAB1bEhkDob5tY4TF+jPCBV/EqG3Lf
        81vDAvGxb5+AXmppVjkzPYXuXhLhNJ70+NGOAp8=
X-Google-Smtp-Source: ABdhPJwaz0JzPpP49j0JB11ZTaRPXYNdiyE2OATpuSZvWzlqnQczQCd4ty3b/ljlaBCaJx4omCEdnMobkvmI2zk8geo=
X-Received: by 2002:a92:cd89:0:b0:2c9:bdf3:c5dd with SMTP id
 r9-20020a92cd89000000b002c9bdf3c5ddmr9696128ilb.252.1648759948210; Thu, 31
 Mar 2022 13:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
 <alpine.LRH.2.23.451.2203311230280.16879@MyRouter> <CAEf4BzYTEMEzMRPtEdS2QyXwU1GUdO7-7=vkXbvpdTTWwyTgNQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYTEMEzMRPtEdS2QyXwU1GUdO7-7=vkXbvpdTTWwyTgNQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 31 Mar 2022 13:52:17 -0700
Message-ID: <CAEf4BzakMhtpBEu5BYcmESBkG9xK5YS268JKwoXQpL7s6U_9wQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] libbpf: add BPF-side of USDT support
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
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

On Thu, Mar 31, 2022 at 11:49 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 31, 2022 at 4:31 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On Fri, 25 Mar 2022, Andrii Nakryiko wrote:
> >
> > > Add BPF-side implementation of libbpf-provided USDT support. This
> > > consists of single header library, usdt.bpf.h, which is meant to be used
> > > from user's BPF-side source code. This header is added to the list of
> > > installed libbpf header, along bpf_helpers.h and others.
> > >
> >
> > <snip>
> >
> > Some suggestions below, but nothing major.
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > > diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> > > new file mode 100644
> > > index 000000000000..8ee084b2e6b5
> > > --- /dev/null
> > > +++ b/tools/lib/bpf/usdt.bpf.h
> > > @@ -0,0 +1,228 @@
> > > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > > +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> > > +#ifndef __USDT_BPF_H__
> > > +#define __USDT_BPF_H__
> > > +
> > > +#include <linux/errno.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include <bpf/bpf_core_read.h>
> > > +
> > > +/* Below types and maps are internal implementation details of libpf's USDT
> > > + * support and are subjects to change. Also, usdt_xxx() API helpers should be
> > > + * considered an unstable API as well and might be adjusted based on user
> > > + * feedback from using libbpf's USDT support in production.
> > > + */
> > > +
> > > +/* User can override BPF_USDT_MAX_SPEC_CNT to change default size of internal
> > > + * map that keeps track of USDT argument specifications. This might be
> > > + * necessary if there are a lot of USDT attachments.
> > > + */
> > > +#ifndef BPF_USDT_MAX_SPEC_CNT
> > > +#define BPF_USDT_MAX_SPEC_CNT 256
> > > +#endif
> > > +/* User can override BPF_USDT_MAX_IP_CNT to change default size of internal
> > > + * map that keeps track of IP (memory address) mapping to USDT argument
> > > + * specification.
> > > + * Note, if kernel supports BPF cookies, this map is not used and could be
> > > + * resized all the way to 1 to save a bit of memory.
> > > + */
> > > +#ifndef BPF_USDT_MAX_IP_CNT
> > > +#define BPF_USDT_MAX_IP_CNT 1024
> > > +#endif
> >
> > might be no harm to just make this default to a reasonable multiple of
> > BPF_USDT_MAX_SPEC_CNT; i.e. n specs X m possible sites. Would allow users
> > to simply override the MAX_SPEC_CNT in most cases too.
>
> It's not clear what the reasonable multiple is, it will differ for
> different binaries. I can do (4 * BPF_USDT_MAX_SPEC_CNT) to arrive at
> the same default 1024? Do you think that's reasonable?
>
> >
> > > +/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This is
> > > + * the only dependency on CO-RE, so if it's undesirable, user can override
> > > + * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported or not.
> > > + */
> > > +#ifndef BPF_USDT_HAS_BPF_COOKIE
> > > +#define BPF_USDT_HAS_BPF_COOKIE \
> > > +     bpf_core_enum_value_exists(enum bpf_func_id___usdt, BPF_FUNC_get_attach_cookie___usdt)
> > > +#endif
> > > +
> > > +enum __bpf_usdt_arg_type {
> > > +     BPF_USDT_ARG_CONST,
> > > +     BPF_USDT_ARG_REG,
> > > +     BPF_USDT_ARG_REG_DEREF,
> > > +};
> > > +
> > > +struct __bpf_usdt_arg_spec {
> > > +     __u64 val_off;
> > > +     enum __bpf_usdt_arg_type arg_type;
> > > +     short reg_off;
> > > +     bool arg_signed;
> > > +     char arg_bitshift;
> >
> > would be no harm having a small comment here or below where the
> > bitshifting is done like "for arg sizes less than 8 bytes, this tells
> > us how many bits to shift to left then right to
> > remove the unused bits, giving correct arg value".
>
> sure, I'll add that comment that this is used for casting and
> potentially sign-extending arguments up to u64
>
> >
> > > +};
> > > +
> > > +/* should match USDT_MAX_ARG_CNT in usdt.c exactly */
> > > +#define BPF_USDT_MAX_ARG_CNT 12
> > > +struct __bpf_usdt_spec {
> > > +     struct __bpf_usdt_arg_spec args[BPF_USDT_MAX_ARG_CNT];
> > > +     __u64 usdt_cookie;
> > > +     short arg_cnt;
> > > +};
> > > +
> > > +__weak struct {
> > > +     __uint(type, BPF_MAP_TYPE_ARRAY);
> > > +     __uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
> > > +     __type(key, int);
> > > +     __type(value, struct __bpf_usdt_spec);
> > > +} __bpf_usdt_specs SEC(".maps");
> > > +
> > > +__weak struct {
> > > +     __uint(type, BPF_MAP_TYPE_HASH);
> > > +     __uint(max_entries, BPF_USDT_MAX_IP_CNT);
> > > +     __type(key, long);
> > > +     __type(value, struct __bpf_usdt_spec);
> > > +} __bpf_usdt_specs_ip_to_id SEC(".maps");
> > > +
> > > +/* don't rely on user's BPF code to have latest definition of bpf_func_id */
> > > +enum bpf_func_id___usdt {
> > > +     BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
> > > +};
> > > +
> > > +static inline int __bpf_usdt_spec_id(struct pt_regs *ctx)
> > > +{
> > > +     if (!BPF_USDT_HAS_BPF_COOKIE) {
> > > +             long ip = PT_REGS_IP(ctx);
> >
> > Trying to sort of the permutations of features, I _think_ is it possible
> > the user has CO-RE support, but the clang version doesn't support the
> > push of the preserve_access_index attribute? Would it be feasible to
> > do an explicit "PT_REGS_IP_CORE(ctx);" here?
>
>
> We don't normally rely on _CORE variants when fetching values from
> pt_regs context, so I didn't want to add more dependency on CO-RE
> here. User can opt out of CO-RE entirely by redefining
> BPF_USDT_HAS_BPF_COOKIE, using PT_REGS_IP_CORE() here would make it
> harder. As for struct pt_regs, in some architectures it's part of
> UAPI, so it's very unlikely that existing fields are going to be moved
> around, so not using _CORE() should be fine, IMO.
>
>
> >
> > > +             int *spec_id_ptr;
> > > +
> > > +             spec_id_ptr = bpf_map_lookup_elem(&__bpf_usdt_specs_ip_to_id, &ip);
> > > +             return spec_id_ptr ? *spec_id_ptr : -ESRCH;
> > > +     }
> > > +
> > > +     return bpf_get_attach_cookie(ctx);
> >
> > should we grab the result in a u64 and handle the 0 case here -
> > meaning "not specified" - and return -ESRCH?
>
> But 0 is a perfectly fine spec ID, so why?
>
> >
> > > +}
> > > +
> > > +/* Return number of USDT arguments defined for currently traced USDT. */
> > > +__hidden __weak
> > > +int bpf_usdt_arg_cnt(struct pt_regs *ctx)
> > > +{
> > > +     struct __bpf_usdt_spec *spec;
> > > +     int spec_id;
> > > +
> > > +     spec_id = __bpf_usdt_spec_id(ctx);
> > > +     if (spec_id < 0)
> > > +             return -EINVAL;
> >
> > spec_id can be 0 for the "cookie not set" case (see above).
> >
> > should we pass through the error value from __bpf_usdt_spec_id()? Looking
> > above it's either -ESRCH or 0, but if we catch the 0 case as above we
> > could just pass through the error value.
> >
>
> See above, zero is correct spec ID. So if the kernel supports cookies
> and bpf_get_attach_cookie() returns zero, that zero is a real value.
>
> > > +
> > > +     spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > > +     if (!spec)
> > > +             return -EINVAL;
> > > +
> >
> > should this be -ESRCH? we know from the above we had a valid
> > spec_id.
>
> sure, I can change to -ESRCH, though it's more like a -EBUG :)
>
> >
> > > +     return spec->arg_cnt;
> > > +}
> >
> > also, since in every case (I think) that we call __bpf_usdt_spec_id()
> > we co on to look up the spec in the map, would it be easier to
> > combine both operations and have
> >
> > struct __bpf_usdt_spec * __bpf_usdt_spec(struct pt_regs *ctx);
> >
> > ?
>
> You are right, I think now we always get a spec itself. My earlier
> versions had an extra map for stuff like USDT name, so having spec ID
> separately made sense. I'll update the code to return spec directly.
>

So I tried this locally, and that doesn't save any code and frankly
makes code a bit more confusing and uglier. So I'll probably leave it
as is, just make sure all code paths return -ESRCH properly and stuff
like that.

> >
> > > +
> > > +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
> > > + * Returns 0 on success; negative error, otherwise.
> > > + * On error *res is guaranteed to be set to zero.
> > > + */
> > > +__hidden __weak
> > > +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
> > > +{
> > > +     struct __bpf_usdt_spec *spec;
> > > +     struct __bpf_usdt_arg_spec *arg_spec;
> > > +     unsigned long val;
> > > +     int err, spec_id;
> > > +
> > > +     *res = 0;
> > > +
> > > +     spec_id = __bpf_usdt_spec_id(ctx);
> > > +     if (spec_id < 0)
> > > +             return -ESRCH;
> > > +
> > > +     spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > > +     if (!spec)
> > > +             return -ESRCH;
> > > +
> > > +     if (arg >= spec->arg_cnt)
> > > +             return -ENOENT;
> > > +
> >
> > I'm surprised you didn't need to check for negative values or a hard
> > upper bound for the arg index here (to keep the verifier happy for
> > the later array indexing using arg). Any dangers that an older
> > LLVM+clang would generate code that might get tripped up on
> > verification with this?
>
> Great point. I think it's because in all the current code arg is a
> known constant, so verifier just knows that everything is within
> bounds. I'll harden the code a bit and will add a test that provides
> arg as dynamic value.
>
> >
> > > +     arg_spec = &spec->args[arg];
> > > +     switch (arg_spec->arg_type) {
> > > +     case BPF_USDT_ARG_CONST:
> > > +             val = arg_spec->val_off;
> > > +             break;
>
> [...]
