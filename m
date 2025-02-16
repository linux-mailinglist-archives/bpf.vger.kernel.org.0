Return-Path: <bpf+bounces-51695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FFA374DA
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 15:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC311886AB4
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BB4195B1A;
	Sun, 16 Feb 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6I4ikH0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1653A7;
	Sun, 16 Feb 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739717345; cv=none; b=tCicYJdkMeyjPHMHGxLI+hCm45bcCzsYoORoJTDrRrFQF2pFWjmveV2b66DCr6LiJ2bRz7JUoszulCj8ty1IojWgNyvU0ZKYaAIQ1UzuzaAEf+1w1OZ3vFbe/ysWf3sVsjr8aFZQQECbY96DozAilQeG3JgoEz6vWljGt4HgCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739717345; c=relaxed/simple;
	bh=v541oYN4LKXknEHBVuJVfB05L2eJ4A19Ug3V3oUP4dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cc7ZufJOr7U8a4qXr9qHKgdo1wjTOoTh14jXfAsbkPtw+7CMXlxrn2wuxIsavK0rUEv7y9Gs7862JA72yvjC5I2WE0FFQJLfaTKIEgZcLCKloShd4rSEcq9POS0lrbjETrTiayOEzz5GylAhxrfouuJ7Oo58ex7aAsHuBOMXGZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6I4ikH0; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8558229e184so13307539f.3;
        Sun, 16 Feb 2025 06:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739717343; x=1740322143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v541oYN4LKXknEHBVuJVfB05L2eJ4A19Ug3V3oUP4dA=;
        b=R6I4ikH0i7QK0/gmKmNwTK0hvs1MjklRHY3tUtalIWNiecVMAgIfTk7jwKWsVmblln
         9i9BvsfCeh+5gdGCsJnUrFEbGzmtzG3eF4V1jP8J9sFvmSzXZUYFcmPEH9vMPn6eMDZe
         cIieIzwgP6cD20MXdKoDgILz5q9RF53wjc0KDoA8tdNJoYRwi46Mf+6XjR/PjTr3dgTc
         ZgmM7fp00degHX/kDAdl3DCFJCxeWvMJqgyT1DhQohkDIFRnWZY0zaggNhNVm5yV/T3k
         vRVizS8qoAXxjzCAGzczfDQv2Ro+a18Lg2WpBJQh2bAew1T7VJyHUg8/gN42rRz/eAxc
         1vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739717343; x=1740322143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v541oYN4LKXknEHBVuJVfB05L2eJ4A19Ug3V3oUP4dA=;
        b=MyI83i7kB6YAJxvjvL4rAw7h3a38Id0umRnqC9jaDctudk/ZNc7sPOQWRX52GwFlK4
         T0c6F/xuVHsBjG7qteypxHCNvdVgDKsteGj4eHlpu8eTOrUrqUCqGQU0VMc9AxmchJ3F
         MGc7OdGfVYI0qAzAif7f8uSF34nXgbr1I+Xrtb4hT+ZvMV9bGCXKVMyR0h7fLM3NYKGN
         NuLKkQnE8HAN+EWLGgzHHmxnBI9wsyemzL7fH1dlmqMLNu5IDD6EA/lT65jNBtQ/yfb1
         rFoBuz3K+BDTfIfC1Ipa62U/T3o3DwBNpUzmqLGoRYV6xbS2UKByKCnoIMg+MI6XulFf
         g8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVj3AkSyljNtkomYzTAhXjosJSdm+lQHHj/QbFWenFLj4EIDdNMntxgLpgFLpEXAkQ1QnU=@vger.kernel.org, AJvYcCW9a0/tI7kbKKoekjsW7xo/B1QpK0VmhyGQkubkHMtuBiqa/vMMC/6eA05mYw18KtOV8/2/9LE5@vger.kernel.org
X-Gm-Message-State: AOJu0YyjW35DNsx9rC8EgWvstTuA5sQabALv+xPz0lk1tkW8uK+O8/pz
	NxacqkFDqMCEDbe8rjO09rd+LbJC300rQs+J/LVGJrckROxVY0jBZxM0qvp6qPps+n+EM8Sb90u
	TLqDjYMKGun0/Eq/g0cX0PCWatt4=
X-Gm-Gg: ASbGncvVYvtFhyu/BLsGge7UaZ9mNdj5VDflIRTRuMe/+YgyhjKrtI0wvo+0CPziZfI
	uvE4vSr6vvj+kUHRLDhnwhdGkgg/NPlBJ1TogM3EoqUQORsoKp6UCBXoHDIWBf4HwKOavO7On
X-Google-Smtp-Source: AGHT+IG3/aB3bhu4torf1LTXIS3c28cHadzav4Wvs1rEYQ66BEtV8AkdQBjP0KC1lzbBaxBGAXfMhYQixQpQF4zJbyU=
X-Received: by 2002:a05:6e02:198d:b0:3d0:4a82:3f42 with SMTP id
 e9e14a558f8ab-3d280946f56mr41335535ab.16.1739717342692; Sun, 16 Feb 2025
 06:49:02 -0800 (PST)
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
 <67b1f7f02320f_3f936429436@willemb.c.googlers.com.notmuch> <CAL+tcoCWmzFvz=GtbmfVoDwacTDXi2XeHt-Fc10rxc5S2WMN_Q@mail.gmail.com>
In-Reply-To: <CAL+tcoCWmzFvz=GtbmfVoDwacTDXi2XeHt-Fc10rxc5S2WMN_Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Feb 2025 22:48:26 +0800
X-Gm-Features: AWEUYZkiW0AhQrlKaFnBShibTFBGkti51Rwws2qTO_nw13Fy9d17HAjL48LcVjc
Message-ID: <CAL+tcoAjdaBPZE96T=YrgtZVUZNTmFpXr8C2+iVXLSZKB+01cA@mail.gmail.com>
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

On Sun, Feb 16, 2025 at 10:45=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Sun, Feb 16, 2025 at 10:36=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Sun, Feb 16, 2025 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> > > >
> > > > On 2/15/25 2:23 PM, Jason Xing wrote:
> > > > > On Sun, Feb 16, 2025 at 2:08=E2=80=AFAM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >>
> > > > >> Jason Xing wrote:
> > > > >>> On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> > > > >>> <willemdebruijn.kernel@gmail.com> wrote:
> > > > >>>>
> > > > >>>> Jason Xing wrote:
> > > > >>>>> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> > > > >>>>>
> > > > >>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> > > > >>>>> callback will occur at the same timestamping point as the use=
r
> > > > >>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use it t=
o
> > > > >>>>> get the same SCM_TSTAMP_SND timestamp without modifying the
> > > > >>>>> user-space application.
> > > > >>>>>
> > > > >>>>> To avoid increasing the code complexity, replace SKBTX_HW_TST=
AMP
> > > > >>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous calle=
rs
> > > > >>>>> from driver side using SKBTX_HW_TSTAMP. The new definition of
> > > > >>>>> SKBTX_HW_TSTAMP means the combination tests of socket timesta=
mping
> > > > >>>>> and bpf timestamping. After this patch, drivers can work unde=
r the
> > > > >>>>> bpf timestamping.
> > > > >>>>>
> > > > >>>>> Considering some drivers doesn't assign the skb with hardware
> > > > >>>>> timestamp,
> > > > >>>>
> > > > >>>> This is not for a real technical limitation, like the skb perh=
aps
> > > > >>>> being cloned or shared?
> > > > >>>
> > > > >>> Agreed on this point. I'm kind of familiar with I40E, so I dare=
 to say
> > > > >>> the reason why it doesn't assign the hwtstamp is because the sk=
b will
> > > > >>> soon be destroyed, that is to say, it's pointless to assign the
> > > > >>> timestamp.
> > > > >>
> > > > >> Makes sense.
> > > > >>
> > > > >> But that does not ensure that the skb is exclusively owned. Nor =
that
> > > > >> the same is true for all drivers using this API (which is not sm=
all,
> > > > >> but small enough to manually review if need be).
> > > > >>
> > > > >> The first two examples I happened to look at, i40e and bnx2x, bo=
th use
> > > > >> skb_get() to get a non-exclusive skb reference for their ptp_tx_=
skb.
> > > >
> > > > I think the existing __skb_tstamp_tx() function is also assigning t=
o
> > > > skb_hwtstamps(skb). The skb may be cloned from the orig_skb first, =
but they
> > > > still share the same shinfo. My understanding is that this patch is=
 assigning to
> > > > the shinfo earlier, so it should not have changed the driver's expe=
ctation on
> > > > the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If there ar=
e drivers
> > > > assuming exclusive access to the skb_hwtstamps(skb), probably it is=
 something
> > > > that needs to be addressed regardless and should not be the common =
case?
> > >
> > > Right, it's also what I was trying to say but missed. Thanks for the
> > > supplementary info:)
> >
> > That existing behavior looks dodgy then, too.
> >
> > I don't have time to look into it deeply right now. But it seems to go
> > back all the way to the introduction of hw timestamping in commit
> > ac45f602ee3d in 2009.
>
> Right. And hardware timestamping has been used for many years, I presume.
>
> >
> > I can see how it works in that nothing else holding a clone will
> > likely have a reason to touch those fields. But that does not make it
> > correct.
> >
> > Your point that the new code is no worse than today probably is true.
>
> Right.
>
> > But when we spot something we prefer to fix it probably. Will need a
> > deeper look..
>
> Got it. I added it to my to-do list. If you don't mind, I plan to take
> a deep look in March and then get back to you because recently I'm
> occupied by many things. I need to study some of the drivers that
> don't use skb_get() there.
>

Oh, sorry, I forgot to ask: what should we do next regarding this series ?

Thanks,
Jason

