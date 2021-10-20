Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FA435536
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 23:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJTVXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 17:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVXg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 17:23:36 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54BC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:21:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i84so14180657ybc.12
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xw34hjBdMiuVB4rooho3nUvol4KKygQ/hlujYoHcXNw=;
        b=VxcqKvzgm1G9MefjHvb6DGKvEXmnqv+kPstVHQNjg8kcmyeKPRcCaba7hK308/+NaL
         l/Zbt5qiXGkr5I0Jqja0ApibTjN7wEGDaS2OMuUojt+yNj9JzUaUoNhb2DgOXBRVc2hr
         WDNGJkHbIUOigOwZwttMRs8HgFnS7RnQDaiSvdb75DUbqRzDz+iMgI0gGJT53EK3WfaI
         dJv/hxmUS/BTEn1Vl2nRAj6zhQ8xc0vO9T4AESHqyhzI2VSOsoFmQJn0TBwAWvUZTv7/
         m+VZjM1bSdZjZpNoUdMNsV+qfTuyNMk0AhPyOHum1HVpfMFHMUeJicdXTQowMfIrq4Sq
         UFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xw34hjBdMiuVB4rooho3nUvol4KKygQ/hlujYoHcXNw=;
        b=1DX6AOBsW3GZKIbmu0k0VOVzO7U7p5j1U2XklOBYtIdYXCTk/xrSyY4rKvxmF+yJ79
         7tlidowaIV78wayjSgkZkAchdQ/3OR1B8GOwMXUp6lBvZpntaV8CGWYkh1FQIQbxvhv0
         evPMiuENPy6A1rV5z+W/STvpVmnOCIwbbUGWKqKrnCePl5q0oJpxS2QBTItLso7Oegjy
         6lyiqUHKyVnOi10BBHPyoTFMpi2cYA5eTr/fSlu1Ux53IGiT0BLClAZbl98lFHPtoGNp
         SuNvQj66cMYMyKiqtA1+g5YXwrgm5mkch1ttgJQGm+HUeSgCs2ZQpAm2fbvYmxKbx4HQ
         MuUw==
X-Gm-Message-State: AOAM5307MVNL6rMpBBtjS9zNUrA6RCfFfuUsi8ylP4wfBR5mbPFYAY2r
        qCalN5Qw+il9zACkzoXpzzMAo+RbwvsEAQEBdz42+5+w9iaKrg==
X-Google-Smtp-Source: ABdhPJx1MaJtMkYmR7HTQavJjisx5tYqLr/y04EOnYnDohzoJWTMDa3NsQ3eED6uC47xh5i/3S3Lryj6yfXpK7uDfR8=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr1455614ybh.267.1634764880880;
 Wed, 20 Oct 2021 14:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-3-joannekoong@fb.com>
 <CAEf4BzarQqJc38ZQGTtSgfbkVtWPoRgj4xLqkkc7nEGw8RvkRQ@mail.gmail.com> <c7b2715c-7c67-a91a-32b7-d613853e4ffa@fb.com>
In-Reply-To: <c7b2715c-7c67-a91a-32b7-d613853e4ffa@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 14:21:09 -0700
Message-ID: <CAEf4BzZWGM_Bz=iM2vCs1gCAXGtTqFpPMVvtNhZwiGKXawSuTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] libbpf: Add "map_extra" as a per-map-type
 extra flag
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 2:09 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 10/8/21 4:19 PM, Andrii Nakryiko wrote:
>
> > On Wed, Oct 6, 2021 at 3:27 PM Joanne Koong <joannekoong@fb.com> wrote:
> >> This patch adds the libbpf infrastructure for supporting a
> >> per-map-type "map_extra" field, whose definition will be
> >> idiosyncratic depending on map type.
> >>
> >> For example, for the bitset map, the lower 4 bits of map_extra
> >> is used to denote the number of hash functions.
> >>
> >> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> >> ---
> >>   include/uapi/linux/bpf.h        |  1 +
> >>   tools/include/uapi/linux/bpf.h  |  1 +
> >>   tools/lib/bpf/bpf.c             |  1 +
> >>   tools/lib/bpf/bpf.h             |  1 +
> >>   tools/lib/bpf/bpf_helpers.h     |  1 +
> >>   tools/lib/bpf/libbpf.c          | 25 ++++++++++++++++++++++++-
> >>   tools/lib/bpf/libbpf.h          |  4 ++++
> >>   tools/lib/bpf/libbpf.map        |  2 ++
> >>   tools/lib/bpf/libbpf_internal.h |  4 +++-
> >>   9 files changed, 38 insertions(+), 2 deletions(-)
> >>
> >> [...]
> >>
> >> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >> index 7d1741ceaa32..41e3e85e7789 100644
> >> --- a/tools/lib/bpf/bpf.c
> >> +++ b/tools/lib/bpf/bpf.c
> >> @@ -97,6 +97,7 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
> >>          attr.btf_key_type_id = create_attr->btf_key_type_id;
> >>          attr.btf_value_type_id = create_attr->btf_value_type_id;
> >>          attr.map_ifindex = create_attr->map_ifindex;
> >> +       attr.map_extra = create_attr->map_extra;
> >>          if (attr.map_type == BPF_MAP_TYPE_STRUCT_OPS)
> >>                  attr.btf_vmlinux_value_type_id =
> >>                          create_attr->btf_vmlinux_value_type_id;
> >> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> >> index 6fffb3cdf39b..c4049f2d63cc 100644
> >> --- a/tools/lib/bpf/bpf.h
> >> +++ b/tools/lib/bpf/bpf.h
> >> @@ -50,6 +50,7 @@ struct bpf_create_map_attr {
> >>                  __u32 inner_map_fd;
> >>                  __u32 btf_vmlinux_value_type_id;
> >>          };
> >> +       __u32 map_extra;
> > this struct is frozen, we can't change it. It's fine to not allow
> > passing map_extra in libbpf APIs. We have libbpf 1.0 task to revamp
> > low-level APIs like map creation in a way that will allow good
> > extensibility. You don't have to worry about that in this patch set.
> I see! From my understanding, without "map_extra" added to the
> bpf_create_map_attr struct, it's not possible in the subsequent
> bloom filter benchmark tests to set the map_extra flag, which

Didn't you add bpf_map__set_map_extra() setter for that? Also one can
always do direct bpf syscall (see sys_bpf in tools/lib/bpf/bpf.c), if
absolutely necessary. But set_map_extra() setter is the way to go for
benchmark, I think.

> means we can't set the number of hash functions. (The entrypoint
> for propagating the flags to the kernel at map creation time is
> in the function "bpf_create_map_xattr", which takes in a
> struct bpf_create_map_attr).
>
> 1) To get the benchmark numbers for different # of hash functions, I'll
> test using a modified version of the code where the map_extra flags
> gets propagated to the kernel. I'll add a TODO to the benchmarks
> saying that the specified # of hash functions will get propagated for real
> once libbpf's map creation supports map_extra.
>
>
> 2) Should I  drop this libbpf patch altogether from this patchset, and add
> it when we do the libbpf 1.0 task to revamp the map creation APIs? Since
> without extending map creation to include the map_extra, these map_extra
> libbpf changes don't have much effect right now

No, getter/setter API is good to have, please keep them.

>
> What are your thoughts?
>
> > [...]
> >> --
> >> 2.30.2
> >>
