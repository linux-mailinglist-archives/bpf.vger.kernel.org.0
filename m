Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050AF43D183
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 21:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhJ0TTF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhJ0TTF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 15:19:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B352CC061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 12:16:39 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id o12so9040043ybk.1
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ldu4UFSVronANdNpDMx4g5NGY8gygFtWXTix1zgZFs=;
        b=B6BYeKLN7I5e04kbTxueF9Mgr/Gx8e9MH1udythEVL3E4U1fDFX1h0bb2Z3KxjGIWH
         q4wzZq+KjuVnQwz5cQS8Dv0z1d5lO94ZcwntMOY8erkQTyA+8biPa3waatouo94/OGbq
         z2cjIixpj918UtZV/kMeV2LYnzuWXYOFgPKOhW2vSicD76fomscy43+PmVDqkTgKVR0l
         oK5fav46H85sgL6Lrs3gFTRbyn3tlE4QNNf2RpxFeobk/aG2wfXE3aPj85QJ4TfvQcQd
         kg4Cb9rMMyBSpfY+oqzBJzJMHGKtR4iDWbs+U5vnmqT8Imcs48YWvVy0i99Z+5i0VSYr
         kKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ldu4UFSVronANdNpDMx4g5NGY8gygFtWXTix1zgZFs=;
        b=w64cwVebVKqHjyyiXH1aTDC8gou2d6KLoNg6inY/cWq63Lhmks6VJcWxvSLsNUUwC+
         hsfzePzDMpx5GPiZMSOQ5h2N44kVVr4YWy4xpr9HPZIOkDDxSB/ivFhFWigIGxKeOteu
         jDsyyWqz1m5D4D7uGB8UIle+FQ2G8PucireQRojgxBwQiS9JjW2NksFrmKMO4ndN7zkj
         L4hssGoJGfaVCwzD2YVv8WneAgMbRzdhz3cBbQEeO0gO+ctmVNQp7aCVQSQKbB/dKmRK
         Lr7+gXyBV4WyYd1W78j2iQ+LJSvb3M43ludyGyvCzPQWKabpsSTvEHC0cOTXDo0sMurv
         zuRg==
X-Gm-Message-State: AOAM533s3tyRxjdI2jNmMZgGB6z58dYlRfbh1NJJJF6x/HFQ4JsWHprB
        Lup6T7zP/OBTao/W5YhRv8iMUdyB0gMqZrybCN4=
X-Google-Smtp-Source: ABdhPJxWQa3u3zzABOfZEpBaI81fU/2UIGl6JNhOpK21+LV5R4QKUENZxCG24530jkWQVSMbJ8y8x8T8CwyVBgEKVxo=
X-Received: by 2002:a25:bfc8:: with SMTP id q8mr2227651ybm.455.1635362198944;
 Wed, 27 Oct 2021 12:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211022220249.2040337-1-joannekoong@fb.com> <20211022220249.2040337-2-joannekoong@fb.com>
 <086460a2-6213-2b1b-9368-166229a91847@fb.com> <8c07e81e-7dc2-2ae3-6109-b15ad3da4850@fb.com>
In-Reply-To: <8c07e81e-7dc2-2ae3-6109-b15ad3da4850@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Oct 2021 12:16:27 -0700
Message-ID: <CAEf4Bzb1s5ka-E03egUqd8AB_qvmctjMtcyJn4U+qoSPmSGX8w@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 12:14 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 10/26/21 8:18 PM, Andrii Nakryiko wrote:
>
> >
> > On 10/22/21 3:02 PM, Joanne Koong wrote:
> >> This patch adds the kernel-side changes for the implementation of
> >> a bpf bloom filter map.
> >>
> >> The bloom filter map supports peek (determining whether an element
> >> is present in the map) and push (adding an element to the map)
> >> operations.These operations are exposed to userspace applications
> >> through the already existing syscalls in the following way:
> >>
> >> BPF_MAP_LOOKUP_ELEM -> peek
> >> BPF_MAP_UPDATE_ELEM -> push
> >>
> >> The bloom filter map does not have keys, only values. In light of
> >> this, the bloom filter map's API matches that of queue stack maps:
> >> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> >> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> >> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> >> APIs to query or add an element to the bloom filter map. When the
> >> bloom filter map is created, it must be created with a key_size of 0.
> >>
> >> For updates, the user will pass in the element to add to the map
> >> as the value, with a NULL key. For lookups, the user will pass in the
> >> element to query in the map as the value, with a NULL key. In the
> >> verifier layer, this requires us to modify the argument type of
> >> a bloom filter's BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE;
> >> as well, in the syscall layer, we need to copy over the user value
> >> so that in bpf_map_peek_elem, we know which specific value to query.
> >>
> >> A few things to please take note of:
> >>   * If there are any concurrent lookups + updates, the user is
> >> responsible for synchronizing this to ensure no false negative lookups
> >> occur.
> >>   * The number of hashes to use for the bloom filter is configurable
> >> from
> >> userspace. If no number is specified, the default used will be 5 hash
> >> functions. The benchmarks later in this patchset can help compare the
> >> performance of using different number of hashes on different entry
> >> sizes. In general, using more hashes decreases both the false positive
> >> rate and the speed of a lookup.
> >>   * Deleting an element in the bloom filter map is not supported.
> >>   * The bloom filter map may be used as an inner map.
> >>   * The "max_entries" size that is specified at map creation time is
> >> used
> >> to approximate a reasonable bitmap size for the bloom filter, and is not
> >> otherwise strictly enforced. If the user wishes to insert more entries
> >> into the bloom filter than "max_entries", they may do so but they should
> >> be aware that this may lead to a higher false positive rate.
> >>
> >> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> >> ---
> >
> >
> > Apart from few minor comments below and the stuff that Martin
> > mentioned, LGTM.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >
> >>   include/linux/bpf.h            |   2 +
> >>   include/linux/bpf_types.h      |   1 +
> >>   include/uapi/linux/bpf.h       |   8 ++
> >>   kernel/bpf/Makefile            |   2 +-
> >>   kernel/bpf/bloom_filter.c      | 198 +++++++++++++++++++++++++++++++++
> >>   kernel/bpf/syscall.c           |  19 +++-
> >>   kernel/bpf/verifier.c          |  19 +++-
> >>   tools/include/uapi/linux/bpf.h |   8 ++
> >>   8 files changed, 250 insertions(+), 7 deletions(-)
> >>   create mode 100644 kernel/bpf/bloom_filter.c
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 31421c74ba08..953d23740ecc 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -193,6 +193,8 @@ struct bpf_map {
> >>       struct work_struct work;
> >>       struct mutex freeze_mutex;
> >>       u64 writecnt; /* writable mmap cnt; protected by freeze_mutex */
> >> +
> >> +    u64 map_extra; /* any per-map-type extra fields */
> >
> >
> > It's minor, but given this is a read-only value, it makes more sense
> > to put it after map_flags so that it doesn't share a cache line with a
> > refcounting and mutex fields
> >
> >
> Awesome, I will make this change.
>
> One question I have in general that's semi-related is about
> backwards-compatibility.
> I might be completely misremembering, but I recall hearing something
> about only adding
> fields to the end of structs in some headers under the linux/include
> directory, so that this
> doesn't mess up backwards-compatibility with older kernel versions.
>
> Is this 100% false or is there a subset under linux/include (like
> linux/include/uapi/linux/*)
> that we do need to adhere to this for?

This backwards compatibility applies only to UAPI types. So any header
under include/uapi (i.e., include/uapi/linux/bpf.h which defines
"public interface" to BPF). While in this case you are modifying
internal kernel types. struct bpf_map is not exposed to user-space, so
you can re-shuffle fields if necessary.

>
> >
> > [...]
> >
