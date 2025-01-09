Return-Path: <bpf+bounces-48419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD083A07E46
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663EE188CF6F
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901218C03A;
	Thu,  9 Jan 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRGV+LLn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34117C230
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442192; cv=none; b=geFkiNrA4z2hIKBbzhAyVdYT/ytijX11M/wi47xvVxlVdFYxet8kInRcOuNRpN/lnFlxAYn+ZVXmZTrCDsIdSIQ+TNJ5VvGFcr1T48mHLX0+tR3S1KUXWZGKpPfNo8nmEwFG9CpfAUSu1PVltu9McMd6uCspj+EJKgEz73ohofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442192; c=relaxed/simple;
	bh=LTwbijH3e+9CTwXx7coYGmUJP8JWJzCux9SOtCp8tJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bt7Fzp73k6kRm2grRzhFg2z2lfvba9SAHx99mcwukx71IaOHVuNwSQOAb8+Mq0ZZqu87CJqXVCKkOuX5/41fJVQuXiBVAYd+/CtW0756r7PwerAPMkR6MxSyiBxchorWgZ5m3w75dmvrRmcaBFin3qaKLXI10t8/osFMaMM3SLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRGV+LLn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736442189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTwbijH3e+9CTwXx7coYGmUJP8JWJzCux9SOtCp8tJY=;
	b=fRGV+LLn4xICDO3uCHZRR011afMjO9mgaiBnF7kqrcNULxOHSZNuPrMkRzEAD54KUmCcbA
	sgnWzt387p8J+XlFR3I9c/SqAdY9iNQx+kJOLqBuHcIq/SMBmTwAK2QrDwQ5F+rmb/10Q4
	Lt8NDTqHgwoVNX1Ux/QhDJ3aIT3V/xo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-T2SASPPlMYmrkOcsxBoYuw-1; Thu, 09 Jan 2025 12:03:07 -0500
X-MC-Unique: T2SASPPlMYmrkOcsxBoYuw-1
X-Mimecast-MFC-AGG-ID: T2SASPPlMYmrkOcsxBoYuw
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53eca4ec061so1075433e87.1
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 09:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736442186; x=1737046986;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTwbijH3e+9CTwXx7coYGmUJP8JWJzCux9SOtCp8tJY=;
        b=tuK7lBaxRs01Ly9nthmjjB/BbVwHhdcgo/7N6DrBuT9iJlAIrUfw4vMJ9G6wmZiTsX
         s6Gqym3safcbZTmgNT9eK/j+gBBmSgAg+7A65Odt0A/NNAyt4gMcuENGORELCBSOFABi
         UXNRBmPOxugk8aMyBKaM741gf3Xo6/IxAmelhKAZ5Val3YQfuraUFQB5uUGxQkV/rShc
         abusARWOLTvujvRAB3WmiI15wbOh57L2YT7NtfizX47JTB21JNFUZP5lTuh0P+sy9YJ+
         RDjOy7TdukmrBgNA1Mw/OhHPMm6NhucbBc7C+QIEYYCPuXTpGBPx40vA+qHqlLBoUtMd
         5yXw==
X-Forwarded-Encrypted: i=1; AJvYcCW0/eam04k/9iQkaQ6l+AWkVQt5D97jYl/uU/itb8J1Cp11KAfZTeo/K7DV0OY8bALY0c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZQ6Z1BNL/Qfb0U4Xceu0yxKCYI1W//hzM3Yds4XAVf2inLxg
	f0eh5e0DFxbOEXP1Qdi1v1U0ILfvsgTQ52h+mfp4uYeyIlpHFUmhoIU2x4u8mrqM6jImfe+qcZ2
	perfY0XHfIXHUGv2IR2+k7qcBCX+c+2sdWuMXPHL0+DTxANEoDQ==
X-Gm-Gg: ASbGncu7pWPygqaxWxOvvby8AySr5crhVcD/uvu1rAzGdODy13Ab122EydtASY2A4Iu
	as6ywRhBNX3c/h7GgSm+zfmXIrFW1XmmNUCDR03r+m6bUwGjX4NXiULCXnOIAiecp0MpBOTqvsE
	280px/elSp33YwxnA49/u44csqV1LQcM1Wc0c5snfRMlOZdNmBRWMttgYkb3cr7wkDDJFuHdIAw
	ynwDM+qFiC0ZVrvrlNxjzPJ0dswNZDGcoRRFteoYVH4MVokZN4xcfFn2sNFbHQhgrv1Ay6yTCGG
	3+ALQQ==
X-Received: by 2002:a05:6512:10c7:b0:540:2d60:d6ce with SMTP id 2adb3069b0e04-5428a68abe1mr1354776e87.24.1736442184029;
        Thu, 09 Jan 2025 09:03:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAYUgH2H+LqOnRoo7/m9gv3kHlx0Ztv+dlDTJQZQb9Ao8W1+CWaxCXuEzHbKIh70tKhNTDsA==
X-Received: by 2002:a05:6512:10c7:b0:540:2d60:d6ce with SMTP id 2adb3069b0e04-5428a68abe1mr1354722e87.24.1736442183467;
        Thu, 09 Jan 2025 09:03:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428fa8439esm90120e87.208.2025.01.09.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:03:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 25DC3177E397; Thu, 09 Jan 2025 18:02:59 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Brandeburg
 <jbrandeburg@cloudflare.com>, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v2 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
In-Reply-To: <d37132e7-b8a6-4095-904c-efa85e15f9e7@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <5ea87b3d-4fcb-4e20-a348-ff90cd9283d9@kernel.org>
 <d37132e7-b8a6-4095-904c-efa85e15f9e7@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 09 Jan 2025 18:02:59 +0100
Message-ID: <87cygvj4xo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

>> What is the "small frame" size being used?
>
> xdp-trafficgen currently hardcodes frame sizes to 64 bytes. I was
> planning to add an option to configure frame size and send it upstream,
> but never finished it yet unfortunately.

Well, I guess I can be of some help here. Just pushed an update to
xdp-trafficgen to support specifying the packet size :)

-Toke


