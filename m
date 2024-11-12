Return-Path: <bpf+bounces-44681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DCD9C6500
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 00:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44B41F21A91
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 23:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9B21A4BA;
	Tue, 12 Nov 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6o4GqbS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826216F8EB
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453446; cv=none; b=ntg6TI0KGha1ynbztxf9f1GO/vOsEpoGZfprwnv7I8dRfYBsaeRkg462TAXHN+73bgecTw1Nm+12qozb5xU7z0m0bw16bsxEZBMPlFMKCbI6NA/7CWgWc4gg6MkJiz4np0K/5nhscAKKXg1a0hiF7k8d1/sSBxnJ8mtaMU917zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453446; c=relaxed/simple;
	bh=dvXKashSdNBLQ6SItp4GTR/uT96g5qqSo8qpbiwNnjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2J+l1qPL4DbKiYcQzdZow08GNmK6kt07NUbHVbFnjjrelZyhNVJGKQ/qgaWJbcUokcaNqIAqhJfxahge+Bmxcx5JlLrf+2wBKROrjmUF5l2N2irvqiVu1QrKdEC1zSRlr1EH/20rnh8pnhe0c7xEDsWrJmktWlf+kWX+FUGDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6o4GqbS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbcd71012so73121545ad.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731453445; x=1732058245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dvXKashSdNBLQ6SItp4GTR/uT96g5qqSo8qpbiwNnjg=;
        b=B6o4GqbS8LyP1qujYcMriBMFyubeSQtY+0Vv75hx6qGSECtwoveuwO+g1MPRs5K8vK
         0rUVNFBoiL9I/MpdNrscFyEwhFrVsDHDNuFE+wr2fpff8uDm7t18UA6IRhkptmQs7R+U
         +dzD8V4ELLKV3NnB3C5HxYaSiCp/rrDS/2PbxjShrlgMYRO5Gtgqr4Fg6MTBRCDXmJQo
         ZTwjybVvUEvuz10Bod6FKz9FtbnFmRK2QMLBJ7lV5S+1YKiSea9p+03vWwUd1KDJGpPZ
         ZNUyuZdmVtq/BxiQJ34FEXwl643xhnCojYE5ZmadX0lFpVBa4g4pxOmeG94SVqjtqIkf
         nYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453445; x=1732058245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvXKashSdNBLQ6SItp4GTR/uT96g5qqSo8qpbiwNnjg=;
        b=OjNJpabuOUti+LyhWgGPvwxYghbasUgRs/+6M3aKFjSehgTHWtOFtfDGOtx4BCsE46
         qrRdzY+wjDwRnOb9RKtTIXa3bLlKXB0yU3h2OaxdhyDsJ5oJbXmjmZWPKu4lNbJg73Fz
         8FG3+9fwA50xKyE1B7CLykHTjb6R394pwkoceK9+tjSwetU8cPAhnSfUUfyUw3bOeldw
         djFkAE36n01zaaKwsdmxeD7VmFEeYDin7hbLvrhAWjEp+L69GNHBZyBcFW+xT3COs0P6
         I+DoERymbmIRr10mMeMpVSRZKX56X47atLrhoHlpjucSOVdZFkkGiBeODTPqFL4mMW4q
         LmSA==
X-Forwarded-Encrypted: i=1; AJvYcCUk7CDwt3LSjdHLu3Vs1zDW0+FgKk2q/JSkQd0ssHyVj+n6hmXzteQucuNGLABD6d9XG3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWrR57XVOafWuQJ4/RwkgMFZ5q4OhH4IUjjRVl+H2206ekqH6
	0qaOPs+T67Ye13/ahkEjGyF2hVpAC2ez5ZNux+x16ZXiHLFqv0M3
X-Google-Smtp-Source: AGHT+IFlOJWqFxbgxynHXVG3mZj4fp/SB1018g1Mt7/6hZonoqYW7A3vsXOVP7T5rpXe8+JKAqQ+iQ==
X-Received: by 2002:a17:902:e750:b0:20b:b238:9d02 with SMTP id d9443c01a7336-2118354cf5dmr255219815ad.33.1731453444758;
        Tue, 12 Nov 2024 15:17:24 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9eb9sm98767225ad.23.2024.11.12.15.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:17:24 -0800 (PST)
Message-ID: <96cb9c896fcfd48e3c2ca7d757713dae47aeba12.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: add selftest to check
 rdtsc jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,  Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
Cc: x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>
Date: Tue, 12 Nov 2024 15:17:19 -0800
In-Reply-To: <20241109004158.2259301-3-vadfed@meta.com>
References: <20241109004158.2259301-1-vadfed@meta.com>
	 <20241109004158.2259301-3-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 16:41 -0800, Vadim Fedorenko wrote:
> get_cpu_cycles() is replaced with rdtsc instruction on x86_64. Add
> tests to check it.
>=20
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


