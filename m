Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D1671180
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 04:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjARDIl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 22:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjARDIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 22:08:38 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32851C4D
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 19:08:26 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id c3so5322993ljh.1
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 19:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt/NFinXeCqS49IKrVARWuoaPBVffqEh8QE5qsQ5J7g=;
        b=qac3T4OTJDZNtfrZzrGAd7p2pCJIG17tqjDOBIlEvQlUGcVfcTgEa4G+SPRUg3eXe0
         EtyqT7RpyQtXEEr566UZ1OaZfDPaVOTnI1pYpSF8rNaIuWW4wKjq0H/xyL75p/TLUUO1
         hlTKW/aJmyh2RuLHvmZkl3XBHp7PNyAUEVt6c9NLimY3vgwzGsBFfuz3ujEG0UvQnRgl
         Lf9Y+wW4UHqAAG2nMIWB5EIC04BbmOr11G7m2OOpH9WPGmwvLdbNDc0FQPy9qTRibAX0
         qSKzmHjdR/s4Azwr107OUWwikRqBI6DgAm6tASaqImWZkl5r0rWW5cAxugAnphhJMLsV
         q9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lt/NFinXeCqS49IKrVARWuoaPBVffqEh8QE5qsQ5J7g=;
        b=rA1cvq+tZsjInbpmn9w4bp4e7KZizImlmTWH8QPj1yRZ4ra93OS1OiwOwNnMLW6F8y
         taECkTSgxzUEi1+NKxc2JTKK8VXHvpEVHoQSHWieuDTdQ/IBDZghx6GxgqwXAAXgwJU8
         k06sdQEz0WkqEemQe8FZg4l3SNg639Hq2LOs4cndi6btQdj1eybw9ewbXxvpzEQlSAyy
         PpQX0Rqon2tuklSn1th/prpORaQ/bB823ohJ2Q2qKAxdqi/xFZwcx0paGvxJpN0CBx1d
         /owam/sn/dCQ7/GrTnGxoTph+mP+J3jhhxZN2Zt0mtXS9bKSfQVx7Opn/BWSjwi2Mb4D
         UIjQ==
X-Gm-Message-State: AFqh2krgscNSYMlQMy1gB+ru4mGPss5yh22qCyeoDop+vGLM6vwGznI8
        ltfX1fPDQYj2zNpdt7tLiiGcAZi3JbFJDPA4QCxj81+4cjo=
X-Google-Smtp-Source: AMrXdXsm+H5ADlb9ST8q40ikTozor3BacynUUl0x1jOpzLEQchLbHOZYVkp9fPiLqgGIG+5SRebL+FO4J5/JvCYLgSc=
X-Received: by 2002:a05:651c:886:b0:28b:63e0:b8d5 with SMTP id
 d6-20020a05651c088600b0028b63e0b8d5mr311533ljq.512.1674011304658; Tue, 17 Jan
 2023 19:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20230112155326.26902-1-laoar.shao@gmail.com> <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
 <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com> <CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com>
In-Reply-To: <CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 18 Jan 2023 11:07:48 +0800
Message-ID: <CALOAHbBVRvTkSxLin+9A20Wv0DZWz4epvNTY1jEaCTf7q0qWJA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] mm, bpf: Add BPF into /proc/meminfo
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Wed, Jan 18, 2023 at 1:25 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 3:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Fri, Jan 13, 2023 at 5:05 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jan 12, 2023 at 7:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > Currently there's no way to get BPF memory usage, while we can only
> > > > estimate the usage by bpftool or memcg, both of which are not reliable.
> > > >
> > > > - bpftool
> > > >   `bpftool {map,prog} show` can show us the memlock of each map and
> > > >   prog, but the memlock is vary from the real memory size. The memlock
> > > >   of a bpf object is approximately
> > > >   `round_up(key_size + value_size, 8) * max_entries`,
> > > >   so 1) it can't apply to the non-preallocated bpf map which may
> > > >   increase or decrease the real memory size dynamically. 2) the element
> > > >   size of some bpf map is not `key_size + value_size`, for example the
> > > >   element size of htab is
> > > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> > > >   That said the differece between these two values may be very great if
> > > >   the key_size and value_size is small. For example in my verifaction,
> > > >   the size of memlock and real memory of a preallocated hash map are,
> > > >
> > > >   $ grep BPF /proc/meminfo
> > > >   BPF:                 350 kB  <<< the size of preallocated memalloc pool
> > > >
> > > >   (create hash map)
> > > >
> > > >   $ bpftool map show
> > > >   41549: hash  name count_map  flags 0x0
> > > >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > > >
> > > >   $ grep BPF /proc/meminfo
> > > >   BPF:               82284 kB
> > > >
> > > >   So the real memory size is $((82284 - 350)) which is 81934 kB
> > > >   while the memlock is only 8192 kB.
> > >
> > > hashmap with key 4b and value 4b looks artificial to me,
> > > but since you're concerned with accuracy of bpftool reporting,
> > > please fix the estimation in bpf_map_memory_footprint().
> >
> > I thought bpf_map_memory_footprint() was deprecated, so I didn't try
> > to fix it before.
>
> It's not deprecated. It's trying to be accurate.
> See bpf_map_value_size().
> In the past we had to be precise when we calculated the required memory
> before we allocated and that was causing ongoing maintenance issues.
> Now bpf_map_memory_footprint() is an estimate for show_fdinfo.
> It can be made more accurate for this map with corner case key/value sizes.
>

Thanks for the clarification.

> > > You're correct that:
> > >
> > > > size of some bpf map is not `key_size + value_size`, for example the
> > > >   element size of htab is
> > > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> > >
> > > So just teach bpf_map_memory_footprint() to do this more accurately.
> > > Add bucket size to it as well.
> > > Make it even more accurate with prealloc vs not.
> > > Much simpler change than adding run-time overhead to every alloc/free
> > > on bpf side.
> > >
> >
> > It seems that we'd better introduce ->memory_footprint for some
> > specific bpf maps. I will think about it.
>
> No. Don't build it into a replica of what we had before.
> Making existing bpf_map_memory_footprint() more accurate.
>

I just don't want to add many if-elses or switch-cases into
bpf_map_memory_footprint(), because I think it is a little ugly.
Introducing a new map ops could make it more clear.  For example,
static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
{
    unsigned long size;

    if (map->ops->map_mem_footprint)
        return map->ops->map_mem_footprint(map);

    size = round_up(map->key_size + bpf_map_value_size(map), 8);
    return round_up(map->max_entries * size, PAGE_SIZE);
}

> > > bpf side tracks all of its allocation. There is no need to do that
> > > in generic mm side.
> > > Exposing an aggregated single number if /proc/meminfo also looks wrong.
> >
> > Do you mean that we shouldn't expose it in /proc/meminfo ?
>
> We should not because it helps one particular use case only.
> Somebody else might want map mem info per container,
> then somebody would need it per user, etc.

It seems we should show memcg info and user info in bpftool map show.

> bpftool map show | awk
> solves all those cases without adding new uapi-s.

Makes sense to me.

-- 
Regards
Yafang
