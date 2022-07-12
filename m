Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C85728C9
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 23:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiGLVtJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 17:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiGLVtI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 17:49:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E033349;
        Tue, 12 Jul 2022 14:49:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x91so11818753ede.1;
        Tue, 12 Jul 2022 14:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYcUu+Nac0EZ/s/dRYU8//7b3MQ6hceTXfmqbMGiXaI=;
        b=UU910ZgfWPltn8ULdLJFeYyuVW172DNR+7v58YGsvAt+Fuh9/tREG9DVLbn8vrijO0
         a5mUXTvSvDV9YP2D5HD5PtyqW/Xbl2wPuCRRO9DN91CE+TY+VfqbE/io/8ZY1ltIkBcU
         98wU76x6GY9Hv3ho39pF/jSkrcLTnADdmoEttYCprWM+3J/x014hJpTjKjNEM07wuee/
         w4YoT6DexJP3UgkCo7QRavu/Iw34UIJCJqTl11TeYIda8WaUj7tx+6ci4KbX400Yu+eX
         MTehzQvy9C+Tzw8tkgUreII4SGAyufLnJ+5K54tvq+ZBVefqlhfN0/IXgMVd0DkZOuMR
         70Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYcUu+Nac0EZ/s/dRYU8//7b3MQ6hceTXfmqbMGiXaI=;
        b=bu/LAeO3i66AIB5fcCsCvGF8w7h1uBe2FHn8bU/CuX1549yLoZ6nHyYuIzvp4aHRlq
         +fVPbaZH5loK22X4vAR1861QkeRZh7AShZZch/Kmc958D3tamIhOutPfX8G728K0YR74
         qbs11NkJlWwh8doxCd0EYGGyfXKPtPp4JKxnTrVvDhlGNysxCFZt0xIMUaCe8q63pMFm
         zw6GZ+jFInkr6bKWGncEa8RAwqqbYimwuUUmkvAZ5d1gymbfDmr+jTCKQSbxtPVkR8R6
         cIawnZfdc69IIrdkynyGoanIWyE2eGd+2/ZpXJu/a00NWkSV8qUp9a1HZ/Z8LQnZ3zIA
         R/CQ==
X-Gm-Message-State: AJIora8yx3vPeUbbDT+/7eOqJrXIYkAZRB13Gjj2BJ9xEew0YRJPbuqf
        izPcX5u6E7Rh86qxaFThzjLMOdjX5MQCJu5ygcQ=
X-Google-Smtp-Source: AGRyM1vw+y4X6f2u2kTWA81r9BYdIMNeGURE7ZMLBg4Z9+Q2ryd68bsUS/hQZYBur97iXSOKA9jXQr6RyXfzp1ehFso=
X-Received: by 2002:a05:6402:350c:b0:43a:e25f:d73 with SMTP id
 b12-20020a056402350c00b0043ae25f0d73mr318533edd.66.1657662545870; Tue, 12 Jul
 2022 14:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220711162827.184743-1-roman.gushchin@linux.dev>
In-Reply-To: <20220711162827.184743-1-roman.gushchin@linux.dev>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Jul 2022 14:48:54 -0700
Message-ID: <CAADnVQ+2Az23WLHj_1pQWYXdd8CbeKooCLrkT_GnzKXV7Yp8hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: reparent bpf maps on memcg offlining
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     bpf <bpf@vger.kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 9:28 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> The memory consumed by a mpf map is always accounted to the memory
> cgroup of the process which created the map. The map can outlive
> the memory cgroup if it's used by processes in other cgroups or
> is pinned on bpffs. In this case the map pins the original cgroup
> in the dying state.
>
> For other types of objects (slab objects, non-slab kernel allocations,
> percpu objects and recently LRU pages) there is a reparenting process
> implemented: on cgroup offlining charged objects are getting
> reassigned to the parent cgroup. Because all charges and statistics
> are fully recursive it's a fairly cheap operation.
>
> For efficiency and consistency with other types of objects, let's do
> the same for bpf maps. Fortunately thanks to the objcg API, the
> required changes are minimal.
>
> Please, note that individual allocations (slabs, percpu and large
> kmallocs) already have the reparenting mechanism. This commit adds
> it to the saved map->memcg pointer by replacing it to map->objcg.
> Because dying cgroups are not visible for a user and all charges are
> recursive, this commit doesn't bring any behavior changes for a user.
>
> v2:
>   added a missing const qualifier
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/bpf.h  |  2 +-
>  kernel/bpf/syscall.c | 35 +++++++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2b21f2a3452f..85a4db3e0536 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -221,7 +221,7 @@ struct bpf_map {
>         u32 btf_vmlinux_value_type_id;
>         struct btf *btf;
>  #ifdef CONFIG_MEMCG_KMEM
> -       struct mem_cgroup *memcg;
> +       struct obj_cgroup *objcg;
>  #endif
>         char name[BPF_OBJ_NAME_LEN];
>         struct bpf_map_off_arr *off_arr;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ab688d85b2c6..ef60dbc21b17 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -419,35 +419,52 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
>  #ifdef CONFIG_MEMCG_KMEM
>  static void bpf_map_save_memcg(struct bpf_map *map)
>  {
> -       map->memcg = get_mem_cgroup_from_mm(current->mm);
> +       /* Currently if a map is created by a process belonging to the root
> +        * memory cgroup, get_obj_cgroup_from_current() will return NULL.
> +        * So we have to check map->objcg for being NULL each time it's
> +        * being used.
> +        */
> +       map->objcg = get_obj_cgroup_from_current();
>  }
>
>  static void bpf_map_release_memcg(struct bpf_map *map)
>  {
> -       mem_cgroup_put(map->memcg);
> +       if (map->objcg)
> +               obj_cgroup_put(map->objcg);
> +}
> +
> +static struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map) {
> +       if (map->objcg)
> +               return get_mem_cgroup_from_objcg(map->objcg);
> +
> +       return root_mem_cgroup;
>  }
>
>  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
>                            int node)
>  {
> -       struct mem_cgroup *old_memcg;
> +       struct mem_cgroup *memcg, *old_memcg;
>         void *ptr;
>
> -       old_memcg = set_active_memcg(map->memcg);
> +       memcg = bpf_map_get_memcg(map);
> +       old_memcg = set_active_memcg(memcg);
>         ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
>         set_active_memcg(old_memcg);
> +       mem_cgroup_put(memcg);

Here we might css_put root_mem_cgroup.
Should we css_get it when returning or
it's marked as CSS_NO_REF ?
But mem_cgroup_alloc() doesn't seem to be doing that marking.
I'm lost at that code.
