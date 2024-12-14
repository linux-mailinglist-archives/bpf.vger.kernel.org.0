Return-Path: <bpf+bounces-46966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2E9F1B41
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1FA188EBD6
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C06618052;
	Sat, 14 Dec 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP8fLOvm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7FB1401B;
	Sat, 14 Dec 2024 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734135010; cv=none; b=HpYNZjJaXWjAllkIAiITM9yQGi6WBNzS3J8HYhlpXxddX2ttulK0AI+ZaWLR0pri+yh4BeF5lu58MMsowwrDTSO5YG3ISb6GbRd8ZYe87wE1KX4hlum8lux+kARyOOGaMQnhetmcbIgt4hnaVcMogJIUFPkqm8nN2cDuVmipNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734135010; c=relaxed/simple;
	bh=oMgeN857fN2FIyxABe5PbkA4tI4w1TYDpttWBE3ZXaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaDdhJ9LmQkZKDDzYZLT/FEahWoHqx2PaDaeljK8wPhOfcb2h8qUtXkWTNATwpV+qvyDSNrsul5PRS5lS6EC7FOPKLbhzQbxtRm62SX528+Ze/h3WEnu2TBbGvIwu/ZDeUMEEbZQJ56EBhEgFKA3k1izl7zxj8kRjDMeFUHoS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP8fLOvm; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a9cb667783so18345855ab.1;
        Fri, 13 Dec 2024 16:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734135008; x=1734739808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H2Fb7CsqFhNEfwhGT1bOO4A72Y2QO0yL1ANzlmc1HE=;
        b=GP8fLOvmnUwCA9i1wiRtrwNbnij5O4n7DL9uU6a7A2E2kSXbkCyQnuWrotZISNK7fx
         74RhgFLRAD7B7OOx3vP2BwOCuixFEvkuq4Od1gXWZZ47pZ006tiIf/1I4X48LtpsQHHN
         ebxYWL4lFAiw2R65FMTjCz4t8F0k9/nWRU0bIMPtXrr0pr/d+31KSHgsU1D1JJKhUgf1
         5+F51wnml2vwcTbVZFcaNzldy7cfnPsqDp7Cx+YxlcP9IUa2JXb365NY/WDMiG6lQXfY
         Ws/dmhJMfFXMoMjgc1VqLYKcOGJIHDjoi8E3INh0D+nAvAr3w7S4mIILx1SBxG4smJ80
         w2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734135008; x=1734739808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4H2Fb7CsqFhNEfwhGT1bOO4A72Y2QO0yL1ANzlmc1HE=;
        b=E+oUgTVceLqOIBgt222b0hmPOO8JiMMookb3wVoOhnGLNlGgkMXu0nhCWqhSC4stz0
         sgPn3L+Ww1C6E4IzGp2cDkjfl1CCDao5CsYwQx4WIMPxDiXUH1iUac05hXhCurrnDhrK
         NADlIPwq+joupbdEFN4LRPbi9nCk+h9TvmkdvIMxWr4nj3xulmSQGFVfEvwKO5MCoV64
         wVA21JXOyghHgPMdAFdDX9c3FAlb8NOqrC3rqiVNh6eXAbcysYVxnL0zDDvENKThOsX6
         0UVyDYHrg1Y+ZzltojnQoxkBuMR1LzcpDKQRKm+geYOWsj0mZk6DX8mj3LKx++ht3Mth
         vXqg==
X-Forwarded-Encrypted: i=1; AJvYcCUX0BM+lTAROH6ScfEVFoqO/hwkF36QeEnv+d+ex0YbRiteyThtFyicmZeznmfwOOtVNraIMgLb@vger.kernel.org, AJvYcCXy+9Td+1loZijJ+ORZOOpZitrR4Qjy9kmlKG2PwCDQxZf3BYCKpzYRQ9oijfnXaK7y9ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/zhJ0AhfLBXupQe9n3SAfSnc08Inoq3eoUK2YhaunuhY6vyB
	Oortsu31emBgivjH8YzpZHLNeFHORBiUirpMBN7y+UjQCtGTH7S3ON2igPOSAzSO1hXN6BIeuZd
	pyK2FYQH2/4DPd2sd9PJoQ0kPNds=
X-Gm-Gg: ASbGncvsYAoV57IK+dMee4lmL5RFkwrpnUMs53834SvD9yCHLp1WAbk7TTF6/lGgw4P
	KITFNAGY0SDbtJbjMETOXOPgPv49/gkeYoQTI
X-Google-Smtp-Source: AGHT+IFXAe1sar+67g39tWhRrbGChSACXRiRCXVsyL1iQ3TQIAh63Mlt3QrH0R06S9blqTGDCIfYI764mbAZdaVM0Nc=
X-Received: by 2002:a05:6e02:168a:b0:3a7:7ad4:fe78 with SMTP id
 e9e14a558f8ab-3aff88b85bfmr49335905ab.19.1734135008063; Fri, 13 Dec 2024
 16:10:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-11-kerneljasonxing@gmail.com> <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
 <CAL+tcoCCvKapSQ8N48iKh83YxYskDkPyM+bpT5=m8cE_YrCovg@mail.gmail.com> <55384b37-005d-48e9-894b-8bbe4f7a6b24@linux.dev>
In-Reply-To: <55384b37-005d-48e9-894b-8bbe4f7a6b24@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 14 Dec 2024 08:09:32 +0800
Message-ID: <CAL+tcoDPM=psbDMuJipuHv__=MATwkj1mQjWd-+G9kB3MDPLAA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 10/11] net-timestamp: export the tskey for TCP
 bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 7:55=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/13/24 7:44 AM, Jason Xing wrote:
> >>> @@ -5569,7 +5569,10 @@ static void __skb_tstamp_tx_bpf(struct sock *s=
k, struct sk_buff *skb,
> >>>                return;
> >>>        }
> >>>
> >>> -     bpf_skops_tx_timestamping(sk, skb, op, 2, args);
> >>> +     if (sk_is_tcp(sk))
> >>> +             args[2] =3D skb_shinfo(skb)->tskey;
> >> Instead of only passing one info "skb_shinfo(skb)->tskey" of a skb, pa=
ss the
> >> whole skb ptr to the bpf prog. Take a look at bpf_skops_init_skb. Lets=
 start
> >> with end_offset =3D 0 for now so that the bpf prog won't use it to rea=
d the
> >> skb->data. It can be revisited later.
> >>
> >>          bpf_skops_init_skb(&sock_ops, skb, 0);
> >>
> >> The bpf prog can use bpf_cast_to_kern_ctx() and bpf_core_cast() to get=
 to the
> >> skb_shinfo(skb). Take a look at the md_skb example in type_cast.c.
> > Sorry, I didn't give it much thought on getting to the shinfo. That's
> > why I quickly gave up using bpf_skops_init_skb() after I noticed the
> > seq of skb is always zero =F0=9F=99=81
> >
> > I will test it tomorrow. Thanks.
> >
> >> Then it needs to add a bpf_sock->op check to the existing
> >> bpf_sock_ops_{load,store}_hdr_opt() helpers to ensure these helpers ca=
n only be
> >> used by the BPF_SOCK_OPS_PARSE_HDR_OPT_CB, BPF_SOCK_OPS_HDR_OPT_LEN_CB=
, and
> >> BPF_SOCK_OPS_WRITE_HDR_OPT_CB callback.
> > Forgive me. I cannot see how the bpf_sock_ops_load_hdr_opt helper has
> > something to do with the current thread? Could you enlighten me?
>
> Sure. This is the same discussion as in patch 2, so may be worth to highl=
ight
> something that I guess may be missing:
>
> a bpf prog does not need to use a helper does not mean:
> a bpf prog is not allowed to call a helper because it is not safe.
>
> The sockops prog running at the new timestamp hook does not need to call
> bpf_setsockopt() but it does not mean the bpf prog is not allowed to call
> bpf_setsockopt() without holding the sk_lock which is then broken.
>
> The sockops timestamp prog does not need to use the
> bpf_sock_ops_{load,store}_hdr_opt but it does not mean the bpf prog is no=
t
> allowed to call bpf_sock_ops_{load,store}_hdr_opt to change the skb which=
 is
> then also broken.

Ah, I see. Thanks for your explanation :)

>
> Now, skops->skb is not NULL only when the sockops prog is allowed to read=
/write
> the skb.
>
> With bpf_skops_init_skb(), skops->skb will not be NULL in the new timesta=
mp
> callback hook. bpf_sock_ops_{load,store}_hdr_opt() will be able to use th=
e
> skops->skb and it will be broken.

I will take care of it along the way.

>
> >
> >> btw, how is the ack_skb used for the SCM_TSTAMP_ACK by the user space =
now?
> > To be honest, I hardly use the ack_skb[1] under this circumstance... I
> > think if someone offers a suggestion to use it, then we can support
> > it?
>
> Thanks for the pointer.
>
> Yep, supporting it later is fine. I am curious because the ack_skb is use=
d in
> the user space time stamping now but not in your patch. I was asking to e=
nsure
> that we should be able to support it in the future if there is a need.  W=
e
> should be able to reuse the skops->syn_skb to support that in the future.

Agreed. I feel that I can handle this part after this series.

>
> >
> > [1]
> > commit e7ed11ee945438b737e2ae2370e35591e16ec371
> > Author: Yousuk Seung<ysseung@google.com>
> > Date:   Wed Jan 20 12:41:55 2021 -0800
> >
> >      tcp: add TTL to SCM_TIMESTAMPING_OPT_STATS
> >
> >      This patch adds TCP_NLA_TTL to SCM_TIMESTAMPING_OPT_STATS that exp=
orts
> >      the time-to-live or hop limit of the latest incoming packet with
> >      SCM_TSTAMP_ACK. The value exported may not be from the packet that=
 acks
> >      the sequence when incoming packets are aggregated. Exporting the
> >      time-to-live or hop limit value of incoming packets helps to estim=
ate
> >      the hop count of the path of the flow that may change over time.
>
>

