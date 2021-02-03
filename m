Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86F230E42E
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhBCUmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhBCUmB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:42:01 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94095C0613ED
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 12:41:20 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id b187so885314ybg.9
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3uEQdY8Xux5V87lgCfUcEHRWUvlbpZ6oypO5tdmy43k=;
        b=TOoiSasrzVIbkXuDd+ajAOIE8vNFygNOVmcpfMpR4VukJ1EHAKHuglIgGXiaiDUiI8
         v1st86YvrimloAgJpjTD2Xhc6JE/2aGr3uKo052Oy0CuBalYpz+8UjdPuVrfs/mA+zHF
         L+1rgXqB+jNbsxGqbqUmgBFPeG2NboIVBeDAS9ZwX11AVw1HNxU0ukse/HjmDgzPtRjK
         7jMGdHsmVrXO36D6lb0F54+LFSmWufpQy3emQ1s6IxTVzoRvjBC20eAPDkhvsjI9A9+J
         nUbT0Zb5W050kUG9wmSIFu0iX91Jb0IZdwdQ0j7blYXz41OWrfzvpL3hG+0Fcvm0W2sM
         yOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3uEQdY8Xux5V87lgCfUcEHRWUvlbpZ6oypO5tdmy43k=;
        b=VuxKiWAXWsK8oElx8YoxAEg+ysKyX8Ouh2zzN6WEVjYh+BfTRn8O00MUV1Cl/78cCt
         qIPmauLjfaHOidleNdkGmIDFa6XJUgVrP95SVaBJHtEOG9qOvkcBvBdDdgVBGUTbZTjb
         v1eiSQ3DVvzwdJVdHSr3ISa/lo7+6SxbKABowgLKM770gUiU0sVd3A2xPbFapEPSgAq1
         euKyTXk68+rOujCwOjQxmEUH0KeWqQq5X6I3p0YGhcLxlijcPbCdV0LKSqLDheX25Rr5
         a6Dqq2MkBGcon5pHWYBefRkqSPFmUMqZKI7LMl8Yrxb7ldpBs0hNqzLupSdpAeMhwfTo
         QhIA==
X-Gm-Message-State: AOAM531QnT8NP2i8/cKJ1cMx6xE/w7ueXUyqdgit2xbE2f0MIlWtnLu+
        gNRHu9Sq3L/VID2JiQ233SD8bMTN/N6Yt6kNGGM=
X-Google-Smtp-Source: ABdhPJwIAwcSlwPNJP0+WnCyVuiDLI2Te3hmCJByUSBBMfeCZS12pipxCQOgHnf3ycbJyHd+M1F7Ky/ov4gytKpL9AI=
X-Received: by 2002:a5b:3c4:: with SMTP id t4mr6710463ybp.510.1612384879745;
 Wed, 03 Feb 2021 12:41:19 -0800 (PST)
MIME-Version: 1.0
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
 <44e6edc6-736e-dadb-c523-eabff8de89c0@infradead.org> <CAEf4BzbZNwHFYRtQZbEZrzqYF+8TenhZA8==N1wLO0nnbmi8Vw@mail.gmail.com>
 <93a6f6b6-167a-a2c6-f0dc-621d5a7bfc20@infradead.org> <CAEf4BzYMbu6X1kpx-oVuwsdrFAF9--_M5KGfFkiZomBPsuYHng@mail.gmail.com>
 <01ffaa2e-c0fd-95a1-a60a-eb90cbf868ad@infradead.org>
In-Reply-To: <01ffaa2e-c0fd-95a1-a60a-eb90cbf868ad@infradead.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 12:41:08 -0800
Message-ID: <CAEf4BzaW-6_xFzD1tfyiU6vTa_02_0As+2RpRix+QpM2rWzUPQ@mail.gmail.com>
Subject: Re: finding libelf
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 12:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/3/21 12:33 PM, Andrii Nakryiko wrote:
> > On Wed, Feb 3, 2021 at 12:15 PM Randy Dunlap <rdunlap@infradead.org> wr=
ote:
> >>
> >> On 2/3/21 12:12 PM, Andrii Nakryiko wrote:
> >>> On Wed, Feb 3, 2021 at 12:09 PM Randy Dunlap <rdunlap@infradead.org> =
wrote:
> >>>>
> >>>> On 2/3/21 11:39 AM, Andrii Nakryiko wrote:
> >>>>> On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
> >>>>>>
> >>>>>> On 2/3/21 2:57 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>>>>>> Randy Dunlap <rdunlap@infradead.org> writes:
> >>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> I see this sometimes when building a kernel: (on x86_64,
> >>>>>>>> with today's linux-next 20210202):
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> CONFIG_CGROUP_BPF=3Dy
> >>>>>>>> CONFIG_BPF=3Dy
> >>>>>>>> CONFIG_BPF_SYSCALL=3Dy
> >>>>>>>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
> >>>>>>>> CONFIG_BPF_PRELOAD=3Dy
> >>>>>>>> CONFIG_BPF_PRELOAD_UMD=3Dm
> >>>>>>>> CONFIG_HAVE_EBPF_JIT=3Dy
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Auto-detecting system features:
> >>>>>>>> ...                        libelf: [ [31mOFF[m ]
> >>>>>>>> ...                          zlib: [ [31mOFF[m ]
> >>>>>>>> ...                           bpf: [ [31mOFF[m ]
> >>>>>>>>
> >>>>>>>> No libelf found
> >>>>>>>> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
> >>>>>>>> No zlib found
> >>>>>>>> make[5]: [Makefile:290: zdep] Error 1 (ignored)
> >>>>>>>> BPF API too old
> >>>>>>>> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> but pkg-config tells me:
> >>>>>>>>
> >>>>>>>> $ pkg-config --modversion  libelf
> >>>>>>>> 0.168
> >>>>>>>> $ pkg-config --libs  libelf
> >>>>>>>> -lelf
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Any ideas?
> >>>>>>>
> >>>>>>> This usually happens because there's a stale cache of the feature
> >>>>>>> detection tests lying around somewhere. Look for a 'feature' dire=
ctory
> >>>>>>> in whatever subdir you got that error. Just removing the feature
> >>>>>>> directory usually fixes this; I've fixed a couple of places where=
 this
> >>>>>>> is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/p=
reload:
> >>>>>>> Make sure Makefile cleans up after itself, and add .gitignore")) =
but I
> >>>>>>> wouldn't be surprised if there are still some that are broken.
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> Thanks for replying.
> >>>>>>
> >>>>>> I removed the feature subdir and still got this build error, so I
> >>>>>> removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
> >>>>>> and still got the same libelf build error.
> >>>>>
> >>>>> I hate the complexity of feature detection framework to the point t=
hat
> >>>>> I'm willing to rip it out from libbpf's Makefile completely. I just
> >>>>> spent an hour trying to understand what's going on in a very simila=
r
> >>>>> situation. Extremely frustrating.
> >>>>>
> >>>>> In your case, it might be feature detection triggered from
> >>>>> resolve_btfids, so try removing
> >>>>> $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.
> >>>>>
> >>>>> It seems like we don't do proper cleanup in resolve_btfids (it shou=
ld
> >>>>> probably call libbpf's clean as well). And it's beyond me why `make=
 -C
> >>>>> tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
> >>>>> file as well.
> >>>>
> >>>>
> >>>> I don't think it's related to improper cleanup or old files/dirs
> >>>> laying around. I say that because I did a full build in a new output=
 dir.
> >>>> and it still failed in the same way.
> >>>
> >>> If you cd tools/lib/bpf and run make there, does it detect those libr=
aries?
> >>
> >> Yes:
> >>
> >> Auto-detecting system features:
> >> ...                        libelf: [ on  ]
> >> ...                          zlib: [ on  ]
> >> ...                           bpf: [ on  ]
> >>
> >>
> >
> > Sounds exactly like my case. I removed
> > $(O)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf} and it
> > started working.
>
> I already tried that with no success.
>
> I suppose that it could be related to how I do builds:
>
> make ARCH=3Dx86_64 O=3Dsubdir -j4 all
>
> so subdir is a relative path, not an absolute path.

so can you confirm this by specifying the absolute path to subdir?

>
> --
> ~Randy
>
