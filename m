Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0766964E
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 13:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbjAMMCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 07:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbjAMMBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 07:01:43 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D96321B2
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 03:53:44 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id g14so22192242ljh.10
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=emIokTK4nKwkwZPI13VlsDTgDe45jFLOJz4i2BcmlzY=;
        b=JSAEeOHhVrTHsJFHIzbH6snvdRKEzkS5FmhbedFjSb3N/rfgw21RH9pEwNAM3A6s4F
         OWC8UwtdJ2meRYeqXF4rE0UqXYY0GNOKuMqCh7lD3eYTHeDUJ8M8YeLmTpfpWfgek7lH
         0R+jdDaA+7XTp2uqHkNZYHDzuyNw1mKmIjSrLZfqpsKapuOh+Z1nj8DQWMjDyJj3pLNQ
         iceYsX4gxyWgNvbzP901zcLDA22/QGWyltya6I5/wqQKb2V/8ExX2BATCp+KBp2/PGk0
         q7Y6BgvMadqDdFAK7eKciKCtFf+XhraVd05Mj4GJYRqQyPWdzfVN94CCMKbqG+buR1kA
         TNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emIokTK4nKwkwZPI13VlsDTgDe45jFLOJz4i2BcmlzY=;
        b=BMDtYchUVfYFZUlLTmFn08g3rh6tTvwdyOZsQS0oBh7mXM3q+Q9LdyFiqq0fOsnKYC
         tnqi3Owvt6tHlg9hzPW9V0XyiHe1AufNrnREMSkJ5X56927+HAIzAWoPxXx+aRNaxjF2
         e0WjHg9cbOvvcGhK5Ccy2XaPqEy2Jbii+ZwW3x63FYmbdKFE3AQWQk8GckLrwOyo0Rtq
         ZGS488HtBosXDP/f+p1jFcmjtb01h8zeXy4u9KrHBzD0BWcroRFbT2uKNqET7r9FJUX5
         EnnfrBvAzVRjI3fD/+GxwMHrP+685dh9FuNo9SQz32eZiaus/zeHQ+oYYA7GOJJ6zjG6
         Gd5g==
X-Gm-Message-State: AFqh2krWxcGC5T14P87aESJu73N7PPdhk6pB/HaDwhQsS/bl0CM+IZdx
        gqObXtZnWb4luzs2iJ5YzAkHfTQ+zLMVAY7Tvlg=
X-Google-Smtp-Source: AMrXdXtsxjamjE8mI7mZIBHqqNz94tF7cDf2yHEHbepzsl5KW9g/pi6hsFdVLuYiNi6uCK/NnQ7qgZQji+B17tt1GdY=
X-Received: by 2002:a2e:86cf:0:b0:282:8f7f:1e90 with SMTP id
 n15-20020a2e86cf000000b002828f7f1e90mr2241754ljj.475.1673610822654; Fri, 13
 Jan 2023 03:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20230112155326.26902-1-laoar.shao@gmail.com> <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
In-Reply-To: <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 13 Jan 2023 19:53:06 +0800
Message-ID: <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com>
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

On Fri, Jan 13, 2023 at 5:05 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 12, 2023 at 7:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Currently there's no way to get BPF memory usage, while we can only
> > estimate the usage by bpftool or memcg, both of which are not reliable.
> >
> > - bpftool
> >   `bpftool {map,prog} show` can show us the memlock of each map and
> >   prog, but the memlock is vary from the real memory size. The memlock
> >   of a bpf object is approximately
> >   `round_up(key_size + value_size, 8) * max_entries`,
> >   so 1) it can't apply to the non-preallocated bpf map which may
> >   increase or decrease the real memory size dynamically. 2) the element
> >   size of some bpf map is not `key_size + value_size`, for example the
> >   element size of htab is
> >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> >   That said the differece between these two values may be very great if
> >   the key_size and value_size is small. For example in my verifaction,
> >   the size of memlock and real memory of a preallocated hash map are,
> >
> >   $ grep BPF /proc/meminfo
> >   BPF:                 350 kB  <<< the size of preallocated memalloc pool
> >
> >   (create hash map)
> >
> >   $ bpftool map show
> >   41549: hash  name count_map  flags 0x0
> >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> >
> >   $ grep BPF /proc/meminfo
> >   BPF:               82284 kB
> >
> >   So the real memory size is $((82284 - 350)) which is 81934 kB
> >   while the memlock is only 8192 kB.
>
> hashmap with key 4b and value 4b looks artificial to me,
> but since you're concerned with accuracy of bpftool reporting,
> please fix the estimation in bpf_map_memory_footprint().

I thought bpf_map_memory_footprint() was deprecated, so I didn't try
to fix it before.

> You're correct that:
>
> > size of some bpf map is not `key_size + value_size`, for example the
> >   element size of htab is
> >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
>
> So just teach bpf_map_memory_footprint() to do this more accurately.
> Add bucket size to it as well.
> Make it even more accurate with prealloc vs not.
> Much simpler change than adding run-time overhead to every alloc/free
> on bpf side.
>

It seems that we'd better introduce ->memory_footprint for some
specific bpf maps. I will think about it.

> Higher level point:

Thanks for your thoughts.

> bpf side tracks all of its allocation. There is no need to do that
> in generic mm side.
> Exposing an aggregated single number if /proc/meminfo also looks wrong.

Do you mean that we shouldn't expose it in /proc/meminfo ?

> People should be able to "bpftool map show|awk sum of fields"
> and get the same number.


-- 
Regards
Yafang
