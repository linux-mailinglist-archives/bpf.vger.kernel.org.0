Return-Path: <bpf+bounces-4369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAB74A83E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4261C20B44
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D410EE;
	Fri,  7 Jul 2023 00:52:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F47F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 00:52:01 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C01FC6
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:52:00 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-766fd5f9536so111957585a.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688691119; x=1691283119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoyxcZZC5H4ip33QGJEwLd8bZuWDBLTi0NEBZvENWyA=;
        b=ai9RSXDNbvcOj5dsfnYFtvDDbxThGn0cFNBZIE38ZmZylAWM0x+c6bJ0Nz9MGVCaWF
         CpBK0CzKD7hFvzzxiJw8Mtpe17kCG35TPRo9+Ds9BMrgUlIoUKqHcx6SmoR4EFqt8GG4
         gs9c5uNUgYlREO5aX2LXHzeaQWn6rgdelHVzQupZo+Glq4dfYLXCvuT0HzFWupGBNryn
         iPgyX2SBqXOGmBlgxxBl4b4Or1MIHZ+bC6UwBlm0MZqqu5oeCV4WRftzay/guzCd5Mju
         A0XflFxhcKp9iKRTSl5DKYSuGhaAJmCzF7ftPwLf+jAnOGX7176yoaF0534Q2F+269IC
         hl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688691119; x=1691283119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoyxcZZC5H4ip33QGJEwLd8bZuWDBLTi0NEBZvENWyA=;
        b=ju0DH5q+dfPP/Kb4T76QqwqpBf/bHj1byPFKHTbcf7t+sYGfbbJpcobLxanIM8tKL4
         TktL5xJuMYXwW/mJgGlmo9lw6FRFyTHbMW2NBuAtRfcTqIq8KPq8YdXD+KLmRcQim8P/
         xfZRYUflInW8GMFhS0VuzIKAzw4GMuxtRnyh7IQvkc7287O49y7EycfqpG3hH4VoAN8Z
         W3pJKl6wp5MDV5cgmN7OhjOkHqzGHy0XXR1gjSZQRZMqHyKJnKV1ys0iVQgSqz/dgSi2
         Yfde5OqpqAFUc/f8CPSIv7egcfrtLCS33Jw9370KoZY6Cjadi2qPFW8KuB5blxPAmakP
         pPXg==
X-Gm-Message-State: ABy/qLbzmqkroHCFBmYXcVL6UNNZMpeJG/67lfnyTsTs3pChYtJYnlgh
	VMWqPFti74CWnbZhiYFZzuZFOR9UmVy9FPPo/0wRpw==
X-Google-Smtp-Source: APBJJlGApWOse7/Xbtp325PxtS7/8GYJ3jEqxv2EfD/37YPftN5PSS/Q0sOOuyiR9/3VxUykDEdqYAssGZmEIigTWrA=
X-Received: by 2002:a0c:abc6:0:b0:62f:e0e1:478e with SMTP id
 k6-20020a0cabc6000000b0062fe0e1478emr2651087qvb.63.1688691119358; Thu, 06 Jul
 2023 17:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706222020.268136-1-hawkinsw@obs.cr> <20230706222020.268136-2-hawkinsw@obs.cr>
 <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
 <CADx9qWjPir2wsRUNJopeT=daQz7rz=hhTJCM=FwCcLo96vY84A@mail.gmail.com> <CAADnVQKdV2A+-+PWpgt7_tUF-0uj-6MSsTSAppQDH=7VeXKFrA@mail.gmail.com>
In-Reply-To: <CAADnVQKdV2A+-+PWpgt7_tUF-0uj-6MSsTSAppQDH=7VeXKFrA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 6 Jul 2023 20:51:48 -0400
Message-ID: <CADx9qWhCKUmJPCBYNOr9+FjKF6d_3SrQ3doVLxi4LzPEiMgHDA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH 1/1] bpf, docs: Describe stack contents of function calls
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 8:48=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 6, 2023 at 5:46=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wro=
te:
> >
> > On Thu, Jul 6, 2023 at 7:32=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jul 6, 2023 at 3:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr>=
 wrote:
> > > >
> > > > The execution of every function proceeds as if it has access to its=
 own
> > > > stack space.
> > > >
> > > > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > > > ---
> > > >  Documentation/bpf/instruction-set.rst | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/=
bpf/instruction-set.rst
> > > > index 751e657973f0..717259767a41 100644
> > > > --- a/Documentation/bpf/instruction-set.rst
> > > > +++ b/Documentation/bpf/instruction-set.rst
> > > > @@ -30,6 +30,11 @@ The eBPF calling convention is defined as:
> > > >  R0 - R5 are scratch registers and eBPF programs needs to spill/fil=
l them if
> > > >  necessary across calls.
> > > >
> > > > +Every function invocation proceeds as if it has exclusive access t=
o an
> > > > +implementation-defined amount of stack space. R10 is a pointer to =
the byte of
> > > > +memory with the highest address in that stack space. The contents
> > > > +of a function invocation's stack space do not persist between invo=
cations.
> > >
> > > Such description belongs in a future psABI doc.
> > > instruction-set.rst is not a place to describe how registers are used=
.
> >
> > Thank you for the feedback!
> >
> > How does your comment square with the immediately preceding
> > description in the document that says:
> >
> > R10: read-only frame pointer to access stack
> >
> > (among the description of how other registers are used during function =
calls).
>
> See
> https://lore.kernel.org/bpf/CAADnVQ+gLnsOVj9s4zpAP6+U6nFHYm6GVZ1FteRac=3D=
ZaJvpfDg@mail.gmail.com/
>
> tldr: it's a mess.
> We should remove 'Registers and calling convention' section from
> instruction-set.rst

Understood. I am working closely (at least I would like to think that
it's closely) with Dave and have been following that thread
attentively. I will help with documentation and writing in whatever
way I can.

Will

