Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9A28C823
	for <lists+bpf@lfdr.de>; Tue, 13 Oct 2020 07:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgJMFNS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Oct 2020 01:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgJMFNS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Oct 2020 01:13:18 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3ABC0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 22:13:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so19488712edi.7
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 22:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMHtvZpCo0ogUR6/0zzxRX8v6JY0sit/IBYq8ZR4jrs=;
        b=gCvDnplOpnWa6rSTrIF6GLhOMk2HMbpRLl5bywzs9mOThcjFMMMRIiIq7VkhATxMnS
         snWavCO8nn7cWUAfvFgklhKJTdTVJEI1ymtZjZaUmQWHEHl7hDpAK4SSwIaelIusPNQX
         tlVmkEYnfR7+7ZunKIEBbc41CqQORyTppLFK4T+IDD0zAs5QKTZDnlxX0Vw425vX1lQD
         1wyABgWpoZ40MuXnvoCri9f6swEOuhzzaZlUtc91a/VXFXOiBSBnibrxYdw3pMgVWbjA
         3nR6tREtHwJcHETQKDwG5z1fuViPeUpixg9ekaR+wO4BjtRDxNzr3NuSwWzaCbQS8eIo
         Qb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMHtvZpCo0ogUR6/0zzxRX8v6JY0sit/IBYq8ZR4jrs=;
        b=dMZT0KqmbTpvbOR1D7IWzwkTsYp5xgxci8V7W2Dx0pnGB5pasCKakNYbHqwn+OHYXZ
         CAAmqdWCbiF+OoGFOBf+RTX8/WtpyK84NDx7mvOvZHBslpWdBWwXsyDEPFeGATKoDznz
         UO7tUEycS7L7AvVwvIrCjEuCjxEvZ6oT901skQ8uU+ANYJzFcw5tbYV5RR3hVGLkd5JU
         Mlcg7V3YYuc2NKr35raZRhIjvRIndsj/uDZ6LnkRBFTgjfYBYuBQi6sn/w8cmmyt41GJ
         HBw4AaRIAyuMWcY8X2lSUA4yH/7LgdrGDgldAHIsjDi/bWfaLdDKDnxd1pgrJ3jZ8quj
         bvIw==
X-Gm-Message-State: AOAM531zcOEebMeDIzDJ1az/14RiLo183la56kLab5D7s+a2OOdgknMf
        PzKacPezt9eAq+3TVnxI+Sm1uHZA75B1/K6R+A==
X-Google-Smtp-Source: ABdhPJxwU8sHOQKAv1e6VJPYPTx8vjfLp9dvNqJgBvwleLeKjJtwPSkyJMrpOuvJGtgoo6inqgCx6GuJzRv4mthSqCo=
X-Received: by 2002:a05:6402:21fd:: with SMTP id ce29mr17683133edb.383.1602565996989;
 Mon, 12 Oct 2020 22:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAEKGpzh70f06iMQdR3B1LF3hMwHnB=x92fvfV8+smQObvKBF_w@mail.gmail.com>
 <CAEf4BzYzhykW_VC8Q-Sa5x9u+MdEO0zfmrgbkShSQDH4F5AsMw@mail.gmail.com>
In-Reply-To: <CAEf4BzYzhykW_VC8Q-Sa5x9u+MdEO0zfmrgbkShSQDH4F5AsMw@mail.gmail.com>
From:   "Daniel T. Lee" <danieltimlee@gmail.com>
Date:   Tue, 13 Oct 2020 14:13:01 +0900
Message-ID: <CAEKGpzg3WV2ffuapR+eif32XCnGb=KW9OQ7zYEZu8Z4RqqVEYQ@mail.gmail.com>
Subject: Re: Where can I find the map's BTF type key/value specification?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 11, 2020 at 9:06 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Oct 10, 2020 at 3:50 AM Daniel T. Lee <danieltimlee@gmail.com> wrote:
> >
> > I'm looking for how BTF type definition '__type(key, int)' is being changed
> > to '__uint(key_size, sizeof(int))'. (Not exactly "changed" but wonder how
> > it can be considered the same)
>
> __type(key, int) captures both BTF ID of key and determines key_size
> based on that type. You can specify both key and key_size, but that's
> unnecessary (and resulting key size still has to match).
>
> >
> >     __uint(type, BPF_MAP_TYPE_ARRAY);
> >     __type(key, int);          => __uint(key_size, sizeof(int))
> >     __type(value, u32);    => __uint(value_size, sizeof(u32))
> >     __uint(max_entries, 2);
> >
> > Whether the specific map type supports BTF or not can be inferred from
> > the file in kernel/bpf/*map.c and by checking each MAP type's
> > bpf_map_ops .map_check_btf pointer is initialized as map_check_no_btf.
> >
> > But how can I figure out that specific types of map support BTF types for
> > key/value? And how can I determine how this BTF key/value type is
> > converted?
>
> I think you answered your own question, you just search whether each
> map implements .map_check_btf that allows key/value BTF type ID. E.g.,
> see array_map_check_btf, which allows key/value type ID. And compare
> to how perf_event_array_map_ops use map_check_no_btf for its
> .map_check_btf callback.
>
> So you can search for all struct bpf_map_ops declarations to see
> operations for all map types, and then see what's there for
> .map_check_btf. Ideally we should extend all maps to support BTF type
> ID for key/value, but no one signed up to do that. If you are
> interested, that should be a good way to contribute to kernel itself.
>
> >
> > I am aware that BTF information is created in the form of a compact
> > type by using pahole to deduplicate repeated types, strings information
> > from DWARF information. However, looking at the *btf or pahole file
> > in dwarves repository, it seemed that it was not responsible for the
> > conversion of the BTF key/value.
> >
> > The remaining guess is that LLVM's BPF target compiler is responsible
> > for this, or it's probably somewhere in the kernel, but I'm not sure
> > where it is.
>
> BTF for the BPF program is emitted by Clang itself when you specify
> `-target bpf -g`. pahole is used to convert kernel's (vmlinux) DWARF
> into BTF and embed it into vmlinux image.
>
> As for key/value BTF type id for maps, that's libbpf parsing map
> definition and recording type IDs. So there are a few things playing
> together. See abd29c931459 ("libbpf: allow specifying map definitions
> using BTF") that introduced this feature.
>
> >
> > --
> > Best,
> > Daniel T. Lee


Thank you for taking the time and effort for the answer.
After following the implementation of key/value BTF type ID, A rough picture
began to be drawn.

What I didn't know well was clearly understood thanks to your explanation.

I'll look forward to contributing to this in the foreseeable future.

-- 
Best,
Daniel T. Lee
