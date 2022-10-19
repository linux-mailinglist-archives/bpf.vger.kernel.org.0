Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036FA604C78
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiJSP5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJSP4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 11:56:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9C4CA17
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 08:54:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g27so25915273edf.11
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naAYSdhhUeje/zKI19ihnf7MnVJBpBxlAGYpRn2m0uM=;
        b=GU59KAXZCaVWlBKPWo+4cebZiSUCaPspknqAPtghcJzf3pSvlmkrunb/d+YF5sOP1X
         Pf0N8ooUBcnmwCVsBLmZqcXik3n1EwSIn++7XKgoMigLTVRO2iCF6d/VP11+l7VdSpfo
         QMNDssGXegyJr+E2MtdWNxPYOvVktXo8wWIhETxbQIAEkzam5FOQ+dloWnvMH4mLElvA
         l2A36YBZdJpVf9VhdscybkaloT+Jrth+iTHg2gOudYhlARjTzPZLfD61p99x3fZPEJXQ
         SZHkq+P7a3HDc7NvvJSQZ6dBOrV/Xch6o3dbj7I8kDF1lkwjSBWL5zOx2LPvAsEs0W+e
         lZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naAYSdhhUeje/zKI19ihnf7MnVJBpBxlAGYpRn2m0uM=;
        b=Sd0joUOUAtd2A+yhOmPPOQWgDqENZeha+f7fdU9L+ABfmgh96wx6tI7HDh5guuAQAL
         61i8XpactiZziRlJDlWBUoqGSPaLOu06Nus1t6LCI6yKSWIVVofo7lfAdZxpyJAXjxMs
         dIKz5+Y/eAuh2/GNDq40E/wqg5zkMZe53+xxuhuVQUs8gtBajzCkgWYx8y0+td+Pl09T
         apaxqq5v1Ie6ueyWtTXrw2h1EKmA0zBy9gi/awTeiWnjRgc0tWmGuhJwpkYnkkM/vZFe
         el2UUdMBc6e7pYDortQxDnTuXAD06BGYk0zq/Hf7Kt48adBFZ+nhqj86e1Nw3KFx/WxV
         VDFw==
X-Gm-Message-State: ACrzQf2rHx4WGHv0ebAFvXb+WVBgwcoNOa+PECOSNfP43+HlItm+G5fD
        lqDEtCbZc9AwVpvIhwp0lU5PIiIjkJHTqw1cgrA=
X-Google-Smtp-Source: AMsMyM5YDyIqQvJ+8BM3qdZ4mlZfXPmCl0rsREpELBeAEqC9i1JDlCQtYlXFx95LTPX8VhJCN+foq+8/lDyMBRPNywI=
X-Received: by 2002:a05:6402:168c:b0:458:5b8b:afd2 with SMTP id
 a12-20020a056402168c00b004585b8bafd2mr8015780edv.357.1666194869455; Wed, 19
 Oct 2022 08:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221013062303.896469-1-memxor@gmail.com> <20221013062303.896469-7-memxor@gmail.com>
 <20221019013526.ziiksjif63frt6nn@macbook-pro-4.dhcp.thefacebook.com> <20221019054257.ly6eoskl7xjgayao@apollo>
In-Reply-To: <20221019054257.ly6eoskl7xjgayao@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 08:54:18 -0700
Message-ID: <CAADnVQLfhOJhqVuwSFaRyFxdxSo_j2hKnuWmLUKEEG2DJeh3_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/25] bpf: Refactor kptr_off_tab into fields_tab
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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

On Tue, Oct 18, 2022 at 10:43 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 07:05:26AM IST, Alexei Starovoitov wrote:
> > On Thu, Oct 13, 2022 at 11:52:44AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > To prepare the BPF verifier to handle special fields in both map values
> > > and program allocated types coming from program BTF, we need to refactor
> > > the kptr_off_tab handling code into something more generic and reusable
> > > across both cases to avoid code duplication.
> > >
> > > Later patches also require passing this data to helpers at runtime, so
> > > that they can work on user defined types, initialize them, destruct
> > > them, etc.
> > >
> > > The main observation is that both map values and such allocated types
> > > point to a type in program BTF, hence they can be handled similarly. We
> > > can prepare a field metadata table for both cases and store them in
> > > struct bpf_map or struct btf depending on the use case.
> > >
> > > Hence, refactor the code into generic btf_type_fields and btf_field
> > > member structs. The btf_type_fields represents the fields of a specific
> > > btf_type in user BTF. The cnt indicates the number of special fields we
> > > successfully recognized, and field_mask is a bitmask of fields that were
> > > found, to enable quick determination of availability of a certain field.
> > >
> > > Subsequently, refactor the rest of the code to work with these generic
> > > types, remove assumptions about kptr and kptr_off_tab, rename variables
> > > to more meaningful names, etc.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h     | 103 +++++++++++++-------
> > >  include/linux/btf.h     |   4 +-
> > >  kernel/bpf/arraymap.c   |  13 ++-
> > >  kernel/bpf/btf.c        |  64 ++++++-------
> > >  kernel/bpf/hashtab.c    |  14 ++-
> > >  kernel/bpf/map_in_map.c |  13 ++-
> > >  kernel/bpf/syscall.c    | 203 +++++++++++++++++++++++-----------------
> > >  kernel/bpf/verifier.c   |  96 ++++++++++---------
> > >  8 files changed, 289 insertions(+), 221 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 9e7d46d16032..25e77a172d7c 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -164,35 +164,41 @@ struct bpf_map_ops {
> > >  };
> > >
> > >  enum {
> > > -   /* Support at most 8 pointers in a BPF map value */
> > > -   BPF_MAP_VALUE_OFF_MAX = 8,
> > > -   BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
> > > +   /* Support at most 8 pointers in a BTF type */
> > > +   BTF_FIELDS_MAX        = 8,
> > > +   BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX +
> > >                             1 + /* for bpf_spin_lock */
> > >                             1,  /* for bpf_timer */
> > >  };
> > >
> > > -enum bpf_kptr_type {
> > > -   BPF_KPTR_UNREF,
> > > -   BPF_KPTR_REF,
> > > +enum btf_field_type {
> > > +   BPF_KPTR_UNREF = (1 << 2),
> > > +   BPF_KPTR_REF   = (1 << 3),
> > > +   BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
> > >  };
> > >
> > > -struct bpf_map_value_off_desc {
> > > +struct btf_field_kptr {
> > > +   struct btf *btf;
> > > +   struct module *module;
> > > +   btf_dtor_kfunc_t dtor;
> > > +   u32 btf_id;
> > > +};
> > > +
> > > +struct btf_field {
> > >     u32 offset;
> > > -   enum bpf_kptr_type type;
> > > -   struct {
> > > -           struct btf *btf;
> > > -           struct module *module;
> > > -           btf_dtor_kfunc_t dtor;
> > > -           u32 btf_id;
> > > -   } kptr;
> > > +   enum btf_field_type type;
> > > +   union {
> > > +           struct btf_field_kptr kptr;
> > > +   };
> > >  };
> > >
> > > -struct bpf_map_value_off {
> > > -   u32 nr_off;
> > > -   struct bpf_map_value_off_desc off[];
> > > +struct btf_type_fields {
> >
> > How about btf_record instead ?
> > Then btf_type_fields_has_field() will become btf_record_has_field() ?
> >
>
> I guess btf_record is ok. I thought of just making it btf_fields, but then
> bpf_map_free_fields (for freeing this struct) and bpf_obj_free_fields (for
> freeing actual fields of object) gets confusing.
>
> Or to be more precise I could name the struct btf_type_record,
> but the member variable record in all places.

What "_type_" prefix adds to btf_record ?

btf already has Type in the abbrev.

And from the other email:

> I agree, what do you think of calling it btf_type_has_field? You pass > in the
> btf_type_record and the field type.

btf_type_has_field doesn't sound right.
