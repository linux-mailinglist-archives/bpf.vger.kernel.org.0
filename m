Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732432AF88A
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 19:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgKKSuP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 13:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgKKSuP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 13:50:15 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056AEC0613D1;
        Wed, 11 Nov 2020 10:50:15 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id i193so2884955yba.1;
        Wed, 11 Nov 2020 10:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdXAAD0iz1oye4klAz4JXXPmQWt3mLSNY3dH2bHsMtI=;
        b=geuRAy2iOvmO4q6hq+kpsdFiRQ+Inv7OC3joc36vcYKI/GhvTl0fXmz88cDpqMsLzZ
         WO+kcb34EIQwQG/Dcg862oRNV35APwpjIP0SSbmhXQNO8hVMK5OVf12tcIXzJ87O5Qw6
         LTp4x94MSmJMgvurUvcSdvDMyyrXI+YKfZKNXDkxWds0WWOA09zqzgNwo0VjGMImvyS4
         mL9FD/sH7rKF6d/14aeylhXzZLpzIlhf0Bvda4w5B+tEXEvboAE69XDCiEP2askdhVUP
         UJEMfsC7QwbVzcS8AY38pTT4j/O8vEY1mPPjsKXZnkZk3OBkcIbQjMATUZY/UuSLhp3R
         7kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdXAAD0iz1oye4klAz4JXXPmQWt3mLSNY3dH2bHsMtI=;
        b=nvGeStwvAJ9hm5oPHWthhBZotwv20b3jOgqbLAw/DhxhZlb16n48oA7qTecW5xl128
         Mh45zPM1LIhKyme+1KKgYhJz5C+WGh8H4QxnC/YQqXSsu6pmOHkqUt88gpn6RxaXErkH
         4r0X9G9954ORXjvd4fK/Yx3Xk0LaUX4ynjL2sQUvtCJMZ1jbtynKIji0P8mCH9chJwP7
         cKLuqZTsZ9gwkHdN/ixPU9ObhQFWdmn1p3X+OaHfFVjkR5oondj9wiatvjlv55DL8XQ0
         oO/Bl0ngrFQ4+nZ5HrQoqVhafnmEuSIgIxnf3/q9uylbbg4wVFRsqpctPw6zklhlBLcu
         HnzA==
X-Gm-Message-State: AOAM530Aet8eZkXIrUQ6YDoYBx6n1mXqcTfjrg+AOI6RrHLJouwtDyG4
        wKI9pM+3JB7xNogbDQh62MQBQv89ju7KZf3p4/Q=
X-Google-Smtp-Source: ABdhPJxM+9jcgSa/xo1w3FG76KYSiNw1aQVM2vejBQdVzoeXOlrbR7h1zg7yw/dPa/xpcfaHGuAjYxOghh3xY6tiIxA=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr36282677ybe.403.1605120614209;
 Wed, 11 Nov 2020 10:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20201106052549.3782099-1-andrii@kernel.org> <20201106052549.3782099-5-andrii@kernel.org>
 <20201111115627.GB355344@kernel.org> <CAEf4BzZZ9HcfhVg=YF_0-7tO8Gpp8Jitm1Utg2h_jasXT0n4sw@mail.gmail.com>
 <1A8E09AB-8FE7-4B19-9287-663F8B139362@gmail.com>
In-Reply-To: <1A8E09AB-8FE7-4B19-9287-663F8B139362@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 10:50:03 -0800
Message-ID: <CAEf4Bza3EOhaVRkUXsk7f4nmDywugCOO7OYP1e-5xvq9SSUF0w@mail.gmail.com>
Subject: Re: [PATCH dwarves 4/4] btf: add support for split BTF loading and encoding
To:     Arnaldo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 10:34 AM Arnaldo <arnaldo.melo@gmail.com> wrote:
>
>
>
> On November 11, 2020 3:27:58 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >On Wed, Nov 11, 2020 at 3:56 AM Arnaldo Carvalho de Melo
> ><acme@kernel.org> wrote:
> >>
> >> Em Thu, Nov 05, 2020 at 09:25:49PM -0800, Andrii Nakryiko escreveu:
> >> > Add support for generating split BTF, in which there is a
> >designated base
> >> > BTF, containing a base set of types, and a split BTF, which extends
> >main BTF
> >> > with extra types, that can reference types and strings from the
> >main BTF.
> >>
> >> > This is going to be used to generate compact BTFs for kernel
> >modules, with
> >> > vmlinux BTF being a main BTF, which all kernel modules are based
> >off of.
> >>
> >> > These changes rely on patch set [0] to be present in libbpf
> >submodule.
> >>
> >> >   [0]
> >https://patchwork.kernel.org/project/netdevbpf/list/?series=377859&state=*
> >>
> >> So, applied and added this:
> >
> >Awesome, thanks! Do you plan to release v1.19 soon?
>
> Yes
>
> >
> >>
> >> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> >> index 4b5e0a1bf5462b28..20ee91fc911d4b39 100644
> >> --- a/man-pages/pahole.1
> >> +++ b/man-pages/pahole.1
> >> @@ -185,6 +185,10 @@ Do not encode VARs in BTF.
> >>  .B \-\-btf_encode_force
> >>  Ignore those symbols found invalid when encoding BTF.
> >>
> >> +.TP
> >> +.B \-\-btf_base
> >> +Path to the base BTF file, for instance: vmlinux when encoding
> >kernel module BTF information.
> >> +
> >>  .TP
> >>  .B \-l, \-\-show_first_biggest_size_base_type_member
> >>  Show first biggest size base_type member.
> >>
> >> ---------------
> >>
> >> The entry for btf_encode/-J is missing, I'll add in a followup patch.
> >>
> >> Also I had to fixup ARGP_btf_base to 321 as I added this, to simplify
> >> the kernel scripts and Makefiles:
> >>
> >>   $ pahole --numeric_version
> >>   118
> >>   $
> >
> >Oh, this is nice! Can't really use it with Kbuild now due to backwards
> >compatibility, but maybe someday.
>
> Well, if it fails with --numeric_version, then it is old and the warning about the minimal version being v1.19 should be emitted :)

Right, but for CONFIG_DEBUG_INFO_BTF v1.13 is still adequate enough
and will generates useful BTF (no functions and no module BTF, but all
the CO-RE stuff is there), I wouldn't want to force everyone to get
v1.19 immediately...

>
> - Arnaldo
> >
> >>
> >> Now to test this all by applying the kernel patches and the encoding
> >> module BTF, looking at it, etc.
> >>
> >> - Arnaldo
> >>
> >
> >[...]
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
