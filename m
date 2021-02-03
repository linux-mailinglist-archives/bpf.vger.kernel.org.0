Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0730D5CD
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 10:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhBCJFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 04:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhBCJE1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 04:04:27 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA839C06174A;
        Wed,  3 Feb 2021 01:03:26 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h11so24389410ioh.11;
        Wed, 03 Feb 2021 01:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=GT1N6S4n8x+mRUfnTVwXlUkuOTTCD41Iu8c7s1hBBXI=;
        b=ktZfO7wrQ6G8M6Z+bOeNpjFv/NbjCtZUEPJ9raFI+1YXeJfzSWUy95NAcwj4UM/5AK
         MiXn65mGd7A4gy9BaoaT2g8Oio4re1E+gQ8Tl+RBzFw82eptmO4YlHgmYilWcoU1TxKf
         WI4iCIgH5jDebaeLibBSTqvS/MPtIBqVqDxCHJX7M2E/i3M1Wy/PuRVWagsc/41Jws6C
         Nbsi48uZesdx72xw5UTmrhdrg6YMS/Z9vhiJ7iOIwQPR7i06hlk2PJp7KafSlCJOvPto
         oIu0v5H48PIymU3bSUIz9FZtWfrtkdHw263FeN5E6mFo0+RzkFmUFmVV5LKpKLS3VNje
         WbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=GT1N6S4n8x+mRUfnTVwXlUkuOTTCD41Iu8c7s1hBBXI=;
        b=Pe7qFN2KuBuhgZuO5txKvPpYffZZJ4cEq0Y1HZ1N/AUA+bjtpCWkDkqP9orBAwLp6C
         uaNQDe5e37H1cLOE7AaMohtRlduF/LV2z6wzBz8a8+SaYaYpT8ZI49dMbs2pN+eWtIWw
         RF7qA4/10hroq5XFFRnlVnvPNoe2WvteeLeSsAglDPwDOmLdMcdDfy8q0CPID3dvR7uL
         xhkDkxhSHieAIdFZiGlSchKAo99EFHyW+ZjNj8x2GNNTSUelmwZTS30OLAQ0dez6lbEz
         DnVIzHwkvUiJCZ2gywwyexthAz4GsuRlf23w3ZN355sR6BkHSBG3Af6qE2T6rLmqXjze
         U11Q==
X-Gm-Message-State: AOAM533qieHzPT2S5f+3+EMitB7UqKmZdOKHBejvDNRIjc25piUiLZh6
        Q53ht0ZoYKK3tGhZ8AuMPPitl5IsvlfRnS+pfJw=
X-Google-Smtp-Source: ABdhPJwxLP3jp08JU3bdjoZfvmdMJu/rno6l05UVSnFabFEq5hKMBIvp/nqdI2YjDT3j19SebKBdzT0WnRiLe/watZc=
X-Received: by 2002:a05:6602:2f93:: with SMTP id u19mr1695272iow.110.1612343006176;
 Wed, 03 Feb 2021 01:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
 <20210128200046.GA794568@kernel.org> <CAEf4BzbXhn2qAwNyDx6Oqaj7+RdBtjnPPLe27=B0-aB9yY+Xmw@mail.gmail.com>
In-Reply-To: <CAEf4BzbXhn2qAwNyDx6Oqaj7+RdBtjnPPLe27=B0-aB9yY+Xmw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 3 Feb 2021 10:03:14 +0100
Message-ID: <CA+icZUUTddV18rhZjaVif0a6BgpWtpj4mP1pyQ9cfh_e2xxvMQ@mail.gmail.com>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Mark Wielaard <mark@klomp.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 2, 2021 at 8:48 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 28, 2021 at 12:00 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Thu, Jan 21, 2021 at 08:11:17PM -0800, Andrii Nakryiko escreveu:
> > > On Thu, Jan 21, 2021 at 6:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > Do you want Nick's DWARF v5 patch-series as a base?
> >
> > > Arnaldo was going to figure out the DWARF v5 problem, so I'm leaving
> > > it up to him. I'm curious about DWARF v4 problems because no one yet
> > > reported that previously.
> >
> > I think I have the reported one fixed, Andrii, can you please do
> > whatever pre-release tests you can in your environment with what is in:
> >
>
> Hi Arnaldo,
>
> Sorry for the delay, just back from a short PTO.
>
> It all looks to be working fine on my side. There is a compilation
> error in our libbpf CI when building the latest pahole from sources
> due to DW_FORM_implicit_const being undefined. I'm updating our VMs to
> use Ubuntu Focal 20.04, up from Bionic 18.04, and that should
> hopefully solve the issue due to newer versions of libdw. If you worry
> about breaking others, though, we might want to add #ifndef guards and
> re-define DW_FORM_implicit_const as 0x21 explicitly in pahole source
> code.
>
> But otherwise, all good from what I can see in my environment. Looking
> forward to 1.20 release! I'll let you know if, after updating to
> Ubuntu Focal, any new pahole issues crop up.
>

Last weekend I did some testing with
<pahole.git#DW_AT_data_bit_offset> and DWARF-v5 support for the
Linux-kernel.

The good: I was able to compile :-).
The bad: My build-log grew up to 1.2GiB and I could not boot in QEMU.
The ugly: I killed the archive which had all relevant material.

Yesterday, I compiled latest pahole.git:

$ git describe
v1.19-25-g8d6f06f053a0

$ git log -1 --oneline
8d6f06f053a0 (HEAD -> master, origin/master, origin/HEAD)
dwarf_loader: Add conditional DW_FORM_implicit_const definition for
older system

I cannot promise to test it with Nick Desaulniers' DWARF-v5 patchset
but the recent DWARF changes within pahole.git look promising.

- Sedat -

>
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset
> >
> > ?
> >
> > The cset has the tests I performed and the references to the bugzilla
> > ticket and Daniel has tested as well for his XDR + gcc 11 problem.
> >
> > Thanks,
> >
> > - Arnaldo
