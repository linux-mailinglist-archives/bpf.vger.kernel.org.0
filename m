Return-Path: <bpf+bounces-9777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6079D782
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF611C21088
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5778F66;
	Tue, 12 Sep 2023 17:25:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F65CAC
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:25:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 801A410F4
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694539553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITgoIWLjrCTnPogKL1G4MPNVe08xbouyawnvHOqvqwk=;
	b=TJJF+fPITJXZCBWULr9uqbAGDaypbmLdxJ2LLY4lKvEx9/zaYzvsjj85nuF+YTkqVJ+qiP
	xnmeOd0JmyGf9SiVGLUeRgyC31K0Z0eY4w5EDN1hLEeEffBa0atDbIu7CdvAINRwv6nqY3
	mrLUpJtitU1gW/aySyzoEi/kQ2yu+6o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-q7FWgy0iO86l5uJPzu86tQ-1; Tue, 12 Sep 2023 13:25:52 -0400
X-MC-Unique: q7FWgy0iO86l5uJPzu86tQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ad7037b0f3so42822066b.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 10:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539551; x=1695144351;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITgoIWLjrCTnPogKL1G4MPNVe08xbouyawnvHOqvqwk=;
        b=puYoyiLjhAnGtGaSJNg75nZ6OsJODxJdtX9J7yyPn6Sa+0/Vvz0w2ROvzWBvT2UHX9
         obaka8UOVnXuhZr6GsPX/6pA4OfQ0lUmFS4bvPtQtrLzUN6wbLk1ndcUb1hobSortKly
         mMZ8deHIjJD5NYC4662Xq8yvq6xZL8qxjqRJw+D+DcfWZCx7siqJPHhPnWM9J8dTgJxU
         TUJOLB9xtjuAPjCxXAjHTuaUIESqX2FVpY/5s9oHLdqnAl43+t/8lMpk5AtWsxpeUGtD
         /P7EEKcvPxllnZ8KCPek7O0xO65an+h970ZCTMjCZcReRWMvI8fZbK8JkfbBkPenwxan
         aOJA==
X-Gm-Message-State: AOJu0Yz++GLsEgxyrme2gEQOT//Bp+k48pUTiMhU2Q1ynPnhVgZjchIh
	KqQXd7PdYQqkl1GbXX37HBMHlJtkkUGSEgjdq2+yzvFiM+oUXDHAYljSbJPOJNq8pQA7ajitFCt
	v88VxsdrlRVRf
X-Received: by 2002:a17:907:7817:b0:9a9:f7c3:c178 with SMTP id la23-20020a170907781700b009a9f7c3c178mr9063590ejc.7.1694539550891;
        Tue, 12 Sep 2023 10:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjWsSi4r6zPsRAGz2JlJmvUW1iHKo5jRoGzLpuhxy30ingNuuICP4j4pOrh1ukiGFoBi/ABw==
X-Received: by 2002:a17:907:7817:b0:9a9:f7c3:c178 with SMTP id la23-20020a170907781700b009a9f7c3c178mr9063576ejc.7.1694539550493;
        Tue, 12 Sep 2023 10:25:50 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id gs9-20020a170906f18900b0099bd5d28dc4sm7186063ejb.195.2023.09.12.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:25:50 -0700 (PDT)
Message-ID: <32a8715a63b686aa0ac19fdae22b5d605d47ae35.camel@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
From: Paolo Abeni <pabeni@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Date: Tue, 12 Sep 2023 19:25:48 +0200
In-Reply-To: <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
	 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
	 <20230912152031.GI401982@kernel.org> <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
	 <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
	 <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 20:04 +0300, Andy Shevchenko wrote:
> On Tue, Sep 12, 2023 at 06:53:23PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> > > > On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> > > > > It's rather a gigantic list of heards that is very hard to follow=
.
> > > > > Sorting helps to see what's already included and what's not.
> > > > > It improves a maintainability in a long term.
> > > > >=20
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > >=20
> > > > Hi Andy,
> > > >=20
> > > > At the risk of bike shedding, the sort function of Vim, when operat=
ing
> > > > with the C locale, gives a slightly different order, as experssed b=
y
> > > > this incremental diff.
> > > >=20
> > > > I have no objections to your oder, but I'm slightly curious as
> > > > to how it came about.
> > >=20
> > > !sort which is external command.
> > >=20
> > > $ locale -k LC_COLLATE
> > > collate-nrules=3D4
> > > collate-rulesets=3D""
> > > collate-symb-hash-sizemb=3D1303
> > > collate-codeset=3D"UTF-8"
> >=20
> > I'm unsure this change is worthy. It will make any later fix touching
> > the header list more difficult to backport, and I don't see a great
> > direct advantage.
>=20
> As Rasmus put it here
> https://lore.kernel.org/lkml/5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusv=
illemoes.dk/
> In short term you can argue that it's not beneficial, but in long term it=
's given
> less conflicts.
>=20
> > Please repost the first patch standalone.
>=20
> Why to repost, what did I miss? It's available via lore, just run
>=20
>   b4 am -slt -P _ 20230911154534.4174265-1-andriy.shevchenko@linux.intel.=
com
>=20
> to get it :-)

It's fairly better if actions (changes) on patches are taken by the
submitter: it scales way better, and if the other path take places we
can be easily flooded with small (but likely increasingly less smaller)
requests that will soon prevent any other activity from being taken.

Please, repost the single patch, it would be easier to me.

Thanks!

Paolo


