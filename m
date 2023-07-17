Return-Path: <bpf+bounces-5140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C2756CDC
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48CE1C20B97
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EADC14B;
	Mon, 17 Jul 2023 19:11:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A61253BE
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 19:11:39 +0000 (UTC)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD697
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:11:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso7911061e87.0
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689621096; x=1692213096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HObTLp61Ps+L6Hv5RwMzkMa6m0B8d/zW2WQXQwU2kw=;
        b=Udcxn02251pq6vzlb54mSoh+Og6GbdFG3EBgfUTHnaceruUjKDSzNzEJRuH0zUBxCn
         XGePp+O3whkR1t/sCgESnkditTTfN7DhuAyGDeL5n+1/aS3K81BYLDm1iHCwzUvxz/Fl
         Ub0NPPtCpVfzFHc0DHzdKqz8R+ionNG8BzJ7GBtF6rLQHZYDc9qsVObBPqNopMnLzbTH
         cEtxZK1RMyuyRg70zHyrR3ZsuXEgBZ//W/ZL4CIeAk3mtHs7hiEffb/u+0Rb9QxG9h00
         sz9k79hubWKooywmrC7HxdaQWn2sz+sJQoQMwnZZcDgoyjI/SO8mN+MwfAdn34V0q8Fb
         knOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621096; x=1692213096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HObTLp61Ps+L6Hv5RwMzkMa6m0B8d/zW2WQXQwU2kw=;
        b=bQPXTGIdI/fcZVCCaqBOLeDtJRySATdQJhMAf+5zEWOdM90mac8dinQ1RCX9SJy3hI
         lLMiSrzEBvta1zo150IS8KWaKoyFA8hRDXiJRHpNB7q3IpWTA2gLuBWbx4JJwdOAX/cQ
         5zuek33D4cwbHiHDIYcQTs2Arjzd7lt3NYhOjUW1tACFRqVgXpSVHgbgVRYEFceW4F2M
         YL7mGJ9eYp1tWF8rrFJ44lyKPp+R/7DpqaWK+Gz0J/bAEsCpbH05TH6XXDs7oAGy/JJZ
         J0n31tmTmKBEQLzqFrjy1WUiqEJbz41xhzTsgf7NwridI4Uoc2nzBmFTso64cnmjCeoW
         idKQ==
X-Gm-Message-State: ABy/qLbGfpPgRUVmcLC/lmiP1nY4U93J/y1u/Qs4ZIIhSYuet9jyiLSz
	aSVv1i2kHZB7GeDuUmjh4mI3e/SCwrf7H3xYBCo=
X-Google-Smtp-Source: APBJJlEndC3LM3gtLH3xFYgy02IItfqdnmiIuuonp+hGdrPM+kEEUQQP+w8h11sGaGc8EWOt8E4Km25fqQUN5Ndo3OE=
X-Received: by 2002:ac2:4e89:0:b0:4fb:9341:9921 with SMTP id
 o9-20020ac24e89000000b004fb93419921mr7305514lfr.52.1689621095982; Mon, 17 Jul
 2023 12:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-9-memxor@gmail.com>
 <20230714224750.27ufbap5guvkqayk@MacBook-Pro-8.local> <CAP01T77dBfMrBsQiEK7TY05oCXnD8zndBTPygb9_b+R0nL3n5A@mail.gmail.com>
 <CAADnVQKSGosH5SwLCxTmPNdbOE+OvtaAgX_xgZOLT4v-viFF9w@mail.gmail.com>
In-Reply-To: <CAADnVQKSGosH5SwLCxTmPNdbOE+OvtaAgX_xgZOLT4v-viFF9w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 18 Jul 2023 00:40:55 +0530
Message-ID: <CAP01T76sQn=OMqqKcJbD1KySFYs3xGge05SHMZKw8JJHf70p1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Introduce bpf_set_exception_callback
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 17 Jul 2023 at 23:17, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 17, 2023 at 9:47=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 15 Jul 2023 at 04:17, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jul 13, 2023 at 08:02:30AM +0530, Kumar Kartikeya Dwivedi wro=
te:
> > > > By default, the subprog generated by the verifier to handle a throw=
n
> > > > exception hardcodes a return value of 0. To allow user-defined logi=
c
> > > > and modification of the return value when an exception is thrown,
> > > > introduce the bpf_set_exception_callback kfunc, which installs a
> > > > callback as the default exception handler for the program.
> > > >
> > > > Compared to runtime kfuncs, this kfunc acts a built-in, i.e. it onl=
y
> > > > takes semantic effect during verification, and is erased from the
> > > > program at runtime.
> > > >
> > > > This kfunc can only be called once within a program, and always set=
s the
> > > > global exception handler, regardless of whether it was invoked in a=
ll
> > > > paths of the program or not. The kfunc is idempotent, and the defau=
lt
> > > > exception callback cannot be modified at runtime.
> > > >
> > > > Allowing modification of the callback for the current program execu=
tion
> > > > at runtime leads to issues when the programs begin to nest, as any
> > > > per-CPU state maintaing this information will have to be saved and
> > > > restored. We don't want it to stay in bpf_prog_aux as this takes a
> > > > global effect for all programs. An alternative solution is spilling
> > > > the callback pointer at a known location on the program stack on en=
try,
> > > > and then passing this location to bpf_throw as a parameter.
> > > >
> > > > However, since exceptions are geared more towards a use case where =
they
> > > > are ideally never invoked, optimizing for this use case and adding =
to
> > > > the complexity has diminishing returns.
> > >
> > > Right. No run-time changes pls.
> > >
> >
> > +1
> >
> > > Instead of bpf_set_exception_callback() how about adding a
> > > btf_tag("exception_handler") or better name
> > > and check that such global func is a single func in a program and
> > > it's argument is a single u64.
> > >
> >
> > That does seem better. Also, a conditional bpf_set_exception_callback
> > taking effect globally may be confusing for users.
> > I will switch to the BTF tag.
> >
> > Any specific reason it has to be a global func and cannot have static l=
inkage?
>
> The compiler will warn about the unused static function.
> Even if we silence the warn somehow the verifier will not verify that
> static unused subprog.

Ah, right. Makes sense. I will change this in v2.

