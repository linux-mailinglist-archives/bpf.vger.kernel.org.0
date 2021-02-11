Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772F5319661
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 00:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhBKXL7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 18:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhBKXL5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 18:11:57 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E976C061574
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 15:11:16 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id q4so6806956otm.9
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 15:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzjLnoN0D4agDhY6bfNov1RBAiLnly47LGd1IJUUd/o=;
        b=AVq0pWSO+KYpWTiPrbkWsdKH+vgApPtkuKj64s+06qux6GV3zuzankSMLjab/4Bb8f
         PKKfNZcCT8HASugsvmZIa0TIe7sorV/4V2NUZhXfBHxfVJRtr7IAvJFxDbAu6+yg439t
         HEX/mOOZQcSgZumurnuJMo7JLLlcwcX9xDyURS45XkQhrl3s0NERVzdJnWezAU+fUaDT
         ho4ejuoUxQcj/fU/m7os452v6wVWGy2DxVGkD90dDo8e5qWN1yovYZ4O8I9Tz6tIzVxy
         bPqWdz2bMrzbzvRaYR13br93e7RJu1D1nfebiZsff7qy100X2S3SxOIeGCywcl/UmsQV
         sllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzjLnoN0D4agDhY6bfNov1RBAiLnly47LGd1IJUUd/o=;
        b=iLcxH7rHsg/53EJaerCMFFpaO2vFh7k/wZguGjaHbkf47nrbzLm4s9o4Nw5MG+iSOt
         SMely6sQjEgaoapQK5BF63oW3zlL73oNAxegB1+Zgnh4tXDpDgJzi5H0P1pq+ZlZIiwm
         EyUhr7nh5SyA2OXjvde+LZvTE8QtbnLWv+LSRLAuZMJZ5ItNNH2ePSJ9Q+gqk9FxlhUW
         E3UO4RFwKyUpCTArcwGFH9C1uzF+Z7cDH9aSol2t4ZThqsY25V4B4O5oY0tiIkpyEqxZ
         2mua5iB1VJToiLK+5gXtMBjafh2vZ40ywNseQsGTEXmILjpvguNAxP8SASxRPvsRcKFg
         IOHQ==
X-Gm-Message-State: AOAM533CkXSaBU++WBiORcwb/EzQGmGW8lQhrOAI3DnZ/csLyF7i2CWa
        6AlTN+PLkfFAYVkXT8Kjtyw6h0RdadykV8Zvju4=
X-Google-Smtp-Source: ABdhPJyYxm4I5CuG+IfIpA5B1wF7Vp2qaEd/KltvrggGCTPMlLoceKoCQBHVJ7nCE13EK2qQX/VaSZGSayLjIVZlJSQ=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr245100otu.59.1613085075668;
 Thu, 11 Feb 2021 15:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20210210030317.78820-1-iii@linux.ibm.com> <20210210030317.78820-2-iii@linux.ibm.com>
 <CAEf4BzY-SOyP0g-ZHTK3h1mppwRGJ4YH3vKugeuLGTe8Q3-r7Q@mail.gmail.com> <bda4c4eb4e9e01a6ecaf4e0cf14e265997520740.camel@linux.ibm.com>
In-Reply-To: <bda4c4eb4e9e01a6ecaf4e0cf14e265997520740.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 11 Feb 2021 15:11:04 -0800
Message-ID: <CAADnVQKWPODWZ2RSJ5FJhfYpxkuV0cvSAL1O+FSr9oP1ercoBg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] bpf: Add BTF_KIND_FLOAT to uapi
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 11, 2021 at 1:26 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2021-02-10 at 16:19 -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 9, 2021 at 7:03 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Add a new kind value, expand the kind bitfield, add a macro for
> > > parsing the additional u32.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  include/uapi/linux/btf.h       | 10 ++++++++--
> > >  tools/include/uapi/linux/btf.h | 10 ++++++++--
> > >  2 files changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> > > index 5a667107ad2c..e713430cb033 100644
> > > --- a/include/uapi/linux/btf.h
> > > +++ b/include/uapi/linux/btf.h
> > > @@ -52,7 +52,7 @@ struct btf_type {
> > >         };
> > >  };
> > >
> > > -#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x0f)
> > > +#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x1f)
> > >  #define BTF_INFO_VLEN(info)    ((info) & 0xffff)
> > >  #define BTF_INFO_KFLAG(info)   ((info) >> 31)
> > >
> > > @@ -72,7 +72,8 @@ struct btf_type {
> > >  #define BTF_KIND_FUNC_PROTO    13      /* Function Proto       */
> > >  #define BTF_KIND_VAR           14      /* Variable     */
> > >  #define BTF_KIND_DATASEC       15      /* Section      */
> > > -#define BTF_KIND_MAX           BTF_KIND_DATASEC
> > > +#define BTF_KIND_FLOAT         16      /* Floating point       */
> > > +#define BTF_KIND_MAX           BTF_KIND_FLOAT
> > >  #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)
> > >
> > >  /* For some specific BTF_KIND, "struct btf_type" is immediately
> > > @@ -169,4 +170,9 @@ struct btf_var_secinfo {
> > >         __u32   size;
> > >  };
> > >
> > > +/* BTF_KIND_FLOAT is followed by a u32 and the following
> >
> >
> > what's the point of that u32, if BTF_FLOAT_BITS() is just t->size *
> > 8?
> > Why adding this complexity. BTF_KIND_INT has bits because we had an
> > inconvenient bitfield encoding as a special BTF_KIND_INT types, which
> > we since stopped using in favor of encoding bitfield sizes and
> > offsets
> > inside struct/union fields. I don't think there is any need for that
> > with FLOAT, so why waste space and add complexity and possibility for
> > inconsistencies?
>
> You are right, this is not necessary. I don't think something like a
> floating-point bitfield exists in the first place.
>
> > Disclaimer: I'm in a "just BTF_KIND_INT encoding bit for
> > floating-point numbers" camp.
>
> Despite me being the guy, who sent this series, I like such a simpler
> approach as well. In fact, my first attempt at this was even simpler -
> just a char[] - but this didn't let us distinguish floats from "real"
> byte arrays, which BTF_KIND_INT encoding does. But I think we need to
> convince Alexey that this would be OK? :-) If that helps, I can
> implement the BTF_KIND_INT encoding variant, so that we could compare
> both approaches. What do you think?

Sorry to crash your party :)
I'm very much against calling "float" a different kind of "int".
BTF is not equivalent to dwarf. It's not a traditional debug format
which purpose is to describe the types, line info, etc.
BTF is used in verification and its correctness is crucial.
Imagine a function with KIND_INT argument if there is no KIND_FLOAT
btf_func_model construction will silently consume 'int' which is actually
'float' which will cause kernel crash.
There is a wip on "unstable helpers". It needs accurate argument processing too.
The same thing will apply there. If KIND_FLOAT is mistaken for KIND_INT
the kernel will crash again, but in a different way.
The usage of floating point in the kernel is minimal, but the point stands.
