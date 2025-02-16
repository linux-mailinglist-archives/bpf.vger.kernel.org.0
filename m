Return-Path: <bpf+bounces-51698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1CDA375A4
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8ED165998
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F24199E84;
	Sun, 16 Feb 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfj/zacb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0681F5FD;
	Sun, 16 Feb 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722685; cv=none; b=HcsYC93T+BgmVh+k/uoN7NGVqhf5Cy0HQPx6MqaSiZbSMDbG6vpSm0ezR+T2hyHJxmJZJyvuA2K1coroJ6l73UtZ99OchGTZPApZPq4EpXaPtfMV2scuGFuHRCYVk/7ON20xotxmBOta5tiOjoMXdhD/Gk27P51uqBDGvKsvH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722685; c=relaxed/simple;
	bh=8HNdzO7KYNn91p/69IUYlcB0XbWidQno9Hua5EF5k2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzwyqTfZClSiNTQEN0jhqPHd/kChT9hlcpFPfdut7tQGoaOxIxtecGwUubKsPO/JNMiJUUJncazrpv1i48VnqG6POAmjUkw69dV1PwdFmAu6hyp+3IVNoJXAwAVisLkf7w+kVuZzcfjvr/qL7kS4ZFcqAqTvi/lmWFA5mdtpB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfj/zacb; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cfc8772469so11659205ab.3;
        Sun, 16 Feb 2025 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739722683; x=1740327483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HNdzO7KYNn91p/69IUYlcB0XbWidQno9Hua5EF5k2o=;
        b=Wfj/zacbFcDh16t3QTZPg1tl2/Q7Vzx0OEqqCKGrA57mJ7IrXqIxdhVnj5VRos5dSJ
         iD+LqsVEi0oPd6JsP2ZUFGuafr+9rgbtCCi4iFcf3kseabcvKBO0AUa5QP7Imx5yi9YR
         LWyjj/ljy1qrxHzCDkSpQJpzGwIMpGUfChB9ig0eOkohM2oNbEIcjLzfDBtYT1Zkpj+j
         XcFZ5wahui8ep4661VVjJ0y6bhmCkKIemzLIGog8y7v3tq3umUAU9PQNCR6Qm4Co2c6g
         rAUoZwYJz8fLF19CuK+UGtklyhZtJfWWXMoGaJwxv2Q4zLv4rpxbiphnuk0wo+Ts19m7
         uPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722683; x=1740327483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HNdzO7KYNn91p/69IUYlcB0XbWidQno9Hua5EF5k2o=;
        b=uSfRQbllFFsFNokUVISRw2onu50vKfyelisRuTeuMx2Bp6Dav6g9/KzsLqYxTX9CvB
         c5evjDIZXXqTgxkywO3IHeubWTAt3KYvWstmFVuVLRfZ1nm4e67SR+KamJgyU3T5DOIz
         dKDs9O0OPPGA1H2Umo0EgYb0ovbUVIhsMAMpGhULfPHOCVWg5I002sgUICfz6kqovR8n
         20gCByedO2Whg0o90YEL/2mTEFV8fWnHak3UEd3y0zbArdKFl+d1SUxTnalJVZ/OPpTn
         a1l11fjYwyEYdE2aDwZyR8cM18k5umVxr7BX/S7wYk08DOtwj9c7D/F1xKUUD+qtUmgp
         FUYw==
X-Forwarded-Encrypted: i=1; AJvYcCVT3e7ZBeuDI+TKVH/bZQBsFdJ0vDbYaH8kzFpMLrkTBypUaHX9ct3dljonbPg77Mpt3RM=@vger.kernel.org, AJvYcCXVhBu3Mom2CYCgBV/QwdjX9BN1asQm7RY86kWPs55WLGwXe6AMzQHsP2UO+peomDwQCcONbtFk@vger.kernel.org
X-Gm-Message-State: AOJu0YxVr6HQ+Yxgfx6iFVgQgfOIO8SmV7h+oHecIawasbVqPWq0IdsP
	0Zo7qqq/ETLqJwaJPVhqymv/Fv26EFi+CzT6Q93Kko8PfLGojhJhAqEXQoazbbCOXYbvzHdDjnp
	FBeAV54Tbch8V16iiv47RgdL+5Qc=
X-Gm-Gg: ASbGncutikqGGuCmbB2tTqHQJyjRbZIgnKm75CE/cCVUVdBXQk4hpUSlvEpYhkMBccd
	Nj5bQjsZ1LHwOXEBNMVUeh3Td3G3TGFEhhXkDxsTzopLH98ndg+6PVD/B5wJwJIQJezmc0j+w
X-Google-Smtp-Source: AGHT+IGxR6XaufIYTxCNlE+MQxXef8enf81gXJGWnkLuk7hW8izL/Tv/oy8s2Pys6hiuk6PUjOamUWUEq/xNWjnQtPs=
X-Received: by 2002:a05:6e02:2610:b0:3d1:78f1:8a86 with SMTP id
 e9e14a558f8ab-3d2809471f1mr53842985ab.15.1739722682966; Sun, 16 Feb 2025
 08:18:02 -0800 (PST)
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
 <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com>
 <89989129-9336-4863-a66e-e9c8adc60072@linux.dev> <CAL+tcoDB=Vv=smpP9rUaj3tug2Vt6dQz9Ay8DRxMwAs-Q9iexg@mail.gmail.com>
 <67b1f7f02320f_3f936429436@willemb.c.googlers.com.notmuch>
 <CAL+tcoCWmzFvz=GtbmfVoDwacTDXi2XeHt-Fc10rxc5S2WMN_Q@mail.gmail.com> <CAL+tcoAjdaBPZE96T=YrgtZVUZNTmFpXr8C2+iVXLSZKB+01cA@mail.gmail.com>
In-Reply-To: <CAL+tcoAjdaBPZE96T=YrgtZVUZNTmFpXr8C2+iVXLSZKB+01cA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Feb 2025 00:17:26 +0800
X-Gm-Features: AWEUYZk_LAj-Hb-PomSVUiMPYjcdlGluRTHtf1YPcbSR9TTgwTQsO8Ol_alQpS0
Message-ID: <CAL+tcoCSrhnO9eNM6X54MHvVi7=p9gkWTLGQVHz9OD+r39+2eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 10:48=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Sun, Feb 16, 2025 at 10:45=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 10:36=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Sun, Feb 16, 2025 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > > > >
> > > > > On 2/15/25 2:23 PM, Jason Xing wrote:
> > > > > > On Sun, Feb 16, 2025 at 2:08=E2=80=AFAM Willem de Bruijn
> > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >>
> > > > > >> Jason Xing wrote:
> > > > > >>> On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> > > > > >>> <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >>>>
> > > > > >>>> Jason Xing wrote:
> > > > > >>>>> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> > > > > >>>>>
> > > > > >>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. Thi=
s
> > > > > >>>>> callback will occur at the same timestamping point as the u=
ser
> > > > > >>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use it=
 to
> > > > > >>>>> get the same SCM_TSTAMP_SND timestamp without modifying the
> > > > > >>>>> user-space application.
> > > > > >>>>>
> > > > > >>>>> To avoid increasing the code complexity, replace SKBTX_HW_T=
STAMP
> > > > > >>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous cal=
lers
> > > > > >>>>> from driver side using SKBTX_HW_TSTAMP. The new definition =
of
> > > > > >>>>> SKBTX_HW_TSTAMP means the combination tests of socket times=
tamping
> > > > > >>>>> and bpf timestamping. After this patch, drivers can work un=
der the
> > > > > >>>>> bpf timestamping.
> > > > > >>>>>
> > > > > >>>>> Considering some drivers doesn't assign the skb with hardwa=
re
> > > > > >>>>> timestamp,
> > > > > >>>>
> > > > > >>>> This is not for a real technical limitation, like the skb pe=
rhaps
> > > > > >>>> being cloned or shared?
> > > > > >>>
> > > > > >>> Agreed on this point. I'm kind of familiar with I40E, so I da=
re to say
> > > > > >>> the reason why it doesn't assign the hwtstamp is because the =
skb will
> > > > > >>> soon be destroyed, that is to say, it's pointless to assign t=
he
> > > > > >>> timestamp.
> > > > > >>
> > > > > >> Makes sense.
> > > > > >>
> > > > > >> But that does not ensure that the skb is exclusively owned. No=
r that
> > > > > >> the same is true for all drivers using this API (which is not =
small,
> > > > > >> but small enough to manually review if need be).
> > > > > >>
> > > > > >> The first two examples I happened to look at, i40e and bnx2x, =
both use
> > > > > >> skb_get() to get a non-exclusive skb reference for their ptp_t=
x_skb.
> > > > >
> > > > > I think the existing __skb_tstamp_tx() function is also assigning=
 to
> > > > > skb_hwtstamps(skb). The skb may be cloned from the orig_skb first=
, but they
> > > > > still share the same shinfo. My understanding is that this patch =
is assigning to
> > > > > the shinfo earlier, so it should not have changed the driver's ex=
pectation on
> > > > > the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If there =
are drivers
> > > > > assuming exclusive access to the skb_hwtstamps(skb), probably it =
is something
> > > > > that needs to be addressed regardless and should not be the commo=
n case?
> > > >
> > > > Right, it's also what I was trying to say but missed. Thanks for th=
e
> > > > supplementary info:)
> > >
> > > That existing behavior looks dodgy then, too.
> > >
> > > I don't have time to look into it deeply right now. But it seems to g=
o
> > > back all the way to the introduction of hw timestamping in commit
> > > ac45f602ee3d in 2009.
> >
> > Right. And hardware timestamping has been used for many years, I presum=
e.
> >
> > >
> > > I can see how it works in that nothing else holding a clone will
> > > likely have a reason to touch those fields. But that does not make it
> > > correct.
> > >
> > > Your point that the new code is no worse than today probably is true.
> >
> > Right.
> >
> > > But when we spot something we prefer to fix it probably. Will need a
> > > deeper look..
> >
> > Got it. I added it to my to-do list. If you don't mind, I plan to take
> > a deep look in March and then get back to you because recently I'm
> > occupied by many things. I need to study some of the drivers that
> > don't use skb_get() there.

One more thing I'd like to mention here is if this is real bug, I
think we should fix in the driver side since __skb_tstamp_tx() will
always clone the skb when tsflag doesn't include
SOF_TIMESTAMPING_OPT_TSONLY. We cannot force every application to add
SOF_TIMESTAMPING_OPT_TSONLY option to prevent such an 'issue'
happening.

Let me set those special drivers as examples, if the skb can be
destroyed in __skb_tstamp_tx() , it means the skb staying in the
driver can be destroyed at any time before entering __skb_tstamp_tx().
Then we may conclude that the skb cannot be accessed safely as long as
without skb_get() protection. Technically speaking, It's a driver side
issue, not socket/bpf timestamping feature.

The same resolution applies for bpf timestamping as well. So I feel
this point would not block this series from being merged?

My instinct tells me it can not be a problem because it was added in
2009. Sorry that I'm unable to persuade you through theory for now.

Thanks,
Jason

