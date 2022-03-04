Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42EF4CDD6E
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 20:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiCDTys (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 14:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCDTyr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 14:54:47 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EE81C9B5C
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 11:50:03 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id 13so1350316ilq.5
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 11:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZBTNphfaHhZVTqi3GXUcMB6Eq7viceo1VRkv3S8cUU=;
        b=iW/DIJCyQv3qLJJkiOFoKIE6kAfYzY9dUJC+SMGpCaGgvYx83Hn1tpOWmkvo2AZGue
         yY/NPxkhrrtyAC/118in2LFjvvd0khkGCPHSxubBqWimW0TkpCQXcg++2sWimrHEkBqT
         iPKUMAmyZe7a9LNhCbw+8cTclOG2hfADerrbfoGg83ZBBX94BOG4AMdCvb9QNjlpuXwW
         TUnpz6cQh5QX33CCYHUlgNjuVi5mB7ptxRalhJpVNt8NvUhPd4zzOQBoYAKMcQtEvQLy
         axAASkbwl9VwEMnhduRvzUfIxQzDBOgLk/SVrN7xEIbMxJxACTRJGrU22y6kxl1CpdgU
         HIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZBTNphfaHhZVTqi3GXUcMB6Eq7viceo1VRkv3S8cUU=;
        b=Kb2FaCfj5TzLblIVkgSv2fipTS0So3sebdkQC6689/kozGPqajLrePuh6upd2CHNKJ
         9iz/6IKitp8TWL9Wmu/Th7ucvzR1QM6lC9EiB9JYZ4A5rzwXuarxHbpAV1yXCPGAlM6c
         q+IZLY6surmVZZsXD8yMlXRXPt2UQAyLltqmVzAERkY3zERqJP47vOxIzr4XWhOQNe2E
         TeETkH2uqJ/yEK92WlOVwL0HA0aBqatXcvqN7KuqtqIXzFl4jTVGeWK0d+nletfXngbj
         hrzyISrxsi6CXJEmqWh+D2Tm4igO+mcc+jXJcALxpNdDHmI666Uz8N5YaMm6cGWmXn8x
         NgOw==
X-Gm-Message-State: AOAM533MxbxjCpFDJ+1vbOyjeQuJrZjtOgeNetwK1dzoKblEHWVxpnt2
        0igXO1x4Yv2Bn2EWO5uUDM7BLaDDEpTNHUtEp13ryPLh40vaGQ==
X-Google-Smtp-Source: ABdhPJwYSnjUCUxc5D0JN5bpRurU8X3U2nMy3O9GLJ4XTfY2rnj1CihLmXlGBAnws/9sJAlLOafA1qf3Rjrf38elvMI=
X-Received: by 2002:a5e:c648:0:b0:640:bc31:cbec with SMTP id
 s8-20020a5ec648000000b00640bc31cbecmr143573ioo.79.1646422818357; Fri, 04 Mar
 2022 11:40:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
 <CAEf4Bza55GsV1oZa=d9UuscNerMsvFPtXSTQ9qr8mrxPQVu7QA@mail.gmail.com>
 <CAEf4BzbHM_5Ytw=bMbw8Lif+EMyyCmvTRt36DnkGB00+ovX26w@mail.gmail.com> <af229a64d7f64996c75e6406b146ff00df3e9f5a.camel@fb.com>
In-Reply-To: <af229a64d7f64996c75e6406b146ff00df3e9f5a.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Mar 2022 11:40:07 -0800
Message-ID: <CAEf4BzaTLjf+Z51Gx=3MQKUJh2WAEq6o+Ps3KSV4tANK_GECzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 3, 2022 at 11:09 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Wed, 2022-03-02 at 20:34 -0800, Andrii Nakryiko wrote:
> > >
> >
> > forgot to mention, this patch logically probably should go before
> > bpftool changes: 1) define types and APIs in libbpf, and only then 2)
> > "use" those in bpftool
>
> Sure.
>
> > > >
> > > > +struct bpf_sym_skeleton {
> > >
> > > I tried to get used to this "sym" terminology for a bit, but it still
> > > feels off. From user's perspective all this are variables. Any
> > > objections to use "var" terminology?
>
> "var" has a specific meaning in btf and I didn't want to make bpf_var_skeleton
> look related to btf_var for example. Given the extern usage that libs require, I
> figured "sym" would make sense to the user.
>

Even for extern cases, we only generate stuff that really is a
variable. That is, it has allocated memory and there is specific
value. Only .kconfig is like that. .ksyms, for example, doesn't get
any exposure in skeleton as it can't be used from user-space code.

For me, symbol is just way too generic (could be basically anything,
including ELF section symbol, function, etc, etc). But our use case is
always variables available to both user-space and BPF code. I don't
think btf_var vs btf_var_skeleton confusion is significant (and even
then, each extern in .kconfig has corresponding BTF_KIND_VAR, so it
all is in sync).

> If you don't think the confusion with btf_var is significant, I can rename it -
> this is all used by generated code anyway.
>
> > >
> > > > +       const char *name;
> > > > +       const char *section;
> > >
> > > what if we store a pointer to struct bpf_map * instead, that way we
> > > won't need to search, we'll just have a pointer ready
>
> We'd have to search *somewhere*. I'd rather have the search inside libbpf than
> inside the generated code. Besides, finding the right bpf_map from within the
> subskeleton is pretty annoying - you'll have to do suffix searches on the
> bpf_map names in the passed-in bpf_object and codegening all that is unnecessary
> when libbpf can look at real_name.

I think you misunderstood what I proposed. There is no explicit
searching. Here is a simple example of sub-skeleton struct and how
code-generated code will fill it out


struct my_subskel {
    struct {
        struct bpf_map *my_map;
    } maps;
    struct my_subskel__data {
        int *my_var;
    } data;
};


/* in codegen'ed code */

struct my_subskel *s;

subskel->syms[0].name = "my_var";
subskel->syms[0].map = &s->maps.data_syn;


It's similar in principle to how we define maps (that are found and
filled out by libbpf):

        s->maps[4].name = ".data.dyn";
        s->maps[4].map = &obj->maps.data_dyn;
        s->maps[4].mmaped = (void **)&obj->data_dyn;


Except in this case we use &s->maps.data_syn for reading, not for
writing into it.

Hope this is clearer now.


>
> >
>
> Thanks,
> Delyan
