Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70B6674634
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjASWeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjASWc1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:32:27 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58285A9582
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:16:06 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id s66so2921491oib.7
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8H7u7i1b64pfLBM6/c3Xt4SYFbHcEBvm9DKOGfWUdSo=;
        b=fWdDMtkkaxCpZIp8MpM8kny/pDsnCFFDq6p2YbnlKANDVhoJ5D0VE5G50mBQDdC6Vy
         DB+Yf3l2nYizGaIhjrw4t3agpBAcwhcxcL9+uf93uJSL0C7Yv885/knevAmPCiBQbY8b
         BF47JAY7b1BlxuBMEQIKbh3OgUbMneOYfqsmrIggeiuxhc+KHrUQ9KfzObEXYlvLqS1+
         15XborFaD1Q4KEY+YkfLuSOtGHeQhPZfy3zIrCR2/y0eunMAo6U87Ld6G+EkZVjqDJ1K
         BgRpTTY7+aUWec3FVtGBCFnqCgOanHKLoSmq8zXPMzhdISUUC0UCMBNcn3ZVLIQ4sIcd
         Koig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H7u7i1b64pfLBM6/c3Xt4SYFbHcEBvm9DKOGfWUdSo=;
        b=60lIsjahFEbX9JmZnbd16TIzg8Z3o50FVB5LTeBGuq7Te7ZqVwOnbOuLAMoJw+t+Mp
         kxslpi4QS07J53kiRA2r2xr5RVgCxZEd16z84GyxmV7iLJiApPob/XR3bSvLe3DjkaSW
         zpgPQzEajMJBdC5FX+rnjqcRppKvQikAWFHsAOVb/e4k7Ml9RiuesoAlyr9L2lIw8I/8
         KGe+tFzv16ud0tlyhDrZRdsKoWkVhGkGoIj+EDmCKbDZhcFlPEHy56x6vZmv9SwEbbsi
         Fm6FNGYcm+ZrigQDapd9xApqK88FCRcXhReDjCk8ArQuQ4BUKOZRcObVucuBcdglHO6H
         qLfQ==
X-Gm-Message-State: AFqh2krI5YyeRmM60pMdIpb8FJI/67xT9ZaKrtGF5kgyyXJ8PhBL6U/S
        mrEbwJDgyKa8UkwackHMpFnWym9XzfwuhT9wfkoiDMjh
X-Google-Smtp-Source: AMrXdXug8MeDXzDzsWsMxx0WJkXTJ89CIAPE0kLqvDZih+w/ed76f5pOl2sITz3RKe5QBN+1BIogpKpJ9vT78JlHQK4=
X-Received: by 2002:a05:6808:3a91:b0:364:c0a5:1fcf with SMTP id
 fb17-20020a0568083a9100b00364c0a51fcfmr674020oib.58.1674166565454; Thu, 19
 Jan 2023 14:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20230119021442.1465269-1-memxor@gmail.com> <20230119021442.1465269-4-memxor@gmail.com>
 <CAJnrk1ZSP=1s91=RYgto9TbniMH9u=4fPdf6BkOueS3RE6LF5w@mail.gmail.com>
In-Reply-To: <CAJnrk1ZSP=1s91=RYgto9TbniMH9u=4fPdf6BkOueS3RE6LF5w@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 20 Jan 2023 03:45:29 +0530
Message-ID: <CAP01T74N3eWg-F1x-X52pPpeM=Y+bDWMnRreCbhbpBftSgSpAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/11] bpf: Fix partial dynptr stack slot reads/writes
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
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

On Fri, 20 Jan 2023 at 03:36, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 6:14 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Currently, while reads are disallowed for dynptr stack slots, writes are
> > not. Reads don't work from both direct access and helpers, while writes
> > do work in both cases, but have the effect of overwriting the slot_type.
> >
> > While this is fine, handling for a few edge cases is missing. Firstly,
> > a user can overwrite the stack slots of dynptr partially.
> >
> > Consider the following layout:
> > spi: [d][d][?]
> >       2  1  0
> >
> > First slot is at spi 2, second at spi 1.
> > Now, do a write of 1 to 8 bytes for spi 1.
> >
> > This will essentially either write STACK_MISC for all slot_types or
> > STACK_MISC and STACK_ZERO (in case of size < BPF_REG_SIZE partial write
> > of zeroes). The end result is that slot is scrubbed.
> >
> > Now, the layout is:
> > spi: [d][m][?]
> >       2  1  0
> >
> > Suppose if user initializes spi = 1 as dynptr.
> > We get:
> > spi: [d][d][d]
> >       2  1  0
> >
> > But this time, both spi 2 and spi 1 have first_slot = true.
> >
> > Now, when passing spi 2 to dynptr helper, it will consider it as
> > initialized as it does not check whether second slot has first_slot ==
> > false. And spi 1 should already work as normal.
> >
> > This effectively replaced size + offset of first dynptr, hence allowing
> > invalid OOB reads and writes.
> >
> > Make a few changes to protect against this:
> > When writing to PTR_TO_STACK using BPF insns, when we touch spi of a
> > STACK_DYNPTR type, mark both first and second slot (regardless of which
> > slot we touch) as STACK_INVALID. Reads are already prevented.
> >
> > Second, prevent writing to stack memory from helpers if the range may
> > contain any STACK_DYNPTR slots. Reads are already prevented.
> >
> > For helpers, we cannot allow it to destroy dynptrs from the writes as
> > depending on arguments, helper may take uninit_mem and dynptr both at
> > the same time. This would mean that helper may write to uninit_mem
> > before it reads the dynptr, which would be bad.
> >
> > PTR_TO_MEM: [?????dd]
> >
> > Depending on the code inside the helper, it may end up overwriting the
> > dynptr contents first and then read those as the dynptr argument.
> >
> > Verifier would only simulate destruction when it does byte by byte
> > access simulation in check_helper_call for meta.access_size, and
> > fail to catch this case, as it happens after argument checks.
> >
> > The same would need to be done for any other non-trivial objects created
> > on the stack in the future, such as bpf_list_head on stack, or
> > bpf_rb_root on stack.
> >
> > A common misunderstanding in the current code is that MEM_UNINIT means
> > writes, but note that writes may also be performed even without
> > MEM_UNINIT in case of helpers, in that case the code after handling meta
> > && meta->raw_mode will complain when it sees STACK_DYNPTR. So that
> > invalid read case also covers writes to potential STACK_DYNPTR slots.
> > The only loophole was in case of meta->raw_mode which simulated writes
> > through instructions which could overwrite them.
> >
> > A future series sequenced after this will focus on the clean up of
> > helper access checks and bugs around that.
> >
> > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 102 ++++++++++++++++++
> >  .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
> >  2 files changed, 105 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index eeb6f1b2bd60..09c09d9bfd89 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -769,6 +769,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg,
> >         __mark_dynptr_reg(reg, type, true);
> >  }
> >
> > +static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
> > +                                       struct bpf_func_state *state, int spi);
> >
> >  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >                                    enum bpf_arg_type arg_type, int insn_idx)
> > @@ -863,6 +865,69 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
> >         return 0;
> >  }
> >
> > +static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> > +                              struct bpf_reg_state *reg);
> > +
> > +static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
> > +                                       struct bpf_func_state *state, int spi)
> > +{
> > +       int i;
> > +
> > +       /* We always ensure that STACK_DYNPTR is never set partially,
> > +        * hence just checking for slot_type[0] is enough. This is
> > +        * different for STACK_SPILL, where it may be only set for
> > +        * 1 byte, so code has to use is_spilled_reg.
> > +        */
> > +       if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
> > +               return 0;
> > +
> > +       /* Reposition spi to first slot */
> > +       if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
> > +               spi = spi + 1;
> > +
> > +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> > +               verbose(env, "cannot overwrite referenced dynptr\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       mark_stack_slot_scratched(env, spi);
> > +       mark_stack_slot_scratched(env, spi - 1);
> > +
> > +       /* Writing partially to one dynptr stack slot destroys both. */
> > +       for (i = 0; i < BPF_REG_SIZE; i++) {
> > +               state->stack[spi].slot_type[i] = STACK_INVALID;
> > +               state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> > +       }
> > +
> > +       /* Invalidate any slices associated with this dynptr */
> > +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
>
> We'll never get here because referenced dynptrs can't be overwritten
> (we check this above and return -EINVAL if dynptr_type_refcounted() is
> true).
> I think we should invalidate any slices associated with non-referenced
> dynptrs as well.

Ah, right. Will fix, and I'll add a test for this to ensure slices are
invalidated in v3.
