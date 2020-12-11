Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6F2D6E46
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 04:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbgLKC7S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 21:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390721AbgLKC6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 21:58:39 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE74C0613CF;
        Thu, 10 Dec 2020 18:57:59 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v67so6771430ybi.1;
        Thu, 10 Dec 2020 18:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42bVQz1GyxUU1ys3oBydFOatnbT6H3ccJxNs8l0OHMw=;
        b=tDmfRcqs6Vn3dee60OSOvHO1SJbGubyu7jNN1uUj0a8QGL/Ne24tOPcdGU+b3toJbH
         foKkq3ntiN2d9l5NxywTN9w82M4iDVIL52Gk1EjZktS97ZSybK1eTlEr/Nfk0XRrlY9L
         ye7h0FD5ySlI4UwtXZ7XoP2PZnSbw2fNFWdJ3jDgI3K1CalIgKjyCl3P7N9jtakroQPE
         41JJbsAkWcBhE9ZPdbv7Kgcdr8qXDtv5Cm/tVNq+Mr/79etQY+xphuvxQwLe74vqo9eg
         kicsizhDxEaLbAMFlZk+GwP2d+CmUbJ0MT6xJxDBDIyKw1f/LssDNELwyZv1lmTzCXT1
         2Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42bVQz1GyxUU1ys3oBydFOatnbT6H3ccJxNs8l0OHMw=;
        b=BYHjl2iHwXCgI7H2mpTkakj52tKgQHITgxVI3vACvWbeVTr2tQ3iN7nUUir/wO+Mm6
         x/mP/v2/+Sqpw/qU2NPXeSfN/9yzK3WV8GrbFy/XEpch8RQL538TOYYPCO0+sbGV/Kuv
         uVVRgyBT/TLMzGbEDbzvoHSitFM0e6tbl8gYKjNpsssVLr1k9VwQnJWbenTmKJlf5PMG
         M6SR4hLXlImEj3Z4IPxKetg1ZkcTGdaKNpwBUVSuiMWBb42KNeAVAYztlP6QrXNX97Tj
         MUvApFPAXq9chhRFlLOfzrr/Wbs7V5dPU1ymGF4rp0OguuqsFKzEe/xHcn/ttD+fBlME
         MM6g==
X-Gm-Message-State: AOAM530Gbg6JXkAkZzLjzGnFYd+ljo4O4f7XW8EIawHIUPv9hhqdwX7v
        oglxonZ8jHp7k8Xy1jAGKlDcPmzx2SpqmoIS/dE=
X-Google-Smtp-Source: ABdhPJxZPJyBtwsXDwvjci/veBAdzQu3S+8TBkqhlUc1twmEYv7+9/8cWltUINLVyJuw7cTuWTaPpHttzwi02tNFeOY=
X-Received: by 2002:a25:d44:: with SMTP id 65mr15796615ybn.260.1607655478713;
 Thu, 10 Dec 2020 18:57:58 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
 <20201210164315.GA184880@krava> <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
 <20201210234201.GC186916@krava> <CAEf4BzbJY5w1nbY7k593wHJcMZwS0mw8mDoCpsH_BdDbLUOYyQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbJY5w1nbY7k593wHJcMZwS0mw8mDoCpsH_BdDbLUOYyQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Dec 2020 18:57:48 -0800
Message-ID: <CAEf4BzYXN5aJ6Ti16LvPtqq1xiU9NUVKTq9fZfUuCBkF+5k2QQ@mail.gmail.com>
Subject: Re: Per-CPU variables in modules and pahole
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 10, 2020 at 3:49 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 10, 2020 at 3:42 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Dec 10, 2020 at 09:02:05AM -0800, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > >
> > > yes, ELF symbol's value is 4, but when iterating DWARF variables
> > > (0x10e70 + 4) is returned. It does look like a special handling of
> > > modules. I missed that libdw does some special things for specifically
> > > modules. Further debugging yesterday showed that 0x10e70 roughly
> > > corresponds to the offset of .data..per_cpu if you count all the
> > > allocatable data sections that come before it. So I think you are
> > > right. We should probably centralize the logic of kernel module
> > > detection so that we can handle these module vs non-module differences
> > > properly.
> > >
> > > >
> > > > not sure this is related but looks like similar issue I had to
> > > > solve for modules functions, as described in the changelog:
> > > > (not merged yet)
> > > >
> > > >     btf_encoder: Detect kernel module ftrace addresses
> > > >
> > > >     ...
> > > >     There's one tricky point with kernel modules wrt Elf object,
> > > >     which we get from dwfl_module_getelf function. This function
> > > >     performs all possible relocations, including __mcount_loc
> > > >     section.
> > > >
> > > >     So addrs array contains relocated values, which we need take
> > > >     into account when we compare them to functions values which
> > > >     are relative to their sections.
> > > >     ...
> > > >
> > > > The 0x10e74 value could be relocated 4.. but it's me guessing,
> > > > because not sure where you see that address exactly
> > >
> > >
> > > It comes up in cu__encode_btf(), var->ip.addr is not 4, as we expect it to be.
> >
> > I'm taking section sh_addr for each function and relocate
> > the addr value for kernel modules, check setup_functions
> > function
> >
> > I don't see this being somehow centralized, looks simple
> > enough to me for each case
>
> I meant centralized detection of whether we are working with the
> module or vmlinux or something else. setup_functions() currently has
> very specific heuristic for that. So I'd like to extract that or come
> up with some other way that won't be so function specific
> (__start_mcount_loc symbol vs __mcount_loc section).
>

This seems to be unnecessary, actually. We already record
btfe->percpu_base_addr, which for vmlinux is always zero, while for
module non-zero. So just subtracting this base addr before looking up
ELF symbol solves the problem for me and still works for vmlinux. So
I'm going with that for now.

> >
> > jirka
> >
