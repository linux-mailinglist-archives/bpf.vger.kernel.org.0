Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8001130E502
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 22:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhBCVcv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 16:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhBCVco (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 16:32:44 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479FC061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 13:32:04 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id r2so1007024ybk.11
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 13:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ppjQRVfbDWJbfz905RRTNnrKq6a9sSMJAxZAUSu8bI=;
        b=R+xiQuKT6W2GKAyCGcpAY67AgtxMveW60Wd9nab9ZAKV6immp8JndrpQ2ogNKQ2Dtk
         kM31m8gyJwglk5XujLlJYiToPzranxmJp2dqxzCCOGx5b2hGkO59XZiWyHhpQgFfZiLK
         s/VWSecDq/mNDL4dkMS7xOvQWBHCDIUVMI/9C2ksJHbL46nuitSXTa9MYyOFIiWahzWf
         6j63Awlq4TVkwmRrX7G5UnIJDyJOxmEea0Tmi4Ww9cYqF+1xGTAsPf8B0Wl06IRFyVOd
         vL1DIBZnoKQP6HtGkrHukVUXPTHS4IeBTZaJE+5itX3W1JU9uLcPRtmC+R6Uk8AGVHDv
         Mmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ppjQRVfbDWJbfz905RRTNnrKq6a9sSMJAxZAUSu8bI=;
        b=ripCMou5fDY8VjBdelrKp6h7ibdmJPFCY3pmfVIzWp3h99i1n+PjCclcmh72S7EMWY
         ASdUOJ+ux6L0oNzZjFuhQrwThnNfnBA8Qn/WqTHrlDbLwKTjaRHSA4QHYkCdw2WjcAPS
         9bXZVKdI66gp0ZAh4esd8PxN03VwVeCT/YLW6Tou3HH+vqjT3vJ4G+KEhOjdDZ/fhigf
         wujKCIBHQG41xWdpaniomKGprYuVVVtHs1Q6030uVt2wROwk6pmjzNiv+twxTIGzDrUS
         5DaMkfvvm9nj7x2+56JhSRapkNHisMS4yicM+5zhZDHsJ3IwiTlpLlUcWhL83PJf4sG8
         8dbQ==
X-Gm-Message-State: AOAM533+4orcpYJzNrGXcnCFcYyPZG+S/dU4VN7dvXcRj1apUGrmIsYT
        LCJf0GkfsF2+EqVAKm3Q7S2JZwBDcexk/yCn2lIVzRYm+M6C0w==
X-Google-Smtp-Source: ABdhPJyaTEMBNe44WLgqd4s8YaqUTu4hV4BQalgO2Rx4ITOuwt7h0jXJzaGmuqg8YAJL+HFzDZZUB2Mgndu3qE+ADlw=
X-Received: by 2002:a25:da4d:: with SMTP id n74mr7652544ybf.347.1612387923920;
 Wed, 03 Feb 2021 13:32:03 -0800 (PST)
MIME-Version: 1.0
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
 <44e6edc6-736e-dadb-c523-eabff8de89c0@infradead.org> <CAEf4BzbZNwHFYRtQZbEZrzqYF+8TenhZA8==N1wLO0nnbmi8Vw@mail.gmail.com>
 <93a6f6b6-167a-a2c6-f0dc-621d5a7bfc20@infradead.org> <CAEf4BzYMbu6X1kpx-oVuwsdrFAF9--_M5KGfFkiZomBPsuYHng@mail.gmail.com>
 <01ffaa2e-c0fd-95a1-a60a-eb90cbf868ad@infradead.org> <CAEf4BzaW-6_xFzD1tfyiU6vTa_02_0As+2RpRix+QpM2rWzUPQ@mail.gmail.com>
 <8c900f52-5fc7-c34d-b045-db6d23c07abf@infradead.org>
In-Reply-To: <8c900f52-5fc7-c34d-b045-db6d23c07abf@infradead.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 13:31:53 -0800
Message-ID: <CAEf4BzYPOoqvznyh_Fmwn1qpx3qNZGLPbHSxu8cdr5KTSGuk3w@mail.gmail.com>
Subject: Re: finding libelf
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 12:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/3/21 12:41 PM, Andrii Nakryiko wrote:
> > On Wed, Feb 3, 2021 at 12:36 PM Randy Dunlap <rdunlap@infradead.org> wr=
ote:
> >>
> >> On 2/3/21 12:33 PM, Andrii Nakryiko wrote:
> >>> On Wed, Feb 3, 2021 at 12:15 PM Randy Dunlap <rdunlap@infradead.org> =
wrote:
> >>>>
> >>>> On 2/3/21 12:12 PM, Andrii Nakryiko wrote:
> >>>>> On Wed, Feb 3, 2021 at 12:09 PM Randy Dunlap <rdunlap@infradead.org=
> wrote:
> >>>>>>
> >>>>>> On 2/3/21 11:39 AM, Andrii Nakryiko wrote:
> >>>>>>> On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> >>>>>>>>
> >>>>>>>> On 2/3/21 2:57 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>>>>>>>> Randy Dunlap <rdunlap@infradead.org> writes:
> >>>>>>>>>
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> I see this sometimes when building a kernel: (on x86_64,
> >>>>>>>>>> with today's linux-next 20210202):
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> CONFIG_CGROUP_BPF=3Dy
> >>>>>>>>>> CONFIG_BPF=3Dy
> >>>>>>>>>> CONFIG_BPF_SYSCALL=3Dy
> >>>>>>>>>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
> >>>>>>>>>> CONFIG_BPF_PRELOAD=3Dy
> >>>>>>>>>> CONFIG_BPF_PRELOAD_UMD=3Dm
> >>>>>>>>>> CONFIG_HAVE_EBPF_JIT=3Dy
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Auto-detecting system features:
> >>>>>>>>>> ...                        libelf: [ [31mOFF[m ]
> >>>>>>>>>> ...                          zlib: [ [31mOFF[m ]
> >>>>>>>>>> ...                           bpf: [ [31mOFF[m ]
> >>>>>>>>>>
> >>>>>>>>>> No libelf found
> >>>>>>>>>> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
> >>>>>>>>>> No zlib found
> >>>>>>>>>> make[5]: [Makefile:290: zdep] Error 1 (ignored)
> >>>>>>>>>> BPF API too old
> >>>>>>>>>> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> but pkg-config tells me:
> >>>>>>>>>>
> >>>>>>>>>> $ pkg-config --modversion  libelf
> >>>>>>>>>> 0.168
> >>>>>>>>>> $ pkg-config --libs  libelf
> >>>>>>>>>> -lelf
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Any ideas?
> >>>>>>>>>
> >>>>>>>>> This usually happens because there's a stale cache of the featu=
re
> >>>>>>>>> detection tests lying around somewhere. Look for a 'feature' di=
rectory
> >>>>>>>>> in whatever subdir you got that error. Just removing the featur=
e
> >>>>>>>>> directory usually fixes this; I've fixed a couple of places whe=
re this
> >>>>>>>>> is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf=
/preload:
> >>>>>>>>> Make sure Makefile cleans up after itself, and add .gitignore")=
) but I
> >>>>>>>>> wouldn't be surprised if there are still some that are broken.
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Thanks for replying.
> >>>>>>>>
> >>>>>>>> I removed the feature subdir and still got this build error, so =
I
> >>>>>>>> removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
> >>>>>>>> and still got the same libelf build error.
> >>>>>>>
> >>>>>>> I hate the complexity of feature detection framework to the point=
 that
> >>>>>>> I'm willing to rip it out from libbpf's Makefile completely. I ju=
st
> >>>>>>> spent an hour trying to understand what's going on in a very simi=
lar
> >>>>>>> situation. Extremely frustrating.
> >>>>>>>
> >>>>>>> In your case, it might be feature detection triggered from
> >>>>>>> resolve_btfids, so try removing
> >>>>>>> $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}=
.
> >>>>>>>
> >>>>>>> It seems like we don't do proper cleanup in resolve_btfids (it sh=
ould
> >>>>>>> probably call libbpf's clean as well). And it's beyond me why `ma=
ke -C
> >>>>>>> tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-cas=
e>
> >>>>>>> file as well.
> >>>>>>
> >>>>>>
> >>>>>> I don't think it's related to improper cleanup or old files/dirs
> >>>>>> laying around. I say that because I did a full build in a new outp=
ut dir.
> >>>>>> and it still failed in the same way.
> >>>>>
> >>>>> If you cd tools/lib/bpf and run make there, does it detect those li=
braries?
> >>>>
> >>>> Yes:
> >>>>
> >>>> Auto-detecting system features:
> >>>> ...                        libelf: [ on  ]
> >>>> ...                          zlib: [ on  ]
> >>>> ...                           bpf: [ on  ]
> >>>>
> >>>>
> >>>
> >>> Sounds exactly like my case. I removed
> >>> $(O)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf} and it
> >>> started working.
> >>
> >> I already tried that with no success.
> >>
> >> I suppose that it could be related to how I do builds:
> >>
> >> make ARCH=3Dx86_64 O=3Dsubdir -j4 all
> >>
> >> so subdir is a relative path, not an absolute path.
> >
> > so can you confirm this by specifying the absolute path to subdir?
>
> Yes, absolute output path works for libelf, zlib, and bpf:
>
> Auto-detecting system features:
> ...                        libelf: [  [32mon [m  ]
> ...                          zlib: [  [32mon [m  ]
> ...                           bpf: [  [32mon [m  ]
>
>
> Are {feature,FEATURE-DUMP} created in multiple places?
> I don't see them in $(OUTDIR)/tools -- there is no /bpf/ subdir there
> at all.
> I do see them in $(OUTDIR)/kernel/bpf/preload/ -- are those different
> feature files?
>

Yes, they are different. Preload builds its own copy of libbpf, while
resolve_btfids builds its own.

So it seems like [0] should fix your issue by not using feature
detection at all.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20210203203445.3=
356114-1-andrii@kernel.org/

>
> thanks.
> --
> ~Randy
>
