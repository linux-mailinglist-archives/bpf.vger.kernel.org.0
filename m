Return-Path: <bpf+bounces-51638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB9A36B81
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 03:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA1188F444
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA281547E1;
	Sat, 15 Feb 2025 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDzDBRa6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC421345;
	Sat, 15 Feb 2025 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739587962; cv=none; b=TsMLi+jx60NcaqpJEvFr0FmgFCMZWPmojwK0Gq9wtgFKsh8nyELBNM3Ye7zb0hUVFXsEQ2up2CrwvBajL4OtYAJ5SUtDzSjBKMb63EjjPCyP5pmqsosYTvBVlulZPnXD4dNrr1nKczZSh3itFQfakr7N5K68As7kM+tFFQL7N44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739587962; c=relaxed/simple;
	bh=MQ/IrKKgd4ffipfPkaKh1BeYbEvV5qrKB9mEAlTHPak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcYLVsURSqoSi5A54c1IBz7kKYJFjMT4GYnPsXrpYfaOAKGS0QdgtcmACDw49XzTNRmc6OD3qDxPSNg/wyp2nVVRbjRCwOxpz7X4a7l23kdxaKHzW1EUQNDCO7FrWcWT/tbTyTgjgXEl0ojZasM25WatfqC3ePijFcH41IZirzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDzDBRa6; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso7228115ab.1;
        Fri, 14 Feb 2025 18:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739587960; x=1740192760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ/IrKKgd4ffipfPkaKh1BeYbEvV5qrKB9mEAlTHPak=;
        b=hDzDBRa6aGrtfv4QFVPFFP6XvdVjInQtwYbwPHTvxd42jgcPkT4S9fA64ZURRNn9ga
         KM6HzaBfD9GZ2cm3pD9vcdllYBBJrttbA3R3q9xkLSAiINDef2Cfd5DC4tkvK55tvdoP
         XZK7OGRQhwoqiieLx8WFd5KwkMfy+4uWhuwxdySmsuiJVViRUsK2b2zGra4CeM7B6inN
         SkpOlAVIubZNkwpI7neLuwTwxzQxXi8RmTR5nn6c2mk7dKocY86O0srrT9yIgCLz2gzQ
         w2YZI0c5xUrM+v6e29OvMeRv9B+B8u4gzHz+mpYL+Nds3tj+NRZmTeVHWw9GnGp3qQ37
         l8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739587960; x=1740192760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ/IrKKgd4ffipfPkaKh1BeYbEvV5qrKB9mEAlTHPak=;
        b=OjY0h18gy/amaIIU+u/cgXmWyUgWkMyw2h7/GnfrbUFp+6vymUuvDheoJspbHFeYvN
         V7DRw0NHdXMrxLxLneZPV00uMK3PpGZfSD8mddSNlceqhRDJE2ITmZp1QiUVfv2Hv/fh
         kcLzT0CLSwrfNb1IKIfh5wTFkhCfghAQjsjUjKJmPh14eX+Q/E/OayTQku+iNLWWqSzd
         aa4N3Mph8/4yR8uYoMaGzSYdBjNepP4BCbbfRdtai+mxGnqLUXmrTzdzZuXaL50Moz52
         X3sesKjMvQs3e/rpyiFO63dWekhOVBkV/qKAcpb5YybAGZ1GcmQ369qvxd17AWGvmPlh
         bKaw==
X-Forwarded-Encrypted: i=1; AJvYcCUNmQws6d2GNRri1JpjB6CnhCaGOszM4+37Jw78gJai2Z77bxeZDgN4Xo7XHiZHuKmKUOA=@vger.kernel.org, AJvYcCXZtHGtjSY7Tb3R3TlceDR+rIIS7PrZdCSam/kzOh/fluQjheLm8/ok0OKKdhpqtR1x0OnY6uLS@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkBQn+QNLap+L1mzsmn+vGtmmO46cr6bgiyuGNsvrQrMxg1XX
	FNb/eqEejk9WPhDSEic3lsps+0JlxxW0s8Tmala4QrPTySweXdT1Zk/+rWA/BcInraBXfnYB5xa
	JLNoMF8SxxZAML67wuUSlV4vpquo=
X-Gm-Gg: ASbGncvWeXkgDQTjNnTVGoOXDcmceoJMdD0NZqwcMmH6dWjEn9qP+BJp+i67ohyIHmE
	aDRjpaN9mx7HlOBbkMlECeRi1sbZh+w0VkQCXareln/lVWG9qHcnv4b1utM69si3eWHl8lXc=
X-Google-Smtp-Source: AGHT+IF4H3bDyU5fgnXqwsQykN661Q8XK/HSGyM0LBHS+o6Ee1VRuje2S4I3gXwFa+zHKGpCZ3twjD8iAEf49Aj0Cj4=
X-Received: by 2002:a05:6e02:1a2e:b0:3d0:47cf:869c with SMTP id
 e9e14a558f8ab-3d280949c9emr10998875ab.19.1739587960314; Fri, 14 Feb 2025
 18:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com> <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
 <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev> <CAL+tcoBAv5QuGeiGYUakhxBwVEsut7Gaa-96YOH03h57jtTVaQ@mail.gmail.com>
 <86453e67-d5dc-4565-bdd6-6383273ed819@linux.dev> <CAL+tcoApvV0vyiTKdaMWMp8F=ZWSodUg0zD+eq_F6kp=oh=hmA@mail.gmail.com>
 <b3f30f7d-e0c3-4064-b27e-6e9a18b90076@linux.dev> <CAL+tcoB2EO_FJis4wp7WkMdEZQyftwuG2X6z0UrJEFaYnSocNg@mail.gmail.com>
 <3dab11ad-5cba-486f-a429-575433a719dc@linux.dev> <CAL+tcoAhQTMBxC=qZO0NpiqRCdfGEkD7iWxSg7Odfs4eO7N_JQ@mail.gmail.com>
 <d7e21933-cd3b-43a2-9678-4f0e592ec87a@linux.dev>
In-Reply-To: <d7e21933-cd3b-43a2-9678-4f0e592ec87a@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 15 Feb 2025 10:52:04 +0800
X-Gm-Features: AWEUYZlBjo95DXXz8WloX8gf6s51YrHtT5FZ6jWNVg6dbS2YBVCCapCb-aVeBfY
Message-ID: <CAL+tcoDnS2j5nqS_BpbK8=7p8AK=-Jw7dAh3QWbstNOtQRLUyw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:39=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 2/14/25 3:53 PM, Jason Xing wrote:
> > Another related topic about rto min test, do you think it's necessary
> > to add TCP_BPF_RTO_MIN into the setget_sockopt test?
>
> hmm... not sure why it is related to the existing TCP_BPF_RTO_MIN.
> I thought this patch is adding the new TCP_RTO_MAX_MS...
>
> or you want to say, while adding a TCP_RTO_MAX_MS test, add a test for th=
e
> existing TCP_BPF_RTO_MIN also because it is missing in the setget_sockopt=
?
> iirc, I added setget_sockopt.c to test a patch that reuses the kernel
> do_*_{set,get}sockopt. Thus, it assumes the optname supports both set and=
 get.
> TCP_BPF_RTO_MIN does not support get, so I suspect setget_sockopt will no=
t be a
> good fit. They are unrelated, so I would leave it out of your patch for n=
ow.

From my perspective, rto min or max is quite similar and only related
to the time limitation of RTO, so I assume they can have the same
usage... Right, what you said is exactly what I would like to know. As
you said, handling rto min will not be included in this series.

Thanks,
Jason

