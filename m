Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8962DDD3D
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 04:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgLRDUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 22:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgLRDUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 22:20:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E9C0617A7;
        Thu, 17 Dec 2020 19:20:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t22so690610pfl.3;
        Thu, 17 Dec 2020 19:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gtA3GIEly3YIJ+GgXUGAd5q4aDboc+hlemv8auSkl3A=;
        b=qqxVaNataHWQET6UvsVwrWEdOO99PnBYzkTivgiQsejKIdm2lEbaKZiweHvk2424pr
         KrJ4VT6dFw+42X2QQxanyZpAlq4y7vZLRlrGivAEM3rfOFg5r1jEYr3kM0nDS3XtHIAO
         WlRahrdZvsTf9qDosP4QGXaNRGfChCFORvUHg0JxF4yvykzL4qoktCIzMxFD+kgaAB/X
         DlDb/3gauCpMvWhcjaLEQFIxEANWU2ON+AV17Ptv9Fmoj6btcWy6QEIsbXmeLPgTOXup
         Yj955XjJlHZcWkV8GmHGir5EghbnP8+/UQq0Vij3nZb+VAMgAeVsKd+jBx5e2UcBP029
         ERyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gtA3GIEly3YIJ+GgXUGAd5q4aDboc+hlemv8auSkl3A=;
        b=tEEo3H8z6zgAC/bsHw5hYSJZptdpid3zSBj+Serk8pHEsYQ1LovZZByBmRS5RXWRlP
         dg69qs66x/mnBHey/DMge5atOcnPF+HdOjXXcLAfDw7PzDGafk0tx59+MCxJR5Rzur+f
         YHvWLRXTwdXFyn8CgAZcJ3sG1nf++v9jEl8rF3qtYEEOfAUcncTfdOzsrI4Nj6ZviFA1
         9KLZ+NQhbyC/kshwbKLWa5BHtHay2XdRmi3dSNehm1Jlni/KLNMilt3syORoAJy4h3QJ
         dKgXGa0cluUJ+7v5K+OfrUu47dOhnbXLsZRGRINzPJjIJzUFl93u/mnZ35VvwupbPBge
         H+Gw==
X-Gm-Message-State: AOAM533q56fWg2a45lCqnFlqSEFvR9btHrwzZXXLKNDtLhG1Zof4YTJ0
        eapTkF6XJpAp6agr7+JqP3o=
X-Google-Smtp-Source: ABdhPJyjxRRaLoakroUv5inkgevuhM3Xs4CdaP4q7qqaXO/Tig6hhyXFbBQOAdonRstLkRU6DPmM4g==
X-Received: by 2002:a65:6405:: with SMTP id a5mr2216655pgv.389.1608261612452;
        Thu, 17 Dec 2020 19:20:12 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:8bfc])
        by smtp.gmail.com with ESMTPSA id p16sm6148764pju.47.2020.12.17.19.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 19:20:11 -0800 (PST)
Date:   Thu, 17 Dec 2020 19:20:09 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Florent Revest <revest@chromium.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
Message-ID: <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
References: <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
 <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
 <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
 <d29c2ed6-d99c-9d28-e6ea-d79ffd4d7e65@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29c2ed6-d99c-9d28-e6ea-d79ffd4d7e65@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 17, 2020 at 09:26:09AM -0800, Yonghong Song wrote:
> 
> 
> On 12/17/20 7:31 AM, Florent Revest wrote:
> > On Mon, Dec 14, 2020 at 7:47 AM Yonghong Song <yhs@fb.com> wrote:
> > > On 12/11/20 6:40 AM, Florent Revest wrote:
> > > > On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > I still think that adopting printk/vsnprintf for this instead of
> > > > > reinventing the wheel
> > > > > is more flexible and easier to maintain long term.
> > > > > Almost the same layout can be done with vsnprintf
> > > > > with exception of \0 char.
> > > > > More meaningful names, etc.
> > > > > See Documentation/core-api/printk-formats.rst
> > > > 
> > > > I agree this would be nice. I finally got a bit of time to experiment
> > > > with this and I noticed a few things:
> > > > 
> > > > First of all, because helpers only have 5 arguments, if we use two for
> > > > the output buffer and its size and two for the format string and its
> > > > size, we are only left with one argument for a modifier. This is still
> > > > enough for our usecase (where we'd only use "%ps" for example) but it
> > > > does not strictly-speaking allow for the same layout that Andrii
> > > > proposed.
> > > 
> > > See helper bpf_seq_printf. It packs all arguments for format string and
> > > puts them into an array. bpf_seq_printf will unpack them as it parsed
> > > through the format string. So it should be doable to have more than
> > > "%ps" in format string.
> > 
> > This could be a nice trick, thank you for the suggestion Yonghong :)
> > 
> > My understanding is that this would also require two extra args (one
> > for the array of arguments and one for the size of this array) so it
> > would still not fit the 5 arguments limit I described in my previous
> > email.
> > eg: this would not be possible:
> > long bpf_snprintf(const char *out, u32 out_size,
> >                    const char *fmt, u32 fmt_size,
> >                   const void *data, u32 data_len)
> 
> Right. bpf allows only up to 5 parameters.
> > 
> > Would you then suggest that we also put the format string and its
> > length in the first and second cells of this array and have something
> > along the line of:
> > long bpf_snprintf(const char *out, u32 out_size,
> >                    const void *args, u32 args_len) ?
> > This seems like a fairly opaque signature to me and harder to verify.
> 
> One way is to define an explicit type for args, something like
>    struct bpf_fmt_str_data {
>       char *fmt;
>       u64 fmt_len;
>       u64 data[];
>    };

that feels a bit convoluted.

The reason I feel unease with the helper as was originally proposed
and with Andrii's proposal is all the extra strlen and strcpy that
needs to be done. In the helper we have to call kallsyms_lookup()
which is ok interface for what it was desinged to do,
but it's awkward to use to construct new string ("%s [%s]", sym, modname)
or to send two strings into a ring buffer.
Andrii's zero separator idea will simplify bpf prog, but user space
would need to do strlen anyway if it needs to pretty print.
If we take pain on converting addr to sym+modname let's figure out
how to make it easy for the bpf prog to do and easy for user space to consume.
That's why I proposed snprintf.

As far as 6 arg issue:
long bpf_snprintf(const char *out, u32 out_size,
                  const char *fmt, u32 fmt_size,
                  const void *data, u32 data_len);
Yeah. It won't work as-is, but fmt_size is unnecessary nowadays.
The verifier understands read-only data.
Hence the helper can be:
long bpf_snprintf(const char *out, u32 out_size,
                  const char *fmt,
                  const void *data, u32 data_len);
The 3rd arg cannot be ARG_PTR_TO_MEM.
Instead we can introduce ARG_PTR_TO_CONST_STR in the verifier.
See check_mem_access() where it's doing bpf_map_direct_read().
That 'fmt' string will be accessed through the same bpf_map_direct_read().
The verifier would need to check that it's NUL-terminated valid string.
It should probably do % specifier checks at the same time.
At the end bpf_snprintf() will have 5 args and when wrapped with 
BPF_SNPRINTF() macro it will accept arbitrary number of arguments to print.
It also will be generally useful to do all other kinds of pretty printing.
