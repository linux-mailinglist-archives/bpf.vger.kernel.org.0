Return-Path: <bpf+bounces-51780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F491A39011
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 01:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D21D3ADDEE
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 00:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392A11D554;
	Tue, 18 Feb 2025 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M45nmBlj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7E6FBF;
	Tue, 18 Feb 2025 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840197; cv=none; b=B6JBUI2JbklDFIBoVw1lFFglXEDehqTgWVAIXHPuyKuE6dgQU7HkIVy6QP1uD7Ejq5coNSDv9l/b6ZBeHPafzzxlYq17zzZ53gnt6ak5mJozb4kSgDWBnsdD0BP5gLlfPdG4rHDdPYM6i9AhKfSUe69FLK0CxvEo0rWkvGr/QM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840197; c=relaxed/simple;
	bh=gktuXd4cZv4swI/Apa4j4BHzU8YLtNUEzVxA3MR771w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r64XPLEp75K3e2XPSbcWr9Bf/qc9YXxxa0j+l/pehxOsbsrops7bZqMC+kk8nzxMme6nZzeCsVOcQTxadIT48o4xrf+yU7VnlI7ltg8kFIwzgiznZRk6w96dMQAR+3ZIM/OSqziLw/p4gQcv8SbrPIvPvMM42c6eoYAdFNADito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M45nmBlj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471ebfbad4dso16020771cf.3;
        Mon, 17 Feb 2025 16:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739840195; x=1740444995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gktuXd4cZv4swI/Apa4j4BHzU8YLtNUEzVxA3MR771w=;
        b=M45nmBljY4xrumXeRdEDbewZVpn6UjNHm5UmEaKxh8Q5uwXDZF6gtq7f8xZELHFrLE
         kUbhKrHrHLAIMPHhZlCPOMZEfXSPBYiOk48SFi+jCJFXup8BTMx5smbS9jWG216AmAyz
         3eu81XLIoT9aMKVbZjIAGfusCj+saBKntRI8Zy0Xi8ZXbXwdhugUFr2Ihgsku+oQNSup
         Mwk18oHQIn1nul8/E6z1lmPZqytu4KtonlNnvE/yD8/1HCBWmzdqBqCJHkkAKTEyixGb
         TkXFLh/KBNeBuni31OMO1UQiNLFdjn+S4aB4qSmam+eE1Qp0tt1mSH4shNLPHTaiC6tS
         VY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739840195; x=1740444995;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gktuXd4cZv4swI/Apa4j4BHzU8YLtNUEzVxA3MR771w=;
        b=IZBN3mwtu1LnUQLjqcd4DdQqAr2ImFaCCgIsLGkLkBW8S+0U+R0LCR8DCi0nZGnL8l
         QvsGEvabQCQ2JGy5LdbpW8OPIL055FpqxhQTi4UcmqkEykQ78YiZdQepWbTY0opSe0ve
         hMh0gLLKoyNLo4BRp+jaQmZszvGWQn0s0Wxh4iF0HVYnbvdriaXLfqqXSgdJrtDmCLMo
         xkzoUkcjgaWUEKlWI/4ey0SXMmVaxnbAITSY5IBubNXqbmaNBIQWdXAKuNkbtPZHSFDQ
         R+EHrWmmtoLy1xhoMdrimI8cKsiZtton7L3+Mj7rt02288+lmoA+XFALerzIq8R57AQe
         wfag==
X-Forwarded-Encrypted: i=1; AJvYcCVRDXATb6QT27qlv98ixn6358GgzoHRAU1zZHpilCSvghq/dX8PptpVLHRRp3F0eSXy5g7hNrqw@vger.kernel.org, AJvYcCVfjRG+IlHLsCuIjUqNI1jEjDvx2HBkiYtpxx8vnJNBcBGwx/1QJtJ4Hr4jem0JjDUUSds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrahgpdtZhxzDODiQ866/VxIbrZ+LTxjQAjl7Ur6KLbnB3dj67
	erlwQzyhloAKp7241XM021rhNHN3rH2Pob+bpinjMxxkb54TvY3b
X-Gm-Gg: ASbGncuqVLOE3vb6ZFdsXtErWVbNjSvg0pjz8JABtDfqLxDElvgzVdR5n8dMbVAmWFS
	GqkWzJpoGOqjlgNzBu/G/ho0iySkW1OVj5TtEnBU/rXSZ/KgcambOftczWG8i10LXoAE8BEn1q7
	Ib1p6HdLokbg2+52mDVNGjgKmdHBGpbrEmwL2YfGrPks5aKhci7bXRSN4+jy+uBeS6WXQ6t315f
	VbbC5QlCNLsQKNbnh8YVK484XCeWEJj3o88+H37DYqifDujPmsbHp2TwZnBGxCt1QL0djXgBbUW
	3D7i95UwVBVz8Qhpqt3mLUIpe414VW7v+H/kmzHczlRhTHeu6iaAcCpKkZ6n5aM=
X-Google-Smtp-Source: AGHT+IF9NR7nqD8yxi/sGp27VLl3DjdQI9WOiYGth2oO8ho51Nn61uuHTQINzedSfZgfnRle7+2TPQ==
X-Received: by 2002:a05:622a:1aa5:b0:471:ba31:ce8c with SMTP id d75a77b69052e-471dbd237e2mr210189801cf.13.1739840195000;
        Mon, 17 Feb 2025 16:56:35 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f4766a48sm12911111cf.52.2025.02.17.16.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 16:56:34 -0800 (PST)
Date: Mon, 17 Feb 2025 19:56:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
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
Message-ID: <67b3dac192f76_c0e25294c8@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAjdaBPZE96T=YrgtZVUZNTmFpXr8C2+iVXLSZKB+01cA@mail.gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com>
 <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
 <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
 <67b0d831bf13f_381893294f4@willemb.c.googlers.com.notmuch>
 <CAL+tcoDhtBFjVBMWObHq3LaSNXgJN_UWBVONAqD=t7CRYN_PAg@mail.gmail.com>
 <89989129-9336-4863-a66e-e9c8adc60072@linux.dev>
 <CAL+tcoDB=Vv=smpP9rUaj3tug2Vt6dQz9Ay8DRxMwAs-Q9iexg@mail.gmail.com>
 <67b1f7f02320f_3f936429436@willemb.c.googlers.com.notmuch>
 <CAL+tcoCWmzFvz=GtbmfVoDwacTDXi2XeHt-Fc10rxc5S2WMN_Q@mail.gmail.com>
 <CAL+tcoAjdaBPZE96T=YrgtZVUZNTmFpXr8C2+iVXLSZKB+01cA@mail.gmail.com>
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
> On Sun, Feb 16, 2025 at 10:45=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 10:36=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Sun, Feb 16, 2025 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.=
lau@linux.dev> wrote:
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
> > > > > >>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. T=
his
> > > > > >>>>> callback will occur at the same timestamping point as the=
 user
> > > > > >>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use =
it to
> > > > > >>>>> get the same SCM_TSTAMP_SND timestamp without modifying t=
he
> > > > > >>>>> user-space application.
> > > > > >>>>>
> > > > > >>>>> To avoid increasing the code complexity, replace SKBTX_HW=
_TSTAMP
> > > > > >>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous c=
allers
> > > > > >>>>> from driver side using SKBTX_HW_TSTAMP. The new definitio=
n of
> > > > > >>>>> SKBTX_HW_TSTAMP means the combination tests of socket tim=
estamping
> > > > > >>>>> and bpf timestamping. After this patch, drivers can work =
under the
> > > > > >>>>> bpf timestamping.
> > > > > >>>>>
> > > > > >>>>> Considering some drivers doesn't assign the skb with hard=
ware
> > > > > >>>>> timestamp,
> > > > > >>>>
> > > > > >>>> This is not for a real technical limitation, like the skb =
perhaps
> > > > > >>>> being cloned or shared?
> > > > > >>>
> > > > > >>> Agreed on this point. I'm kind of familiar with I40E, so I =
dare to say
> > > > > >>> the reason why it doesn't assign the hwtstamp is because th=
e skb will
> > > > > >>> soon be destroyed, that is to say, it's pointless to assign=
 the
> > > > > >>> timestamp.
> > > > > >>
> > > > > >> Makes sense.
> > > > > >>
> > > > > >> But that does not ensure that the skb is exclusively owned. =
Nor that
> > > > > >> the same is true for all drivers using this API (which is no=
t small,
> > > > > >> but small enough to manually review if need be).
> > > > > >>
> > > > > >> The first two examples I happened to look at, i40e and bnx2x=
, both use
> > > > > >> skb_get() to get a non-exclusive skb reference for their ptp=
_tx_skb.
> > > > >
> > > > > I think the existing __skb_tstamp_tx() function is also assigni=
ng to
> > > > > skb_hwtstamps(skb). The skb may be cloned from the orig_skb fir=
st, but they
> > > > > still share the same shinfo. My understanding is that this patc=
h is assigning to
> > > > > the shinfo earlier, so it should not have changed the driver's =
expectation on
> > > > > the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If ther=
e are drivers
> > > > > assuming exclusive access to the skb_hwtstamps(skb), probably i=
t is something
> > > > > that needs to be addressed regardless and should not be the com=
mon case?
> > > >
> > > > Right, it's also what I was trying to say but missed. Thanks for =
the
> > > > supplementary info:)
> > >
> > > That existing behavior looks dodgy then, too.
> > >
> > > I don't have time to look into it deeply right now. But it seems to=
 go
> > > back all the way to the introduction of hw timestamping in commit
> > > ac45f602ee3d in 2009.
> >
> > Right. And hardware timestamping has been used for many years, I pres=
ume.
> >
> > >
> > > I can see how it works in that nothing else holding a clone will
> > > likely have a reason to touch those fields. But that does not make =
it
> > > correct.
> > >
> > > Your point that the new code is no worse than today probably is tru=
e.
> >
> > Right.
> >
> > > But when we spot something we prefer to fix it probably. Will need =
a
> > > deeper look..
> >
> > Got it. I added it to my to-do list. If you don't mind, I plan to tak=
e
> > a deep look in March and then get back to you because recently I'm
> > occupied by many things. I need to study some of the drivers that
> > don't use skb_get() there.
> >
> =

> Oh, sorry, I forgot to ask: what should we do next regarding this serie=
s ?

Please resubmit with the two remaining small issues addressed:

- Martin's point about moving code to patch 8
- Remove unused variable



