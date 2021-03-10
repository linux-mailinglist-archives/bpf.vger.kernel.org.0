Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B3F334A26
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhCJVv5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 16:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhCJVvx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 16:51:53 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8CAC061574;
        Wed, 10 Mar 2021 13:51:53 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id f145so3086771ybg.11;
        Wed, 10 Mar 2021 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hX1sbP8EszqgWKbbcRjaS3YBe+SgvuzH+C2gcwmgs6c=;
        b=o1taLVDQR8GaLFTtrZA5sHQcS20O/8LdKvxul/3Te3g0vypKrqy+emSO5PCxduVrwo
         ncv6rvISPRxcYnQ+0+8gzdwo+noS8WnqGpMRgR/ufzkw1Z9jZmiIGhytGGfabsLy4DaA
         anXbBT3L9Ig1sUu7USlQZG/y+w0kY0eCyRXqoHhdZrcnnr5xItQHEv1YHBGMjOO1R9lg
         e9O6n704eMZKC5vaNshv7CkPi+uatRR7G/X7k/hRs3EsJqvd50VG3mm+81BSM9h3aUAG
         RxpPmAlWo4Gs0ZVuWp7tFWiB3tzkknylSRSmETkB3EkrXSwguxeyFLpw5ZawKnSS3Ksf
         Ip2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hX1sbP8EszqgWKbbcRjaS3YBe+SgvuzH+C2gcwmgs6c=;
        b=lUA3H6utUgEMwazOxs5A1fSxO6kq143Ip8A0iSMhd/XfEaC4LfyIodCbu5tH3N5hDt
         siEluBlWGEC6l3KhmiSLsEH6C1Pv151bKFHjF8qLCcd86xaOPzIdrElJSak5soFFRtoO
         UUkYp1T0fBwZmZW8REvr0stHVdaiNq7iNGIuHQIhZRBq0nx04ZwQJlY6fsjbtJZqC105
         6fzUiqEJnnp1liRcsjqWRD0UqVOQpndR8PzBgB25NMmn+FjPpIsEn5tCFMiMMnSiGVEG
         FT+wVEXt6aLngtn19SsOZz03W0wL/wJbRj3YqfbWhRbq0ho+iV5K+QkHkcLE54jfaJg3
         SOjQ==
X-Gm-Message-State: AOAM533eg34/+1sYQq1oT7TukTWd8hlAwjlZK8Ovf8zlwp96wvYiZ7QH
        9fG+DRfdmcHHhUUFZE4cjn4anesGUOAKCi7E/mM=
X-Google-Smtp-Source: ABdhPJxw8xO8sEKrSziLpEGWBqhQpuweTxPuEg3LJpxREwC8EvtUtDLnJbBBLzKq+BITSd8FAUO+WXHHj5ouBCTUwU4=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr7105082ybf.260.1615413112387;
 Wed, 10 Mar 2021 13:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20210310015455.1095207-1-revest@chromium.org> <f5cfb3d0-fab4-ee07-70de-ad5589db1244@fb.com>
 <eb0a8485-9624-1727-6913-e4520c9d8c04@fb.com> <CABRcYmK8m21sb8dHbr1wLT_oTCBpvr2Zg-8KHwKuJ2Ak0iTZ_A@mail.gmail.com>
 <454d2e4b-f842-624c-a89e-441830c98e99@fb.com> <CAEf4BzY8kRBM578iV+xMZZxT7gKazMFGp5CZjvc1ueyd9vf3KA@mail.gmail.com>
In-Reply-To: <CAEf4BzY8kRBM578iV+xMZZxT7gKazMFGp5CZjvc1ueyd9vf3KA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Mar 2021 13:51:41 -0800
Message-ID: <CAEf4BzbZ+96_WRCyHQ8LVW7gvLouf2rT95Pt6vHPFu7uGqX=WQ@mail.gmail.com>
Subject: Re: [BUG] One-liner array initialization with two pointers in BPF
 results in NULLs
To:     Yonghong Song <yhs@fb.com>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 12:12 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 10, 2021 at 8:59 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 3/10/21 3:48 AM, Florent Revest wrote:
> > > On Wed, Mar 10, 2021 at 6:16 AM Yonghong Song <yhs@fb.com> wrote:
> > >> On 3/9/21 7:43 PM, Yonghong Song wrote:
> > >>> On 3/9/21 5:54 PM, Florent Revest wrote:
> > >>>> I noticed that initializing an array of pointers using this syntax:
> > >>>> __u64 array[] = { (__u64)&var1, (__u64)&var2 };
> > >>>> (which is a fairly common operation with macros such as BPF_SEQ_PRINTF)
> > >>>> always results in array[0] and array[1] being NULL.
> > >>>>
> > >>>> Interestingly, if the array is only initialized with one pointer, ex:
> > >>>> __u64 array[] = { (__u64)&var1 };
> > >>>> Then array[0] will not be NULL.
> > >>>>
> > >>>> Or if the array is initialized field by field, ex:
> > >>>> __u64 array[2];
> > >>>> array[0] = (__u64)&var1;
> > >>>> array[1] = (__u64)&var2;
> > >>>> Then array[0] and array[1] will not be NULL either.
> > >>>>
> > >>>> I'm assuming that this should have something to do with relocations
> > >>>> and might be a bug in clang or in libbpf but because I don't know much
> > >>>> about these, I thought that reporting could be a good first step. :)
> > >>>
> > >>> Thanks for reporting. What you guess is correct, this is due to
> > >>> relocations :-(
> > >>>
> > >>> The compiler notoriously tend to put complex initial values into
> > >>> rodata section. For example, for
> > >>>      __u64 array[] = { (__u64)&var1, (__u64)&var2 };
> > >>> the compiler will put
> > >>>      { (__u64)&var1, (__u64)&var2 }
> > >>> into rodata section.
> > >>>
> > >>> But &var1 and &var2 themselves need relocation since they are
> > >>> address of static variables which will sit inside .data section.
> > >>>
> > >>> So in the elf file, you will see the following relocations:
> > >>>
> > >>> RELOCATION RECORDS FOR [.rodata]:
> > >>> OFFSET           TYPE                     VALUE
> > >>> 0000000000000018 R_BPF_64_64              .data
> > >>> 0000000000000020 R_BPF_64_64              .data
> > >
> > > Right :) Thank you for the explanations Yonghong!
> > >
> > >>> Currently, libbpf does not handle relocation inside .rodata
> > >>> section, so they content remains 0.
> > >
> > > Just for my own edification, why is .rodata relocation not yet handled
> > > in libbpf ? Is it because of a read-only mapping that makes it more
> > > difficult ?
> >
> > We don't have this use case before. In general, people do not put
> > string pointers in init code in the declaration. I think
> > bpf_seq_printf() is special about this and hence triggering
> > the issue.
> >
> > To support relocation of rodata section, kernel needs to be
> > involved and this is actually more complicated as
>
> Exactly. It would be trivial for libbpf to support it, but it needs to
> resolve to the actual in-kernel address of a map (plus offset), which
> libbpf has no way of knowing.

Having said that, libbpf should probably error out when such
relocation is present, because there is no way the application with
such relocations is going to be correct.

>
> > the relocation is against .data section. Two issues the kernel
> > needs to deal with:
> >     - .data section will be another map in kernel, so i.e.,
> >       relocation of .rodata map value against another map.
> >     - .data section may be modified, some protection might
> >       be needed to prevent this. We may ignore this requirement
> >       since user space may have similar issue.
> >
> > This is a corner case, if we can workaround in the libbpf, in
> > this particular case, bpf_tracing.h. I think it will be
> > good enough, not adding further complexity in kernel for
> > such a corner case.
>
> Is there some way to trick compiler into thinking that those values
> are not constant? Some volatile and pointers game? Or any other magic?
>
>
> >
> > >
> > >>> That is why you see the issue with pointer as NULL.
> > >>>
> > >>> With array size of 1, compiler does not bother to put it into
> > >>> rodata section.
> > >>>
> > >>> I *guess* that it works in the macro due to some kind of heuristics,
> > >>> e.g., nested blocks, etc, and llvm did not promote the array init value
> > >>> to rodata. I will double check whether llvm can complete prevent
> > >>> such transformation.
> > >>>
> > >>> Maybe in the future libbpf is able to handle relocations for
> > >>> rodata section too. But for the time being, please just consider to use
> > >>> either macro, or the explicit array assignment.
> > >>
> > >> Digging into the compiler, the compiler tries to make *const* initial
> > >> value into rodata section if the initial value size > 64, so in
> > >> this case, macro does not work either. I think this is how you
> > >> discovered the issue.
> > >
> > > Indeed, I was using a macro similar to BPF_SEQ_PRINTF and this is how
> > > I found the bug.
> > >
> > >> The llvm does not provide target hooks to
> > >> influence this transformation.
> > >
> > > Oh, that is unfortunate :) Thanks for looking into it! I feel that the
> > > real fix would be in libbpf anyway and the rest is just workarounds.
> >
> > The real fix will need libbpf and kernel.
> >
> > >
> > >> So, there are two workarounds,
> > >> (1).    __u64 param_working[2];
> > >>           param_working[0] = (__u64)str1;
> > >>           param_working[1] = (__u64)str2;
> > >> (2). BPF_SEQ_PRINTF(seq, "%s ", str1);
> > >>        BPF_SEQ_PRINTF(seq, "%s", str2);
> > >
> > > (2) is a bit impractical for my actual usecase. I am implementing a
> > > bpf_snprintf helper (patch series Coming Soon TM) and I wanted to keep
> > > the selftest short with a few BPF_SNPRINTF() calls that exercise most
> > > format specifiers.
> > >
> > >> In practice, if you have at least one non-const format argument,
> > >> you should be fine. But if all format arguments are constant, then
> > >> none of them should be strings.
> > >
> > > Just for context, this does not only happen for strings but also for
> > > all sorts of pointers, for example, when I try to do address lookup of
> > > global __ksym variables, which is important for my selftest.
> >
> > Currently, in bpf_seq_printf(), we do memory copy for string
> > and certain ipv4/ipv6 addresses. ipv4 is not an issue as the compiler
> > less likely put it into rodata. for ipv6,
> > if it is a constant, we can just directly put it into the format
> > string. For many other sort of pointers, we just print pointer
> > values, I don't see a value to print pointer value for something like
> >      static const param[] = { &str1, &str2 };
> >      bpf_seq_printf(seq, "%px\n", param[0]);
> >
> > The global __ksym variable cannot be pointing to rodata at compile time,
> > so it should be fine.
> >
> > >
> > >> Maybe we could change marco
> > >>      unsigned long long ___param[] = { args };
> > >> to declare an array explicitly and then have a loop to
> > >> assign each array element?
> > >
> > > I think this would be a good workaround for now, indeed. :) I'll look
> > > into it today and send it as part of my bpf_snprintf series.
> >
> > If we can make it work, that will be great! thanks for working on this.
> >
> > >
> > > Thanks!
> > >
