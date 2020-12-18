Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860D42DE959
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 19:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgLRSyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 13:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbgLRSyt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Dec 2020 13:54:49 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C7C0617A7;
        Fri, 18 Dec 2020 10:54:09 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id w127so2818295ybw.8;
        Fri, 18 Dec 2020 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xS0F7nVE0LZgOJjr38NIlpM7s/imAsrx6lW5J/Oc/eg=;
        b=nMl2mSmV1mDn1esAvqbGSKKMRho1MCAmG4sEojWAifkySt6unIHwrF3l2aR8MFnvVY
         m12vz8ZLS5Y6waGhXELCdulZc8t4Yu/dHkeIIMxMlSGkNGN9rojSkhSgyaL7lK/Yrv2F
         yNd4QHtCLutv4/5RevSwVJz0++KxdyO/1ulrsrv+x7fH5IeyqsWWd4xD2sPalDAxptyj
         tj7FMe8Wk2o7/B2D0vIUtfqOWcKenl+qtB8ffOdR3dOiSVQnQ+yJUbx5ZLM7ATYxCwE6
         FHqHwurT7k92ipR60URo2/s7I9spyULb+Y536JHWqL5hlmDw/dfjKT3HUr1nPTAyVrhJ
         DNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xS0F7nVE0LZgOJjr38NIlpM7s/imAsrx6lW5J/Oc/eg=;
        b=NbxUIWjKr6E30foxx7B8loDn0dXu/pQnoXxSZdTL4yqWdvlMN8aJNhtC/LKFpmTroG
         q1BDDpdCNW2NJYcrcwfZnB76R94F9Ku6wPxNUwUmWssUaVXD7sAQwKtbwW5PBoQ8x5na
         IvUJSJxm0GcqiVVDuZt+ftV3m/vNJaqIAH5ncW6Bm7TmMWvToXTVDsJ0Oh7b4bOvKmZS
         cLC1sYJnrMPhjqFsy+mwDv7bA0lpfVol2gtFHHTQPDIymi3jIcWC73GKwCDVGHyjhKx1
         CIQHYf0nu+IaoaKibQ0+xLkmjPbcudwcCmhSpbb+i5XziJQ7YvEYeGOgVWe3Zw8IqRut
         HCQw==
X-Gm-Message-State: AOAM531ZZkwqXu4Wt0KdJi1pl4rKgA02+TBxgdGOxzvjTcv3Htbv5BnG
        gGEUooIuGZcfNYXwB6/ULjhSWKl7yGx9xEaIRs4=
X-Google-Smtp-Source: ABdhPJy16oHglvcmGwj9lPsbfCYai3rb2juHH6r8Ze1QaN4tZ4H7RNlQPL+8zeJ4ElaeYZQbdhtgG2/m9swiN/ac0Ds=
X-Received: by 2002:a25:818e:: with SMTP id p14mr7624180ybk.425.1608317648419;
 Fri, 18 Dec 2020 10:54:08 -0800 (PST)
MIME-Version: 1.0
References: <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com> <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com> <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com> <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
 <d29c2ed6-d99c-9d28-e6ea-d79ffd4d7e65@fb.com> <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
In-Reply-To: <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 18 Dec 2020 10:53:57 -0800
Message-ID: <CAEf4BzZagDk=HZMqnX_Vvm0Nf+YxjxYARan2hUWy5tyt7qCrFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 17, 2020 at 7:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 17, 2020 at 09:26:09AM -0800, Yonghong Song wrote:
> >
> >
> > On 12/17/20 7:31 AM, Florent Revest wrote:
> > > On Mon, Dec 14, 2020 at 7:47 AM Yonghong Song <yhs@fb.com> wrote:
> > > > On 12/11/20 6:40 AM, Florent Revest wrote:
> > > > > On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > I still think that adopting printk/vsnprintf for this instead of
> > > > > > reinventing the wheel
> > > > > > is more flexible and easier to maintain long term.
> > > > > > Almost the same layout can be done with vsnprintf
> > > > > > with exception of \0 char.
> > > > > > More meaningful names, etc.
> > > > > > See Documentation/core-api/printk-formats.rst
> > > > >
> > > > > I agree this would be nice. I finally got a bit of time to experiment
> > > > > with this and I noticed a few things:
> > > > >
> > > > > First of all, because helpers only have 5 arguments, if we use two for
> > > > > the output buffer and its size and two for the format string and its
> > > > > size, we are only left with one argument for a modifier. This is still
> > > > > enough for our usecase (where we'd only use "%ps" for example) but it
> > > > > does not strictly-speaking allow for the same layout that Andrii
> > > > > proposed.
> > > >
> > > > See helper bpf_seq_printf. It packs all arguments for format string and
> > > > puts them into an array. bpf_seq_printf will unpack them as it parsed
> > > > through the format string. So it should be doable to have more than
> > > > "%ps" in format string.
> > >
> > > This could be a nice trick, thank you for the suggestion Yonghong :)
> > >
> > > My understanding is that this would also require two extra args (one
> > > for the array of arguments and one for the size of this array) so it
> > > would still not fit the 5 arguments limit I described in my previous
> > > email.
> > > eg: this would not be possible:
> > > long bpf_snprintf(const char *out, u32 out_size,
> > >                    const char *fmt, u32 fmt_size,
> > >                   const void *data, u32 data_len)
> >
> > Right. bpf allows only up to 5 parameters.
> > >
> > > Would you then suggest that we also put the format string and its
> > > length in the first and second cells of this array and have something
> > > along the line of:
> > > long bpf_snprintf(const char *out, u32 out_size,
> > >                    const void *args, u32 args_len) ?
> > > This seems like a fairly opaque signature to me and harder to verify.
> >
> > One way is to define an explicit type for args, something like
> >    struct bpf_fmt_str_data {
> >       char *fmt;
> >       u64 fmt_len;
> >       u64 data[];
> >    };
>
> that feels a bit convoluted.
>
> The reason I feel unease with the helper as was originally proposed
> and with Andrii's proposal is all the extra strlen and strcpy that
> needs to be done. In the helper we have to call kallsyms_lookup()
> which is ok interface for what it was desinged to do,
> but it's awkward to use to construct new string ("%s [%s]", sym, modname)
> or to send two strings into a ring buffer.
> Andrii's zero separator idea will simplify bpf prog, but user space
> would need to do strlen anyway if it needs to pretty print.
> If we take pain on converting addr to sym+modname let's figure out
> how to make it easy for the bpf prog to do and easy for user space to consume.
> That's why I proposed snprintf.

I have nothing against snprintf support for symbols. But
bpf_ksym_resolve() solves only a partially overlapping problem, so
deserves to be added in addition to snprintf support. With snprintf,
it will be hard to avoid two lookups of the same symbol to print "%s
[%s]" form, so there is a performance loss, which is probably bigger
than a simple search for a zero-byte. But bpf_ksym_resolve() can be
used flexibly. You can either do two separate bpf_ksym_resolve() calls
to get symbol name (and its length) and symbol's module (and its
length), if you need to process it programmatically in BPF program. Or
you can bundle it together and let user-space process it. User-space
will need to copy data anyways because it can't stay in
perfbuf/ringbuf for long. So scanning for zero delimiters will be
negligible, it will just bring data into cache. All I'm saying is that
ksym_resolve() gives flexibility which snprintf can't provide.

Additionally, with ksym_resolve() being able to return base address,
it's now possible to do a bunch of new stuff, from in-BPF
symbolization to additional things like correlating memory accesses or
function calls, etc. We just need to make sure that fixed-length base
addr is put first, before symbol name and symbol module (if they are
requested), so that a BPF program just knows that it's at offset 0. We
can discuss those details separately (it's just a matter of ordering
bits), my point is that ksym_resolve() is more powerful than
snprintf(): the latter can be used pretty much only for
pretty-printing.

>
> As far as 6 arg issue:
> long bpf_snprintf(const char *out, u32 out_size,
>                   const char *fmt, u32 fmt_size,
>                   const void *data, u32 data_len);
> Yeah. It won't work as-is, but fmt_size is unnecessary nowadays.
> The verifier understands read-only data.
> Hence the helper can be:
> long bpf_snprintf(const char *out, u32 out_size,

With the power of BTF, we can also put these two correlated values
into a single struct and pass a pointer to it. It will take only one
parameter for one memory region. Alternative is the "fat pointer"
approach that Go and Rust use, but it's less flexible overall.

>                   const char *fmt,
>                   const void *data, u32 data_len);
> The 3rd arg cannot be ARG_PTR_TO_MEM.
> Instead we can introduce ARG_PTR_TO_CONST_STR in the verifier.
> See check_mem_access() where it's doing bpf_map_direct_read().
> That 'fmt' string will be accessed through the same bpf_map_direct_read().
> The verifier would need to check that it's NUL-terminated valid string.
> It should probably do % specifier checks at the same time.
> At the end bpf_snprintf() will have 5 args and when wrapped with
> BPF_SNPRINTF() macro it will accept arbitrary number of arguments to print.
> It also will be generally useful to do all other kinds of pretty printing.
