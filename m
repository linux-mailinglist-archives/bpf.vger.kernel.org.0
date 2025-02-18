Return-Path: <bpf+bounces-51779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B7AA3900D
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 01:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD9E7A2D22
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 00:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87B1D554;
	Tue, 18 Feb 2025 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj64oeHc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A2C8EB;
	Tue, 18 Feb 2025 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840143; cv=none; b=sWTai7FHH5Z2xO1j//GlV9CpHbGOMnqm136Njh6Bn2+MHrk7q+BUenpziWvtajAqFuY3vLkbc9UcWETBA7oF47cWxvXm2YXaQdwZLlGMKXqbKobY3L+t3TxIRgKIexF0H1myeEvQ+UlGD1uh4xAEL89scX6tLeTS1Nj5lQgaGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840143; c=relaxed/simple;
	bh=v7JweXGcUAvEhBc3So3CIVKPw9foZH3LplK2/v0UvmU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CoPGSg9LWsinZ2V2BdKLOmHh4YQ4yzc2viKFA8a46ZFeSiBcufi+BmsTyrxEjRaB1LVr0xHN5LDjYjNJrMpJveOnzmnroI4qRALxut2Uk2CG0M5n6oC045BVoQzolMSSpU7u4kHOA2cer4uoSdqTDo4qqvVZHj1hqzFlqVlgaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj64oeHc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c081915cf3so21839085a.1;
        Mon, 17 Feb 2025 16:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739840140; x=1740444940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRB4QBCBpfFopy2XrFRy9ooLzTy8WDbnYonaIdzEX2w=;
        b=mj64oeHc4Zi4DQNo9Znue2dzVEnSyCd1EDjt43t3TmCjDtlQL+IV43IMxoo58uVkjP
         Opju7r6xWyJHqJSK7/O6HUfdsxpog6wZfHTzvecg8deif2oqUcVFkPHRsRVKbao02K+/
         vUpN3remxFBTzHPfZj7hYwb9vOTYcRZwbleC6eVq4t/sHim5wVOe2v6p44KY0aDVJN2G
         f59lbO1gVAfDgruVHzZMPWdSy/0D+L9wrjj5stO39AhVvMk6hzGfSa7Qq+w6SbzEW8ye
         08EKQkG8yWr3AqnqBSR6Ji4JXfdufnzX8Ziwyppoe07mht0Y+znxPxYJ8aIctkbex1a+
         qZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739840140; x=1740444940;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vRB4QBCBpfFopy2XrFRy9ooLzTy8WDbnYonaIdzEX2w=;
        b=SYIVjrX0YhGiwuL+a3avPnb+nO+dAJln9TiVbplVla5jSaM5fKx6GlZE/wz0xLvkwr
         grI+A6z6P2fOY5Q6ZOlb7BMKV6zl4sobyhhJC2wZL08Jr+m1uZNqe44CtfOKPMYKB5KG
         ozCAs8KM8X3FzqyKtg+8Tmj9BZ5RcHFJ9YCYSha1BfUBk/52coSv67v2WqgdytA1EOO0
         M5TCJ6A1jNKqB9DoRl6FWqRRA+H+4rYraA13amL/zzxoqrssRsvi2QOfqjlytOGKUAgX
         tSmKUknymgW9JJA/tu2LWSbTN5ecdFwCljirb0hfSWcDwIQi82jbaeDhx86E8xB3eN7a
         hPcA==
X-Forwarded-Encrypted: i=1; AJvYcCV5qN1tMHNA34mhlQRkeD4+zr9f6EZQat/E3o6g8kXBl5TOinvfEflsduwb9Qzbvxu7dnxto0t9@vger.kernel.org, AJvYcCXi18+b/Pa/+qPWaZwGZ3isKhbcpNa4MBtehWTCIhYD+UA11tb9Il1Lc3clTNbyUvvKeWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8as1WrxseWxtauvc8ki1cTzDtI19cnHvkD457fB6rs8Jtkum0
	bhPhc6GiFtYb+0V2tPR91MSA2TSuSy17vB9yYx2XFOUZd7TJOhLVnMO7jg==
X-Gm-Gg: ASbGncuXVqfOKohMd04OXdolXDKQzsMEzZU1LOHb1OJ3E4cunSSKyiUA6uEzUVhcgV1
	hc3kPNbXEUiTJEmLvQ+MPbauWmCddZOvnprQQAiLbLoYd6ZuwuydZ3y5xnoYgmIk758ylkKAk4j
	riqSsKiewvg+YsyDkTTqrVMsZBTLVgyvUW7Io0Rf4hGWN+WWDWqun/RFrcDtfhB73QCeV7vKDZa
	WvWSeoZhlW2hJVzjGxSAcc974r0IAMbM+EEesiwAa7KglC00a82nk8DXj5AVZYMRe6eoBP7ZY4/
	C7UTOkVQQ264tLQUSy4fr7wKGCvCMekuJ35AkDGsvtZm/o6oC3LSClcIYfw9bpc=
X-Google-Smtp-Source: AGHT+IG3Vav8gXXJu3BLwFWpmBo+VGwPm6OadL+SaldebSCH+tqGWfmFcbkD0APW5Io9KNL6nl7aZA==
X-Received: by 2002:a05:620a:444c:b0:7c0:a7aa:58b0 with SMTP id af79cd13be357-7c0a7aa6015mr375731185a.15.1739840139559;
        Mon, 17 Feb 2025 16:55:39 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ade609easm18088285a.69.2025.02.17.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 16:55:38 -0800 (PST)
Date: Mon, 17 Feb 2025 19:55:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
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
Message-ID: <67b3da89bc6c7_c0e25294cb@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b1f7f02320f_3f936429436@willemb.c.googlers.com.notmuch>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com>
 <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
 <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
 <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
 <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com>
 <89989129-9336-4863-a66e-e9c8adc60072@linux.dev>
 <CAL+tcoDB=Vv=smpP9rUaj3tug2Vt6dQz9Ay8DRxMwAs-Q9iexg@mail.gmail.com>
 <67b1f7f02320f_3f936429436@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Jason Xing wrote:
> > On Sun, Feb 16, 2025 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> > >
> > > On 2/15/25 2:23 PM, Jason Xing wrote:
> > > > On Sun, Feb 16, 2025 at 2:08=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >>
> > > >> Jason Xing wrote:
> > > >>> On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> > > >>> <willemdebruijn.kernel@gmail.com> wrote:
> > > >>>>
> > > >>>> Jason Xing wrote:
> > > >>>>> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> > > >>>>>
> > > >>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> > > >>>>> callback will occur at the same timestamping point as the use=
r
> > > >>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use it t=
o
> > > >>>>> get the same SCM_TSTAMP_SND timestamp without modifying the
> > > >>>>> user-space application.
> > > >>>>>
> > > >>>>> To avoid increasing the code complexity, replace SKBTX_HW_TST=
AMP
> > > >>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous calle=
rs
> > > >>>>> from driver side using SKBTX_HW_TSTAMP. The new definition of=

> > > >>>>> SKBTX_HW_TSTAMP means the combination tests of socket timesta=
mping
> > > >>>>> and bpf timestamping. After this patch, drivers can work unde=
r the
> > > >>>>> bpf timestamping.
> > > >>>>>
> > > >>>>> Considering some drivers doesn't assign the skb with hardware=

> > > >>>>> timestamp,
> > > >>>>
> > > >>>> This is not for a real technical limitation, like the skb perh=
aps
> > > >>>> being cloned or shared?
> > > >>>
> > > >>> Agreed on this point. I'm kind of familiar with I40E, so I dare=
 to say
> > > >>> the reason why it doesn't assign the hwtstamp is because the sk=
b will
> > > >>> soon be destroyed, that is to say, it's pointless to assign the=

> > > >>> timestamp.
> > > >>
> > > >> Makes sense.
> > > >>
> > > >> But that does not ensure that the skb is exclusively owned. Nor =
that
> > > >> the same is true for all drivers using this API (which is not sm=
all,
> > > >> but small enough to manually review if need be).
> > > >>
> > > >> The first two examples I happened to look at, i40e and bnx2x, bo=
th use
> > > >> skb_get() to get a non-exclusive skb reference for their ptp_tx_=
skb.
> > >
> > > I think the existing __skb_tstamp_tx() function is also assigning t=
o
> > > skb_hwtstamps(skb). The skb may be cloned from the orig_skb first, =
but they
> > > still share the same shinfo. My understanding is that this patch is=
 assigning to
> > > the shinfo earlier, so it should not have changed the driver's expe=
ctation on
> > > the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If there ar=
e drivers
> > > assuming exclusive access to the skb_hwtstamps(skb), probably it is=
 something
> > > that needs to be addressed regardless and should not be the common =
case?
> > =

> > Right, it's also what I was trying to say but missed. Thanks for the
> > supplementary info:)
> =

> That existing behavior looks dodgy then, too.
> =

> I don't have time to look into it deeply right now. But it seems to go
> back all the way to the introduction of hw timestamping in commit
> ac45f602ee3d in 2009.
> =

> I can see how it works in that nothing else holding a clone will
> likely have a reason to touch those fields. But that does not make it
> correct.
> =

> Your point that the new code is no worse than today probably is true.
> But when we spot something we prefer to fix it probably. Will need a
> deeper look..

The original commit explains the rationale. It is as I expected: the
field is newly introduced and for every skb it is therefore known that
no other path exists that touches that field.

"
    The new semantic for hardware/software time stamping around
    ndo_start_xmit() is based on two assumptions about existing
    network device drivers which don't support hardware time
    stamping and know nothing about it:
     - they leave the new skb_shared_tx unmodified
     - the keep the connection to the originating socket in skb->sk
       alive, i.e., don't call skb_orphan()
    =

    Given that skb_shared_tx is new, the first assumption is safe.
"

I'm not aware of us relying on such soft assurances for other fields
in skb_shared_info wrt accessing while cloned. But we can assume it
out of scope for this series.=

