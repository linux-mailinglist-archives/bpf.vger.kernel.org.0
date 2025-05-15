Return-Path: <bpf+bounces-58316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A9AB88FE
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 16:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F483AC93E
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E81B21B8;
	Thu, 15 May 2025 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6ALeXWJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C734174A;
	Thu, 15 May 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318368; cv=none; b=A5sqiiUMaQ5+JlNsDCUnl6OhnDrnF6kUxIqZarXP7yD+Hxho2mWc1VektKl4JcnSPYNDGWWWAZ48p6JqAjuf1m6Q7nhn72+SuelWooAkTJpCINj/ho8O7tuxT8exdysqTpZJhi6NNBtex+c/kuxjBexnnhVHQ+kl6NzNLainsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318368; c=relaxed/simple;
	bh=5RRhaJVenCLk1rbSvNJ0OzmwxKOaaoDiaIZpYMo1mok=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g7qFN4gM8FuAZmZFf+hwbe5MU7zqXnWflyrXk1/bOZoJd2zHCKiBGxSSmstG9q9b2ell7qcebHBu4A3ThQl0mPab1r1v5Tj9fZrbvUxNoKUtXLGF6crRnWqlmcAmdpwBHy1w9/1HeheL8awdI5SUfOV66bKujBk251u/V7anVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6ALeXWJ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7caea4bc9e9so158364085a.1;
        Thu, 15 May 2025 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747318364; x=1747923164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlhYFMDdd23VaSWKYL/EzWag4DSFG2r7/eb+0LaOnNA=;
        b=G6ALeXWJ3hWrcUxb4flSz1AyEfvE3kg1t7FDWvNSHr/3u92OWtsldZKpa4/JrvHDRa
         bF88Pxk47Hdi0qmzvBednTzGP9o8iNO/hjndNZP2ZXpADDhO6yidGTvQaAArDePaE4y+
         P2vpRPAW3eJr+bof01AgOm9wr6eBGZEzXSpYqs1DYMrTvb/R0bfatsP8+hvvptXLvuka
         1F6BhaCuzxoFJG9vAYkeSxBwtPekQoTOwpAC1necnmnrlRQiWVwNZBeVUidIVyLqVEpg
         8yqPQNh52tWs+zZwBb7zTrn410wDX7sIKXQb2GzMD25ov8qLY45tZSgOlggnSLBZJ/pC
         x01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318364; x=1747923164;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JlhYFMDdd23VaSWKYL/EzWag4DSFG2r7/eb+0LaOnNA=;
        b=sqP9Sz8zIYyqQDC5hoDpyD6dPDW2OI7zDxx2YC5ExtmAWDm5BqaGWK8itO4IR9wLjb
         fO0ZUBx+fqVSaP1z+3U0zW1fGnxr8LD4aMrJ85jTJyMqEXNWG10JhXhr9eHWW2GLWRo3
         ABFmHHZ7VsP1TxIE3s+K3lLF1CtH9LixHpkBsF8NJuE3H0Bhsw5djI4EaUx4dnUstO2k
         /yuLCDZJluXo3+246VZZGKy6qz4QHd0QOI3t8IU3elvrQW/OfA93+sCvDJ+sEvmBRyuw
         vd4VbNV/GUFWW22yGwZd5bYC2FV3EmOQBRD8SxQpUoJYpQg9XCSR0rUhu0m49zbJ1fp7
         mGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1LhbsnX2D0Ro7Yaeyi7+li22PWjOr/JHPy7GA8CySky+IjLaB4Rc0lbAGCMTiRcmyL0g=@vger.kernel.org, AJvYcCV44hFRKBehZnL2ik3gcbT2pHhOUbMNrrN2vdSg2wga7MTmgmsMJLk2fMH80OBjqVnSlRVdqaXQvwyaQRbi@vger.kernel.org, AJvYcCXIVIL/9RFCgELrXe2mL2IEMfNy3TeF/oTfh3a22nsX0veKhgTuCVTjK+ar7+ZE9t+qfZHXt+6B@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIRJkgdyx6YT1yoS9Oudl1Ir2Q7HOyrFwZd6HADmR8+5SU0IF
	UtPCumonADyyquc/MkCO6CAgeJs8AXHDagghL9U/on2qetdYI7qy
X-Gm-Gg: ASbGncvROzggJrMVUf0dPqNTUUyv2A6KWvIgQn6oeNqsbNPG/mbu77hWWX0n44jUSBC
	wQMWE4XBUP/FUkDSyK7ADHzKNkMyHlel+Y//WO+Dhk8WIdzirSDSwilYS8FZBiA37kzUTDWnX6G
	mDD5/k+fRdZnQ04JXyFumF7W0kxj7B9X+irGKhvyFxYuPbw3Fgm/vPz0D1YCgbeEjCYeZBml18r
	J6yteg/oeCn+KWiCA6/c/8Z+QOQja5YRuOpglDfXQLhgjj8pmr99TLHVJ7thRD4Ft7Q35coGs5Z
	aD4WjjPQ+gd+/ZUKqtnkun1MXx8WYaIwIa7ntTonn8eeh17qx6nVAb73OmrGDCgjiHPbNJ7HWI7
	nZUwQh2ByGhGkCo0355vnMOA=
X-Google-Smtp-Source: AGHT+IE4jGyzlbSNyE/arYY6S49Y1MfWoKII6xYgI8s+WK4F7swz6OVtcfQ4RX1E4lr8RoUDI4uwqQ==
X-Received: by 2002:a05:620a:28c5:b0:7c5:6140:734f with SMTP id af79cd13be357-7cd3c67bc7cmr368934485a.18.1747318364297;
        Thu, 15 May 2025 07:12:44 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd00f63ba2sm990768585a.44.2025.05.15.07.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:12:43 -0700 (PDT)
Date: Thu, 15 May 2025 10:12:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Shalimov <alex-shalimov@yandex-team.ru>, 
 willemdebruijn.kernel@gmail.com
Cc: alex-shalimov@yandex-team.ru, 
 andrew@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 jacob.e.keller@intel.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 bpf@vger.kernel.org
Message-ID: <6825f65ae82b5_24bddc29422@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514233931.56961-1-alex-shalimov@yandex-team.ru>
References: <681a63e3c1a6c_18e44b2949d@willemb.c.googlers.com.notmuch>
 <20250514233931.56961-1-alex-shalimov@yandex-team.ru>
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Shalimov wrote:
> 06.05.2025, 22:32, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>=
:
> > Perhaps bpftrace with a kfunc at a suitable function entry point to
> > get access to these ring structures.
> =

> Thank you for your responses!
> =

> Initially, we implemented such monitoring using bpftrace but we were
> not satisfied with the need to double-check the structure definitions
> in tun.c for each new kernel version.
> =

> We attached kprobe to the "tun_net_xmit()" function. This function
> gets a "struct net_device" as an argument, which is then explicitly
> cast to a tun_struct - "struct tun_struct *tun =3D netdev_priv(dev)".
> However, performing such a cast within bpftrace is difficult because
> tun_struct is defined in tun.c - meaning the structure definition
> cannot be included directly (not a header file). As a result, we were
> forced to add fake "struct tun_struct" and "struct tun_file"
> definitions, whose maintenance across kernel versions became
> cumbersome (see below). The same problems exists even with kfunc and
> btf - we are not able to cast properly netdev to tun_struct.
> =

> That=E2=80=99s why we decided to add this functionality directly to the=
 kernel.

Let's solve this in bpftrace instead. That's no reason to rever to
hardcoded kernel APIs.

It quite possibly already is. I'm no bpftrace expert. Cc:ing bpf@

There seem to be two parts:

The field lookup in struct tun_struct. This should be captured by BTF:

	$ bpftool btf dump file /sys/kernel/btf/vmlinux | grep tun_struct | wc -=
l
        1

The cast from netdev_priv to struct tun_struct. Note that in recent
kernels netdev_priv is just args->dev->priv. No need for this manual
struct tun_net_device.

> =

> Here is an example of bpftrace:
> =

> #define NET_DEVICE_TUN_OFFSET 0x900
> =

> struct tun_net_device {
>     unsigned char padding[NET_DEVICE_TUN_OFFSET]; #such calculation is =
pain
>     struct tun_struct tun;
> }
> =

> kprobe:tun_net_xmit {
>     $skb =3D (struct sk_buff*) arg0;
>     $netdev =3D $skb->dev;
>     $tun_dev =3D (struct tun_net_device *)arg1;
>     $tun =3D $tun_dev->tun;
>    ....
> }
> =

> Could you please recommend the right way to implement such bpftrace scr=
ipt?
> Either better place in kernel for the patch.



