Return-Path: <bpf+bounces-4473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D865A74B62D
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8559A1C21067
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1965171C4;
	Fri,  7 Jul 2023 18:21:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC80107B5
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 18:21:22 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914C2125
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 11:21:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so33850071fa.2
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688754078; x=1691346078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+p/ThKuc0U2fK2KYri/P4TsN5GA6GN/Iffy91YpccY=;
        b=qrsa08R3NGKOs1IwjFscSyCj1IW+AhEVzVZVLxwq7g6TVbZPEcHPXG9UQIyCkXoI85
         oNLKJC3aX/DqGGKTqwseIhePe5VpZ+JTepirHucFZaNEeOkPTGjlE4uPn5+BUO3oQ7UC
         IX7D3a+xRd8XYXVCBGUfDc2+Bni++i96x4MsgX1soBsG02O925S3M4WuiIg8BUJAtYt4
         3s5TkQLUUcUaYy6CKpUYlJ+S27xCNscXlkV49sqbWdTcKS8s9aRzcQsGG82cHd1pZoSo
         fZ0dBiIVQ+oGcTDt5QkyHoOpkwGjI4fOO0F3WSNFkrEErsLxu6fVsA4WaBCmy+Vo6RN2
         NNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688754078; x=1691346078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+p/ThKuc0U2fK2KYri/P4TsN5GA6GN/Iffy91YpccY=;
        b=RpficC8LrI8+4JY3CkI/oiYbT4KqhVzN+NWled3bb+cbqsi+XDFXI9L+Ij1BKwVd8B
         DzzFYePWC2aFHYx6xFf5Cd0FhQkJz5GxiCD7zvL5EIOntJuS152KEIpx8ZNjhbjKw/5a
         BaTHFBwftDqBN6a4hPTD61f3XIMLE5tHQWQv8JQYN8yY4AYkwA7Q+v+2CIrzhUOJZe44
         fRKfbMoDgmj2fLk6zKpfV7DfuZaQL3Vkh1c0z6wOA5iO4yIkrKOv+Y09cEOWS00eOa7J
         WMk5YDK/eXcUJdX3uUskhOi7M4WPlOo+zQagBh+w5YfYADkU0UyqWgEktk3LAAYM6U1e
         JnHA==
X-Gm-Message-State: ABy/qLaiMCb8TAur5GBe+VEcIuquE4b//A+7ewGxnF5qgEtDnCU/WirL
	KPfVueqcnBTVFs9JTrOHk/kUUrn2KNCEJLpK58o=
X-Google-Smtp-Source: APBJJlG2X1XrG/PveGJS/5r1S16wRTDSrPb3WXHoaCcJh0QBwl/jiKaWCF0UGU5sH4q9/8CGKWI+hGgBPV5RNscE3Nk=
X-Received: by 2002:a2e:8857:0:b0:2b4:47ad:8c70 with SMTP id
 z23-20020a2e8857000000b002b447ad8c70mr4592432ljj.11.1688754077934; Fri, 07
 Jul 2023 11:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com> <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
In-Reply-To: <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
From: Andrew Werner <awerner32@gmail.com>
Date: Fri, 7 Jul 2023 14:21:06 -0400
Message-ID: <CA+vRuzPoVH8PAxe6X=xr3L2fcHmhAV3mRvq+_-BF_SNAdUM+HQ@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrei Matei <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 2:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jul 7, 2023 at 9:44=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 7, 2023 at 7:04=E2=80=AFAM Andrew Werner <awerner32@gmail.c=
om> wrote:
> > >
> > > When it comes to fixing the problem, I don't quite know where to star=
t.
> > > Perhaps these iteration callbacks ought to be treated more like globa=
l functions
> > > -- you can't always make assumptions about the state of the data in t=
he context
> > > pointer. Treating the context pointer as totally opaque seems bad fro=
m
> > > a usability
> > > perspective. Maybe there's a way to attempt to verify the function
> > > body of the function
> > > by treating all or part of the context as read-only, and then if that
> > > fails, go back and
> > > assume nothing about that part of the context structure. What is the
> > > right way to
> > > think about plugging this hole?
> >
> > 'treat as global' might be a way to fix it, but it will likely break
> > some setups, since people passing pointers in a context and current
> > global func verification doesn't support that.
>
> yeah, the intended use case is to return something from callbacks
> through context pointer. So it will definitely break real uses.

Definitely, this would break the probes we're using.

>
> > I think the simplest fix would be to disallow writes into any pointers
> > within a ctx. Writes to scalars should still be allowed.
>
> It might be a partial mitigation, but even with SCALARs there could be
> problems due to assumed SCALAR range, which will be invalid if
> callback is never called or called many times.

Indeed when the bug was first found it was because an offset scalar
in the context was being modified and was being added to an unmodified
pointer.

> > Much more complex fix would be to verify callbacks as
> > process_iter_next_call(). See giant comment next to it.
>
> yep, that seems like the right way forward. We need to simulate 0, 1,
> 2, .... executions of callbacks until we validate and exhaust all
> possible context modification permutations, just like open-coded
> iterators do it

I'll give process_iter_next_call() a shot, and see if I run into trouble.

On Fri, Jul 7, 2023 at 2:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jul 7, 2023 at 9:44=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 7, 2023 at 7:04=E2=80=AFAM Andrew Werner <awerner32@gmail.c=
om> wrote:
> > >
> > > When it comes to fixing the problem, I don't quite know where to star=
t.
> > > Perhaps these iteration callbacks ought to be treated more like globa=
l functions
> > > -- you can't always make assumptions about the state of the data in t=
he context
> > > pointer. Treating the context pointer as totally opaque seems bad fro=
m
> > > a usability
> > > perspective. Maybe there's a way to attempt to verify the function
> > > body of the function
> > > by treating all or part of the context as read-only, and then if that
> > > fails, go back and
> > > assume nothing about that part of the context structure. What is the
> > > right way to
> > > think about plugging this hole?
> >
> > 'treat as global' might be a way to fix it, but it will likely break
> > some setups, since people passing pointers in a context and current
> > global func verification doesn't support that.
>
> yeah, the intended use case is to return something from callbacks
> through context pointer. So it will definitely break real uses.
>
> > I think the simplest fix would be to disallow writes into any pointers
> > within a ctx. Writes to scalars should still be allowed.
>
> It might be a partial mitigation, but even with SCALARs there could be
> problems due to assumed SCALAR range, which will be invalid if
> callback is never called or called many times.
>
> > Much more complex fix would be to verify callbacks as
> > process_iter_next_call(). See giant comment next to it.
>
> yep, that seems like the right way forward. We need to simulate 0, 1,
> 2, .... executions of callbacks until we validate and exhaust all
> possible context modification permutations, just like open-coded
> iterators do it
>
> > But since we need a fix for stable I'd try the simple approach first.
> > Could you try to implement that?

