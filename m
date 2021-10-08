Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2B5427429
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbhJHX1I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 19:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhJHX1H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 19:27:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EFC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 16:25:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x7so40042960edd.6
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSr8KCFdMvuTCtQZ/L5ng1hPtppLusXW+9ipdB7vKB4=;
        b=MkasUZsiP5ZFG5aE0q38WRaBNjlkJzTrw37vfygr3lENZgozuSuHLfzz/+YlqWyGSK
         fopy/mnA75NJxb0rtBun+PqzUZDxqDz4wJ8hj6YQGfK3tsI8nQMyEU6HNbFAs/muxN2i
         YiwGBnaYLJrwKJI61dvoYblYLI0rGfo6Sy8vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSr8KCFdMvuTCtQZ/L5ng1hPtppLusXW+9ipdB7vKB4=;
        b=egEXNBTRDIDB10fhLHaiINi4p1kqSTzC2rdj6QKfW7VKhtvF8GkgvqdGVNyXPY56bx
         vkjxLg8ORoV7o7jY6CEXtNocr01drwdHXAK+G720aCu4cM42oEAPdbPX1E1cRIC/DAel
         LVTEqh3MB7QYpIlaniPs2EKxxtHZrXpiYSuiYJzE5XmVmW7b7HARga6dha+XUQs1c3hY
         3e3WXwXKzdDKPI537iq7D00O/lWx/MKmmMgMtmkggT45RCZbA2dfxuMT0M7N8aIFdpMG
         uTt9ULJGKlAeoqjj3Rn4SsH8aPrgksiL14fW0A0iVVr8lnIiPxfZyoBxsgI+AwPQyqxO
         wWYA==
X-Gm-Message-State: AOAM530cgr3nkptZacp71MogMuilXXqGS4c/TvG3wS5ymnMAYtTvvCxL
        kx+QqW893UBD1tJuyygENfGjHwLvDvzv9xC5y97eHA==
X-Google-Smtp-Source: ABdhPJwBrcVswKa6uFDTowLya2lOAGpJF8wjftrPyQDkJ4+mpeRokZfPtP+rWb1umdyKaNSgApHROLiotS473K9Y6cU=
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr6497120edz.310.1633735509643;
 Fri, 08 Oct 2021 16:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-2-joannekoong@fb.com>
 <CAEf4Bzb9GJaKGSL5fgA468aUL70eJSiPvknARt-KWDViOqT7cQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb9GJaKGSL5fgA468aUL70eJSiPvknARt-KWDViOqT7cQ@mail.gmail.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Fri, 8 Oct 2021 16:24:58 -0700
Message-ID: <CAC1LvL3k8N_=Q0aFaGExWD_+hOO-aBwdY4N3Lwz+4OZvj6CwPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter capabilities
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 4:05 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 3:27 PM Joanne Koong <joannekoong@fb.com> wrote:
> >
> > This patch adds the kernel-side changes for the implementation of
> > a bitset map with bloom filter capabilities.
> >
> > The bitset map does not have keys, only values since it is a
> > non-associative data type. When the bitset map is created, it must
> > be created with a key_size of 0, and the max_entries value should be the
> > desired size of the bitset, in number of bits.
> >
> > The bitset map supports peek (determining whether a bit is set in the
> > map), push (setting a bit in the map), and pop (clearing a bit in the
> > map) operations. These operations are exposed to userspace applications
> > through the already existing syscalls in the following way:
> >
> > BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
> > BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
> > BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
> >
> > For updates, the user will pass in a NULL key and the index of the
> > bit to set in the bitmap as the value. For lookups, the user will pass
> > in the index of the bit to check as the value. If the bit is set, 0
> > will be returned, else -ENOENT. For clearing the bit, the user will pass
> > in the index of the bit to clear as the value.
> >
> > Since we need to pass in the index of the bit to set/clear in the bitmap
>
> While I can buy that Bloom filter doesn't have a key, bitset clearly
> has and that key is bit index. Are we all sure that this marriage of
> bit set and bloom filter is the best API design?
>

Adding on to this, as a user of the bpf helpers, peek, push, and pop have
meaning to me as operating on data structures for which those are well defined,
such as stacks and queues. For bitsets, "push"ing a bit doesn't make sense to
me as a concept, so needing to use bpf_map_push_elem to set a bit is not
intuitive to me. bpf_map_lookup_elem, bpf_map_update_elem, and
bpf_map_delete_elem make more sense to me (though if we have update, delete is
redundant).

> > whenever we do a lookup/clear, in the verifier layer this requires us to
> > modify the argument type of a bitset's BPF_FUNC_map_peek_elem and
> > BPF_FUNC_map_pop_elem calls to ARG_PTR_TO_MAP_VALUE; correspondingly, in
> > the syscall layer, we need to copy over the user value so that in
> > bpf_map_peek_elem and bpf_map_pop_elem, we have the specific
> > value to check.
> >
> > The bitset map may be used as an inner map.
> >
> > The bitset map may also have additional bloom filter capabilities. The
> > lower 4 bits of the map_extra flags for the bitset map denote how many
> > hash functions to use. If more than 0 hash functions is specified, the
> > bitset map will operate as a bloom filter where a set of bits are
> > set/checked where the bits are the results from the bloom filter
> > functions. Right now, jhash is function used; in the future, this can be
> > expanded to use map_extra to specify which hash function to use.
>
> Please make sure that map_extra is forced to zero for all the existing
> maps, for future extensibility.
>
> >
> > A few things to additionally please take note of:
> >  * If there are any concurrent lookups + updates in the bloom filter, the
> > user is responsible for synchronizing this to ensure no false negative
> > lookups occur.
> >  * Deleting an element in the bloom filter map is not supported.
> >  * The benchmarks later in this patchset can help compare the performance
> > of using different number of hashes on different entry sizes. In general,
> > using more hashes increases the false positive rate of an element being
>
> probably meant "decreases" here?
>
> > detected in the bloom filter but decreases the speed of a lookup.
> >
> > Signed-off-by: Joanne Koong <joannekoong@fb.com>
> > ---
> >  include/linux/bpf.h            |   2 +
> >  include/linux/bpf_types.h      |   1 +
> >  include/uapi/linux/bpf.h       |   9 ++
> >  kernel/bpf/Makefile            |   2 +-
> >  kernel/bpf/bitset.c            | 256 +++++++++++++++++++++++++++++++++
> >  kernel/bpf/syscall.c           |  25 +++-
> >  kernel/bpf/verifier.c          |  10 +-
> >  tools/include/uapi/linux/bpf.h |   9 ++
> >  8 files changed, 308 insertions(+), 6 deletions(-)
> >  create mode 100644 kernel/bpf/bitset.c
> >
>
> [...]
