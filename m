Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2E30FC80
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 20:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbhBDTVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 14:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbhBDSf3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 13:35:29 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB2C06178B
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 10:34:48 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a16so1264868uad.9
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 10:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eihxO5r/t34DbPHv1BAApe+ovuE0Dvbi7s4289fXd6g=;
        b=OctQePZZd+NwZFyoBBtGSzDhOZGgU8kUT3Hs98MiL/unuiolbTutE9oFVWAwkNx7c9
         Q1LTbSMjigJthSLN+YtX02kXrnk5R1NiPGsNUr0eJN3oRS0dx/YBZcVrUUnPaloTrYKX
         p8Fmi40IUvq9F39USoH7HGcaWJCUx4lRFsaiD9BjAvfX0vvbcGbO1dukQRg8UvvpgV5A
         wiuEBN4JxbeRN9sNKVPIZ5QUfMIoygQMJtypxnvS/VPRlutT+eS27cbSnAbvYPvSVk8B
         +ipG8cvvEKI9Cnna5P3WwLyckjt2W7WW73PEpHulFdeThqFhVMofxSgrGlJcqd3c/0+0
         tfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eihxO5r/t34DbPHv1BAApe+ovuE0Dvbi7s4289fXd6g=;
        b=VO3TNDjXK/Jt9JyUlFDkDb1WHRhVlZPSaYiZgMFs0s8oobqpQngzyk6f1AM+7BkiCl
         rjCf5dKm7oSRncoeHA42tSZSTrl8D0OAKKxOepjiFKhJRr6blYWp9ZtbQg85wV5zieiC
         pbAmH5st4C8OWRDESI2C0CYxkMK6yFRmY1fqkrgaMOXNUEYGgXjuSLJ0hERrmGytb57e
         nz/r1hqAT0dBKQoL3LbwA7e1r5WoQij1/O3vRGvd+WXxmMRU/ZLwrSqRuwEUifkl9Dai
         KNe6vpYtXOulaXbmdYPXOikqm1M2FOFPwxODExPc/suykCB3zKv0JQKI5CyrODuV+Jvp
         Z+VQ==
X-Gm-Message-State: AOAM533ejQdDj5KHMuIsDXbgdRxd/uwyUFLo00hSJiFDjt4yViUIgY56
        zg0Uzrk51RmyerGFj4bvQb9X+I8AbFIpjS4ZSsM7Sw==
X-Google-Smtp-Source: ABdhPJwhIwSb8JQXRdT899QtxY5y0uunhas7rYQuzYOsol4WwQjeL3eBJaT8N21+STAZ94zPsHAFp9MVpQGajTymUYc=
X-Received: by 2002:a9f:248b:: with SMTP id 11mr528653uar.133.1612463687332;
 Thu, 04 Feb 2021 10:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-3-gprocida@google.com>
 <CAEf4BzY_xk2H1Eh9h_WiXbqP3O-afiZnmpWf=MtCrqdJeNW+ag@mail.gmail.com>
In-Reply-To: <CAEf4BzY_xk2H1Eh9h_WiXbqP3O-afiZnmpWf=MtCrqdJeNW+ag@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Thu, 4 Feb 2021 18:34:10 +0000
Message-ID: <CAGvU0HmHR0AXKT2=LyD6HWdr79JM9kWjLTZhajjUJx+p2QB0tA@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 2/4] btf_encoder: Manually lay out updated ELF sections
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.

On Thu, 4 Feb 2021 at 04:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 1, 2021 at 9:26 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > pahole -J needs to do the following to an ELF file:
> >
> > * add or update the ".BTF" section
> > * maybe update the section name string table
> > * update the Section Header Table (SHT)
> >
> > libelf either takes full control of layout or requires the user to
> > specify offset, size and alignment of all new and updated sections and
> > headers.
> >
> > To avoid libelf moving program segments in particular, we position the
>
> It's not clear to me what's wrong with libelf handling all the layout.
> Even if libelf will move program segments around, what's the harm?
> Does it break anything if we just let libelf do this?
>

It doesn't hurt the userspace case I care about. I've no idea what it
means in terms of vmlinux.

However, I wrote that text before I discovered that pahole -J isn't
actually used to modify kernel images.

One thing I haven't tried is to try to make .BTF loadable but leave
placement to libelf.

> > ".BTF" and section name string table (typically named ".shstrtab")
> > sections after all others. The SHT always lives at the end of the file.
> >
> > Note that the last section in an ELF file is normally the section name
> > string table and any ".BTF" section will normally be second last.
> > However, if these sections appear earlier, then we'll waste some space
> > in the ELF file when we rewrite them.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> >  libbtf.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 62 insertions(+), 2 deletions(-)
> >
>
> [...]
