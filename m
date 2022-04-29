Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1673A5141AC
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 07:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbiD2FFZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiD2FFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 01:05:23 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1CE53A73
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 22:02:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y11so3310156ilp.4
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 22:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+Bmxk2IAMXeVTesPFjOtn8QXeMSZNtPo2ofMvnKPE8=;
        b=g357iiSHm4JaBehSwCEDK+vrckhCEFev3KZdXOIaRL8Jo3JEIqeqK4y77giKksf3Bx
         HCZGBjtUs4NNeBJzZBhUZzpAf1J6b0/SOFXcOILIEbWeBD6jK5+NOSHRX2WutG4Imyoe
         9sekVx4hyCISiLThUueXOesTnvClAFXByvhnk5klCgxyLtisIs0xHar1eiSqHT17mZU9
         hdVfcyWolprbOTVk9ZWtrX67um6d3G6czQUj0IOU5fBLc6h3hL9h20F/hBhHqaLhNSgj
         4x5yCfoWCG5tFDf3BMzew4G8W982FxYxwpSIn4IjJkhYpi6AlnhspI1VPyI77ikWAA1r
         ND7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+Bmxk2IAMXeVTesPFjOtn8QXeMSZNtPo2ofMvnKPE8=;
        b=n2Fiai8P/HU6At0vbC22mJrt0edNN6T4nQmuvyyMGOnfXBurUgnADohvsoZrKUNkY4
         SpFXFCviObsBhfKZZ7pZeNKkFiz4WDCEFsoeMPvuDR3opLM7MQzRCdaLyOoLclh5LeNY
         ve/VAyCAxX+AEoax3PyPD6XjlwSyNtW6Yy1DcSbNSgzSrveK/VgWcn4OlEZze6qFWDdO
         gBIS2DJHwdmNEmzG8Xh7a0rGmNq2jnCol2uWkhtKOr7pFnBsU/LYhRJlnKpGtejfXPIi
         Ol3grAi8ujyIY4Sd36D53ecFWGObtuJei4IUI9qomon43wLiTOdw8oVXVNF+EElhJNJ8
         40DA==
X-Gm-Message-State: AOAM5303V2AM+4akHqWarsQPNDcE36dz6Jr1xswodng5VcuiBSX2FG0N
        Ah9rF0UDA6xT9hYTNnTf3hqq/zIm6/ekQ9WT4a4=
X-Google-Smtp-Source: ABdhPJxgvMb6rijrBxoTPj9bL2DtPwhMb+gm22Ugjm591xJp30gJpWkLtcPlr85g2pIfQd2XNFWlys9PWR8IkqKAObc=
X-Received: by 2002:a05:6e02:1b89:b0:2cd:942d:86e3 with SMTP id
 h9-20020a056e021b8900b002cd942d86e3mr9976877ili.71.1651208525753; Thu, 28 Apr
 2022 22:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220416042940.656344-1-kuifeng@fb.com> <20220416042940.656344-2-kuifeng@fb.com>
 <CAEf4BzY3eOOv-4V8npHwJz2NK7HEso7vdS8zQGMfuvw0D8euxQ@mail.gmail.com> <4e289d04fe799edbbcf5653f4f70883246ff2f8a.camel@fb.com>
In-Reply-To: <4e289d04fe799edbbcf5653f4f70883246ff2f8a.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Apr 2022 22:01:54 -0700
Message-ID: <CAEf4BzaYEXmKx9vmN4UxGz53CPu1ZadQ=RErJZa5ytT8dB5ZDw@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 6:52 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
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
> >
> > >         mutex_unlock(&st_map->lock);
> > >         return err;
> > >  }
> > > @@ -545,9 +570,9 @@ static void bpf_struct_ops_map_free(struct
> > > bpf_map *map)
> > >  {
> > >         struct bpf_struct_ops_map *st_map = (struct
> > > bpf_struct_ops_map *)map;
> > >
> > > -       if (st_map->progs)
> > > +       if (st_map->links)
> > >                 bpf_struct_ops_map_put_progs(st_map);
> > > -       bpf_map_area_free(st_map->progs);
> > > +       bpf_map_area_free(st_map->links);
> > >         bpf_jit_free_exec(st_map->image);
> > >         bpf_map_area_free(st_map->uvalue);
> > >         bpf_map_area_free(st_map);
> >
> > [...]
> >
> > > @@ -105,10 +120,20 @@ int bpf_struct_ops_test_run(struct bpf_prog
> > > *prog, const union bpf_attr *kattr,
> > >         }
> > >         set_vm_flush_reset_perms(image);
> > >
> > > +       link = kzalloc(sizeof(*link), GFP_USER);
> > > +       if (!link) {
> > > +               err = -ENOMEM;
> > > +               goto out;
> > > +       }
> > > +       /* prog doesn't take the ownership of the reference from
> > > caller */
> > > +       bpf_prog_inc(prog);
> > > +       bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
> > > &bpf_struct_ops_link_lops, prog);
> > > +
> > >         op_idx = prog->expected_attach_type;
> > > -       err = bpf_struct_ops_prepare_trampoline(tprogs, prog,
> > > +       err = bpf_struct_ops_prepare_trampoline(tlinks, link,
> > >                                                 &st_ops-
> > > >func_models[op_idx],
> > >                                                 image, image +
> > > PAGE_SIZE);
> > > +
> >
> > nit: no need for extra empty line here
> >
> > >         if (err < 0)
> > >                 goto out;
> > >
> > > @@ -124,7 +149,9 @@ int bpf_struct_ops_test_run(struct bpf_prog
> > > *prog, const union bpf_attr *kattr,
> > >  out:
> > >         kfree(args);
> > >         bpf_jit_free_exec(image);
> > > -       kfree(tprogs);
> > > +       if (link)
> > > +               bpf_link_put(&link->link);
> >
> > you never to bpf_link_prime() and bpf_link_settle() for these "pseudo
> > links" for struct_ops, so there is no need for bpf_link_put(), it can
> > be just bpf_link_free(), right?
>
> Just realize that bpf_link_free() is a static function of
> bpf/syscall.c.  And, this code is for testing only.  So, I don't touch
> this line.
>

we can make it non-static and expose along with other generic bpf_link
internal APIs, like bpf_link_cleanup()

> >
> > > +       kfree(tlinks);
> > >         return err;
> > >  }
> > >
> > > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > > index 8fb0116f9136..6353a789322b 100644
> > > --- a/tools/bpf/bpftool/link.c
> > > +++ b/tools/bpf/bpftool/link.c
> > > @@ -23,6 +23,7 @@ static const char * const link_type_name[] = {
> > >         [BPF_LINK_TYPE_XDP]                     = "xdp",
> > >         [BPF_LINK_TYPE_PERF_EVENT]              = "perf_event",
> > >         [BPF_LINK_TYPE_KPROBE_MULTI]            = "kprobe_multi",
> > > +       [BPF_LINK_TYPE_STRUCT_OPS]               = "struct_ops",
> > >  };
> > >
> > >  static struct hashmap *link_table;
> > > diff --git a/tools/include/uapi/linux/bpf.h
> > > b/tools/include/uapi/linux/bpf.h
> > > index d14b10b85e51..a4f557338af7 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -1013,6 +1013,7 @@ enum bpf_link_type {
> > >         BPF_LINK_TYPE_XDP = 6,
> > >         BPF_LINK_TYPE_PERF_EVENT = 7,
> > >         BPF_LINK_TYPE_KPROBE_MULTI = 8,
> > > +       BPF_LINK_TYPE_STRUCT_OPS = 9,
> > >
> > >         MAX_BPF_LINK_TYPE,
> > >  };
> > > --
> > > 2.30.2
> > >
>
