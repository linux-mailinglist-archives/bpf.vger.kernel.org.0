Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F934B28A
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhCZXOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZXOA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 19:14:00 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585CC0613AA;
        Fri, 26 Mar 2021 16:13:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id l15so7524760ybm.0;
        Fri, 26 Mar 2021 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/LzATK/9qRelX8R7vtHQvT8vFHwsezBEAygRYwLnro=;
        b=J1VUpQ9weHKL9VqVzwF2S2lvPE2FjMRPLXeaf4IBagUB6yJbldtE1mhQKFueFt2XFw
         sRKIuMN+uaQfggTFG77k5Gwxi8e0LHbMoZO2YmmpWYFSsBjQ9UAyZv/wvpMe3Fxev1BL
         J3qme9cIn44KyKFKGh0WHxqH1zNLY4CnJw34Mfg+RdNNXj7IMTsrBMSZ5EoIaXsV5toE
         ZO+vSU+0GU+WFoyg6SOSpje2EYHNVNC2biZiuCaMvxjMyuVH/SfbdLOnda1O2xX4huR6
         r7zuX1MTQ/+4VBCDCVOU2Lo2aH/bIrobxUrGs1q8ZvfepnRVhyHp24mlyP4TIk7Fw9kn
         ozEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/LzATK/9qRelX8R7vtHQvT8vFHwsezBEAygRYwLnro=;
        b=bHF96yacH5XMmkNqLvyD3zGDCSYKG+dAOyWIbZ0FGxAKfkYU5iUbVQkC6Fr0/GIdb0
         5NEZT1bJy0dr4WraSjLQsfADmUX/QLDBtwfH0EfiQZC5+9Vsrl8JoDIL1TNZ4oM0Nzzn
         8WX27lSnwDet/4y+AhDmZie+0UnNONwEML9LzeiwQ+ARzXPGHidSGKIRw7iMPr2XDkpC
         K7Un2z3+vFbbSctVy0mdyJ3Xin8Y0TXUod8unbckNXP1qf7o/pw8SB4T9Yb83JYYk9+w
         SA1lgIthMVZ1YT7ye2lnBuVhEqy3xXx2GhWjSpKsqoE/jnSGFO7lp49jlwBrSemyBdAY
         lK4Q==
X-Gm-Message-State: AOAM5317XMWRYuwKpkFnDzh9NrM8ybas1LgtWRo0AIiC5Gg91gdoxOJe
        YB6q/ao8f65wRw4SnNwMJzYUOyA1PoGzY5Qdfx0=
X-Google-Smtp-Source: ABdhPJwOnCljnA9O8XA24iozCEgxy1QDvA1pb3P/j1bxpjzsn4e6HPuo4WVQ6nGVuVjofHql8E/NoBYqBeyj/GEDMtY=
X-Received: by 2002:a25:ab03:: with SMTP id u3mr16776242ybi.347.1616800439248;
 Fri, 26 Mar 2021 16:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210325065316.3121287-1-yhs@fb.com> <20210325065322.3121605-1-yhs@fb.com>
In-Reply-To: <20210325065322.3121605-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 16:13:48 -0700
Message-ID: <CAEf4BzYcfEjeRHD_aVPvJNXqtqR2Uso4Rt+Q4SmCk5+GUoAzEg@mail.gmail.com>
Subject: Re: [PATCH dwarves 1/3] dwarf_loader: permits flexible HASHTAGS__BITS
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 24, 2021 at 11:53 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, types/tags hash table has fixed HASHTAGS__BITS = 15.
> That means the number of buckets will be 1UL << 15 = 32768.
> In my experiments, a thin-LTO built vmlinux has roughly 9M entries
> in types table and 5.2M entries in tags table. So the number
> of buckets is too less for an efficient lookup. This patch
> refactored the code to allow the number of buckets to be changed.
>
> In addition, currently hashtags__fn(key) return value is
> assigned to uint16_t. Change to uint32_t as in a later patch
> the number of hashtag bits can be increased to be more than 16.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  dwarf_loader.c | 48 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index c106919..a02ef23 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -50,7 +50,12 @@ struct strings *strings;
>  #define DW_FORM_implicit_const 0x21
>  #endif
>
> -#define hashtags__fn(key) hash_64(key, HASHTAGS__BITS)
> +static uint32_t hashtags__bits = 15;
> +
> +uint32_t hashtags__fn(Dwarf_Off key)
> +{
> +       return hash_64(key, hashtags__bits);

I vaguely remember pahole patch that updated hash function to use the
same one as libbpf's hashmap is using. Arnaldo, wasn't that patch
accepted?

But more to the point, I think hashtags__fn() should probably preserve
all 64 bits of the hash?

> +}
>
>  bool no_bitfield_type_recode = true;
>
> @@ -102,9 +107,6 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
>         *(dwarf_off_ref *)(dtag + 1) = spec;
>  }
>
> -#define HASHTAGS__BITS 15
> -#define HASHTAGS__SIZE (1UL << HASHTAGS__BITS)
> -
>  #define obstack_chunk_alloc malloc
>  #define obstack_chunk_free free
>
> @@ -118,22 +120,41 @@ static void *obstack_zalloc(struct obstack *obstack, size_t size)
>  }
>
>  struct dwarf_cu {
> -       struct hlist_head hash_tags[HASHTAGS__SIZE];
> -       struct hlist_head hash_types[HASHTAGS__SIZE];
> +       struct hlist_head *hash_tags;
> +       struct hlist_head *hash_types;
>         struct obstack obstack;
>         struct cu *cu;
>         struct dwarf_cu *type_unit;
>  };
>
> -static void dwarf_cu__init(struct dwarf_cu *dcu)
> +static int dwarf_cu__init(struct dwarf_cu *dcu)
>  {
> +       uint64_t hashtags_size = 1UL << hashtags__bits;

I wish pahole could just use libbpf's dynamically resized hashmap,
instead of hard-coding maximum size like this :(

Arnaldo, libbpf is not going to expose its hashmap as public API, but
if you'd like to use it, feel free to just copy/paste the code. It
hasn't change for a while and is unlikely to change (unless some day
we decide to make more efficient open-addressing implementation).

> +       dcu->hash_tags = malloc(sizeof(struct hlist_head) * hashtags_size);
> +       if (!dcu->hash_tags)
> +               return -ENOMEM;
> +
> +       dcu->hash_types = malloc(sizeof(struct hlist_head) * hashtags_size);
> +       if (!dcu->hash_types) {
> +               free(dcu->hash_tags);
> +               return -ENOMEM;
> +       }
> +

[...]
