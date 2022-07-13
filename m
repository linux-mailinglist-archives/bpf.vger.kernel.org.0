Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711A572B3C
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 04:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiGMCPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 22:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiGMCPA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 22:15:00 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1773761D72;
        Tue, 12 Jul 2022 19:14:59 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:13:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657678497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d3ZWU/BSJQ8KaUrQyBtjftgf/8Wn3DQWN5MEjZ2mDVs=;
        b=Tck2SANcnLqLDykX8OugLEEXRUSNr75MjIrc5U1/4fbr2atgS5nKAB0ycOzOYHMEjJG8vh
        g+VrB4n0kR8v1/qvZeaoXBJSTYVZhcA0jKYPuhBe7yCnx109y4DIYa8Uw/ALWYmFfFGZrF
        3JRVjjLe5NAy3xFuit9ZvrLSGPPN1NU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: reparent bpf maps on memcg offlining
Message-ID: <Ys4qYsCozq0zF9n/@castle>
References: <20220711162827.184743-1-roman.gushchin@linux.dev>
 <CAADnVQ+2Az23WLHj_1pQWYXdd8CbeKooCLrkT_GnzKXV7Yp8hw@mail.gmail.com>
 <CALvZod5uPV9cNKCMjs3HmadVnF--fum5BgG-Zcv1vTM_Bak8hw@mail.gmail.com>
 <CAADnVQJPm13Mu_XMyzsYk40eW-4CPKWF52LkwwJTJhA6OyJT+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJPm13Mu_XMyzsYk40eW-4CPKWF52LkwwJTJhA6OyJT+g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 03:15:27PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 12, 2022 at 3:11 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Tue, Jul 12, 2022 at 2:49 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 11, 2022 at 9:28 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > >
> > > > The memory consumed by a mpf map is always accounted to the memory
> > > > cgroup of the process which created the map. The map can outlive
> > > > the memory cgroup if it's used by processes in other cgroups or
> > > > is pinned on bpffs. In this case the map pins the original cgroup
> > > > in the dying state.
> > > >
> > > > For other types of objects (slab objects, non-slab kernel allocations,
> > > > percpu objects and recently LRU pages) there is a reparenting process
> > > > implemented: on cgroup offlining charged objects are getting
> > > > reassigned to the parent cgroup. Because all charges and statistics
> > > > are fully recursive it's a fairly cheap operation.
> > > >
> > > > For efficiency and consistency with other types of objects, let's do
> > > > the same for bpf maps. Fortunately thanks to the objcg API, the
> > > > required changes are minimal.
> > > >
> > > > Please, note that individual allocations (slabs, percpu and large
> > > > kmallocs) already have the reparenting mechanism. This commit adds
> > > > it to the saved map->memcg pointer by replacing it to map->objcg.
> > > > Because dying cgroups are not visible for a user and all charges are
> > > > recursive, this commit doesn't bring any behavior changes for a user.
> > > >
> > > > v2:
> > > >   added a missing const qualifier
> > > >
> > > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > > ---
> > > >  include/linux/bpf.h  |  2 +-
> > > >  kernel/bpf/syscall.c | 35 +++++++++++++++++++++++++++--------
> > > >  2 files changed, 28 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 2b21f2a3452f..85a4db3e0536 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -221,7 +221,7 @@ struct bpf_map {
> > > >         u32 btf_vmlinux_value_type_id;
> > > >         struct btf *btf;
> > > >  #ifdef CONFIG_MEMCG_KMEM
> > > > -       struct mem_cgroup *memcg;
> > > > +       struct obj_cgroup *objcg;
> > > >  #endif
> > > >         char name[BPF_OBJ_NAME_LEN];
> > > >         struct bpf_map_off_arr *off_arr;
> > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > index ab688d85b2c6..ef60dbc21b17 100644
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -419,35 +419,52 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
> > > >  #ifdef CONFIG_MEMCG_KMEM
> > > >  static void bpf_map_save_memcg(struct bpf_map *map)
> > > >  {
> > > > -       map->memcg = get_mem_cgroup_from_mm(current->mm);
> > > > +       /* Currently if a map is created by a process belonging to the root
> > > > +        * memory cgroup, get_obj_cgroup_from_current() will return NULL.
> > > > +        * So we have to check map->objcg for being NULL each time it's
> > > > +        * being used.
> > > > +        */
> > > > +       map->objcg = get_obj_cgroup_from_current();
> > > >  }
> > > >
> > > >  static void bpf_map_release_memcg(struct bpf_map *map)
> > > >  {
> > > > -       mem_cgroup_put(map->memcg);
> > > > +       if (map->objcg)
> > > > +               obj_cgroup_put(map->objcg);
> > > > +}
> > > > +
> > > > +static struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map) {
> > > > +       if (map->objcg)
> > > > +               return get_mem_cgroup_from_objcg(map->objcg);
> > > > +
> > > > +       return root_mem_cgroup;
> > > >  }
> > > >
> > > >  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
> > > >                            int node)
> > > >  {
> > > > -       struct mem_cgroup *old_memcg;
> > > > +       struct mem_cgroup *memcg, *old_memcg;
> > > >         void *ptr;
> > > >
> > > > -       old_memcg = set_active_memcg(map->memcg);
> > > > +       memcg = bpf_map_get_memcg(map);
> > > > +       old_memcg = set_active_memcg(memcg);
> > > >         ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
> > > >         set_active_memcg(old_memcg);
> > > > +       mem_cgroup_put(memcg);
> > >
> > > Here we might css_put root_mem_cgroup.
> > > Should we css_get it when returning or
> > > it's marked as CSS_NO_REF ?
> > > But mem_cgroup_alloc() doesn't seem to be doing that marking.
> > > I'm lost at that code.
> >
> > CSS_NO_REF is set for root_mem_cgroup in cgroup_init_subsys().

Yeah, the root cgroups can't be deleted so we save on the refcounting.
> 
> Ahh. I see that
> css = ss->css_alloc(NULL); css->flags |= CSS_NO_REF; now.
> Thanks.

Thanks for applying the patch!
