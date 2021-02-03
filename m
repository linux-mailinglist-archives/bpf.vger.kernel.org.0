Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B462630E41A
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhBCUeH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhBCUeG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:34:06 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495FC061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 12:33:26 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id s61so902272ybi.4
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=me7HbPDTOW0Xgy0fD84d5Wcywb+vD8AeZDdCyM7+T6s=;
        b=Sm2W7WSCsAoy0jKk7dyk9IrD9crI1B+XsEQuNWBJUpM9QHvZgrGANZLNuDcIJKNDu+
         ZU4D1W/76IKAb+uE/0sHPfvMBkuEY9MFffwnklQDWrZT06aIe5Hys292SXkK7Tueqi9U
         y3M9CabyKZIDp6S3fVdFC5DlJZYSht7hM5pczpudqUywu4IrWq7iC9tYrOBSXeaYJjrV
         LVOeWEfLE/heohkOL2h41Rbs7g7edtCWxLZdNYNrQtoL+s8MFIxsExHC0AWzNQ/7vmYI
         U6sJA+33MB5Ia3ZDTFLMbaxommI/xuoYW5rSjMzDtMrbTTyHmr28ez1T+9OH9XQE5XMc
         ohAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=me7HbPDTOW0Xgy0fD84d5Wcywb+vD8AeZDdCyM7+T6s=;
        b=pmu9E3CwnFya4KzfrAXCHLcWtpqgWqDYXwgk4hUjgia6gjp53S/PviDDOtMiihqJ0N
         /lrorWopZsigI8F/kS761O5Gax54NBq2AOQMpBOWqdpmolJbNXd9HNN08EIDix/Q0XUf
         XAU9Eey+br6rSlThm+7wutp7opzRsQiRaOl5vBeePVll5iDXABPM2j4tg8vqXaWcNFaR
         MKbFQ5tBRg6XTlkp/1qhNcH/Kz12QfJAlzDcXxxwftdVRpM9IDynXjLYf5Unuxd9Hc+x
         56JuqID9Qh6WKHsd0Ngd7W8vAhNz9ckQi2KeZQ059GUCwt22h8xi414yi7eHdZ+mYh34
         9FrQ==
X-Gm-Message-State: AOAM532m+vegsFZ509bwBfO5yaqbfMm8bM0ln+tc3dnKQjkotNVm5keP
        00VCQh5jjPaS4C2M0n8jO3cyRoLqgO7xB6Tg2Cg=
X-Google-Smtp-Source: ABdhPJywz3zwh6oVw5pfOgnau8CNh1w62zu7L2fzZ3Lmyvbgt8bRsOGvep5NUbJY/znymeiVGMCHtwOewwOCaJJoF60=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr7143451ybd.230.1612384405432;
 Wed, 03 Feb 2021 12:33:25 -0800 (PST)
MIME-Version: 1.0
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
 <87eehxa06v.fsf@toke.dk> <a6a8fbd6-c610-873e-12e1-b6b0fadb94be@infradead.org>
 <CAEf4Bzb7-jpQLStjtrWm+CvDkLGHR_LiVdb6YcagR2v-Yt42tw@mail.gmail.com>
 <44e6edc6-736e-dadb-c523-eabff8de89c0@infradead.org> <CAEf4BzbZNwHFYRtQZbEZrzqYF+8TenhZA8==N1wLO0nnbmi8Vw@mail.gmail.com>
 <93a6f6b6-167a-a2c6-f0dc-621d5a7bfc20@infradead.org>
In-Reply-To: <93a6f6b6-167a-a2c6-f0dc-621d5a7bfc20@infradead.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 12:33:14 -0800
Message-ID: <CAEf4BzYMbu6X1kpx-oVuwsdrFAF9--_M5KGfFkiZomBPsuYHng@mail.gmail.com>
Subject: Re: finding libelf
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 12:15 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/3/21 12:12 PM, Andrii Nakryiko wrote:
> > On Wed, Feb 3, 2021 at 12:09 PM Randy Dunlap <rdunlap@infradead.org> wr=
ote:
> >>
> >> On 2/3/21 11:39 AM, Andrii Nakryiko wrote:
> >>> On Wed, Feb 3, 2021 at 9:22 AM Randy Dunlap <rdunlap@infradead.org> w=
rote:
> >>>>
> >>>> On 2/3/21 2:57 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>>>> Randy Dunlap <rdunlap@infradead.org> writes:
> >>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> I see this sometimes when building a kernel: (on x86_64,
> >>>>>> with today's linux-next 20210202):
> >>>>>>
> >>>>>>
> >>>>>> CONFIG_CGROUP_BPF=3Dy
> >>>>>> CONFIG_BPF=3Dy
> >>>>>> CONFIG_BPF_SYSCALL=3Dy
> >>>>>> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
> >>>>>> CONFIG_BPF_PRELOAD=3Dy
> >>>>>> CONFIG_BPF_PRELOAD_UMD=3Dm
> >>>>>> CONFIG_HAVE_EBPF_JIT=3Dy
> >>>>>>
> >>>>>>
> >>>>>> Auto-detecting system features:
> >>>>>> ...                        libelf: [ [31mOFF[m ]
> >>>>>> ...                          zlib: [ [31mOFF[m ]
> >>>>>> ...                           bpf: [ [31mOFF[m ]
> >>>>>>
> >>>>>> No libelf found
> >>>>>> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
> >>>>>> No zlib found
> >>>>>> make[5]: [Makefile:290: zdep] Error 1 (ignored)
> >>>>>> BPF API too old
> >>>>>> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
> >>>>>>
> >>>>>>
> >>>>>> but pkg-config tells me:
> >>>>>>
> >>>>>> $ pkg-config --modversion  libelf
> >>>>>> 0.168
> >>>>>> $ pkg-config --libs  libelf
> >>>>>> -lelf
> >>>>>>
> >>>>>>
> >>>>>> Any ideas?
> >>>>>
> >>>>> This usually happens because there's a stale cache of the feature
> >>>>> detection tests lying around somewhere. Look for a 'feature' direct=
ory
> >>>>> in whatever subdir you got that error. Just removing the feature
> >>>>> directory usually fixes this; I've fixed a couple of places where t=
his
> >>>>> is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/pre=
load:
> >>>>> Make sure Makefile cleans up after itself, and add .gitignore")) bu=
t I
> >>>>> wouldn't be surprised if there are still some that are broken.
> >>>>
> >>>> Hi,
> >>>>
> >>>> Thanks for replying.
> >>>>
> >>>> I removed the feature subdir and still got this build error, so I
> >>>> removed everything in BUILDDIR/kernel/bpf/preload and rebuilt --
> >>>> and still got the same libelf build error.
> >>>
> >>> I hate the complexity of feature detection framework to the point tha=
t
> >>> I'm willing to rip it out from libbpf's Makefile completely. I just
> >>> spent an hour trying to understand what's going on in a very similar
> >>> situation. Extremely frustrating.
> >>>
> >>> In your case, it might be feature detection triggered from
> >>> resolve_btfids, so try removing
> >>> $(OUTPUT)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf}.
> >>>
> >>> It seems like we don't do proper cleanup in resolve_btfids (it should
> >>> probably call libbpf's clean as well). And it's beyond me why `make -=
C
> >>> tools/build/feature clean` doesn't clean up FEATURE-DUMP.<use-case>
> >>> file as well.
> >>
> >>
> >> I don't think it's related to improper cleanup or old files/dirs
> >> laying around. I say that because I did a full build in a new output d=
ir.
> >> and it still failed in the same way.
> >
> > If you cd tools/lib/bpf and run make there, does it detect those librar=
ies?
>
> Yes:
>
> Auto-detecting system features:
> ...                        libelf: [ on  ]
> ...                          zlib: [ on  ]
> ...                           bpf: [ on  ]
>
>

Sounds exactly like my case. I removed
$(O)/tools/bpf/resolve_btfids/{feature/,FEATURE-DUMP.libbpf} and it
started working.

> --
> ~Randy
>
