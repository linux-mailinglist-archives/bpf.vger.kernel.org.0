Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0E4273FE
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 01:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJHXHT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 19:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHXHT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 19:07:19 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBB6C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 16:05:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id d131so24330455ybd.5
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMPkq0CfY26XkKp7g1iUgKm13pqomgcLz8JH4GLVEXc=;
        b=DGnwJjM0jJ+apfrtuaCVVx58dgMmHKDmx6tC3ILx9EfHIQwVSF4fVCWIhlL7vGkH11
         4eazTiGkxHK8Ae3KNgXuRejD/jCXIr1MXKhdQsQPPFOamULwXskgZjHdqW6X14munL7/
         2RLrBLEaYRzWnhsCo0/qdXjlRS550mG8Cs2vUYjuanLbtnDQRdqI3HQ6t5EliBPcO8NK
         PNpQU6/4slrnarrxtxLfGt6rNHzg8NVZ0I9afRg08Wt9M1Y5Wjc3hDVTfD9jlB4h10QN
         Qdx0QgZ/uk6K5FM8hL2rYa3emgW6Rn/BL6HlGhHXkcffuKjz7Ol4L7VvBeAYT57dZ6v0
         WiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMPkq0CfY26XkKp7g1iUgKm13pqomgcLz8JH4GLVEXc=;
        b=RF4c3T/+qiufZqe4l26RCUhpiFSWf4PlDBg8y8rUMHsC4jryZT6DlphjaDWlWEZXHZ
         Zt2TCTK/GGog8pG1gB2/z7jjvV3Y5VKolW2TkgCgepSgGyIcv9+lRupKO9cIA4TbV3CK
         0ppXMOdN78Wa43TplEQPByzJ/IS4PKjk2FwwbwhRKfOn8IAzs1mqP5GNwfckh54zj0qU
         P66KgHWn5Q1aJAOFZ7XbR4yQ4DFFXFd3sD6y8fa+2arIieazQbQAQWK0HGansPCRZSCx
         WhMvrq1pMNgbnmp3pOYkS+0ZN/+0HDqY31KRr3DHQuwpSFPVmNWfIXWHJ743FVyArfCL
         kjOw==
X-Gm-Message-State: AOAM533Y6lXIpod/K4cN6edZyQH5QIMR9kiYLWq4jCiTkItSW6CkbDNb
        9TNGOZW7IztTS/aY1h/Ri+Kvrndlcp1JZ0dgdkSBCCjmoCk=
X-Google-Smtp-Source: ABdhPJwRA4jMdXYC3WLqt4MZdWWzQ6PvZQfnmC26vwTnR5VxeBOJVLJDZk2nffdkGMgPXhEijf7+jvUcspLaVnMc8io=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr6758703ybk.2.1633734322208;
 Fri, 08 Oct 2021 16:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-2-joannekoong@fb.com>
In-Reply-To: <20211006222103.3631981-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 16:05:11 -0700
Message-ID: <CAEf4Bzb9GJaKGSL5fgA468aUL70eJSiPvknARt-KWDViOqT7cQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter capabilities
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 3:27 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the kernel-side changes for the implementation of
> a bitset map with bloom filter capabilities.
>
> The bitset map does not have keys, only values since it is a
> non-associative data type. When the bitset map is created, it must
> be created with a key_size of 0, and the max_entries value should be the
> desired size of the bitset, in number of bits.
>
> The bitset map supports peek (determining whether a bit is set in the
> map), push (setting a bit in the map), and pop (clearing a bit in the
> map) operations. These operations are exposed to userspace applications
> through the already existing syscalls in the following way:
>
> BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
> BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
> BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
>
> For updates, the user will pass in a NULL key and the index of the
> bit to set in the bitmap as the value. For lookups, the user will pass
> in the index of the bit to check as the value. If the bit is set, 0
> will be returned, else -ENOENT. For clearing the bit, the user will pass
> in the index of the bit to clear as the value.
>
> Since we need to pass in the index of the bit to set/clear in the bitmap

While I can buy that Bloom filter doesn't have a key, bitset clearly
has and that key is bit index. Are we all sure that this marriage of
bit set and bloom filter is the best API design?

> whenever we do a lookup/clear, in the verifier layer this requires us to
> modify the argument type of a bitset's BPF_FUNC_map_peek_elem and
> BPF_FUNC_map_pop_elem calls to ARG_PTR_TO_MAP_VALUE; correspondingly, in
> the syscall layer, we need to copy over the user value so that in
> bpf_map_peek_elem and bpf_map_pop_elem, we have the specific
> value to check.
>
> The bitset map may be used as an inner map.
>
> The bitset map may also have additional bloom filter capabilities. The
> lower 4 bits of the map_extra flags for the bitset map denote how many
> hash functions to use. If more than 0 hash functions is specified, the
> bitset map will operate as a bloom filter where a set of bits are
> set/checked where the bits are the results from the bloom filter
> functions. Right now, jhash is function used; in the future, this can be
> expanded to use map_extra to specify which hash function to use.

Please make sure that map_extra is forced to zero for all the existing
maps, for future extensibility.

>
> A few things to additionally please take note of:
>  * If there are any concurrent lookups + updates in the bloom filter, the
> user is responsible for synchronizing this to ensure no false negative
> lookups occur.
>  * Deleting an element in the bloom filter map is not supported.
>  * The benchmarks later in this patchset can help compare the performance
> of using different number of hashes on different entry sizes. In general,
> using more hashes increases the false positive rate of an element being

probably meant "decreases" here?

> detected in the bloom filter but decreases the speed of a lookup.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  include/linux/bpf.h            |   2 +
>  include/linux/bpf_types.h      |   1 +
>  include/uapi/linux/bpf.h       |   9 ++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/bitset.c            | 256 +++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           |  25 +++-
>  kernel/bpf/verifier.c          |  10 +-
>  tools/include/uapi/linux/bpf.h |   9 ++
>  8 files changed, 308 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/bpf/bitset.c
>

[...]
