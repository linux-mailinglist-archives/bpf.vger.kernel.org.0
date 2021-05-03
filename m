Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B96371FD7
	for <lists+bpf@lfdr.de>; Mon,  3 May 2021 20:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhECSop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 May 2021 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhECSoo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 May 2021 14:44:44 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BB9C06174A
        for <bpf@vger.kernel.org>; Mon,  3 May 2021 11:43:51 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z1so8869837ybf.6
        for <bpf@vger.kernel.org>; Mon, 03 May 2021 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCO33FMH94UjbMIsyUt/KfLk5M3w+L3cj6/gR6TEoZ0=;
        b=MSQVLN90oZCQpSsTGwASYt6mvFjAMTtI8D8k1Ew6ra7/0yaxD0r0fgbQGKJne0PTXg
         xCdz06/xuq1YAqzmn8SmLdBSAkfJ32qxH02BjO0n7ns56kW3g0efkbWvs4LfLL/nmVWF
         yEnPMyTKsPK15iW1g72baqnJHIN3rHjqJ2p/LCQ+j+UH76xifD/cgO71B9l9u2zEpGbv
         ZeWy7FNFSwN34es+7XntZdmWtxfSBFwJlrIlWfcVha7sLl52THrOj7Vu45WiXwcFF9oz
         BfQRa1cVSZy/rFGSHUY/jFsSvFAy01TOQVtw/Un6Nxcuq9bgACErYPe7Wjfxd/g0xOia
         TEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCO33FMH94UjbMIsyUt/KfLk5M3w+L3cj6/gR6TEoZ0=;
        b=WfCuTEXgTeqQdeAS7tw5APgHCTz/TITZdPxzAx3gzj31KwqxBCsxGdasJl5P1m1h6g
         xqIseGHF/Jx2+SXp1EJ2aaMgT7to2vpRiuc8qg1amY2djYLsromS/TaqYQmkOba+wHIh
         PfisGUHHRnfkoJDbuPoHZc87fErsQr5+h8dELaPqZuCjmZ4b8TDhUm6dmyJevlua2Z/x
         Zo/y0szlx+PVDlDSgipZQK2VTd/X2P4RyArwMDWntVTjZKSeNZJRkWHVSFnGF/uKW13j
         a8n45npi/4nqfLI9Ufz5Fj1UkqflnACCA6bjsUu004zZ1DJDocmnfNNSvoRDYX0gMI9v
         Ei8Q==
X-Gm-Message-State: AOAM5339USorEI5J3oSXvH9KZoJmA9wXpR9fScuJccEubn++q0Fw+fZL
        H5EvPFFmtuol8H6exYsU0JTn0Kl7EMV+9AgYOFo=
X-Google-Smtp-Source: ABdhPJxGgMDXPvY2WJ/xJ0El8cN1RtG5qEtT3jxsXDJFFzn8OroV1nLCpcExesthOUhb0OEVOTEP7uGZWaMDmBlYYJI=
X-Received: by 2002:a5b:645:: with SMTP id o5mr30637804ybq.347.1620067430569;
 Mon, 03 May 2021 11:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
 <CAEf4Bzayxgt3P+kz36t6C8jp-MUTuwuKvwHWWsd2qrCs3-RHXA@mail.gmail.com> <CAO658oUpqOHmSAif+6zor1XTruDqHeTzAQHrCXOSPRo6oTp5vg@mail.gmail.com>
In-Reply-To: <CAO658oUpqOHmSAif+6zor1XTruDqHeTzAQHrCXOSPRo6oTp5vg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 3 May 2021 11:43:39 -0700
Message-ID: <CAEf4BzYfn0SonnH=R-kA8eeYD5yBrAFQTsEMDtuOX=MaadTJsA@mail.gmail.com>
Subject: Re: Typical way to handle missing macros in vmlinux.h
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 3, 2021 at 11:32 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Wed, Apr 28, 2021 at 5:15 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 28, 2021 at 1:53 PM Grant Seltzer Richman
> > <grantseltzer@gmail.com> wrote:
> > >
> > > Hi all,
> > >
> > > I'm working on enabling CO:RE in a project I work on, tracee, and am
> > > running into the dilemma of missing macros that we previously were
> > > able to import from their various header files. I understand that
> > > macros don't make their way into BTF and therefore the generated
> > > vmlinux.h won't have them. However I can't import the various header
> > > files because of multiple-definition issues.
> >
> > Sadly, copy/pasting has been the only way so far.
> >
> > >
> > > Do people typically redefine each of these macros for their project?
> > > If so is there anything I should be careful of, such as architectural
> > > differences. Does anyone have creative ideas, even if not developed
> > > fully yet that I can possibly contribute to libbpf?
> >
> > We've discussed adding Clang built-in to detect if a specific type is
> > already defined and doing something like this in vmlinux.h:
> >
> > #if !__builtin_is_type_defined(struct task_struct)
> > struct task_struct {
> >      ...
> > }
> > #endif
> >
> > And just do that for every struct, union, typedef. That would allow
> > vmlinux.h to co-exist (somewhat) with other types.
> >
> > Another alternative is to not use vmlinux.h and use just linux
> > headers, but mark necessary types with
> > __attribute__((preserve_access_index)) to make them CO-RE relocatable.
> > You can add that to existing types with the same pragma that vmlinux.h
> > uses.
>
> I'm attempting to try doing the above. I'm just replacing
> bpf_probe_read with bpf_core_read and not importing vmlinux.h, just
> all the kernel headers I need.

Yes, that will work, bpf_core_read() uses preserve_access_index
built-in to achieve the same effect.

>
> When you say "Add that to existing types with the same pragma that
> vmlinux.h uses", Should I be able to add the following to my bpf
> source file before importing my headers?
>
> ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> #pragma clang attribute push (__attribute__((preserve_access_index)),
> apply_to = record)
> #endif
>
> and then pop the attribute at the bottom of the file, or after the
> header includes.

Yeah, that's the idea and that's what vmlinux.h does for all its
structs. It doesn't add __attribute__((preserve_access_index)) after
each struct/union. So I wonder why you are getting those unknown
attribute errors. Can you paste an example?

Also check that you use Clang that supports preserve_access_index, of course.

>
> I've tried this and get a whole bunch of 'unknown attribute' warnings,
> leading me to believe that I either have something installed
> incorrectly or don't understand how to use clang attributes. Do I need
> to edit the types in the actual header files?

No, the whole idea is to not touch original headers.

>
> Thank you very very much for the help!
> - Grant
> >
> > >
> > > Thanks so much,
> > > Grant Seltzer
