Return-Path: <bpf+bounces-49739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C77A1C02D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014033AF3C2
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83A1EE01C;
	Sat, 25 Jan 2025 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G78h+9Mz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AC150980;
	Sat, 25 Jan 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768134; cv=none; b=YukS42QdKGiEDmuQiymhSJliDDXVsk3cyAZeeKPR2lLAL3+wfcnb2FkmMUONIehAhuWnmAvwcipvsrvnLYG3MYrKKom7N5N82wUd3aY6OKKnDAJiNM7uTexkdwGPAO3eYGG/16JSscsU9FMNCrU50Zaj0qlYO2F0d7PMvs7px94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768134; c=relaxed/simple;
	bh=UCBA/HowwVC7GNobtr3cxdadzs7h1tjadFAN/cUCWiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNmv8umBI4Y9b5HDn4XpKVG7BuFBv5wrMd+C1mlaQ1rOtvLwCalAUlujt/mNAyqj6pShAlHDccJQfzzPgBk+OTp6Q9wfWkypD/Jb17G8or7lTP0Iz1D7XtrkzjyWRr5frcn79Zn1sKhi/iTt4sYbF6XpijmJrLFBGvVylK07Fwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G78h+9Mz; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a8146a8ddaso7179185ab.1;
        Fri, 24 Jan 2025 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737768131; x=1738372931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/TAS7BErCR+/XX/PyO/JwKfwhAmhKgXmdcSFl/pB+g=;
        b=G78h+9Mzt+mBXNf2IQ8gzMRcB83Cs0ShMnPmwK8ZH5SIURICH2QzxXR4ooaoP0rF6x
         7LUlLgoM2QYN1Y0qEq3QiwvN3DtK5gNE6JpIke6MMfHk4JT6Jn2d66v9JqJefZWRc2u1
         B1cSUM8SwMY6NB/vlzJvt3ggVFTE5H3rLgELfsIgreA/b/FRJ2HwWdFpTgDgj4YbyOT+
         fC1ZJUmSADb6ULhdbqgdwyz0OyuIPSGCXwnO7M+JhqYMDH0duO/eXj6n10YwlkKu4luY
         xbfMPIyr4zyWf7TngCS/dqVj4VZ8MXwCFsjQfIbPrG33NEkPESiXE4ZzfgLH9pfzyan+
         923w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768131; x=1738372931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/TAS7BErCR+/XX/PyO/JwKfwhAmhKgXmdcSFl/pB+g=;
        b=lJ9r4x0QkMxV9ugiat+g/4Ww2MnNp5VK6azK5MPGfwfbrlEj20seX+twffgjSdQvwy
         lGZ2rePmQraOBexX88D0cQGFDs3Sxxx5s333fK9JDwlaO/ZnXRhFYAuTd3RIOkKnRhwz
         zpwbZkl7ZXUmv6+QBSk2gn1zaZ7osPKrUnDAWK7uVXXFxFPn09PiiMacUvm4WT2oa4MF
         2wf2qjTXpmnmaUa+Nrprnec2KC+FmizdAgWzyVQjJdJPfEIwvpgKIjuVSm/UR/xyEmsh
         XXiVEnH2i3E9H+88fKm3eSCSXp5MinM2Os9mlSDfM+H+I1paQ2Z1MuQFkvFDRNCoUZeN
         PTDw==
X-Forwarded-Encrypted: i=1; AJvYcCW+XF7gsEPZYzCt6Nu3i8tb13ej38+PEtrmJE7+ntoK3zo4enC8EqQgkp43Hy+FUra4Csku0HFe@vger.kernel.org, AJvYcCXuYRWd8AenLt4qx2JF2R2LgvsHzXlmsCVgAZkP80V7fMI9zbBQxBQhoF+pDco84JVui7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3MVi4MHWxKa5TgDjKJQpQl4XptHHLZ8FvrmI4bNMasZQSTxX
	a/4HkwpkieTvl9UmdjHaqe8z8JY9bZL8ur7mfw9qGAsXzrG0qc8kIVlk2iEV1E7YkNiv/z3k2nq
	4hVdmRp4ug0ax7ZYWZg1iKRCIoeg=
X-Gm-Gg: ASbGnctqZe0fJYT4cFdS9IyJjjQENt+NCHNl5lKxen41E8pcKgsIxOCsqk9bIVMDSMb
	h90WcP0CAJGFPPOHA9uMGvXCyILqHxz4yzMGN9Uz1YuKWrY1X+G9YT/p1wm+92A==
X-Google-Smtp-Source: AGHT+IHTZdqV507loK77LIBD4GUhIPEF6v0TrQeRI3qND+azANNUKFJN+kdNv6d2Z2bmLPYsRCr0RJeCAXu71dhzUoA=
X-Received: by 2002:a05:6e02:20e7:b0:3ce:7fc3:9f76 with SMTP id
 e9e14a558f8ab-3cf743eae5amr253747745ab.6.1737768131511; Fri, 24 Jan 2025
 17:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-12-kerneljasonxing@gmail.com> <db1c1edc-f02f-4755-9b6d-b1c1e9b90564@linux.dev>
In-Reply-To: <db1c1edc-f02f-4755-9b6d-b1c1e9b90564@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 09:21:35 +0800
X-Gm-Features: AWEUYZkNKJoSGoNNmaBJ-hWYuY8fy0k1f66_zrMVt5is25MAJnmOjRT9xAfy1Y8
Message-ID: <CAL+tcoDT7KpTSgon-QORLZazgXoCJQHBuwADmV8URH272M2EdA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 11/13] net-timestamp: add a new callback
 in tcp_tx_timestamp()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 8:50=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/20/25 5:28 PM, Jason Xing wrote:
> > Introduce the callback to correlate tcp_sendmsg timestamp with other
> > three points (SND/SW/ACK). We can let bpf trace the beginning of
> > tcp_sendmsg_locked() and fetch the socket addr, so that in
> > tcp_tx_timestamp() we can correlate the tskey with the socket addr.
> > It is accurate since they are under the protect of socket lock.
> > More details can be found in the selftest.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/uapi/linux/bpf.h       | 3 +++
> >   net/ipv4/tcp.c                 | 1 +
> >   tools/include/uapi/linux/bpf.h | 3 +++
> >   3 files changed, 7 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 3b9bfc88345c..55c74fa18163 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7042,6 +7042,9 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_TCP_SND_CB,     /* Called when every tcp_sendmsg
> > +                                      * syscall is triggered
> > +                                      */
>
> I recall we agreed in v5 to adjust the "TCP_" naming part because it will=
 be
> used in UDP also. Like completely remove the "TCP_" from the name?

Right. The thing is that, after that discussion, I altered my thoughts
because I'm not so sure if I need this for UDP (I need more time to
think about the UDP case) which can be trace by fentry, sorry.

I will follow your instructions to remove "TCP_".

Thanks,
Jaosn

>
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 0a41006b10d1..49e489c346ea 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -500,6 +500,7 @@ static void tcp_tx_timestamp(struct sock *sk, struc=
t sockcm_cookie *sockc)
> >               tcb->txstamp_ack_bpf =3D 1;
> >               shinfo->tx_flags |=3D SKBTX_BPF;
> >               shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> > +             bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_TCP_SN=
D_CB);
> >       }
> >   }
> >
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index b463aa9c27da..38fc04a7ac20 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7035,6 +7035,9 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_TCP_SND_CB,     /* Called when every tcp_sendmsg
> > +                                      * syscall is triggered
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
>

