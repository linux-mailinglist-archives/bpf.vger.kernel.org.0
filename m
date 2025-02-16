Return-Path: <bpf+bounces-51693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F58A374B9
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566E216CBDC
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2B5195985;
	Sun, 16 Feb 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJKmuzeq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3618DB2B;
	Sun, 16 Feb 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739716597; cv=none; b=GbTXgp8bkGNKHY/K5bY/UhDG7Pi59ElixPGTbcfv2wudfFXQicaVguZBXcBO3WGFXRSEbNITNle5uGAF9lxWO6Rdq3vs8i+KPmPqxqQxC5lhnGPQpLfqi6WySOPyu3te8Q4iYAbCoRls1qq6Wy6YEswSi11UdyRwQ0QEJhg6274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739716597; c=relaxed/simple;
	bh=BLRB2nv0CC2GcvM0rFvuHT5sWfq7VFeitoMFuuj92q4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DLKHypEXrCjKBSVN7uuWagNTuWem/3BnYy37HWizVJ8pHUFQ5WJYzjaUX9K9EKCDjFssLCDvAklBxJ1T7cc3IygHKmZkAPt2kHahndqcYPBHNCTzOLrVx3ESxulV2/XCU+ixEKrbhBqyUijfPqqL5/JIuW9N5o3vNEQnDrooVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJKmuzeq; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be49f6b331so354283885a.1;
        Sun, 16 Feb 2025 06:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739716593; x=1740321393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLRB2nv0CC2GcvM0rFvuHT5sWfq7VFeitoMFuuj92q4=;
        b=jJKmuzeq9jfOW4g3pmGm5eUpvFlTgb1JBt+tsjfYFc0MOgv5N9whyICRMIDwYoMo/Z
         UmrU4Y1AiGX8hkKJ9h/PJxld7cdGfnFLUzFFb/hDQ/nUnYldkLPyPZKPxqy5MWO6O4mN
         j+kwblw6E4Tpa+Uqttyn9RVprA1RXvo4AeAnB8ADpQwRm43SPzg70ErhR+r7OOgmj4Tl
         XA88RgaYXYFQznrYHsEyu26iktRZu//24MOYOGomLWS4pVgIoCUGOnXD6uNIao//Qgtu
         A5JRXdMkKxwmzUQmCCFF8GPRWSolWSCmwwOkafyjQvgkMeUXSpb8XFYG23efilWI4fTl
         WpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739716593; x=1740321393;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BLRB2nv0CC2GcvM0rFvuHT5sWfq7VFeitoMFuuj92q4=;
        b=lTbDPvPT2UlOFFnlMCQZIfDsABpOhirtSQEvgyB2UWN/zt1BxfOpvKs8VH+nbTuICF
         JRGKCMg3IUJ/g1Zj6z7LE6PwfSRTTXYkFVe5u0E0azdMqJWeYibncTaItrDN/p8sG7V0
         qLBbit7xZQeg9nepx+LdYdQX0T3T0xv+Ig6ZzTRdMX2yA7B0S/91oT+POZ3vWEUo1gVq
         9ah3fswWRe9oCMuFtaFTV6keGnRQQ6mXsL5g6CCmKQzt8BO5eGO2l4dQhfZNmQFEDgNu
         C2f+CN62GVxdXTnlRQ6DUEiwuUzpMX2yclbZRZ7rrCF9UCrpbn2BM1oSq2QRqcfSvtRv
         Xj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7CES8fwRqmIn+ECvcJzHf3mrFqlrb5GyzRcvaWa91Qk2nO5dehpoTNTrQ3G3MUvaH/t8=@vger.kernel.org, AJvYcCXQkrtZtvH8iLMui63J9xYQbIRK+Pynix0ZPQmIjmHb8KOW6+Mas+xzz5ZXWWKfBetHKZxZuMD1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GCTv2a7ndvsh0DyOceKEYLYloI+cRnfnYGnI7rPi3WAsMvWn
	BIr43Jw/knGqc8anlwVICoEV3ITGOuuUzOlVglbL8aOLAKkQ4bDF
X-Gm-Gg: ASbGncs4GpiGF+SIc49N8HwEg3AiFNEw6LWdd3hjD5kH43+8pGLcE56vX7o/xHgAiTu
	WS7fFUh4HM3tbgolpmwbxoR2UMVgoXrAQbS2QOIEZctNJUu/EcvkxU1vwn5ZYw68t3scXSa+LLn
	/ZDDTie2G3a3oR7/oOpLeebscwubxrFVwoJBuCrYvnigEwkS0AK1Nrp1wZO6ep8X7rBHsbOBjgb
	Aq9dzaFRMiEYpnMHsKdVuxkJzB8W/VQWk310Q1N7g1EmZP8b4c+rEMRUf2ydqMcru352xQxYM0j
	AC+6l5HwXe3NgGysivq1N3o4l4my9G6ocgfv5fkhM5rb3pn8Wf7793y3t9rUmBM=
X-Google-Smtp-Source: AGHT+IHp+Kno/dGJCWo1kANgiWAf9oPTTmxtDK7XpbJ2wc/4c8geKrEVDZfFvPXhIrWRBNThU8d+UQ==
X-Received: by 2002:a05:620a:372b:b0:7c0:7b2c:eede with SMTP id af79cd13be357-7c08aab46demr946806785a.54.1739716593493;
        Sun, 16 Feb 2025 06:36:33 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785cf1sm42215996d6.42.2025.02.16.06.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 06:36:32 -0800 (PST)
Date: Sun, 16 Feb 2025 09:36:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
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
Message-ID: <67b1f7f02320f_3f936429436@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDB=Vv=smpP9rUaj3tug2Vt6dQz9Ay8DRxMwAs-Q9iexg@mail.gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com>
 <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
 <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
 <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
 <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com>
 <89989129-9336-4863-a66e-e9c8adc60072@linux.dev>
 <CAL+tcoDB=Vv=smpP9rUaj3tug2Vt6dQz9Ay8DRxMwAs-Q9iexg@mail.gmail.com>
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
> On Sun, Feb 16, 2025 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >
> > On 2/15/25 2:23 PM, Jason Xing wrote:
> > > On Sun, Feb 16, 2025 at 2:08=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > >>
> > >> Jason Xing wrote:
> > >>> On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> > >>> <willemdebruijn.kernel@gmail.com> wrote:
> > >>>>
> > >>>> Jason Xing wrote:
> > >>>>> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> > >>>>>
> > >>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> > >>>>> callback will occur at the same timestamping point as the user
> > >>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> > >>>>> get the same SCM_TSTAMP_SND timestamp without modifying the
> > >>>>> user-space application.
> > >>>>>
> > >>>>> To avoid increasing the code complexity, replace SKBTX_HW_TSTAM=
P
> > >>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers=

> > >>>>> from driver side using SKBTX_HW_TSTAMP. The new definition of
> > >>>>> SKBTX_HW_TSTAMP means the combination tests of socket timestamp=
ing
> > >>>>> and bpf timestamping. After this patch, drivers can work under =
the
> > >>>>> bpf timestamping.
> > >>>>>
> > >>>>> Considering some drivers doesn't assign the skb with hardware
> > >>>>> timestamp,
> > >>>>
> > >>>> This is not for a real technical limitation, like the skb perhap=
s
> > >>>> being cloned or shared?
> > >>>
> > >>> Agreed on this point. I'm kind of familiar with I40E, so I dare t=
o say
> > >>> the reason why it doesn't assign the hwtstamp is because the skb =
will
> > >>> soon be destroyed, that is to say, it's pointless to assign the
> > >>> timestamp.
> > >>
> > >> Makes sense.
> > >>
> > >> But that does not ensure that the skb is exclusively owned. Nor th=
at
> > >> the same is true for all drivers using this API (which is not smal=
l,
> > >> but small enough to manually review if need be).
> > >>
> > >> The first two examples I happened to look at, i40e and bnx2x, both=
 use
> > >> skb_get() to get a non-exclusive skb reference for their ptp_tx_sk=
b.
> >
> > I think the existing __skb_tstamp_tx() function is also assigning to
> > skb_hwtstamps(skb). The skb may be cloned from the orig_skb first, bu=
t they
> > still share the same shinfo. My understanding is that this patch is a=
ssigning to
> > the shinfo earlier, so it should not have changed the driver's expect=
ation on
> > the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If there are =
drivers
> > assuming exclusive access to the skb_hwtstamps(skb), probably it is s=
omething
> > that needs to be addressed regardless and should not be the common ca=
se?
> =

> Right, it's also what I was trying to say but missed. Thanks for the
> supplementary info:)

That existing behavior looks dodgy then, too.

I don't have time to look into it deeply right now. But it seems to go
back all the way to the introduction of hw timestamping in commit
ac45f602ee3d in 2009.

I can see how it works in that nothing else holding a clone will
likely have a reason to touch those fields. But that does not make it
correct.

Your point that the new code is no worse than today probably is true.
But when we spot something we prefer to fix it probably. Will need a
deeper look..

