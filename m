Return-Path: <bpf+bounces-42138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707599FE35
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECADA1F26448
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 01:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FC136326;
	Wed, 16 Oct 2024 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRuIWf1G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4F28EA;
	Wed, 16 Oct 2024 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041884; cv=none; b=ifsyiZ4v8JW9Eqmo152ra+uvBOFAQTWP0vwRAQOm6/rMmEavpyRlTdSfevEhU+4N6t9itMayg3EX7y0MPFAHLjAHRJAh+IpkhbRN7J0TKY3+L5tpzY/TwY0LHp14FU67Rf7A0Hq7eyqX0mT/LNMFcy7NEWEq0IiWiPNeLTPY4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041884; c=relaxed/simple;
	bh=jVbvc1SZNZr+NRVIJl/5D8cQrcc4dovO14QiyWGUUGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwaxHnz68qT4M5+UmN9oZMG2Pr0ZQg7ezxm3DaivSNKqMxy0UmGsamtJdRFFaMLJOouL64Cp5J9vTGEJif9HHmT6Pl91dcbsP6NZj4D6Q74qGSe/zeZOa7A0IulJzZsyxoJ0Jekn9tN3+C1l7hB+1QRTkAkZFeRbeNsMspjVczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRuIWf1G; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b98d8a7eso15419405ab.3;
        Tue, 15 Oct 2024 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729041882; x=1729646682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwxRQOVmGucIIaXDapHmEk+KUNwTmfSyNHBCP2gBsvA=;
        b=bRuIWf1GxrNlsvikLT5g/T0SgxSj++SgfD7xlotpwoghJPCzIvUzcGisEENBSTtR9U
         v8MlCZCe1O2wrwyoo+KR19KL/oJOmzg+tTzcJGTVXa4XY5ZUH8ROKPSUrlwMYaffJHCP
         y/E2bKYwGtGTU2atWhlRje0Z4KgMB3N7nWJft8n1EZKqzVzu6kPW5Vg5v9XufAyJdqcL
         XEudoYwYLBe9YhWyY8I6shpIV5j7PLuer3S7PzsVBD9ov8Q+XJCNSYTzGaVFKg3lRUlJ
         PCIoQtaAsBrmjmpyjBgim0Ukpp4ymfV1ey+YrBNYzOnFQvz2O+Loq1zYngpKekhdVKs4
         +MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729041882; x=1729646682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwxRQOVmGucIIaXDapHmEk+KUNwTmfSyNHBCP2gBsvA=;
        b=f4zDULKvGfhD5rAi0hO7fn/PCp4rUQh0LFbaey07alxaydC0YgSQ3MywHrwW0l2F0s
         qDFxy3W2/BYAULpy5qBt1EFI2KS6ENnEvUNdmmuWj4eX+U4eVQobDsnAkRzN+STdXF4h
         Lb6U3PgmUIqjw+lhtjJuZLOQv29Jru4i6kFqdzMgUGXSoZpOwo5j3/PEJreAiuAoAsFV
         +msJps3QnS6ioHR1GogqoGFAUgn30593zp+Sh3cmaGNJAv0RK7bXgr+/iS+MNdW/+4Kt
         BkcSAfEHqwaG9YGstzMyxA42dxw6mKno/zyCgbG13f/B+KCOAr9FkNHYZaYov3kXMk1B
         o5nw==
X-Forwarded-Encrypted: i=1; AJvYcCVNLiMqddtlTGtRt9G3Hhnaybt4jVNjUidK2hl7wPeV8cr8g2pbGu5Kl8Y/+cYcZ0uwTqs=@vger.kernel.org, AJvYcCX2YUSSOY+6YzbzUgYJ98nbVZKnEeZNW+WT73sIeIAcuVOCErOE1Hq0Kiz71INUxtSnxeivj34e@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0p1SEoi8XvVJFfsiqeQ8izgOrFnDAkZxnB4bTJ+Fo9bS22+N
	vF34D7GhxTKJzkljQ/qZCYPKRbz8yfSKrSevPNzbjFeBgqkXGM1YJMmmjQAkhkqZJ6MjI25W+FN
	V6UU+W3WEjHLXAq3a8Usg33o9fYI=
X-Google-Smtp-Source: AGHT+IFaJcpev/z/nvz1yK2mvSXTH685JW392TZLSgbKDsts917JbBlzLGc2zAR9Z5VhyVYSsQwe6LkuQcqd4rxdAO4=
X-Received: by 2002:a05:6e02:1fe6:b0:3a3:4221:b0d3 with SMTP id
 e9e14a558f8ab-3a3b5c765e6mr157369885ab.0.1729041881879; Tue, 15 Oct 2024
 18:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-7-kerneljasonxing@gmail.com> <b4767fab-9c61-49f0-8185-6445349ae30b@linux.dev>
In-Reply-To: <b4767fab-9c61-49f0-8185-6445349ae30b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 09:24:05 +0800
Message-ID: <CAL+tcoD8OF0LCSFVEN-oEQas1JGfR+HF7Zt+2fqMH5_4eK9X4g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
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

On Wed, Oct 16, 2024 at 9:01=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/11/24 9:06 PM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
> > print timestamps when the skb just passes the dev layer.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/uapi/linux/bpf.h       |  5 +++++
> >   net/core/skbuff.c              | 17 +++++++++++++++--
> >   tools/include/uapi/linux/bpf.h |  5 +++++
> >   3 files changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 157e139ed6fc..3cf3c9c896c7 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7019,6 +7019,11 @@ enum {
> >                                        * by the kernel or the
> >                                        * earlier bpf-progs.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SCHED_OPT_CB,   /* Called when skb is passing thr=
ough
> > +                                      * dev layer when SO_TIMESTAMPING
> > +                                      * feature is on. It indicates th=
e
> > +                                      * recorded timestamp.
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 3a4110d0f983..16e7bdc1eacb 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5632,8 +5632,21 @@ static void bpf_skb_tstamp_tx_output(struct sock=
 *sk, int tstype)
> >               return;
> >
> >       tp =3D tcp_sk(sk);
> > -     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_C=
B_FLAG))
> > -             return;
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_C=
B_FLAG)) {
> > +             struct timespec64 tstamp;
> > +             u32 cb_flag;
> > +
> > +             switch (tstype) {
> > +             case SCM_TSTAMP_SCHED:
> > +                     cb_flag =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> > +                     break;
> > +             default:
> > +                     return;
> > +             }
> > +
> > +             tstamp =3D ktime_to_timespec64(ktime_get_real());
> > +             tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_n=
sec);
>
> There is bpf_ktime_get_*() helper. The bpf prog can directly call the
> bpf_ktime_get_* helper and use whatever clock it sees fit instead of enfo=
rcing
> real clock here and doing an extra ktime_to_timespec64. Right now the
> bpf_ktime_get_*() does not have real clock which I think it can be added.

In this way, there is no need to add tcp_call_bpf_*arg() to pass
timestamp to userspace, right? Let the bpf program implement it.

Now I wonder what information I should pass? Sorry for the lack of BPF
related knowledge :(

>
> I think overall the tstamp reporting interface does not necessarily have =
to
> follow the socket API. The bpf prog is running in the kernel. It could pa=
ss
> other information to the bpf prog if it sees fit. e.g. the bpf prog could=
 also
> get the original transmitted tcp skb if it is useful.

Good to know that! But how the BPF program parses the skb by using
tcp_call_bpf_2arg() which only passes u32 parameters.

Thanks,
Jason

