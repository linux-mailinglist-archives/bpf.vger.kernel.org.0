Return-Path: <bpf+bounces-51671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF15A37018
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 19:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ED2188BD5D
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE801EA7FC;
	Sat, 15 Feb 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoTpAakm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9A1EA7D1;
	Sat, 15 Feb 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739642933; cv=none; b=tQq47fEy4pFoo1rEqQkgBNxNW4LdkRz5Nm4vgM6nQSbuZkzp0gQR/2VVoC7I6GMmLkdCw1LxzT0C8Yevop9BPinx92e8MVIeth3hf3WAw5vsOJ39UtspaVRqA5pHCbM4XPsMRQg5U0wURys/2qliCy6FeXODiynqf2bIfLX2tdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739642933; c=relaxed/simple;
	bh=NccI31F7rV0WvzxZtscLcB2GnsekIpnuO9pALSe0X+4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hXbWVzrOKJt5Rn4AC7IoEp+NHqJ45Ib1Nns9fgvflEPVfjc20G0tOwjjsG2agJy+tKHxNayg6nQkEmncfc5XUzfrcIs3dK8QcsWzY77B+/DrW7GQDRHe7a1nwNmCzrvED/M5DYgJWQoLsOvM6w53LBOOl9UpTlMT2z6UTQURvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoTpAakm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471b937f2feso33864771cf.3;
        Sat, 15 Feb 2025 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739642931; x=1740247731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NccI31F7rV0WvzxZtscLcB2GnsekIpnuO9pALSe0X+4=;
        b=ZoTpAakmlV1sTA7qzC4WNP68lBe3HotAyzMrROiaNsEiViuWp7Dxo2rP2kAMcqP/RU
         IcEL5L/eVHt3RC3Con3+inecDpi3r79mfRnYA1vPDvF8Lun1un11BVMEVjOaA2ZLoIrp
         7JB84xWxI8J42rLVwP7YrGtakpKT85OVOMUdAw2zN8T+QZ0nI4RX0LmF50B/sc9OQDuD
         iCY0+nWpueWW4p/1g8uRgmEK1Afcia3ZoQB51bPrjFm8vDGEDCWXtH479ZbSOQ/uM7yC
         Qme2QVIAnTbHZRNNErexEjk5FYkc1qCf58Xv0VaFeEKx7gBm13Y4x3AL8xPlR70TTv1Z
         4WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739642931; x=1740247731;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NccI31F7rV0WvzxZtscLcB2GnsekIpnuO9pALSe0X+4=;
        b=PvahnXmQD4V/t3KdebYdrhqXDJCCfPd7VeMdr7Zmr6L9cFce3Mlth7eSKngJd0hkfw
         FdZONpPp0tWvzwP8EnETwqEuipkrsWf98CowIJ8r7dmd7V0Gphs6awnCPFxDS6mIhjPO
         +evZ7hN48IirAgNiDJBbetAgIMaU2I80Juu0UqnqPRb9QY2XtWXCS/mUjVp5QZHMg7uJ
         jQOPxNsqNSyIbY+uqLERI8TMpchBZEEfDND2kc/CcQQO9S++NXhM7BlUfnMv9OeLc6yJ
         90U5RJzBj1kLF04UrsoK8gFxE9w321fG8hNaQMgMwzEoi6UzX21ztAy+HbBmbrs2h37m
         6AEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUUz6cOEQB+E8liYmv7FYCVEwMwc+hbhBitykcY5UXS7pfkmzPMPdNOv4PI+fVNcZ3cqiQCXII@vger.kernel.org, AJvYcCVXBSCEkjcbms98Gcuga7tvQdeeQtlf8aAdg+I3JwKQqswkSmnMfMkQuljDg/R5iaCZXgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUoYeDasafv5ABMN0ItePZaNjdjARhBl9G7lJFf4KTZTX56Wy
	McuaIjoeeFk1v39DCfr6unQ4BGO/g7G2OW3cdwA+XZI6abreOZLp
X-Gm-Gg: ASbGncsdQ3N3cHwFgf07VnRpakhNkZ4EjayU+ON46kqkdZOhtRlyoaNQzo1zOspx1bw
	vz2tDSp4U9dbjFeO+rrrlqGEGrqkQMXPH37cOvv5xOfsnvJwiq5P/10crC22N9f4qA6N6+FIiFk
	RmMCq6otdwghbO/4I/YrBs5c3iCl14hXd9AP74w+t0xFwzfXCsuZ4QB9KkV/JSa4iHYo3PBxayc
	paR+bNr4G3zxiyIrMmTrtU7TDjq0Yq/FKxP7Phpqd7nsvEc915PvxIGFa6JMN8k7ENP+rQv9rXO
	2wpJvWhm6/2MDEbc6rveBcDHh8pEYnlXGnZS+RRSdRECmLSaNjcbYzFbIX6sWhE=
X-Google-Smtp-Source: AGHT+IEzCY9xHhRJZMrhMAnlYpu9+APLOeAjYNpOIm0yZiZzDSaeByeaDAfofpdNt7qAOtrFra8SkQ==
X-Received: by 2002:ac8:5d8a:0:b0:471:d742:9b4f with SMTP id d75a77b69052e-471dbd21d85mr55631581cf.21.1739642930896;
        Sat, 15 Feb 2025 10:08:50 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2b05716sm29165271cf.68.2025.02.15.10.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 10:08:50 -0800 (PST)
Date: Sat, 15 Feb 2025 13:08:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com>
 <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
 <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB
 callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > Support hw SCM_TSTAMP_SND case for bpf timestamping.
> > >
> > > Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> > > callback will occur at the same timestamping point as the user
> > > space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> > > get the same SCM_TSTAMP_SND timestamp without modifying the
> > > user-space application.
> > >
> > > To avoid increasing the code complexity, replace SKBTX_HW_TSTAMP
> > > with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> > > from driver side using SKBTX_HW_TSTAMP. The new definition of
> > > SKBTX_HW_TSTAMP means the combination tests of socket timestamping
> > > and bpf timestamping. After this patch, drivers can work under the
> > > bpf timestamping.
> > >
> > > Considering some drivers doesn't assign the skb with hardware
> > > timestamp,
> >
> > This is not for a real technical limitation, like the skb perhaps
> > being cloned or shared?
> =

> Agreed on this point. I'm kind of familiar with I40E, so I dare to say
> the reason why it doesn't assign the hwtstamp is because the skb will
> soon be destroyed, that is to say, it's pointless to assign the
> timestamp.

Makes sense.

But that does not ensure that the skb is exclusively owned. Nor that
the same is true for all drivers using this API (which is not small,
but small enough to manually review if need be).

The first two examples I happened to look at, i40e and bnx2x, both use
skb_get() to get a non-exclusive skb reference for their ptp_tx_skb.

> >
> > > this patch do the assignment and then BPF program
> > > can acquire the hwstamp from skb directly.
> >
> > If the above is not the case and it is safe to write to the skb_shinf=
o,
> > and only if respinning anyway, grammar:
> =

> From what I've known about various drivers (although very limited),
> it's safe to do the assignment.
> =

> >
> > s/doesn't/don't/
> > s/do/does/
> =

> Thanks for catching these things. If the re-spin is necessary, I will
> fix them all for sure.
> =

> Thanks,
> Jason



