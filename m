Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E8372135
	for <lists+bpf@lfdr.de>; Mon,  3 May 2021 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhECUVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 May 2021 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECUVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 May 2021 16:21:36 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE242C06174A
        for <bpf@vger.kernel.org>; Mon,  3 May 2021 13:20:42 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id o192so3603767vsd.7
        for <bpf@vger.kernel.org>; Mon, 03 May 2021 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMOwLFmz6GugapCkf5uuvpANHBPJMCc9AvAkHonn0cI=;
        b=EPyWrLgtgQ5Ac9pBZ4rDSsyGEtWwgI6tTyNPRVrT+e6rilJXLzNmcKGEeHtBgv0vcd
         FOuii4RFjbLeOsUVsh77gG8AmPal82W9KpZ8k0nLMbAoZauKggL+891xUqIFK6aQALSt
         eY2oUqPf63XsC4l2PVYZTjLUDbFnW5hbNzxFf3abbrlionp+rfA7NBizBt74eTdHHy70
         m0N3rzQ0iyhwQdUL7dToYJcwJDr5o0jLVbMHbEqPEF2qKRkt7VCIrkeBBLVssMPLOxpb
         jhqzvZMhbTvr0hcaa2j+M7LOBkrLOrM/qvt6EeUKWOZzKLbajMsigMw/50HSDn3zjAds
         ZrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMOwLFmz6GugapCkf5uuvpANHBPJMCc9AvAkHonn0cI=;
        b=rhWH+5J3LaRE8LcqDDD0ghZjOgRVtxH6pXpdLTetPhgRDk+dWPbVK/AL4EaFj7eBbC
         wjrfKR5jtWkqsdumivHTdxfKc6M5piLSwZvkokeCweHGjRYFxLjEskCDq1FtHtgnKrNG
         oZIjieBJdj3VB1NGQtVd8tMrw0DN9rXPkV6IgRdXG5eQSZ26nukqWDhoOmGkY7faVjWG
         jldrd2bzTdblBpighuKc8dGgg8K+PnVHZY1+MdhwqwFh6tZY8uSfEzIgAHY+rXpsKXkR
         h+8MDbrKaW/PJHz/vBX7irZySWrYrAywMz0fHBulR097gF7Cvwv8V9FdG2g4UIvxCNfZ
         FMQw==
X-Gm-Message-State: AOAM5314w9ENNZDGsy1WdW/SO5jFykPDNwsxf+MCpSZop37sEymaDAmd
        bm/xWSHsNl4jJiqUqCHncdVO/+96fpYeoV9q9QM=
X-Google-Smtp-Source: ABdhPJwySJgTSEPWJbAV2OIo7bhWgyXetlNblSTZMYM2NtZvvph+hfcLpGksz8aCP7Kx6Pitst4Ygq7yIYgikpMcNxU=
X-Received: by 2002:a05:6102:507:: with SMTP id l7mr4227499vsa.25.1620073241795;
 Mon, 03 May 2021 13:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
 <CAEf4Bzayxgt3P+kz36t6C8jp-MUTuwuKvwHWWsd2qrCs3-RHXA@mail.gmail.com>
 <CAO658oUpqOHmSAif+6zor1XTruDqHeTzAQHrCXOSPRo6oTp5vg@mail.gmail.com> <CAEf4BzYfn0SonnH=R-kA8eeYD5yBrAFQTsEMDtuOX=MaadTJsA@mail.gmail.com>
In-Reply-To: <CAEf4BzYfn0SonnH=R-kA8eeYD5yBrAFQTsEMDtuOX=MaadTJsA@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 3 May 2021 16:20:30 -0400
Message-ID: <CAO658oWY3QK0A3U=NeDzXJRPsydCFWCrx1kdAfSdtq9CpNj0ow@mail.gmail.com>
Subject: Re: Typical way to handle missing macros in vmlinux.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 3, 2021 at 2:43 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 3, 2021 at 11:32 AM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Wed, Apr 28, 2021 at 5:15 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Apr 28, 2021 at 1:53 PM Grant Seltzer Richman
> > > <grantseltzer@gmail.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I'm working on enabling CO:RE in a project I work on, tracee, and am
> > > > running into the dilemma of missing macros that we previously were
> > > > able to import from their various header files. I understand that
> > > > macros don't make their way into BTF and therefore the generated
> > > > vmlinux.h won't have them. However I can't import the various header
> > > > files because of multiple-definition issues.
> > >
> > > Sadly, copy/pasting has been the only way so far.
> > >
> > > >
> > > > Do people typically redefine each of these macros for their project?
> > > > If so is there anything I should be careful of, such as architectural
> > > > differences. Does anyone have creative ideas, even if not developed
> > > > fully yet that I can possibly contribute to libbpf?
> > >
> > > We've discussed adding Clang built-in to detect if a specific type is
> > > already defined and doing something like this in vmlinux.h:
> > >
> > > #if !__builtin_is_type_defined(struct task_struct)
> > > struct task_struct {
> > >      ...
> > > }
> > > #endif
> > >
> > > And just do that for every struct, union, typedef. That would allow
> > > vmlinux.h to co-exist (somewhat) with other types.
> > >
> > > Another alternative is to not use vmlinux.h and use just linux
> > > headers, but mark necessary types with
> > > __attribute__((preserve_access_index)) to make them CO-RE relocatable.
> > > You can add that to existing types with the same pragma that vmlinux.h
> > > uses.
> >
> > I'm attempting to try doing the above. I'm just replacing
> > bpf_probe_read with bpf_core_read and not importing vmlinux.h, just
> > all the kernel headers I need.
>
> Yes, that will work, bpf_core_read() uses preserve_access_index
> built-in to achieve the same effect.
>
> >
> > When you say "Add that to existing types with the same pragma that
> > vmlinux.h uses", Should I be able to add the following to my bpf
> > source file before importing my headers?
> >
> > ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> > #pragma clang attribute push (__attribute__((preserve_access_index)),
> > apply_to = record)
> > #endif
> >
> > and then pop the attribute at the bottom of the file, or after the
> > header includes.
>
> Yeah, that's the idea and that's what vmlinux.h does for all its
> structs. It doesn't add __attribute__((preserve_access_index)) after
> each struct/union. So I wonder why you are getting those unknown
> attribute errors. Can you paste an example?

Here's a couple examples of the warnings:

```
tracee/tracee.bpf.c:5:46: warning: unknown attribute
'preserve_access_index' ignored [-Wunknown-attributes]
#pragma clang attribute push (__attribute__((preserve_access_index)),
apply_to = record)
                                             ^
/lib/modules/5.10.21-200.fc33.x86_64/source/include/linux/ipv6.h:185:1:
note: when applied to this declaration
struct ipv6_fl_socklist;
^
tracee/tracee.bpf.c:5:46: warning: unknown attribute
'preserve_access_index' ignored [-Wunknown-attributes]
#pragma clang attribute push (__attribute__((preserve_access_index)),
apply_to = record)
                                             ^
/lib/modules/5.10.21-200.fc33.x86_64/source/include/linux/ipv6.h:187:1:
note: when applied to this declaration
struct inet6_cork {
```

after these warnings are emitted (it seems as if there's one for every
data type, though I can't confirm), I get errors that look like this:

```
tracee/tracee.bpf.c:445:22: error: nested
builtin_preserve_access_index() not supported
    return READ_KERN(READ_KERN(task->thread_pid)->numbers[level].nr);
                     ^
tracee/tracee.bpf.c:206:27: note: expanded from macro 'READ_KERN'
                          bpf_core_read(&_val, sizeof(_val), &ptr); \
```
I believe this is just a result of the warnings above, but if you're
curious it's what i'm doing here:
https://github.com/aquasecurity/tracee/blob/core-experiment/tracee-ebpf/tracee/tracee.bpf.c#L204-L208

>
> Also check that you use Clang that supports preserve_access_index, of course.

I'm using clang 11.0 on Fedora 33. All dependencies appear properly
installed (libelf, zlib, dwarves [provides pahole], llvm, llc,
llvm-devel,...)

>
> >
> > I've tried this and get a whole bunch of 'unknown attribute' warnings,
> > leading me to believe that I either have something installed
> > incorrectly or don't understand how to use clang attributes. Do I need
> > to edit the types in the actual header files?
>
> No, the whole idea is to not touch original headers.

Got it - that's good to know.

>
> >
> > Thank you very very much for the help!
> > - Grant
> > >
> > > >
> > > > Thanks so much,
> > > > Grant Seltzer
