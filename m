Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0A680E9C
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 14:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjA3NO4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 08:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbjA3NOo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 08:14:44 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8910611678
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 05:14:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gr7so6985743ejb.5
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 05:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4ot21tosj26w8vKX0wsIMvfJKyxg9HzLw84nCxBKGg=;
        b=EKmBfppr0esgDRuegyVD3n2yyRvfuYd5Nped5CfdnHnqqYSnKps3uax0Bot5kLLs5w
         gZChFUP2B3jyhtloZiwtXwwyxDITDbN2ai4gaRcIAVWghKsTQYuibmQQYAsQy+R9f/EM
         KE0PHzgVpgmdLCyQEJ9j0EJ+NEVc56/CTcMihGPaLni2qNAWMamgUpoKFTl4Wq1FwqlX
         Y4xGUr+6Dq9d/R7EQcrN6jAmjgxX68P+y9B2Xq62tJAMFyPv+bvOZ/eEDFA5AHY3rw9A
         MjUXv1e9laY19kcBUssY/KDjuPC1s+NwNWARHTS6SQqBccvCdUgLpwVKYayeyMt6Ea3P
         0JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4ot21tosj26w8vKX0wsIMvfJKyxg9HzLw84nCxBKGg=;
        b=u9dgaDChgJl4XawXh9P3tKPfN2aH1CGz5Lc6pESFqS3hcVlHVwj55TtYaPjhkj1XAw
         lTT7/2ZD9+T4dJwy2LaPqvOJnN/yF3je7GFjOMevVtLTQ9XzcAunjF4YBtECOcCrkdSr
         Y43cOBwaT+/hDCaLyGSNsP9SddTYqOLnBW5nV/20sxvl/nL1JaACa6Y1qOVOjjc3V6gE
         hc98qhDIEXWYs9wv6yvCnEo+dWeub61ChOHWn/xei8PUhR84h8HlBhlhdw0jNUyiiie4
         0WGHgooYMCGR22QUrxZrcX1u9N6OB5fYLCHDMAFcdR9hLU3TcLa/r1puyB2FUEuwQn8s
         3wtQ==
X-Gm-Message-State: AFqh2krMqnyr8C/ZN4EERqF5776sJkcBWDHaRHa2zZVqubLuRd7CdjrB
        ZOWwVxBXLQwO9ZApmtF/VN4=
X-Google-Smtp-Source: AMrXdXtn867dZ1QBqxXMOyN/Cfjr+lRRofBOeP0nBDbtTactpQJ4lkld7omxhBbX2ue8m/LACIr1vA==
X-Received: by 2002:a17:907:a2cb:b0:871:dd2:4af0 with SMTP id re11-20020a170907a2cb00b008710dd24af0mr59836135ejc.26.1675084481825;
        Mon, 30 Jan 2023 05:14:41 -0800 (PST)
Received: from pc636 (host-78-79-169-126.mobileonline.telia.com. [78.79.169.126])
        by smtp.gmail.com with ESMTPSA id q5-20020a1709060f8500b00883ec4c63ddsm3552862ejj.146.2023.01.30.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 05:14:41 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 30 Jan 2023 14:14:37 +0100
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
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
Subject: Re: [RFC PATCH bpf-next v2 00/11] mm, bpf: Add BPF into /proc/meminfo
Message-ID: <Y9fCvZIfvgO+nJ9E@pc636>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
 <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
 <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com>
 <CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com>
 <CALOAHbBVRvTkSxLin+9A20Wv0DZWz4epvNTY1jEaCTf7q0qWJA@mail.gmail.com>
 <CAADnVQJtSZWe0sjvA3YT2LPHJyUqDuhG1f62x2PTjB4WMeLsJw@mail.gmail.com>
 <CALOAHbCY4fGyAN6q3dd+hULs3hRJcYgvMR7M5wg1yb3vPiK=mw@mail.gmail.com>
 <CAADnVQJ9-XEz_JdbUWEK5ZdgnidvNcDZcP2jb7ojyEFtPdPMoA@mail.gmail.com>
 <CALOAHbD0u2OPR4psZbtefttyLA8LU5ZzbXoTjbiXaz3wqNGwfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbD0u2OPR4psZbtefttyLA8LU5ZzbXoTjbiXaz3wqNGwfw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 28, 2023 at 07:49:08PM +0800, Yafang Shao wrote:
> On Thu, Jan 26, 2023 at 1:45 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jan 17, 2023 at 10:49 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > > I just don't want to add many if-elses or switch-cases into
> > > > > bpf_map_memory_footprint(), because I think it is a little ugly.
> > > > > Introducing a new map ops could make it more clear.  For example,
> > > > > static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
> > > > > {
> > > > >     unsigned long size;
> > > > >
> > > > >     if (map->ops->map_mem_footprint)
> > > > >         return map->ops->map_mem_footprint(map);
> > > > >
> > > > >     size = round_up(map->key_size + bpf_map_value_size(map), 8);
> > > > >     return round_up(map->max_entries * size, PAGE_SIZE);
> > > > > }
> > > >
> > > > It is also ugly, because bpf_map_value_size() already has if-stmt.
> > > > I prefer to keep all estimates in one place.
> > > > There is no need to be 100% accurate.
> > >
> > > Per my investigation, it can be almost accurate with little effort.
> > > Take the htab for example,
> > > static unsigned long htab_mem_footprint(const struct bpf_map *map)
> > > {
> > >     struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> > >     unsigned long size = 0;
> > >
> > >     if (!htab_is_prealloc(htab)) {
> > >         size += htab_elements_size(htab);
> > >     }
> > >     size += kvsize(htab->elems);
> > >     size += percpu_size(htab->extra_elems);
> > >     size += kvsize(htab->buckets);
> > >     size += bpf_mem_alloc_size(&htab->pcpu_ma);
> > >     size += bpf_mem_alloc_size(&htab->ma);
> > >     if (htab->use_percpu_counter)
> > >         size += percpu_size(htab->pcount.counters);
> > >     size += percpu_size(htab->map_locked[i]) * HASHTAB_MAP_LOCK_COUNT;
> > >     size += kvsize(htab);
> > >     return size;
> > > }
> >
> > Please don't.
> > Above doesn't look maintainable.
> 
> It is similar to htab_map_free(). These pointers are the pointers
> which will be freed in map_free().
> We just need to keep map_mem_footprint() in sync with map_free(). It
> won't be a problem for maintenance.
> 
> > Look at kvsize(htab). Do you really care about hundred bytes?
> > Just accept that there will be a small constant difference
> > between what show_fdinfo reports and the real memory.
> 
> The point is we don't have a clear idea what the margin is.
> 
> > You cannot make it 100%.
> > There is kfence that will allocate 4k though you asked kmalloc(8).
> >
> 
> We already have ksize()[1], which covers the kfence.
> 
> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/mm/slab_common.c#n1431
> 
> > > We just need to get the real memory size from the pointer instead of
> > > calculating the size again.
> > > For non-preallocated htab, it is a little trouble to get the element
> > > size (not the unit_size), but it won't be a big deal.
> >
> > You'd have to convince mm folks that kvsize() is worth doing.
> > I don't think it will be easy.
> >
> 
> As I mentioned above, we already have ksize(), so we only need to
> introduce vsize().  Per my understanding, we can simply use
> vm_struct->size to get the vmalloc size, see also the patch #5 in this
> patchset[2].
> 
> Andrew, Uladzislau, Christoph,  do you have any comments on this newly
> introduced vsize()[2] ?
> 
> [2]. https://lore.kernel.org/bpf/20230112155326.26902-6-laoar.shao@gmail.com/
> 
<snip>
+/* Report full size of underlying allocation of a vmalloc'ed addr */
+static inline size_t vsize(const void *addr)
+{
+	struct vm_struct *area;
+
+	if (!addr)
+		return 0;
+
+	area = find_vm_area(addr);
+	if (unlikely(!area))
+		return 0;
+
+	return area->size;
+}
<snip>

You can not access area after the lock is dropped. We do not have any
ref counters for VA objects. Therefore it should be done like below:


<snip>
  spin_lock(&vmap_area_lock);
  va = __find_vmap_area(addr, &vmap_area_root);
  if (va && va->vm)
    va_size = va->vm->size;
  spin_unlock(&vmap_area_lock);

  return va_size;
<snip>

--
Uladzislau Rezki
