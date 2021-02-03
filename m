Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F2930E3E8
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhBCUNi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhBCUNh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:13:37 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9A8C0613D6
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 12:12:57 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id k4so832368ybp.6
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 12:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QfsdVupHvpiEitPEvCLJCVnfcu4p7g5JL7R5zjKw+Eo=;
        b=dOiWvolAkakSohdfeMuHbyUUlfGKWHyl9F3E33Txx5td+k4HU3YpFpHvGMwc9eJf2U
         XsZ+8OB9yyFSAGEju4Q47TtKu7kv9DOwCDWdriA91qgwOt11fr83UC+rUlGdTLiYmFXA
         Om86D+5VUr/IEMZy08L8cVr9zawAKrghwND5bHLCpbc1Aea/p+wW7R4odc+vnUyY0W5p
         kYgsfdV9z8UxXysR00hUCjA2DE6YGJWOEBuTynG0T089nOr1BcEPxYa0qyZKJmTBvAyL
         uOF/G8fjfnVJAkQILWp6eDNpwR9lCXXH06yo96IWHNGkd6/xu0qY7uY4+2GqhkAQmMML
         y7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QfsdVupHvpiEitPEvCLJCVnfcu4p7g5JL7R5zjKw+Eo=;
        b=RMeBfebgcYIqtXi+NZZdwoP/OQ3FQQozw/VnYdf5UOjQ3UgvJ4/p4dyhJFH+Mo3s31
         qCD9ea0X0ECrCoQyrnjnGN1cVM6FFGIjJIc8LfbgWPWGuI45+Oefs0jFl7/QoGgJWo2n
         He86TS3HTYjNyUbf9GtRnfNr18pKcQEgTMkQRBZr677LzhDUUJ3WV4juxpDRd5u52ezx
         GQyIF+bcSpyj2PNISYapVoVEnNA2GnoznM6FdfRUCzPfLMHAxoWUCwG8JDcL0KuUVZ29
         p/mVXKmpcSwD7z9wbCEJQfSqYXGaPUoavDpRcmuH9+jbO29PRAUvLxZfGGKh7TBVhe/A
         IMuA==
X-Gm-Message-State: AOAM5328WdMAQNAUkVN4g5KH07/4m42L217tMtBKD0ojU0UwF/HF66w0
        7+jhtqCgfeoj3yh/qm8BnyRvjvk2MXnbDKRauiM=
X-Google-Smtp-Source: ABdhPJyNyCi5Dkx2k3Macwjilnxbdm7sAPAGlSsEasNG1r8nXVHj07mY68hkybll432FO2xX2iEvfheL0qLfNImrUTQ=
X-Received: by 2002:a25:9882:: with SMTP id l2mr6552842ybo.425.1612383176718;
 Wed, 03 Feb 2021 12:12:56 -0800 (PST)
MIME-Version: 1.0
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com> <44e6edc6-736e-dadb-c523-eabff8de89c0@infradead.org>
In-Reply-To: <44e6edc6-736e-dadb-c523-eabff8de89c0@infradead.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 12:12:46 -0800
Message-ID: <CAEf4BzbZNwHFYRtQZbEZrzqYF+8TenhZA8==N1wLO0nnbmi8Vw@mail.gmail.com>
Subject: Re: finding libelf
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 12:09 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/3/21 11:39 AM, Andrii Nakryiko wrote:
> > On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org> wro=
te:
> >>
> >> On 2/3/21 2:57 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>> Randy Dunlap <rdunlap@infradead.org> writes:
> >>>
> >>>> Hi,
> >>>>
> >>>> I see this sometimes when building a kernel: (on x86_64,
> >>>> with today's linux-next 20210202):
> >>>>
> >>>>
> >>>> CONFIG_CGROUP_BPF=3Dy
> >>>> CONFIG_BPF=3Dy
> >>>> CONFIG_BPF_SYSCALL=3Dy
> >>>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
> >>>> CONFIG_BPF_PRELOAD=3Dy
> >>>> CONFIG_BPF_PRELOAD_UMD=3Dm
> >>>> CONFIG_HAVE_EBPF_JIT=3Dy
> >>>>
> >>>>
> >>>> Auto-detecting system features:
> >>>> ...                        libelf: [ [31mOFF[m ]
> >>>> ...                          zlib: [ [31mOFF[m ]
> >>>> ...                           bpf: [ [31mOFF[m ]
> >>>>
> >>>> No libelf found
> >>>> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
> >>>> No zlib found
> >>>> make[5]: [Makefile:290: zdep] Error 1 (ignored)
> >>>> BPF API too old
> >>>> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
> >>>>
> >>>>
> >>>> but pkg-config tells me:
> >>>>
> >>>> $ pkg-config --modversion  libelf
> >>>> 0.168
> >>>> $ pkg-config --libs  libelf
> >>>> -lelf
> >>>>
> >>>>
> >>>> Any ideas?
> >>>
> >>> This usually happens because there's a stale cache of the feature
> >>> detection tests lying around somewhere. Look for a 'feature' director=
y
> >>> in whatever subdir you got that error. Just removing the feature
> >>> directory usually fixes this; I've fixed a couple of places where thi=
s
> >>> is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/prelo=
ad:
> >>> Make sure Makefile cleans up after itself, and add .gitignore")) but =
I
> >>> wouldn't be surprised if there are still some that are broken.
> >>
> >> Hi,
> >>
> >> Thanks for replying.
> >>
> >> I removed the feature subdir and still got this build error, so I
> >> removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
> >> and still got the same libelf build error.
> >
> > I hate the complexity of feature detection framework to the point that
> > I'm willing to rip it out from libbpf's Makefile completely. I just
> > spent an hour trying to understand what's going on in a very similar
> > situation. Extremely frustrating.
> >
> > In your case, it might be feature detection triggered from
> > resolve_btfids, so try removing
> > $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.
> >
> > It seems like we don't do proper cleanup in resolve_btfids (it should
> > probably call libbpf's clean as well). And it's beyond me why `make -C
> > tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
> > file as well.
>
>
> I don't think it's related to improper cleanup or old files/dirs
> laying around. I say that because I did a full build in a new output dir.
> and it still failed in the same way.

If you cd tools/lib/bpf and run make there, does it detect those libraries?

>
> --
> ~Randy
>
