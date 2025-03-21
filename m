Return-Path: <bpf+bounces-54533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96148A6B604
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 09:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D86460E45
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91B61EFF9B;
	Fri, 21 Mar 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzRxNW1P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C408BEE;
	Fri, 21 Mar 2025 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545374; cv=none; b=mcSr5l4MpOsslFhyBioyabcsowSeibzTQ6MiM4lMWy72/htueO4sXwrxH614+b/XuRIvXmhezCAHrgnHzehKI9/rx/tjIuk5L3XZGkVH5Y+Ps7CMa2wgkm1yUDL+3f7D2WhF+Qd32J4y/55v1164qA4wxCye4qgURMUh44SpyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545374; c=relaxed/simple;
	bh=FiR8bNoSbo2/6XqM1Ojy1oJbP3xb2ESxDx0nOMrezt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFxrXlLrXp7RZ2bd5kjQIZ9SRYscxNVJZK8M+1HVa/3WF4+z401kCPskD0ArKK0gxImiaQ8uCin0kG3jtBMFbBFGRz16jgtrOq78msRgAc3yv1dINzVYK0MFBCftsBq3zYeZa9ssUV1Cvdr/vo4fGs1f1T9XUGeRKZ8eNXGgNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzRxNW1P; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so2512292a12.0;
        Fri, 21 Mar 2025 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742545371; x=1743150171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5EB1Q/bNPzxlpAWO7o5BWpROZju3sVEZNDvgPYV2Tc=;
        b=lzRxNW1PsVaZYqzVxu2S+PVvkyRmGOwQpd2uLl0S+Zb7HZljiWgTKSUcb1+LQeU/Ce
         4wtBoU6yValehH5TVcpcECyPzPLwH86GqEDRPipl1en0kTJh/Uo3Y2mOVweEYs90XI88
         fr6SbF6dZ23r/OLFrCBpgHhBYdYAsu1AJYwGKx34cNijWFw28Hkr6Kgyuq8UusFMa1qs
         Tp6aV+0zCGZKtmu9ZvqJD5p9r8aecfa387fMgUKsEpPRwxkJ+xTBVjugQDje905mH2iq
         aaFr6goNkXitjGEFRGG++o2oeZf84gUW10tIzU+A3Q1vOZ381nTDqKrsXIDs4otX/FrR
         IFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742545371; x=1743150171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5EB1Q/bNPzxlpAWO7o5BWpROZju3sVEZNDvgPYV2Tc=;
        b=i7lIsgOXwFsiTQP2cIDXsG7VF4lJcxGmDBTPVdvgKJ9TOKJYzXGj3n5lKC6wVHslSg
         Ji3Wx+JwOjpjqNMDubbmcxWaJ2QD7PSa7YzrAnruUddrhejZlIUP+B86K1M/zUoze5Fy
         dFe9N0+AcPDAcoIdYRxHEABw6/X7QT0fx6lt9f6HkmGTx6bug/u1C4FT9p7FLGs1HpNj
         F60Ib1zsFcAY1wEEjC2fgCvtFBQaJ+QFu3EF4TUx+3Eb9Zq4xqRPe+nDbdQyL/BzeP4z
         ApCHONtmY0eLLwAJA/DQAmvF/9XhNy5qqdVBwiMVwTn4aN2uSeyWl5qkVWWPPEQ0W4Yv
         TjRg==
X-Forwarded-Encrypted: i=1; AJvYcCWI48fWrxjGLmmQH83hamZzd5gxcVExdWgTfXC748SLuOxtV3rEoEJoE97RFDiLrFgsYUU=@vger.kernel.org, AJvYcCXNa0uLoMWPN74YnmS8dgFSMYiEiuzLfCQi3VTCiqrtm9zVbSnkNcoE8f59MKqHhHvQWVWe+ypN@vger.kernel.org, AJvYcCXxDJ79cC9zI4e4Chs/53sV9+UuRCmC0kltAi65uI0vLcqiJJcGLej5RRGTngEosolaFUOZbJB9+BwKHXGv@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpiSoOiBpYaN8uA7ChsFzdRdkiZGPSslmSkQwxL3WbVn9UTg4
	g+yR9sY64/Tmzcu92wBCd8RugPC1Pk9XKi1fW9KZ51g1bGjJU0r62vBwHhEhaqTOYop/p2rwJle
	e9VndcYUb/hydYCM++pLgA4lWkg==
X-Gm-Gg: ASbGncvxIKZu3S491x+Ad+PRlj3FTy4XGvhYpAAWnsZfESex7LvFLDctzSUtkOsJ0cS
	CnR2Lj/fmTaZitcWmfr/eghEBy9M6l6j/wVphpLGf3Tgr3Vi5JFqy9YxBBQ4jGTlhE5gsNUOzr1
	kCxzBKSghW8NKt2drcrOvJGuzr
X-Google-Smtp-Source: AGHT+IFEj/clJ4TiD6lGeA9BIgIOoeq6FF3j6z0VANP7q0h73cH/pg3o0wIJqdcZ0fz0/auTBsdCPP+fwMJapTyfpYg=
X-Received: by 2002:a05:6402:84d:b0:5e7:8503:1a4b with SMTP id
 4fb4d7f45d1cf-5ebcd468e7amr2124222a12.18.1742545370560; Fri, 21 Mar 2025
 01:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321044852.1086551-1-wangliang74@huawei.com>
In-Reply-To: <20250321044852.1086551-1-wangliang74@huawei.com>
From: Jussi Maki <joamaki@gmail.com>
Date: Fri, 21 Mar 2025 09:22:14 +0100
X-Gm-Features: AQ5f1Jpv_KM5n370YdSx-cz5z0JMIcFja6d3n9EusYyhjwq8Mqv_ErrLR2MAkSg
Message-ID: <CAHn8xc=UeFzCybi199grR8To9yQjDyA1dMypFBMe1QCCD5S3vw@mail.gmail.com>
Subject: Re: [PATCH net v2] bonding: check xdp prog when set bond mode
To: Wang Liang <wangliang74@huawei.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 5:38=E2=80=AFAM Wang Liang <wangliang74@huawei.com>=
 wrote:
>
> Following operations can trigger a warning[1]:
>
>     ip netns add ns1
>     ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>     ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>     ip netns exec ns1 ip link set bond0 type bond mode broadcast
>     ip netns del ns1
>
> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
> mode is changed after attaching xdp program, the warning may occur.
>
> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mod=
e
> with xdp program attached is not good. Add check for xdp program when set
> bond mode.

Looks reasonable to me. Thanks!

Acked-by: Jussi Maki <joamaki@gmail.com>

