Return-Path: <bpf+bounces-42116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3835999FD62
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 02:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F761C2149F
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 00:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6BD1E4A6;
	Wed, 16 Oct 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1wBhvVF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037A4C98;
	Wed, 16 Oct 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039819; cv=none; b=W7y+iwAh0RcdzQSAn+jDLftbdFS//8jgDwU3Kju53ZzuAvqkh1aD/178EGaKGCmXPnfYFkqdcNBBQiBzTj/SJ7+4eo46j2mjfAFjJCYV11gAEhsL7bjgWyGpOa3BnlDCxlMBDxSvchNnivo2rx1NArkTF7yIjpHuPQVuBYRp6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039819; c=relaxed/simple;
	bh=O3NNg/PzOG51Ln5PrCGURwmsxk/4+4xtr1GKlqdQbbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra+1qjbFnHG23Wm7ULaMC+nlt+jCvK84ff/lWiwtITupN0TgzPRAiO50mmdcCOPyUucORDXwqqJjooNRXeJfMG433WR6bthS6YMBdL/j6njyQfirA0IRZ6M6HedAGYB+wjtIk0elC0cgjaOJSdu8vZv8eeZkLacmDcBXrYwFF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1wBhvVF; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a39f73a2c7so22903435ab.0;
        Tue, 15 Oct 2024 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729039815; x=1729644615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eCEBFAX2TPTuZalR/ShAGJfx+bHE9c+qeKvlCzy+OY=;
        b=Q1wBhvVFW3GLMExwT4JuksZKaIkR26wD+zvZfh50MgEClP2ae8R78TAMUqM03SmD36
         s+56hyWdFrctUstlRAhUVGckv2yKMCcKhDoaer/HD18usx8WydtV7fzovRPq5ZOX4UhE
         UiAx7pE609ng7f6MCFxaee0rKhqgf8ajjmz3aisAdAoolhs+pOsc5pM2uiZek/FN2zdP
         HCg8+GAqVdl9ayXWiiW3gpOJr4I1a+H4FkgGxTj8b3IX/am3fI/qlU+NT9cRe4uBTaAA
         /qzVlPKvoCD1kPpizEITBrhQFZ/+g+A9AxoxZSgZllwhvu4SMiQKqEoFlsbqsvuUlLtU
         T9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729039815; x=1729644615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eCEBFAX2TPTuZalR/ShAGJfx+bHE9c+qeKvlCzy+OY=;
        b=VX3c2L5wh5v805UBVJxI6tkKWjpRnLkVjDFMMMX7Q4QoDddPbeJCZOblMo3wmimLMc
         rd9361IhgpnkdzXY+27xIsAZlOi2qLIyP8plO9tIjVQ52pDep2DOXmohWyxgpy4IKqXS
         WzLQI/BJ6T9NMq5s6lQXi25tS3WRLxMrS0GZDi8eiOhMDK6KujRXrdf2XmMJmd5/3K9m
         2epqil/d/x5fdBcDqh+MviPMjxlHxOqESfyg4K3C8SP49EIL1KKghzWZPlanAdqEUK19
         +8gvpQBXcDdr0mgxvRMJ70GzSttOlmv4VckCGGCBqlGghtrUCAPE30RcDMfOsMjEDNyx
         e2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVPFSeL0ZZaCmDLrQ9xMZGSOkYHBl4QKeQX5L6D0dmE8QoJKWmBi3chLIm6WDCoryDjr8x/stAq@vger.kernel.org, AJvYcCVxj4G3A0MPu4sSNH5qxZZggy9brd+M+6CMC2kj3bhap2qqHDW9kbs6oF9lKt6vqCvf84M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQT72zqgoaTxo9AfCTDC2BfJ7wISPX82l45q5ghFg9KO0CZSv
	HN5hy37lSJPBponJVQBTrT3Wx1leSRxulosWt5As0aAFv/F7jELZTwkBm4COwheeyK2Lp7odGXv
	+OjISeDM5a83+CD/RMOiQk8YdZYE=
X-Google-Smtp-Source: AGHT+IHujDvH3avimFT6nNSasbCYaFKyJ5N8Gl6iOdtBE0j63lGo27frpflYVqywVH4vRkyazDiAOO5zqQFr/gSFfUE=
X-Received: by 2002:a05:6e02:168e:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a3b5f6b26bmr151370705ab.10.1729039815366; Tue, 15 Oct 2024
 17:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com> <93fe5cf0-1e22-4036-a6da-b39e0046e16c@linux.dev>
In-Reply-To: <93fe5cf0-1e22-4036-a6da-b39e0046e16c@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 08:49:38 +0800
Message-ID: <CAL+tcoDe7+wMk-LD-m2MLOzMcN8vQdVoL2s03fL5X5QJjOLo=g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for bpf_setsockopt
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 7:54=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/11/24 9:06 PM, Jason Xing wrote:
> > +static int bpf_sock_set_timestamping(struct sock *sk,
> > +                                  struct so_timestamping *timestamping=
)
> > +{
> > +     u32 flags =3D timestamping->flags;
> > +
> > +     if (flags & ~SOF_TIMESTAMPING_MASK)
> > +             return -EINVAL;
> > +
> > +     if (!(flags & (SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SO=
FTWARE |
> > +           SOF_TIMESTAMPING_TX_ACK)))
>
> hmm... Does it mean at least one of the bit must be set and cannot be com=
pletely
> cleared once it has been set before?

Yes. Because in the current BPF extension feature I don't support all
the original SO_TIMESTAMPING flags (SOF_TIMESTAMPING_*) . When it
comes to clearing flags, I cannot find a proper time/chance to clear
them. That's the reason why I don't implement it.

