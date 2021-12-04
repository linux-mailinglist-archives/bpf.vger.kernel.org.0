Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE31468181
	for <lists+bpf@lfdr.de>; Sat,  4 Dec 2021 01:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354532AbhLDAqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 19:46:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42884 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345008AbhLDAqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 19:46:11 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by linux.microsoft.com (Postfix) with ESMTPSA id 67B2820E694B;
        Fri,  3 Dec 2021 16:42:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 67B2820E694B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638578566;
        bh=lXUni3I/ybswjXgtwnT3esCqFp0K1gkOc8i9Mt2Wif8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UUQLwyva8eYh69kLIH9Z6PLWd4iLDM5hFxtBQQUf22ZBZDhTmFKxF+Yn4GeX8ZFks
         RkQonqEp1J4cICt+vEtRkHe2keL+6VUif/SbkxAA0Bl3/ErvzzSbmzQhvdhzikKdGh
         rhmH2w1AOupjisH6LZ9t+3Fqb9rzc0KPFW2nWxBM=
Received: by mail-pj1-f49.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso6473625pji.0;
        Fri, 03 Dec 2021 16:42:46 -0800 (PST)
X-Gm-Message-State: AOAM53216EDhWtfqKUIEWANHzwu84Z3oNlIJ7oCPy3VfB7hpINfH7S7S
        povmy7XeYx9mdS6GJf4ucKhPbwDm/bRLFV/pt6Q=
X-Google-Smtp-Source: ABdhPJyNnMQOpntjmq0qxJMtkrL9naW5mTWhRXVn3joVrzDgJ44SFlCLHUuD+8ibNbofaICHrdC4N2qxz/m7vX0Ai5A=
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr5803413pjq.20.1638578565899;
 Fri, 03 Dec 2021 16:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
 <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
 <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
 <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
 <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org> <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
In-Reply-To: <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sat, 4 Dec 2021 01:42:09 +0100
X-Gmail-Original-Message-ID: <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
Message-ID: <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Luca Boccassi <bluca@debian.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 11:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 3, 2021 at 2:06 PM Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Fri, 2021-12-03 at 11:37 -0800, Alexei Starovoitov wrote:
> > > On Fri, Dec 3, 2021 at 11:36 AM Matteo Croce
> > > <mcroce@linux.microsoft.com> wrote:
> > > >
> > > > On Fri, Dec 3, 2021 at 8:22 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce
> > > > > <mcroce@linux.microsoft.com> wrote:
> > > > > >
> > > > > > From: Matteo Croce <mcroce@microsoft.com>
> > > > > >
> > > > > > This series add signature verification for BPF files.
> > > > > > The first patch implements the signature validation in the
> > > > > > kernel,
> > > > > > the second patch optionally makes the signature mandatory,
> > > > > > the third adds signature generation to bpftool.
> > > > >
> > > > > Matteo,
> > > > >
> > > > > I think I already mentioned that it's no-go as-is.
> > > > > We've agreed to go with John's suggestion.
> > > >
> > > > Hi,
> > > >
> > > > my previous attempt was loading a whole ELF file and parsing it in
> > > > kernel.
> > > > In this series I just validate the instructions against a
> > > > signature,
> > > > as with kernel CO-RE libbpf doesn't need to mangle it.
> > > >
> > > > Which suggestion? I think I missed this one..
> > >
> > > This talk and discussion:
> > > https://linuxplumbersconf.org/event/11/contributions/947/
> >
> > Thanks for the link - but for those of us who don't have ~5 hours to
> > watch a video recording, would you mind sharing a one line summary,
> > please? Is there an alternative patch series implementing BPF signing
> > that you can link us so that we can look at it? Just a link or
> > googlable reference would be more than enough.
>
> It's not 5 hours and you have to read slides and watch
> John's presentation to follow the conversation.

So, If I have understood correctly, the proposal is to validate the
tools which loads the BPF (e.g. perf, ip) with fs-verity, and only
allow BPF loading from those validated binaries?
That's nice, but I think that this could be complementary to the
instructions signature.
Imagine a validated binary being exploited somehow at runtime, that
could be vector of malicious BPF program load.
Can't we have both available, and use one or other, or even both
together depending on the use case?

Regards,
-- 
per aspera ad upstream
