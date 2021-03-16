Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF433CDA6
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 06:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhCPFzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 01:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCPFzs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 01:55:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78022C06174A
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 22:55:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id u3so35640088ybk.6
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 22:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1i4tYu9mMeEof39nSIiL+YXFviVhBkiA1+sY09eWRUw=;
        b=VjSL1NgX9wYrfyEbjskBZiFQmlDEl1Z7AyL+ppHet7+gezza+5Ok/oO4VvjQC9wv+d
         WwP99LsSQIzcoQvzJSDTcPfUmiQsNdQu3Nh0T7FTVzlNWYsizrHkk8b9ibL2vEHEESxb
         OXk7ldpxuluW10FUvcA4PT/kU0Mux840kYI+nWvKrqOTyWpwI4IvRfQSg8PNr5jVG8H9
         rSLNXS2p5JeIQM7I+KuxA9Sibzjb6B1kcFFXibQlO3UZMK8oeRd8GXmS6mA/xtM43mPN
         5oQegTTG1x3ECUlLvScepCucbx9QUYf5N+MMY6dTfYfnIENR2wPMGaUhZMhfeQFkJYs5
         BKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1i4tYu9mMeEof39nSIiL+YXFviVhBkiA1+sY09eWRUw=;
        b=QHRdk3/hRX01E8WY4pk0/3FIEar9E5z2V1EUUarvW3ZHd4FRyG9yRJ4trQUUjLF0zS
         G0RthdyCqWTSWhAJLYCfGOndBBRmkRWlBfjY/YsJm2eTb3V1sbcP4OSJhR8szu74AibU
         A743j2ykC0sPeP8u3dZuRLM2W4vfRvfSICPX1Yj3WFoEYk6mCH4gyFahacZqCWUxb/AW
         e90LzEVOcASRwVPQ8xcO3oVfE9S/t5jrh4lKWCXjfbAYZEq+EeXO/Yzhj2fHUnJvAhJo
         fwXvIq0SOEjijjES+7JEmXjXBV5p1VWXsKlqS9sx1C+BghiY0+oTfAzO1UHCrP6C7dUg
         ySLQ==
X-Gm-Message-State: AOAM531q2Tn/NW/47oe4nYzAKTYeDv+08lyGznjI2EFTfdQ+fI/op0D3
        Svvjhfd1TqNoSknpdvGNvHubrLo7+1RdmCkeXnk=
X-Google-Smtp-Source: ABdhPJwyY3YJ/L/5ALH4VdFyPvWSjAXfu1cu4jIuFZfuJ2UVl3LIQQqiTJBEY5KJHLrjJVPTfZW9fja+PlV50lzy7LM=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr4590906yba.459.1615874147782;
 Mon, 15 Mar 2021 22:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <CANaYP3GTwpRMNrLNLLvOyaVzU6UiV-h2Ji=JwWeOJq4NBiJ_Bg@mail.gmail.com>
In-Reply-To: <CANaYP3GTwpRMNrLNLLvOyaVzU6UiV-h2Ji=JwWeOJq4NBiJ_Bg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Mar 2021 22:55:37 -0700
Message-ID: <CAEf4BzaFMhCrDSHuQH1uc9cBNuvuTKeXPam0Ux2LmuUM9anJJg@mail.gmail.com>
Subject: Re: libbpf pinning strategies - towards v1
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 14, 2021 at 8:40 AM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> As libbpf is heading towards a first major release, we wanted to
> discuss libbpf's object pinning strategy.
>
> bpf object pinning has a couple of use cases (feel free to add, there
> are more for sure):
> 1. Sharing specific bpf objects between different processes (for
> example, one process loads a bpf skeleton, another one interacts with
> it using various bpf maps (for example, for changing configurations
> (i.e. dynamic networking rules etc))
> 2. Preventing bpf objects from destruction upon owning process exit
> (i.e. to prevent bpf progs detach upon userspace program crash)
>
> Regarding the first use case, for most cases manually setting the pin
> path (both in the loading process and in other processes) will
> probably be the best. In such cases, no redesign is required here.
>
> For the second one, something like the bpf_object__pin will be more
> appropriate (to allow a complete reuse of the bpf objects). For that
> use case, some sensible requirements we can consider are:
>
> 1. Paths should be unique:
>     a. at the bpf_object level (that is, same pinnable objects that
> belong to different bpf_object s should be pinned at different paths).
>     b. in the same bpf_object, between different pinnable object types
> (i.e. a map and a prog) should always be pinned at different paths.
>     c. different objects, belonging to the same bpf_object and of the
> same type should be pinned at different paths.
> 2. Paths should be predictable, given enough information on the
> originating bpf_object (that is, adding random UID to ensure
> uniqueness is not an option).
>
> All the above should be applied to auto-pinned maps and the
> bpf_object__pin function. I am not sure if the
> bpf_object__pin_{maps,programs} should conform to those requirements
> too. Of course, all paths should be overridable similarly to the
> current implementation.

I actually think that bpf_object__pin_maps and
bpf_object__pin_programs should be removed.
bpf_object__pin()/bpf_object__unpin() and then per-map and per-program
API to control their pinning parameters should be enough to handle all
the cases.

>
> Regarding implementation, 1.c. will already be satisfied by the
> current implementation (after the program name pinning path will be
> changed, since both map names and function names are unique inside a
> single object).

That's going to change with BPF static linking. I'm thinking about
supporting static maps, i.e., maps visible within a single BPF .o
file, but still visible to outside world. At that point, each .o file
should be able to have conflicting map name, just as you'd expect to
have conflicting static variables and static functions. I haven't
thought yet all that is going to be expose  to user-space, though.

> For 1.a and 1.b, I think that bpf_object__pin should produce the
> following directory layout:
>
> <obj_name>
> =E2=94=9C=E2=94=80=E2=94=80 maps
> =E2=94=82      =E2=94=94=E2=94=80=E2=94=80 <map_name>
> =E2=94=94=E2=94=80=E2=94=80 programs
>         =E2=94=94=E2=94=80=E2=94=80 <program_name>
>
> If we decide that the requirements should apply to the specific
> bpf_object__pin_<type>s variants, then each will produce
>
> <obj_name>
> =E2=94=94=E2=94=80=E2=94=80 <type>s (i.e. maps, programs)
>         =E2=94=94=E2=94=80=E2=94=80 <name>
>
> It may be better to put all pinned objects under a objects/ directory
> too, I am not sure about that.

seems a bit of an overkill, first-level directory for an object seems nice

>
> As a last point, I think that it will be nice to have a way to pin a
> bpf_object_skeleton. This will be an improvement over the current
> bpf_object__pin since skeletons keep track of attached links.

Hm.. that's the first time this comes up. You mean that all the
created bpf_links (stored inside skel->links) will be pinned in such a
case? Those links would probably go under <obj_name/links/ directory,
right? Would we then need to generate something like
my_skeleton__load_pinned(), which would be called instead of
my_skeleton__load()?

>
> There are more use cases I am not familiar with for sure, so I would
> like to hear other's opinions and comments.

Yes, absolutely, I'd like to hear some more use cases as well.

I think we need to discuss more on how to manage pinning settings for
maps (including .data, .rodata, etc) and programs. Another aspect that
is rarely discussed but is important is compatibility and
upgradeability. I.e., what if pinned map is not exactly the same as
the one you expect in your BPF code (e.g., map value size increased,
etc). This is especially important for .data, .rodata special maps, as
BPF program code will reference variables through compiled-in offsets.
For such cases we'd need to validate that all expected/used variables
are still at the same place and have the same (or compatible?) sizes.

In short, there is a lot more subtlety to pinning that meets the eye,
which is why I hope that more people will get involved in the
discussion. I personally never had a use for pinning, so for me it's
hard to judge what's important in practice. But I do see a lot of
ambiguity and potential problems with re-using BPF maps and BPF
programs :)
