Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3049373282
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 00:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEDWdx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 18:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhEDWds (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 18:33:48 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DA7C061352
        for <bpf@vger.kernel.org>; Tue,  4 May 2021 15:32:07 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g38so103097ybi.12
        for <bpf@vger.kernel.org>; Tue, 04 May 2021 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/D3xfOMBtfFqiQhB4S/kEHKMnmQay9PQwry7qoljWRE=;
        b=gzPR1SVVwMGCvJRdvEnTWW7vTC5Z66ldrDK5BFFft0NmXjZdxuCh1+tIbfj6d34XQK
         gH3GXQmpS+aUWQrukwhb9hI/WFxp2XqqhzOfDHQdPxP6YpprcZR6hbDvYmPqnG8xlGJM
         lvyf1QwLZFhun4SnnwDk+mvxbbLzYCHf8geyvXiiZnTf5XxYgWJ2BTvdBKsUyxv0fqc0
         KSID7ocNJIu63n4piGFMcd3w7TM8jV6/KcuePQHtJWF1P7uL2BlefVaUBMcMQ0id7Lch
         q2YejeMnC7/QapX5vpBiV05y3p+oBKVaHTTWexYoP2GqHA2AgDnW4XvFk0Ub7FzxW1mt
         W5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/D3xfOMBtfFqiQhB4S/kEHKMnmQay9PQwry7qoljWRE=;
        b=EtPRT3GnZzLOtNYQ0PSs+Bt7agU02VuHTuKqBs8sQ5bUP2yKmkjW4YJsAsVDzyJuEX
         ZnNDiHnH+vK8JBjym4XhNddeqBDWnrg0lFCUA9UWy3HSMG2RJ2y20LmR01WqazsaxKXJ
         gMw4s2L2wUcG9gTRQZfC9c5jCnRxJNxisrXSMm6pNpeXR05manhNe3/gWlbKQ71Xncid
         5WOUxGWSa3EtkivEZLiPiw+vf1undF9lFJUpTIvN7KeXszhURdNyaZyfsDPI/biWT5YE
         g5a6V6nNBNtmFsi0zZs/0sppIRXWTqOhE0rIa9Xsxpb3nl7TMJ+OKgTeaDQA75vyDf/4
         Hqsw==
X-Gm-Message-State: AOAM530Scf7i8nPOiGSAf2Zi3hdSCYAa74YunZBd6+MdC2aVBuKmsP47
        fTMVIQ/o3HNqMxvdcsEPhPFENaylDZhEv4tPG9UGwEIE
X-Google-Smtp-Source: ABdhPJyBamjze9UDWIpmJvwNiaNVBq5IOmkvRp1VAFRVOY7aQlz/zgeq+jeu6BQJ5RHcUnQMn6gtAzpmezi/JlpZnI8=
X-Received: by 2002:a5b:286:: with SMTP id x6mr2423198ybl.347.1620167526731;
 Tue, 04 May 2021 15:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
 <CAEf4Bzayxgt3P+kz36t6C8jp-MUTuwuKvwHWWsd2qrCs3-RHXA@mail.gmail.com>
 <CAO658oUpqOHmSAif+6zor1XTruDqHeTzAQHrCXOSPRo6oTp5vg@mail.gmail.com>
 <CAEf4BzYfn0SonnH=R-kA8eeYD5yBrAFQTsEMDtuOX=MaadTJsA@mail.gmail.com>
 <CAO658oWY3QK0A3U=NeDzXJRPsydCFWCrx1kdAfSdtq9CpNj0ow@mail.gmail.com>
 <CAEf4BzbRTuYQtzSScqCkM8dLfLLDzRs2BPKrHbrx3=joFr5YPw@mail.gmail.com> <CAO658oX7_b18Q4OxZ_PxAPhBjQPXv4+dQsQzH1-TWKhozikWiA@mail.gmail.com>
In-Reply-To: <CAO658oX7_b18Q4OxZ_PxAPhBjQPXv4+dQsQzH1-TWKhozikWiA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 May 2021 15:31:55 -0700
Message-ID: <CAEf4Bzb7ZvkKBVorCeu2qVv0Xc7UmNr2Bz27r831+O3wwtgywQ@mail.gmail.com>
Subject: Re: Typical way to handle missing macros in vmlinux.h
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 4, 2021 at 8:32 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Mon, May 3, 2021 at 5:22 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, May 3, 2021 at 1:20 PM Grant Seltzer Richman
> > <grantseltzer@gmail.com> wrote:
> > >
> > > On Mon, May 3, 2021 at 2:43 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, May 3, 2021 at 11:32 AM Grant Seltzer Richman
> > > > <grantseltzer@gmail.com> wrote:
> > > > >
> > > > > On Wed, Apr 28, 2021 at 5:15 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 28, 2021 at 1:53 PM Grant Seltzer Richman
> > > > > > <grantseltzer@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > I'm working on enabling CO:RE in a project I work on, tracee, and am
> > > > > > > running into the dilemma of missing macros that we previously were
> > > > > > > able to import from their various header files. I understand that
> > > > > > > macros don't make their way into BTF and therefore the generated
> > > > > > > vmlinux.h won't have them. However I can't import the various header
> > > > > > > files because of multiple-definition issues.
> > > > > >
> > > > > > Sadly, copy/pasting has been the only way so far.
> > > > > >
> > > > > > >
> > > > > > > Do people typically redefine each of these macros for their project?
> > > > > > > If so is there anything I should be careful of, such as architectural
> > > > > > > differences. Does anyone have creative ideas, even if not developed
> > > > > > > fully yet that I can possibly contribute to libbpf?
> > > > > >
> > > > > > We've discussed adding Clang built-in to detect if a specific type is
> > > > > > already defined and doing something like this in vmlinux.h:
> > > > > >
> > > > > > #if !__builtin_is_type_defined(struct task_struct)
> > > > > > struct task_struct {
> > > > > >      ...
> > > > > > }
> > > > > > #endif
> > > > > >
> > > > > > And just do that for every struct, union, typedef. That would allow
> > > > > > vmlinux.h to co-exist (somewhat) with other types.
> > > > > >
> > > > > > Another alternative is to not use vmlinux.h and use just linux
> > > > > > headers, but mark necessary types with
> > > > > > __attribute__((preserve_access_index)) to make them CO-RE relocatable.
> > > > > > You can add that to existing types with the same pragma that vmlinux.h
> > > > > > uses.
> > > > >
> > > > > I'm attempting to try doing the above. I'm just replacing
> > > > > bpf_probe_read with bpf_core_read and not importing vmlinux.h, just
> > > > > all the kernel headers I need.
> > > >
> > > > Yes, that will work, bpf_core_read() uses preserve_access_index
> > > > built-in to achieve the same effect.
> > > >
> > > > >
> > > > > When you say "Add that to existing types with the same pragma that
> > > > > vmlinux.h uses", Should I be able to add the following to my bpf
> > > > > source file before importing my headers?
> > > > >
> > > > > ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> > > > > #pragma clang attribute push (__attribute__((preserve_access_index)),
> > > > > apply_to = record)
> > > > > #endif
> > > > >
> > > > > and then pop the attribute at the bottom of the file, or after the
> > > > > header includes.
> > > >
> > > > Yeah, that's the idea and that's what vmlinux.h does for all its
> > > > structs. It doesn't add __attribute__((preserve_access_index)) after
> > > > each struct/union. So I wonder why you are getting those unknown
> > > > attribute errors. Can you paste an example?
> > >
> > > Here's a couple examples of the warnings:
> > >
> > > ```
> > > tracee/tracee.bpf.c:5:46: warning: unknown attribute
> > > 'preserve_access_index' ignored [-Wunknown-attributes]
> > > #pragma clang attribute push (__attribute__((preserve_access_index)),
> > > apply_to = record)
> > >                                              ^
> > > /lib/modules/5.10.21-200.fc33.x86_64/source/include/linux/ipv6.h:185:1:
> > > note: when applied to this declaration
> > > struct ipv6_fl_socklist;
> > > ^
> > > tracee/tracee.bpf.c:5:46: warning: unknown attribute
> > > 'preserve_access_index' ignored [-Wunknown-attributes]
> > > #pragma clang attribute push (__attribute__((preserve_access_index)),
> > > apply_to = record)
> > >                                              ^
> > > /lib/modules/5.10.21-200.fc33.x86_64/source/include/linux/ipv6.h:187:1:
> > > note: when applied to this declaration
> > > struct inet6_cork {
> > > ```
> > >
> > > after these warnings are emitted (it seems as if there's one for every
> > > data type, though I can't confirm), I get errors that look like this:
> > >
> > > ```
> > > tracee/tracee.bpf.c:445:22: error: nested
> > > builtin_preserve_access_index() not supported
> > >     return READ_KERN(READ_KERN(task->thread_pid)->numbers[level].nr);
> > >                      ^
> > > tracee/tracee.bpf.c:206:27: note: expanded from macro 'READ_KERN'
> > >                           bpf_core_read(&_val, sizeof(_val), &ptr); \
> > > ```
> > > I believe this is just a result of the warnings above, but if you're
> > > curious it's what i'm doing here:
> > > https://github.com/aquasecurity/tracee/blob/core-experiment/tracee-ebpf/tracee/tracee.bpf.c#L204-L208
> > >
> >
> > Looking at your Makefile, you are not using `clang -target bpf` to
> > compile BPF object files, which is probably what causes you trouble.
> > preserve_access_index is a BPF target-only attribute. There is no need
> > to do the legacy clang -emit-llvm | llc, especially when you are using
> > CO-RE.
>
> Got it. Funny enough, it turns out this is just a continuation of a
> conversation you had with my coworker Yaniv last year:
> https://lore.kernel.org/bpf/CAEf4BzbshRMCX1T1ooAtYGYuUGefbbo2=ProkMg5iOtUKh3YtQ@mail.gmail.com/
>
> But to summarize our continued challenge: Adding the
> `preserve_access_index` attribute, compiling with `-target bpf`, and
> using the same kernel headers we used (not vmlinux.h) causes issues
> because of architecture specific asm errors (likely stemming from
> headers we include). Unless there's a way to get around those we're
> going to need to include "vmlinux.h", change our Makefile to `-target
> bpf`, and redefine macros and/or functions that vmlinux.h does not
> provide.
>
> I think this is a pretty significant usability challenge. The idea you
> mentioned of having a built-in to detect if a type is defined would be
> a huge step forward. Has any progress been made towards this?
>
> Another thought is having vmlinux.h include function definitions,
> aren't they included in DWARF/BTF?

DWARF might have some #defines recorded if one enables some extra
DWARF subsets (which I don't think are enabled by default). BTF
definitely doesn't have anything like that.

>
> Thanks for your help, as always, Andrii!
>
> >
> > > >
> > > > Also check that you use Clang that supports preserve_access_index, of course.
> > >
> > > I'm using clang 11.0 on Fedora 33. All dependencies appear properly
> > > installed (libelf, zlib, dwarves [provides pahole], llvm, llc,
> > > llvm-devel,...)
> > >
> > > >
> > > > >
> > > > > I've tried this and get a whole bunch of 'unknown attribute' warnings,
> > > > > leading me to believe that I either have something installed
> > > > > incorrectly or don't understand how to use clang attributes. Do I need
> > > > > to edit the types in the actual header files?
> > > >
> > > > No, the whole idea is to not touch original headers.
> > >
> > > Got it - that's good to know.
> > >
> > > >
> > > > >
> > > > > Thank you very very much for the help!
> > > > > - Grant
> > > > > >
> > > > > > >
> > > > > > > Thanks so much,
> > > > > > > Grant Seltzer
