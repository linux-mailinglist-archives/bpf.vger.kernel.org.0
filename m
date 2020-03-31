Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AB199FE9
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 22:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgCaUXo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 16:23:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33964 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaUXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 16:23:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id i6so24593657qke.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2020 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2Xjl+tu9dt8lDajpKq9iYoZKBoTg+AzZ/EUYxNULVg=;
        b=na7OGF7zEZXkjsSc155up/B44h/+USLLAKn0yG0ZSFNpmrGE1ABeuCfapIAVixMiF8
         /dHbb85d3ytEF1NLoxbE4lsaZr6n+S6miZp7Sn1FYhBLTIGdE5CazDL2g7/okM0BlZBo
         QQ3M/ZJ2qmQw3CjH3nZ9iaeHcuOkq5/bqao/t/LyS6C0ucj36FSd9J4DqbbIxjuUcGZU
         qkNotg3R+XA+4bmGDXE/WNsSnUvLtZd4hb6IG3ColWKzvG6kX17O++kO7Yv8I9bCvNFN
         psbsDVVfL6jJ4B/1W3Wim9bSVSV9Y1pYUt9Bkf/is/JA/0eezU7p/oxkqUdrwdfbNtCV
         IIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2Xjl+tu9dt8lDajpKq9iYoZKBoTg+AzZ/EUYxNULVg=;
        b=e8sT9qfM9DqbiArC25L0CUg3POXC/RqiQHg1zWebqbnUBOT44YTtEuGmiGPhJilmO4
         /ElJluK1GuxGbX5VjlRTEsnlIt6aW0xwtTlBCOJGXVwfxAEE4B6yIpgmZ1IsmyEq0Zib
         baCPFBdNwSRtA7pbFoSVKJqOH1w6nQkHB3u0rGqj2yflstlPEe21B4UEiU4tZDAa9oGh
         w7CpjVuHcBZNSCOJVDmug/1e1vTWf0mc06CtEncsUxWLx3wTbI0obFz77jjCrJ6/A3q4
         Pk/IS/7Y5XSVgKtLcfLmzCNXfU/GvVedV0LVZXHqnbnmRTJ3ygtBpc0QbzLeypVfE7ZG
         Hfwg==
X-Gm-Message-State: ANhLgQ2InGaVWg/+28/nAGD6c3TI9VdtofVQm0Yb8fvDm8lIcz0xZ6+A
        p99rXffoh4j2JQo0UH7uXeP+LCqOG2o7eDACi+g=
X-Google-Smtp-Source: ADFU+vvzLoOQupQEE/JE45FafsskjhAXiekCkRxUaEeeBCYJGZpyr6VsELMrWgDYhV0SA1r2TCgTjnyXrQIPYANunvc=
X-Received: by 2002:a37:992:: with SMTP id 140mr6277399qkj.36.1585686221047;
 Tue, 31 Mar 2020 13:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
 <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
 <202003301016.D0E239A0@keescook> <c332da87-a770-8cf9-c252-5fb64c06c17e@iogearbox.net>
 <202003311110.2B08091E@keescook> <CAEf4BzYZsiuQGYVozwB=7nNhVYzCr=fQq6PLgHF3M5AXbhZyig@mail.gmail.com>
 <202003311257.3372EC63@keescook>
In-Reply-To: <202003311257.3372EC63@keescook>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Mar 2020 13:23:30 -0700
Message-ID: <CAEf4BzYODtQtuO79BAn-m=2n8QwPRLd74UP-rwivHj6uLk3ycA@mail.gmail.com>
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Slava Bacherikov <slava@bacher09.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 31, 2020 at 12:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Mar 31, 2020 at 12:50:07PM -0700, Andrii Nakryiko wrote:
> > On Tue, Mar 31, 2020 at 11:12 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Mar 31, 2020 at 12:41:04AM +0200, Daniel Borkmann wrote:
> > > > On 3/30/20 7:20 PM, Kees Cook wrote:
> > > > > On Mon, Mar 30, 2020 at 06:17:32PM +0200, Jann Horn wrote:
> > > > > > On Mon, Mar 30, 2020 at 5:59 PM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
> > > > > > > >
> > > > > > > > I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
> > > > > > > > of CONFIG_GCC_PLUGIN_RANDSTRUCT.
> > > > > > >
> > > > > > > Is it a theoretical stmt or you have data?
> > > > > > > I think it's the other way around.
> > > > > > > gcc-plugin breaks dwarf and breaks btf.
> > > > > > > But I only looked at gcc patches without applying them.
> > > > > >
> > > > > > Ah, interesting - I haven't actually tested it, I just assumed
> > > > > > (perhaps incorrectly) that the GCC plugin would deal with DWARF info
> > > > > > properly.
> > > > >
> > > > > Yeah, GCC appears to create DWARF before the plugin does the
> > > > > randomization[1], so it's not an exposure, but yes, struct randomization
> > > > > is pretty completely incompatible with a bunch of things in the kernel
> > > > > (by design). I'm happy to add negative "depends" in the Kconfig if it
> > > > > helps clarify anything.
> > > >
> > > > Is this expected to get fixed at some point wrt DWARF? Perhaps would make
> > >
> > > No, gcc closed the issue as "won't fix".
> > >
> > > > sense then to add a negative "depends" for both DWARF and BTF if the option
> > > > GCC_PLUGIN_RANDSTRUCT is set given both would be incompatible/broken.
> > >
> > > I hadn't just to keep wider randconfig build test coverage. That said, I
> > > could make it be: depends COMPILE_TEST || !DWARF ...
> > >
> > > I can certainly do that.
> >
> > I've asked Slava in [0] to disable all three known configs that break
> > DWARF and subsequently BTF, I hope it's ok to just do it in one patch.
> > Currently all these appear to result in invalid BTF due to various
> > DWARF modifications:
> >
> >   - DEBUG_INFO_REDUCED (see [1])
> >   - DEBUG_INFO_SPLIT (see [0]
> >   - GCC_PLUGIN_RANDSTRUCT (this discussion).
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4BzadnfAwfa1D0jZb=01Ou783GpK_U7PAYeEJca-L9kdnVA@mail.gmail.com/
> >   [1] https://lore.kernel.org/bpf/CAEf4BzZri8KpwLcoPgjiVx_=QmJ2W9UzBkDqSO2rUWMzWogkKg@mail.gmail.com/
>
> Sure! That'd by fine by me. I'd just like it to be a "|| COMPILE_TEST"
> for GCC_PLUGIN_RANDSTRUCT. Feel free to CC me for an Ack. :)
>

+cc Slava

I'm unsure what COMPILE_TEST dependency (or is it anti-dependency?)
has to do with BTF generation and reading description in Kconfig
didn't clarify it for me. Can you please elaborate just a bit? Thanks!

> -Kees
>
> >
> >
> > >
> > > -Kees
> > >
> > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84052
> > >
> > > --
> > > Kees Cook
>
> --
> Kees Cook
