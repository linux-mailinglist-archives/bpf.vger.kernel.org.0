Return-Path: <bpf+bounces-61815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD68AEDBA7
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AE93A5E4D
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60C283FD2;
	Mon, 30 Jun 2025 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcWiQuLF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82998280338;
	Mon, 30 Jun 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284288; cv=none; b=MZ8pdO/wQmDEL4FZxRmR+ffGrlqvFSNk7dVviiCPuz29VMG4v/MsAXIWstxdWv+gJT+GjivBtgqoinkm1h1l4GMS5lpsuK+t7phoUgtsKSip5hUqmpDq+6EGtoBMMM0zGj8rkbx/z9TNbOWFZL96ftw7UHPuGERjf/SV+BXDkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284288; c=relaxed/simple;
	bh=HUbdQ19sl514KfajAwJVU7L3W1cY3+nFral3SJF0RbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPfjrDdE4Ih8endqPDdB0F3MpXuMNM/Hk4WEQJgaweovLcSdOxawAyJMaTLvwWhC+QdjzP4oDNLNyejouQZQBSCGVFknezQo/Ayr+1en7L+tt6iVAT3jXJx5OmcRiPdXxjDQcFCXjI94vGBqfu6t7s1x86T78tnJGuPJGmegOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcWiQuLF; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so21186175ab.2;
        Mon, 30 Jun 2025 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751284285; x=1751889085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVoVStbXU6ccjSQ1NePiUp1BW7p4LaA0FGyVw4Z6EYA=;
        b=EcWiQuLFr7gEeEsSJY/0tM5vdOJ4RY/JuvtjttiBnJlz8YSbbtn1jhfzckLogYe8xq
         jdP92s3ptt39zc/qNZ7PuFAUNROWk8c2lri48BnxF4V9zOhQuqoo+QZkKWeiq/FfX1jp
         spwdu0fR+l0nquYkEzwk38mIlyez871S3URIGEvLKqrthyKyCA44XJhJN0DKOCXyAWTW
         kQXFkhQ26lmzSgpZ7BwqpSZKyRXQfNgzICvGtEwN+Tg/J7n/pF2YXUP4K5QPvRfE6SJR
         Fy2yg7ltow+aCE3feTbxmwn/KJWxkXFimkFJvY9a3Q5NURZLjq5qCusNfMeg1f37OxX9
         l3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751284285; x=1751889085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVoVStbXU6ccjSQ1NePiUp1BW7p4LaA0FGyVw4Z6EYA=;
        b=UMvIEPfuInpg9pW7gMP17HQ8YwYpDry9S/8lphjkLY3RDx1w8zNoWqwWl0zqiOzkHv
         BDLkSy49attuGdnixoygXSoK9tFM/LITGivuUEnfm8WY2ZtSZfi6CbNCLLgRhEbMLJFy
         VEVj9g6De5wZnFajIWqSHMebRGNJYfrJgZZKJzq96ahfKYR6zqJCs+D63NjHM51gxmqL
         yZIKAeYDYT2JBY328drSVCKpLSgpekVsw4R3HN9+GtRmSvysWUjEF7jPvyUo28zIkiN4
         0nYa63oZGpnMBCwGsRMg2iycX4SLubc1dwMcG5gby98InBYQomNw+gMQNRAXkRoBro39
         CScQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp8Ybu03RdVq7QsEwAK2AZHgtWS8Fn+qbVgxGmR0YOyY3MNxGSuYh/di+fn1jv9lxUbXqTKV6q@vger.kernel.org, AJvYcCXqR1lhWaUJhvg3S9au8Oety0h5EguRHPTbPhGj2ecspqH/wRvjE4+XXBYHICs9rMQ/s1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnECsyheQ8d1r39jL7Eknc34Rh9C8lScWHItLuIpjuAR2DAyi
	T2hwLowBWePGXfFLLXvM4vCcVpHSK1GxNJ/6Z2IGA5gTu8UT923t+/yDGZtMC4K2ZRkqWzluUuN
	Hu5AEPRo99iRpAcFW1NA/OZ4AQU986FI=
X-Gm-Gg: ASbGncviExDB9cfyA2wNvj+WIRdidebcZCxGwGcSznh3cP6ZQ5Nm2KimXIA3fR3rj75
	lX8FHJwh+vYOlX8HZjk2WR6kuOasS1yHUQqBdSejwZOCO+phVJ7lEMlpdo3/vyDdMIGbbhBMj0G
	kbw644/17Ycu1ATBphXWSlsR8HUemH/v0HR1ix+0qf/OE=
X-Google-Smtp-Source: AGHT+IErVhEJ6O9QU/koTNJ7LOED3GK7DckGsViLXOhiJh57scg13qi7yQVVENlnKQUHtlM+4GytxCJiL9kzu2K5TxM=
X-Received: by 2002:a05:6e02:3d85:b0:3df:3d4c:be27 with SMTP id
 e9e14a558f8ab-3df4ab2c7dfmr143342265ab.5.1751284285471; Mon, 30 Jun 2025
 04:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628120841.12421-1-kerneljasonxing@gmail.com> <aGJ4ohHA3Cs45wCp@boxer>
In-Reply-To: <aGJ4ohHA3Cs45wCp@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Jun 2025 19:50:48 +0800
X-Gm-Features: Ac12FXx5tgVmEb0LnF7RrqgCktSLhkoEGze3OOXZPE1n-NGE2XuQW2tLm9Nh9gc
Message-ID: <CAL+tcoA6if=S3592=V503vo_BFxEJ1FgOdDA+SGOrNWtuAQuTg@mail.gmail.com>
Subject: Re: [PATCH net-next] Documentation: xsk: correct the obsolete
 references and examples
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:44=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, Jun 28, 2025 at 08:08:40PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The modified lines are mainly related to the following commits[1][2]
> > which remove those tests and examples. Since samples/bpf has been
> > deprecated, we can refer to more examples that are easily searched
> > in the various xdp-projects.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t/commit/?id=3Df36600634
> > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t/commit/?id=3Dcfb5a2dbf14
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  Documentation/networking/af_xdp.rst | 45 ++++++++---------------------
> >  1 file changed, 12 insertions(+), 33 deletions(-)
> >
> > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networ=
king/af_xdp.rst
> > index dceeb0d763aa..37711619e89e 100644
> > --- a/Documentation/networking/af_xdp.rst
> > +++ b/Documentation/networking/af_xdp.rst
> > @@ -209,13 +209,10 @@ Libbpf
> >
> >  Libbpf is a helper library for eBPF and XDP that makes using these
> >  technologies a lot simpler. It also contains specific helper functions
> > -in tools/lib/bpf/xsk.h for facilitating the use of AF_XDP. It
> > -contains two types of functions: those that can be used to make the
> > -setup of AF_XDP socket easier and ones that can be used in the data
> > -plane to access the rings safely and quickly. To see an example on how
> > -to use this API, please take a look at the sample application in
> > -samples/bpf/xdpsock_usr.c which uses libbpf for both setup and data
> > -plane operations.
> > +in ./tools/testing/selftests/bpf/xsk.h for facilitating the use of
> > +AF_XDP. It contains two types of functions: those that can be used to
> > +make the setup of AF_XDP socket easier and ones that can be used in th=
e
> > +data plane to access the rings safely and quickly.
> >
> >  We recommend that you use this library unless you have become a power
> >  user. It will make your program a lot simpler.
> > @@ -372,8 +369,7 @@ needs to explicitly notify the kernel to send any p=
ackets put on the
> >  TX ring. This can be accomplished either by a poll() call, as in the
> >  RX path, or by calling sendto().
> >
> > -An example of how to use this flag can be found in
> > -samples/bpf/xdpsock_user.c. An example with the use of libbpf helpers
> > +An example with the use of libbpf helpers
> >  would look like this for the TX path:
> >
> >  .. code-block:: c
> > @@ -551,10 +547,9 @@ Usage
> >
> >  In order to use AF_XDP sockets two parts are needed. The
> >  user-space application and the XDP program. For a complete setup and
> > -usage example, please refer to the sample application. The user-space
> > -side is xdpsock_user.c and the XDP side is part of libbpf.
> > +usage example, please refer to the xdp-project.
> >
> > -The XDP code sample included in tools/lib/bpf/xsk.c is the following:
> > +The XDP code sample is the following:
> >
> >  .. code-block:: c
> >
> > @@ -753,27 +748,11 @@ to facilitate extending a zero-copy driver with m=
ulti-buffer support.
> >  Sample application
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -There is a xdpsock benchmarking/test application included that
> > -demonstrates how to use AF_XDP sockets with private UMEMs. Say that
> > -you would like your UDP traffic from port 4242 to end up in queue 16,
> > -that we will enable AF_XDP on. Here, we use ethtool for this::
> > -
> > -      ethtool -N p3p2 rx-flow-hash udp4 fn
> > -      ethtool -N p3p2 flow-type udp4 src-port 4242 dst-port 4242 \
> > -          action 16
> > -
> > -Running the rxdrop benchmark in XDP_DRV mode can then be done
> > -using::
> > -
> > -      samples/bpf/xdpsock -i p3p2 -q 16 -r -N
> > -
> > -For XDP_SKB mode, use the switch "-S" instead of "-N" and all options
> > -can be displayed with "-h", as usual.
>
> Hi Jason,
>
> these commands above should be kept as-is imho and we should point users
> to new xdpsock's location:
>
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example

I thought we'd better not refer to an external link that might be
unreliable in the future. It turns out I was wrong.

No problem. I will revise them because for now it's still working well.

Thanks,
Jason

>
> > -
> > -This sample application uses libbpf to make the setup and usage of
> > -AF_XDP simpler. If you want to know how the raw uapi of AF_XDP is
> > -really used to make something more advanced, take a look at the libbpf
> > -code in tools/lib/bpf/xsk.[ch].
> > +Xdpsock benchmarking/test application can be found through googling
> > +the various xdp-project repositories connected to libxdp. If you want
> > +to know how the raw uapi of AF_XDP is really used to make something
> > +more advanced, take a look at the libbpf code in
> > +tools/testing/selftests/bpf/xsk.[ch].
> >
> >  FAQ
> >  =3D=3D=3D=3D=3D=3D=3D
> > --
> > 2.41.3
> >
> >

