Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6652412AD9
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 03:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhIUCAx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 22:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbhIUBwr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Sep 2021 21:52:47 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3AAC0386FC
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:21:21 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 73so43472023qki.4
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znh9ggZizMwDhKAV9Ni97xVIQID9gP6YfoS3LZVvffg=;
        b=N8ZSpG7C6mN0SQeR7680td5NGAFslnD4wwN1QolFW95kOU8f01aiVDII1nd96YX0zq
         tYEjYTSEJ69SGgfilLKPpOyt3hXuZkdSr64beccuZjyCmSlymxCAQAJYB2FZEGIJvcKW
         E8W6p1KVv9DIc0xoYDs5/5cT6YmnWNSj6NEVr57t9Ab8ULlVDvRVnRvUlSUVuSlFOfGo
         /A17gnCaG8Mm/oSu5/UhTPQg9hNrL2i4vnXzlyXKdCoYzUn4Jw2SnvGH4oKACYAPBTzA
         6qny694uMuIWjVF8+pyYtiZUdqnJ7l/bM2cc1JUs7nP/Ycxq/LwTn0m9LJHdQ+uWFull
         Gm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znh9ggZizMwDhKAV9Ni97xVIQID9gP6YfoS3LZVvffg=;
        b=bXhE6JEcGPDR77YZO+52D+VJ+U+xtyFQUJ6UldZidKSlj6S3DNv6ScHANdwWQlUexp
         /FaPKKlaDdn+p2UdPRwuBQbBAHmt1ALgrLA2qOkpdXPrjMQkbqt3052bqJzA+RBlEbd0
         vBtnlN/4VUjoy/lzPjJ1TU42Qr835KdLLxYQbqUB75Be0vyXGxFcbz2ArxvaNbXQ2O95
         sJgV++F5HfiiDXCmYKtAoOhNEp5FfljAbwMZWOXOfHHeMXlZsRxCtg9H+Gm9qvmrpXoq
         fOwJ1ebLuVE0ygIWxL/uBYfrIVi3mgbGnX6yOON5u7R93/aK2scZxtcvLyvtChtxUdKp
         NsxA==
X-Gm-Message-State: AOAM530gQ0WAZUs2SPrRCSGcY/moBsVBHcsNUIPqFuiCn8ryPP5ge9m8
        S5iS2z1Xs1Z/RrfDmVBcct9biDO9LqSuResFxGw=
X-Google-Smtp-Source: ABdhPJyVoVQBXjUMvWz68EcBWd22uXQ3Tvd7Y1AoPTM616Y5BbvZ0Xo5IDxlKWuYzMIQ8VLDPZe3peiKekUOdyxEKI4=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr37048023yba.225.1632180080962;
 Mon, 20 Sep 2021 16:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210914040433.3184308-1-joannekoong@fb.com> <20210914040433.3184308-2-joannekoong@fb.com>
 <20210917170130.njmm3dm65ftd76vo@ast-mbp> <CAEf4BzaA2QCmcc0nZqNbAqMdabqhjE5X_Nh59QjP8kd=iGH5GA@mail.gmail.com>
 <17d7b319-01d0-163e-57b6-c385d38cc9ad@fb.com>
In-Reply-To: <17d7b319-01d0-163e-57b6-c385d38cc9ad@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 20 Sep 2021 16:21:09 -0700
Message-ID: <CAEf4BzYRZM7Oi_CY=trjvefkavt5dwfF-Zu2GKihhfpeopGAnw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 20, 2021 at 3:52 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> My previous email replied to Alexei's email before I saw Andrii's new
> email, so please
> feel free to disregard my previous email.

Never got that reply of yours. Alexei's email arrived a few hours
after I've already replied to you. It was a time warp anomaly :)

>
> On 9/20/21 1:58 PM, Andrii Nakryiko wrote:
>
> > On Fri, Sep 17, 2021 at 6:08 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Mon, Sep 13, 2021 at 09:04:30PM -0700, Joanne Koong wrote:
> >>> +
> >>> +/* For bloom filter maps, the next 4 bits represent how many hashes to use.
> >>> + * The maximum number of hash functions supported is 15. If this is not set,
> >>> + * the default number of hash functions used will be 5.
> >>> + */
> >>> +     BPF_F_BLOOM_FILTER_HASH_BIT_1 = (1U << 13),
> >>> +     BPF_F_BLOOM_FILTER_HASH_BIT_2 = (1U << 14),
> >>> +     BPF_F_BLOOM_FILTER_HASH_BIT_3 = (1U << 15),
> >>> +     BPF_F_BLOOM_FILTER_HASH_BIT_4 = (1U << 16),
> >> The bit selection is unintuitive.
> >> Since key_size has to be zero may be used that instead to indicate the number of hash
> >> functions in the rare case when 5 is not good enough?
> > Hm... I was initially thinking about proposing something like that,
> > but it felt a bit ugly at the time. But now thinking about this a bit
> > more, I think this would be a bit more meaningful if we change the
> > terminology a bit. Instead of saying that Bloom filter has values and
> > no keys, we actually have keys and no values. So all those bytes that
> > are hashed are treated as keys (which is actually how sets are
> > implemented on top of maps, where you have keys and no values, or at
> > least the value is always true).
> >
> > So with that we'll have key/key_size to specify number of bytes that
> > needs to be hashed (and it's type info). And then we can squint a bit
> > and say that number of hashes are specified by value_size, as in
> > values are those nr_hash bits that we set in Bloom filter.
> >
> > Still a bit of terminology stretch, but won't necessitate those
> > specialized fields just for Bloom filter map. But if default value is
> > going to be good enough for most cases and most cases won't need to
> > adjust number of hashes, this seems to be pretty clean to me.
>
> With having bloom filter map keys instead of values,  I think this would
> lead to messier code in the kernel for handling map_lookup_elem
> and map_update_elem calls, due to the fact that the bloom filter map
> is a non-associative map and the current APIs for non-associative map types
> (peek_elem/push_elem/pop_elem) all have the map data as the value and
> not the key.
>
> For example, for map_update_elem, the API from the eBPF program side is
>
> int (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64
> flags);
>
> This would require us to either
>
> a) Add some custom logic in syscall.c so that we bypass the
> copy_from_bpfptr call on
> bloom filter map values (necessary because memcpying 0 bytes still
> requires the src pointer
> to be valid), which would allow us to pass in a NULL value
>
> b) Add a new function like
>
> int (*map_push_key)(struct bpf_map *map, void *key, u64 flags)
>
> that eBPF programs can call instead of map_update_elem.
>
> or
>
> c) Try to repurpose the existing map_push_elem API by passing in the key
> instead of the value,
> which would lead to inconsistent use of the API
>
> I think if we could change the non-associative map types (currently only
> stack maps and queue
> maps, I believe) to have their data be a key instead of a value, and
> have the pop/peek APIs use
> keys instead of values, then this would be cleaner, since we could then
> just use the existing peek/pop
> APIs.

I don't think we can change existing map APIs anymore, unfortunately.

>
> >> Or use inner_map_fd since there is no possibility of having an inner map in bloomfilter.
> >> It could be a union:
> >>      __u32   max_entries;    /* max number of entries in a map */
> >>      __u32   map_flags;      /* BPF_MAP_CREATE related
> >>                               * flags defined above.
> >>                               */
> >>      union {
> >>         __u32  inner_map_fd;   /* fd pointing to the inner map */
> >>         __u32  nr_hash_funcs;  /* or number of hash functions */
> >>      };
> > This works as well. A bit more Bloom filter-only terminology
> > throughout UAPI and libbpf, but I'd be fine with that as well.
> >
> Great, it looks like this is the consensus - I will go with this option
> for v3!
> >>      __u32   numa_node;      /* numa node */
> >>
> >>> +struct bpf_bloom_filter {
> >>> +     struct bpf_map map;
> >>> +     u32 bit_array_mask;
> >>> +     u32 hash_seed;
> >>> +     /* If the size of the values in the bloom filter is u32 aligned,
> >>> +      * then it is more performant to use jhash2 as the underlying hash
> >>> +      * function, else we use jhash. This tracks the number of u32s
> >>> +      * in an u32-aligned value size. If the value size is not u32 aligned,
> >>> +      * this will be 0.
> >>> +      */
> >>> +     u32 aligned_u32_count;
> >> what is the performance difference?
> >> May be we enforce 4-byte sized value for simplicity?
> > This might be a bit too surprising, especially if keys are just some
> > strings, where people might not expect that it has to 4-byte multiple
> > size. And debugging this without extra tooling (like retsnoop) is
> > going to be nightmarish.
> >
> > If the performance diff is huge and that if/else logic is
> > unacceptable, we can also internally pad with up to 3 zero bytes and
> > include those into the hash.
> I think the if/else logic is unavoidable if we support non 4-byte
> aligned value sizes,
> unless we are okay with truncating any remainder bytes of non 4-byte
> aligned values
> and stipulating that a bloom filter map value size has to be greater
> than 4 bytes (these
> conditions would allow us to use jhash2 for every value without an
> if/else check). If we
> internally pad, we will have to pad on every update and lookup, which
> would also
> require an if/else.
> Thanks for the comments and reviews, Alexei and Andrii. They are much
> appreciated!

I don't think truncation is an option. And I also forgot that we don't
really store values, so there is nothing to pad, really. So yeah, I'd
keep it as is, especially if that is not expensive (which I assume
it's not). As I mentioned before, that logic can be encapsulated in a
dedicated helper function and reused in a few places.
