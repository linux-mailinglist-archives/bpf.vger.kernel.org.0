Return-Path: <bpf+bounces-38536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9DE965C8E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 11:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC811C22507
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EDC16F8F5;
	Fri, 30 Aug 2024 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H05XK3JW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7D4DA14;
	Fri, 30 Aug 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009703; cv=none; b=DUXKJCZ2NI/l7aIn10zcSqD9aa1yI3HthYdCFrgMMuo3y/fNVcqERL/ihKWpkLM4TKinnsqehnOAutyFw/y5xAvzXhalmly3Ws9oyuIA1mN4Jh/L7I6mNexED+ewN8m6JyHyJHfnoSVvb94+f9ndzFAe0p0+Aq44jMywkTv7zCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009703; c=relaxed/simple;
	bh=PBa85KbK5z/zb2c0mwGne/LpgHRpLIPL8DnXi9mGrVQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=libKpMdOe83wWXIyDyoNc54eylQYN20nnKLJjt0/Wh/4HZoJcAOfmFumVNXaQpyln4htqGz3vG1hJ7yX8GuRd9oBVAYwpMFiFZFXjV8fmlF+PTf/XwQcAKWVUUezWbhT+ASkAdvLgnHtCIZ2aQdv2TH6z6MkgRxT8WeeJ9H10xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H05XK3JW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1043125a12.1;
        Fri, 30 Aug 2024 02:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725009701; x=1725614501; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PBa85KbK5z/zb2c0mwGne/LpgHRpLIPL8DnXi9mGrVQ=;
        b=H05XK3JWyxz+arcyfGuKaJJirwbJm1+baLKGlBjFZHOnArGUcvA1y5pJn0heA8mkBY
         +SLW9+vJ9OM4s51gsNQs/zmKDH6TzDLSbaIM+43O8Ls325a6NSh//jT2MBDLqG22ULGk
         OQElq4IjbXkBpSOnCpnuwPUyRUHC0oVlsVrd+U3LJRKUYqyFgyj/lMdK7bP6/JqQ8WhU
         4oWRaRKBGjng1lBqGDCeDQUhpvQWCydSUUqSblWYV5AeIwZF69xu7eVRP/9nfyTSJbWK
         jnf8r7VnmCg0ZHrx4GPlq7cAHUUul5KArzfKQOz0mzYLTl+NH0KPEuHg9uR9E1HF/9Ap
         MgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009701; x=1725614501;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBa85KbK5z/zb2c0mwGne/LpgHRpLIPL8DnXi9mGrVQ=;
        b=tKADsv3X8oC1Aewk3cPE0pON8rC+nUIMrFmU2LVdhUScS4+fauASSU8Z9y2NoFpAwo
         OZv1rxmzA4rypPkojRkjjylE4w1ORUoz9JIsecyn2K0XTK/oVkkvxJYOf4dRWlfM/xSP
         DWoF/yuDlvxi/zf7o4ZNzkgW7WoHX0n4SwHuQkHwL3EdtgFdkUjn2NxwRNj5KgsSuddw
         8dDKh4XNV4JyVyr4htkL6SXZWseNWxCyZ8mPdvbBDF4i3byia8yn1pH+Un4MsWa4orw5
         X5+dVBRH0DEwWmVbGxHgjzDN+wI+nq0UkmYMDCtJMq1GgASBpFKeUt4O1aJlCkg25gc+
         wG5g==
X-Forwarded-Encrypted: i=1; AJvYcCV3YCrzkGgym1um03Tnn2/mtIybDMHzWQ8tN9ALl2BSpg715WXSgJvYmqURsYecot0otJ4=@vger.kernel.org, AJvYcCXsF/gichr1iKxuxm5Y+W9ojH+ug37kmogA8NjUJKLqrIZD0T5yDHqkPdAk2xR80QexTZYZ6Dxeiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAmZrdXcj7fZryqYhdenR/M00yfxa5Eet5zTk5jfX8J1SqmOP
	LAmvsdMf4FPOgrHVVUAPCkpqhzL+8bH7+m3Ugj0K4pdJulg2Eb85hSSotw==
X-Google-Smtp-Source: AGHT+IFFlLmrpR76BVY/jVWfmaJItMzvw9QCouJ2HQHZERHdoi7OF/UvtNRwJcsFSFxqJPJjxcQiCw==
X-Received: by 2002:a17:90b:4c84:b0:2c9:90fa:b9f8 with SMTP id 98e67ed59e1d1-2d86af76912mr2653983a91.10.1725009701008;
        Fri, 30 Aug 2024 02:21:41 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8818feacesm275274a91.30.2024.08.30.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:21:40 -0700 (PDT)
Message-ID: <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent
 pahole changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <songliubraving@meta.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, "dwarves@vger.kernel.org"
 <dwarves@vger.kernel.org>,  bpf <bpf@vger.kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Date: Fri, 30 Aug 2024 02:21:35 -0700
In-Reply-To: <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
	 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 02:49 +0000, Song Liu wrote:

[...]

> Clarification:=20
>=20
> With the regression, _both_ .BTF and .BTF.base sections (or at=20
> least part of these sections) are in little endian for s390:

Hi Song,

Understood, thank you for clarification and sorry for confusion.
This makes sense because btf__distill_base() generates
two new BTF structures and both need to inherit endianness.

Thanks,
Eduard

[...]


