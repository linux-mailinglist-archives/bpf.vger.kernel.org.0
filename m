Return-Path: <bpf+bounces-50586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4CA29E2C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4837D3A7790
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA12561D;
	Thu,  6 Feb 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7j2DlMa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC910F2;
	Thu,  6 Feb 2025 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803959; cv=none; b=SgLoVUZ3RM/eGW94ldJjgAiJke1SU1MCXZ34YFbbVr2cKWF7CQfGkVOG1ob+tO8m/4Zgp8a+fZUNkOz4Kfatz4yS3DLqhhcvPCJGkEnZOO867ljufhBTtgCJOg1zYUQThpRjBmZAX8GD5Lrqx/knGLeMUxQGFkyVILRFjqUPYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803959; c=relaxed/simple;
	bh=KQQ+2XlLbTNF2wY+Xk5Fz7Dbm2FP061v1mkgGcvRKDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOueG7h4fdQasMd2gjroNU6Hu0C3xtZ6TB4yoPuU90AkfM/W6LlflPBuvImaH/f3m4YHOb6nTyAWbBkzotPi1DSjKmSEX2elPFAQBlhyX3gcM4BtThJxJabZ0aTzW9eLDCkpTJ1pWFlTG3ue9jMcMz/T9MgO5aQ+mIVu/PaD8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7j2DlMa; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d01dc5a7f6so1016055ab.0;
        Wed, 05 Feb 2025 17:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738803957; x=1739408757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moH97NtZACXMHwbz4LidFoVFYT00RxbcY8+FwE69LLE=;
        b=f7j2DlMavr3Zz0ZwUI8cjUx9MZ3Yyhn6DqILwtnU7RT+vuNr6aHXfIxQvgSXOXAeiZ
         Q9Ln1hWSKRAs9qghTA98XUXdxvZ9KmCvCxXRQPY8X41TzmxNuZNvP+lNUdSHsDDP9CZJ
         5GtfkAxlrZbIg84LmUTn4WuhC8zInSBClwFUfhn0sUW+mqFga5SZWw4K+w48iQVPutDo
         d9rkuT9hWyktQehtczz6mVcB5m83ucZ8DM8rObFunCQEGMlSytPMFEZ1pXOvUKja0HYe
         1Yit45UEzMfQSzkih9Wkg7OwTC+wtGBIhDB2xYBTFTlD1t5MLL+uO28+LejbKgk9Wzp1
         8jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738803957; x=1739408757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moH97NtZACXMHwbz4LidFoVFYT00RxbcY8+FwE69LLE=;
        b=MtMyKgQYLfHoOuU13OHiP0I/CjVFaYUIdTfV/NG8qFLbcDtJ4Ml5VBd4EUtsyRHQpe
         1Oawmg0UNb9UCN0m1QU4I5QM9vLNuvqIOUDLa6ufw8N7laalGojGHEa6sIA/D48ICKSb
         q95kzroQJ3jDkMBVQoZCwVx6Mh9Faom60NMDv6h7TgZPxs7ddQjs06M2/ruylLx5c1Lh
         XutQzE33veMQwJoyA6Rhs4XHettD0rbUvd5L8jX1+fEgDZcPDn5gyTvHZPatOd4IdnU0
         53SKeKvveqNqd9HcYEDO5LcmRRKuBTyifnpDzT+chBOUhlZQwVH8oxlvQgJQiCeNZ5Zm
         cB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtWE5gF5R1UxNkECSctI83NxHl+qofWFfSie1n5/Z6zJI1uWRySjNu16lIyCy2zD3ETvVU012u@vger.kernel.org, AJvYcCXXK7mADdVWk/5PPkiAQL7wViKERj5m6hq4yA0n1Da2L0uiu14iZhZS65i8klzPe92OmS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZ4rfQBgjp+6r0K+Oe5vLj4SkZkW6xzZoFKSIf/hd1xlnJQTz
	vLR6Zc0qtiqUPD5sJcbV49eesus61bk6gVe3/bLpIRP+HN8LXu7xbjm7+k5bietNxdP/aOoQtVi
	84UQGnSestInI0ZDROQhKWfavsLI=
X-Gm-Gg: ASbGncvVYxrSaXs+b3fv5cQ6puAfF1jYj1xWR5ag4MRH4oBXcRb00IARn+cvIXKm/dc
	KUmnpJS0jtV+N73Ps4wmnPLYAtILRwzVcF1KZWIHWjIuLZ/gK2hVXm8vWfS/F0D4fFUkA0MQ=
X-Google-Smtp-Source: AGHT+IFjVgo3/WPhNKwo1gXqirRveT2RdB+IMQQt7M3lqpnU78l+JAIxyHeoxmEQKevqNO+mxPU7kQ172sHnDOui7js=
X-Received: by 2002:a05:6e02:158b:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3d04f40350bmr50410485ab.1.1738803956675; Wed, 05 Feb 2025
 17:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com> <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev> <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev>
In-Reply-To: <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 09:05:20 +0800
X-Gm-Features: AWEUYZkYL6GKwqGIG6sxB0YiN0hUC_NT96GIWPkghZSfbk5XHHpikNVDhQ0IgHg
Message-ID: <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 8:47=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/5/25 4:12 PM, Jason Xing wrote:
> > On Thu, Feb 6, 2025 at 5:57=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >>
> >> On 2/4/25 5:57 PM, Jakub Kicinski wrote:
> >>> On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
> >>>> +    if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> >>>> +        SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) =
{
> >>>> +            struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> >>>> +            struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> >>>> +
> >>>> +            tcb->txstamp_ack_bpf =3D 1;
> >>>> +            shinfo->tx_flags |=3D SKBTX_BPF;
> >>>> +            shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> >>>> +    }
> >>>
> >>> If BPF program is attached we'll timestamp all skbs? Am I reading thi=
s
> >>> right?
> >>
> >> If the attached bpf program explicitly turns on the SK_BPF_CB_TX_TIMES=
TAMPING
> >> bit of a sock, then all skbs of this sock will be tx timestamp-ed.
> >
> > Martin, I'm afraid it's not like what you expect. Only the last
> > portion of the sendmsg will enter the above function which means if
> > the size of sendmsg is large, only the last skb will be set SKBTX_BPF
> > and be timestamped.
>
> Sure. The last skb of a large msg and more skb of small msg (or MSG_EOR).
>
> My point is, only attaching a bpf alone is not enough. The
> SK_BPF_CB_TX_TIMESTAMPING still needs to be turned on.

Right.

>
> >
> >>
> >>>
> >>> Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whether it=
's
> >>> interested in tracing current packet all the way thru the stack?
> >>
> >> I like this idea. It can give the BPF prog a chance to do skb sampling=
 on a
> >> particular socket.
> >>
> >> The return value of BPF_SOCK_OPS_TS_SND_CB (or any cgroup BPF prog ret=
urn value)
> >> already has another usage, which its return value is currently enforce=
d by the
> >> verifier. It is better not to convolute it further.
> >>
> >> I don't prefer to add more use cases to skops->reply either, which is =
an union
> >> of args[4], such that later progs (in the cgrp prog array) may lose th=
e args value.
> >>
> >> Jason, instead of always setting SKBTX_BPF and txstamp_ack_bpf in the =
kernel, a
> >> new BPF kfunc can be added so that the BPF prog can call it to selecti=
vely set
> >> SKBTX_BPF and txstamp_ack_bpf in some skb.
> >
> > Agreed because at netdev 0x19 I have an explicit plan to share the
> > experience from our company about how to trace all the skbs which were
> > completed through a kernel module. It's how we use in production
> > especially for debug or diagnose use.
>
> This is fine. The bpf prog can still do that by calling the kfunc. I don'=
t see
> why move the bit setting into kfunc makes the whole set won't work.
>
> > I'm not knowledgeable enough about BPF, so I'd like to know if there
> > are some functions that I can take as good examples?
> >
> > I think it's a standalone and good feature, can I handle it after this =
series?
>
> Unfortunately, no. Once the default is on, this cannot be changed.
>
> I think Jakub's suggestion to allow bpf prog selectively choose skb to ti=
mestamp
> is useful, so I suggested a way to do it.

Because, sorry, I don't want to postpone this series any longer (blame
on me for delaying almost 4 months), only wanting to focus on the
extension for SO_TIMESTAMPING so that we can quickly move on with
small changes per series.

Selectively sampling the skbs or sampling all the skbs could be an
optional good choice/feature for users instead of mandatory?

There are two kinds of monitoring in production: 1) daily monitoring,
2) diagnostic monitoring which I'm not sure if I translate in the
right way. For the former that is obviously a light-weight feature, I
think we don't need to trace that many skbs, only the last skb is
enough which was done in Google because even the selective feature[1]
is a little bit heavy. I received some complaints from a few
latency-sensitive customers to ask us if we can reduce the monitoring
in the kernel because as I mentioned before many issues are caused by
the application itself instead of kernel.

[1] selective feature consists of two parts, only selectively
collecting all the skbs in a certain period or selectively collecting
exactly like what SO_TIMESTAMPING does in a certain period. It might
need a full discussion, I reckon.

Thanks,
Jason

