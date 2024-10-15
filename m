Return-Path: <bpf+bounces-41949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6BE99DC73
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283E81C216F0
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334616D9B8;
	Tue, 15 Oct 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVP4u8Y2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF966AB8;
	Tue, 15 Oct 2024 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960766; cv=none; b=R7v1uuB+ZbHoRD/5EuwoXzBLie2FlkAPmDobJq6D/4c/f7go4GTOwv4HFNW+WedyMONVSBNxaOEh5msMex0Ii7jWEyPZr6aKPx023TKTsZU5R0d2JDytYH/sp4LiL7UjPYpVGi9qm6DmWCjfgvr3gq0I+gyCmSiHtzudZQZg3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960766; c=relaxed/simple;
	bh=GbzxacKMo5PpZHC9naYTwiDvQlduvxISA7N+n9/rKHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K24smBYcf33FoyXkirbiHJjNjvCsV3LC7PGmhi5FxdknAtyBCpmzKlEwFRz8ZoBuLcGDiuWYrZp9fZEpk89lhKermtNtEWI87fAp8qPQMAZU43Nlo11dxXroTZ0B2DV2QlLydYPq3bYixoxk5akS0+vc8FZ98bLC092f3RutBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVP4u8Y2; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-836f1b47cdfso233909939f.0;
        Mon, 14 Oct 2024 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728960764; x=1729565564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAJLyBEeYIoMR80aOX4LYJxaHBn4sMugZLgLsnApHn4=;
        b=EVP4u8Y2F7e43f1kmbLa8faZDzRnoJZEi2jj22jB8/Fimgt+9G4w0VIvq56pZ+pRmd
         M2UWaV3frd5J4C8NeZYG8kJ7eYia9W/GDWzF+NKQIIszq+sJbTbRlLbXsHqrOdSuYeFy
         2Ei9OPXvDfr/Uf2I+QICVIEn7WX+QnmfDtx1VuraZvwguJfixlcHBB95SrHrCjWU5M7g
         JbHcmvBWrB/NHbX1+Rac1hlP1s+4I3TnHf9JnquK155MLH3NOlsXUrZTR2rHcLiXgvr4
         k4aLJLDIShY/DhcKkjwM2PfQQNGLud0KTgwhGGR3aLnzPltrmYu2krCcJFEBUI10NC2p
         W2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728960764; x=1729565564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAJLyBEeYIoMR80aOX4LYJxaHBn4sMugZLgLsnApHn4=;
        b=iJcLtWS/qV5XLblgPOWpxEgDARDVn5k9IkbCGpRPuuJhcbS2AlDEoRarpQ1OmBtpTE
         fkHsbOjEqrAg33gu3BiMQxa7uBak/VF7ILvGYmQPt9+Z+Nz7U0/B5Hhdnv/HgpwaO8y/
         AEue18wvx3NxV3J8TDHN/0yjWR6JXtKkhg1GUhmo3b7McMkFOT/0obVRrt3wPuK98s3F
         H8/pEKh7CwSsaH7tEDNk5OE92bmSGqaet/CzVkqY/jS26jNfwdmPIMb/+9iZ1FXXFlgf
         QdckmaKXMRTYmjKR5eVVTZwiDz4e7Pz+rYTAziF8B4Mm2UfaNULf1Rbr1darAfLCriTy
         Nqww==
X-Forwarded-Encrypted: i=1; AJvYcCVn3mY1eyDDmzlfhA2Sol8ceYErARvdH+Xmile4z2jriNXiX1rvTa8JQgR1OXP++wDWrPU=@vger.kernel.org, AJvYcCXrAaVyPxcjZdLtwyNENykVUgyGculkDqnpB+I+mO8+QEWyYOPX0LUBW6a9dGaL+n8hSD9DXA3/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1XRR/XKt9Rr1Dmd5gQ//VhSeDZWXPBWTCuz7sZTgwu2KZfhn
	XcnvwNhRNXjJGoRM8tgbUk7Cd/rCvJc4do24r0bU+JnyboqvtGSQGAj8qCvOwzmteCxOluThQR4
	EC50fxOIo8JkaR86dK+3zBgn3D6U=
X-Google-Smtp-Source: AGHT+IENafkjKNk+0Tx3LMODWVNovShvGzPA+mrRg5i7AYhWJUndKlRzNBDCmq01XIDRnnEc3gNRj8pxazgI8Zmu6Xo=
X-Received: by 2002:a05:6e02:1986:b0:3a0:9a32:dedc with SMTP id
 e9e14a558f8ab-3a3b5f863fbmr110122075ab.6.1728960764274; Mon, 14 Oct 2024
 19:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch>
 <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com> <670dc531710c_2e1742294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <670dc531710c_2e1742294b4@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 10:52:07 +0800
Message-ID: <CAL+tcoA-pMZniF2wmYJBR+PKCWThT+i+h5K-cRs3P5yqe3x-PQ@mail.gmail.com>
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

On Tue, Oct 15, 2024 at 9:28=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Sun, Oct 13, 2024 at 1:48=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by us=
ing
> > > > tracepoint to print information (say, tstamp) so that we can
> > > > transparently equip applications with this feature and require no
> > > > modification in user side.
> > > >
> > > > Later, we discussed at netconf and agreed that we can use bpf for b=
etter
> > > > extension, which is mainly suggested by John Fastabend and Willem d=
e
> > > > Bruijn. Many thanks here! So I post this series to see if we have a
> > > > better solution to extend. My feeling is BPF is a good place to pro=
vide
> > > > a way to add timestamping by administrators, without having to rebu=
ild
> > > > applications.
> > > >
> > > > This approach mostly relies on existing SO_TIMESTAMPING feature, us=
ers
> > > > only needs to pass certain flags through bpf_setsocktop() to a sepa=
rate
> > > > tsflags. For TX timestamps, they will be printed during generation
> > > > phase. For RX timestamps, we will wait for the moment when recvmsg(=
) is
> > > > called.
> > > >
> > > > After this series, we could step by step implement more advanced
> > > > functions/flags already in SO_TIMESTAMPING feature for bpf extensio=
n.
> > > >
> > > > In this series, I only support TCP protocol which is widely used in
> > > > SO_TIMESTAMPING feature.
> > > >
> > > > ---
> > > > V2
> > > > Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljaso=
nxing@gmail.com/
> > > > 1. Introduce tsflag requestors so that we are able to extend more i=
n the
> > > > future. Besides, it enables TX flags for bpf extension feature sepa=
rately
> > > > without breaking users. It is suggested by Vadim Fedorenko.
> > > > 2. introduce a static key to control the whole feature. (Willem)
> > > > 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature =
in
> > > > some TX/RX cases, not all the cases.
> > > >
> > > > Note:
> > > > The main concern we've discussion in V1 thread is how to deal with =
the
> > > > applications using SO_TIMESTAMPING feature? In this series, I allow=
 both
> > > > cases to happen at the same time, which indicates that even one
> > > > applications setting SO_TIMESTAMPING can still be traced through BP=
F
> > > > program. Please see patch [04/12].
> > >
> > > This revision does not address the main concern.
> > >
> > > An administrator installed BPF program can affect results of a proces=
s
> > > using SO_TIMESTAMPING in ways that break it.
> >
> > Sorry, I didn't get it. How the following code snippet would break user=
s?
>
> The state between user and bpf timestamping needs to be separate to
> avoid interference.

Do you agree that we will use this method as following, only allow
either of them to work?

void __skb_tstamp_tx(struct sk_buff *orig_skb,
                     const struct sk_buff *ack_skb,
                     struct skb_shared_hwtstamps *hwtstamps,
                     struct sock *sk, int tstype)
{
        if (!sk)
                return;

       ret =3D skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstyp=
e);
       if (ret)
               /* Apps does set the SO_TIMESTAMPING flag, return directly *=
/
               return;

       if (static_branch_unlikely(&bpf_tstamp_control))
                bpf_skb_tstamp_tx_output(sk, orig_skb, tstype, hwtstamps);
}

which means if the apps using non-bpf method, we will not see the
output even if we load bpf program.

>
> Introducing a new sk_tsflags for bpf goes a long way. Though I prefer
> a separate sk_tsflags_bpf and not touching existing sk_tsflags over
> the array approach of patch 1. Also need to check pahole and maybe
> move sk_tsflags_bpf elsewhere in the struct.

Yes, I will use this instead.

>
> Other state is sk_tskey. The current approach can initialize the key
> in bpf before the user attempts it for the same socket. Admittedly
> unlikely. But hard to reach states creates hard to debug issues.
>
> This field cannot easily be duplicated, because the key is tracked
> in skb_shinfo. Where there is not sufficient room for two keys.
>
> The same goes for txflags.

They are not that easy to handle in a proper way. That's the reason
why I chose to use the same logic, so that there is no side effect.

If we expect to separate them as well, it seems a little bit weird to
introduce another similar flags in struct sk_buff.

>
> The current approach is to set those flags if either user or bpf
> requestss them, then on __skb_tstamp_tx detect if the user did not set
> them, and if so skip output to the user. Need to take a closer look,
> but seems to work.

Let me keep this current approach, it will not affect each other.

>
> So getting closer.

Thanks for the careful review.

Thanks,
Jason

