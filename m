Return-Path: <bpf+bounces-4365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CE974A838
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BE51C20ED5
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602EDEA4;
	Fri,  7 Jul 2023 00:46:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8117F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 00:46:19 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F40E6E
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:46:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7659924cd9bso135754385a.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688690777; x=1691282777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYVwt83WbqMvn4f2pxzshe+36GeTFxuSw4Vys39lq2Y=;
        b=gA9v5HwyNsM6qpNxgT0sqFmBJJdk+LqfBb7wdfi4Wh5Z6kjy1KgndtIUTQEjl1EN8/
         8hR787z4rHFdIHFntCeK0lwk4dF1iJrOVZ3G9b91AtrKWIlAviNyAqXiBEkwtwL6KteY
         PmoXO9UstLU8w5rJleqc/np+c/iGpNbNj+yydqSodetc/rDEZMhSJ2M25t7kOwtUjBm1
         jgoY4xETYP4KMVxQvQ8j2lts49hzFqaSM+oKzDoFCcqduq6tnmVQHIqfMPnqi6zhUSex
         yCAO/j/Qcc+HZF9g21YM0fzw59SUyONMUDtcnLCsu4CpfDSCSnXJhNhcAmTh6yEInAX0
         vd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688690777; x=1691282777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYVwt83WbqMvn4f2pxzshe+36GeTFxuSw4Vys39lq2Y=;
        b=GB+O3NpQnZ5sMz4FsUgznf0l92O5sxhjpu6tYs1j7QzNMrruSzjwRZ5D4B5mhFJ4ip
         LhQOL0GELfLRL0Defri00EFnM6pvBKx+x1yipvmNP60LDN07ASf3nHvym8VwZwuJqBPA
         XV5vNGegoYmr5jC+MyJ9DvlGjx6wAaaH5EpNqdyWGCGD3e8mJnLzp9XZfyfSvNmrN4j5
         +6fXzqdaYeq4JAlgeFK3ZdbABNE7qU9sriIuLnk0MrZbBhL1kX59JEi3CtwdD2ZEY4VK
         7tUdvKbU2Pzj38wYV6PMTGSX0NoCrKJOOC4Emx+1emClnghZC1zcTEi0vykOBvkdu2Vi
         TCXw==
X-Gm-Message-State: ABy/qLaKB5QWLRJk3eU4ZPP3xFQ5VpOz0y/ef1yUuSYMa4r/o1lorUi6
	Octbigy4n15kHHIhGmxhNiFhfr+U7lEQJloVCdFxIWQ8CUUerDuD7BU=
X-Google-Smtp-Source: APBJJlHF9SDSuxVzrP+u2/S10pfwf9cQ1t7T+f3WID3qleaW9iqAVJ+mADSmggSfzPI6zhFGugP4B1tnRhpL7d6vccE=
X-Received: by 2002:a05:620a:2450:b0:767:4cb2:3145 with SMTP id
 h16-20020a05620a245000b007674cb23145mr5172885qkn.41.1688690777396; Thu, 06
 Jul 2023 17:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706222020.268136-1-hawkinsw@obs.cr> <20230706222020.268136-2-hawkinsw@obs.cr>
 <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 6 Jul 2023 20:46:06 -0400
Message-ID: <CADx9qWjPir2wsRUNJopeT=daQz7rz=hhTJCM=FwCcLo96vY84A@mail.gmail.com>
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

On Thu, Jul 6, 2023 at 7:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 6, 2023 at 3:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wro=
te:
> >
> > The execution of every function proceeds as if it has access to its own
> > stack space.
> >
> > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > ---
> >  Documentation/bpf/instruction-set.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/=
instruction-set.rst
> > index 751e657973f0..717259767a41 100644
> > --- a/Documentation/bpf/instruction-set.rst
> > +++ b/Documentation/bpf/instruction-set.rst
> > @@ -30,6 +30,11 @@ The eBPF calling convention is defined as:
> >  R0 - R5 are scratch registers and eBPF programs needs to spill/fill th=
em if
> >  necessary across calls.
> >
> > +Every function invocation proceeds as if it has exclusive access to an
> > +implementation-defined amount of stack space. R10 is a pointer to the =
byte of
> > +memory with the highest address in that stack space. The contents
> > +of a function invocation's stack space do not persist between invocati=
ons.
>
> Such description belongs in a future psABI doc.
> instruction-set.rst is not a place to describe how registers are used.

Thank you for the feedback!

How does your comment square with the immediately preceding
description in the document that says:

R10: read-only frame pointer to access stack

(among the description of how other registers are used during function call=
s).

Sorry if I am being dense and/or naive.

Sincerely,
Will

> For example x86-64 JIT maps BPF R10 to RBP.
> Yet there is -fomit-frame-pointer.
> So we might very well do something like that in the future.

