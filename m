Return-Path: <bpf+bounces-51797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBECA3922C
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84791894215
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 04:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371911ACED5;
	Tue, 18 Feb 2025 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITHkoce7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320051AA1E4;
	Tue, 18 Feb 2025 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854354; cv=none; b=NAaZw6j+KYnHzGQKgt7TgUItKO5yB5APH91gc+CcZAIcSPbkuGYnH9E7FgBSt2ujGRzsQkZTgdvsJn+81kif5uD9cCTy5jXPNcfas+W5MIUO+0v3Tnf6pYRpeFnUjiQ8uH6sZ7D3GcfTdPp9qDBEHEWbgeFYRcn58z6xZO9WhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854354; c=relaxed/simple;
	bh=sMzfapoEOGG8h5wQ3oTEOdAhh0iV0+ZuHPUQEdpGUfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJ+uhx92Fi9gN+GBZLq0W6lE/WhLJFNEKBoF6uJ6YpeNJiz1AhmUfmGT6B1OCObrVq0JKO8vEECcwQ6G9fz/0WPFDJ46R3Q1TYxxKTA5lXfxLW0XK+29br4AKCJbbmGrZgUHXqQRos81zXI23gSj+/yFgiheMuy3j+D7/Ia8Tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITHkoce7; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d1987cce10so29224725ab.3;
        Mon, 17 Feb 2025 20:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854352; x=1740459152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMzfapoEOGG8h5wQ3oTEOdAhh0iV0+ZuHPUQEdpGUfY=;
        b=ITHkoce7Sza/MD5s6E74BdzROoFPvKWJiLIdW4w9LagoOey0JR1q4vUqp21X+LMwY1
         fp9FEfeIuPJgksIRIdF5L51IpU5aydXUfod/HD0fi+35vP5kVM2de6q40KGhTmHUUaGC
         LtlvgR1FqRERcNxSL/ooPncgVlbXIsatcKvYLvRMp/g1UwRL1rV0tmwemBVIaCu4Rblw
         DfRFzXosTteCaiBHZCJ0SUmUrwjNdTCHkevofJ4lj4GWM++vvVosi3KzAy3a/hnLNB5c
         n0gBig42170pj9v7EKQliy+lK/Fr3MBDjglcpciuULUksy7Ip9TitC+5ZudiK6lZztAZ
         zVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854352; x=1740459152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMzfapoEOGG8h5wQ3oTEOdAhh0iV0+ZuHPUQEdpGUfY=;
        b=PYPOIlCefUJz6RHlzIWU02an1JTBHKGxnK2CHrin9GRWiG/kWAe1oJJg3Jvd4bFfJi
         DuqZh/AU8TfFNBzc6x5PUOS5e6UJgWgS/TVK/PGmYrsHSDYWxXOqXyGgvySMiOfiGWzj
         bgscHlSVMtwxmEo8+VvQ2doRDBt59HjqSDJObxLZc6DobcP9v8D0zmspFatrMczxD9Wi
         9R2Osc6JxWS/sBPYdHBxD4CbsP+xlNU/rKG1Xycuckp4D9Qk6pFWkZMWLt5VX2uJjcW7
         n3jBer+UVgk6hq/UX3ft8I4MF4yM8WvjBbhhJ8ZxQk+wOxG92YLBb4m7OksdumTahkfr
         GU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQO/DNMQaS+XH0aC16qiHyLnneJ6BBIItF4J4UkM+m3ij1JSchquh+481DirgJ+x2P+VpbuDiG@vger.kernel.org, AJvYcCVpGQEbrA6fy70xb40irwuuNHbspxRvCqihhIHQJuNe3+3UusqBbIxxPy5BRWiDfRhoik0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNpKPc4XwPIc0fWZZQ78BtUMUktaPh6kKQN5ZnkJ23v1X12jGV
	P03YjF7BTst477rAjiS+hMVXbzX/eMzG5qBQdGMuO92B7+J8U/xlRRczhuuhigUhWUc0XhHFtDV
	mGXi0sf91ehHrE/xIWTe/Xst+dD8=
X-Gm-Gg: ASbGnctQGN6Avr06OHi3Zs4Qz0Q+hDcdRbJ291Q6/yyGhO/hJcgA8aOv6A19oNWamAX
	NOYYMtaDttTBLtOWTUoHq6GrSU2av08VmL8JdSn0/66pu+fqIvxribWgrmDEXLSFe7cD66fc/
X-Google-Smtp-Source: AGHT+IFV9fqQYPdMagVdivZyMf7kq9e4Dp5klD0HCxC/k1v64R3vmZKJ4uTiaos3jMEew8f8GNuKf20XgqPIyEXzbek=
X-Received: by 2002:a05:6e02:1d85:b0:3d1:9999:4f62 with SMTP id
 e9e14a558f8ab-3d2807ab794mr118477305ab.2.1739854352057; Mon, 17 Feb 2025
 20:52:32 -0800 (PST)
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
 <CAL+tcoCWmzFvz=GtbmfVoDwacTDXi2XeHt-Fc10rxc5S2WMN_Q@mail.gmail.com>
 <CAL+tcoAjdaBPZE96T=YrgtZVUZNTmFpXr8C2+iVXLSZKB+01cA@mail.gmail.com> <67b3dac192f76_c0e25294c8@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b3dac192f76_c0e25294c8@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Feb 2025 12:51:55 +0800
X-Gm-Features: AWEUYZmT9yoyVcUD_Pyn64kbvto4K8wWop8iltHnjodaKGqsMHfAkcym-p2ZzRg
Message-ID: <CAL+tcoDufxA0KvLPBf37f=MGUnL0YWSLsT+v9dFEa=0tTrTDqA@mail.gmail.com>
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

On Tue, Feb 18, 2025 at 8:56=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Sun, Feb 16, 2025 at 10:45=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > On Sun, Feb 16, 2025 at 10:36=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > On Sun, Feb 16, 2025 at 6:58=E2=80=AFAM Martin KaFai Lau <martin.=
lau@linux.dev> wrote:
> > > > > >
> > > > > > On 2/15/25 2:23 PM, Jason Xing wrote:
> > > > > > > On Sun, Feb 16, 2025 at 2:08=E2=80=AFAM Willem de Bruijn
> > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >>
> > > > > > >> Jason Xing wrote:
> > > > > > >>> On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
> > > > > > >>> <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >>>>
> > > > > > >>>> Jason Xing wrote:
> > > > > > >>>>> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> > > > > > >>>>>
> > > > > > >>>>> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. T=
his
> > > > > > >>>>> callback will occur at the same timestamping point as the=
 user
> > > > > > >>>>> space's hardware SCM_TSTAMP_SND. The BPF program can use =
it to
> > > > > > >>>>> get the same SCM_TSTAMP_SND timestamp without modifying t=
he
> > > > > > >>>>> user-space application.
> > > > > > >>>>>
> > > > > > >>>>> To avoid increasing the code complexity, replace SKBTX_HW=
_TSTAMP
> > > > > > >>>>> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous c=
allers
> > > > > > >>>>> from driver side using SKBTX_HW_TSTAMP. The new definitio=
n of
> > > > > > >>>>> SKBTX_HW_TSTAMP means the combination tests of socket tim=
estamping
> > > > > > >>>>> and bpf timestamping. After this patch, drivers can work =
under the
> > > > > > >>>>> bpf timestamping.
> > > > > > >>>>>
> > > > > > >>>>> Considering some drivers doesn't assign the skb with hard=
ware
> > > > > > >>>>> timestamp,
> > > > > > >>>>
> > > > > > >>>> This is not for a real technical limitation, like the skb =
perhaps
> > > > > > >>>> being cloned or shared?
> > > > > > >>>
> > > > > > >>> Agreed on this point. I'm kind of familiar with I40E, so I =
dare to say
> > > > > > >>> the reason why it doesn't assign the hwtstamp is because th=
e skb will
> > > > > > >>> soon be destroyed, that is to say, it's pointless to assign=
 the
> > > > > > >>> timestamp.
> > > > > > >>
> > > > > > >> Makes sense.
> > > > > > >>
> > > > > > >> But that does not ensure that the skb is exclusively owned. =
Nor that
> > > > > > >> the same is true for all drivers using this API (which is no=
t small,
> > > > > > >> but small enough to manually review if need be).
> > > > > > >>
> > > > > > >> The first two examples I happened to look at, i40e and bnx2x=
, both use
> > > > > > >> skb_get() to get a non-exclusive skb reference for their ptp=
_tx_skb.
> > > > > >
> > > > > > I think the existing __skb_tstamp_tx() function is also assigni=
ng to
> > > > > > skb_hwtstamps(skb). The skb may be cloned from the orig_skb fir=
st, but they
> > > > > > still share the same shinfo. My understanding is that this patc=
h is assigning to
> > > > > > the shinfo earlier, so it should not have changed the driver's =
expectation on
> > > > > > the skb_hwtstamps(skb) after calling __skb_tstamp_tx(). If ther=
e are drivers
> > > > > > assuming exclusive access to the skb_hwtstamps(skb), probably i=
t is something
> > > > > > that needs to be addressed regardless and should not be the com=
mon case?
> > > > >
> > > > > Right, it's also what I was trying to say but missed. Thanks for =
the
> > > > > supplementary info:)
> > > >
> > > > That existing behavior looks dodgy then, too.
> > > >
> > > > I don't have time to look into it deeply right now. But it seems to=
 go
> > > > back all the way to the introduction of hw timestamping in commit
> > > > ac45f602ee3d in 2009.
> > >
> > > Right. And hardware timestamping has been used for many years, I pres=
ume.
> > >
> > > >
> > > > I can see how it works in that nothing else holding a clone will
> > > > likely have a reason to touch those fields. But that does not make =
it
> > > > correct.
> > > >
> > > > Your point that the new code is no worse than today probably is tru=
e.
> > >
> > > Right.
> > >
> > > > But when we spot something we prefer to fix it probably. Will need =
a
> > > > deeper look..
> > >
> > > Got it. I added it to my to-do list. If you don't mind, I plan to tak=
e
> > > a deep look in March and then get back to you because recently I'm
> > > occupied by many things. I need to study some of the drivers that
> > > don't use skb_get() there.
> > >
> >
> > Oh, sorry, I forgot to ask: what should we do next regarding this serie=
s ?
>
> Please resubmit with the two remaining small issues addressed:
>
> - Martin's point about moving code to patch 8
> - Remove unused variable

Sure, the v12 is coming soon :)

Thanks,
Jason

