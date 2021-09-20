Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C147D412AD7
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbhIUCAu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 22:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhIUBld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Sep 2021 21:41:33 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0064C04CD20
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 13:58:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a10so47377553qka.12
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMjhA7+1sCJcapiwdZFzXc5j9KCSVC0mWGXrfUnVfyc=;
        b=KRYBdmPAYauDFpaMb3BVtLAnBINhBsQ9btICGlkd8lECxm3x3nkaLvXqu+641GoKES
         hodWP7AeNx5DnUI7abjvT6ExD1axYCoX8FLlhs41HnVsMB/OZezHRM525JSRacBIWhDP
         x50I3JOpwbQ6JzhPY86CrdXoYphPw7klpg6BqBsaHaLDs0dlDG+g5nFhoFCPkeKlSboG
         vhscEfkyVycRrC1iRLeAAYNxgyL7gdwRAen4vDpu2VF+DiN3JKC/KNXtGcc1sWjctxQC
         NgGpq8QkLDUyegW0y+ifWw8tmPF5kdte6ZUWa2ZOnGJE476YlWPu51k1qkOYn8F6z/5w
         Hm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMjhA7+1sCJcapiwdZFzXc5j9KCSVC0mWGXrfUnVfyc=;
        b=KHEP2hLe7ZNMZvd+ObOPUCnDYoDo827CCKjU9SnwhPBm0ZOuXkyAdQQVVT5wRPePUS
         mDwYv4gMYalyU54cnzOfHW689nVhT+rv0ig2zZ7bZbLjY0ffoA9EU4/bOWqIbwnbBquV
         qWLBb9wzP9xw9hrMxnpVDW3xPhGyVRp8Ck2qdQ1wzzZGwt9XnZsD9+agqd6PwhsFI7NC
         Vlrbq6q2rDCAfc5O0PBukt43V0X3M6uYYwrypM+M8C+V3htfie/SGvjWmDzsBvQvQm0W
         jOrytqKzlALabvDALVgHdyoR+zoK4qUihxVwunZPschunx1olH6eaMyujP7wuT0U25Ef
         2WdA==
X-Gm-Message-State: AOAM530UXfasAMaSbj2ubC5xqr2o8pfv4DvHIAklHucpsQVuYfEsoGu7
        2Koun6VR6u956Z6Ryn2E1cb28jXQTgR/q3fu8Xg=
X-Google-Smtp-Source: ABdhPJwzUk+rHQf1bnNCbDQV8tCuAqQqOcGWasK0fvurrUf94GlUcBkeSbCiKdW7qqvEYW0bf1Bxto68YVjYMxK/9nU=
X-Received: by 2002:a25:83c6:: with SMTP id v6mr2405388ybm.2.1632171531930;
 Mon, 20 Sep 2021 13:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210914040433.3184308-1-joannekoong@fb.com> <20210914040433.3184308-2-joannekoong@fb.com>
 <20210917170130.njmm3dm65ftd76vo@ast-mbp>
In-Reply-To: <20210917170130.njmm3dm65ftd76vo@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 20 Sep 2021 13:58:41 -0700
Message-ID: <CAEf4BzaA2QCmcc0nZqNbAqMdabqhjE5X_Nh59QjP8kd=iGH5GA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Add bloom filter map implementation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 6:08 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 13, 2021 at 09:04:30PM -0700, Joanne Koong wrote:
> > +
> > +/* For bloom filter maps, the next 4 bits represent how many hashes to use.
> > + * The maximum number of hash functions supported is 15. If this is not set,
> > + * the default number of hash functions used will be 5.
> > + */
> > +     BPF_F_BLOOM_FILTER_HASH_BIT_1 = (1U << 13),
> > +     BPF_F_BLOOM_FILTER_HASH_BIT_2 = (1U << 14),
> > +     BPF_F_BLOOM_FILTER_HASH_BIT_3 = (1U << 15),
> > +     BPF_F_BLOOM_FILTER_HASH_BIT_4 = (1U << 16),
>
> The bit selection is unintuitive.
> Since key_size has to be zero may be used that instead to indicate the number of hash
> functions in the rare case when 5 is not good enough?

Hm... I was initially thinking about proposing something like that,
but it felt a bit ugly at the time. But now thinking about this a bit
more, I think this would be a bit more meaningful if we change the
terminology a bit. Instead of saying that Bloom filter has values and
no keys, we actually have keys and no values. So all those bytes that
are hashed are treated as keys (which is actually how sets are
implemented on top of maps, where you have keys and no values, or at
least the value is always true).

So with that we'll have key/key_size to specify number of bytes that
needs to be hashed (and it's type info). And then we can squint a bit
and say that number of hashes are specified by value_size, as in
values are those nr_hash bits that we set in Bloom filter.

Still a bit of terminology stretch, but won't necessitate those
specialized fields just for Bloom filter map. But if default value is
going to be good enough for most cases and most cases won't need to
adjust number of hashes, this seems to be pretty clean to me.

> Or use inner_map_fd since there is no possibility of having an inner map in bloomfilter.
> It could be a union:
>     __u32   max_entries;    /* max number of entries in a map */
>     __u32   map_flags;      /* BPF_MAP_CREATE related
>                              * flags defined above.
>                              */
>     union {
>        __u32  inner_map_fd;   /* fd pointing to the inner map */
>        __u32  nr_hash_funcs;  /* or number of hash functions */
>     };

This works as well. A bit more Bloom filter-only terminology
throughout UAPI and libbpf, but I'd be fine with that as well.


>     __u32   numa_node;      /* numa node */
>
> > +struct bpf_bloom_filter {
> > +     struct bpf_map map;
> > +     u32 bit_array_mask;
> > +     u32 hash_seed;
> > +     /* If the size of the values in the bloom filter is u32 aligned,
> > +      * then it is more performant to use jhash2 as the underlying hash
> > +      * function, else we use jhash. This tracks the number of u32s
> > +      * in an u32-aligned value size. If the value size is not u32 aligned,
> > +      * this will be 0.
> > +      */
> > +     u32 aligned_u32_count;
>
> what is the performance difference?
> May be we enforce 4-byte sized value for simplicity?

This might be a bit too surprising, especially if keys are just some
strings, where people might not expect that it has to 4-byte multiple
size. And debugging this without extra tooling (like retsnoop) is
going to be nightmarish.

If the performance diff is huge and that if/else logic is
unacceptable, we can also internally pad with up to 3 zero bytes and
include those into the hash.
