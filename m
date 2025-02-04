Return-Path: <bpf+bounces-50368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7653BA26A36
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 03:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068E93A66AB
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BFB145A03;
	Tue,  4 Feb 2025 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDxf3ysp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307878F4F;
	Tue,  4 Feb 2025 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637138; cv=none; b=IbnuZu7QjS23r1vQgmr7BSknhLWYZY7+CqSlmqH+pnVobT7A5Tc6zeNihzQlkw/dNchHe3shWN9kXx6taFwFUm2RyN1yGcpQTroRp+5qF5ioLaTMcx+c3UDNyMMTZjM1hoUt8GNyAhKQxb6ZkP2CAaf5B4IHBdSiWihIdkLcBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637138; c=relaxed/simple;
	bh=yflwYZPaRxLnXTEznbm21UWh+afWaz33wb1Y8tW5Y4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7rZtM6B/v/rFk+qn3GIWSgEkPIqWuBpfI+ogOAfmAJgFFK89RouAYncmN0k1h6WUDOWlPk5BGyNlyMl4GTv5swnIShxZxQoJYGBzg4DShTGbRPTO+TY5jm6xdx2DjWy6T2svje6pwLd9HkhVjQ5e3GhNLqjBCJhxG3S9oZgEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDxf3ysp; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3cfe17f75dfso38094815ab.2;
        Mon, 03 Feb 2025 18:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738637135; x=1739241935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yflwYZPaRxLnXTEznbm21UWh+afWaz33wb1Y8tW5Y4c=;
        b=UDxf3yspfiqjNhzmEUt0lFyYDGlNowWL2qUsMKqIk30FP8MHwjFNCcf78lQxfldcD3
         AlDefWkIVs9qQrmOmQ8C+EzYhd6g5j7K5+5QYXhBcyEzvZmLvGMrLoQlMo5GvftNoqhw
         XHyfVBIZeWbGbm8uqakCqtcxb/evb8ZJ0Y0IztKI+w9CB01VxUkumMCsM37rBrTIUmxW
         nw7ajyHPwAS86BdsM+iETyeYtrufjgzxWRb1l6P0YuS7JUbWfB47Z+vO2hA6sQPbwHUM
         hu3zQpa5kzdF22/Nrr4QNi6nYyc8amWITOs+AzL6Z1Ai+XWMPK/3sP9AL7zyccsma+Jc
         ES4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738637135; x=1739241935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yflwYZPaRxLnXTEznbm21UWh+afWaz33wb1Y8tW5Y4c=;
        b=rTBH1PuQ6M98Q5VhPY0ebtVVUfINCSZncWHiGTDzySi+HG5FSL197+1fg5zug7TXl+
         OtZaXkF6lh6Ec202XBmy5bIwpvF/AL8dNFZDajX8WF0+nEVM7XMsAsqXdoxGYYWrCgPH
         3lmhlzT7IVUujHkHxa58tfSfcUUsbN2zCc5Xotqck41+PNrgt55Df3p8n0TMKlRzvT/Z
         1i/DMpslRevNiQ3AjZIUWomnXfXEQSLED+yB04q8hP6v2JVa+inWlzzr3blIvLtTvJiH
         utToq6Lk8LgaJJaASFQ7QXCzEAJkPQoEma0ErdS4ghyloeZVwppl/RBDFm6Eis9zTjtD
         53BA==
X-Forwarded-Encrypted: i=1; AJvYcCVA0roTxYH1UVgNwzBDCnY9XvPLGOAPiUx9Ls5wovqAnXE+DjWT+8QxmynMWncYIu5VnC8=@vger.kernel.org, AJvYcCVDc1QwJZTn5/HtXbzArGZ7MxD74Gw8uPDXnQiVzmolDGxOxpMuAY/XoJug1mNt6+iYKCjaDqBx@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyDTa95BPTBDyWg0WWSRDiYU1F6HZMy8ZJQseizwgVYccRT7g
	ETt6JagR3Xf8f02es8JVqGYVJGSzB7M9gfH6BG6kr+CYBh/lzsra2iW0mcUaTgMDwIvTpFBpLND
	rhJ/oC/kIuMEjJ/3Btb09ft5Q2jI=
X-Gm-Gg: ASbGncvCk02kvA4n3sTfvhM+m/7obdHLzy0dAls9Ez4EZFtmdt0rFlN+dSFmcy8TtE9
	xKtAf/w2UaMUO9dAkI+PkZBG9ZpHTzh11mj+KOJiiNgXYntLmIVVAr+e6lGON6Lwe0d/gmWq2
X-Google-Smtp-Source: AGHT+IHG5VycRtiTomtf+qEUPk+KV4HRLcyfKnPsEEx2gBJJG+b10iF7cIpTiskYJ4yFisu0Ol8m1swNk1m10hmj/BA=
X-Received: by 2002:a92:cda9:0:b0:3cf:bb3e:884c with SMTP id
 e9e14a558f8ab-3cffe44793amr217609435ab.16.1738637135552; Mon, 03 Feb 2025
 18:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com> <2706706c-3d85-4f43-ad91-d04bbb4f2b92@linux.dev>
In-Reply-To: <2706706c-3d85-4f43-ad91-d04bbb4f2b92@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Feb 2025 10:44:59 +0800
X-Gm-Features: AWEUYZlBosmRW8GmSkfO8lOW172NcH1aNf6246Q1fFbHbXfTjPSpMmiE8GCFGU0
Message-ID: <CAL+tcoAXcDuAsy6rqGBh3Sb1dkdZ0xn6YFCQec-K6QSPyaVwEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 00/13] net-timestamp: bpf extension to equip
 applications transparently
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:27=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/28/25 12:46 AM, Jason Xing wrote:
> > "Timestamping is key to debugging network stack latency. With
> > SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> > network issues can be attributed to the kernel." This is extracted
> > from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> > addressed by Willem de Bruijn at netdevconf 0x17).
> >
> > There are a few areas that need optimization with the consideration of
> > easier use and less performance impact, which I highlighted and mainly
> > discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> > uAPI compatibility, extra system call overhead, and the need for
> > application modification. I initially managed to solve these issues
> > by writing a kernel module that hooks various key functions. However,
> > this approach is not suitable for the next kernel release. Therefore,
> > a BPF extension was proposed. During recent period, Martin KaFai Lau
> > provides invaluable suggestions about BPF along the way. Many thanks
> > here!
> >
> > In this series, I only support foundamental codes and tx for TCP.
>
> *fundamental*.
>
> May be just "only tx time stamping for TCP is supported..."
>
> > This approach mostly relies on existing SO_TIMESTAMPING feature, users
> > only needs to pass certain flags through bpf_setsocktopt() to a separat=
e
> > tsflags. Please see the last selftest patch in this series.
> >
> > After this series, we could step by step implement more advanced
> > functions/flags already in SO_TIMESTAMPING feature for bpf extension.
>
> Patch 1-4 and 6-11 can use an extra "bpf:" tag in the subject line. Patch=
 13
> should be "selftests/bpf:" instead of "bpf:" in the subject.
>
> Please revisit the commit messages of this patch set to check for outdate=
d
> comments from the earlier revisions. I may have missed some of them.

Roger that, sir. Thanks for your help!

>
> Overall, it looks close. I will review at your replies later.
>
> Willem, could you also take a look? Thanks.

Right, some related parts need reviews from netdev experts as well.

Willem, please help me review this when you're available. No rush :)

Thanks,
Jason

