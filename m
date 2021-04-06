Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDB355852
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbhDFPmi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 11:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhDFPmg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 11:42:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC545C061756
        for <bpf@vger.kernel.org>; Tue,  6 Apr 2021 08:42:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id x16so16078838iob.1
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yuM2FMRUJwl6h7NJ7ORzgicbz5nr00WuJkQeXJ1kuA=;
        b=WA8luX17wUAamJDGGrccgiIstP5J/szgoSQdO19y/uI4Q6N+hiHQ1WxgeHrG+gliJa
         fjrlFaywq5PgPCt3KDJvCIqsXPKFnBJGdj+1c6zxEIV3uwyl21FpweyC4V++Ce7DL0Ah
         NDV0mHoHWsM6/0qOBeR3V7Pht9hUfdyAoUyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yuM2FMRUJwl6h7NJ7ORzgicbz5nr00WuJkQeXJ1kuA=;
        b=hEQqRKEdJlxJh/M79XoSs+vxEqFhevKbPtooBC2ab8a2DS1lrRcjHvfQ3CA0dkbyvB
         OxgAH1VulbJBCJMjsQe45Xkp+fJ2OmpcxOiOkRBoPtn9R5T7actT+R6FcvDd2cK9hd7k
         0bb/ep4l7AXxelSkK3+r94tpftaNTi9SMCf5w82HOpKgQ3J6vtEJMs/M4PO0gazRLlO+
         t1atHj0YrmWsmYIocMSMK0D6lstn1Og9m+FRr9ukeoa3m3eu0KbtGbbJn3TVw+bBVVTd
         9RYae3uhuAImXzv6XhRSAnOe5l+h6+ZTN4NNweQh1YcBcIiUBGxXeQKZR0vHE4jlW+i4
         Ht7A==
X-Gm-Message-State: AOAM530CVpgG3T5r4nzrQWAvVZ9FnfBURHdnAd4XHLINaiL0VGk9nBA0
        7dzSRsRkHrFlQCseEoQJAHZUlCfvEpy/6v11MO4Uxg==
X-Google-Smtp-Source: ABdhPJzOwwJtjQRciV12szv0027FWcMRRZPyX/sYtasYoDcG1me9lmObLfyOqI131l/gsqCAnMJ04lf50R5OGMBY3XU=
X-Received: by 2002:a05:6638:606:: with SMTP id g6mr29793910jar.52.1617723747119;
 Tue, 06 Apr 2021 08:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-5-revest@chromium.org>
 <CAEf4BzbCZnLV6mHqqAX9vcEjxtKzu3a9RFCSs9wbmQWw67gXtA@mail.gmail.com>
In-Reply-To: <CAEf4BzbCZnLV6mHqqAX9vcEjxtKzu3a9RFCSs9wbmQWw67gXtA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 6 Apr 2021 17:42:16 +0200
Message-ID: <CABRcYmJA47nk0=f=65H6-sFz-km+wBWwLJWjOz2NbEEboR3kQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Initialize the bpf_seq_printf
 parameters array field by field
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 27, 2021 at 12:01 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> >
> > When initializing the __param array with a one liner, if all args are
> > const, the initial array value will be placed in the rodata section but
> > because libbpf does not support relocation in the rodata section, any
> > pointer in this array will stay NULL.
> >
> > Fixes: c09add2fbc5a ("tools/libbpf: Add bpf_iter support")
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index f9ef37707888..d9a4c3f77ff4 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -413,6 +413,22 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
> >  }                                                                          \
> >  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> >
> > +#define ___bpf_fill0(arr, p, x)
>
> can you please double-check that no-argument BPF_SEQ_PRINTF won't
> generate a warning about spurious ';'? Maybe it's better to have zero
> case as `do {} while(0);` ?
>
> > +#define ___bpf_fill1(arr, p, x) arr[p] = x
> > +#define ___bpf_fill2(arr, p, x, args...) arr[p] = x; ___bpf_fill1(arr, p + 1, args)
> > +#define ___bpf_fill3(arr, p, x, args...) arr[p] = x; ___bpf_fill2(arr, p + 1, args)
> > +#define ___bpf_fill4(arr, p, x, args...) arr[p] = x; ___bpf_fill3(arr, p + 1, args)
> > +#define ___bpf_fill5(arr, p, x, args...) arr[p] = x; ___bpf_fill4(arr, p + 1, args)
> > +#define ___bpf_fill6(arr, p, x, args...) arr[p] = x; ___bpf_fill5(arr, p + 1, args)
> > +#define ___bpf_fill7(arr, p, x, args...) arr[p] = x; ___bpf_fill6(arr, p + 1, args)
> > +#define ___bpf_fill8(arr, p, x, args...) arr[p] = x; ___bpf_fill7(arr, p + 1, args)
> > +#define ___bpf_fill9(arr, p, x, args...) arr[p] = x; ___bpf_fill8(arr, p + 1, args)
> > +#define ___bpf_fill10(arr, p, x, args...) arr[p] = x; ___bpf_fill9(arr, p + 1, args)
> > +#define ___bpf_fill11(arr, p, x, args...) arr[p] = x; ___bpf_fill10(arr, p + 1, args)
> > +#define ___bpf_fill12(arr, p, x, args...) arr[p] = x; ___bpf_fill11(arr, p + 1, args)
> > +#define ___bpf_fill(arr, args...) \
> > +       ___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
>
> cool. this is regular enough to easily comprehend :)
>
> > +
> >  /*
> >   * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
> >   * in a structure.
> > @@ -421,12 +437,14 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> >         ({                                                                  \
> >                 _Pragma("GCC diagnostic push")                              \
> >                 _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
> > +               unsigned long long ___param[___bpf_narg(args)];             \
> >                 static const char ___fmt[] = fmt;                           \
> > -               unsigned long long ___param[] = { args };                   \
> > +               int __ret;                                                  \
> > +               ___bpf_fill(___param, args);                                \
> >                 _Pragma("GCC diagnostic pop")                               \
>
> Let's clean this up a little bit;
> 1. static const char ___fmt should be the very first
> 2. _Pragma scope should be minimal necessary, which includes only
> ___bpf_fill, right?
> 3. Empty line after int __ret; and let's keep three underscores for consistency.
>
>
> > -               int ___ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),    \
> > -                                           ___param, sizeof(___param));    \
> > -               ___ret;                                                     \
> > +               __ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),         \
> > +                                      ___param, sizeof(___param));         \
> > +               __ret;                                                      \
>
> but actually you don't need __ret at all, just bpf_seq_printf() here, right?

Agreed with everything and also the indentation comment in 5/6, thanks.
