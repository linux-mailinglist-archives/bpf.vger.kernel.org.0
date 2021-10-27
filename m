Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE343D0EB
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 20:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbhJ0Snw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 14:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbhJ0Snu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 14:43:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36498C061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 11:41:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o12so8784211ybk.1
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0pT67OqqaT0jPaEjhlWIrYHMDA5pXeavYXrAIGefeg=;
        b=dLlB+djVu5oVRvD6XWY/sNMsIskX0Mm3j/t0cJZDWicGBu/7r/FFsXQagjkd+aKi2C
         VdTOd6JgwQeL9/ErOhhhdCsQRU7JS2cwTGtMEY49XHLI4/jcsr2V5nA1IrSZkjvp9aHk
         up+3f919UtbiK/oy8MvnDdYZeoOp0tIflK5qeBTtRRazEFVXbEM+ktJTvecVpaYMo30s
         WZWuUsN7fxxQWIrD3BQ51m3PYOSoHlDKzNWEYmGMVoJQcQBUmgQNNqRmrPNE4aUNRKhY
         bDHSwDLKVzLs9He4eMLv6Po0aMccFMfDj5mKkFR5OAZoS7SFY7y0GZ43aKWhTIvz3/fg
         121w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0pT67OqqaT0jPaEjhlWIrYHMDA5pXeavYXrAIGefeg=;
        b=rD3SQHM1G/BaGghh9cIvfbvBtTpD94wNYOyvtEG7WU6Pbo6BzptjGXKyjzeha0wnxz
         Fm3/Og6jC/E29TqL2lOKiEGrI384aQUPU54puxeC+G6/Ch22lu3e/ExGzsPlTywrFFc6
         EYnTV4AH4/29G77+Jgu819xwrmL/xHQo+qc6hJ+XsMp1T11IRcMl98YgKmu4jGGhn6AY
         4hBblG4lZjEL58MPwwh3tzcspzqjczZbO/g1wgCVjXJ0h1v5uWlBPu+8gM9tR8f0TBky
         aLoyO/AWGKTXAWlSEp9jWd9v4HZHmu2OJtrnKUdGkWGgVN4XpzSGg/1cpgZfaQxJQDpp
         6R0Q==
X-Gm-Message-State: AOAM530J/XM1Pcz0lhK4HhOZ3szMTLwTeE0WC+e+z29kMQOekngCmVTs
        qc4KA2089xx1aNjAj6pSStGoXnj/1eLeD+DCn6P0uVVIMbQ=
X-Google-Smtp-Source: ABdhPJx0wi4cbLolbEpl6WQPKDJN8VUyiO6pPiIECqtQ5G1IRertqPRpcl1ISAjPlx0EOd1rAxTJWafVFUuY5SlExSc=
X-Received: by 2002:a25:b19b:: with SMTP id h27mr7934181ybj.225.1635360084460;
 Wed, 27 Oct 2021 11:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211022220249.2040337-1-joannekoong@fb.com> <20211022220249.2040337-3-joannekoong@fb.com>
 <3bc83103-6c5a-6cfb-9ea3-1b98fb50352b@fb.com> <1d6fff4c-eaaf-09d3-7d9f-4d5184048fd6@fb.com>
In-Reply-To: <1d6fff4c-eaaf-09d3-7d9f-4d5184048fd6@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Oct 2021 11:41:13 -0700
Message-ID: <CAEf4Bza1rz+R_nioirOqv1KxUPWuR7uBc5zQ+_EdWqnTJfbdDA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/5] libbpf: Add "map_extra" as a per-map-type
 extra flag
To:     Joanne Koong <joannekoong@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 11:39 AM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 10/26/21 8:30 PM, Andrii Nakryiko wrote:
>
> >
> > On 10/22/21 3:02 PM, Joanne Koong wrote:
> >> This patch adds the libbpf infrastructure for supporting a
> >> per-map-type "map_extra" field, whose definition will be
> >> idiosyncratic depending on map type.
> >>
> >> For example, for the bloom filter map, the lower 4 bits of
> >> map_extra is used to denote the number of hash functions.
> >>
> >> Please note that until libbpf 1.0 is here, the
> >> "bpf_create_map_params" struct is used as a temporary
> >> means for propagating the map_extra field to the kernel.
> >>
> >> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> >> ---
> >>   include/uapi/linux/bpf.h         |  1 +
> >>   tools/include/uapi/linux/bpf.h   |  1 +
> >>   tools/lib/bpf/bpf.c              | 27 ++++++++++++++++++++-
> >>   tools/lib/bpf/bpf_gen_internal.h |  2 +-
> >>   tools/lib/bpf/gen_loader.c       |  3 ++-
> >>   tools/lib/bpf/libbpf.c           | 41 ++++++++++++++++++++++++++++----
> >>   tools/lib/bpf/libbpf.h           |  3 +++
> >>   tools/lib/bpf/libbpf.map         |  2 ++
> >>   tools/lib/bpf/libbpf_internal.h  | 25 ++++++++++++++++++-
> >>   9 files changed, 96 insertions(+), 9 deletions(-)
> [...]
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index db6e48014839..751cfb9778dc 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -400,6 +400,7 @@ struct bpf_map {
> >>       char *pin_path;
> >>       bool pinned;
> >>       bool reused;
> >> +    __u64 map_extra;
> >>   };
> >>     enum extern_type {
> >> @@ -2313,6 +2314,17 @@ int parse_btf_map_def(const char *map_name,
> >> struct btf *btf,
> >>               }
> >>               map_def->pinning = val;
> >>               map_def->parts |= MAP_DEF_PINNING;
> >> +        } else if (strcmp(name, "map_extra") == 0) {
> >> +            /*
> >> +             * TODO: When the BTF array supports __u64s, read into
> >> +             * map_def->map_extra directly.
> >> +             */
> >
> > Please drop the TODO comment. There are no plans to extend BTF arrays
> > to support __u64 sizes.
> >
> I see, I will remove this.
>
> If BTF arrays never support __u64 sizes, then people won't be able to
> define a map in libbpf
> that uses bits 33 - 64 of the map_extra field, correct? Or is there a
> workaround for them that
> I'm not seeing?

Right, they won't be able to do it declaratively (if we ever need
higher 32 bits). They will still be able to specify map_extra
programmatically through bpf_map__set_map_extra() and with low-level
map creation APIs. So not ideal, but there will be a work-around.

>
> >
> > [...]
> >
