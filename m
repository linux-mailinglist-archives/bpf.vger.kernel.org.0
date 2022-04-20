Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE950923B
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382618AbiDTVoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 17:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382628AbiDTVoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 17:44:07 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF44614C
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 14:41:17 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id d9so2807059vsh.10
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oBII489pAxubFq4JfKvzwwABjg5iG2biDKZ3L00PcE=;
        b=mrTAYigfPyD9zpRyZ2Nz6Bn1+5Qr33LnkPjdPQSBy2goxS/7c36HDoKfyXy4XlRhe6
         DAG08rOIs6xOciteyun5OxbW93iuRJ7X+SnZMkHeTzsU2+SVeOrSEQcDG3Ub8Ex0jDLa
         inXThQFQomk5QNpfQuv5hQqc3wLMrNro91jBzx60nnbzyQpXM6fmrusw/eJ3LCTqiEtc
         rsRXqMKSqj0L+elAQ5Br/eZO/hg0Dig3swnNH9NwVyN02m4qNeVEOWJGCZ8YkStOOspY
         6LJ2dRe2NHsr4BvD4S/lwh00HIr2TKSJMd0IDuYX7YGmypqgqXOnFlwFZ0LnpUAeBda1
         e0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oBII489pAxubFq4JfKvzwwABjg5iG2biDKZ3L00PcE=;
        b=JR0AOfS9q8C5zN75upv8y5iKAeoGG2pXn2hQFJaem0oST6PARFqbV5x8T5p4bdAdDh
         tUstkay9ieSPzBYJ2/FMSVRs6oyXP++ROq7/F0wsAyTK4kxb60E1pDpfvLY+ATPcTQ51
         qUQQz1ACGBmTSZRmXLmdp76G6MZYIEjRD6Af6vsDM5rHgChmgIMIjq4hAyKyteNUd+Zp
         C0TE5SZSvQyc8OauOy64ZsHU/+JvAUXXtychUh/UMdEzceKO+E4Q2p5Wo/fi5KkMGCD0
         7cJcQ1I54xC4O9lq8+0/D6PpUNNp9AuzUumkQmV95AJs09yTX9h2NzNfncJQh7VL8210
         E89Q==
X-Gm-Message-State: AOAM533nM3xxURSg8oQ0icnBV4/h+mUD8oCylBQ2R8SJB9S8MICyNtKg
        m+qb/dj/dz3O9BGld17RK5vzlT1rtlKoFkZnek3hi9LO
X-Google-Smtp-Source: ABdhPJzUuYuQMyB8rmV6Xh1wsll+nCIgsrMF0GNCdQqbkMEOFLho6RlTGHvsarhYSryhSwve+73OFwNz7jshcupIg6w=
X-Received: by 2002:a67:fb8b:0:b0:32a:667e:4d1d with SMTP id
 n11-20020a67fb8b000000b0032a667e4d1dmr4333343vsr.39.1650490876573; Wed, 20
 Apr 2022 14:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220416042940.656344-1-kuifeng@fb.com> <20220416042940.656344-2-kuifeng@fb.com>
 <CAEf4BzY3eOOv-4V8npHwJz2NK7HEso7vdS8zQGMfuvw0D8euxQ@mail.gmail.com> <d2ed2fb9c2264cf904505923094d1f9374ac4daa.camel@fb.com>
In-Reply-To: <d2ed2fb9c2264cf904505923094d1f9374ac4daa.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 14:41:05 -0700
Message-ID: <CAEf4BzaaK0mJ7b_SkjoMb6JRfEm-Ho5gkw4i3i+1SDcb9K_hJA@mail.gmail.com>
Subject: Re: [PATCH dwarves v6 1/6] bpf, x86: Generate trampolines from bpf_tramp_links
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, Apr 20, 2022 at 1:17 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Wed, 2022-04-20 at 10:37 -0700, Andrii Nakryiko wrote:
> > On Fri, Apr 15, 2022 at 9:30 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > Replace struct bpf_tramp_progs with struct bpf_tramp_links to
> > > collect
> > > struct bpf_tramp_link(s) for a trampoline.  struct bpf_tramp_link
> > > extends bpf_link to act as a linked list node.
> > >
> > > arch_prepare_bpf_trampoline() accepts a struct bpf_tramp_links to
> > > collects all bpf_tramp_link(s) that a trampoline should call.
> > >
> > > Change BPF trampoline and bpf_struct_ops to pass bpf_tramp_links
> > > instead of bpf_tramp_progs.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c    | 36 +++++++++--------
> > >  include/linux/bpf.h            | 36 +++++++++++------
> > >  include/linux/bpf_types.h      |  1 +
> > >  include/uapi/linux/bpf.h       |  1 +
> > >  kernel/bpf/bpf_struct_ops.c    | 69 ++++++++++++++++++++++--------
> > > --
> > >  kernel/bpf/syscall.c           | 23 ++++-------
> > >  kernel/bpf/trampoline.c        | 73 +++++++++++++++++++-----------
> > > ----
> > >  net/bpf/bpf_dummy_struct_ops.c | 37 ++++++++++++++---
> > >  tools/bpf/bpftool/link.c       |  1 +
> > >  tools/include/uapi/linux/bpf.h |  1 +
> > >  10 files changed, 175 insertions(+), 103 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -385,6 +399,7 @@ static int
> > > bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> > >         for_each_member(i, t, member) {
> > >                 const struct btf_type *mtype, *ptype;
> > >                 struct bpf_prog *prog;
> > > +               struct bpf_tramp_link *link;
> > >                 u32 moff;
> > >
> > >                 moff = __btf_member_bit_offset(t, member) / 8;
> > > @@ -438,16 +453,26 @@ static int
> > > bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> > >                         err = PTR_ERR(prog);
> > >                         goto reset_unlock;
> > >                 }
> > > -               st_map->progs[i] = prog;
> > >
> > >                 if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
> > >                     prog->aux->attach_btf_id != st_ops->type_id ||
> > >                     prog->expected_attach_type != i) {
> > > +                       bpf_prog_put(prog);
> > >                         err = -EINVAL;
> > >                         goto reset_unlock;
> > >                 }
> > >
> > > -               err = bpf_struct_ops_prepare_trampoline(tprogs,
> > > prog,
> > > +               link = kzalloc(sizeof(*link), GFP_USER);
> >
> > seems like you are leaking this link and all the links allocated in
> > previous successful iterations of this loop?
>
> In the block of reset_unlok, it calls bpf_struct_ops_map_put_progs() to
> release all links in st_map including all links of previous iterations.
>
> >
> > > +               if (!link) {
> > > +                       bpf_prog_put(prog);
> > > +                       err = -ENOMEM;
> > > +                       goto reset_unlock;
> > > +               }
> > > +               bpf_link_init(&link->link,
> > > BPF_LINK_TYPE_STRUCT_OPS,
> > > +                             &bpf_struct_ops_link_lops, prog);
> > > +               st_map->links[i] = &link->link;
> > > +
> > > +               err = bpf_struct_ops_prepare_trampoline(tlinks,
> > > link,
> > >                                                         &st_ops-
> > > >func_models[i],
> > >                                                         image,
> > > image_end);
> > >                 if (err < 0)
> > > @@ -490,7 +515,7 @@ static int
> > > bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> > >         memset(uvalue, 0, map->value_size);
> > >         memset(kvalue, 0, map->value_size);
> > >  unlock:
> > > -       kfree(tprogs);
> > > +       kfree(tlinks);
> >
> > so you'll need to free those links inside tlinks (or wherever else
> > they are stored)
>
> All links are in st_maps.
> They will be free by bpf_struct_ops_map_put_progs().
> Does that make sense?

ah, yeah, makes sense. I was wondering how did we miss this in
previous revisions. Great, never mind this issue then.

>
> >
> > >         mutex_unlock(&st_map->lock);
> > >         return err;
> > >  }

[...]
