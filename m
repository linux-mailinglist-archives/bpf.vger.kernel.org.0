Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53C868246A
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 07:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjAaG3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 01:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaG3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 01:29:01 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECF36467
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 22:28:59 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d13so10520778qvj.8
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 22:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OXKnE1Q6JdHrDyzYHAwmA0pvBC/vTqF0R9By7nEYIy8=;
        b=SdZcC9sg9BHuygD51Fl4j+M9bYlSIcsSygDtD6jIfeEM6ygkgHWQU9tybNnifq/TtE
         kGpv6hFqw7G9rLWcYmA/lsWGF1utgZ6MEcP4GB6pq13VdXxmLq3T+Lk/2dGritYxTAtb
         nZgF0fYwYSv06rw+CyBkKdQBpY8t6S/V5VfTtuOxrRxZ+hQfA7+mLMm+NdDpWaS/hwvY
         yd7HrK6TyLsY/hF8xnRrmPl9h+x/JJG63SZT+Xm3jpvgdfhQOM8ViDWhVFeR11hGkZtv
         dnsh58ryEapRJ+55dZ6UpExrMgDtif+4FqNgmcKCn5/E7Fqr1Uvx/nPD8tkGRFyntX2u
         iJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXKnE1Q6JdHrDyzYHAwmA0pvBC/vTqF0R9By7nEYIy8=;
        b=QAKDEKPwQKIoTIH/1mkgJ2Q8sjWZSDlovdxunCnS4Gk+KXEAgMQoLXv8ZyHElKQ63E
         hWLrhGOABVBi7AcR6SXjJLbeGmXxRvWJtgcM1coV2DJzZfg1HTmy5uh7HsD5/c9ito1S
         DxISHey99jJtAxZx/k92SdHWkCFKZFEts3SSl+VHdahr+WezScUF15v2Wim97DyqPyfd
         zVTDWq1Xz0MeiCeGJfV8QawlKAnFeAZ1DT3aleRAyAJDtqTlmOxjLqea5j7lB3ODW37z
         t6hx5MW8NoNRP30szF+Y5Mz9pSjr8clO8X3r0h6A+zJpPWkkgdjG/ltBQDYdVw537r8Y
         MuCQ==
X-Gm-Message-State: AFqh2ko/OaUcYEhLq/XGJeyoCmdYD7doyAZ4PSZhAWM4HJZbZNRBdG48
        PVOIeoosIBeorpj7BWyjbRbtkTDy1jwzq6JIsgo=
X-Google-Smtp-Source: AMrXdXsqE5xOOBm/VB9hw0p4F3n+12UIrKfURK3doyrcCWAv5uwmZkPCnjxgvfD9hipk634TLRTksk3uxGMKUgZRXKc=
X-Received: by 2002:a05:6214:2622:b0:537:2334:7fb3 with SMTP id
 gv2-20020a056214262200b0053723347fb3mr2248442qvb.59.1675146538591; Mon, 30
 Jan 2023 22:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20230112155326.26902-1-laoar.shao@gmail.com> <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
 <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com>
 <CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com>
 <CALOAHbBVRvTkSxLin+9A20Wv0DZWz4epvNTY1jEaCTf7q0qWJA@mail.gmail.com>
 <CAADnVQJtSZWe0sjvA3YT2LPHJyUqDuhG1f62x2PTjB4WMeLsJw@mail.gmail.com>
 <CALOAHbCY4fGyAN6q3dd+hULs3hRJcYgvMR7M5wg1yb3vPiK=mw@mail.gmail.com>
 <CAADnVQJ9-XEz_JdbUWEK5ZdgnidvNcDZcP2jb7ojyEFtPdPMoA@mail.gmail.com>
 <CALOAHbD0u2OPR4psZbtefttyLA8LU5ZzbXoTjbiXaz3wqNGwfw@mail.gmail.com> <Y9fCvZIfvgO+nJ9E@pc636>
In-Reply-To: <Y9fCvZIfvgO+nJ9E@pc636>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 31 Jan 2023 14:28:22 +0800
Message-ID: <CALOAHbB17gTQx4O0+b8oBLQ6ckSFHyS4qwqUn0kXj5U1Wqc3SA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] mm, bpf: Add BPF into /proc/meminfo
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
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

On Mon, Jan 30, 2023 at 9:14 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Sat, Jan 28, 2023 at 07:49:08PM +0800, Yafang Shao wrote:
> > On Thu, Jan 26, 2023 at 1:45 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jan 17, 2023 at 10:49 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > > > I just don't want to add many if-elses or switch-cases into
> > > > > > bpf_map_memory_footprint(), because I think it is a little ugly.
> > > > > > Introducing a new map ops could make it more clear.  For example,
> > > > > > static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
> > > > > > {
> > > > > >     unsigned long size;
> > > > > >
> > > > > >     if (map->ops->map_mem_footprint)
> > > > > >         return map->ops->map_mem_footprint(map);
> > > > > >
> > > > > >     size = round_up(map->key_size + bpf_map_value_size(map), 8);
> > > > > >     return round_up(map->max_entries * size, PAGE_SIZE);
> > > > > > }
> > > > >
> > > > > It is also ugly, because bpf_map_value_size() already has if-stmt.
> > > > > I prefer to keep all estimates in one place.
> > > > > There is no need to be 100% accurate.
> > > >
> > > > Per my investigation, it can be almost accurate with little effort.
> > > > Take the htab for example,
> > > > static unsigned long htab_mem_footprint(const struct bpf_map *map)
> > > > {
> > > >     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> > > >     unsigned long size = 0;
> > > >
> > > >     if (!htab_is_prealloc(htab)) {
> > > >         size += htab_elements_size(htab);
> > > >     }
> > > >     size += kvsize(htab->elems);
> > > >     size += percpu_size(htab->extra_elems);
> > > >     size += kvsize(htab->buckets);
> > > >     size += bpf_mem_alloc_size(&htab->pcpu_ma);
> > > >     size += bpf_mem_alloc_size(&htab->ma);
> > > >     if (htab->use_percpu_counter)
> > > >         size += percpu_size(htab->pcount.counters);
> > > >     size += percpu_size(htab->map_locked[i]) * HASHTAB_MAP_LOCK_COUNT;
> > > >     size += kvsize(htab);
> > > >     return size;
> > > > }
> > >
> > > Please don't.
> > > Above doesn't look maintainable.
> >
> > It is similar to htab_map_free(). These pointers are the pointers
> > which will be freed in map_free().
> > We just need to keep map_mem_footprint() in sync with map_free(). It
> > won't be a problem for maintenance.
> >
> > > Look at kvsize(htab). Do you really care about hundred bytes?
> > > Just accept that there will be a small constant difference
> > > between what show_fdinfo reports and the real memory.
> >
> > The point is we don't have a clear idea what the margin is.
> >
> > > You cannot make it 100%.
> > > There is kfence that will allocate 4k though you asked kmalloc(8).
> > >
> >
> > We already have ksize()[1], which covers the kfence.
> >
> > [1]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/mm/slab_common.c#n1431
> >
> > > > We just need to get the real memory size from the pointer instead of
> > > > calculating the size again.
> > > > For non-preallocated htab, it is a little trouble to get the element
> > > > size (not the unit_size), but it won't be a big deal.
> > >
> > > You'd have to convince mm folks that kvsize() is worth doing.
> > > I don't think it will be easy.
> > >
> >
> > As I mentioned above, we already have ksize(), so we only need to
> > introduce vsize().  Per my understanding, we can simply use
> > vm_struct->size to get the vmalloc size, see also the patch #5 in this
> > patchset[2].
> >
> > Andrew, Uladzislau, Christoph,  do you have any comments on this newly
> > introduced vsize()[2] ?
> >
> > [2]. https://lore.kernel.org/bpf/20230112155326.26902-6-laoar.shao@gmail.com/
> >
> <snip>
> +/* Report full size of underlying allocation of a vmalloc'ed addr */
> +static inline size_t vsize(const void *addr)
> +{
> +       struct vm_struct *area;
> +
> +       if (!addr)
> +               return 0;
> +
> +       area = find_vm_area(addr);
> +       if (unlikely(!area))
> +               return 0;
> +
> +       return area->size;
> +}
> <snip>
>
> You can not access area after the lock is dropped. We do not have any
> ref counters for VA objects. Therefore it should be done like below:
>
>
> <snip>
>   spin_lock(&vmap_area_lock);
>   va = __find_vmap_area(addr, &vmap_area_root);
>   if (va && va->vm)
>     va_size = va->vm->size;
>   spin_unlock(&vmap_area_lock);
>
>   return va_size;
> <snip>
>

Ah, it should take this global lock.  I missed that.
Many thanks for the detailed explanation.

-- 
Regards
Yafang
