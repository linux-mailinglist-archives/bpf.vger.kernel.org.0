Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CEF372E4D
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 18:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEDQ6I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEDQ6I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 12:58:08 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379EC061574
        for <bpf@vger.kernel.org>; Tue,  4 May 2021 09:57:13 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id j13so5129535vsf.2
        for <bpf@vger.kernel.org>; Tue, 04 May 2021 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkFvfyJ9VI2OgQ89vUiSm4qF+7y//eLI+wKJF3FKDJM=;
        b=N1CjTIV3/ARvPxL7jMpjstv7BQ/hc7un8B72DldOVaDkL8dzNoDDCuf5EZ5U5PhnWI
         B5yolPfbSAsex0vhatpnTUNJTz72E4O4yatJXBoxInYq07c4Mk7rxPFIWZo6TM2UEU6r
         f5z4lEy5Q0wdlF2/seYUQTVHSo9/FDApH1oEjQebWrdqnJZgT43yoii6OTL2ffd+Vtzo
         38+AEtkg4xkKXITL4rY+ILpvmWp4gXJHDl0LVnuKpqOG4jAAzpQiMho8e3Jj4ZXVhL1+
         7AVcUEUz6teH/+m9f6GI/OGk4j94tayCbKGvuEx6uJTlawcXTMLRodTk3IKZwml5sDas
         XE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkFvfyJ9VI2OgQ89vUiSm4qF+7y//eLI+wKJF3FKDJM=;
        b=P9X3wIi1OpkToatdicbN8lyLn/LGDeYjfLLgFtmSeIw4NYWxY27/pB/GUn4jyUxxyx
         dJKg184j/kYWQK7uGh94lfapYtqFQzPpM99WdFPudNy7vXZG1hK/ey8k1pebA6a9c1Of
         rlqmBrQZJSvmxxl+6AzibGKVNfAc24QFubc/nI4BAeJ1ePV6SCrnwHboNra2b8KH5uw3
         /QjhHfOZYoX30qTh3mB7SXo3EKN7/6r1VGXeWiLIBJdmzaejtlF976FyNziAChAPkzAr
         43wo8CXkDGgft3hmLoRhk2HHtyzOA1mDhYxUU/j4RKlP5pRzjCZGLyAd2CQzxVFjb4U2
         N09w==
X-Gm-Message-State: AOAM533DCGnTdY5wU8PKgc+4M/AZFrWz/vgqG7Tl3alHVvnqyaMv2657
        vXLbAGHt6rR+fuGyx4KZUwy8UCr5zq1AER09nEs=
X-Google-Smtp-Source: ABdhPJx1C7swSqo1F6lNAQMMzf7n9Vst2AiVZb719PDLl+Y/QJmZhUC9tS1nZwLdp9XSo2cIWY5KxQ4P3AEGRl8YhEs=
X-Received: by 2002:a67:f146:: with SMTP id t6mr20919290vsm.22.1620147432072;
 Tue, 04 May 2021 09:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
 <CAEf4Bzayxgt3P+kz36t6C8jp-MUTuwuKvwHWWsd2qrCs3-RHXA@mail.gmail.com>
 <CAO658oUpqOHmSAif+6zor1XTruDqHeTzAQHrCXOSPRo6oTp5vg@mail.gmail.com>
 <CAEf4BzYfn0SonnH=R-kA8eeYD5yBrAFQTsEMDtuOX=MaadTJsA@mail.gmail.com>
 <CAO658oWY3QK0A3U=NeDzXJRPsydCFWCrx1kdAfSdtq9CpNj0ow@mail.gmail.com>
 <CAEf4BzbRTuYQtzSScqCkM8dLfLLDzRs2BPKrHbrx3=joFr5YPw@mail.gmail.com>
 <CAO658oX7_b18Q4OxZ_PxAPhBjQPXv4+dQsQzH1-TWKhozikWiA@mail.gmail.com> <294a5f06-19dd-d649-a000-c40f1fdbd299@fb.com>
In-Reply-To: <294a5f06-19dd-d649-a000-c40f1fdbd299@fb.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 4 May 2021 12:57:00 -0400
Message-ID: <CAO658oX64YmV_qnR=zx5yhcmBP=WEdigkjopDuRF0sPaCV-UqQ@mail.gmail.com>
Subject: Re: Typical way to handle missing macros in vmlinux.h
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 4, 2021 at 12:25 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/4/21 8:31 AM, Grant Seltzer Richman wrote:
> > On Mon, May 3, 2021 at 5:22 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, May 3, 2021 at 1:20 PM Grant Seltzer Richman
> >> <grantseltzer@gmail.com> wrote:
> >>>
> >>> On Mon, May 3, 2021 at 2:43 PM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>>
> >>>> On Mon, May 3, 2021 at 11:32 AM Grant Seltzer Richman
> >>>> <grantseltzer@gmail.com> wrote:
> >>>>>
> >>>>> On Wed, Apr 28, 2021 at 5:15 PM Andrii Nakryiko
> >>>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>>>
> >>>>>> On Wed, Apr 28, 2021 at 1:53 PM Grant Seltzer Richman
> >>>>>> <grantseltzer@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> I'm working on enabling CO:RE in a project I work on, tracee, and am
> >>>>>>> running into the dilemma of missing macros that we previously were
> >>>>>>> able to import from their various header files. I understand that
> >>>>>>> macros don't make their way into BTF and therefore the generated
> >>>>>>> vmlinux.h won't have them. However I can't import the various header
> >>>>>>> files because of multiple-definition issues.
> >>>>>>
> >>>>>> Sadly, copy/pasting has been the only way so far.
> >>>>>>
> >>>>>>>
> >>>>>>> Do people typically redefine each of these macros for their project?
> >>>>>>> If so is there anything I should be careful of, such as architectural
> >>>>>>> differences. Does anyone have creative ideas, even if not developed
> >>>>>>> fully yet that I can possibly contribute to libbpf?
> >>>>>>
> >>>>>> We've discussed adding Clang built-in to detect if a specific type is
> >>>>>> already defined and doing something like this in vmlinux.h:
> >>>>>>
> >>>>>> #if !__builtin_is_type_defined(struct task_struct)
> >>>>>> struct task_struct {
> >>>>>>       ...
> >>>>>> }
> >>>>>> #endif
> >>>>>>
> >>>>>> And just do that for every struct, union, typedef. That would allow
> >>>>>> vmlinux.h to co-exist (somewhat) with other types.
> >>>>>>
> >>>>>> Another alternative is to not use vmlinux.h and use just linux
> >>>>>> headers, but mark necessary types with
> >>>>>> __attribute__((preserve_access_index)) to make them CO-RE relocatable.
> >>>>>> You can add that to existing types with the same pragma that vmlinux.h
> >>>>>> uses.
> >>>>>
> >>>>> I'm attempting to try doing the above. I'm just replacing
> >>>>> bpf_probe_read with bpf_core_read and not importing vmlinux.h, just
> >>>>> all the kernel headers I need.
> >>>>
> >>>> Yes, that will work, bpf_core_read() uses preserve_access_index
> >>>> built-in to achieve the same effect.
> >>>>
> >>>>>
> >>>>> When you say "Add that to existing types with the same pragma that
> >>>>> vmlinux.h uses", Should I be able to add the following to my bpf
> >>>>> source file before importing my headers?
> >>>>>
> >>>>> ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> >>>>> #pragma clang attribute push (__attribute__((preserve_access_index)),
> >>>>> apply_to = record)
> >>>>> #endif
> >>>>>
> >>>>> and then pop the attribute at the bottom of the file, or after the
> >>>>> header includes.
> >>>>
> >>>> Yeah, that's the idea and that's what vmlinux.h does for all its
> >>>> structs. It doesn't add __attribute__((preserve_access_index)) after
> >>>> each struct/union. So I wonder why you are getting those unknown
> >>>> attribute errors. Can you paste an example?
> >>>
> >>> Here's a couple examples of the warnings:
> >>>
> >>> ```
> >>> tracee/tracee.bpf.c:5:46: warning: unknown attribute
> >>> 'preserve_access_index' ignored [-Wunknown-attributes]
> >>> #pragma clang attribute push (__attribute__((preserve_access_index)),
> >>> apply_to = record)
> >>>                                               ^
> >>> /lib/modules/5.10.21-200.fc33.x86_64/source/include/linux/ipv6.h:185:1:
> >>> note: when applied to this declaration
> >>> struct ipv6_fl_socklist;
> >>> ^
> >>> tracee/tracee.bpf.c:5:46: warning: unknown attribute
> >>> 'preserve_access_index' ignored [-Wunknown-attributes]
> >>> #pragma clang attribute push (__attribute__((preserve_access_index)),
> >>> apply_to = record)
> >>>                                               ^
> >>> /lib/modules/5.10.21-200.fc33.x86_64/source/include/linux/ipv6.h:187:1:
> >>> note: when applied to this declaration
> >>> struct inet6_cork {
> >>> ```
> >>>
> >>> after these warnings are emitted (it seems as if there's one for every
> >>> data type, though I can't confirm), I get errors that look like this:
> >>>
> >>> ```
> >>> tracee/tracee.bpf.c:445:22: error: nested
> >>> builtin_preserve_access_index() not supported
> >>>      return READ_KERN(READ_KERN(task->thread_pid)->numbers[level].nr);
> >>>                       ^
> >>> tracee/tracee.bpf.c:206:27: note: expanded from macro 'READ_KERN'
> >>>                            bpf_core_read(&_val, sizeof(_val), &ptr); \
> >>> ```
> >>> I believe this is just a result of the warnings above, but if you're
> >>> curious it's what i'm doing here:
> >>> https://github.com/aquasecurity/tracee/blob/core-experiment/tracee-ebpf/tracee/tracee.bpf.c#L204-L208
> >>>
> >>
> >> Looking at your Makefile, you are not using `clang -target bpf` to
> >> compile BPF object files, which is probably what causes you trouble.
> >> preserve_access_index is a BPF target-only attribute. There is no need
> >> to do the legacy clang -emit-llvm | llc, especially when you are using
> >> CO-RE.
> >
> > Got it. Funny enough, it turns out this is just a continuation of a
> > conversation you had with my coworker Yaniv last year:
> > https://lore.kernel.org/bpf/CAEf4BzbshRMCX1T1ooAtYGYuUGefbbo2=ProkMg5iOtUKh3YtQ@mail.gmail.com/
> >
> > But to summarize our continued challenge: Adding the
> > `preserve_access_index` attribute, compiling with `-target bpf`, and
> > using the same kernel headers we used (not vmlinux.h) causes issues
> > because of architecture specific asm errors (likely stemming from
> > headers we include). Unless there's a way to get around those we're
> > going to need to include "vmlinux.h", change our Makefile to `-target
> > bpf`, and redefine macros and/or functions that vmlinux.h does not
> > provide.
> >
> > I think this is a pretty significant usability challenge. The idea you
> > mentioned of having a built-in to detect if a type is defined would be
> > a huge step forward. Has any progress been made towards this?
>
> I briefly looked at this probably one and half years ago.
> It will involve tweak clang frontend cpp side. Now I haven't
> done any concrete work yet. But will look at it in the future.

Got it - thanks for the info. Also any advice you or anyone else has
to avoid having to redefine functions would be very much appreciated!

>
> >
> > Another thought is having vmlinux.h include function definitions,
> > aren't they included in DWARF/BTF?
> >
> > Thanks for your help, as always, Andrii!
> >
> >>
> >>>>
> >>>> Also check that you use Clang that supports preserve_access_index, of course.
> >>>
> >>> I'm using clang 11.0 on Fedora 33. All dependencies appear properly
> >>> installed (libelf, zlib, dwarves [provides pahole], llvm, llc,
> >>> llvm-devel,...)
> >>>
> >>>>
> >>>>>
> >>>>> I've tried this and get a whole bunch of 'unknown attribute' warnings,
> >>>>> leading me to believe that I either have something installed
> >>>>> incorrectly or don't understand how to use clang attributes. Do I need
> >>>>> to edit the types in the actual header files?
> >>>>
> >>>> No, the whole idea is to not touch original headers.
> >>>
> >>> Got it - that's good to know.
> >>>
> >>>>
> >>>>>
> >>>>> Thank you very very much for the help!
> >>>>> - Grant
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks so much,
> >>>>>>> Grant Seltzer
