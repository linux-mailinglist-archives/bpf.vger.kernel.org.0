Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA15666E4E7
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 18:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjAQR1Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 12:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjAQRZr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 12:25:47 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C035A49039
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 09:25:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hw16so65163329ejc.10
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PbngI1x45WG0Dj+cWyNRbiJ8XHkY6KMeJj98Xvf7rH4=;
        b=PaOLMjbQDrZqFWDLjlOIoVP7YXr91GRcToXJSf5eVe1y3F+nzbmT/QnbEjFNh/A3fC
         elesWXMQtaFTv3cIDAhLwzv5PcCEVcVB1j/PIt/jO9X9h+cX3/aJkGFlBOnJzVLBqHLl
         vRD5Of124M53bWwaykcaW0B6mqqrAdxQV0l2lCHts8gebi0b6EA12IeNW+F4ogneFQyO
         qft6bJ9NjZaGx5VobOy5SyoXGEn6q6wFaaTe/gc2jf4dmNavAv4agL8LalmbFKtXYkRQ
         x6JEZ4rOuMDJw08XfJ1u5FjWp2xHH7ioD2i/zZnExvJd07SYum7oiAvzjuSKtCak5+nL
         XVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbngI1x45WG0Dj+cWyNRbiJ8XHkY6KMeJj98Xvf7rH4=;
        b=Ccyq+9ihhVLnh0pKmbxv5QLHx9PygwXnY+Hh4J8sAhsC67EtYILnBihXRdQT40imzH
         iDMZ6JEtKfWw46NNBUsVdgwteYJAn2/b35sxU9yS776OYJk/qYm3qiDW52ye4V0isM1v
         ZxafzGwLZoWvSquWnB1fA09SR1Jd7RWHWxItAB66Uxhoh/y/J9GpTDPAYfsst+N0gnKG
         YzHLH9PPuG7iPkkYIH6wTMW11n5apC3045q0SK33ivlBwW0QWbJa2VQf8PI9nM3z7psC
         tkB+WeTCS3QXGmjHfO/psTUZWLUZDC5hKIwU4/20fPJFUDDfeObs74yklEHS8VcY4yAe
         O1yw==
X-Gm-Message-State: AFqh2kov6GJtmC8fKOulTjrdiDwOr0B2sRiHVDrgtyhPc0tzm4IqUsv5
        vn3652kvfZdxXkBQkh88bIN5iGc/2VIMb4hZAS0=
X-Google-Smtp-Source: AMrXdXueaFau9Bs5d0hYqlfJnVo24HUntnH6hlew8tVrtRc09TNgiq02I58e4KbOGC7E1TScI4uZgMpseIjdVWsptWQ=
X-Received: by 2002:a17:906:40d7:b0:836:e897:648a with SMTP id
 a23-20020a17090640d700b00836e897648amr218299ejk.94.1673976323181; Tue, 17 Jan
 2023 09:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20230112155326.26902-1-laoar.shao@gmail.com> <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
 <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com>
In-Reply-To: <CALOAHbAsQ66j77BWC6isTRiKRPgG1Ap2qf6L+wQ+x2SXJt8NjQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Jan 2023 09:25:12 -0800
Message-ID: <CAADnVQJGF5Xthpn7D2DgHHvZz8+dnuz2xMi6yoSziuauXO7ncA@mail.gmail.com>
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

On Fri, Jan 13, 2023 at 3:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 5:05 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 12, 2023 at 7:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > Currently there's no way to get BPF memory usage, while we can only
> > > estimate the usage by bpftool or memcg, both of which are not reliable.
> > >
> > > - bpftool
> > >   `bpftool {map,prog} show` can show us the memlock of each map and
> > >   prog, but the memlock is vary from the real memory size. The memlock
> > >   of a bpf object is approximately
> > >   `round_up(key_size + value_size, 8) * max_entries`,
> > >   so 1) it can't apply to the non-preallocated bpf map which may
> > >   increase or decrease the real memory size dynamically. 2) the element
> > >   size of some bpf map is not `key_size + value_size`, for example the
> > >   element size of htab is
> > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> > >   That said the differece between these two values may be very great if
> > >   the key_size and value_size is small. For example in my verifaction,
> > >   the size of memlock and real memory of a preallocated hash map are,
> > >
> > >   $ grep BPF /proc/meminfo
> > >   BPF:                 350 kB  <<< the size of preallocated memalloc pool
> > >
> > >   (create hash map)
> > >
> > >   $ bpftool map show
> > >   41549: hash  name count_map  flags 0x0
> > >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > >
> > >   $ grep BPF /proc/meminfo
> > >   BPF:               82284 kB
> > >
> > >   So the real memory size is $((82284 - 350)) which is 81934 kB
> > >   while the memlock is only 8192 kB.
> >
> > hashmap with key 4b and value 4b looks artificial to me,
> > but since you're concerned with accuracy of bpftool reporting,
> > please fix the estimation in bpf_map_memory_footprint().
>
> I thought bpf_map_memory_footprint() was deprecated, so I didn't try
> to fix it before.

It's not deprecated. It's trying to be accurate.
See bpf_map_value_size().
In the past we had to be precise when we calculated the required memory
before we allocated and that was causing ongoing maintenance issues.
Now bpf_map_memory_footprint() is an estimate for show_fdinfo.
It can be made more accurate for this map with corner case key/value sizes.

> > You're correct that:
> >
> > > size of some bpf map is not `key_size + value_size`, for example the
> > >   element size of htab is
> > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> >
> > So just teach bpf_map_memory_footprint() to do this more accurately.
> > Add bucket size to it as well.
> > Make it even more accurate with prealloc vs not.
> > Much simpler change than adding run-time overhead to every alloc/free
> > on bpf side.
> >
>
> It seems that we'd better introduce ->memory_footprint for some
> specific bpf maps. I will think about it.

No. Don't build it into a replica of what we had before.
Making existing bpf_map_memory_footprint() more accurate.

> > bpf side tracks all of its allocation. There is no need to do that
> > in generic mm side.
> > Exposing an aggregated single number if /proc/meminfo also looks wrong.
>
> Do you mean that we shouldn't expose it in /proc/meminfo ?

We should not because it helps one particular use case only.
Somebody else might want map mem info per container,
then somebody would need it per user, etc.
bpftool map show | awk
solves all those cases without adding new uapi-s.
