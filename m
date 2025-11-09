Return-Path: <bpf+bounces-74002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84678C436A8
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 01:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 059C94E3E6F
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 00:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5814A8B;
	Sun,  9 Nov 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQfla0ev"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154494C6D
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647062; cv=none; b=AgSykJSEIhTSPwmFvtdBP9QlTa38HO7Oi4sy1fClFCFbfPgMNBhNLhH8b/0W+duRM0hke1TkvUelaAeXqMd/m7cg2GSLwmIbFy+70ktoJ4TZkjyaBLCjQc82C4F/tYUx6ceBqX5Yd4wtkRsltRaz+3MWW15nWoxgLadxl3u8KdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647062; c=relaxed/simple;
	bh=uciTLeXnGZa+fHKIKHqbTzuMHbVFCOUEY8frA2QOXIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9LptAdYPQ6dxELNeHQt26krPthuw/bHhiO0d09F3ZuH5edq5r/n4UknUNuh7XBN7bH+2JUH6k3kO9qiYYBHJlXjXlodVH9KGPFgDlck4NC1G9Zktgww3Pi9kcCDXR4LetZP7ojHR6r1XzJ0dIq87RPNA/avLscVZghuAiVn/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQfla0ev; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4330ef18daeso8070435ab.3
        for <bpf@vger.kernel.org>; Sat, 08 Nov 2025 16:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762647060; x=1763251860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uciTLeXnGZa+fHKIKHqbTzuMHbVFCOUEY8frA2QOXIw=;
        b=YQfla0eveU4PkcTFB2oDv0QshlnaEl2LtUOSsB+3Id3XblfdxENF0+CNwWkPMEbOED
         cHOElH1L25wembKk/zOM+25uKLPcaUuVi8qZvnr4cGV1uyrZ+oRT+GECpgq1uRrCzS+e
         FvQim8puz5Si9RTkbhq2MQ5fKr4TNzW9Y0hMQIL05/MqfR9H2krTtsD8sh9rOEn5f501
         rFeWYqF2KlDM21Wn1igqMHxfMO3uUNmnYc/D+OyF5VQo3sFUfyrAXvwZdaibmEl2R4Rz
         vVxSLAc2BQCyzGBymVduHddoT6+4tHNhtDEComqw5ts/h19LO+KyHQ2jfZEMA4YZtxnP
         DdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762647060; x=1763251860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uciTLeXnGZa+fHKIKHqbTzuMHbVFCOUEY8frA2QOXIw=;
        b=UuEE5qKxWVZ56Nk1RUBP6fVB48V/ZKZOhZmsoUgl4dUYnhMj23O8mnXn+5ntobiFz+
         jAXh6pA0sF7wT1CnVW5Oye98H7snPZQHUaakk5vDEd2G3hORy2wNLvlNysuogCQaonPv
         RRXerNAH8E9ZcX/I2zE033KpQ1G5tgAvP8fwvEWoN/ttS3bLa8VH7JSAeGcVU1y5rRu5
         icu3OxLaI2lSBOw9xDvJ7S6vDhYnhhm5BahIkW3OMH5TGV3VtB6jGma6F/V1cJjCktHN
         6Z/Xk3dmOBRmkqc8OfELAGEgciCvE98AB3ZRJIZc18Y4Fl8KlRMU250r8Zhvi4wegDKB
         WzcA==
X-Forwarded-Encrypted: i=1; AJvYcCUew82hhaNZkbyX3k8YGEx5IkmKF820fQRqhOEilOWkkkrX2Ol2PzGo1Od743B7DhD599E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6Prtv+sWTlVlBei2MfNABsssjH2onm00CIkW8rnkmK2AyvC4
	+qYaM9bNNfnQmFSp33RyNXhDZZHHPqCPl5psf8FYfjseYiKV45V2MrIps3hLpb65APeCoF1i/un
	iLBGC6SZOA05nTlHP4KTqSKXbg6FfIGA=
X-Gm-Gg: ASbGncswmSGZIE2E1W5VZNem7LVBvuYD753nfwEA1HF/OW201e7twk0R0kXsiPenMC+
	pZ0En+7i3X+A8htHLXDO04iuZhp4ebZBxew8anSiZSfVr4QirgDZFBYMWf17dW5UNuSpUrb19xY
	GZdpDyYJCO3Ikh9IvYC2x1hfx15Jj7Mfh2GMjZ271r86DxKoA+RgjqHNf1bzS+IQMZTglJ4MN13
	mIrAw8CpXuT1EGaXmi4z3FuzxQnV8JsX0eHOyBFtNvRkuUgnJStDdPTiaiQovtU
X-Google-Smtp-Source: AGHT+IE6q3ZwFR3f7NoF+liqpAJtsjQrZpjUSa+tOSFG0ga97sj8kN0pG548UbIbviTE50Tohd1SyQw9NrBfD4bqVnc=
X-Received: by 2002:a05:6e02:1606:b0:433:2cca:f004 with SMTP id
 e9e14a558f8ab-43367e65122mr55491525ab.23.1762647060040; Sat, 08 Nov 2025
 16:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu> <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu> <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu> <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
 <aQ9YhCAdu7QNyYxu@eldamar.lan>
In-Reply-To: <aQ9YhCAdu7QNyYxu@eldamar.lan>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 9 Nov 2025 08:10:23 +0800
X-Gm-Features: AWmQ_bnqB8P6josJY8yWeOXB9YCvh_6FqaX49H8uEkcVmwtgx1Xz_DKqbz4CsnE
Message-ID: <CAL+tcoBQPBh_GSeO71=OGx2og_BQ0YaWsA7zzNpC08yYGGfVig@mail.gmail.com>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, mc36 <csmate@nop.hu>, alekcejk@googlemail.com, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 1118437@bugs.debian.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 10:49=E2=80=AFPM Salvatore Bonaccorso <carnil@debian=
.org> wrote:
>
> Hi,
>
> On Tue, Oct 21, 2025 at 12:51:32PM +0200, Fernando Fernandez Mancera wrot=
e:
> >
> >
> > On 10/20/25 11:31 PM, mc36 wrote:
> > > hi,
> > >
> > > On 10/20/25 11:04, Jason Xing wrote:
> > > >
> > > > I followed your steps you attached in your code:
> > > > ////// gcc xskInt.c -lxdp
> > > > ////// sudo ip link add veth1 type veth
> > > > ////// sudo ip link set veth0 up
> > > > ////// sudo ip link set veth1 up
> > >
> > > ip link set dev veth1 address 3a:10:5c:53:b3:5c
> > >
> > > > ////// sudo ./a.out
> > > >
> > > that will do the trick on a recent kerlek....
> > >
> > > its the destination mac in the c code....
> > >
> > > ps: chaining in the original reporter from the fedora land.....
> > >
> > >
> > > have a nice day,
> > >
> > > cs
> > >
> > >
> >
> > hi, FWIW I have reproduced this and I bisected it, issue was introduced=
 at
> > 30f241fcf52aaaef7ac16e66530faa11be78a865 - working on a patch.
>
> Just a qustion in particular for the stable series shipping the commit
> (now only 6.17.y relevant at this point since 6.16.y is EOL): Give the
> proper fix will take a bit more time to develop, would it make sense
> to at least revert the offending commit in the stable series as the
> issue is, unless I missunderstood the report, remotely(?) triggerable
> denial of service?
>
> Or do I miss something here?

We've been working on this already. Please find the patches at
https://lore.kernel.org/all/20251031093230.82386-1-kerneljasonxing@gmail.co=
m/

Yes, my solution is to revert first and apply a pre-allocate array to
temporarily store the descriptors that will be published at the tx
completion phase.

If you also care about this, please feel free to review the whole
idea. As long as everyone is on board, I will send an official version
with more detailed updates. I'm still waiting for more suggestions :)

Thanks,
Jason

