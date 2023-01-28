Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93267F7A5
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 12:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjA1Ltr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 06:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjA1Ltq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 06:49:46 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C723650
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 03:49:45 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id q10so5727213qvt.10
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePpzN6qRFIEbKg9D3BVBzunxUucei+EPla7AGvFoiyA=;
        b=AcLZflbFD5YHqYSEh1R1kZ9nXNMTRunbGDaR+QGVZByhqbEAhhoUZieUdfCfs4M7cs
         GvBJXkzVg/NUXTDG3S+87xG0CQgqj113CVZGKvANKckhp47yfytuLxsLTuPqgB0L1RSQ
         jFp8Wjq3dmpybwYNY65IOp84Lthlef2CaQDIttQwRgz2F9Z6bOmxGH7dLWLMLaCGjhd1
         vJdOorFPPG4EMASqzW2Es71tqpsbxbx3Se/Ox5ypJ23xVSom0WVTSC8CONl6FWMMcqeu
         FDvLLsXI2rHMOEzKy9ybdwcZr2V2Zo0+mBGg0WOAFok1Ai79SHblk3tLtacNdKyMgUS8
         F2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePpzN6qRFIEbKg9D3BVBzunxUucei+EPla7AGvFoiyA=;
        b=mKpn3dDtXeeBpSr83yBxEAd/mlk4VVKIOiE8DS2AuAS7ydtrFDarjxRuzZOIEgDOw9
         W0No/uciHUeqd0Xr6ye/JFC8qql3GKnQzqDp7zy8vVEEax5cByIyBltFEjkoKQsrsYOq
         tLZvT1BQqi1x4NwXL2p37YDjEmJ0DTMngRF3buRnuwko/tp0CRHrF8LrilNPvdaygqIk
         g9MYRZ6guQMopEloOv07hegnsiA9Eg7f3JnNzmNRrw0H5gOSMGLM08iqmN/NWEOF2MC3
         6K8zEIwRUC2TYsoQfLmwEegF8qHrOkpEu3IVsorYmPgPLwDGiPrQgeQFIGs8SxhxIQRn
         eXCQ==
X-Gm-Message-State: AO0yUKVrOvJftl+o21rhiJG5QFfJAwl931Yfrcjjj8X+uwslF5NB75Yb
        druLduuh1Oroutifn9T8FrO06cr6g/CVd5rLv0I=
X-Google-Smtp-Source: AK7set9rMswu63KF4x1RGdf3cnOhRrW9s4JWqiyE3fCHaI98pkqMvJ/fyjdYQxXknuxk4i4QTsehIERQ+ZFi37sWpec=
X-Received: by 2002:a0c:fe8e:0:b0:538:887f:be54 with SMTP id
 d14-20020a0cfe8e000000b00538887fbe54mr426983qvs.104.1674906584929; Sat, 28
 Jan 2023 03:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20230112155326.26902-1-laoar.shao@gmail.com> <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
 <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com>
 <CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com>
 <CALOAHbBVRvTkSxLin+9A20Wv0DZWz4epvNTY1jEaCTf7q0qWJA@mail.gmail.com>
 <CAADnVQJtSZWe0sjvA3YT2LPHJyUqDuhG1f62x2PTjB4WMeLsJw@mail.gmail.com>
 <CALOAHbCY4fGyAN6q3dd+hULs3hRJcYgvMR7M5wg1yb3vPiK=mw@mail.gmail.com> <CAADnVQJ9-XEz_JdbUWEK5ZdgnidvNcDZcP2jb7ojyEFtPdPMoA@mail.gmail.com>
In-Reply-To: <CAADnVQJ9-XEz_JdbUWEK5ZdgnidvNcDZcP2jb7ojyEFtPdPMoA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 28 Jan 2023 19:49:08 +0800
Message-ID: <CALOAHbD0u2OPR4psZbtefttyLA8LU5ZzbXoTjbiXaz3wqNGwfw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] mm, bpf: Add BPF into /proc/meminfo
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        Christoph Hellwig <hch@infradead.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Tejun Heo <tj@kernel.org>, dennis@kernel.org,
        Chris Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
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

On Thu, Jan 26, 2023 at 1:45 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 17, 2023 at 10:49 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > I just don't want to add many if-elses or switch-cases into
> > > > bpf_map_memory_footprint(), because I think it is a little ugly.
> > > > Introducing a new map ops could make it more clear.  For example,
> > > > static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
> > > > {
> > > >     unsigned long size;
> > > >
> > > >     if (map->ops->map_mem_footprint)
> > > >         return map->ops->map_mem_footprint(map);
> > > >
> > > >     size = round_up(map->key_size + bpf_map_value_size(map), 8);
> > > >     return round_up(map->max_entries * size, PAGE_SIZE);
> > > > }
> > >
> > > It is also ugly, because bpf_map_value_size() already has if-stmt.
> > > I prefer to keep all estimates in one place.
> > > There is no need to be 100% accurate.
> >
> > Per my investigation, it can be almost accurate with little effort.
> > Take the htab for example,
> > static unsigned long htab_mem_footprint(const struct bpf_map *map)
> > {
> >     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> >     unsigned long size = 0;
> >
> >     if (!htab_is_prealloc(htab)) {
> >         size += htab_elements_size(htab);
> >     }
> >     size += kvsize(htab->elems);
> >     size += percpu_size(htab->extra_elems);
> >     size += kvsize(htab->buckets);
> >     size += bpf_mem_alloc_size(&htab->pcpu_ma);
> >     size += bpf_mem_alloc_size(&htab->ma);
> >     if (htab->use_percpu_counter)
> >         size += percpu_size(htab->pcount.counters);
> >     size += percpu_size(htab->map_locked[i]) * HASHTAB_MAP_LOCK_COUNT;
> >     size += kvsize(htab);
> >     return size;
> > }
>
> Please don't.
> Above doesn't look maintainable.

It is similar to htab_map_free(). These pointers are the pointers
which will be freed in map_free().
We just need to keep map_mem_footprint() in sync with map_free(). It
won't be a problem for maintenance.

> Look at kvsize(htab). Do you really care about hundred bytes?
> Just accept that there will be a small constant difference
> between what show_fdinfo reports and the real memory.

The point is we don't have a clear idea what the margin is.

> You cannot make it 100%.
> There is kfence that will allocate 4k though you asked kmalloc(8).
>

We already have ksize()[1], which covers the kfence.

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/mm/slab_common.c#n1431

> > We just need to get the real memory size from the pointer instead of
> > calculating the size again.
> > For non-preallocated htab, it is a little trouble to get the element
> > size (not the unit_size), but it won't be a big deal.
>
> You'd have to convince mm folks that kvsize() is worth doing.
> I don't think it will be easy.
>

As I mentioned above, we already have ksize(), so we only need to
introduce vsize().  Per my understanding, we can simply use
vm_struct->size to get the vmalloc size, see also the patch #5 in this
patchset[2].

Andrew, Uladzislau, Christoph,  do you have any comments on this newly
introduced vsize()[2] ?

[2]. https://lore.kernel.org/bpf/20230112155326.26902-6-laoar.shao@gmail.com/

> > > With a callback devs will start thinking that this is somehow
> > > a requirement to report precise memory.
> > >
> > > > > > > bpf side tracks all of its allocation. There is no need to do that
> > > > > > > in generic mm side.
> > > > > > > Exposing an aggregated single number if /proc/meminfo also looks wrong.
> > > > > >
> > > > > > Do you mean that we shouldn't expose it in /proc/meminfo ?
> > > > >
> > > > > We should not because it helps one particular use case only.
> > > > > Somebody else might want map mem info per container,
> > > > > then somebody would need it per user, etc.
> > > >
> > > > It seems we should show memcg info and user info in bpftool map show.
> > >
> > > Show memcg info? What do you have in mind?
> > >
> >
> > Each bpf map is charged to a memcg. If we know a bpf map belongs to
> > which memcg, we can know the map mem info per container.
> > Currently we can get the memcg info from the process which loads it,
> > but it can't apply to pinned-bpf-map.
> > So it would be better if we can show it in bpftool-map-show.
>
> That sounds useful.
> Have you looked at bpf iterators and how bpftool is using
> them to figure out which process loaded bpf prog and created particular map?

Yes, I have looked at it.  I know what you mean. It seems we can
introduce a memcg_iter or something else to implement it.

-- 
Regards
Yafang
