Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58020349B0A
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 21:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCYUgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhCYUfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 16:35:52 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243BC06174A
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 13:35:52 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i144so3664796ybg.1
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLBDX260KdMlx7irGJ7leqchQKey3s/Vuzhty7bANVY=;
        b=kXx1hwATZZ4dTZI1UEGQQcq3yZLBatwDS1UMurU1M9RfJs5cX9ZIGrOkM8M5jsql2V
         76J2DUoBUe66OsuXTTx2rrFzsQyB2k2WmLtymN2URA8D7TiZxtAQFajUcJ7kmF7GOGoO
         0yEv6C2WA2OeB8N0ImwtLuirVv5rPiTEl/qaeRVd6gsgdWpzoIBKg59UA8yPuHmhPsCV
         t0ZMvvT37ZWMtwAxDD7TstE5J3sytnDl4jmfWh9LfPuopaCKE6J4shtLX6qjDFJ8qlgr
         U7EVsB3+4RxlTZKxXeGAo/vmnbs7/TIpfZgLsBG3Gooa0qgPGifq0CbB97FtNNxeP8Pm
         pk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLBDX260KdMlx7irGJ7leqchQKey3s/Vuzhty7bANVY=;
        b=tD7xNJdjG9wO6rB+6vL8zaQQnghF+iT7OxFslvX5CtbGduHWSu7Yv+/2n3w8lmsQds
         AahdxPLg47e7TsZlWWYgbhnP8nCUPvJxMvn6ggb+Efk5x2ONY+nMieYLbEpvyqL/39iG
         tmcPBjQIIkgUfqAK7nwJcDDqGilKRdEu9tXLOJWZNdKdLfM+JiesKHowmMKCr1WkUuZT
         gzTYmRrDLQyWVXSaUabfOrG8n+jo6O1ocIXwB4pKGRATXvEwKUEv/8h7YytYIbSNHi8U
         wX1xWiKPkTTHGFfWtAqfcTFMxFsf4R3q9/7HrsiA7L2RTEVSPv/xod/+AbBknuu5qcn1
         s/7w==
X-Gm-Message-State: AOAM531nJYaid4nH6bE1elHmaJriOqicP+v0af5N7mAgs81h68r+OsXz
        qUm/4xKHJ00/nkWDe6NeQpmmv9kWsMoRid6S8ik=
X-Google-Smtp-Source: ABdhPJxSKj7k9GKUwv5rxCc2hcP+N+7iFmandDLvreRPnlJ8rtM8p+WX8fC+Xa5ELcU0fKOdc2TvWRM0iiIi6sTe+dg=
X-Received: by 2002:a25:becd:: with SMTP id k13mr14651332ybm.459.1616704551511;
 Thu, 25 Mar 2021 13:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210323040952.2118241-1-rafaeldtinoco@ubuntu.com> <60597d21d7eed_45ba42086@john-XPS-13-9370.notmuch>
In-Reply-To: <60597d21d7eed_45ba42086@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Mar 2021 13:35:40 -0700
Message-ID: <CAEf4BzaY-iBDNg5m7EfW355HjZxayydFRHGN9P95oT-Ovm2Mpg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] libbpf: add bpf object kern_version attribute setter
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 10:31 PM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Rafael David Tinoco wrote:
> > Unfortunately some distros don't have their kernel version defined
> > accurately in <linux/version.h> due to different long term support
> > reasons.
> >
> > It is important to have a way to override the bpf kern_version
> > attribute during runtime: some old kernels might still check for
> > kern_version attribute during bpf_prog_load().
> >
> > Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 10 ++++++++++
> >  tools/lib/bpf/libbpf.h   |  1 +
> >  tools/lib/bpf/libbpf.map |  1 +
> >  3 files changed, 12 insertions(+)
> >
>
> Hi Andrii and Rafael,
>
> Did you consider making kernel version an attribute of the load
> API, bpf_prog_load_xattr()? This feels slightly more natural
> to me, to tell the API the kernel you need at load time.

Um... kern_version is already part of bpf_load_program_attr, used by
bpf_load_program_xattr. What am I missing? But you can't use that with
bpf_object APIs.

>
> Although, I don't use the skeleton pieces so maybe it would be
> awkward for that usage.

Yes, low-level APIs are separate. This is for cases where you have
struct bpf_program abstractions, which are loaded by
bpf_object__load(). We could set it at per-program level, but they
should be all the same, so bpf_object__set_kversion() makes more sense
and is more convenient to use. And there is already a getter for that,
so it complements that nicely.

>
> Sorry, missed v1,v2 so didn't reply sooner.
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 058b643cbcb1..3ac3d8dced7f 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8269,6 +8269,16 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
> >       return obj->btf ? btf__fd(obj->btf) : -1;
> >  }
> >
> > +int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
> > +{
> > +     if (obj->loaded)
> > +             return -EINVAL;
> > +
> > +     obj->kern_version = kern_version;
> > +
> > +     return 0;
> > +}
> > +
>
> Having a test to read uname and feed it into libbpf using
> above to be sure we don't break this in the future would be
> nice.

kern_version has been ignored by kernel for a long time. So there is
no way to test this in selftests/bpf. We could use libbpf CI's old
kernel setup to validate, but I don't think it's worth it. It's
extremely unlikely this will ever change or break (and it's a legacy
stuff we move away from anyways, so it's born sort of obsolete).

>
> >  int bpf_object__set_priv(struct bpf_object *obj, void *priv,
> >                        bpf_object_clear_priv_t clear_priv)
> >  {
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index a1a424b9b8ff..cf9bc6f1f925 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -143,6 +143,7 @@ LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
> >
> >  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
> >  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
> > +LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version);
> >
> >  struct btf;
> >  LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 279ae861f568..f5990f7208ce 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -359,4 +359,5 @@ LIBBPF_0.4.0 {
> >               bpf_linker__finalize;
> >               bpf_linker__free;
> >               bpf_linker__new;
> > +             bpf_object__set_kversion;
> >  } LIBBPF_0.3.0;
> > --
> > 2.27.0
> >
