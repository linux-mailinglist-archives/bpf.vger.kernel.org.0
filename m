Return-Path: <bpf+bounces-41821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1775B99B828
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 05:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C26B21077
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162712D773;
	Sun, 13 Oct 2024 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQQniB7Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79132F32;
	Sun, 13 Oct 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728791069; cv=none; b=dbTCFI9fX3G+gVAvBZDQ4PRfV/GMH/9NF1m/TYiY7SGC5xxqN0hIUdlN4s/OacrZLOx32Sye3Ukff1v+8S/nNZB5zMMp+Thgb+beCuwNeKQGmVkFR7DqQTGTGiYA+QAK/YroXbHZu2IWEfiSXVsKIxhW0Bh5eDDOntHj5JXa8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728791069; c=relaxed/simple;
	bh=fD+yBTzY+VRkPpNuuawmArRdA6ZiaPgMeL8qxug5m1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lszyKfUNh4naCPv6NmVuffpnOS8DULJMqYe4CtAhlxXjMjbkkTX/k+PbU++0usrxXNUEwYu86+jeFvfenCdzIW0fn9p2b0roLiChIYt2gEA8F2ZJ2KUvXqNcZ6jFbVX+kyskr4KBVYXFgsN0hR29NXc5VjdYC6ZvlNmY7qtVl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQQniB7Z; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a39cabb9faso10891605ab.3;
        Sat, 12 Oct 2024 20:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728791065; x=1729395865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBI4zAZ3xLhFRzT01S8Qd2MLhVethc1bvcMVmsscP3o=;
        b=CQQniB7ZSDLhaxOIyJhhlausn4XVTFkQPeR7Yiyp7rSvXUspk7z2BD7xQ/oJJVnQA6
         kiqg1yU7IOQMdXNqFLTO4VSPM038YVr40N3YyRGeEqt57J9PilszAC5kAk3s5EEv9byW
         TFd8Mf8jRDZ6rYcZbF9HtTn7+Ia616gsQQRkIFklpuZTgb7EChadsZDJsM0NeB3Y+OP/
         10vpk6iaf1HvEgvF0L8jW8Ts30AI1Q/deUrGWPmx3ky7ATlxLluIW+hv/3YjEmjawzs9
         +u37E/L+kwYVaRB0YfNh9UpCGup7D5MEAqLahm3B0BWjKizGHm3yN8cZIOZTQfOURnyX
         oAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728791065; x=1729395865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBI4zAZ3xLhFRzT01S8Qd2MLhVethc1bvcMVmsscP3o=;
        b=j8rOCFVjWEV+1rmSqaqp8ypJRei/qRUHn2Cebkhbd23onFJ0hVZQEGEy+sDPhY1Uo9
         iScR7Tbrgmw97fIMbS6URhbmzfVxqzlFzPp2KdqgAQa71OL389WpMxlgbKmughg2MbWQ
         3nciUDtCKqyXLcCj9AhdcANQRNM0ytSkxqCKkebQRd42NHHTDxgB0nmsERVoFRORySOl
         GznV8KUFZdIV+BY6w1IDDGkke6r4wYDWM5JHzSD57UTlwB4ZyQoprTaijZmTUf1xj952
         p5W2+yr0IihDG5lI5qk/6mp1ORcBShj3ZXIk32NfzY/18IbrrrWZ3KjHZmhJgv3y5Wfa
         f+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx5/82aBg2yG5002hmuH6MdP4KNmj/3M5+Lerdz7gCpRS0aHevJMp5i16whB6jXq9LxccBwUIG@vger.kernel.org, AJvYcCXLdY7Rg35FVubr13zYY9NnUqDVzvObvcIHcVDlAbE06nyDxseaZvc39M7DlYKmwI3scSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YHXNaz3lqDE4zaN6Kd3p4zM7mG9Jk3U7xp1q03BCOBbthMYf
	mxcVib/B1l75ZsjQhCSjRccyYfS84hRV0HmKGCoANtHg/DpdZ341kO/eW+wESFz060QjQYo78fO
	mYYXMC1sl+YhIqr7bfkFXzdGoqTA=
X-Google-Smtp-Source: AGHT+IHkIkmGPC4w5BfCmj6pay7q+CEdqTz690E1prQpjGkD80lafcWICvsGjQr2VoS9QghUnI/IffSRFOgWQQH6558=
X-Received: by 2002:a05:6e02:168a:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a3b6022e6cmr54510935ab.18.1728791064799; Sat, 12 Oct 2024
 20:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch> <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com>
In-Reply-To: <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 13 Oct 2024 11:43:48 +0800
Message-ID: <CAL+tcoCwQpM3mMsB3Trw0XrHoLcHqSFxU1LSs0AxUyiZc1wNgw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 11:28=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Sun, Oct 13, 2024 at 1:48=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by usin=
g
> > > tracepoint to print information (say, tstamp) so that we can
> > > transparently equip applications with this feature and require no
> > > modification in user side.
> > >
> > > Later, we discussed at netconf and agreed that we can use bpf for bet=
ter
> > > extension, which is mainly suggested by John Fastabend and Willem de
> > > Bruijn. Many thanks here! So I post this series to see if we have a
> > > better solution to extend. My feeling is BPF is a good place to provi=
de
> > > a way to add timestamping by administrators, without having to rebuil=
d
> > > applications.
> > >
> > > This approach mostly relies on existing SO_TIMESTAMPING feature, user=
s
> > > only needs to pass certain flags through bpf_setsocktop() to a separa=
te
> > > tsflags. For TX timestamps, they will be printed during generation
> > > phase. For RX timestamps, we will wait for the moment when recvmsg() =
is
> > > called.
> > >
> > > After this series, we could step by step implement more advanced
> > > functions/flags already in SO_TIMESTAMPING feature for bpf extension.
> > >
> > > In this series, I only support TCP protocol which is widely used in
> > > SO_TIMESTAMPING feature.
> > >
> > > ---
> > > V2
> > > Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljasonx=
ing@gmail.com/
> > > 1. Introduce tsflag requestors so that we are able to extend more in =
the
> > > future. Besides, it enables TX flags for bpf extension feature separa=
tely
> > > without breaking users. It is suggested by Vadim Fedorenko.
> > > 2. introduce a static key to control the whole feature. (Willem)
> > > 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature in
> > > some TX/RX cases, not all the cases.
> > >
> > > Note:
> > > The main concern we've discussion in V1 thread is how to deal with th=
e
> > > applications using SO_TIMESTAMPING feature? In this series, I allow b=
oth
> > > cases to happen at the same time, which indicates that even one
> > > applications setting SO_TIMESTAMPING can still be traced through BPF
> > > program. Please see patch [04/12].
> >
> > This revision does not address the main concern.
> >
> > An administrator installed BPF program can affect results of a process
> > using SO_TIMESTAMPING in ways that break it.
>
> Sorry, I didn't get it. How the following code snippet would break users?
>
> void __skb_tstamp_tx(struct sk_buff *orig_skb,
>                      const struct sk_buff *ack_skb,
>                      struct skb_shared_hwtstamps *hwtstamps,
>                      struct sock *sk, int tstype)
> {
>         if (!sk)
>                 return;
>
>         if (static_branch_unlikely(&bpf_tstamp_control))
>                 bpf_skb_tstamp_tx_output(sk, orig_skb, tstype, hwtstamps)=
;
>
>         skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk,
> tstype);
> }
>
> You can see, the application shipped with SO_TIMESTAMPING still prints
> timestamps even when the application stays in the attached cgroup
> directory.

I tested this by running "./txtimestamp -4 -L 127.0.0.1 -l 1000 -c 5"
in the bpf attached directory and it can correctly print the
timestamp. So it would not break users.

And surprisingly I found the key is not that right (ERROR: key 1000,
expected 999). I will investigate and fix it.

Thanks,
Jason

