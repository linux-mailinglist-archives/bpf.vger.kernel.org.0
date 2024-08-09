Return-Path: <bpf+bounces-36801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A539194D8A1
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 00:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E29D1F22DC3
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729F16C445;
	Fri,  9 Aug 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V8w4wz/Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8197168488
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723241419; cv=none; b=qX3+7FrPz5ihKRBFZ5R/bWs0u1Qe7UogOJr93FykYranNyzpuo7ipH69ovDydc6yiLo8JLyleULmvb6Cl9zzekch1NhzF5R8HzGANRPwJA+VLuvorVn7pQ3tyaop+LOyudChLGYyHxDy3DeZIFXzRgr+5EGGJDPijh721nz5uUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723241419; c=relaxed/simple;
	bh=25nnKHRATKsCBU/n1AqvspZM6C+R6Z6erJzS2eBx3ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9x/GMopV+SKoCq52meVmQX2+wTj1fSEf9SfQTkRmCr4uL8KjFgcvyQOFzuLGJQkJyazD19RycD3wUAI2fwOFcfux7Z9n4c2EK+2ERUp3/BcVPIMRm2Rjk3rAo2/Eg88pjdtR3BiRXKvTFcw3X/36Jfn6CSU95vcbSs8rE6eThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V8w4wz/Z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso2028877a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723241417; x=1723846217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdgOzJ4SnYOchjgUni5CLr7DrFPzCOvLYwE0f7b/ZBo=;
        b=V8w4wz/ZZcCnBdI6GjV/l95AcAgvCiv5ftNEhpOQ2ZHRIINeSG071T70S4sRBIVYxj
         a+/xNnM3iA4T7TjxGxkR9OaKzrroalfGFdhdnxWDPG2CUZ6CG4IgKx8kMQUIzJzqvy1w
         bVjl4NGRwFmHjDWFxF7ucyIzK9jx4J8xQ4s6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723241417; x=1723846217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdgOzJ4SnYOchjgUni5CLr7DrFPzCOvLYwE0f7b/ZBo=;
        b=IA4E/Z5QkwfU+sd1cdwvyk4JrfkqUo00jIGofyKwKJEr7NUIlI7zD63XcKzDW9k7xM
         I1rWhYJFKrU8c26KteQePO3NYSj+cEH7bRXVMwEmRPEiOtv54eSEZ0uMTuWe9LZ5LOAT
         /b9z5bjXhaWq6SnlVbzPnwUS21eEVeHI7+Bm8f9CZG+BrfVNIGnGOXyNKcfhxseW1Xqp
         6XZboBbQmQiy2v8fM9rqh5Y0wQFMGZRwo+k4BWUT4txZqsVVIM8S6Ei2Zqlye1VkVqkK
         N73k6yb7nk1LdQrh2Mo8cXeB8NnWmEQagCjwNof0GK8OoaCRGDZMzkp80MncgS0pjpU+
         ybYw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Qyira9i/iD3fL51ATyVDe0ciX8vxZho1JjsWb0xvO2kFMJbe9CnQ05NFqcod2WOOYVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFmRLwxz8KTd8d4ovlFCbV1vxUTppRHif3U4lxKG6LQhTjguL
	hRlC2dc1PDW1wnI7l1irP/rQFQc1/TfZTwBwKfj1rcDzXwIGz/Tj0RKGJhhPgPwff5iq/XgLtwR
	vLXGPOU0MBBXnEV/8X3YB0YoV9ToyTcs8wWLY
X-Google-Smtp-Source: AGHT+IGd0LxCEbiIJm03ZGYgIE58Ul8Tl1iOdZ065agxmT/QApewqk/ptKbowjsggmPTAHnCOi7Pxy8tewPTsybuHfA=
X-Received: by 2002:a17:90b:190a:b0:2c2:df58:bb8c with SMTP id
 98e67ed59e1d1-2d1e7fdb96amr3584116a91.18.1723241417013; Fri, 09 Aug 2024
 15:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com> <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
 <CAMdnO-JBznFpExduwCAm929N73Z_p4S4_nzRaowL9SzseqC6LA@mail.gmail.com>
 <de5b4d42-c81d-4687-b244-073142e2967b@lunn.ch> <CAMdnO-+_2Fy=uNgGevtnL8PGPvKyWXPvYaxOJwKcUZj+nnfqYg@mail.gmail.com>
 <5ff4a297-bafd-4b33-aae1-5a983f49119a@lunn.ch>
In-Reply-To: <5ff4a297-bafd-4b33-aae1-5a983f49119a@lunn.ch>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 9 Aug 2024 15:10:05 -0700
Message-ID: <CAMdnO-KpcksaTiqazjVLXNTjJAT+bS8vTVmux94CKLooej=s7A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add PCI driver support for BCM8958x
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 1:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Aug 08, 2024 at 06:54:51PM -0700, Jitendra Vegiraju wrote:
> > On Tue, Aug 6, 2024 at 4:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Mon, Aug 05, 2024 at 05:56:43PM -0700, Jitendra Vegiraju wrote:
> > > > On Fri, Aug 2, 2024 at 4:08=E2=80=AFPM Andrew Lunn <andrew@lunn.ch>=
 wrote:
> > > > >
> > > > > > Management of integrated ethernet switch on this SoC is not han=
dled by
> > > > > > the PCIe interface.
> > > > >
> > > > > MDIO? SPI? I2C?
> > > > >
> > > > The device uses SPI interface. The switch has internal ARM M7 for
> > > > controller firmware.
> > >
> > > Will there be a DSA driver sometime soon talking over SPI to the
> > > firmware?
> > >
> > Hi Andrew,
>
> So the switch will be left in dumb switch everything to every port
> mode? Or it will be totally autonomous using the in build firmware?
>
> What you cannot expect is we allow you to manage the switch from Linux
> using something other than an in kernel driver, probably DSA or pure
> switchdev.

I am starting to get familiar with DSA and switchdev.
The configuration can be sent over the SPI interface.
In the current application, the host receiving PCIE network traffic
need not be the same host that controls the SPI interface.

>
>         Andrew

