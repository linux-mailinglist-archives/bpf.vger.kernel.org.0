Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB356220E5
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKIAhC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKIAgw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:36:52 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024663162
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:36:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u24so24934106edd.13
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/p5Lc2b7tDwotLFDsld0l4ZvQmPo23leE/943+s/L8M=;
        b=NsnH19YFO/L0KRFwoBTEjwwFESKGI0tMJGJs4pHpEzqKWROZohG/6OVadep8b+4hdz
         lmz5A/ns/Xpy6khC0zE/QAdM/kHCzS1r2BUqPHFkkvumGAXgiKsxrv5PgFRV9JSZUhm9
         8KR8VDOAqTce2JhL9yVl4/g4K775dQZkqJYR8qXtyVfQAvnrTPYDj/2aXxgP06spjcaw
         nNgl4i0W+HOpeFP1jvsAIlJV+NNcG1IeyjQFQpPD6t7DUhg0TYuOxw8ifoBCU5Cj8o+L
         b8MHQ2KdiJw14SbcCFeOQlmHg3fTtqcYwN8J5Qek9Nga/3CrqF0sTvCtZFPEVpNlXqvF
         WZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/p5Lc2b7tDwotLFDsld0l4ZvQmPo23leE/943+s/L8M=;
        b=rT5Fg/WI2+bYCF1WHIlDtplKSyeaEfo4mo2d4gInkTNswyPYJJdMup2rfXKJGX+ToA
         r84u+l4NFiygFffeAa4Zm05KBxmO8od2wqNen1CpNJkkhllQxNjR547ahq2WjPxcbRen
         r5vZvbCOXqzkxDX1q4LA6NQD7jqHJC0eTtwlveK3Vx5881BQk9vLaTsgSHvE1Hk8/3IJ
         aZUb6iWEGuaZUYW82S1cIq95MRRbNu0d3lerlJXbS/1Mx/oVtWfSjwimT567NLgVs88G
         C3pUAkLhPcxeEtjn/+4UK6qXnIGehdAPEpZl77uSXm/Xv87SW6et0voqXjZiTKcAuesa
         R+Bg==
X-Gm-Message-State: ACrzQf0WBW5ejLHbrIralXrwnGV/56iLXUE5D25y4ujIZs/lokDospRo
        1K68I2GKJV+tj6euS9fo+x6VR4mgPxS2Mq/MIeo=
X-Google-Smtp-Source: AMsMyM4Vw8o747KWhwjjtBzeb6+rfIUhacsgG0LGQ4tEx1mDuzPk1ak6xjQdHjdA9qMWLY2Bppl2wHV8rTZlNGolFAg=
X-Received: by 2002:aa7:c2ca:0:b0:461:89a6:2281 with SMTP id
 m10-20020aa7c2ca000000b0046189a62281mr60107297edp.260.1667954201243; Tue, 08
 Nov 2022 16:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-7-memxor@gmail.com>
 <CAEf4BzZRaN_zd07jvtom6QJEEDGmFQTLJy4BM1bKi1MH5+n5QA@mail.gmail.com> <20221109000016.np325iqjjegvdose@apollo>
In-Reply-To: <20221109000016.np325iqjjegvdose@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 16:36:29 -0800
Message-ID: <CAEf4BzZ0h4yda0_M8+wgpsHAgm_J5oeUtaxm8V-jqy3gNjFWdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 06/25] bpf: Introduce local kptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Tue, Nov 8, 2022 at 4:00 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, Nov 09, 2022 at 04:59:41AM IST, Andrii Nakryiko wrote:
> > On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
> > > program BTF. This is indicated by the presence of MEM_ALLOC type flag in
> > > reg->type to avoid having to check btf_is_kernel when trying to match
> > > argument types in helpers.
> > >
> > > Refactor btf_struct_access callback to just take bpf_reg_state instead
> > > of btf and btf_type paramters. Note that the call site in
> > > check_map_access now simulates access to a PTR_TO_BTF_ID by creating a
> > > dummy reg on stack. Since only the type, btf, and btf_id of the register
> > > matter for the checks, it can be done so without complicating the usual
> > > cases elsewhere in the verifier where reg->btf and reg->btf_id is used
> > > verbatim.
> > >
> > > Whenever walking such types, any pointers being walked will always yield
> > > a SCALAR instead of pointer. In the future we might permit kptr inside
> > > local kptr (either kernel or local), and it would be permitted only in
> > > that case.
> > >
> > > For now, these local kptrs will always be referenced in verifier
> > > context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> > > to such objects, as long fields that are special are not touched
> > > (support for which will be added in subsequent patches). Note that once
> > > such a local kptr is marked PTR_UNTRUSTED, it is no longer allowed to
> > > write to it.
> > >
> > > No PROBE_MEM handling is therefore done for loads into this type unless
> > > PTR_UNTRUSTED is part of the register type, since they can never be in
> > > an undefined state, and their lifetime will always be valid.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h              | 28 ++++++++++++++++--------
> > >  include/linux/filter.h           |  8 +++----
> > >  kernel/bpf/btf.c                 | 16 ++++++++++----
> > >  kernel/bpf/verifier.c            | 37 ++++++++++++++++++++++++++------
> > >  net/bpf/bpf_dummy_struct_ops.c   | 14 ++++++------
> > >  net/core/filter.c                | 34 ++++++++++++-----------------
> > >  net/ipv4/bpf_tcp_ca.c            | 13 ++++++-----
> > >  net/netfilter/nf_conntrack_bpf.c | 17 ++++++---------
> > >  8 files changed, 99 insertions(+), 68 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index afc1c51b59ff..75dbd2ecf80a 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -524,6 +524,11 @@ enum bpf_type_flag {
> > >         /* Size is known at compile time. */
> > >         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> > >
> > > +       /* MEM is of a type from program BTF, not kernel BTF. This is used to
> > > +        * tag PTR_TO_BTF_ID allocated using bpf_obj_new.
> > > +        */
> > > +       MEM_ALLOC               = BIT(11 + BPF_BASE_TYPE_BITS),
> > > +
> >
> > you fixed one naming confusion with RINGBUF and basically are creating
> > a new one, where "ALLOC" means "local kptr"... If we are stuck with
> > "local kptr" (which I find very confusing as well, but that's beside
> > the point), why not stick to the whole "local" terminology here?
> > MEM_LOCAL?
> >
>
> See the discussion about this in v4:
> https://lore.kernel.org/bpf/20221104075113.5ighwdvero4mugu7@apollo
>
> It was MEM_TYPE_LOCAL before. Also, better naming suggestions are always
> welcome, I asked the same in that message as well.

Sorry, I haven't followed <v5. Don't have perfect name, but logically
this is BPF program memory. So "prog_kptr" would be something to
convert this, but I'm not super happy with such a name. "user_kptr"
would be too confusing, drawing incorrect "kernel space vs user space"
comparison, while both are kernel memory. It's BPF-side kptr, so
"bpf_kptr", but also not great.

So that's why didn't suggest anything specific, but at least as far as
MEM_xxx flag goes, MEM_LOCAL_KPTR is better than MEM_ALLOC, IMO. It's
at least consistent with the official name of the concept it
represents.

>
> > >         __BPF_TYPE_FLAG_MAX,
> > >         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
> > >  };
> > > @@ -771,6 +776,7 @@ struct bpf_prog_ops {
> > >                         union bpf_attr __user *uattr);
> > >  };
> > >
> >
> > [...]
> >
> > > -int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> > > -                     const struct btf_type *t, int off, int size,
> > > -                     enum bpf_access_type atype __maybe_unused,
> > > +int btf_struct_access(struct bpf_verifier_log *log,
> > > +                     const struct bpf_reg_state *reg,
> > > +                     int off, int size, enum bpf_access_type atype __maybe_unused,
> > >                       u32 *next_btf_id, enum bpf_type_flag *flag)
> > >  {
> > > +       const struct btf *btf = reg->btf;
> > >         enum bpf_type_flag tmp_flag = 0;
> > > +       const struct btf_type *t;
> > > +       u32 id = reg->btf_id;
> > >         int err;
> > > -       u32 id;
> > >
> > > +       t = btf_type_by_id(btf, id);
> > >         do {
> > >                 err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
> > >
> > >                 switch (err) {
> > >                 case WALK_PTR:
> > > +                       /* For local types, the destination register cannot
> > > +                        * become a pointer again.
> > > +                        */
> > > +                       if (type_is_local_kptr(reg->type))
> > > +                               return SCALAR_VALUE;
> >
> > passing the entire bpf_reg_state just to differentiate between local
> > vs kernel pointer seems like a huge overkill. bpf_reg_state is quite a
> > complicated and extensive amount of state, and it seems cleaner to
> > just pass it as a flag whether to allow pointer chasing or not. At
> > least then we know we only care about that specific aspect, not about
> > dozens of other possible fields of bpf_reg_state.
> >
>
> I agree that the separation is usually better, especially because this is also a
> callback. I don't feel too strong about this though, we certainly do pass the
> whole reg to functions which only work on a specific type of pointer. Though the

Yeah, and then it takes a lot of grepping and jumping around the code
to verify that only one simple field out of the entire bpf_reg_state
is actually used. I'd say this is actually bad that we do pass it
around so willy-nilly. Verifier code is already a hot complex mess,
let's not actively make it harder than necessary.

> concern in this case is justified as it's not only an internal function but also
> a callback.
>
> It was just a bool in the RFC.
> But in https://lore.kernel.org/bpf/20220907233023.x3uclwlnjuhftvtb@macbook-pro-4.dhcp.thefacebook.com
> Alexei suggested passing reg instead.
> From the link:
> > imo it's cleaner to pass 'reg' instead of 'reg->btf',
> > so we don't have to pass another boolean.
> > And check type_is_local(reg) inside btf_struct_access().

I sympathize with "too many input args" (especially if it's a bunch of
bools) argument, but see above, I find it increasingly harder to know
what parts of complex internal register state is used by helper
functions and which are not.

And the fact that we have to construct a fake register state in some
case is a red flag to me. Pass enum bpf_reg_type type to avoid passing
true/false. Or let's invent a new enum. Or extend enum bpf_access_type
to have READ_NOPTR/WRITE_NOPTR or something like that. Don't know.

This isn't a major issue, I can live with this just fine, but this
definitely doesn't feel like a clean approach.
