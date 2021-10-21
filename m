Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F5A436CDF
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhJUVnv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 17:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhJUVnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 17:43:47 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717BC061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 14:41:30 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id q189so2522570ybq.1
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCBlmMv+4h0KUAZDzkwpjCJZcuL3IikEHeSPOdFIWg8=;
        b=nttSq40XmFsu0zd3ZuIgvJZfp3XxmzmbP3kLvrgGZMs+r5C/94H8RS8bfnie5AHiCR
         2O2Z4wf00Nr1o3wgvmgykpEpF4m/hg+wypLdxcYJkj+fET1YoSXwqqTdbxr+V0JLwYv2
         XS62HQeHSxmoce+rRYCxkWPuMYGEswYphzWqNcBaXUut9yv4k6IG3aMDKUxUv/RCGvMG
         T4/148FDjTCdrQa+pXJHQjFrq/Dk0rgw0jRqELqkypKrAI3ZbosfsWN2HnifFvaq579A
         jQA39onr9mU69SJbeuuJAmBI62mrbZMh8cswhto3SCH5jzKhFdShI5GXwAprV6cgTvk5
         iRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCBlmMv+4h0KUAZDzkwpjCJZcuL3IikEHeSPOdFIWg8=;
        b=Mu+u3nZ6zX+CTiI3j/UBpgWQxVwwBxRNPc5CxJ0tFnKS66ss/HIpEA0Tja7CDwmxp5
         odxrQaY+amfrgDo+rDFnedCiig/ArF5BW3kpxFItwrQexv2qGdlmUCbreF52pt1s/w03
         wDEX5MTPfiUQ0OG1QTubT+u132Hh3AFJfDO/DL+ilYZZPLhaSMxT6mckQp6cSE4GXbfP
         zDSSoe0ewn0wF7HJaeAOtvOCGEWtC6P0ToUrL3izxk7fs3i0yQv3NyLN83mNitlYTPKv
         AJt+NtA6G1s1BUOvPzDsN5NfaxGwa5xuiY4Htky0uJjY4rXQ1nrdzuas0aIJAzmKCWPa
         fP1Q==
X-Gm-Message-State: AOAM533RJd2bt3NtyQTaoHQdaOrl1mM/yJ0HFe2oOaraNKbHZ6HW7a/f
        YMhKlvPXBLflAk2J1AY+RYK2K5Tc54hV7AYqfCxN01tt+HyXXw==
X-Google-Smtp-Source: ABdhPJy4Q+xEB46Y/4qRtZ4nyG21VTWtSC5i+uvY/7PMTWrIwtvk8T9SPEiV2SFR93IHEZ28Z5gM0/u+mMTaq3/I8q8=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr9347014ybf.455.1634852489913;
 Thu, 21 Oct 2021 14:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-3-joannekoong@fb.com>
 <CAEf4BzarQqJc38ZQGTtSgfbkVtWPoRgj4xLqkkc7nEGw8RvkRQ@mail.gmail.com>
 <c7b2715c-7c67-a91a-32b7-d613853e4ffa@fb.com> <CAEf4BzZWGM_Bz=iM2vCs1gCAXGtTqFpPMVvtNhZwiGKXawSuTg@mail.gmail.com>
 <1e6778c7-3d6b-a389-0952-8c6f7a3f1574@fb.com>
In-Reply-To: <1e6778c7-3d6b-a389-0952-8c6f7a3f1574@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Oct 2021 14:41:19 -0700
Message-ID: <CAEf4BzbKBosYkeQMDxDvbBZb4ApwrEuHiaSDCLG_o-QD2jf2Zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] libbpf: Add "map_extra" as a per-map-type
 extra flag
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 1:14 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 10/20/21 2:21 PM, Andrii Nakryiko wrote:
>
> > On Wed, Oct 20, 2021 at 2:09 PM Joanne Koong <joannekoong@fb.com> wrote:
> >> On 10/8/21 4:19 PM, Andrii Nakryiko wrote:
> >>
> >>> On Wed, Oct 6, 2021 at 3:27 PM Joanne Koong <joannekoong@fb.com> wrote:
> >>>> This patch adds the libbpf infrastructure for supporting a
> >>>> per-map-type "map_extra" field, whose definition will be
> >>>> idiosyncratic depending on map type.
> >>>>
> >>>> For example, for the bitset map, the lower 4 bits of map_extra
> >>>> is used to denote the number of hash functions.
> >>>>
> >>>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> >>>> ---
> >>>>    include/uapi/linux/bpf.h        |  1 +
> >>>>    tools/include/uapi/linux/bpf.h  |  1 +
> >>>>    tools/lib/bpf/bpf.c             |  1 +
> >>>>    tools/lib/bpf/bpf.h             |  1 +
> >>>>    tools/lib/bpf/bpf_helpers.h     |  1 +
> >>>>    tools/lib/bpf/libbpf.c          | 25 ++++++++++++++++++++++++-
> >>>>    tools/lib/bpf/libbpf.h          |  4 ++++
> >>>>    tools/lib/bpf/libbpf.map        |  2 ++
> >>>>    tools/lib/bpf/libbpf_internal.h |  4 +++-
> >>>>    9 files changed, 38 insertions(+), 2 deletions(-)
> >>>>
> >>>> [...]
> >>>>
> >>>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >>>> index 7d1741ceaa32..41e3e85e7789 100644
> >>>> --- a/tools/lib/bpf/bpf.c
> >>>> +++ b/tools/lib/bpf/bpf.c
> >>>> @@ -97,6 +97,7 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
> >>>>           attr.btf_key_type_id = create_attr->btf_key_type_id;
> >>>>           attr.btf_value_type_id = create_attr->btf_value_type_id;
> >>>>           attr.map_ifindex = create_attr->map_ifindex;
> >>>> +       attr.map_extra = create_attr->map_extra;
> >>>>           if (attr.map_type == BPF_MAP_TYPE_STRUCT_OPS)
> >>>>                   attr.btf_vmlinux_value_type_id =
> >>>>                           create_attr->btf_vmlinux_value_type_id;
> >>>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> >>>> index 6fffb3cdf39b..c4049f2d63cc 100644
> >>>> --- a/tools/lib/bpf/bpf.h
> >>>> +++ b/tools/lib/bpf/bpf.h
> >>>> @@ -50,6 +50,7 @@ struct bpf_create_map_attr {
> >>>>                   __u32 inner_map_fd;
> >>>>                   __u32 btf_vmlinux_value_type_id;
> >>>>           };
> >>>> +       __u32 map_extra;
> >>> this struct is frozen, we can't change it. It's fine to not allow
> >>> passing map_extra in libbpf APIs. We have libbpf 1.0 task to revamp
> >>> low-level APIs like map creation in a way that will allow good
> >>> extensibility. You don't have to worry about that in this patch set.
> >> I see! From my understanding, without "map_extra" added to the
> >> bpf_create_map_attr struct, it's not possible in the subsequent
> >> bloom filter benchmark tests to set the map_extra flag, which
> > Didn't you add bpf_map__set_map_extra() setter for that? Also one can
> > always do direct bpf syscall (see sys_bpf in tools/lib/bpf/bpf.c), if
> > absolutely necessary. But set_map_extra() setter is the way to go for
> > benchmark, I think.
> bpf_map__set_map_extra() sets the map_extra field for the bpf_map
> struct, but that field can't get propagated through to the kernel
> when the BPF_MAP_CREATE syscall is called in bpf_map_create_xattr.
> This is because bpf_map_create_xattr takes in a "bpf_create_map_attr"
> struct to instantiate the "bpf_attr" struct it passes to the kernel, but
> map_extra is not part of "bpf_create_map_attr" struct and can't be
> added since the struct is frozen.

Oh, that's where the problem is. Libbpf internally doesn't have to use
bpf_create_map_xattr(). We are going to revamp all these low-level
interfaces to be extensible, but until then, I think it will be fine
to just create an internal helper that would allow us to create maps
without restrictions of maintaining API compatibility. See what we did
with libbpf__bpf_prog_load().

>
> I don't think doing a direct bpf syscall in the userspace program,
> and then passing the "int bloom_map_fd" to the bpf program
> through the skeleton works either. This is because in the bpf program,
> we can't call bpf_map_peek/push since these only take in a
> "struct bpf_map *", and not an fd. We can't go from fd -> struct bpf_map *
> either with something like
>
> struct fd f = fdget(bloom_map_fd);
> struct bpf_map *map = __bpf_map_get(f);
>
> since both "__bpf_map_get" and "fdget" are not functions bpf programs
> can call.

On BPF side there is no "struct bpf_map", actually. bpf_map_peek()
takes just "void *" which will be just a reference to the variable
that represents the map (and BPF verifier actually does the right
thing during program load, passing correct kernel address of the map).
On user-space side, though, user can use bpf_map__reuse_fd() to set
everything up, if they create map with their own custom logic.

But we are getting too much into the weeds. Let's just copy/paste
bpf_map_create_xattr() for now and add map_extra support there. And
pretty soon we'll have a nicer set of low-level APIs, at which point
we'll switch to using them internally as well.

>
>
> >> means we can't set the number of hash functions. (The entrypoint
> >> for propagating the flags to the kernel at map creation time is
> >> in the function "bpf_create_map_xattr", which takes in a
> >> struct bpf_create_map_attr).
> >>
> >> 1) To get the benchmark numbers for different # of hash functions, I'll
> >> test using a modified version of the code where the map_extra flags
> >> gets propagated to the kernel. I'll add a TODO to the benchmarks
> >> saying that the specified # of hash functions will get propagated for real
> >> once libbpf's map creation supports map_extra.
> >>
> >>
> >> 2) Should I  drop this libbpf patch altogether from this patchset, and add
> >> it when we do the libbpf 1.0 task to revamp the map creation APIs? Since
> >> without extending map creation to include the map_extra, these map_extra
> >> libbpf changes don't have much effect right now
> > No, getter/setter API is good to have, please keep them.
> >
> >>> [...]
> >>>> --
> >>>> 2.30.2
> >>>>
