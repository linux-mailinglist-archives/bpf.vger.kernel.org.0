Return-Path: <bpf+bounces-51678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97205A37133
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 00:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8C13ACD31
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 23:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857A1FBEB0;
	Sat, 15 Feb 2025 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc1q/hGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1A4C76;
	Sat, 15 Feb 2025 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739661040; cv=none; b=HuHSDQMUKkRk7yNqsPpZx67hQBjGd9JflIKYx7auGfbdXPF/zhNLB0v5LbjD5yja2B/5UjZ4bOzf2eKitNWoEmMVF9WRNyQxhO1zq/2rtXw60y+oN0BhxV/muD3aU9J0IyQkRp75Te6Lt+R6UEIkehRDK0mUGD7G8R+RjLL53IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739661040; c=relaxed/simple;
	bh=Q+wIlnTmdGqNNGvNUFdDjBEb8y6ZnP8e3NLEzD3PYQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYT7/IisfC3Iqytbm+iu/gNRHyAUOGQUQFEMYp/oYd/lqizrDzyTdvQD7nVJfuhJpSW1P9b42FsyPk5q4byYd2f0A+WwIT+Psj397v+vhlcAeUrhbiDkbjckeVi39EOsw+4fX1L5ZfQa2Y76L9VPqdG/UwKoqTf2pa13XSK5bAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc1q/hGx; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d18f97e98aso22473445ab.3;
        Sat, 15 Feb 2025 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739661038; x=1740265838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+wIlnTmdGqNNGvNUFdDjBEb8y6ZnP8e3NLEzD3PYQA=;
        b=Gc1q/hGxNvY4l7NIeHTQ7iijE2Beo1KULytLS2z63lqFvmxRNiG2fp2HmBNlGS1vw8
         w3VbYBb1/ZlF9nUKqpov0JM/RS72aRBIxM1QXP2mwqIo/UdRH1mjLb72ZwbhYwU/ASIa
         dTAHuwNbL9DTKViErFSp89aCFzX8XIAekYN6GhZU+6YfZmbNNjWDQmgF/4/fHhJUWQeR
         uVvgWgwXHmNPeq8r71DzLJlUk/Cx/WmPnFijCr2OeBrEu0P09LKmGCQwaN/cAAe/WX5i
         4cHQ+cLeIs6s6FNTlTgdf1x2eLAm/F04S4lmeR+yFiUpa4CCAnf1yKMq7PzO8hD5Fc4r
         ScTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739661038; x=1740265838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+wIlnTmdGqNNGvNUFdDjBEb8y6ZnP8e3NLEzD3PYQA=;
        b=hTCk1g2u388SjBiwqsq8MRpvTm4kPeqFujD15/SyswAK7zTpYACRsmeqgiFLNCEMv/
         im2NvkfyIRFSjuhiTg7qWXdsPHu6233u/tNkGgarIkNuwC3Gza0FOvu1dSnh5qw4LTIy
         U7MjjRQefXP4aqoSVQ82BsVyuIs5T0reaYR3Bx/k9OlDBti1MbgA+/XLSUQ9RUFt/O+H
         RRbyHXdLls0KbnYa0cTSS4dNvyK3LFLR0nReZZzvbIn8X4rH8Mloyk7owtW47mekLfCy
         YpCX80NKWFduS8tMOTQIZjfbilZTUm/wNiZgNbjTTZxcLkDwhltAy7mL+voHez6F3ZVj
         6mVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs7noDHqfnT0+tIsnhFFcBBm7OlrbasbIWUKxU9y4/EuigE7YZkWK1lRD//iCqW5L8VkkSK8bn@vger.kernel.org, AJvYcCXMCU2mHCh3QFNODBehZimEkzzG8XzCjCfs6xLUaV8+QkbmSrMUFpZNnbAULHPvNbECOQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHHKeW230i5Sg/FLJ+HASYAFIx2w/vC7B0Abdb0LfUcpXmQAJc
	1s6MbIwRQ5hULWm0r8qv6+l2bo648heift/dW1IFaPCx1Aaurdpwfjnmo9T/8Xvb/CqkCeO5CRr
	VfObdCNHq3gbqCFlQUetIucZQffA=
X-Gm-Gg: ASbGncuxbbGDq1bgNEsH1GocDHMFHVU5YeeqpfPGag7lwDiEPA0v9DIZ77l+/BAy4Kq
	pdkl1xHX/qvptdZHkdFiPabhMuC5A17FJ+JWI8NufhUsLKqz76EraleSmHW36zcXm4xP5aiqj
X-Google-Smtp-Source: AGHT+IFSstRKrAw7h1ArkDKt0b20RPJc22x44fL7Ljckhwg0FwGeFruqAqOrozhS1DZO8xtKPxG1c7lvg2eA3HlgAcE=
X-Received: by 2002:a05:6e02:5:b0:3d0:47e3:40bb with SMTP id
 e9e14a558f8ab-3d28076c3d7mr40186955ab.4.1739661038448; Sat, 15 Feb 2025
 15:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com> <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
 <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
 <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
 <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com> <89989129-9336-4863-a66e-e9c8adc60072@linux.dev>
In-Reply-To: <89989129-9336-4863-a66e-e9c8adc60072@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Feb 2025 07:10:02 +0800
X-Gm-Features: AWEUYZkeu973ybNEc6fZKnyTugM98Nidqco8tJI8qmZ2nxfR80yHa3tVw1K_4cU
Message-ID: <CAL+tcoDB=Vv=smpP9rUaj3tug2Vt6dQz9Ay8DRxMwAs-Q9iexg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/15/25 2:23 PM, Jason Xing wrote:
> > On Sun, Feb 16, 2025 at 2:08=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> >>
> >> Jason Xing wrote:
> >>> On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> >>> <willemdebruijn.kernel@gmail.com> wrote:
> >>>>
> >>>> Jason Xing wrote:
> >>>>> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> >>>>>
> >>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> >>>>> callback will occur at the same timestamping point as the user
> >>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> >>>>> get the same SCM_TSTAMP_SND timestamp without modifying the
> >>>>> user-space application.
> >>>>>
> >>>>> To avoid increasing the code complexity, replace SKBTX_HW_TSTAMP
> >>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> >>>>> from driver side using SKBTX_HW_TSTAMP. The new definition of
> >>>>> SKBTX_HW_TSTAMP means the combination tests of socket timestamping
> >>>>> and bpf timestamping. After this patch, drivers can work under the
> >>>>> bpf timestamping.
> >>>>>
> >>>>> Considering some drivers doesn't assign the skb with hardware
> >>>>> timestamp,
> >>>>
> >>>> This is not for a real technical limitation, like the skb perhaps
> >>>> being cloned or shared?
> >>>
> >>> Agreed on this point. I'm kind of familiar with I40E, so I dare to sa=
y
> >>> the reason why it doesn't assign the hwtstamp is because the skb will
> >>> soon be destroyed, that is to say, it's pointless to assign the
> >>> timestamp.
> >>
> >> Makes sense.
> >>
> >> But that does not ensure that the skb is exclusively owned. Nor that
> >> the same is true for all drivers using this API (which is not small,
> >> but small enough to manually review if need be).
> >>
> >> The first two examples I happened to look at, i40e and bnx2x, both use
> >> skb_get() to get a non-exclusive skb reference for their ptp_tx_skb.
>
> I think the existing __skb_tstamp_tx() function is also assigning to
> skb_hwtstamps(skb). The skb may be cloned from the orig_skb first, but th=
ey
> still share the same shinfo. My understanding is that this patch is assig=
ning to
> the shinfo earlier, so it should not have changed the driver's expectatio=
n on
> the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If there are driv=
ers
> assuming exclusive access to the skb_hwtstamps(skb), probably it is somet=
hing
> that needs to be addressed regardless and should not be the common case?

Right, it's also what I was trying to say but missed. Thanks for the
supplementary info:)

Thanks,
Jason

