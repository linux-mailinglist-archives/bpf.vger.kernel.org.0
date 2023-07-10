Return-Path: <bpf+bounces-4606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB24774D736
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 15:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278FA1C20AB1
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB1F11CA0;
	Mon, 10 Jul 2023 13:16:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B2C8F9
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 13:16:00 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E1E7;
	Mon, 10 Jul 2023 06:15:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso6961571e87.2;
        Mon, 10 Jul 2023 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688994957; x=1691586957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r+L2gG891GPh66M0eDCMQ9aRXVxlZ1KRKtbZ7it2tCU=;
        b=eWO0wziAXWJVXyVgrtJ/WXvnL1i9c0XR37cedncp/7gjGQR4+Qv/jaCEQuY1avf/zg
         JAqgH9/0Aqp0RAS+pE2QQM6QuxBkhk4ReH3Eff6SMFay5KZusft5UShfuUy93tP+TkWA
         yxJjC+IescEurMzYNRASleuxPC0Y7PIiAEX0u8J+eL2NjDvp6GR2LCpzWPAjJM883SCp
         iICcpB4ZcOyGN0YWzVJKjRQCH5waAvKwIV3dcgQVqBV2cljirSttA4drN1K5porSJM9B
         CJjzM58rfoNga3CbQFVInoAkEBF9cRkoFIxCYvhY0sM+tQKhwqnxKYUBSREp9q4ExHSQ
         vwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688994957; x=1691586957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+L2gG891GPh66M0eDCMQ9aRXVxlZ1KRKtbZ7it2tCU=;
        b=UfgPEwGoS+O/ZdX6K21kTTeQ73JN7En5otVcdyyMOtbUapVs9xv6qjx5mw5yEjt+ag
         yBv8GM2tU8xrW0O6SaKOcb9OwYfUarIcfWGjwkOc2CyIYnDVzVViB6JygyLXp+K9qoVT
         pqE8gGUs5/OulLWoIZUAWZRYCwgV03EwZ5EXrnHZ4pyCd1YTFoZTVf9xa9+2JnbVJkAR
         QP43rP1MLXa0693BUfIlhwpPKZ5vFnwmEz2FeFyQIIyIyToFOnQq3V0DkXnLBWlZEaTA
         perXvisQ/+swkWKSq99QxBB6yT4mgdZw1CoCY1Bh67l4MVy8U6SUCmrsLddimdQ0hkzo
         OtqQ==
X-Gm-Message-State: ABy/qLYXAIE9130Rfu5dSuzCM0S9eJbrTheukwwD/vAeSXKTBRFq04WH
	Ct4TALPuwiMP4SHGy9e2OgM=
X-Google-Smtp-Source: APBJJlH2p4Y9PIwGdr2rfQCKwmGmMwrQoDASOLTGFwsXesE1S98uBFZp3qce8qMPoeqWLa5eZsF52w==
X-Received: by 2002:ac2:5f6a:0:b0:4f9:5426:6622 with SMTP id c10-20020ac25f6a000000b004f954266622mr9710319lfc.69.1688994956129;
        Mon, 10 Jul 2023 06:15:56 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ep14-20020a056512484e00b004fbdf1c85b5sm480650lfb.116.2023.07.10.06.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:15:55 -0700 (PDT)
Message-ID: <9250ec6c6a446cda93f9042d9868a8b36643c5f9.camel@gmail.com>
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
 mykolal@fb.com
Date: Mon, 10 Jul 2023 16:15:54 +0300
In-Reply-To: <ZKwEEd1Ercz8kkId@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
	 <ZHnxsyjDaPQ7gGUP@kernel.org>
	 <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
	 <ZHovRW1G0QZwBSOW@kernel.org>
	 <c9c1e04b10f0a13a3af9e980d04ce08d3304ac3a.camel@gmail.com>
	 <ZH3nalodXmup6pEF@kernel.org>
	 <2b4372428cd1e56de3b79791160cdd3afdc7df6a.camel@gmail.com>
	 <ZH4vZjaQnCGOzY/w@kernel.org> <ZKwEEd1Ercz8kkId@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-10 at 10:13 -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 05, 2023 at 03:54:30PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Mon, Jun 05, 2023 at 05:39:19PM +0300, Eduard Zingerman escreveu:
> > > On Mon, 2023-06-05 at 10:47 -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Jun 02, 2023 at 09:08:51PM +0300, Eduard Zingerman escreveu=
:
> > > > > On Fri, 2023-06-02 at 15:04 -0300, Arnaldo Carvalho de Melo wrote=
:
> > > > > > Em Fri, Jun 02, 2023 at 04:52:40PM +0300, Eduard Zingerman escr=
eveu:
> > > > > > > Right, you are correct.
> > > > > > > The 'structures__tree =3D RB_ROOT' part is still necessary, t=
hough.
> > > > > > > If you are ok with overall structure of the patch I can resen=
d it w/o bzero().
> > > >=20
> > > > > > Humm, so basically this boils down to the following patch?
> > > >=20
> > > > > > +++ b/pahole.c
> > > > > > @@ -674,7 +674,12 @@ static void print_ordered_classes(void)
> > > > > >  		__print_ordered_classes(&structures__tree);
> > > > > >  	} else {
> > > > > >  		struct rb_root resorted =3D RB_ROOT;
> > > > > > -
> > > > > > +#ifdef DEBUG_CHECK_LEAKS
> > > > > > +		// We'll delete structures from structures__tree, since we'r=
e
> > > > > > +		// adding them to ther resorted list, better not keep
> > > > > > +		// references there.
> > > > > > +		structures__tree =3D RB_ROOT;
> > > > > > +#endif
> > > > =20
> > > > > But __structures__delete iterates over structures__tree,
> > > > > so it won't delete anything if code like this, right?
> > > > =20
> > > > > >  		resort_classes(&resorted, &structures__list);
> > > > > >  		__print_ordered_classes(&resorted);
> > > > > >  	}
> > > >=20
> > > > Yeah, I tried to be minimalistic, my version avoids the crash, but
> > > > defeats the DEBUG_CHECK_LEAKS purpose :-\
> > > >=20
> > > > How about:
> > > >=20
> > > > diff --git a/pahole.c b/pahole.c
> > > > index 6fc4ed6a721b97ab..e843999fde2a8a37 100644
> > > > --- a/pahole.c
> > > > +++ b/pahole.c
> > > > @@ -673,10 +673,10 @@ static void print_ordered_classes(void)
> > > >  	if (!need_resort) {
> > > >  		__print_ordered_classes(&structures__tree);
> > > >  	} else {
> > > > -		struct rb_root resorted =3D RB_ROOT;
> > > > +		structures__tree =3D RB_ROOT;
> > > > =20
> > > > -		resort_classes(&resorted, &structures__list);
> > > > -		__print_ordered_classes(&resorted);
> > > > +		resort_classes(&structures__tree, &structures__list);
> > > > +		__print_ordered_classes(&structures__tree);
> > > >  	}
> > > >  }
> > > > =20
> > >=20
> > > That would work, but I still think that there is no need to replicate=
 call
>=20
> I'm going thru the pile of stuff from before my vacations, can I take
> the above as an Acked-by in addition to your Reported-by?

Hi Arnaldo,

Sure, no problem.

>=20
> - Arnaldo
>=20
> > > to __print_ordered_classes, as long as the same list is passed as an =
argument,
> > > e.g.:
> > >=20
> > > @@ -670,14 +671,11 @@ static void resort_classes(struct rb_root *reso=
rted, struct list_head *head)
> > > =20
> > >  static void print_ordered_classes(void)
> > >  {
> > > -       if (!need_resort) {
> > > -               __print_ordered_classes(&structures__tree);
> > > -       } else {
> > > -               struct rb_root resorted =3D RB_ROOT;
> > > -
> > > -               resort_classes(&resorted, &structures__list);
> > > -               __print_ordered_classes(&resorted);
> > > +       if (need_resort) {
> > > +               structures__tree =3D RB_ROOT;
> > > +               resort_classes(&structures__tree, &structures__list);
> > >         }
> > > +       __print_ordered_classes(&structures__tree);
> > >  }
> >=20
> > Right, that can be done as a follow up patch, further simplifying the
> > code.
> >=20
> > I'm just trying to have each patch as small as possible.


