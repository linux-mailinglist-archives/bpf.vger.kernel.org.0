Return-Path: <bpf+bounces-23165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DFF86E782
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D727CB2DF73
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87273101D4;
	Fri,  1 Mar 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="px9EOQVF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1238BFE
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314811; cv=none; b=G0aUToQP44NvENjDKm7BKW64ix0boHTNAcmPSKypsit8fkp5adUNFnjyqP++gYhdmftuMPlra2OjAiOoz5zJMcQuf/l+8TsBpqKufau4frxjypx2SfXVZhHsg8XtFakffuqZrKRnmChqgSHwu/vas6e5RtJYu5LQagVVvUooizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314811; c=relaxed/simple;
	bh=UB3/57HFBauwLv+012N6zNdwHb3m9tv4hQ3fEEnCH+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hylkq2ZAmuYyts29/rn7Cxcp5M6NPWTfHdoQiCyhtZLVjz9r+4YlBn/sIREG6mrNv8f6W4jlxUxuZFG4RymvEWg5fbRtuyw1hVEBHoWp3kZGBCtWiKgtEntnTWaGL2x0iexhlzES/LkuunICOGQ8DLGQ6HM7gYN/uVl23f8EbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=px9EOQVF; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60925c4235eso24297817b3.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709314808; x=1709919608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKuoTII8owMqXxc9bXrPH4tQcPB3RC2Q+SoMsJFiE6E=;
        b=px9EOQVFODT7Lk+tRSIpIFN2b+V1F/K2HVwxmkp9MS8WbtjupqQQTGH3nhAaLBSP0o
         UnOnrQxSfVCoNwtP2/oP6m9AjVnaemkmO8N+nWsWi/Gevt9aHGiY/dbzFm9oMRdwRC8N
         1zOfYYdU5+G8EEH0OT8dCFjY213VdEcAylPdZr7yiTXLCLbetIXyjcOw8fTleD+ff6nf
         LgR7uNYyNRv5rBe51Wlt6vBjWnku580NzqSBYxhDIT6IzMIL2MYp9j7pD0mTboqSLKYe
         eKpevhpc5iOQRoA2U23lC4lLcva7hanXuddJGuZlQiCQd7bDKTRCvs4al5PJ9v382/mO
         E1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314808; x=1709919608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKuoTII8owMqXxc9bXrPH4tQcPB3RC2Q+SoMsJFiE6E=;
        b=UlDmHjcc95tk80NVFuzxgX5GZHmsU+3xDlGJ4j13qQ89wYUUXT6JIE35gJKWAiqDbC
         PiCOpmB+oSz/SdUdyynniA9cU1WvCLUsr/xkDUfNkSOida95jGIDIWY+zRIUtWkmo9MN
         7Tq4U3jyux0WP9Sm2aPEa0Ti4R2Ntp7LKOApzHtahUqmVF29RIzP4vfcPNKgmEuzpvEm
         ZEPrcUlxaHP4n77xjobRd/wNtk4XFQ03QaFF3XfI1siLBkshv6thkFT+3yUjaSsfKqXT
         Gw64GEyDetMsR93Uc3AHQykP8nt8MFnySoYGOqbMhAhNanvumaP+uOGfCgpCYx+CYpCs
         pvFA==
X-Forwarded-Encrypted: i=1; AJvYcCViBRsDumIhEVinEsPk63tPkRZ/d2QzssL38U0FPGMP8FRCxqMbB9nCbLWE/iMyw+zayWFr/CWiyjmeRl0Yz4aYXEJM
X-Gm-Message-State: AOJu0YxKjz6j3iKAbUpEp6hnWHONrRdbbPm61ai2yAg0zdnOK0VNlOTb
	c9Qk7XBzdBMfYh5+scAwVFazyKL/oE9zZXCaZ5fNLsJH3+O8ucEWItCHw2csBike6XnA8wlpGQx
	/dppjd/NUFIG5ksjUbBn4W9GxGD+phrM1tALp
X-Google-Smtp-Source: AGHT+IGMv1I8lsnSEM98Q7RwuIprQg6WXktaBL5cN+m4nAwoC6lB1l1TJqrjSknlIJcOsn1qmvc77M/Y/IIks77lNrw=
X-Received: by 2002:a81:a196:0:b0:609:2c2a:1115 with SMTP id
 y144-20020a81a196000000b006092c2a1115mr2484668ywg.30.1709314807947; Fri, 01
 Mar 2024 09:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com> <20240301090020.7c9ebc1d@kernel.org>
In-Reply-To: <20240301090020.7c9ebc1d@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 1 Mar 2024 12:39:56 -0500
Message-ID: <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tom Herbert <tom@sipanda.io>, John Fastabend <john.fastabend@gmail.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, mleitner@redhat.com, Mahesh.Shirshyad@amd.com, 
	Vipin.Jain@amd.com, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com, Vlad Buslov <vladbu@nvidia.com>, 
	horms@kernel.org, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, 
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, andy.fingerhut@gmail.com, 
	"Sommers, Chris" <chris.sommers@keysight.com>, mattyk@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 29 Feb 2024 19:00:50 -0800 Tom Herbert wrote:
> > > I want to emphasize again these patches are about the P4 s/w pipeline
> > > that is intended to work seamlessly with hw offload. If you are
> > > interested in h/w offload and want to contribute just show up at the
> > > meetings - they are open to all. The current offloadable piece is the
> > > match-action tables. The P4 specs may change to include parsers in th=
e
> > > future or other objects etc (but not sure why we should discuss this
> > > in the thread).
> >
> > Pardon my ignorance, but doesn't P4 want to be compiled to a backend
> > target? How does going through TC make this seamless?
>
> +1
>

I should clarify what i meant by "seamless". It means the same control
API is used for s/w or h/w. This is a feature of tc, and is not being
introduced by P4TC. P4 control only deals with Match-action tables -
just as TC does.

> My intuition is that for offload the device would be programmed at
> start-of-day / probe. By loading the compiled P4 from /lib/firmware.
> Then the _device_ tells the kernel what tables and parser graph it's
> got.
>

BTW: I just want to say that these patches are about s/w - not
offload. Someone asked about offload so as in normal discussions we
steered in that direction. The hardware piece will require additional
patchsets which still require discussions. I hope we dont steer off
too much, otherwise i can start a new thread just to discuss current
view of the h/w.

Its not the device telling the kernel what it has. Its the other way around=
.
From the P4 program you generate the s/w (the ebpf code and other
auxillary stuff) and h/w pieces using a compiler.
You compile ebpf, etc, then load.

The current point of discussion is the hw binary is to be "activated"
through the same tc filter that does the s/w. So one could say:

tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3
\
   prog type hw filename "simple_l3.o" ... \
   action bpf obj $PARSER.o section p4tc/parser \
   action bpf obj $PROGNAME.o section p4tc/main

And that would through tc driver callbacks signal to the driver to
find the binary possibly via  /lib/firmware
Some of the original discussion was to use devlink for loading the
binary - but that went nowhere.

Once you have this in place then netlink with tc skip_sw/hw. This is
what i meant by "seamless"

> Plus, if we're talking about offloads, aren't we getting back into
> the same controversies we had when merging OvS (not that I was around).
> The "standalone stack to the side" problem. Some of the tables in the
> pipeline may be for routing, not ACLs. Should they be fed from the
> routing stack? How is that integration going to work? The parsing
> graph feels a bit like global device configuration, not a piece of
> functionality that should sit under sub-sub-system in the corner.

The current (maybe i should say initial) thought is the P4 program
does not touch the existing kernel infra such as fdb etc.
Of course we can model the kernel datapath using P4 but you wont be
using "ip route add..." or "bridge fdb...".
In the future, P4 extern could be used to model existing infra and we
should be able to use the same tooling. That is a discussion that
comes on/off (i think it did in the last meeting).

cheers,
jamal

