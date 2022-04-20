Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0EB508EA1
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 19:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiDTRk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiDTRk2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 13:40:28 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EFA46B37
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:37:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h4so1446059ilq.8
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vdvp64F2iwSRIttzBPFoc5b8g1fN+safhnILDg9IuGI=;
        b=JltZRM+rUKG6oh0Bz6Zg2le2z7NfjIS4cdFJ0UslHobDvDH6xBJJkl6L7ztfyvCyqs
         vWgNcxmi7Lo8bZghYVnfhvLJ6GOEi5a1zjJOD2+3PSzueSQFzVJ52pIIJyraZuv6MEJG
         0DVzs1lQyz/eSyV7/OJIKZYc7jN022QqqAlQSzRJFXXZqyOYLJnrKddZM+iyc/q0aPRw
         Hj5wWsG04nsVw3oKpzMA6MuguWRMz0TDJ31fCRiuYaK6ghqGf01tmQXlu+2h8aUzsJ+s
         kHzIb5r3gZLgeg1SYziQFeRJs8Y5FlEHj5CA9y7cn3/VmcVkSTn1abh0ze9nCBQmZ6is
         zT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vdvp64F2iwSRIttzBPFoc5b8g1fN+safhnILDg9IuGI=;
        b=8OUgR41HMPGfGNMCCKMKrfEICc/zbGlIgwh9Jo57WDE8mGdpVVYOjW1PT8LQDsIcrh
         m0HVuGF6WJQFlPAbAWK7YNKxsbRzndiSooIZQIYrTUBSYQekoZwVYxJJSxXOY0Seitnw
         PIw/bTgbO/iyYL49ssw5RtxvQH1SmDcZ6fvCJvSwZN/pd5PDqruu3ROs2VOcMPyxP8a9
         47WJ09ezGDjl/j425/hdOyjf92Zxg2qEwV4YJoRP5dFZgAN2lyUIYEkKdO7HN51dRD3J
         RiMO5xKz3mNkVuyYCXO4nijRmSNOhu+N/juAg9sTpmRHTS6YcaVfNPVB0OGJrshdnpOa
         DFzw==
X-Gm-Message-State: AOAM531+BREw/pwddPviJTR/YCKlNQtcqyZTWW6hZnLvKv13JwSvDqaD
        xxnhnFaKtq142ur/1gmLRirmHc2MT+JgNXe4a2DncAL/PTQ=
X-Google-Smtp-Source: ABdhPJx4f0QITCbwq+lkWeUd3yMhnPXBmdhS4HnATqX+y/qfb4F/2n9XkDZxEesXk67dk/D3mTfgY7zJYiv8VB571bo=
X-Received: by 2002:a92:cd83:0:b0:2cc:1a66:6435 with SMTP id
 r3-20020a92cd83000000b002cc1a666435mr7475794ilb.252.1650476260994; Wed, 20
 Apr 2022 10:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220416042940.656344-1-kuifeng@fb.com> <20220416042940.656344-2-kuifeng@fb.com>
In-Reply-To: <20220416042940.656344-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 10:37:30 -0700
Message-ID: <CAEf4BzY3eOOv-4V8npHwJz2NK7HEso7vdS8zQGMfuvw0D8euxQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v6 1/6] bpf, x86: Generate trampolines from bpf_tramp_links
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Apr 15, 2022 at 9:30 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Replace struct bpf_tramp_progs with struct bpf_tramp_links to collect
> struct bpf_tramp_link(s) for a trampoline.  struct bpf_tramp_link
> extends bpf_link to act as a linked list node.
>
> arch_prepare_bpf_trampoline() accepts a struct bpf_tramp_links to
> collects all bpf_tramp_link(s) that a trampoline should call.
>
> Change BPF trampoline and bpf_struct_ops to pass bpf_tramp_links
> instead of bpf_tramp_progs.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    | 36 +++++++++--------
>  include/linux/bpf.h            | 36 +++++++++++------
>  include/linux/bpf_types.h      |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/bpf_struct_ops.c    | 69 ++++++++++++++++++++++----------
>  kernel/bpf/syscall.c           | 23 ++++-------
>  kernel/bpf/trampoline.c        | 73 +++++++++++++++++++---------------
>  net/bpf/bpf_dummy_struct_ops.c | 37 ++++++++++++++---
>  tools/bpf/bpftool/link.c       |  1 +
>  tools/include/uapi/linux/bpf.h |  1 +
>  10 files changed, 175 insertions(+), 103 deletions(-)
>

[...]

> @@ -385,6 +399,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>         for_each_member(i, t, member) {
>                 const struct btf_type *mtype, *ptype;
>                 struct bpf_prog *prog;
> +               struct bpf_tramp_link *link;
>                 u32 moff;
>
>                 moff = __btf_member_bit_offset(t, member) / 8;
> @@ -438,16 +453,26 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>                         err = PTR_ERR(prog);
>                         goto reset_unlock;
>                 }
> -               st_map->progs[i] = prog;
>
>                 if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
>                     prog->aux->attach_btf_id != st_ops->type_id ||
>                     prog->expected_attach_type != i) {
> +                       bpf_prog_put(prog);
>                         err = -EINVAL;
>                         goto reset_unlock;
>                 }
>
> -               err = bpf_struct_ops_prepare_trampoline(tprogs, prog,
> +               link = kzalloc(sizeof(*link), GFP_USER);

seems like you are leaking this link and all the links allocated in
previous successful iterations of this loop?

> +               if (!link) {
> +                       bpf_prog_put(prog);
> +                       err = -ENOMEM;
> +                       goto reset_unlock;
> +               }
> +               bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
> +                             &bpf_struct_ops_link_lops, prog);
> +               st_map->links[i] = &link->link;
> +
> +               err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>                                                         &st_ops->func_models[i],
>                                                         image, image_end);
>                 if (err < 0)
> @@ -490,7 +515,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>         memset(uvalue, 0, map->value_size);
>         memset(kvalue, 0, map->value_size);
>  unlock:
> -       kfree(tprogs);
> +       kfree(tlinks);

so you'll need to free those links inside tlinks (or wherever else
they are stored)

>         mutex_unlock(&st_map->lock);
>         return err;
>  }
> @@ -545,9 +570,9 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>  {
>         struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
>
> -       if (st_map->progs)
> +       if (st_map->links)
>                 bpf_struct_ops_map_put_progs(st_map);
> -       bpf_map_area_free(st_map->progs);
> +       bpf_map_area_free(st_map->links);
>         bpf_jit_free_exec(st_map->image);
>         bpf_map_area_free(st_map->uvalue);
>         bpf_map_area_free(st_map);

[...]

> @@ -105,10 +120,20 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>         }
>         set_vm_flush_reset_perms(image);
>
> +       link = kzalloc(sizeof(*link), GFP_USER);
> +       if (!link) {
> +               err = -ENOMEM;
> +               goto out;
> +       }
> +       /* prog doesn't take the ownership of the reference from caller */
> +       bpf_prog_inc(prog);
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog);
> +
>         op_idx = prog->expected_attach_type;
> -       err = bpf_struct_ops_prepare_trampoline(tprogs, prog,
> +       err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>                                                 &st_ops->func_models[op_idx],
>                                                 image, image + PAGE_SIZE);
> +

nit: no need for extra empty line here

>         if (err < 0)
>                 goto out;
>
> @@ -124,7 +149,9 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>  out:
>         kfree(args);
>         bpf_jit_free_exec(image);
> -       kfree(tprogs);
> +       if (link)
> +               bpf_link_put(&link->link);

you never to bpf_link_prime() and bpf_link_settle() for these "pseudo
links" for struct_ops, so there is no need for bpf_link_put(), it can
be just bpf_link_free(), right?

> +       kfree(tlinks);
>         return err;
>  }
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 8fb0116f9136..6353a789322b 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -23,6 +23,7 @@ static const char * const link_type_name[] = {
>         [BPF_LINK_TYPE_XDP]                     = "xdp",
>         [BPF_LINK_TYPE_PERF_EVENT]              = "perf_event",
>         [BPF_LINK_TYPE_KPROBE_MULTI]            = "kprobe_multi",
> +       [BPF_LINK_TYPE_STRUCT_OPS]               = "struct_ops",
>  };
>
>  static struct hashmap *link_table;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index d14b10b85e51..a4f557338af7 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1013,6 +1013,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_XDP = 6,
>         BPF_LINK_TYPE_PERF_EVENT = 7,
>         BPF_LINK_TYPE_KPROBE_MULTI = 8,
> +       BPF_LINK_TYPE_STRUCT_OPS = 9,
>
>         MAX_BPF_LINK_TYPE,
>  };
> --
> 2.30.2
>
