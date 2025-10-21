Return-Path: <bpf+bounces-71562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7007BF6A57
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3BFE355AE3
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AD1DF75B;
	Tue, 21 Oct 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHrZ9l4S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38C78F4B
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051791; cv=none; b=okhtQwIgC5lrN5FZSz54JQjxGAu634kclTSJ6lSmBVdVTMrlJnOTZ5B1Noco3c/FRGqOvG5wbWaOYgSVbSiOMS5mTlBTNU+sY7FA8yf+gAq3GSM/w2nhkhREt0aHbxBLIJHEJNDGPt9rsCj+1fyb/maw4K9yDaKlBex1b0zbilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051791; c=relaxed/simple;
	bh=edvx2QIDGE1D9wIk1L0McJgVQojvsErgZMqmgZxaaNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZF72esgFh6VeNq2YxKsh/6vzLUMtw6Fm8unJrGaLFgy3cBNR6FEgXg1PQdt+1VEbH5GoHNzJrgjIztgj0pmqh/B0S43Rjoi0C6MLap6O5h4oQ0/ubMfYjAf0Uy4pCumQDJpx1xvm7b6Lw4VFaPhwTPNvnt7p/0vlgY38euUeLB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHrZ9l4S; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430d08d56caso12917275ab.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761051787; x=1761656587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AERNXzqQ7nQXEWE75BXTmph2gSHqc++z8nwSg6AhUrs=;
        b=NHrZ9l4Sru8vPTabMiIWTRd54bD6Z3BuX2iSgGyAj978UH/cou5aCiTnO1xgogYh0L
         yOka5cuWVZ8u/muNz4jXVUO9ng0if0/lQcl5mbepR4LPfvV/Vwxb29XmnHxrZYadXpii
         t8A3YWgZV8OVUTzJLgC89ChM6bQWv5SydLrkxVdM8cxFrAXwNbat8DZGq9lMt7qbROkC
         C9qT4QDIXABEpcu8iyTV+3vmTxordD8+ltbh11EbOPIR0nug8jUFmWbYEeWp4muIbzki
         eDW3B2JN54A0lz5tJqmpsOCiq3JIS2jEFR7cdw0XLq8QoprvUDt+KgUwUq7wt3jSIcCr
         dpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051787; x=1761656587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AERNXzqQ7nQXEWE75BXTmph2gSHqc++z8nwSg6AhUrs=;
        b=HMXXBFmlG4xEhGffmw/id7Zc++CuKVBRnluBrfY93yzjlOY1R7bZx6fP9szmmiiXej
         9+BL7Fw+Qn6mY73O2OjLWP5qJManf6yWkyAgG4ZkZC4WbyU/kAjvWUZbb39/bFY0WRwV
         CzHFiN4BfIOpnTJ1gYc2F1OHaM45FUvBpMWiJB2kF94S6Z6ELSKZTYBuqEHAxFipBlju
         kuassuEjWJZ1gAXoOvmNXKlJ88rMu05+01abjG793/iOSvnbIqE9+3hp+IUBWitNwkZE
         jCg4GVPtWpBgnoxBwCuBBCpjleRxo7v/ZrQ/kuRzgUb1YrgqRaTwLq3j82DtjDk9EOcD
         B9SA==
X-Forwarded-Encrypted: i=1; AJvYcCUKGKf59JHnKIaVHd8QYqm5Q3N7dLVUs5m/efjhGrvAXIHttwh0xqgmXoUMCvVlFP0OyKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSza1B5eUakSL0OYxyIgWdk0+gA9NGoHMhcBnw+oHL5zV+ZVr
	XQ7az4Z73h/iJhB+eqEI1cRefFClJomhw8se29UdmKERH6tIawLn1mYabq0RtjZ52ThSD8/DQpd
	eFEeWuD66PEz8xQ2M8LgIsJvMa/Pk25I=
X-Gm-Gg: ASbGncsK5MNbUmc3jtrZag1JISwThGYNMsoF5y6u5ZgR9xWCAKWGD7nR/qTrQGcMxn2
	Dn3QgFqj44N/2361+OitUscXiz2wr5k9YzAfUEZGYd1SyhwTy7K89cwBKZ2vK8uD2utGK0lWnmH
	wlsArsjiM5EpmGM+nU3L86pb3a8aeSlrWy4iFz26+vZEK2VH9AvbFQzHf6AUY4inF8DMIfUZWt4
	7zNfLn8bcA9MM5Eqec25Q3mADAT1Y28xWThzUKFibTHpfbRpHDswNaR/YBqfsodNqRz+TU=
X-Google-Smtp-Source: AGHT+IESVKzExUbkSbXmWCyDa1Eb/W9GRE52sbu+XOIP5l1aRZ0fxVv3tUlgFqknUhMlIQsu91NoGOkAZb1IWFv6Guo=
X-Received: by 2002:a05:6e02:4805:b0:430:e5a4:6f41 with SMTP id
 e9e14a558f8ab-430e5a472d5mr75188935ab.32.1761051786827; Tue, 21 Oct 2025
 06:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu> <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu> <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu> <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
 <CAL+tcoDLr_soUTsZzFE+f-M0R83tvqx7tGjU+a5nBFSdtyP7Lw@mail.gmail.com> <fbeb5832-0051-4f78-bfdf-f1087bc98510@nop.hu>
In-Reply-To: <fbeb5832-0051-4f78-bfdf-f1087bc98510@nop.hu>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Oct 2025 21:02:30 +0800
X-Gm-Features: AS18NWCvrsFHTov72_L7B6nbSSIch5KuztIH_kRJyymSxwWN9N0Ndy-noLoBE_o
Message-ID: <CAL+tcoBVLi6sRJv4ZTA-O3FcACq0dOsUdKO92MuCCC0CZgLs-Q@mail.gmail.com>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: mc36 <csmate@nop.hu>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, alekcejk@googlemail.com, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 1118437@bugs.debian.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:59=E2=80=AFPM mc36 <csmate@nop.hu> wrote:
>
> hi,
>
> you both are crazy good, thank you so much for both of your effort! :)
>
>
> if you're in a need for some more complicated xsk tests, just let me know=
, freertr
>
> have a dataplane and a socat-alike tool with an xsk based packetio for a =
while....

Could you provide a link that points to what you just mentioned? I
believe more tests on veth are necessary.

Thanks,
Jason

>
> br,
>
> cs
>
> On 10/21/25 14:25, Jason Xing wrote:
> > On Tue, Oct 21, 2025 at 6:52   PM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> >>
> >>
> >>
> >> On 10/20/25 11:31 PM, mc36 wrote:
> >>> hi,
> >>>
> >>> On 10/20/25 11:04, Jason Xing wrote:
> >>>>
> >>>> I followed your steps you attached in your code:
> >>>> ////// gcc xskInt.c -lxdp
> >>>> ////// sudo ip link add veth1 type veth
> >>>> ////// sudo ip link set veth0 up
> >>>> ////// sudo ip link set veth1 up
> >>>
> >>> ip link set dev veth1 address 3a:10:5c:53:b3:5c
> >>>
> >>>> ////// sudo ./a.out
> >>>>
> >>> that will do the trick on a recent kerlek....
> >>>
> >>> its the destination mac in the c code....
> >>>
> >>> ps: chaining in the original reporter from the fedora land.....
> >>>
> >>>
> >>> have a nice day,
> >>>
> >>> cs
> >>>
> >>>
> >>
> >> hi, FWIW I have reproduced this and I bisected it, issue was introduce=
d
> >> at 30f241fcf52aaaef7ac16e66530faa11be78a865 - working on a patch.
> >
> > Exactly. I simply reverted it and its dependencies and didn't see any
> > crash then. It was newly introduced, hopefully it will not bring much
> > trouble. As I replied before, I will take a look tomorrow morning.
> >
> > Thanks,
> > Jason
>

