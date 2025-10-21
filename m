Return-Path: <bpf+bounces-71557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65270BF66EE
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B24519A3742
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5AA32E73C;
	Tue, 21 Oct 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQxK/5Hx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7435503C
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049549; cv=none; b=Z28Yo2HmcIxjR0kKPptqpEdLg/Cxv4got79OrRH4m5GuNZZh7mPC9QhXvI8FkD66MSdfeuUG2I4uaw9PFi92Qi+JDMN2/gynQg/lEtJ35zDvx5zgwznSy35qYKcUTgjW275/pEMfvgj0S2yZiwW590ZYIlP4DTj/ilPdYzYNOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049549; c=relaxed/simple;
	bh=ktWOZ8sx65f0/bJwZvgY/DZ5tkUetuyN7nRy1XtAE/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfddsszF1INfShoQLZ6szWEu0nNmGeteq0MSv83rmUK6GsxNj4gefOJAfzXYGTIsZx8QgB/Q0TMzjrJY04w+vYf/e7ZOaH/YHxoTZiR4NKlzH2p7oKrdpn+F1yAdgcTNMyGEtaKn0h30da8DRHv3GZNB11t04FWUGlilORmaqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQxK/5Hx; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93bccd4901aso470565139f.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761049546; x=1761654346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktWOZ8sx65f0/bJwZvgY/DZ5tkUetuyN7nRy1XtAE/g=;
        b=FQxK/5HxZ/yY6nHDZ5wzGjhOiq65vgv3PVwf6BJ2UYo5mcmBTPMF3h+cr3KyqAZ6f0
         hI9DNCC6LYV5WOsNSekhYUuXV2mHYM9fO1zJ7yu82Le+sCHUHSPtoEGwtwdkF60O9Sth
         n2227CZQi8YnVKDjAAyvI8oZtTzD26UIwSLNBKICCO2/f1VNRrxTR3fz/RP4aRfa/zdV
         zRduRFO4qy+lbeNIRd666QvxYUIufYeyBIMaIs9MJYXbD069nmU48lVFFZ2yLPPqJQTF
         dEqG8SmvhrvjAey6onNMV6N387oGaHhvakh93oDWR7Mn9FXbIUwDw5fEhGWdz1gxV6S2
         RP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049546; x=1761654346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktWOZ8sx65f0/bJwZvgY/DZ5tkUetuyN7nRy1XtAE/g=;
        b=TeDOYbkVGTopgbZDx3WJUkYNCDZydYuWLDve+aUMrqqD3BsZWjo4lR0u/lCU1+ISAs
         43vdqs6/p2iRBJCsZfd1m/5rEXkGem26rs5g/TFyFBIPpU4ZF9nCuPdGM0PWjsn0WGGe
         DYK9HL0yPb6FWIE4Sl+rI25ArmJsuR7fslSpWjdCWybu0dHdp4VebZ3HldOwNGCRWoH3
         q1Qnc5NDBOeU19lhADd7qx0QZLnkXuxRfTraWc71/WtBzqNdfofUk3GxAYkj4ZaY54wp
         ukoynylJ21CZZSHDez2YnoFiPTZtoWb0pLsRfqHAieEu32TXNaKOUC35JuS5IqA5Uu8c
         euIA==
X-Forwarded-Encrypted: i=1; AJvYcCVOMDH3U9AeQWm7lAzF+d7nZePf0fojUBCN1xMR4E0tj6X/6gMoZ0e+14MnzLRXs/jbpVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+lJgMCfYHmlbFElfYI4/k/I9PQbJejRowDgfI9PmnsSFFqLd
	4PQdFeOMvrye2AJajKriuQJ5NbFr1WuVYWLi6TD0SjgSpmRnXhNHtxH64pN75DJaHsdigvwBtiO
	fUruhH8ziRRyUfyt6BLPVxtpKFk+jNTJChzmY0sw=
X-Gm-Gg: ASbGncs6vrDATW6TUENwzJvCmSbfKxjJ29tJhwurGxWK4MSAMvIkZlp4OTO6xqAq04C
	KYPDkxBUcdzhOLObHGo08bQAvFiXeACfl+O+v8D0G8UN+MZcxvPqGKPsExJ3GxGpPstgS87Vz+n
	WOimTyWy+oz+fK4ZRE8bGMKWWYPPhK3DF58JTTEUvt4mxOLL0fluz85Q59sX9RwoIn+dtKx9GGI
	WTESgDDKQCnP4PFLwbZyh8vEMnmRTmItJMdSxB9qCmSi/bDBkrT2MfEujkVgMRGmdL1xIE=
X-Google-Smtp-Source: AGHT+IEPjbfrKNwYdqhrdEIinLi4QHAD2LgZDidtG7WC2qmQgFHIghWWQJSKStO7jWPBz4mHplHpo+iB8yDDyXogzpE=
X-Received: by 2002:a05:6e02:1d9d:b0:430:a65c:a833 with SMTP id
 e9e14a558f8ab-430c52ccf5fmr254378145ab.31.1761049545965; Tue, 21 Oct 2025
 05:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu> <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu> <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu> <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
In-Reply-To: <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Oct 2025 20:25:09 +0800
X-Gm-Features: AS18NWCK7bntQZTu0FjGx1VkqHaElYhEKFMOKaTvnzFXM91Cgx5Y_qGTKEr-zew
Message-ID: <CAL+tcoDLr_soUTsZzFE+f-M0R83tvqx7tGjU+a5nBFSdtyP7Lw@mail.gmail.com>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: mc36 <csmate@nop.hu>, alekcejk@googlemail.com, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 1118437@bugs.debian.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:52=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
>
>
> On 10/20/25 11:31 PM, mc36 wrote:
> > hi,
> >
> > On 10/20/25 11:04, Jason Xing wrote:
> >>
> >> I followed your steps you attached in your code:
> >> ////// gcc xskInt.c -lxdp
> >> ////// sudo ip link add veth1 type veth
> >> ////// sudo ip link set veth0 up
> >> ////// sudo ip link set veth1 up
> >
> > ip link set dev veth1 address 3a:10:5c:53:b3:5c
> >
> >> ////// sudo ./a.out
> >>
> > that will do the trick on a recent kerlek....
> >
> > its the destination mac in the c code....
> >
> > ps: chaining in the original reporter from the fedora land.....
> >
> >
> > have a nice day,
> >
> > cs
> >
> >
>
> hi, FWIW I have reproduced this and I bisected it, issue was introduced
> at 30f241fcf52aaaef7ac16e66530faa11be78a865 - working on a patch.

Exactly. I simply reverted it and its dependencies and didn't see any
crash then. It was newly introduced, hopefully it will not bring much
trouble. As I replied before, I will take a look tomorrow morning.

Thanks,
Jason

