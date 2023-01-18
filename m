Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B506671341
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 06:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjARFjd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 00:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARFjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 00:39:32 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674453565
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 21:39:31 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vw16so17420257ejc.12
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 21:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sCkYNjQz0eVYQeRBw5clOPzwavuUa2lDilvlVQo0adk=;
        b=R6diirM1lvUNsgA39gpKs4Y4vTaMcG3TsP8XXw0chXTsUUeDehamB/6IRhUACT873E
         9nHXHgqyGH9kEwk2bfaSb27Q0vvkBqI7gyBGuwXGaTN5FKh+8ZGH0QFLsahRjezh/J9y
         /cAFIzszaPpHpFGm9qRL0zZ8wx9OHIiy/enrz+WnDW0PZOGVT/2G99WZkv85n/LIvuyp
         LMwkpw5FdZ/MN0meUGBPIwSqbHOONk/vTpiSGTPKIQIJf99XSwkShRYJ+H0eXtkjmrg9
         zzobkdu+5WoJTGGplWQiVIcWjR0Jzis5VQjfOqJhEjBdUwmAqMIlLdxuYfTwE5Y204pF
         czXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCkYNjQz0eVYQeRBw5clOPzwavuUa2lDilvlVQo0adk=;
        b=qKcmGEc2t8yi06uP89lJ2qzx0Q4oR1wNdzNTSZu2GtbmqcfYkzmvDcbvPPf0yaiDX7
         tWPeUj4sf/iutWaHGpUVt59qdfMz6NyMwv8WWrBaICpJWSrMckn7CBigbi4AJBiQKV/0
         f2gwtNvgqVMln18cHjWHg9PJ6O7NGPwjmxLSSVxQV8gvuDRRNi9E1UP9quzVM6UvGZMN
         Gb18nEu0TYAfDCGg0vQhK5YPr4yS2/ZRhqyW3fCAW7bRRmOGNv7937xTeMTedkAaL20P
         SR00tCLUcXYXOjmplPnBp5XtZaiOAWvZk6voDkvIuE+rQRqCKNlZm33osvjPHmQtqPtG
         Ozsg==
X-Gm-Message-State: AFqh2kpyo021b0+NadfVFN9NV/Awk6nl2PVqKdYHDprMg5NvrHk8Bxnd
        rU3zkZ4I7S1W1/xEWHXDYON5oxM/hN1PacxXq5o=
X-Google-Smtp-Source: AMrXdXvAhe4Hizyfjsf2WGaF+txf7La5oe9VkKVF2FVL/XasSyEHwZfDOMaLPmUFO/dPf9a0cATh/8BEnAYXY621etA=
X-Received: by 2002:a17:906:40d7:b0:836:e897:648a with SMTP id
 a23-20020a17090640d700b00836e897648amr334327ejk.94.1674020369519; Tue, 17 Jan
 2023 21:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20230112155326.26902-1-laoar.shao@gmail.com> <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
 <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com>
 <CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com> <CALOAHbBVRvTkSxLin+9A20Wv0DZWz4epvNTY1jEaCTf7q0qWJA@mail.gmail.com>
In-Reply-To: <CALOAHbBVRvTkSxLin+9A20Wv0DZWz4epvNTY1jEaCTf7q0qWJA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Jan 2023 21:39:18 -0800
Message-ID: <CAADnVQJtSZWe0sjvA3YT2LPHJyUqDuhG1f62x2PTjB4WMeLsJw@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 7:08 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 1:25 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jan 13, 2023 at 3:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On Fri, Jan 13, 2023 at 5:05 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Jan 12, 2023 at 7:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > Currently there's no way to get BPF memory usage, while we can only
> > > > > estimate the usage by bpftool or memcg, both of which are not reliable.
> > > > >
> > > > > - bpftool
> > > > >   `bpftool {map,prog} show` can show us the memlock of each map and
> > > > >   prog, but the memlock is vary from the real memory size. The memlock
> > > > >   of a bpf object is approximately
> > > > >   `round_up(key_size + value_size, 8) * max_entries`,
> > > > >   so 1) it can't apply to the non-preallocated bpf map which may
> > > > >   increase or decrease the real memory size dynamically. 2) the element
> > > > >   size of some bpf map is not `key_size + value_size`, for example the
> > > > >   element size of htab is
> > > > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> > > > >   That said the differece between these two values may be very great if
> > > > >   the key_size and value_size is small. For example in my verifaction,
> > > > >   the size of memlock and real memory of a preallocated hash map are,
> > > > >
> > > > >   $ grep BPF /proc/meminfo
> > > > >   BPF:                 350 kB  <<< the size of preallocated memalloc pool
> > > > >
> > > > >   (create hash map)
> > > > >
> > > > >   $ bpftool map show
> > > > >   41549: hash  name count_map  flags 0x0
> > > > >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > > > >
> > > > >   $ grep BPF /proc/meminfo
> > > > >   BPF:               82284 kB
> > > > >
> > > > >   So the real memory size is $((82284 - 350)) which is 81934 kB
> > > > >   while the memlock is only 8192 kB.
> > > >
> > > > hashmap with key 4b and value 4b looks artificial to me,
> > > > but since you're concerned with accuracy of bpftool reporting,
> > > > please fix the estimation in bpf_map_memory_footprint().
> > >
> > > I thought bpf_map_memory_footprint() was deprecated, so I didn't try
> > > to fix it before.
> >
> > It's not deprecated. It's trying to be accurate.
> > See bpf_map_value_size().
> > In the past we had to be precise when we calculated the required memory
> > before we allocated and that was causing ongoing maintenance issues.
> > Now bpf_map_memory_footprint() is an estimate for show_fdinfo.
> > It can be made more accurate for this map with corner case key/value sizes.
> >
>
> Thanks for the clarification.
>
> > > > You're correct that:
> > > >
> > > > > size of some bpf map is not `key_size + value_size`, for example the
> > > > >   element size of htab is
> > > > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> > > >
> > > > So just teach bpf_map_memory_footprint() to do this more accurately.
> > > > Add bucket size to it as well.
> > > > Make it even more accurate with prealloc vs not.
> > > > Much simpler change than adding run-time overhead to every alloc/free
> > > > on bpf side.
> > > >
> > >
> > > It seems that we'd better introduce ->memory_footprint for some
> > > specific bpf maps. I will think about it.
> >
> > No. Don't build it into a replica of what we had before.
> > Making existing bpf_map_memory_footprint() more accurate.
> >
>
> I just don't want to add many if-elses or switch-cases into
> bpf_map_memory_footprint(), because I think it is a little ugly.
> Introducing a new map ops could make it more clear.  For example,
> static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
> {
>     unsigned long size;
>
>     if (map->ops->map_mem_footprint)
>         return map->ops->map_mem_footprint(map);
>
>     size = round_up(map->key_size + bpf_map_value_size(map), 8);
>     return round_up(map->max_entries * size, PAGE_SIZE);
> }

It is also ugly, because bpf_map_value_size() already has if-stmt.
I prefer to keep all estimates in one place.
There is no need to be 100% accurate.
With a callback devs will start thinking that this is somehow
a requirement to report precise memory.

> > > > bpf side tracks all of its allocation. There is no need to do that
> > > > in generic mm side.
> > > > Exposing an aggregated single number if /proc/meminfo also looks wrong.
> > >
> > > Do you mean that we shouldn't expose it in /proc/meminfo ?
> >
> > We should not because it helps one particular use case only.
> > Somebody else might want map mem info per container,
> > then somebody would need it per user, etc.
>
> It seems we should show memcg info and user info in bpftool map show.

Show memcg info? What do you have in mind?

The user info is often useless. We're printing it in bpftool prog show
and some folks suggested to remove it because it always prints 'uid 0'
Notice we use bpf iterators in both bpftool prog/map show
that prints the process that created the map.
That is much more useful than 'user id'.
In bpftool we can add 'verbosity' flag and print more things.
There is also json output.
And, of course, nothing stops you from having your own prog/map stats
collectors.
