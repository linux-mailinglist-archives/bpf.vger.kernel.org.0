Return-Path: <bpf+bounces-63520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADEDB08229
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DE6167F31
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDD1B4223;
	Thu, 17 Jul 2025 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M18k3886"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302952E371A;
	Thu, 17 Jul 2025 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714813; cv=none; b=gbmCg2J2KyAoB1DsNvi+IhtSDaBOcD5TbYF96vrNKyoa2c1kCgVlgqSTupabgaKZt41yewINwVzFU4SPAYyv0PfvT7T8nlbGD8scBs0krYxlTKyxahk59JvBZ2VsBAgE/JcVRO7mK2hGhtHgwJASVdBRcxE4BnB/8gUHO76MYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714813; c=relaxed/simple;
	bh=MXoVxG3n4rT3K90u+1ubqCjerqq0R8LcHr5fEXnaUnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuEx7Mxdw/bT2Cidy40dsU3yU2OoUibc5MAmkawrrGCDuYO34Q5ES5OCo+Bj6IcoYXdwfLCJs+UDyyyoojpBLUmTcoMGqxcOZTVFt5IBrv5eVnqj5jWNGC6+dDb8bFnMGNrqxFJXODVN/rh0t/AZpW63xCtZcW0/ttxOakXMDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M18k3886; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86a052d7897so38856439f.0;
        Wed, 16 Jul 2025 18:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752714811; x=1753319611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXoVxG3n4rT3K90u+1ubqCjerqq0R8LcHr5fEXnaUnQ=;
        b=M18k3886EAwtuE5lYiKUsUkHWMFWVxRVc8Z2CKjEg/UwmdvF1u0MFFYFCx7DOgNSA+
         EZdqUkys5onVrpC3IDo/T46PZ5GVtHAtG3RurZP9Ljp5ZaNKtGpA8rYeVyd8r2sV/rHx
         pndC31A9EWVcpZ/QJKy7TN5zCBl/2/YT0nbxOx4W/0nJf5rAMEj1SH65k8cDvgCkf93w
         PXg5AAOVErp3NwP45MOhR3LkgbfABcChEBfwhXz1h8wgjkM5SBtsrlYDLxUBLM4kgXhT
         GEt5yP4O5jH8kOxsBDFNcoros84aU7xiITzkzk92YtN6QMUz2uUO9bfVN2yCCUoxZK14
         GDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714811; x=1753319611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXoVxG3n4rT3K90u+1ubqCjerqq0R8LcHr5fEXnaUnQ=;
        b=wL4Qz3rlcQGV54y0ZCX22vWtTEZGHosIASZO58V+UQWjn0tR6eVZaITrg9PdDNuoa8
         TwX9k8SDjEtPBNfQ3Shuh1xNcn4ZX+vH6YiDxep1vZXW6ki3qMXnrRWsSJSOlPH8SpaG
         DoH2OaT6MCUS4WW9dF1xJ39zECZdgFKvBeIhdUHON2tFDPThAhvK/X4m/PPcb0H7Zpqi
         uSsJo66LXb4nJFufEBY/ei8qEH5mwxMEm9eobz47SB33mv1PzIZjRZjLOOf2vGshZGgA
         7sbWMCs0qdH5SQeeRfXnVx8KChxfMZ1LOLY7g56XksoomQ5azH1gvvS08adI0PeaghRN
         f7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVHbZwxcVM0H5Ddu+IDieeUyKpni2rHtSimWaFT+7Ow/e1MH9sy63jesXUyMlkluS2YEejzBzKf@vger.kernel.org, AJvYcCVMAEojKhNFpvm581FPbfdv1HTRxelD5H4Cmn2918BRVJNk3ioTIhmDmIr8THdsKq88M1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YySN9MNWJN+eAaXldUOksk3EyPQdmQX4s/46Z6QmvYcwmW5mgeT
	0JnaRpAA4sP7Q4O8AZOXtayIHb3DT1E1MRpHoy7LuAhMIrnW3MkjnQdbrwwSLxRdImUWEVTY1sv
	7diXwaVR3AOzWGq/Erxz575AbQlcV7Jk=
X-Gm-Gg: ASbGnctYgpIOsnbIJ0HFzRYnRMSjJf+PkvG/S2SAaBK2i1/F7wTvpGO/dYg+bjcPe1P
	oQ+0Ljv9Ym8zEgFQqLij/uSavUsZTvwwSFHgosCHVmQJyGkdlpApJLQ2D4dm/DnKHQNJu0/QWKK
	q8d0C+w8EYqg7wsj2hIAh84nL5bB1VXznLjrseFhFMlkr/S9l+mlljqA9x6jzU3+dW7b7A27aAR
	3VbSQ==
X-Google-Smtp-Source: AGHT+IGk6JnR0W2meKWxHrizaj2wksySomjAfMXMb9FQyg09pft6e8rov4boPIkvjYx2Ye6bq7hRgN/SxZMn2RzBTps=
X-Received: by 2002:a05:6602:6c0d:b0:86c:e686:ca29 with SMTP id
 ca18e2360f4ac-879c0892211mr688495439f.2.1752714811061; Wed, 16 Jul 2025
 18:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716122725.6088-1-kerneljasonxing@gmail.com>
 <20250716145645.194db702@kernel.org> <CAL+tcoByyPQX+L3bbAg1hC4YLbnuPrLKidgqKqbyoj0Sny7mxQ@mail.gmail.com>
 <20250716164312.40a18d2f@kernel.org> <CAL+tcoA1LMjxKgQb4WZZ8LeipbGU038is21M_y+kc93eoUpBCA@mail.gmail.com>
 <20250716175248.4f626bdb@kernel.org>
In-Reply-To: <20250716175248.4f626bdb@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Jul 2025 09:12:54 +0800
X-Gm-Features: Ac12FXy8BqrE2XsYETu3EEHmmnmj54eqJPs14i393o5p4ojzgbfcO-QqEgErPtU
Message-ID: <CAL+tcoCMQhaZdvbR1p50tuVk0RUdqAiRgjDrO0b+EO1XvM=2qw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 17 Jul 2025 08:06:48 +0800 Jason Xing wrote:
> > To be honest, this patch really only does one thing as the commit
> > says. It might look very complex, but if readers take a deep look they
> > will find only one removal of that validation for xsk in the hot path.
> > Nothing more and nothing less. So IMHO, it doesn't bring more complex
> > codes here.
> >
> > And removal of one validation indeed contributes to the transmission.
> > I believe there remain a number of applications using copy mode
> > currently. And maintainers of xsk don't regard copy mode as orphaned,
> > right?
>
> First of all, I'm not sure the patch is correct. The XSK skbs can have
> frags, if device doesn't support or clears _SG we should linearize,
> right?

But note that there is one more function __skb_linearize() after
skb_needs_linearize() in the validate_xmit_skb(). __skb_linearize()
tests many members of skbs, which are not used to check the skbs from
xsk. For xsk, it's very simple (please see xsk_build_skb())

>
> Second, we don't understand where the win is coming from, the numbers
> you share are a bit vague. What's so expensive about a few skbs

To be more accurate, it's not "a few" but "so many" because of the
high pps reaching more than 1,000,000. So if people run the xdpsock to
test it, it's not hard to see most of time is spent during the skb
allocation process.

> accesses? Maybe there's an optimization possible to the validation,
> which would apply more broadly, instead of skipping it for one trivial
> case.
>
> Third, I asked you to compare with AF_PACKET, because IIUC it should
> have similar properties as AF_XDP in copy mode. So why not use that?

I haven't run into AF_PACKET so far. At least, I can confirm that xsk
doesn't need it from my side. The whole logic of validation apparently
is not designed for xsk case...

>
> Lastly, the patch is not all that bad, sure. But the experience of
> supporting generic XDP is a very mixed. All the paths that pretend
> to do XDP on skbs have a bunch of quirks and bugs. I'd prefer that
> we push back more broadly on any sort of pretend XDP.

Well, sorry, I feel a bit upset when reading this because as I
insisted before not everyone can use the advanced zerocopy mode.

Thanks,
Jason

