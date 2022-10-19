Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEB605441
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 01:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJSX5o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 19:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJSX5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 19:57:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE521849A5
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:57:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h13so18716985pfr.7
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UT+6LdRJgEoToATdSFv3ttQV3xqMeQKxnhJmDPSaO8g=;
        b=CX6NKgRPtHmyH+weSlodtqKTjp3kbZEcCMrV7PqW+gST6IsWEKh2Wu5tHdy7Zk42QZ
         wp+V75juysbtOCH1vekCJT+gjRIMaTTtEyIrdad3bLKyEDyfDZdAcK3GQolxVHvjJLHu
         yf+JJIvlMYhSQKp9AQP3ec5a4gNOoNpyjtFtxYmMC4TMbcJQtrJKJAErV7Qfy1Z5L7MN
         LzXVYGR1xH4C2q2+0O4WH57Gz+96W/SCTRKrpjXnG6FZGP/daUmbfP7NgWHY2zHij6K5
         ZhrslyN6r+56bFpI5zEIgJ4cwBbgjHDgJhnyZRADNieUYa4hrzJq0U7DhiMko7ZtHWdA
         OxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT+6LdRJgEoToATdSFv3ttQV3xqMeQKxnhJmDPSaO8g=;
        b=QX2dFo6cGKVmIe8XoeKc26DRi8qZeGl7aI53ILSbrtB1ezZo+qnJEECAwoHJoJLFok
         ZKDNQHio6ESj5X6Mevte8F5SqFG0ZjcoYLBM1BcE74+Qjh+ik8NezsjkJC/5pferaetM
         mrCrOxEeug+pTcAJRfUsSTe8UZnthlj2Bm45gZ2j2Etv4LOVZNZ//5Rlh1QkJkROWPdM
         jUlfgsfJfdyN18WcbX5sU6zu55jBEG0cFp1sG5OOX70y0IvyJd57PBtX/DzmwT/slBv/
         FXGPI7gXBlJF7qC8oJZqGoXu+5n56QgG8n/8NB2GBoVeyaq27GJByTJ+RxQw2xFGuA9d
         onAQ==
X-Gm-Message-State: ACrzQf2jgFlCXc2Vjz+1ptxidQlHm7n6XgKGFkbehaG5oPPyOAV9F7IU
        g1oDyCl1rTtnBeo+aW9JDDY=
X-Google-Smtp-Source: AMsMyM6sqbOlNQAsod84HqGNV7g+zyu6uUONokqUzaD+HTDMjJU0Q2ImVPMSucS8FQZ6ABqpOCvzTw==
X-Received: by 2002:a05:6a00:2491:b0:565:998b:90ac with SMTP id c17-20020a056a00249100b00565998b90acmr11392470pfv.65.1666223862065;
        Wed, 19 Oct 2022 16:57:42 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902714500b00178323e689fsm11263314plm.171.2022.10.19.16.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:57:41 -0700 (PDT)
Date:   Thu, 20 Oct 2022 05:27:30 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 06/25] bpf: Refactor kptr_off_tab into
 fields_tab
Message-ID: <20221019235730.lxmiii2fbzcuieub@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-7-memxor@gmail.com>
 <20221019013526.ziiksjif63frt6nn@macbook-pro-4.dhcp.thefacebook.com>
 <20221019054257.ly6eoskl7xjgayao@apollo>
 <CAADnVQLfhOJhqVuwSFaRyFxdxSo_j2hKnuWmLUKEEG2DJeh3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLfhOJhqVuwSFaRyFxdxSo_j2hKnuWmLUKEEG2DJeh3_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 09:24:18PM IST, Alexei Starovoitov wrote:
> On Tue, Oct 18, 2022 at 10:43 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, Oct 19, 2022 at 07:05:26AM IST, Alexei Starovoitov wrote:
> > > On Thu, Oct 13, 2022 at 11:52:44AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > To prepare the BPF verifier to handle special fields in both map values
> > > > and program allocated types coming from program BTF, we need to refactor
> > > > the kptr_off_tab handling code into something more generic and reusable
> > > > across both cases to avoid code duplication.
> > > >
> > > > Later patches also require passing this data to helpers at runtime, so
> > > > that they can work on user defined types, initialize them, destruct
> > > > them, etc.
> > > >
> > > > The main observation is that both map values and such allocated types
> > > > point to a type in program BTF, hence they can be handled similarly. We
> > > > can prepare a field metadata table for both cases and store them in
> > > > struct bpf_map or struct btf depending on the use case.
> > > >
> > > > Hence, refactor the code into generic btf_type_fields and btf_field
> > > > member structs. The btf_type_fields represents the fields of a specific
> > > > btf_type in user BTF. The cnt indicates the number of special fields we
> > > > successfully recognized, and field_mask is a bitmask of fields that were
> > > > found, to enable quick determination of availability of a certain field.
> > > >
> > > > Subsequently, refactor the rest of the code to work with these generic
> > > > types, remove assumptions about kptr and kptr_off_tab, rename variables
> > > > to more meaningful names, etc.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  include/linux/bpf.h     | 103 +++++++++++++-------
> > > >  include/linux/btf.h     |   4 +-
> > > >  kernel/bpf/arraymap.c   |  13 ++-
> > > >  kernel/bpf/btf.c        |  64 ++++++-------
> > > >  kernel/bpf/hashtab.c    |  14 ++-
> > > >  kernel/bpf/map_in_map.c |  13 ++-
> > > >  kernel/bpf/syscall.c    | 203 +++++++++++++++++++++++-----------------
> > > >  kernel/bpf/verifier.c   |  96 ++++++++++---------
> > > >  8 files changed, 289 insertions(+), 221 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 9e7d46d16032..25e77a172d7c 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -164,35 +164,41 @@ struct bpf_map_ops {
> > > >  };
> > > >
> > > >  enum {
> > > > -   /* Support at most 8 pointers in a BPF map value */
> > > > -   BPF_MAP_VALUE_OFF_MAX = 8,
> > > > -   BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
> > > > +   /* Support at most 8 pointers in a BTF type */
> > > > +   BTF_FIELDS_MAX        = 8,
> > > > +   BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX +
> > > >                             1 + /* for bpf_spin_lock */
> > > >                             1,  /* for bpf_timer */
> > > >  };
> > > >
> > > > -enum bpf_kptr_type {
> > > > -   BPF_KPTR_UNREF,
> > > > -   BPF_KPTR_REF,
> > > > +enum btf_field_type {
> > > > +   BPF_KPTR_UNREF = (1 << 2),
> > > > +   BPF_KPTR_REF   = (1 << 3),
> > > > +   BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
> > > >  };
> > > >
> > > > -struct bpf_map_value_off_desc {
> > > > +struct btf_field_kptr {
> > > > +   struct btf *btf;
> > > > +   struct module *module;
> > > > +   btf_dtor_kfunc_t dtor;
> > > > +   u32 btf_id;
> > > > +};
> > > > +
> > > > +struct btf_field {
> > > >     u32 offset;
> > > > -   enum bpf_kptr_type type;
> > > > -   struct {
> > > > -           struct btf *btf;
> > > > -           struct module *module;
> > > > -           btf_dtor_kfunc_t dtor;
> > > > -           u32 btf_id;
> > > > -   } kptr;
> > > > +   enum btf_field_type type;
> > > > +   union {
> > > > +           struct btf_field_kptr kptr;
> > > > +   };
> > > >  };
> > > >
> > > > -struct bpf_map_value_off {
> > > > -   u32 nr_off;
> > > > -   struct bpf_map_value_off_desc off[];
> > > > +struct btf_type_fields {
> > >
> > > How about btf_record instead ?
> > > Then btf_type_fields_has_field() will become btf_record_has_field() ?
> > >
> >
> > I guess btf_record is ok. I thought of just making it btf_fields, but then
> > bpf_map_free_fields (for freeing this struct) and bpf_obj_free_fields (for
> > freeing actual fields of object) gets confusing.
> >
> > Or to be more precise I could name the struct btf_type_record,
> > but the member variable record in all places.
>
> What "_type_" prefix adds to btf_record ?
>
> btf already has Type in the abbrev.
>

Well, it's the record of a btf_type, so btf_type_record.

> And from the other email:
>
> > I agree, what do you think of calling it btf_type_has_field? You pass > in the
> > btf_type_record and the field type.
>
> btf_type_has_field doesn't sound right.

Ok, let's go with just the btf_record naming.
