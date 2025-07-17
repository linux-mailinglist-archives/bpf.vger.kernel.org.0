Return-Path: <bpf+bounces-63552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE60BB08340
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C421AA56C1
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4762A1E379B;
	Thu, 17 Jul 2025 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isn1pze/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BF63CF;
	Thu, 17 Jul 2025 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721887; cv=none; b=hVRaxN6qsqCkXqAhT6tbrQv9uKEFFeHTkcJ+nvPXLzaz4P42gFS9CIN7AGBcVMyHeAPyBo9J5jVLjJIEPFMvIdv86vH1LhMmrqdo9mEpiKjVoIeEJMmASlSjkG4MxiPdsjNh4LNMGl3kD6Of2xysQ2aWWzOkkIHfteoDgzcCIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721887; c=relaxed/simple;
	bh=xfRY10Q3m/4i5x7a2WbzvtkGzjEBTWgP2bb4vKVkmCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfniLp1rDxSIs91JOrsas8A/AZclgRWvvugPjgOOCYArgcI0ItAjGtOdXbqfDaJ0nuqttga/arsFPe4FI5fEY8zjKU9zWIrTgssuHOmDeOGnxvWx90vyJC0Mr5TNVyIZu+PYcqYVYYqnHo4J/cMXg+bZ9U5IZFeen7hqrFOMXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isn1pze/; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8762a0866a3so9121339f.2;
        Wed, 16 Jul 2025 20:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752721885; x=1753326685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfRY10Q3m/4i5x7a2WbzvtkGzjEBTWgP2bb4vKVkmCU=;
        b=isn1pze/qOThi8q1dCsHRr3UqdL6kxCgle2cSfX6Ilcs1MT6cTKeaBWU1FdwL8I7qo
         AgsgaTyrCWlB9vihKP4697mqt8DC9Frusj9Tvd1Cr1Px4C+2/+KbB9+fbbRT9l+xuqMb
         rZltvwByNRdlRXkKWDJpLqmsrJuAc7M9L+sIprMqa8s56t1y31uHERRJQHO4JZdyfoDK
         vkDXgIEQNFqwscM4iDtvjx9mbvSHTuPYbnatikXHyFYcwns8r9KCzW6SZbwAZuUH/7oj
         j1GOymCmewxXSM4JlxAQRen4bWg5Il3Y87eapBHIoOyprCrI0TyHjTftXHd1VVStQpeL
         s3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752721885; x=1753326685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfRY10Q3m/4i5x7a2WbzvtkGzjEBTWgP2bb4vKVkmCU=;
        b=LL8OzODdOerT9Sk/axPi2lH7j7PxBHfH47Xoa2jvhBAtLohar8zVoVVKoBu1Z/N97i
         2tOwDwOkqaYaNaHp27bNx+sr7VtAjL3ZdcauliyIVMEfcCoqZrfIdLmzM8xUlQ6tj3wP
         iSg8O+h3gVsxOUj9L21/cYsOr0D+bfSzuU/2TV1Dk+S/fKlxX8EVeKA3BHObwZTU+vQS
         Mv762LgFraEhvBYoyEGjMPv3yORSbBAbpct9fFZW5oQb7+xQ4HNUus42o/7knxt0+Q3F
         879jenxXvMSEKQLXC+TEcOtfSNQ9zfRvAKjshO5kmbf9WEe8CaR/fcWWgXJefhqKK7KA
         XhtA==
X-Forwarded-Encrypted: i=1; AJvYcCVpjwGEY8xjK9NuSQiXd62eEYuGJfYA6EWHKeOsDxelt9CjM2bjpiI/3kn3GKDMjLAEp20=@vger.kernel.org, AJvYcCX7mRumqyYLl4MfMhLi2d4hjEnLDs+bkeafLguli4cPkrsHO8On+IOZbzglbguSN+GOTrfmCVMF@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYkSXUV1ROwP56N8lS8tlYrBS30Exaz/pX7KrlWBlGbDFMdGD
	fy08vSnx9Qt1GiEnMFRWZSOxM7EtNCHDe7SE5eSC8soqE93yXVu+oVm0G3D9X+T5tlhsIUQzgAQ
	qVzPNLlBa2Vi8pxleSxNSgp/DHbO9RdE=
X-Gm-Gg: ASbGncuCJ/ioptoLy0NtJgUv9Vx/Bss2IXLS04zbkisBUvZtFqKBnAAKJyX+2xQOaH3
	ZdNdQAuxPom/62WTa7a4wcou7KCtNysZWQHthTrrAmquyQlavIa/i0zv9AmvqDj1IAoI4KSfxyu
	wd0laoqc+VqJRLPXNrLtlkdeQHEVdGctUAMJHU0GtFiIxxK5ZLmf5OFMKc4V77o5IAtCTruHtGC
	JLaEEY=
X-Google-Smtp-Source: AGHT+IHS9dqyksCoN5oNW3oIxyZEnTBYLjVB/y4gyLu3p4oY0myhdWTFJ7lYUqgjlAE/hq8fOgB+gn2FMDa5EEGjEEU=
X-Received: by 2002:a05:6602:1348:b0:879:66fe:8d1e with SMTP id
 ca18e2360f4ac-87c0138865bmr140299839f.8.1752721885305; Wed, 16 Jul 2025
 20:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716122725.6088-1-kerneljasonxing@gmail.com>
 <20250716145645.194db702@kernel.org> <CAL+tcoByyPQX+L3bbAg1hC4YLbnuPrLKidgqKqbyoj0Sny7mxQ@mail.gmail.com>
 <20250716164312.40a18d2f@kernel.org> <CAL+tcoA1LMjxKgQb4WZZ8LeipbGU038is21M_y+kc93eoUpBCA@mail.gmail.com>
 <20250716175248.4f626bdb@kernel.org> <CAL+tcoCMQhaZdvbR1p50tuVk0RUdqAiRgjDrO0b+EO1XvM=2qw@mail.gmail.com>
 <6878655ca06c7_9aa0c294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <6878655ca06c7_9aa0c294c5@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Jul 2025 11:10:48 +0800
X-Gm-Features: Ac12FXybXgTUEEKerdQr9fM84bKdc9vOeWAxIPiLBxbzMCwCqW2P0uprSu9HBI0
Message-ID: <CAL+tcoAEtJ43UKR6rDsLV9s9U31KmT_sE2+xpYnvFRQjsSAu5w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:52=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Jul 17, 2025 at 8:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 17 Jul 2025 08:06:48 +0800 Jason Xing wrote:
> > > > To be honest, this patch really only does one thing as the commit
> > > > says. It might look very complex, but if readers take a deep look t=
hey
> > > > will find only one removal of that validation for xsk in the hot pa=
th.
> > > > Nothing more and nothing less. So IMHO, it doesn't bring more compl=
ex
> > > > codes here.
> > > >
> > > > And removal of one validation indeed contributes to the transmissio=
n.
> > > > I believe there remain a number of applications using copy mode
> > > > currently. And maintainers of xsk don't regard copy mode as orphane=
d,
> > > > right?
> > >
> > > First of all, I'm not sure the patch is correct. The XSK skbs can hav=
e
> > > frags, if device doesn't support or clears _SG we should linearize,
> > > right?
> >
> > But note that there is one more function __skb_linearize() after
> > skb_needs_linearize() in the validate_xmit_skb(). __skb_linearize()
> > tests many members of skbs, which are not used to check the skbs from
> > xsk. For xsk, it's very simple (please see xsk_build_skb())
>
> For single frame xsk skb_needs_linearize will be false and thus
> __skb_linearize is not called?
>
> More generally, I would also think that the cost of the
> validate_xmit_skb checks are quite cheap in the xsk case where they
> are all false. On the assumption that the touched cachelines are
> likely warm.
>
> > >
> > > Second, we don't understand where the win is coming from, the numbers
> > > you share are a bit vague. What's so expensive about a few skbs
> >
> > To be more accurate, it's not "a few" but "so many" because of the
> > high pps reaching more than 1,000,000. So if people run the xdpsock to
> > test it, it's not hard to see most of time is spent during the skb
> > allocation process.
>
> Right, the alloc or memcpy more than the validate?

Thanks for chiming in.

Sure thing. Validate only takes 4% total time, which could be easily
observed by using perf.

The story behind the patch is that I was scanning the code and found
the validation is not necessary based on the theory instead of
experiment, _then_ I tried xdpsock to see if any performance impact
and used perf to capture the hot spot.

And I don't think I can find any other useful improvement whether in
copy mode or zc mode after finishing investigation so far.

Last time, I mentioned that I tried two out-of-thin-air approaches[1].
But everything didn't go as well as expected...

[1]: https://lore.kernel.org/all/CAL+tcoAn8ADUGARSzZB=3D5dGoa+Kh7HnNBLxyqTa=
3W6tOhUK-sg@mail.gmail.com/

Thanks,
Jason

