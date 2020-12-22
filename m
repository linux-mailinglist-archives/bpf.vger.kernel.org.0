Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2672E0F75
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 21:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgLVUj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Dec 2020 15:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLVUjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 15:39:25 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C784C0617A6
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 12:38:45 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id t8so13146856iov.8
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 12:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fs0wEultW9zvQel3qPl1so7Ch2WK22A6xYiOBL0kebU=;
        b=GUOqVK2GKM6L9XvTXPd7UsU0AbRN112EvkhpERSk2KvSH+z0D2y7907p5uVvtTM4rh
         yI2X+on0CziqmK9VkqSViFaFIKnhQOxKrkOMqtCvxOPpXA/iBeIll/+rPH3uKhVgOBlf
         sjPryZ/C8wbToLv++MkCvvaTCRbKEneiuv3ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fs0wEultW9zvQel3qPl1so7Ch2WK22A6xYiOBL0kebU=;
        b=YLKx/pf+vmVgmwVLqOpRjOY75xPjEOWbRWapjsxvSieMKoMUweBR7uVI3akw4MdHLi
         JX+dkHrXiOClM0p/8xWy+gTMHYK30q3jGBu81q0nx4KdMamA9O6JDZDAuIB3shJKECyO
         Wo3GA7GjsD+n+Nz+gu0eokZY8Pl1PJpI75ka6o+Ta/kMCPiRD6D80NDEqaNAbXjh9d9U
         M2afr0EQ4vNfYYUmcEs3HhSy1pzrCV+dEeVesOA+wzqYQyZXF3FKFvD/6rwe6K4qX9er
         03o3MtOx1mapO4SIIF+0Jgre7+e8f3cJk7C9Apqnv5zh74fwPlXcblJ2oyBDeJhvf7Sc
         pK+w==
X-Gm-Message-State: AOAM531kE8VBx0+mEab1xTIbm1qoC3vAGrCoE93j+hFp+mu+De6bYDDK
        90uuHI5Fp74Dj2/aMgmzgk6YEQnxgbz8wnkjKUwD2KKA0tHE/w==
X-Google-Smtp-Source: ABdhPJzMylCygG0mT+xBD9KIIZ7/ktY12ovO2dEqB0OjSTEhRCtOO7W0DfI7euAu+vePQeRCdYi8drbee8x4VrzK6LI=
X-Received: by 2002:a05:6638:1a:: with SMTP id z26mr20379959jao.52.1608669524643;
 Tue, 22 Dec 2020 12:38:44 -0800 (PST)
MIME-Version: 1.0
References: <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com> <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com> <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
 <d29c2ed6-d99c-9d28-e6ea-d79ffd4d7e65@fb.com> <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
 <CAEf4BzZagDk=HZMqnX_Vvm0Nf+YxjxYARan2hUWy5tyt7qCrFA@mail.gmail.com>
 <20201218203655.clqyeeamwicvej5z@ast-mbp> <CAEf4BzZ7Pk677ZjUprRpsKzF3epBvouogxMU7YKN9i5pH2zQRg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ7Pk677ZjUprRpsKzF3epBvouogxMU7YKN9i5pH2zQRg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 22 Dec 2020 21:38:33 +0100
Message-ID: <CABRcYm+9j=bHW-bbLXnhRfNAApZJwt2tPRksCyyek5gVL2vrpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 18, 2020 at 9:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 18, 2020 at 12:36 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 18, 2020 at 10:53:57AM -0800, Andrii Nakryiko wrote:
> > > On Thu, Dec 17, 2020 at 7:20 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 17, 2020 at 09:26:09AM -0800, Yonghong Song wrote:
> > > > >
> > > > >
> > > > > On 12/17/20 7:31 AM, Florent Revest wrote:
> > > > > > On Mon, Dec 14, 2020 at 7:47 AM Yonghong Song <yhs@fb.com> wrote:
> > > > > > > On 12/11/20 6:40 AM, Florent Revest wrote:
> > > > > > > > On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
> > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > > I still think that adopting printk/vsnprintf for this instead of
> > > > > > > > > reinventing the wheel
> > > > > > > > > is more flexible and easier to maintain long term.
> > > > > > > > > Almost the same layout can be done with vsnprintf
> > > > > > > > > with exception of \0 char.
> > > > > > > > > More meaningful names, etc.
> > > > > > > > > See Documentation/core-api/printk-formats.rst
> > > > > > > >
> > > > > > > > I agree this would be nice. I finally got a bit of time to experiment
> > > > > > > > with this and I noticed a few things:
> > > > > > > >
> > > > > > > > First of all, because helpers only have 5 arguments, if we use two for
> > > > > > > > the output buffer and its size and two for the format string and its
> > > > > > > > size, we are only left with one argument for a modifier. This is still
> > > > > > > > enough for our usecase (where we'd only use "%ps" for example) but it
> > > > > > > > does not strictly-speaking allow for the same layout that Andrii
> > > > > > > > proposed.
> > > > > > >
> > > > > > > See helper bpf_seq_printf. It packs all arguments for format string and
> > > > > > > puts them into an array. bpf_seq_printf will unpack them as it parsed
> > > > > > > through the format string. So it should be doable to have more than
> > > > > > > "%ps" in format string.
> > > > > >
> > > > > > This could be a nice trick, thank you for the suggestion Yonghong :)
> > > > > >
> > > > > > My understanding is that this would also require two extra args (one
> > > > > > for the array of arguments and one for the size of this array) so it
> > > > > > would still not fit the 5 arguments limit I described in my previous
> > > > > > email.
> > > > > > eg: this would not be possible:
> > > > > > long bpf_snprintf(const char *out, u32 out_size,
> > > > > >                    const char *fmt, u32 fmt_size,
> > > > > >                   const void *data, u32 data_len)
> > > > >
> > > > > Right. bpf allows only up to 5 parameters.
> > > > > >
> > > > > > Would you then suggest that we also put the format string and its
> > > > > > length in the first and second cells of this array and have something
> > > > > > along the line of:
> > > > > > long bpf_snprintf(const char *out, u32 out_size,
> > > > > >                    const void *args, u32 args_len) ?
> > > > > > This seems like a fairly opaque signature to me and harder to verify.
> > > > >
> > > > > One way is to define an explicit type for args, something like
> > > > >    struct bpf_fmt_str_data {
> > > > >       char *fmt;
> > > > >       u64 fmt_len;
> > > > >       u64 data[];
> > > > >    };
> > > >
> > > > that feels a bit convoluted.
> > > >
> > > > The reason I feel unease with the helper as was originally proposed
> > > > and with Andrii's proposal is all the extra strlen and strcpy that
> > > > needs to be done. In the helper we have to call kallsyms_lookup()

Note that vsprintf itself calls  __sprint_symbol which does the same
thing as my helper (a kallsyms_lookup followed by a strcpy and a
strlen)

> > > > which is ok interface for what it was desinged to do,
> > > > but it's awkward to use to construct new string ("%s [%s]", sym, modname)
> > > > or to send two strings into a ring buffer.
> > > > Andrii's zero separator idea will simplify bpf prog, but user space
> > > > would need to do strlen anyway if it needs to pretty print.
> > > > If we take pain on converting addr to sym+modname let's figure out
> > > > how to make it easy for the bpf prog to do and easy for user space to consume.
> > > > That's why I proposed snprintf.

Both solutions are fine with us but I feel that the snprintf would be
generally more helpful for BPF.

> > >
> > > I have nothing against snprintf support for symbols. But
> > > bpf_ksym_resolve() solves only a partially overlapping problem, so
> > > deserves to be added in addition to snprintf support. With snprintf,
> > > it will be hard to avoid two lookups of the same symbol to print "%s
> > > [%s]" form, so there is a performance loss, which is probably bigger
> > > than a simple search for a zero-byte.
> >
> > I suspect we're not on the same page in terms of what printf can do.
> > See Documentation/core-api/printk-formats.rst and lib/vsprintf.c:symbol_string()
> > It's exactly one lookup in sprintf implementation.
> > bpf_snprintf(buf, "%ps", addr) would be equivalent to
> > {
> >   ksym_resolve(sym, modname, addr, SYM | MOD);
> >   printf("%s [%s]", sym, modname);
> > }
>
> Ah, I missed that we'll have a single specifier for "%s [%s]" format.
> My assumption was that we have one for symbol name only and another
> for symbol module. Yeah, then it's fine from the performance
> perspective.
>
> >
> > > But bpf_ksym_resolve() can be
> > > used flexibly. You can either do two separate bpf_ksym_resolve() calls
> > > to get symbol name (and its length) and symbol's module (and its
> > > length), if you need to process it programmatically in BPF program. Or
> > > you can bundle it together and let user-space process it. User-space
> > > will need to copy data anyways because it can't stay in
> > > perfbuf/ringbuf for long. So scanning for zero delimiters will be
> > > negligible, it will just bring data into cache. All I'm saying is that
> > > ksym_resolve() gives flexibility which snprintf can't provide.
> >
> > Well, with snprintf there will be no way to print mod symbol
> > without modname, but imo it's a good thing.
> > What is the use case for getting mod symbol without modname?
>
> For easier post-processing on the user side. Instead of parsing
> "vmlinux_symbol" or "module_symbol [module_name]" (two non-uniform
> variants already), user-space would just get two separate strings. I
> just like APIs that don't assume how I am going to use them :), so
> "symbol [module]" format is a bit more inconvenient than decomposed
> pieces.
> >
> > > Additionally, with ksym_resolve() being able to return base address,
> > > it's now possible to do a bunch of new stuff, from in-BPF
> > > symbolization to additional things like correlating memory accesses or
> > > function calls, etc.
> >
> > Getting adjusted base address could be useful some day, but why now? What for?
>
> I proposed that only if we do bpf_ksym_resolve(). No need to support
> that in snprintf case, of course.
>
> >
> > > bits), my point is that ksym_resolve() is more powerful than
> > > snprintf(): the latter can be used pretty much only for
> > > pretty-printing.
> >
> > Potentially yes. I think the stated goal was pretty printing.
>
> That's fine if we do only snprintf, yes. But if a separate helper,
> then we should think more broadly.

Let's start with only snprintf then, this solves our usecase and if a
different need arises in the future (eg: offset) we could design a new
helper around that need.

> >
> > >
> > > >
> > > > As far as 6 arg issue:
> > > > long bpf_snprintf(const char *out, u32 out_size,
> > > >                   const char *fmt, u32 fmt_size,
> > > >                   const void *data, u32 data_len);
> > > > Yeah. It won't work as-is, but fmt_size is unnecessary nowadays.
> > > > The verifier understands read-only data.
> > > > Hence the helper can be:
> > > > long bpf_snprintf(const char *out, u32 out_size,
> > >
> > > With the power of BTF, we can also put these two correlated values
> > > into a single struct and pass a pointer to it. It will take only one
> > > parameter for one memory region. Alternative is the "fat pointer"
> > > approach that Go and Rust use, but it's less flexible overall.
> >
> > I think it will be less flexible when output size is fixed by the type info.
> > With explicit size the bpf_snprintf() can print directly into ringbuffer.
> > Multiple bpf_snprintf() will be able to fill it one by one reducing
> > space available at every step.
> > bpf_snprintf() would need to return the number of bytes, of course.
> > Just like probe_read_str.
>
> Ok, I should have probably demonstrated with an example. I don't
> propose to specify the size through BTF itself. I was thinking about:
>
> struct bpf_mem_ptr {
>     void *data;
>     size_t size;
> };
>
>
> struct bpf_mem_ptr p = { ptr, 123 };
> bpf_whatever_helper(&p, ...);
>
>
> bpf_whatever_helper() will specify that the first argument has to be
> PTR_TO_BTF_ID where btf_id corresponds to struct bpf_mem_ptr. Hope
> this helps.
