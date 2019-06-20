Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5DA4D0BF
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2019 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFTOtS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jun 2019 10:49:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40178 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfFTOtS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jun 2019 10:49:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so2340497oie.7
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2019 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oc33oE2xRX7hMJGSAcFuY8lZKfgw7nROACFzsI0WwOI=;
        b=Eh7ICkKyXMkCv/TtpjgQ8JZjnmbd0naf8A1vhbqimu7ktZFIbjgJPzEAa/wfGQsrW9
         VbVQEy9L3U6EY0VcOVbsb3XgLAi9E28VEHCjNrzKVyfHW4NENPRwQRvp0gh4gEHhjtho
         ok9T+XPuS0rlpe2RHpY4CPaLT0UltGy3Gmhk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oc33oE2xRX7hMJGSAcFuY8lZKfgw7nROACFzsI0WwOI=;
        b=t2cJNOYSiSveS4I9raW8bZbHQ30qLHbuUjjc44f2bSLerY3IvLkhlwdfrN1WEkCtKo
         hGwgjrGZJQHaiIfLN625IqrEjSHZGh/EuAZv59UEot2QZjz5Ps6HtMMdkWRVxxcSIRta
         3eGraG7EmUTBOFbjkprH/EHgaNV3X3Crt5/rfCSVVe/NHnXx333NVn1jJ1qOvprBAgE7
         f+ZiOi4LRvonGc87Vyteog8uR9Qq0b44VQIVWT3ikx/xQo2xMo/hRUFmHn8opBsPyI+B
         U5GVbRcJgtM4T8xQ48zlS5JX0O1B+yG5ws35biBIxeCkUxZvF4qMSGDEm06UPBsk5p5/
         z+5A==
X-Gm-Message-State: APjAAAX6pydua2OKsNxo1vp2hiTuY2atvdWjq3xaF9N7cRo3YfmKn7d1
        98R385RtdZPJxb8usLtkJ5LES3EvhfkC1jwNh+lXFQ==
X-Google-Smtp-Source: APXvYqxvxYTmfVhDwJTa+n6k0phZmVmXhu18TJeHQfxiQuwIspSmS+eyKRyGDEE8nlpM4YMv7tt2YJhqAY0aTJEe8eA=
X-Received: by 2002:aca:ea0b:: with SMTP id i11mr5821710oih.102.1561042157221;
 Thu, 20 Jun 2019 07:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190617192700.2313445-1-andriin@fb.com> <30a2c470-5057-bd96-1889-e77fd5536960@iogearbox.net>
 <CAEf4Bzae1CPDkhPrESa2ZmiOH8Mqf0KA_4ty9z=xnYn=q7Frhw@mail.gmail.com>
In-Reply-To: <CAEf4Bzae1CPDkhPrESa2ZmiOH8Mqf0KA_4ty9z=xnYn=q7Frhw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 20 Jun 2019 15:49:06 +0100
Message-ID: <CACAyw9-L0qx8d9O66SaYhJGjsyKo_6iozqLAQHEVa1AW-U=2Tg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/11] BTF-defined BPF map definitions
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 18 Jun 2019 at 22:37, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > I would just drop the object-scope pinning. We avoided using it and I'm not
> > aware if anyone else make use. It also has the ugly side-effect that this
> > relies on AF_ALG which e.g. on some cloud provider shipped kernels is disabled.
> > The pinning attribute should be part of the standard set of map attributes for
> > libbpf though as it's generally useful for networking applications.
>
> Sounds good. I'll do some more surveying of use cases inside FB to see
> if anyone needs object-scope pinning, just to be sure we are not
> short-cutting anyone.

I'm also curious what the use cases for declarative pinning are. From my
limited POV it doesn't seem that useful? There are a couple of factors:

* Systemd mounts the default location only accessible to root, so I have to
  used my own bpffs mount.
* Since I don't want to hard code that, I put it in a config file.
* After loading the ELF we pin maps from the daemon managing the XDP.

How do other people work around this? Hard coding it in the ELF seems
suboptimal.

> > And the loader should figure this out and combine everything in the background.
> > Otherwise above 'struct inner_map_t value' would be mixing convention of using
> > pointer vs non-pointer which may be even more confusing.
>
> There are two reasons I didn't want to go with that approach:
>
> 1. This syntax makes my_inner_map usable as a stand-alone map, while
> it's purpose is to serve as a inner map prototype. While technically
> it is ok to use my_inner_map as real map, it's kind of confusing and
> feels unclean.

I agree, avoiding this problem is good.

> So we came up with a way to "encode" integer constants as part of BTF
> type information, so that *all* declarative information is part of BTF
> type, w/o the need to compile-time initialization. We tried to go the
> other way (what Jakub was pushing for), but we couldn't figure out
> anything that would work w/o more compiler hacks. So here's the
> updated proposal:
>
> #define __int(name, val) int (*name)[val]

Consider my mind blown: https://cdecl.org/?q=int+%28*foo%29%5B10%5D

> #define __type(name, val) val (*foo)

Maybe it's enough to just hide the pointer-ness?

  #define __member(name) (*name)
  struct my_value __member(value);

> struct my_inner_map {
>         __int(type, BPF_MAP_TYPE_ARRAY);
>         __int(max_entries, 1000);
>         __type(key, int);
>         __type(value, struct my_value);

What if this did

  __type(value, struct my_value)[1000];
  struct my_value __member(value)[1000]; // alternative

instead, and skipped max_entries?

> static struct {
>         __int(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>         __int(max_entries, 1000);
>         __type(key, int);
>         __type(value, struct my_inner_map);
>         struct my_inner_map *values[];
> } my_initialized_outer_map SEC(".maps") = {
>         .values = {
>                 &imap1,
>                 [500] = &imap2,
>         },
> };
>
> Here struct my_inner_map is complete definition of array map w/ 1000
> elements w/ all the type info for k/v. That struct is used as a
> template for my_outer_map map-in-map. my_initialized_outer_map is the
> case of pre-initialization of array-of-maps w/ instances of existing
> maps imap1 and imap2.

For my_initialized_outer_map, which section does .values end up in the
generated ELF? How much space is going to be allocated? 501 * 4 bytes?

> The idea is that we encode integer fields as array dimensions + use
> pointer to an array to save space. Given that syntax in plain C is a
> bit ugly and hard to remember, we hide that behind __int macro. Then
> in line with __int, we also have __type macro, that hides that hateful
> pointer for key/value types. This allows map definition to be
> self-describing w/o having to look at initialized ELF data section at
> all, except for special cases of explicitly initializing map-in-map or
> prog_array.
>
> What do you think?

I think this is an interesting approach. One thing I'm not sure of is handling
these types from C. For example:

  sizeof(my_outer_map.value)

This compiles, but doesn't produce the intended result. Correct would be:

  sizeof(my_outer_map.value[0])

At that point you have to understand that value is a pointer so all of
our efforts
are for naught. I suspect there is other weirdness like this, but I need to play
with it a little bit more.

> Yeah I can definitely see some confusion here. But it seems like this
> is more of a semantics of map sharing, and maybe it should be some
> extra option for when we have automatic support for extern (shared)
> maps. E.g., something like
>
> __int(sharing, SHARE_STRATEGY_MERGE) vs __int(sharing, SHARE_STRATEGY_OVERWRITE)
>
> Haven't though through exact syntax, naming, semantics, but it seems
> doable to support both, depending on desired behavior.
>
> Maybe we should also unify this w/ pinning? E.g., there are many
> sensible ways to handle already existing pinned map:
>
> 1. Reject program (e.g., if BPF application is the source of truth for that map)
> 2. Use pinned as is (e.g., if BPF application wants to consume data
> from source of truth app)
> 3. Merge (what you described above)
> 4. Replace/reset - not sure if useful/desirable.

From my experience, trying to support many use cases in a purely declarative
fashion ends up creating many edge cases, and quirky behaviour that is hard to
fix later on. It's a bit like merging dictionaries in $LANGUAGE,
which starts out simple and then gets complicated because sometimes you
want to override a key, but lists should be concatenated, except in
that one case...

I wonder: are there many use cases where writing some glue code isn't
possible? With libbpf getting more mature APIs that should become easier and
easier. We could probably support existing iproute2 features that way as well.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
