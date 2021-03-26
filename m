Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D0534A007
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 04:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhCZDBM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 23:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhCZDBJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 23:01:09 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58182C06174A
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 20:01:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 8so4396118ybc.13
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 20:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2E8C3aVezk7jwZdjAJmvZRewv3javcMFWMxEKuk+CQA=;
        b=IdXjgcha9rTQ67uV9pHsqWzgGbFV431CusTFMqbOL3EVNMwxFXwVzcoLm9GkK08cue
         hTCU+ZgImtNoJVcpPMRsipMfXml4JYM/HjkARB/2gnXIM/83Bh2+jkkBVSX6l9cN/Kn/
         wtNLMuppw3CQ9QtgLhAa85NmimhuobQo40WbLT/FFBD0oFR5JJGi3rjrCzOe9OFrkz/e
         XJYNYvJEonFN+YCtnYoHSpKUC/BwpaqosqbLP062/z9MTEBvvHH7hLaRSycm2e7qDaWL
         SVGUbIgIWsjVVQnDJ4JELVTlx8uhwcuw91CtkhivsceSBf3ESu55tx/lQILCqZUDads4
         UIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2E8C3aVezk7jwZdjAJmvZRewv3javcMFWMxEKuk+CQA=;
        b=V4GbeC5Oakk+d2FfegrIU9uRgaV8+uVa72OyvqQ1BWHX6EJCkf3UbXBmsoy//RYhqg
         Exq3fx+iuNx7InEP/dcdD4KRbx8Xfzd69+ShHoDW6vLziEUM50IXdYQQR83F8mC6Ih9p
         uzylaKxnpV9opShCnd8YdzmMGXI5ZUoBb6D/iPUIagCWWOpPoyTgmoTggPaZN3CSKqv5
         i35wDxrDtVlDi7Wkjt9cO/aeYmWNXnfoCU4G3lyPQda1xeNNVqnB4WlNl/6kS7WoGx2N
         xFCgmmNaJy1GGRB94QrXLTxWbM12J6ZjEezOJ7y4w4JrZj0H/Gf8fszlj0EEYBT30o/q
         KnhA==
X-Gm-Message-State: AOAM530E6Hx+kjJjd3nVJuVPruXopPEfueDoA0fK3ebdWkI4PjcZzq3I
        lZtyTcTVY0+Twy5uaDDnJd/GPaM4gJrqphpluuY=
X-Google-Smtp-Source: ABdhPJySRzgNaVXkwuefV5Fw7Y4BQIzgJ1fTNQ4IczucEetkzqk65Go+nVOS6SwuL8KJCkojzxsBODRlIqxwTegEj/M=
X-Received: by 2002:a25:ab03:: with SMTP id u3mr10312553ybi.347.1616727668543;
 Thu, 25 Mar 2021 20:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210323040952.2118241-1-rafaeldtinoco@ubuntu.com>
 <60597d21d7eed_45ba42086@john-XPS-13-9370.notmuch> <CAEf4BzaY-iBDNg5m7EfW355HjZxayydFRHGN9P95oT-Ovm2Mpg@mail.gmail.com>
 <605d312ebe3e6_938e5208e@john-XPS-13-9370.notmuch>
In-Reply-To: <605d312ebe3e6_938e5208e@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Mar 2021 20:00:57 -0700
Message-ID: <CAEf4BzbESgQGNmU-=EzDx+JKE7j3ziA2DisYrOdA8NdJyNaBFA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] libbpf: add bpf object kern_version attribute setter
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 25, 2021 at 5:56 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > On Mon, Mar 22, 2021 at 10:31 PM John Fastabend
> > <john.fastabend@gmail.com> wrote:
> > >
> > > Rafael David Tinoco wrote:
> > > > Unfortunately some distros don't have their kernel version defined
> > > > accurately in <linux/version.h> due to different long term support
> > > > reasons.
> > > >
> > > > It is important to have a way to override the bpf kern_version
> > > > attribute during runtime: some old kernels might still check for
> > > > kern_version attribute during bpf_prog_load().
> > > >
> > > > Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c   | 10 ++++++++++
> > > >  tools/lib/bpf/libbpf.h   |  1 +
> > > >  tools/lib/bpf/libbpf.map |  1 +
> > > >  3 files changed, 12 insertions(+)
> > > >
> > >
> > > Hi Andrii and Rafael,
> > >
> > > Did you consider making kernel version an attribute of the load
> > > API, bpf_prog_load_xattr()? This feels slightly more natural
> > > to me, to tell the API the kernel you need at load time.
> >
> > Um... kern_version is already part of bpf_load_program_attr, used by
> > bpf_load_program_xattr. What am I missing? But you can't use that with
> > bpf_object APIs.
>
> Aha I mistyped. It looks like I have a patch floating around on my
> stack to add it to bpf_object_load_attr.

Oh, you meant this one. I'm actually trying to move away from having
load() to take options at all. If you check BPF skeletons, their load
doesn't even accept options. Adding getters/setter is better in one
major way:
  - it's more flexible approach and allows to have both per-object
setters/options and per-program ones. bpf_object_load_attr provides
only per-object options, which are often inadequate (see recent
bpf_program__set_attach_target() and bpf_program__set_autoload(),
which are just impossible to sanely do with per-object options)
  - even though we now have the whole forward/backwards compatible
OPTS "framework" within libbpf, I think it's less pleasant to use than
setters. We have to do options on load, because we don't have any
object before open happens (if we had separate new() and open() that
wouldn't be the case), so there is a need to specify things before
bpf_object is instantiated. bpf_object__load() doesn't have this
problem, because we have entire bpf_object and bpf_map/bpf_program to
tweak before we perform load.
  - adding new APIs is inherently forward compatible. And backwards
compatibility is the same between OPTS and new API methods: you need
to make sure to use recent enough libbpf version that has options/API
you need.

So in short, I'm against adding load-time options, because there are
better and more flexible alternatives.

>
>
> > >
> > > Although, I don't use the skeleton pieces so maybe it would be
> > > awkward for that usage.
> >
> > Yes, low-level APIs are separate. This is for cases where you have
> > struct bpf_program abstractions, which are loaded by
> > bpf_object__load(). We could set it at per-program level, but they
> > should be all the same, so bpf_object__set_kversion() makes more sense
> > and is more convenient to use. And there is already a getter for that,
> > so it complements that nicely.
>
> +1
>
> >
> > >
> > > Sorry, missed v1,v2 so didn't reply sooner.
> > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 058b643cbcb1..3ac3d8dced7f 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -8269,6 +8269,16 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
> > > >       return obj->btf ? btf__fd(obj->btf) : -1;
> > > >  }
> > > >
> > > > +int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
> > > > +{
> > > > +     if (obj->loaded)
> > > > +             return -EINVAL;
> > > > +
> > > > +     obj->kern_version = kern_version;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > >
> > > Having a test to read uname and feed it into libbpf using
> > > above to be sure we don't break this in the future would be
> > > nice.
> >
> > kern_version has been ignored by kernel for a long time. So there is
> > no way to test this in selftests/bpf. We could use libbpf CI's old
> > kernel setup to validate, but I don't think it's worth it. It's
> > extremely unlikely this will ever change or break (and it's a legacy
> > stuff we move away from anyways, so it's born sort of obsolete).
>
> +1
>
> For the patch, thanks for the details Andrii, thanks for the patch
> Rafael it will be useful here.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
