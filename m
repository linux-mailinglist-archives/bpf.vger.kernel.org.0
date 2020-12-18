Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F52DEA4F
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 21:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLRUhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 15:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLRUhj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Dec 2020 15:37:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243B6C0617B0;
        Fri, 18 Dec 2020 12:36:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w1so5350483pjc.0;
        Fri, 18 Dec 2020 12:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1W61gzlGyaBnL9MLhoQS8797DEnUp3WfY+xqMbtKbNc=;
        b=BXgGUWJAHS45zlPE2YxHFSoW39VlKmLnZii0/F9dLLY8Wb7dndVOpwkldG6WZlf/Z8
         CYqX9fmSFPRWyIBiEaiiOpqXhBdohu/k4RCT7Y2KO+yalNwcZJ9lKIkOxhf4v7v4MJJO
         1sFJ7/8uWnCcPLWPXxe3LJ8M1Lhtn/l7zm0Ikb8Tj4f9/xjw/266TgTCjqBEpLZ5Dd/9
         FsqlkgjGVr1oJegU05zLbrYT4bmykW4iW1gSSweQ/eW2tFxTuO+NShInBw7C41oh4a5v
         p8dlFn6YdoN+qspaNyeT3KLmBy3lFWK3/v9TEuuiNMhYqpWTip+iO9+APsXto7bRs6kP
         TJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1W61gzlGyaBnL9MLhoQS8797DEnUp3WfY+xqMbtKbNc=;
        b=jpdERCFTBqkNgN/PWNOf++Teqxl24kC0+F3S30HPdXxHnpZZJ2hwIhUV7kHKjvPNAc
         1frc4sCFIqAwcHIPOW0tr8QR5QwwKNeztyotPzQulqLZfd0ALltMMS9lVt4eaMFVlgtL
         Y+yOQ91eNS5q6DnUTb1IphPOxsyhQMudhhS/sLeUa1tgVbniv6ObJZLazCJCJFfkin2L
         43HdiJIuJOOmwF3X9oX2+PhwOIsH9RUL1aZg8YBLvsQDobmTWd8OB4ggd+K65f3Jo5fv
         H9CWXwUD4/NN2rrSamlpR4GDVo/fWOiGbaEGomui4DbUUp6J6gdQOdyX0vLAhGq7qRVC
         dn1g==
X-Gm-Message-State: AOAM5316aih0TdS3s3luJHI4Khxji9ZSK2+7X7ha6mlnNY+nAJsx55ht
        ln6PmxNT+y9GPJzCy1ZvzGs=
X-Google-Smtp-Source: ABdhPJySL/NALGXhPEjKAsjyIUqSWbSR06EPXt3Xr/8uknbzjI+t7MDnKFWJcj82Gnloon7e+PiakQ==
X-Received: by 2002:a17:902:eac4:b029:da:79a5:1e88 with SMTP id p4-20020a170902eac4b02900da79a51e88mr5743045pld.78.1608323818534;
        Fri, 18 Dec 2020 12:36:58 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5c04])
        by smtp.gmail.com with ESMTPSA id k125sm6369602pga.57.2020.12.18.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 12:36:57 -0800 (PST)
Date:   Fri, 18 Dec 2020 12:36:55 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
Message-ID: <20201218203655.clqyeeamwicvej5z@ast-mbp>
References: <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
 <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
 <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
 <d29c2ed6-d99c-9d28-e6ea-d79ffd4d7e65@fb.com>
 <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
 <CAEf4BzZagDk=HZMqnX_Vvm0Nf+YxjxYARan2hUWy5tyt7qCrFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZagDk=HZMqnX_Vvm0Nf+YxjxYARan2hUWy5tyt7qCrFA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 18, 2020 at 10:53:57AM -0800, Andrii Nakryiko wrote:
> On Thu, Dec 17, 2020 at 7:20 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Dec 17, 2020 at 09:26:09AM -0800, Yonghong Song wrote:
> > >
> > >
> > > On 12/17/20 7:31 AM, Florent Revest wrote:
> > > > On Mon, Dec 14, 2020 at 7:47 AM Yonghong Song <yhs@fb.com> wrote:
> > > > > On 12/11/20 6:40 AM, Florent Revest wrote:
> > > > > > On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > I still think that adopting printk/vsnprintf for this instead of
> > > > > > > reinventing the wheel
> > > > > > > is more flexible and easier to maintain long term.
> > > > > > > Almost the same layout can be done with vsnprintf
> > > > > > > with exception of \0 char.
> > > > > > > More meaningful names, etc.
> > > > > > > See Documentation/core-api/printk-formats.rst
> > > > > >
> > > > > > I agree this would be nice. I finally got a bit of time to experiment
> > > > > > with this and I noticed a few things:
> > > > > >
> > > > > > First of all, because helpers only have 5 arguments, if we use two for
> > > > > > the output buffer and its size and two for the format string and its
> > > > > > size, we are only left with one argument for a modifier. This is still
> > > > > > enough for our usecase (where we'd only use "%ps" for example) but it
> > > > > > does not strictly-speaking allow for the same layout that Andrii
> > > > > > proposed.
> > > > >
> > > > > See helper bpf_seq_printf. It packs all arguments for format string and
> > > > > puts them into an array. bpf_seq_printf will unpack them as it parsed
> > > > > through the format string. So it should be doable to have more than
> > > > > "%ps" in format string.
> > > >
> > > > This could be a nice trick, thank you for the suggestion Yonghong :)
> > > >
> > > > My understanding is that this would also require two extra args (one
> > > > for the array of arguments and one for the size of this array) so it
> > > > would still not fit the 5 arguments limit I described in my previous
> > > > email.
> > > > eg: this would not be possible:
> > > > long bpf_snprintf(const char *out, u32 out_size,
> > > >                    const char *fmt, u32 fmt_size,
> > > >                   const void *data, u32 data_len)
> > >
> > > Right. bpf allows only up to 5 parameters.
> > > >
> > > > Would you then suggest that we also put the format string and its
> > > > length in the first and second cells of this array and have something
> > > > along the line of:
> > > > long bpf_snprintf(const char *out, u32 out_size,
> > > >                    const void *args, u32 args_len) ?
> > > > This seems like a fairly opaque signature to me and harder to verify.
> > >
> > > One way is to define an explicit type for args, something like
> > >    struct bpf_fmt_str_data {
> > >       char *fmt;
> > >       u64 fmt_len;
> > >       u64 data[];
> > >    };
> >
> > that feels a bit convoluted.
> >
> > The reason I feel unease with the helper as was originally proposed
> > and with Andrii's proposal is all the extra strlen and strcpy that
> > needs to be done. In the helper we have to call kallsyms_lookup()
> > which is ok interface for what it was desinged to do,
> > but it's awkward to use to construct new string ("%s [%s]", sym, modname)
> > or to send two strings into a ring buffer.
> > Andrii's zero separator idea will simplify bpf prog, but user space
> > would need to do strlen anyway if it needs to pretty print.
> > If we take pain on converting addr to sym+modname let's figure out
> > how to make it easy for the bpf prog to do and easy for user space to consume.
> > That's why I proposed snprintf.
> 
> I have nothing against snprintf support for symbols. But
> bpf_ksym_resolve() solves only a partially overlapping problem, so
> deserves to be added in addition to snprintf support. With snprintf,
> it will be hard to avoid two lookups of the same symbol to print "%s
> [%s]" form, so there is a performance loss, which is probably bigger
> than a simple search for a zero-byte. 

I suspect we're not on the same page in terms of what printf can do.
See Documentation/core-api/printk-formats.rst and lib/vsprintf.c:symbol_string()
It's exactly one lookup in sprintf implementation.
bpf_snprintf(buf, "%ps", addr) would be equivalent to
{
  ksym_resolve(sym, modname, addr, SYM | MOD);
  printf("%s [%s]", sym, modname);
}

> But bpf_ksym_resolve() can be
> used flexibly. You can either do two separate bpf_ksym_resolve() calls
> to get symbol name (and its length) and symbol's module (and its
> length), if you need to process it programmatically in BPF program. Or
> you can bundle it together and let user-space process it. User-space
> will need to copy data anyways because it can't stay in
> perfbuf/ringbuf for long. So scanning for zero delimiters will be
> negligible, it will just bring data into cache. All I'm saying is that
> ksym_resolve() gives flexibility which snprintf can't provide.

Well, with snprintf there will be no way to print mod symbol
without modname, but imo it's a good thing.
What is the use case for getting mod symbol without modname?

> Additionally, with ksym_resolve() being able to return base address,
> it's now possible to do a bunch of new stuff, from in-BPF
> symbolization to additional things like correlating memory accesses or
> function calls, etc. 

Getting adjusted base address could be useful some day, but why now? What for?

> bits), my point is that ksym_resolve() is more powerful than
> snprintf(): the latter can be used pretty much only for
> pretty-printing.

Potentially yes. I think the stated goal was pretty printing.

> 
> >
> > As far as 6 arg issue:
> > long bpf_snprintf(const char *out, u32 out_size,
> >                   const char *fmt, u32 fmt_size,
> >                   const void *data, u32 data_len);
> > Yeah. It won't work as-is, but fmt_size is unnecessary nowadays.
> > The verifier understands read-only data.
> > Hence the helper can be:
> > long bpf_snprintf(const char *out, u32 out_size,
> 
> With the power of BTF, we can also put these two correlated values
> into a single struct and pass a pointer to it. It will take only one
> parameter for one memory region. Alternative is the "fat pointer"
> approach that Go and Rust use, but it's less flexible overall.

I think it will be less flexible when output size is fixed by the type info.
With explicit size the bpf_snprintf() can print directly into ringbuffer.
Multiple bpf_snprintf() will be able to fill it one by one reducing
space available at every step.
bpf_snprintf() would need to return the number of bytes, of course.
Just like probe_read_str.
