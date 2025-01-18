Return-Path: <bpf+bounces-49244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B88A15AEB
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 02:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5583A8416
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD2939AEB;
	Sat, 18 Jan 2025 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLfg3C2n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6EE136E;
	Sat, 18 Jan 2025 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164627; cv=none; b=XWmrcuW/UetxCqeFG/PQ0TWfz1gUrYKAc4HlyUWnG9tUg2la9O8iicwYvUeKGvEP+KSHmRZCvl/l/QWqrZjN7ytMo6hDiA30Fy8Zy76h/6BsjvyvqlF1GRb0abXK6kyrNDtE1tK9vBTvFpOgJRCRtapzbhcFl/4otN5ngBdfTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164627; c=relaxed/simple;
	bh=FavsH1FYpzX+sGPkI+Y2Nj0D20dMfPMCoVuzRuv5no0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErD3HMG9x/y5bI4/aA+2wVfz7vKioxed4gChrRxbTIDpjPICDCQSLwdquhGakia9K+RKUCWG+Ly9V/eM1fAXOpg/AkcYe0sdgcnIGlAz0/ZfSr2vAWRGN4E+Ka5SneeVxVo1nDdqYBHS0YqFU+fZ+eCXI3ZB9faghs/1ZPgKEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLfg3C2n; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce8a6bc715so18198245ab.2;
        Fri, 17 Jan 2025 17:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737164625; x=1737769425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oW/BfIQNINEXoPOWU/EhbMQeE1Kioc1v7RgH6djsRM=;
        b=PLfg3C2nz3JNmFjq1Otox5bh0qGOW0xafsfVG/m32fgnS6ey+X5P7AzjFE3woTL4p8
         oW+PVHXIwL3ytTZHDR6m2lVEFAwegftsrwg2Te5MThBF//ncQ15pMG7rd5117BDQuj5/
         kICX3uU2Y1p3dCADfWeklO7bBXaZEGhEA1cp1ddxVEl9wrydG07FAG5Me6jZiqQXLuPK
         70pU9184zpe/urMwLfkutxOYZU+uaukcKIreVDxZeQb2gZqndmp8TGOcgRRuYTpHGKaP
         O6gaQK8m2OqSm+KmDKqCs/6EgbUoSI8B1l7ERHgS146sJJuQAYm4Va5z1aoKxUN3mN68
         uzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737164625; x=1737769425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oW/BfIQNINEXoPOWU/EhbMQeE1Kioc1v7RgH6djsRM=;
        b=Hq8fkHQv7d8JW3imZVF4UC/FKabcAVEGQw2LipBi5kMXDx7B6z6p9ATrDmDn2+hnm6
         bv3XG0AAopGlKUP3jQJgqokKKP4llJRxxoqkKJGQGMZhE72z2eFZefkq4WKT8hNAVr9u
         stBqLd6tge1bwvSSfiQFOrb8m9lPnTNZM4CfqvR44z2VpZRpVe2YYuVrXy7Pu5FPVuDw
         LzlbeQjYIoNFoSEJntSpTuiczG1ClmDqpdYOF+lByTQCHIoXlWZgp8u2wxVarQbrxG8g
         cAAR5CElnMLLUvN+DNwGGFkVPCcEdpiHaklpc6B4QagBo6KhAYVPqDOWxKb7jyGtilWk
         oB5g==
X-Forwarded-Encrypted: i=1; AJvYcCXXOZJUibq2H/mWEE0xJvmO5zHBeX9Tdxt9uE8p7FkrjP7UdielrpzaJFcGe5qiapLAcus=@vger.kernel.org, AJvYcCXoykAZjiwQNCMQICg9+iR7T1G22tFXDhPXeGPa43AL27mNsz7b23Wql0q9I02YkRIkicT0jvnM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7o8zidZMc98DFJbhXJjlne/6OdhivKH/e1N+diJXXIvEbbn8
	Pb7xL3Ybg/fq+tVWgwRZziqD+7OB5y8GEBSDpd+wvhzlWYR5pguIUOxFgu/yuHcFYvd8VXG8ujl
	X4zDQ56SmEIfWrpGPfSZQTqAgVw8=
X-Gm-Gg: ASbGnct+Ooo69hlcZrcwR/8qP2Rx9J1W/dPYAb674/A+uVeL26pjqif3QaBizlxnQEX
	Rs5K/57hTQhC/GQS41oZpdpaxHCwZx8jhiHH8U6wk5qjs2VN7JQ==
X-Google-Smtp-Source: AGHT+IERhV8jtj0q2VkkTM0erQVbe8KKmqoDfKLUHNehwNikmWaOmUv38wjGWzyskvHQ2hf+FSMtiIbunzb+tLjM/eQ=
X-Received: by 2002:a05:6e02:1d8b:b0:3ce:78ab:dcd1 with SMTP id
 e9e14a558f8ab-3cf7449415bmr36779605ab.19.1737164625160; Fri, 17 Jan 2025
 17:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-9-kerneljasonxing@gmail.com> <ef391d15-4968-42c6-b107-cbd941d98e73@linux.dev>
 <CAL+tcoC+bXAPP94zLka5GcwbpWNQtFijxd0PcPnVrtS-F=h6vQ@mail.gmail.com> <fc4dd0d9-d4ae-4601-be01-5fad7c74e585@linux.dev>
In-Reply-To: <fc4dd0d9-d4ae-4601-be01-5fad7c74e585@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 18 Jan 2025 09:43:08 +0800
X-Gm-Features: AbW1kvYl3EMP_G-BIRtDjOgOaDN0I4S78rm4JgVEfdhBNINqa58akMYV08cdIRs
Message-ID: <CAL+tcoCJiaO4o8y56k2p8aePzkoE6SHXc7o4hEAc+D_hw7K8+A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] net-timestamp: support sw
 SCM_TSTAMP_SND for bpf extension
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

On Sat, Jan 18, 2025 at 8:47=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/15/25 3:56 PM, Jason Xing wrote:
> > On Thu, Jan 16, 2025 at 6:48=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 1/12/25 3:37 AM, Jason Xing wrote:
> >>> Support SCM_TSTAMP_SND case. Then we will get the software
> >>> timestamp when the driver is about to send the skb. Later, I
> >>> will support the hardware timestamp.
> >>
> >>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>> index 169c6d03d698..0fb31df4ed95 100644
> >>> --- a/net/core/skbuff.c
> >>> +++ b/net/core/skbuff.c
> >>> @@ -5578,6 +5578,9 @@ static void __skb_tstamp_tx_bpf(struct sk_buff =
*skb, struct sock *sk, int tstype
> >>>        case SCM_TSTAMP_SCHED:
> >>>                op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >>>                break;
> >>> +     case SCM_TSTAMP_SND:
> >>> +             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> >>
> >> For the hwtstamps case, is skb_hwtstamps(skb) set? From looking at a f=
ew
> >> drivers, it does not look like it. I don't see the hwtstamps support i=
n patch 10
> >> either. What did I miss ?
> >
> > Sorry, I missed adding a new flag, namely, BPF_SOCK_OPS_TS_HW_OPT_CB.
> > I can also skip adding that new one and rename
> > BPF_SOCK_OPS_TS_SW_OPT_CB accordingly for sw and hw cases if we
> > finally decide to use hwtstamps parameter to distinguish two different
> > cases.
>
> I think having a separate BPF_SOCK_OPS_TS_HW_OPT_CB is better considering=
 your
> earlier hwtstamps may be NULL comment. I don't see the drivers I looked a=
t
> passing NULL though but the comment of skb_tstamp_tx did say it may be NU=
LL :/

Yep, I was trying not to rely on or trust the hardware/driver's
implementation, or else it will let the bpf program fetch the software
timestamp instead of hardware timestamp which will cause unexpected
behaviour.

After re-reading this part, I reckon that using this SKBTX_IN_PROGRESS
flag is enough to recognize if we are in the hardware timestamping
generation period. I will try this one since it requires much less
modification.

>
> Regardless, afaict, skb_hwtstamps(skb) is still not set to the hwtstamps =
passed
> by the driver here. The bpf prog is supposed to directly get the hwtstamp=
s from
> the skops->skb pointer.

Right. I will init the skb_shinfo(skb)->hwtstamps first in this hw callback=
.

Thanks,
Jason

