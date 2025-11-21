Return-Path: <bpf+bounces-75252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B458C7BAF6
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 21:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243E83A712E
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 20:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5922E8B84;
	Fri, 21 Nov 2025 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaEFP7xd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596C2C0F69
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758380; cv=none; b=JeCwlEX3d2uWFeqA7RHsgMRTL5Xc7btb5E/Q5a9QwuDhTHAz/jZ6YsA4Fn55wM4VqiwZn4ijJFg+N1Gw9mhM0ORgeymEApzPJ0ZgY0wnbO0Wf/pyqX4G//1V+4H68s7BaxaxKcebCDEgYm7S1qNYOS1cHDa4Uh/188MpUoxceBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758380; c=relaxed/simple;
	bh=7E2QmRfQ7Yf+oin1EVMYhgxelTvJF0kNloZAyAOxzGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cj2PZXP3SKm68cnOYlUQioMK5eCTuTLHdZt9X2FK61Ww9jP32NxO2mO0OEcEIw6J7FcL3f6AZNXta+18hOc603HYioym10WU7YE7MMiS5jJ8fm/dR9HISo+iHZtorIQPFSjFdGx3Su2tPnr0/FUm5BZwzIxNzpprmjAY2b74Wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaEFP7xd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so2849152b3a.3
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 12:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763758376; x=1764363176; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7E2QmRfQ7Yf+oin1EVMYhgxelTvJF0kNloZAyAOxzGw=;
        b=OaEFP7xdBajHHK3v8N98HbeJfO8jbj36JJu+8npkI1zf/Av087BQ5Rb1/cyFuVTvzV
         hzZTGX+feM+EFh7FYFWdns1nwC2WkVTTWL4zBb3tmDWVeKjIOYF+8afCIn0BDKmTuRHs
         HDITA9W3m1Dwb1P8C4OtfuKvxXvzb1Xsk3ZIUVne9/lUslN4WH1YNtAC19vY2SbA3MDX
         DvdCRyMtyZEEcJegftfLb7vp9bcXyzuKR4tOZzh44c+Sf8mNXqcgZI3iDJVYf1/r4X/q
         6JNWIY7jZ2gdT2SrhVd6TI8HDqh1Wb160u89wOPhpI6LERTZq51xs0RbR2vL0o3ADtgA
         S+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758376; x=1764363176;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7E2QmRfQ7Yf+oin1EVMYhgxelTvJF0kNloZAyAOxzGw=;
        b=stkEgjRq+HfJnKKGI5yjYoiUk1qVSPFDVJY+DZk7gC4VsV75Ni0tc333Dx6l4P6FCc
         Ox9Ci1CXLtN2GU6LNrRyJWlr9pKn9gdAPErAfOrgirlpkglDl5K0dHOBlg3TLZ6RpCeH
         Oxcx1pxA6tmJI3x1CmLONx+8UIydA62vjQD2i7nlGN0NCIiSP+NehJNH6pNvdccgtYZa
         JhICNMHJfznJZpzpe0nXgobZOLXovxHtDpU+o850FK9tlOgXaeKWjVfCT2rSVB6ps9pp
         QwLixmqId8NGhWOWHYDKlHJwBHrGlaTCcuvHrR8n/f4rc46Lu0oBo1ePfU+9ZsLKEV/l
         z2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv7DrMjmdt0W6Q6+sGP/v83Sl0IUcVlkeJRf8gI7bGYXv/+b3sseK+cEd9I/CuFD10QuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yIoCCyoPos71yAoIv0bpSXCrKPR+DepydCk3NNyqP6/SN7d5
	TbaXddqJ38zVdbGYM6RIkZWy4970yEN4ezS249weH2VrTHym72FEolKu
X-Gm-Gg: ASbGncunv22cq8cljucnOW5fLVLDeSwb1v+8paZy0GtPTIkqafL9fYbT5DcR7xZV0UB
	LhKzrv8h1vfxRFSILScXhSaol8Mq9EUKmyTNGdFC6Ys6qtlCL4w5Dl30+toYGjvVCGItN80bXaI
	PovMWK8neYX1qsgTejmRoIEkFOf+Xyy5CCb1wBRif4/ef+HJESBwTxhc3nrFzBrvrJ/DqQ2iG7r
	1KFOR+IUQ2gF4iqW8wDTIksNoeRAyNSBYJUSRKp1jg7m/49CE3olLqTwgFxnT5pV/RwtvEFz7gP
	4O+kRVqf+MaFpayB1r/1uMcn0ilFd2YcJ0zlxYmILob3UmucdNy1uaBfF7uSCtogeEvD8Ya5jyL
	gx5ir8DT7mgH3HGmGOMthhbxTHiLWY4xCtqYna0AZiLZhBDS+p8U0mRq7/lPhaLTMClSNj5idSt
	bTkAE1mwagmqmq0w5jKA==
X-Google-Smtp-Source: AGHT+IETJYOBOChr6LSM5tHCqXEw8JYjZ1ci7eORhb4F+ej+kh1Ld9i2CmJzGq85/Mres/je/SbXKw==
X-Received: by 2002:a05:6a00:1ad1:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7c58c2b19e8mr3933922b3a.10.1763758376137;
        Fri, 21 Nov 2025 12:52:56 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174ba7dsm6883519b3a.64.2025.11.21.12.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:52:55 -0800 (PST)
Message-ID: <37e74a8b398b8fc69797ddf16b21f21282ab0a3d.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add debug messaging in dedup
 equivalence/identity matching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org
Date: Fri, 21 Nov 2025 12:52:53 -0800
In-Reply-To: <20251120224256.51313-1-alan.maguire@oracle.com>
References: <20251120224256.51313-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-20 at 22:42 +0000, Alan Maguire wrote:
> We have seen a number of issues like [1]; failures to deduplicate
> key kernel data structures like task_struct.=C2=A0 These are often hard
> to debug from pahole even with verbose output, especially when
> identity/equivalence checks fail deep in a nested struct comparison.
>=20
> Here we add debug messages of the form
>=20
> libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent but =
differs for 23-indexed
> cand/canon member 'sched_class'/'sched_class': 0
>=20
> These will be emitted during dedup from pahole when --verbose/-V
> is specified.=C2=A0 This greatly helps identify exactly where dedup
> failures are experienced.
>=20
> [1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@orac=
le.com/
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Lgtm, but maybe also add id1/id2, cand_id/canon_id to the print out?

[...]

