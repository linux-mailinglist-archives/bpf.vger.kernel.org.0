Return-Path: <bpf+bounces-6118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7652A7660ED
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D35282559
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E720815A9;
	Fri, 28 Jul 2023 00:56:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25977C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:56:11 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9C72D51
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:56:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso24610411fa.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690505765; x=1691110565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVVw9V6+eXMOzrYrZNj/SaWARDVdKVJviBLcx53P3ZQ=;
        b=dMNXoWyVBnPDl67ZivzX2VxwxYcYXIq9KlAxmVZA80nQm4okJonRgaMrA8V/2NBPzk
         mHCpq5fkQDfIqcI3Cq697fRDSSB5NIvvB/5/dSV3tjKjqTvLCAXUUx8bXoFyal9mkpB6
         //oCKHZkHc5sIWxp5nVOL3BoY9kxmUDLcZd4jeNJ/sm8WPri9gBLeoe4BpB5OKmdyrja
         VehpGJvV8oZcR6VrZz4oZak5aawtdnM1/rbcTdzHUikzvqzWphpsFMHfDV431k24iOgy
         T9cScWlpCyes8nvMd+d+3Wd9TXltyxpMhzOIzDtm2jhYGtBP0BO+EUfNr/VkTw50FGgQ
         gT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690505765; x=1691110565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVVw9V6+eXMOzrYrZNj/SaWARDVdKVJviBLcx53P3ZQ=;
        b=B1htRhRKWzIvolHm/dOU0y2rn36bMGsrusm8hkmT83gFJ5H+qi1O1w5QWCzcJVjYbS
         avRZW2kDGWQxjXBujYgw6UM1XYQe4kCOG1vVZAGqDSYAV52in7txpjBGfYVOaaY2XiPk
         Y9qGExArrOaF0hSLWbR+1Zo/O0NZCTOihk9jslfDw8LL1gSXlz/XipIIGrZkVioDw694
         F9v0SZQyWDYLim0nLYwze++16B5IHcEbjPoNRLqGdrV+DOdFQBDmU/IbQhSpGfQEsbBo
         oDJmGqS1yf9EhNbYsA187BGvhnGnQ/NdBjlhks20o19aZf60Es6QWWUc7XUmKzdZsmD/
         hGVA==
X-Gm-Message-State: ABy/qLYLfMBLzm5JOyTNTUJqQAgDZs4yr9sNgY77Kfhn9zu+v11QEM+I
	WnCHIS8V4PuGa2r33sPKxvyyt21Hf+DGPskgQrDNtbDjaOU=
X-Google-Smtp-Source: APBJJlEXq2/6tNRsFubcck+VptVVbUngHYk+ZDxKWI6bIwM9a1UKEQdvvWeQh1G1/6r+nfRBZ9gMu6l5DMGhOpJ8oK8=
X-Received: by 2002:a2e:8e93:0:b0:2b5:7a87:a85a with SMTP id
 z19-20020a2e8e93000000b002b57a87a85amr519609ljk.13.1690505764821; Thu, 27 Jul
 2023 17:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com> <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
In-Reply-To: <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jul 2023 17:55:53 -0700
Message-ID: <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 11:37=E2=80=AFAM Watson Ladd <watsonbladd@gmail.com=
> wrote:
>
> On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@microsoft.=
com> wrote:
> > >
> > > I am forwarding the email below (after converting HTML to plain text)
> > > to the mailto:bpf@vger.kernel.org list so replies can go to both list=
s.
> > >
> > > Please use this one for any replies.
> > >
> > > Thanks,
> > > Dave
> > >
> > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > To: bpf@ietf.org
> > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > >
> > > > Dear BPF wg,
> > > >
> > > > I took a look at the draft and think it has some issues, unsurprisi=
ngly at this stage. One is
> > > > the specification seems to use an underspecified C pseudo code for =
operations vs
> > > > defining them mathematically.
> >
> > Hi Watson,
> >
> > This is not "underspecified C" pseudo code.
> > This is assembly syntax parsed and emitted by GCC, LLVM, gas, Linux Ker=
nel, etc.
>
> I don't see a reference to any description of that in section 4.1.
> It's possible I've overlooked this, and if people think this style of
> definition is good enough that works for me. But I found table 4
> pretty scanty on what exactly happens.

Could you please be specific which instruction in table 4 is not obvious?

> >
> > > > The good news is I think this is very fixable although tedious.
> > > >
> > > > The other thornier issues are memory model etc. But the overall str=
ucture seems good
> > > > and the document overall makes sense.
> >
> > What do you mean by "memory model" ?
> > Do you see a reference to it ? Please be specific.
>
> No, and that's the problem. Section 5.2 talks about atomic operations.
> I'd expect that to be paired with a description of barriers so that
> these work, or a big warning about when you need to use them.

That's a good suggestion.
A warning paragraph that BPF ISA does not have barrier instructions
is necessary.

> For
> clarity I'm pretty unfamiliar with bpf as a technology, and it's
> possible that with more knowledge this would make sense. On looking
> back on that I don't even know if the memory space is flat, or
> segmented: can I access maps through a value set to dst+offset, or
> must I always used index? I'm just very confused.

flat vs segmented is an orthogonal topic.
We definitely need to cover it in the architecture doc.
BPF WG charter requires us to produce it as Informational doc eventually.

As far as memory model BPF adopts LKMM (Linux Kernel Memory Model).
https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p0124r7.html

We can add a reference to it from BPF ISA doc, but since
there are no barrier instructions at the moment the memory model
statement would be premature.
The work on "BPF Memory Model" have been ongoing for quite some time.
For example see:
https://lpc.events/event/11/contributions/941/attachments/859/1667/bpf-memo=
ry-model.2020.09.22a.pdf

BPF Memory Model is certainly an important topic, but out of scope for ISA.

