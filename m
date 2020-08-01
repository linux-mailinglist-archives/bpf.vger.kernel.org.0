Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D242353F4
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHASLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgHASLs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Aug 2020 14:11:48 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19411C061757
        for <bpf@vger.kernel.org>; Sat,  1 Aug 2020 11:11:48 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id o2so15597525qvk.6
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJb6Vvu8mqqcj73oC2DfT7w8cGZtXr27iT4LRSChT/Q=;
        b=B1ctzC+S5jfe4gCdjqspi59Uqvd6Ie4ws+IZGMvBk+M54ynwBEIpRkE6a5K6XjMK5M
         luzUguj+XuC9mpTh9u5aInvPB1fgyc0QrP2wUw7g68zf8PWsjPz5WCwRQUKYRigIfyCl
         g4kBYCgNuS/+FLlHNLnH2Yc1YO/q2jz7dgS9wvOyxO/p+2WsRHkTSOgxZongLrcOBtRR
         V446TNHSWHZ779cIJgc0YF5PA8CD4/SrHa+8vUWZ1QgNARLamcdwy3MNFmmP/gQvubW7
         hR3I6x9uqKZdG7wDhGFvgRfKgIeaNy6k8zoS++05VsEBnsQbox6mli2zjr4IBFdWWJI+
         w2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJb6Vvu8mqqcj73oC2DfT7w8cGZtXr27iT4LRSChT/Q=;
        b=YTSQw6WnTXZLp/3+In6uZrudoAv20InaHZo7XYD+ibNgoo4EKRuR2qq2sOjuJ05//d
         jA8sQupq/n5A/COfBZALwlxbc6QE2m6J0GiktTRYrnj+oFAXn/OFQQldXPl5W00ag2B9
         4lVTBmH9WMKEklmOUKVOw7d75uP1KrxABsRpLP69QfrD2SKBLlZ8ha+KMqNJ6mAF67TS
         UgNgM6obVpHuVFIJ/P80X+lDMDRhi204KW1rZRTHMI/AA4eGUI+1JVsr7yKd4knC2r3D
         LN/05xRmGRfuD6TLYqinnNR7kiLlSqjJFtMTJmWD8qle5/TmY3lpgvoDB89M55YB0AJK
         TNAg==
X-Gm-Message-State: AOAM531kVzvtBihabRy/mbXZvFFD/XEcGode0/PR62DDeFNQ8PJFdR8I
        bK1wnxP8nWmEwKNsyexBPFhmxozxXA/IykSIFThvoA==
X-Google-Smtp-Source: ABdhPJwRqQEWFeJB1ka2IEsgDI4U9/nh2uXxQWOZPsgp8AoDeR3kHHzMq8U2mLzSEzfWeRlPXuU6Rghcd68fzVjS8GU=
X-Received: by 2002:a0c:f8c3:: with SMTP id h3mr9180708qvo.135.1596305506859;
 Sat, 01 Aug 2020 11:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200801045722.877331-1-brianvv@google.com> <4cd10805-b056-21a7-fdc2-d3f66e94dcf6@fb.com>
In-Reply-To: <4cd10805-b056-21a7-fdc2-d3f66e94dcf6@fb.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Sat, 1 Aug 2020 11:11:35 -0700
Message-ID: <CAMzD94TUmUGwDLktpLm-MMXqOE0QX_4acV9mtjU47+f1AMDntQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make __htab_lookup_and_delete_batch faster
 when map is almost empty
To:     Yonghong Song <yhs@fb.com>
Cc:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linux NetDev <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 1, 2020 at 9:59 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/31/20 9:57 PM, Brian Vazquez wrote:
> > While running some experiments it was observed that map_lookup_batch was much
> > slower than get_next_key + lookup when the syscall overhead is minimal.
> > This was because the map_lookup_batch implementation was more expensive
> > traversing empty buckets, this can be really costly when the pre-allocated
> > map is too big.
> >
> > This patch optimizes the case when the bucket is empty so we can move quickly
> > to next bucket.
> >
> > The benchmark to exercise this is as follows:
> >
> > -The map was populate with a single entry to make sure that the syscall overhead
> > is not helping the map_batch_lookup.
> > -The size of the preallocated map was increased to show the effect of
> > traversing empty buckets.
> >
> > Results:
> >
> >    Using get_next_key + lookup:
> >
> >    Benchmark                Time(ns)        CPU(ns)     Iteration
> >    ---------------------------------------------------------------
> >    BM_DumpHashMap/1/1k          3593           3586         192680
> >    BM_DumpHashMap/1/4k          6004           5972         100000
> >    BM_DumpHashMap/1/16k        15755          15710          44341
> >    BM_DumpHashMap/1/64k        59525          59376          10000
>
> I think "BM_DumpHashMap/1/64k" means the program "BM_DumpHashMap",
> the map having only "1" entry, and the map preallocated size is "64k"?
> What is the "Iteration" here? The number of runs with the same dump?
> The CPU(ns) is the system cpu consumption, right? The Time/CPU is for
> all iterations, not just one, right? It would be good
> if the above results can be described better, so people can
> understand the results better.
>

Hi Yonghong, thanks for reviewing it!

I'll fix it in next iteration.
> >
> >    Using htab_lookup_batch before this patch:
> >    Benchmark                Time(ns)        CPU(ns)     Iterations
> >    ---------------------------------------------------------------
> >    BM_DumpHashMap/1/1k          3933           3927         177978
> >    BM_DumpHashMap/1/4k          9192           9177          73951
> >    BM_DumpHashMap/1/16k        42011          41970          16789
> >    BM_DumpHashMap/1/64k       117895         117661           6135
> >
> >    Using htab_lookup_batch with this patch:
> >    Benchmark                Time(ns)        CPU(ns)     Iterations
> >    ---------------------------------------------------------------
> >    BM_DumpHashMap/1/1k          2809           2803         249212
> >    BM_DumpHashMap/1/4k          5318           5316         100000
> >    BM_DumpHashMap/1/16k        14925          14895          47448
> >    BM_DumpHashMap/1/64k        58870          58674          10000
> >
> > Suggested-by: Luigi Rizzo <lrizzo@google.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Brian Vazquez <brianvv@google.com>
> > ---
> >   kernel/bpf/hashtab.c | 23 ++++++++---------------
> >   1 file changed, 8 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 2137e2200d95..150015ea6737 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1351,7 +1351,6 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> >       struct hlist_nulls_head *head;
> >       struct hlist_nulls_node *n;
> >       unsigned long flags = 0;
> > -     bool locked = false;
> >       struct htab_elem *l;
> >       struct bucket *b;
> >       int ret = 0;
> > @@ -1410,19 +1409,19 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> >       dst_val = values;
> >       b = &htab->buckets[batch];
> >       head = &b->head;
> > -     /* do not grab the lock unless need it (bucket_cnt > 0). */
> > -     if (locked)
> > -             flags = htab_lock_bucket(htab, b);
> >
> > +     l = hlist_nulls_entry_safe(rcu_dereference_raw(hlist_nulls_first_rcu(head)),
> > +                                     struct htab_elem, hash_node);
> > +     if (!l && (batch + 1 < htab->n_buckets)) {
> > +             batch++;
> > +             goto again_nocopy;
> > +     }
> > +
> > +     flags = htab_lock_bucket(htab, b);
> [...]
