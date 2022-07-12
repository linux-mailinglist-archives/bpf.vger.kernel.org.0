Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC557290E
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiGLWLQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 18:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiGLWLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 18:11:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F2FC54AC
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 15:11:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b8so7977312pjo.5
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5+SKXw7xQ8pOW3xLBv/UilgsLJssuxU4DHDUS6CbQc=;
        b=M0mF9jUFX4FVreFrTePPsEIkrtpYgoEBr1di/wduOo2KoxQ0jSOypHtBVeXIllLvXn
         yyPgcxKzbCEeqxVvRHjofm7TboLZfOFUWUCMxGANS88cuOSTX+KhXqfzkEMBJ94XciFJ
         8kb53RPFjzoQqA1BFWZzbm63AHFLTzbrgTKJLbN6RFG/ZMI8Bt2tsQTq6EdagRCwbdRz
         WQipvDGM+3aNXKbF7hruJgugaYTATQ0FzpGG38H1dP8ZL1GN+5LTaMHqk7+RFaHwOdx2
         cAICVm2/WKiTIDYmlq1sIjtlvsHcztIzdsF5KzgF+24K6i/Ywiph7L+z+IytXUyXSevg
         MPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5+SKXw7xQ8pOW3xLBv/UilgsLJssuxU4DHDUS6CbQc=;
        b=pG7ELiDKiw14InbGlQjRtnqQVYphZ87k2e11wbKIydBZf4ms8cirr1dsvyeuufh9gQ
         wqf6wX2SZ4/HgpVvoQN8Vtxu+lkLTY5hqKgv+AfigWx6KeKSPHguRKrNDhKn3z7TIrgb
         0buULaHVipgOlxUgVX7fAq8A+TA+mvLxw4MeqjtmymJBWzYHHdG9gQUx6JXj7IXqLe7A
         QRWGznHK+DNVMpNjdW9uiYX0EZE7Xtm9WMhlz2U7plM36UnGxOlUOdH1Uro1pMXAiV2m
         DJBCdRq1+wAtBuDUOPW31JCUoAFECuAhtSUTFi5ennGCLGMCOcrV1Ul+xHDqn1Ie7imx
         7Gog==
X-Gm-Message-State: AJIora8SWFqLPvwCQe7Zt9Cyh9AxZWBAlDos0FDi2K8bHgbCYpsjIVSP
        h/wTq/aq4zm6apBvgfEt+yg4IQFTT7chsxMJuZsg4g==
X-Google-Smtp-Source: AGRyM1tH5qwHM1eKTMf6FAQlhOKEGgTM2L8i+n9p3AUCA/nGBRZblR3qk+QLnYGQJJv4fLafWZ1DTgQJVFrbg1IrbKE=
X-Received: by 2002:a17:902:e746:b0:16c:4eb6:915d with SMTP id
 p6-20020a170902e74600b0016c4eb6915dmr160322plf.106.1657663873107; Tue, 12 Jul
 2022 15:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220711162827.184743-1-roman.gushchin@linux.dev> <CAADnVQ+2Az23WLHj_1pQWYXdd8CbeKooCLrkT_GnzKXV7Yp8hw@mail.gmail.com>
In-Reply-To: <CAADnVQ+2Az23WLHj_1pQWYXdd8CbeKooCLrkT_GnzKXV7Yp8hw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jul 2022 15:11:02 -0700
Message-ID: <CALvZod5uPV9cNKCMjs3HmadVnF--fum5BgG-Zcv1vTM_Bak8hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: reparent bpf maps on memcg offlining
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 2:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 9:28 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > The memory consumed by a mpf map is always accounted to the memory
> > cgroup of the process which created the map. The map can outlive
> > the memory cgroup if it's used by processes in other cgroups or
> > is pinned on bpffs. In this case the map pins the original cgroup
> > in the dying state.
> >
> > For other types of objects (slab objects, non-slab kernel allocations,
> > percpu objects and recently LRU pages) there is a reparenting process
> > implemented: on cgroup offlining charged objects are getting
> > reassigned to the parent cgroup. Because all charges and statistics
> > are fully recursive it's a fairly cheap operation.
> >
> > For efficiency and consistency with other types of objects, let's do
> > the same for bpf maps. Fortunately thanks to the objcg API, the
> > required changes are minimal.
> >
> > Please, note that individual allocations (slabs, percpu and large
> > kmallocs) already have the reparenting mechanism. This commit adds
> > it to the saved map->memcg pointer by replacing it to map->objcg.
> > Because dying cgroups are not visible for a user and all charges are
> > recursive, this commit doesn't bring any behavior changes for a user.
> >
> > v2:
> >   added a missing const qualifier
> >
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  include/linux/bpf.h  |  2 +-
> >  kernel/bpf/syscall.c | 35 +++++++++++++++++++++++++++--------
> >  2 files changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 2b21f2a3452f..85a4db3e0536 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -221,7 +221,7 @@ struct bpf_map {
> >         u32 btf_vmlinux_value_type_id;
> >         struct btf *btf;
> >  #ifdef CONFIG_MEMCG_KMEM
> > -       struct mem_cgroup *memcg;
> > +       struct obj_cgroup *objcg;
> >  #endif
> >         char name[BPF_OBJ_NAME_LEN];
> >         struct bpf_map_off_arr *off_arr;
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index ab688d85b2c6..ef60dbc21b17 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -419,35 +419,52 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
> >  #ifdef CONFIG_MEMCG_KMEM
> >  static void bpf_map_save_memcg(struct bpf_map *map)
> >  {
> > -       map->memcg = get_mem_cgroup_from_mm(current->mm);
> > +       /* Currently if a map is created by a process belonging to the root
> > +        * memory cgroup, get_obj_cgroup_from_current() will return NULL.
> > +        * So we have to check map->objcg for being NULL each time it's
> > +        * being used.
> > +        */
> > +       map->objcg = get_obj_cgroup_from_current();
> >  }
> >
> >  static void bpf_map_release_memcg(struct bpf_map *map)
> >  {
> > -       mem_cgroup_put(map->memcg);
> > +       if (map->objcg)
> > +               obj_cgroup_put(map->objcg);
> > +}
> > +
> > +static struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map) {
> > +       if (map->objcg)
> > +               return get_mem_cgroup_from_objcg(map->objcg);
> > +
> > +       return root_mem_cgroup;
> >  }
> >
> >  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
> >                            int node)
> >  {
> > -       struct mem_cgroup *old_memcg;
> > +       struct mem_cgroup *memcg, *old_memcg;
> >         void *ptr;
> >
> > -       old_memcg = set_active_memcg(map->memcg);
> > +       memcg = bpf_map_get_memcg(map);
> > +       old_memcg = set_active_memcg(memcg);
> >         ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
> >         set_active_memcg(old_memcg);
> > +       mem_cgroup_put(memcg);
>
> Here we might css_put root_mem_cgroup.
> Should we css_get it when returning or
> it's marked as CSS_NO_REF ?
> But mem_cgroup_alloc() doesn't seem to be doing that marking.
> I'm lost at that code.

CSS_NO_REF is set for root_mem_cgroup in cgroup_init_subsys().
