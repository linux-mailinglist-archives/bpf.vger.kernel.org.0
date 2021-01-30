Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749103094EC
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 12:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhA3LgO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 06:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhA3LgN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jan 2021 06:36:13 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09CC061574
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 03:35:32 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e7so10942278ile.7
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 03:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NCnhzl3YFEPYjNGC3qVLj8vYdo08Rot3lfgCi1SOm8=;
        b=Bgn9foxGZlyyabnHETDbJjU5AMo0XpBpFT8DJXOlvelcE2lxlJa90eytB1TDXH4NNZ
         j75s7bsHpo/P9IVvS4nDoaMltX0X3R5GoTLeTr3761RxOfewt0t2TOSeBiYsnt5/8uiK
         z7KlIpr3W0uqqJZZEu5RLIhvKSYaqlslMB0nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NCnhzl3YFEPYjNGC3qVLj8vYdo08Rot3lfgCi1SOm8=;
        b=Y0wgVwsvifP6Iggz7zS7isjHCcpAY9tch3rvEzI8IB0d14x0805VJsluUP0/jvKRw3
         HslExOB22LVyCNjh43kg1SkXSWEl+4ytMMpQ+wrUa/KTW5nEymLg2z9lDoFXokHmSlgn
         JijRWfgdQib5s+sezRUAxwUtkwor/yeFrz7oskXIqzDrYs08oPLuSyvdenn8yxLnMTMU
         RmXUHnbuNJslGmACzWlHLVRE+fO2cblO9h76HqPQEi9EOn8Gc6n4paoK3hvWWlBiHybx
         MjFInu+VfEHPVBPCSxv3JXVRb6CqfOPIq/oJV6OG9KnZ92LGjcpj8n+afIDL4+sGYYWL
         PAgQ==
X-Gm-Message-State: AOAM530OcOm53X1umequnOibWKzsoRMXgtrOUiYwaYcbgmjDeWEtdEPJ
        0iOCtLdvzjGuauUv0kkIbAlwIcCx0WkrNuyavx+PnFTbQ9A=
X-Google-Smtp-Source: ABdhPJxCMB1eZhCgwfrf/Jc3O0TGysSi3yor9ipDeAEks5wHQVEdQga2elTpsMmiFzdOqdOus3+fUD6tlMWFR4rSEfQ=
X-Received: by 2002:a05:6e02:4cd:: with SMTP id f13mr6087304ils.42.1612006531743;
 Sat, 30 Jan 2021 03:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20210126183559.1302406-1-revest@chromium.org> <20210126183559.1302406-2-revest@chromium.org>
 <CAEf4BzZ9MmdeR9P7bybXEM77MV6C-T=yZPugLOHSFC1ES2e4=g@mail.gmail.com>
In-Reply-To: <CAEf4BzZ9MmdeR9P7bybXEM77MV6C-T=yZPugLOHSFC1ES2e4=g@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Sat, 30 Jan 2021 12:35:21 +0100
Message-ID: <CABRcYmK1kAFAu=8CCVv+zYLFui5B_+jOJj6NpE0jW3Ers7Y6ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/5] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 27, 2021 at 10:01 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 26, 2021 at 10:36 AM Florent Revest <revest@chromium.org> wrote:
> >
> > This needs a new helper that:
> > - can work in a sleepable context (using sock_gen_cookie)
> > - takes a struct sock pointer and checks that it's not NULL
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > Acked-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/bpf.h            |  1 +
> >  include/uapi/linux/bpf.h       |  8 ++++++++
> >  kernel/trace/bpf_trace.c       |  2 ++
> >  net/core/filter.c              | 12 ++++++++++++
> >  tools/include/uapi/linux/bpf.h |  8 ++++++++
> >  5 files changed, 31 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 1aac2af12fed..26219465e1f7 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1874,6 +1874,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
> >  extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
> >  extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
> >  extern const struct bpf_func_proto bpf_sock_from_file_proto;
> > +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
> >
> >  const struct bpf_func_proto *bpf_tracing_func_proto(
> >         enum bpf_func_id func_id, const struct bpf_prog *prog);
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 0b735c2729b2..5855c398d685 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1673,6 +1673,14 @@ union bpf_attr {
> >   *     Return
> >   *             A 8-byte long unique number.
> >   *
> > + * u64 bpf_get_socket_cookie(void *sk)
>
> should the type be `struct sock *` then?

Oh, absolutely. :) Thank you Andrii
