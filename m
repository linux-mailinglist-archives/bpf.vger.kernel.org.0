Return-Path: <bpf+bounces-64075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF0B0E0FC
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E56C546E13
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA5D279DC6;
	Tue, 22 Jul 2025 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIujCzkb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1975279DAA;
	Tue, 22 Jul 2025 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199622; cv=none; b=Zz7R03Jp2FYj7VWXjATWsmbWrjgPSoA8i2CZeA3BKLWRYQD6O91naItDh4FRdhcK76FRzbS9+d8ZGpVNvgmyV07dEFWKa6RroZweRHTXyVaYk1WLnIFFFGrgGsV1H1N9Va8iKilRCGtxlfbyEs9/t+AEmc/sYjtOODslpnQXaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199622; c=relaxed/simple;
	bh=adr5sYEO4gGv2YXAYDqrl4czLFwxUgDgxoHepLkF+Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opdtxR3p4Z3aAIzTDepd0WrDOSh/Y+OXaqSo+9jTMTo1AooYsg40Hy6vSYczTSDzBHSD7Gx7K57LZPZWktpXtHQzd+62TF1q3BrlhTEEdFm6isc6n8i2QbwSKp9jul0tkdYKMqAAs42i2VRz3O/Az7s1vuRa/a+pJLJIHhXyR74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIujCzkb; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso45709565ab.0;
        Tue, 22 Jul 2025 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753199620; x=1753804420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adr5sYEO4gGv2YXAYDqrl4czLFwxUgDgxoHepLkF+Nw=;
        b=fIujCzkbAH45D3K6e4DQjRT3xFXaF7sDarwP1Bk3BxOqDos+Hb5i9A+tDGLgFSpvXz
         GZavIWzlDeQKfPWjQFJO7BQLi3vvWcrcuT3VvJcKAm9hoPWmchy+rZ21JskxhAQBYJvj
         7hZYUMxoQBrq84BGcILoFkPM10de5FmNuKkcXCGkVh75nhXu0xd3XDXs4FwdaAWw1Em2
         5U948u7zHXH+EZnT+2hgKyotiBG2qI2XO/9EAbET9dLMsILUgNjMB+Xt2ZKNMyOjAcK1
         zjnGicynjdPiJkWH3CHevJC4VienvMFxuSrc4NggYWHQNscmdcVO9COPVBcFIr8rKKM4
         S7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753199620; x=1753804420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adr5sYEO4gGv2YXAYDqrl4czLFwxUgDgxoHepLkF+Nw=;
        b=vvgWj2MySDj2xCElkljNZOs1Qb3gLXDWu+iaCnH3ZV1nTyLuUY/ar2uvEaa/F8NfM4
         iI9l9dUpgjHX1TmbKZZ1MwahfpPgq0wuRkp8i7tENgFYVr8iWnrXh6g4TuWUAdMUA0Fw
         PurAW9vJKIAJT/GIluXmodTxmkJZtPWhGWuDiqDegUzbZFgDyshSDFP2t7eTSW2W91k6
         kmxjv0c4Kq3LtwvRZIygY54DcZkqwr2s37aZb9sCd8rgyKIhoCR9YSYmxqV1vuaFT0vY
         boh/njP5EDw2cF7bGGd4sjmh85tqRMw2goJOmUi1k7ZVU0nS7DzD4HGs7KOd1qnUVFBB
         TrnA==
X-Forwarded-Encrypted: i=1; AJvYcCVi9KNI4FIjHNJOitZwcG2Xz6S/TmoO+ca+PiynF7D9OBjRG9KbnI49yQOAFK5VmPEg3vE6GOcL@vger.kernel.org, AJvYcCXvt0v0HiwXoSD5fPmMu2r+UT2Bu1QikfhGpGDw4vjrNGMbj+Swy+tKd1GKVmqRhn5q89g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlVZj52rtQh7custP1XTy3PKi29EheAseVhjtX0hy2ZM+JWNB
	OlhYiZ+LlgMxqsj27y3o9s1hLQ8KumFgEghTvZDfoluCWd0JRFmsBHffU3c27NG8QB1ieETesvn
	NRO3zbk44RnsDgXYFkM7uWBVNWjRrSQ8=
X-Gm-Gg: ASbGncuKrMvMaY+X9IkMyKUC0g0kQjH55jtcLD6jITDMDuP+QrULp3YXMQPVAmIjMOb
	0sRNcpZKj0eoJM4e/Dd/wwp2iaqKq+6i6QOe/XTZgtnLxSPpfUMSywJmCNNlSZmhOOnbhp/SI+D
	PMKEUZKkbfSg1AtEQoRBFbOsjRt3Ww/2FqPwnjTi3vWLC6In+sml6ZJ9rMQzV+mXPi6tHcSU5Vv
	34rMm6AlbVL7w4V
X-Google-Smtp-Source: AGHT+IEJWm/iCeW2Y4moVUtuGQu6TSWVSa6lw45TSOWwh0m4HIQqc9HfG9s47AeP0XtnyGFnP1g9pMf1aTcA5QyVbwo=
X-Received: by 2002:a92:d110:0:b0:3dd:89b0:8e1b with SMTP id
 e9e14a558f8ab-3e28245d435mr236925025ab.15.1753199619608; Tue, 22 Jul 2025
 08:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com> <8c9e97e4-3590-49a8-940b-717deac0078d@molgen.mpg.de>
 <CAL+tcoAP7Zk7A4pzK-za+_NMoX11SGR3ubtY6R+aaywoEq_H+g@mail.gmail.com> <687f9d4cf0b14_2aa7cc29443@willemb.c.googlers.com.notmuch>
In-Reply-To: <687f9d4cf0b14_2aa7cc29443@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Jul 2025 23:53:03 +0800
X-Gm-Features: Ac12FXwbckjpwxjxMK_Lfr5hlSRd7HzN5fKFdGn8nikqBlfITUYZXyaXfPGKt0A
Message-ID: <CAL+tcoC5KnTuWKxKcUqFGh-nBSF+X+RWzr=RkkK86+jY1Q20Kw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] stmmac: xsk: fix underflow
 of budget in zerocopy mode
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:16=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Hi Paul,
> >
> > On Mon, Jul 21, 2025 at 4:56=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg=
.de> wrote:
> > >
> > > Dear Jason,
> > >
> > >
> > > Thank you for your patch.
> >
> > Thanks for your quick response and review :)
> >
> > >
> > > Am 21.07.25 um 10:33 schrieb Jason Xing:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The issue can happen when the budget number of descs are consumed. =
As
> > >
> > > Instead of =E2=80=9CThe issue=E2=80=9D, I=E2=80=99d use =E2=80=9CAn u=
nderflow =E2=80=A6=E2=80=9D.
> >
> > Will change it.
> >
> > >
> > > > long as the budget is decreased to zero, it will again go into
> > > > while (budget-- > 0) statement and get decreased by one, so the
> > > > underflow issue can happen. It will lead to returning true whereas =
the
> > > > expected value should be false.
> > >
> > > What is =E2=80=9Cit=E2=80=9D?
> >
> > It means 'underflow of budget' behavior.
>
> A technicality, but this is (negative) overflow.
>
> Underflow is a computation that results in a value that is too small
> to be represented by the given type.

Interesting. Thanks for sharing this with me:)

I just checked the wikipedia[1] that says " Underflow can in part be
regarded as negative overflow of the exponent of the floating-point
value.". I assume this rule can also be applied in this case? I'm
hesitant to send the v3 patch tomorrow with this 'negative overflow'
term included.

[1]: https://en.wikipedia.org/wiki/Arithmetic_underflow

Thanks,
Jason

