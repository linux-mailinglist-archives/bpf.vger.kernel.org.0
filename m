Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146FE67C463
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 06:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjAZFpa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 00:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjAZFp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 00:45:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3DB1A4AD
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:45:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g11so879538eda.12
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FveYOsiMd65GK7iPAWBv1At230iwf8BEo8Ey5SfPIfA=;
        b=S4Zge+RQuskYZqkxySFtgUSlsG5nE+pHkVlCJvm+DunbEgbf1DdCn+KuImSD/P77bJ
         OKFFrRBlrYOmIQyeyK5yHhE24aJQVGBtkwhkvZMxf8YJhUDYIaGo890FdCXOyM99cG32
         9yMejlNvRNWuxu3IiqNpffGeVE1AFT32cjKClWq6vTK5lM+6C1OzXHamJPzMRQndC4ud
         yg3NpUkhffNvtRwpkKe8CTtvUjU7AHJWqO4Y3eRPdnYfFZt0pU6dt+B3q2wlGHsPeuix
         CGdnK7XMDXSLuMCUPq+QqF7oerp/tgB2tfLqJNge+U4RJkiKhzSkj+yGDxc9xQzE/ZAH
         giAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FveYOsiMd65GK7iPAWBv1At230iwf8BEo8Ey5SfPIfA=;
        b=rq1XBO8+SL3ZcpSgu/8a5nCztbDDcfx/MkLsqG5maNLjBllXG54EUG1J9lcOzv04Qa
         t6A0qBOcbvi5DuHTZerQRiEuDQFNJLoCiEC7bEl+yUokJJqa5/KoY63MmN1g1DoqeeKE
         wjt41CU51Xpnti5THrZrbziqILkaXQmLhGYXMK8ZllvQDH/FL8W13U6hKhbPJucOPb9I
         hvF1tnaNiz2tyYqYGMD/79XM0ZD79lfCZ8o8B0kaKI4iFEerwy57sZs505KDY14NuohL
         6kObuYZmL6Y9tJtLtmH3moSOASsxmS8SEtThTYPKHmKE3EQg6L6CUGG5gNAl0UHf6Fxz
         pLBw==
X-Gm-Message-State: AO0yUKWfctdqoCWvKAg93fmE1uJ6ApAy1vA1KK+TaaTnHKfdwGk3sl1J
        Myzem8oT+ro8tlYIFPwpVFRFXhB5dq3XWvgzjPBfsvr1Ddw=
X-Google-Smtp-Source: AK7set/zeXyIi1LbtXUG86WV+E3vGBPdo2Ey/WKyCNmapGg+3QgWq1reyTaVJ03dDwaMMHNUvMP9+dDzrAmwYEjK8FE=
X-Received: by 2002:aa7:cb8d:0:b0:4a0:b690:8ee7 with SMTP id
 r13-20020aa7cb8d000000b004a0b6908ee7mr549984edt.34.1674711926172; Wed, 25 Jan
 2023 21:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20230112155326.26902-1-laoar.shao@gmail.com> <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
 <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com>
 <CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com>
 <CALOAHbBVRvTkSxLin+9A20Wv0DZWz4epvNTY1jEaCTf7q0qWJA@mail.gmail.com>
 <CAADnVQJtSZWe0sjvA3YT2LPHJyUqDuhG1f62x2PTjB4WMeLsJw@mail.gmail.com> <CALOAHbCY4fGyAN6q3dd+hULs3hRJcYgvMR7M5wg1yb3vPiK=mw@mail.gmail.com>
In-Reply-To: <CALOAHbCY4fGyAN6q3dd+hULs3hRJcYgvMR7M5wg1yb3vPiK=mw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Jan 2023 21:45:14 -0800
Message-ID: <CAADnVQJ9-XEz_JdbUWEK5ZdgnidvNcDZcP2jb7ojyEFtPdPMoA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] mm, bpf: Add BPF into /proc/meminfo
To:     Yafang Shao <laoar.shao@gmail.com>
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
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Jan 17, 2023 at 10:49 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > I just don't want to add many if-elses or switch-cases into
> > > bpf_map_memory_footprint(), because I think it is a little ugly.
> > > Introducing a new map ops could make it more clear.  For example,
> > > static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
> > > {
> > >     unsigned long size;
> > >
> > >     if (map->ops->map_mem_footprint)
> > >         return map->ops->map_mem_footprint(map);
> > >
> > >     size = round_up(map->key_size + bpf_map_value_size(map), 8);
> > >     return round_up(map->max_entries * size, PAGE_SIZE);
> > > }
> >
> > It is also ugly, because bpf_map_value_size() already has if-stmt.
> > I prefer to keep all estimates in one place.
> > There is no need to be 100% accurate.
>
> Per my investigation, it can be almost accurate with little effort.
> Take the htab for example,
> static unsigned long htab_mem_footprint(const struct bpf_map *map)
> {
>     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>     unsigned long size = 0;
>
>     if (!htab_is_prealloc(htab)) {
>         size += htab_elements_size(htab);
>     }
>     size += kvsize(htab->elems);
>     size += percpu_size(htab->extra_elems);
>     size += kvsize(htab->buckets);
>     size += bpf_mem_alloc_size(&htab->pcpu_ma);
>     size += bpf_mem_alloc_size(&htab->ma);
>     if (htab->use_percpu_counter)
>         size += percpu_size(htab->pcount.counters);
>     size += percpu_size(htab->map_locked[i]) * HASHTAB_MAP_LOCK_COUNT;
>     size += kvsize(htab);
>     return size;
> }

Please don't.
Above doesn't look maintainable.
Look at kvsize(htab). Do you really care about hundred bytes?
Just accept that there will be a small constant difference
between what show_fdinfo reports and the real memory.
You cannot make it 100%.
There is kfence that will allocate 4k though you asked kmalloc(8).

> We just need to get the real memory size from the pointer instead of
> calculating the size again.
> For non-preallocated htab, it is a little trouble to get the element
> size (not the unit_size), but it won't be a big deal.

You'd have to convince mm folks that kvsize() is worth doing.
I don't think it will be easy.

> > With a callback devs will start thinking that this is somehow
> > a requirement to report precise memory.
> >
> > > > > > bpf side tracks all of its allocation. There is no need to do that
> > > > > > in generic mm side.
> > > > > > Exposing an aggregated single number if /proc/meminfo also looks wrong.
> > > > >
> > > > > Do you mean that we shouldn't expose it in /proc/meminfo ?
> > > >
> > > > We should not because it helps one particular use case only.
> > > > Somebody else might want map mem info per container,
> > > > then somebody would need it per user, etc.
> > >
> > > It seems we should show memcg info and user info in bpftool map show.
> >
> > Show memcg info? What do you have in mind?
> >
>
> Each bpf map is charged to a memcg. If we know a bpf map belongs to
> which memcg, we can know the map mem info per container.
> Currently we can get the memcg info from the process which loads it,
> but it can't apply to pinned-bpf-map.
> So it would be better if we can show it in bpftool-map-show.

That sounds useful.
Have you looked at bpf iterators and how bpftool is using
them to figure out which process loaded bpf prog and created particular map?
