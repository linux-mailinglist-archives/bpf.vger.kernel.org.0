Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3AA199F86
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCaT6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 15:58:33 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37653 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCaT6d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 15:58:33 -0400
Received: by mail-pj1-f67.google.com with SMTP id o12so1572955pjs.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2020 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iIE5XFM5K7QbE20yyDiZj6SZSyFq4hlwbNrIPIzU0gY=;
        b=S+w7GqDb769CQ8xv21FIHZaNTBTZm/T6OlidzROuKsDVAboV/EyN3Llh6Rz9mTZIft
         zotPnmEPIB8CQiPZpqd8ptbr4VcDp3TNcS1e4/py50PXxoyy27AenDHwc+9tWLcOub7S
         xUXQTmtjjTRF4Le26nz+prjPz5JX7fc6k5RGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iIE5XFM5K7QbE20yyDiZj6SZSyFq4hlwbNrIPIzU0gY=;
        b=khRN5tGxH+I6SUHtWG1Vhye8QVz3jnpyeur+FZuXe+hTvkZZOvwbgjHhfeR8aic3Fx
         NY/Y9BRZrjdTP+mWL+KLQI5b+r55aHmAZbNjnF8kKr5RBNnUiasS+Z+Y3yYfLehEQVIx
         W7/v62fjz+m7OwUaX6dtGc7c+NmJkXhLX+GPJHNFpTcOYAJs9rr4Y+KoYUWoUJ551OuO
         fifoHUFUBW1I600mEo4vXwGYZ7GHbTpvmX/vMBhiKq5fM7/r0uuWr6muqMnVuuGtEMtM
         B2LBdYpIVFTXdBq6DK6UY2iDt/dHTTK4D/h3vK1PbEmCXCW2cV5fNvVSgY4xopqbVZ4Y
         swDw==
X-Gm-Message-State: ANhLgQ0ao+l/7o5EvjdUqSS3JG9iUT/RmgXHlMTf2rZPE2SHM/h6qbRh
        eewADMnOYpRiSZvGQfeYwWIU3w==
X-Google-Smtp-Source: ADFU+vthYqtijXEiYJ1M7gXE9t+NnabDok25352WJK4rM43tVjWFqpSgeiB1d/0wichYw3yjyVfreg==
X-Received: by 2002:a17:902:8648:: with SMTP id y8mr18766618plt.153.1585684711969;
        Tue, 31 Mar 2020 12:58:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8sm2553519pjx.12.2020.03.31.12.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:58:31 -0700 (PDT)
Date:   Tue, 31 Mar 2020 12:58:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
Message-ID: <202003311257.3372EC63@keescook>
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
 <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
 <202003301016.D0E239A0@keescook>
 <c332da87-a770-8cf9-c252-5fb64c06c17e@iogearbox.net>
 <202003311110.2B08091E@keescook>
 <CAEf4BzYZsiuQGYVozwB=7nNhVYzCr=fQq6PLgHF3M5AXbhZyig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYZsiuQGYVozwB=7nNhVYzCr=fQq6PLgHF3M5AXbhZyig@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 31, 2020 at 12:50:07PM -0700, Andrii Nakryiko wrote:
> On Tue, Mar 31, 2020 at 11:12 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Mar 31, 2020 at 12:41:04AM +0200, Daniel Borkmann wrote:
> > > On 3/30/20 7:20 PM, Kees Cook wrote:
> > > > On Mon, Mar 30, 2020 at 06:17:32PM +0200, Jann Horn wrote:
> > > > > On Mon, Mar 30, 2020 at 5:59 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
> > > > > > >
> > > > > > > I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
> > > > > > > of CONFIG_GCC_PLUGIN_RANDSTRUCT.
> > > > > >
> > > > > > Is it a theoretical stmt or you have data?
> > > > > > I think it's the other way around.
> > > > > > gcc-plugin breaks dwarf and breaks btf.
> > > > > > But I only looked at gcc patches without applying them.
> > > > >
> > > > > Ah, interesting - I haven't actually tested it, I just assumed
> > > > > (perhaps incorrectly) that the GCC plugin would deal with DWARF info
> > > > > properly.
> > > >
> > > > Yeah, GCC appears to create DWARF before the plugin does the
> > > > randomization[1], so it's not an exposure, but yes, struct randomization
> > > > is pretty completely incompatible with a bunch of things in the kernel
> > > > (by design). I'm happy to add negative "depends" in the Kconfig if it
> > > > helps clarify anything.
> > >
> > > Is this expected to get fixed at some point wrt DWARF? Perhaps would make
> >
> > No, gcc closed the issue as "won't fix".
> >
> > > sense then to add a negative "depends" for both DWARF and BTF if the option
> > > GCC_PLUGIN_RANDSTRUCT is set given both would be incompatible/broken.
> >
> > I hadn't just to keep wider randconfig build test coverage. That said, I
> > could make it be: depends COMPILE_TEST || !DWARF ...
> >
> > I can certainly do that.
> 
> I've asked Slava in [0] to disable all three known configs that break
> DWARF and subsequently BTF, I hope it's ok to just do it in one patch.
> Currently all these appear to result in invalid BTF due to various
> DWARF modifications:
> 
>   - DEBUG_INFO_REDUCED (see [1])
>   - DEBUG_INFO_SPLIT (see [0]
>   - GCC_PLUGIN_RANDSTRUCT (this discussion).
> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzadnfAwfa1D0jZb=01Ou783GpK_U7PAYeEJca-L9kdnVA@mail.gmail.com/
>   [1] https://lore.kernel.org/bpf/CAEf4BzZri8KpwLcoPgjiVx_=QmJ2W9UzBkDqSO2rUWMzWogkKg@mail.gmail.com/

Sure! That'd by fine by me. I'd just like it to be a "|| COMPILE_TEST"
for GCC_PLUGIN_RANDSTRUCT. Feel free to CC me for an Ack. :)

-Kees

> 
> 
> >
> > -Kees
> >
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84052
> >
> > --
> > Kees Cook

-- 
Kees Cook
