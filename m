Return-Path: <bpf+bounces-51676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD035A37102
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 23:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CB816F857
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF71FCCE1;
	Sat, 15 Feb 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVWLKEAC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12FF1925B8;
	Sat, 15 Feb 2025 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739658221; cv=none; b=shL0XQw+JbE8yi41V7Y+OoJICF78B56JT+HTHpzVPh41u5Tg3EvJ52zdnHQGO0geXp4fBbo1wNf07s6Q9l2if+Hdzx1UqLyuWGftn08EDmDea1/GjhGKjhf1gy86aGVtBlnetknMKN80gDJaSmAVb1EZ3S5hg3UvpfGypqtf3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739658221; c=relaxed/simple;
	bh=WxUqXFoc0v+FC5jGbMzhQ98KcSVIEpmFgW4rdWOcGe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYn6AqhgLtQ+ivKT/vhaJ0b16npv5+CYxIKdlFj/mFXnUjjD13k9Ura5sdZ0XOQiZquit7BLH509c27VlcsA0iLhD3L6AgJmKFHvGV/m0yFjJSfEAtb3a/pnpItpvSzc5erD/yeQlRERnOm47wUKLbha+zRTjmaH81U16zea2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVWLKEAC; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8557b84dc10so21896639f.1;
        Sat, 15 Feb 2025 14:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739658219; x=1740263019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/lPm77R/VxrM1c8M3WlZWbc65YgI1L7atIsYcpj52U=;
        b=dVWLKEAC8NPj+dyhsUCQ73pgt3krlnA+V5WXjZLXlnntbfmBaoTMsXavYgL2En/09E
         J9aWmY+JzxVbKOVWeLnOlHsNe/HlKA/M4B5Esj2XtBYXcKZL5BctxNiLOlYuZv5YJ6EZ
         AGFDoZWyjEFQeiOmTrSKgYG/LApkl8EGHcNF8Efh9b3Z1/gZl8acdCg5KouuDWC6d43e
         5T436sUVE3/yb4gURQ366dDeDVvyAmTSrLaEEeYLIjI7CGUhgFzb5hmOeZNMA3kONvqi
         fbRBnKGNZpQMdop6sUMOI4hbiYfcwUcOKS/o5xTqky9ZqBtSSU1URVaO3q9UBbfgBkx9
         6hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739658219; x=1740263019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/lPm77R/VxrM1c8M3WlZWbc65YgI1L7atIsYcpj52U=;
        b=o6DNgKz6JlqmcMKWTHWudYmwhMsql/QGbouZ7SO1/fKSFUlbMhwqIyJxIr5W/GU5na
         cnFRdn8OeAuq5LGP64+Z3+TmU9TOjB/1CE2JYjOmyHgndlfGvhtW3V7a9DZyIkK9zr06
         joiAhln+XU1Z+SGf0lz7e7BxevthVPUpVbpLeHWHZq/w3RmgzVLR28w1u58qR4AbaKam
         SNdKshohDr+BY6xpCrfab1Dr06crMZxT4101a7/BmomiF5dKq6H6cPxviuYB513Iou0D
         SKtby3+fzXaRqmJTRdS/gE1wh3C7w9sSPxkZPq/jL4zcrjiJZBDnjJ+OlFtMWaMg5IlY
         tBOg==
X-Forwarded-Encrypted: i=1; AJvYcCVecuxnbmSLQrnSXGinLwDkBSAQjcmNcwW+VW+EtPM5Qo/Iz1evAQ9sEyKrxYqEZH7zMpU=@vger.kernel.org, AJvYcCWg/fBswwsKGJdMCcQUJJlDaGN1Q/1KdP2TRxfh2ZU7TMDWyL3Zb/ltPkYu6J6Mmt0jsv+zjBq7@vger.kernel.org
X-Gm-Message-State: AOJu0YwqB4BQq91ArNrP5XJJEPI5tozwo83yu+f1U5KREJCLrqIECDmr
	oYK9SSbwp4he795QofOduPvEpA7Qnmi3GW7gSEQOh9khQvpkVkz2ZGbLGzzM2owzVsb5kjPBcW6
	ZlId6qq5DKRJPPVxtCho7ty/oKnI=
X-Gm-Gg: ASbGncvRhw8OmF3Tq5ZF0bGknBxMx/8cuPEQvcoODRJC5wesPNSAEZ3+u/wAtluRbdL
	52QiZBF3T9TzyUGRfJCi17GDw6aOgLAGQxBIDxFMR9RJrq+9AmWJIhQhCOk6agdKIgnb0bPtR
X-Google-Smtp-Source: AGHT+IEG6WiZeqTB/VkXTeCe5DR049y0rdhxfP0hnEReN5jxcIDxZsMHzJaz+Q/olHrpKMlKM2/YQJgNV2ex6uWnAG4=
X-Received: by 2002:a92:cd82:0:b0:3cf:b3ab:584d with SMTP id
 e9e14a558f8ab-3d2809209f9mr26917055ab.13.1739658218945; Sat, 15 Feb 2025
 14:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com> <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
 <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com> <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Feb 2025 06:23:02 +0800
X-Gm-Features: AWEUYZnzV2CHt7W5X-S41Mq4YhU7IR7IqMMDALJfUqtznIK-h927nZa6wcNyF9M
Message-ID: <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 2:08=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > Support hw SCM_TSTAMP_SND case for bpf timestamping.
> > > >
> > > > Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> > > > callback will occur at the same timestamping point as the user
> > > > space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> > > > get the same SCM_TSTAMP_SND timestamp without modifying the
> > > > user-space application.
> > > >
> > > > To avoid increasing the code complexity, replace SKBTX_HW_TSTAMP
> > > > with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> > > > from driver side using SKBTX_HW_TSTAMP. The new definition of
> > > > SKBTX_HW_TSTAMP means the combination tests of socket timestamping
> > > > and bpf timestamping. After this patch, drivers can work under the
> > > > bpf timestamping.
> > > >
> > > > Considering some drivers doesn't assign the skb with hardware
> > > > timestamp,
> > >
> > > This is not for a real technical limitation, like the skb perhaps
> > > being cloned or shared?
> >
> > Agreed on this point. I'm kind of familiar with I40E, so I dare to say
> > the reason why it doesn't assign the hwtstamp is because the skb will
> > soon be destroyed, that is to say, it's pointless to assign the
> > timestamp.
>
> Makes sense.
>
> But that does not ensure that the skb is exclusively owned. Nor that
> the same is true for all drivers using this API (which is not small,
> but small enough to manually review if need be).
>
> The first two examples I happened to look at, i40e and bnx2x, both use
> skb_get() to get a non-exclusive skb reference for their ptp_tx_skb.

Right. i40e uses skb_get() in i40e_tsyn() introduced by commit
beb0dff1251d. bnx2x uses it in bnx2x_start_xmit() introduced by commit
eeed018cbfa3.

Here are all the drivers listed to be reviewed:
1. drivers/net/ethernet/amd/xgbe/xgbe-drv.c
It uses skb_get() in xgbe_prep_tx_tstamp().

2. drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
Please see aq_ptp_xmit()->__aq_ptp_skb_put(). Every skb enqueued into
ring->buff will be 'skb_get()' here.

3. drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
In this case, I cannot see the skb is 'skb_get()' before bnxt_tx_ts_cmp().
bnxt_start_xmit()
    -> tx_buf->skb =3D skb;

I stopped here and found out about this special case and then pondered
over this point.

Willem, does this mean that we are unable to safely modify the field
in skb? I'm afraid not. Sorry for my limited knowledge about drivers
here... I feel skb_get() cannot be used to know if the skb is safely
accessed. Because, let me put in this way, if skb passed to
skb_tstamp_tx() can be destroyed in the meantime, that means skb in
skb_tstamp_tx() is not safe anymore, which also means all readers
accessing this skb are not safe anymore. Based on the analysis, I
think accessing the skb by BPF program is safe.

Thanks,
Jason

>
> > >
> > > > this patch do the assignment and then BPF program
> > > > can acquire the hwstamp from skb directly.
> > >
> > > If the above is not the case and it is safe to write to the skb_shinf=
o,
> > > and only if respinning anyway, grammar:
> >
> > From what I've known about various drivers (although very limited),
> > it's safe to do the assignment.
> >
> > >
> > > s/doesn't/don't/
> > > s/do/does/
> >
> > Thanks for catching these things. If the re-spin is necessary, I will
> > fix them all for sure.
> >
> > Thanks,
> > Jason
>
>

