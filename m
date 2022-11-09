Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8CA622092
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiKIAAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKIAAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:00:21 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3513EB7D5
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:00:20 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso356412pjc.2
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0ZjnsjOaw3Tfq2pV7kWn2x2ye8zOaXYClf5zmo2D2g=;
        b=d8BY5hqHyorc30i0gSaasdKu+mNSrU1R47N0peudaY0sWduOpeolSGw7Xuhg7zJus5
         37Pip9wVmIi5hMwY5taeL582jLwM6lAzEiwvEavqhzzN7eDJxK1d1a/dj5UAoiuCwCUi
         tffxm/RBdu4wSl8n/p13k66yLZQFzghiL2Z4E9oRzPB1lb6Yro1lW19JgwsftqvGUcCy
         kCNrjkEiTJsoUlOkmiLYqFgUu5K5gVUQa6FPr9IqK824na6mU50IK0G6aII8C6PwwH/y
         /yPLgqPFj61ENkhvRFiiTvg2TaVzaEYKhgEZMEXDnIOhlQcwp7+lykaLMfFhzgzwVERu
         hrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0ZjnsjOaw3Tfq2pV7kWn2x2ye8zOaXYClf5zmo2D2g=;
        b=S5VNqSny/PqGpnImUTqrAcv6CPjlWOZcIdht3FdHYWWNQnhkqAO1WOLH53BfpAMsjC
         cWOi1vy1Oauw7d/ocpvHz69IjfN+37gZR6pvxmC/B/TRwkXBxnqghYImWSGHHjFKBvae
         AVpXULD3FyzGxcPSmCiVLc7nYtHaUR9N2NRFaraqHR3M4yEI24LixYz6zGVuCdRhv39U
         1+eUocVD3/11M1pbV6laALJ+ZnK9XauWfcWYF3GAC0nlLyCMnsQdz++bXRU0h8u82cJt
         iWT1M78Jvn8JBa9o7b35egYvtzINKlVSvMuk3BK8AxD0WG3+PuoIfh3RY2jGJAa5fGHA
         lDqQ==
X-Gm-Message-State: ACrzQf2derHAT/bXViufmoXuftB3sZNW1NNBABfehEOY56gwiuWLcbdE
        Cpyd13sbuhV/Uw78X+euFwU=
X-Google-Smtp-Source: AMsMyM553yw8i3a6SfoLOSH+P1C6EcrbzHQA6CQHdSm4JHkXErjzACeYzTRkxSasrkFKyseJm0vp9w==
X-Received: by 2002:a17:90a:2847:b0:213:9ae5:b9b4 with SMTP id p7-20020a17090a284700b002139ae5b9b4mr64036986pjf.136.1667952019613;
        Tue, 08 Nov 2022 16:00:19 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709027d9400b0018862b7f8besm7550252plm.160.2022.11.08.16.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:00:19 -0800 (PST)
Date:   Wed, 9 Nov 2022 05:30:16 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 06/25] bpf: Introduce local kptrs
Message-ID: <20221109000016.np325iqjjegvdose@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-7-memxor@gmail.com>
 <CAEf4BzZRaN_zd07jvtom6QJEEDGmFQTLJy4BM1bKi1MH5+n5QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZRaN_zd07jvtom6QJEEDGmFQTLJy4BM1bKi1MH5+n5QA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 04:59:41AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
> > program BTF. This is indicated by the presence of MEM_ALLOC type flag in
> > reg->type to avoid having to check btf_is_kernel when trying to match
> > argument types in helpers.
> >
> > Refactor btf_struct_access callback to just take bpf_reg_state instead
> > of btf and btf_type paramters. Note that the call site in
> > check_map_access now simulates access to a PTR_TO_BTF_ID by creating a
> > dummy reg on stack. Since only the type, btf, and btf_id of the register
> > matter for the checks, it can be done so without complicating the usual
> > cases elsewhere in the verifier where reg->btf and reg->btf_id is used
> > verbatim.
> >
> > Whenever walking such types, any pointers being walked will always yield
> > a SCALAR instead of pointer. In the future we might permit kptr inside
> > local kptr (either kernel or local), and it would be permitted only in
> > that case.
> >
> > For now, these local kptrs will always be referenced in verifier
> > context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> > to such objects, as long fields that are special are not touched
> > (support for which will be added in subsequent patches). Note that once
> > such a local kptr is marked PTR_UNTRUSTED, it is no longer allowed to
> > write to it.
> >
> > No PROBE_MEM handling is therefore done for loads into this type unless
> > PTR_UNTRUSTED is part of the register type, since they can never be in
> > an undefined state, and their lifetime will always be valid.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h              | 28 ++++++++++++++++--------
> >  include/linux/filter.h           |  8 +++----
> >  kernel/bpf/btf.c                 | 16 ++++++++++----
> >  kernel/bpf/verifier.c            | 37 ++++++++++++++++++++++++++------
> >  net/bpf/bpf_dummy_struct_ops.c   | 14 ++++++------
> >  net/core/filter.c                | 34 ++++++++++++-----------------
> >  net/ipv4/bpf_tcp_ca.c            | 13 ++++++-----
> >  net/netfilter/nf_conntrack_bpf.c | 17 ++++++---------
> >  8 files changed, 99 insertions(+), 68 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index afc1c51b59ff..75dbd2ecf80a 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -524,6 +524,11 @@ enum bpf_type_flag {
> >         /* Size is known at compile time. */
> >         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > +       /* MEM is of a type from program BTF, not kernel BTF. This is used to
> > +        * tag PTR_TO_BTF_ID allocated using bpf_obj_new.
> > +        */
> > +       MEM_ALLOC               = BIT(11 + BPF_BASE_TYPE_BITS),
> > +
>
> you fixed one naming confusion with RINGBUF and basically are creating
> a new one, where "ALLOC" means "local kptr"... If we are stuck with
> "local kptr" (which I find very confusing as well, but that's beside
> the point), why not stick to the whole "local" terminology here?
> MEM_LOCAL?
>

See the discussion about this in v4:
https://lore.kernel.org/bpf/20221104075113.5ighwdvero4mugu7@apollo

It was MEM_TYPE_LOCAL before. Also, better naming suggestions are always
welcome, I asked the same in that message as well.

> >         __BPF_TYPE_FLAG_MAX,
> >         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
> >  };
> > @@ -771,6 +776,7 @@ struct bpf_prog_ops {
> >                         union bpf_attr __user *uattr);
> >  };
> >
>
> [...]
>
> > -int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> > -                     const struct btf_type *t, int off, int size,
> > -                     enum bpf_access_type atype __maybe_unused,
> > +int btf_struct_access(struct bpf_verifier_log *log,
> > +                     const struct bpf_reg_state *reg,
> > +                     int off, int size, enum bpf_access_type atype __maybe_unused,
> >                       u32 *next_btf_id, enum bpf_type_flag *flag)
> >  {
> > +       const struct btf *btf = reg->btf;
> >         enum bpf_type_flag tmp_flag = 0;
> > +       const struct btf_type *t;
> > +       u32 id = reg->btf_id;
> >         int err;
> > -       u32 id;
> >
> > +       t = btf_type_by_id(btf, id);
> >         do {
> >                 err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
> >
> >                 switch (err) {
> >                 case WALK_PTR:
> > +                       /* For local types, the destination register cannot
> > +                        * become a pointer again.
> > +                        */
> > +                       if (type_is_local_kptr(reg->type))
> > +                               return SCALAR_VALUE;
>
> passing the entire bpf_reg_state just to differentiate between local
> vs kernel pointer seems like a huge overkill. bpf_reg_state is quite a
> complicated and extensive amount of state, and it seems cleaner to
> just pass it as a flag whether to allow pointer chasing or not. At
> least then we know we only care about that specific aspect, not about
> dozens of other possible fields of bpf_reg_state.
>

I agree that the separation is usually better, especially because this is also a
callback. I don't feel too strong about this though, we certainly do pass the
whole reg to functions which only work on a specific type of pointer. Though the
concern in this case is justified as it's not only an internal function but also
a callback.

It was just a bool in the RFC.
But in https://lore.kernel.org/bpf/20220907233023.x3uclwlnjuhftvtb@macbook-pro-4.dhcp.thefacebook.com
Alexei suggested passing reg instead.
From the link:
> imo it's cleaner to pass 'reg' instead of 'reg->btf',
> so we don't have to pass another boolean.
> And check type_is_local(reg) inside btf_struct_access().
