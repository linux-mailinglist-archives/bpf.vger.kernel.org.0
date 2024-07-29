Return-Path: <bpf+bounces-35911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D893FCF7
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3481F22E02
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4BA1607A1;
	Mon, 29 Jul 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi2RUBOR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF727FBA8
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276059; cv=none; b=g0INtNw3cH25pT/4UF3bCP8rmWCmWPo56ADFXxDyNeqd48dfqL/57gcQvRbSgzLuTiIk9glxhxCylyyw5oFg8i06njjE2QRb5n6Ki5ltJDRWgc7mp6x1bq6WNZw676k0rvP/hnATG5oVifA9QZk366bigoxVr9Y78a+7UyZmZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276059; c=relaxed/simple;
	bh=gTinpY4itf6BI/VzPeC5oJ0as7MsMETywDnoUpPbiqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8NTIUS5wQOxIN34xQLWxSL36TQLVzgB97hqO+0F9Nk7cO4WglU3lXecnNC6g1g9av/75ddlV8vfajor+aXC89YMf1MBW1WypeacGtvP7p9fk5yCpycUb4jcGRh2V5hmw0PTeaqUIFsYB8Wf4WXNKueVzUYI2lpbYNPkx/yoOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gi2RUBOR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722276056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1Yj0FL6bBk0S7TAJGcylnT51HTnsFv86PhBeh7shbs=;
	b=Gi2RUBORPMhnSIdiuzi7Z3/WMeqOWu0PZj/B09j8TywGADJ+2+3NF7J93/KstCB8zg9lum
	oysDn2d/Uhzo2WnUCW0QLAjUI6KEhMIGfTbRCDWXlkT8vXabH7L97R1YYyq8PnogI7teH3
	d/QfigbE2t3F6mddWN9TSJjxc8n4AUc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-uV8WiqJ8MHi444EQxY6uUQ-1; Mon, 29 Jul 2024 14:00:54 -0400
X-MC-Unique: uV8WiqJ8MHi444EQxY6uUQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7a27fcd51so46524136d6.3
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 11:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722276054; x=1722880854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1Yj0FL6bBk0S7TAJGcylnT51HTnsFv86PhBeh7shbs=;
        b=Ro9Tj+IIK7WSaoGjvhL8JYFYKfSpeOhp9nxKPnnYIhi9f9wlVfBLehGwEfGwki0F1U
         5sXSTD5w+RngvYSEu6nb0qrlz8q1prOI/2VDgS2pUKu95VpTdBzMZcu1jlXwo50y+Nc4
         ziHRbs7jQDzjnGDwITbBr2B3rf+WwxXpDRJdn+/e66kqZfgeLLuz3hwEhHHA8bfc/Ot2
         3QELx3K9gkJLmmHo6977AupOVDlcyw9aiJeFTAnEUz5+0GTr3cAoOK5UaUi/BAroABar
         fUeLAa9brD0CwewTN6ODwQNMSiiGiE1UGLIHwjDFlK/uDLpXtBv6Ko58X6zo+blxxT3w
         OBpw==
X-Forwarded-Encrypted: i=1; AJvYcCVxRMkUSwfw/Xmmhq4h/LspzMn3qx0w0VV4MXCtihaGWjA0ieECwojKmv+4XbDM8xFCwZ1k3n7u8rq3TZMHeKfiaGI9
X-Gm-Message-State: AOJu0Yxc7uqeOQaVH2SnNuRoWWdnz79J2HT393RahlU8IBGeqobfSuJQ
	Ywgc+zlQ4ZRlzGYt642SFnR6fGbWQLHgjYJ7UGk9+xYpyS6RFDShMURdJK6vxj0l7No59EvgRgl
	c7W9qwQoUHCACfoyG109YJfga3rkOL5ijlXmDDgToimuzicvBc+VOMug9RnwMaMjTCSAJH3Uhmm
	ved7eUVhPhzNC1ERP+ASOv292L
X-Received: by 2002:ad4:5bc3:0:b0:6b7:9bdd:c5ac with SMTP id 6a1803df08f44-6bb55aec078mr112759876d6.54.1722276053783;
        Mon, 29 Jul 2024 11:00:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1n2toFS2ZsCj0V29zabmrYz0QmGmC0Il9Ic/P2pdVWBsuD9rxQUVP1f4HDaKaP2uCJZOCF3hcREju/aoHH3c=
X-Received: by 2002:ad4:5bc3:0:b0:6b7:9bdd:c5ac with SMTP id
 6a1803df08f44-6bb55aec078mr112759506d6.54.1722276053388; Mon, 29 Jul 2024
 11:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net> <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com> <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com> <87v80uol97.fsf@toke.dk> <7aa360d4486155e811d045043704227276ab112c.camel@nvidia.com>
In-Reply-To: <7aa360d4486155e811d045043704227276ab112c.camel@nvidia.com>
From: Samuel Dobron <sdobron@redhat.com>
Date: Mon, 29 Jul 2024 20:00:42 +0200
Message-ID: <CA+h3auP4gn2T3ghpBjqC5xdYACEOmC5RCsq3ps6VWoLNhy5HNg@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "toke@redhat.com" <toke@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Carolina Jubran <cjubran@nvidia.com>, 
	"hawk@kernel.org" <hawk@kernel.org>, "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, sorry.
Yes, I was talking about 6.4 regression.

I double-checked that v5.15 regression and I don't see anything
that significant as Sebastiano. I ran a couple of tests for:
* kernel-5.10.0-0.rc6.90.eln105
* kernel-5.14.0-60.eln112
* kernel-5.15.0-0.rc7.53.eln113
* kernel-5.16.0-60.eln114
* kernel-6.11.0-0.rc0.20240724git786c8248dbd3.12.eln141

The results of XDP_DROP on receiving side (the one, that is dropping
packets) are more or less the same ~20.5Mpps (17.5Mpps on 6.11, but
that's due to 6.4 regression). CPU is bottleneck, so 100% cpu utilization
for all the kernels on both ends - generator and receiver. We use pktgen
as a generator, both generator and receiver machines use mlx5 NIC.

However, I noticed that between 5.10 and 5.14 there is 30Mpps->22Mpps
regression BUT at the GENERATOR side, CPU util remains the same
on both ends and amount of dropped packets on receiver side is
the same as well (since it's CPU bottlenecked). Other drivers seems
to be unaffected.

That's probably something unrelated to Sebastiano's regression,
but I believe it's worth to mention.

And so, no idea where Sebastiano's regression comes from. I can see,
he uses ConnectX-6, we don't have those, only ConnectX-5, cloud that
be the problem?

Thanks,
Sam.




On Fri, Jul 26, 2024 at 10:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Hi,
>
> On Wed, 2024-07-24 at 17:36 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > Carolina Jubran <cjubran@nvidia.com> writes:
> >
> > > On 22/07/2024 12:26, Dragos Tatulea wrote:
> > > > On Sun, 2024-06-30 at 14:43 +0300, Tariq Toukan wrote:
> > > > >
> > > > > On 21/06/2024 15:35, Samuel Dobron wrote:
> > > > > > Hey all,
> > > > > >
> > > > > > Yeah, we do tests for ELN kernels [1] on a regular basis. Since
> > > > > > ~January of this year.
> > > > > >
> > > > > > As already mentioned, mlx5 is the only driver affected by this =
regression.
> > > > > > Unfortunately, I think Jesper is actually hitting 2 regressions=
 we noticed,
> > > > > > the one already mentioned by Toke, another one [0] has been rep=
orted
> > > > > > in early February.
> > > > > > Btw. issue mentioned by Toke has been moved to Jira, see [5].
> > > > > >
> > > > > > Not sure all of you are able to see the content of [0], Jira sa=
ys it's
> > > > > > RH-confidental.
> > > > > > So, I am not sure how much I can share without being fired :D. =
Anyway,
> > > > > > affected kernels have been released a while ago, so anyone can =
find it
> > > > > > on its own.
> > > > > > Basically, we detected 5% regression on XDP_DROP+mlx5 (currentl=
y, we
> > > > > > don't have data for any other XDP mode) in kernel-5.14 compared=
 to
> > > > > > previous builds.
> > > > > >
> > > > > >   From tests history, I can see (most likely) the same improvem=
ent
> > > > > > on 6.10rc2 (from 15Mpps to 17-18Mpps), so I'd say 20% drop has =
been
> > > > > > (partially) fixed?
> > > > > >
> > > > > > For earlier 6.10. kernels we don't have data due to [3] (there =
is regression on
> > > > > > XDP_DROP as well, but I believe it's turbo-boost issue, as I me=
ntioned
> > > > > > in issue).
> > > > > > So if you want to run tests on 6.10. please see [3].
> > > > > >
> > > > > > Summary XDP_DROP+mlx5@25G:
> > > > > > kernel       pps
> > > > > > <5.14        20.5M        baseline
> > > > > > > =3D5.14      19M           [0]
> > > > > > <6.4          19-20M      baseline for ELN kernels
> > > > > > > =3D6.4        15M           [4 and 5] (mentioned by Toke)
> > > > >
> > > > > + @Dragos
> > > > >
> > > > > That's about when we added several changes to the RX datapath.
> > > > > Most relevant are:
> > > > > - Fully removing the in-driver RX page-cache.
> > > > > - Refactoring to support XDP multi-buffer.
> > > > >
> > > > > We tested XDP performance before submission, I don't recall we no=
ticed
> > > > > such a degradation.
> > > >
> > > > Adding Carolina to post her analysis on this.
> > >
> > > Hey everyone,
> > >
> > > After investigating the issue, it seems the performance degradation i=
s
> > > linked to the commit "x86/bugs: Report Intel retbleed vulnerability"
> > > (6ad0ad2bf8a67).
> >
> > Hmm, that commit is from June 2022, [...]
> >
> The results from the very first mail in this thread from Sebastiano were
> showing a 30Mpps -> 21.3Mpps XDP_DROP regression between 5.15 and 6.2. Th=
is
> is what Carolina was focused on. Furthermore, the results from Samuel don=
't show
> this regression. Seems like the discussion is now focused on the 6.4 regr=
ession?
>
> > [...] and according to Samuel's tests,
> > this issue was introduced sometime between commits b6dad5178cea and
> > 40f71e7cd3c6 (both of which are dated in June 2023).
> >
> Thanks for the commit range (now I know how to decode ELN kernel versions=
 :)).
> Strangely this range doesn't have anything suspicious. I would have expec=
ted to
> see the page_pool or the XDP multibuf changes would have shown up in this=
 range.
> But they are already present in the working version... Anyway, we'll keep=
 on
> looking.
>
> >  Besides, if it was
> > a retbleed mitigation issue, that would affect other drivers as well,
> > no? Our testing only shows this regression on mlx5, not on the intel
> > drivers.
> >
> >
> > > > > I'll check with Dragos as he probably has these reports.
> > > > >
> > > > We only noticed a 6% degradation for XDP_XDROP.
> > > >
> > > > https://lore.kernel.org/netdev/b6fcfa8b-c2b3-8a92-fb6e-0760d5f6f5ff=
@redhat.com/T/
> >
> > That message mentions that "This will be handled in a different patch
> > series by adding support for multi-packet per page." - did that ever go
> > in?
> >
> Nope, no XDP multi-packet per page yet.
>
> Thanks,
> Dragos


