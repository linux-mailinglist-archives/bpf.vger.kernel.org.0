Return-Path: <bpf+bounces-61556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C20DAE8BCC
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E011C4A32A3
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6762D4B66;
	Wed, 25 Jun 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mto+wa8v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494C1DA60F
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874132; cv=none; b=a092nKwL3G9hxSfvwiDQJKNM/PQOeYG4TUXXA0Dah0M3PNBQJcOZ6VBtMkQtsSgZppWe9xlVzCrBlxGbU67wk7rsesJlPkBG/cvoUPmxlq8juMgJ6G7LTxfYwlIhqmtm+gFjywLuP8U1Rp8MaONYT41kZpCqOMuoTkr4EPacIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874132; c=relaxed/simple;
	bh=QJ1AfkcTQSy6ZagE9m7XtLgEIb/+Zmly+QyVf6jNp4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HoeYkTU79v4Uu1P2soxogxtZj5pNd3FSME4UnfCOjj9DLYVghfqhyuB6cWLAeflVaEsOrhn3oCSmwLa0kmxSd1WNd4kXoF2O6hcIf8O00/arUfyIHG99mAkANORL9pobfH39UNXjSG6Ot00FXYk8Mwk7K5TwVHSkXd5HxWrLkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mto+wa8v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234c5b57557so1926185ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750874130; x=1751478930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jV2r+aBzmbR5Hd4rw7z64MqhcOWD3MWoB9104Xo4WVc=;
        b=mto+wa8v/CYnOardsHea2Wn5St0el1mKsm+K3xP7OR0iLtqaXxAUgj1rx8ciHiGyRG
         Frni0IlGWe+8JJygNCsa9BR2QtlpqpuuOKWtxbmaF/p5nk/j0XV+sxCUUgT49BuzopEY
         T/+EdliKC8vwmza3AiWa7K0VrwGPUvMZWiIinVcnaWEML89i4kQY+GkVq/8DjhlDgCA5
         KsJN9d4MGIeRp03A7nAPa9TcpEL1PZQv1Giz1b1AiWSQwHH6GDFK2f+WPtPjVLGZnjsw
         f1/0ZiMjlt8DfDlgenzy+u227TsDksmvkDjtLbnTpZyIj62yBF3a4LniY9M96qKwAqFr
         HKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750874130; x=1751478930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jV2r+aBzmbR5Hd4rw7z64MqhcOWD3MWoB9104Xo4WVc=;
        b=l0P7HAA6AXLyRLYckj6kKMaP7xuxeOQ5d8Nnf7xYRwCjmcqH93ave72mtkYwXf24km
         go0NUyLfzFEgFKr9cSuKk5xfUFbxJmu5jD1eWPiNkTz1WJzbFSfo/I2CE8juXKVTYVn+
         FKz9wIIBmcnIJ5xu68eEeKEfERyYFmytRIvtDIDHfnEUfgEb1oQYdafT8RLvja8UTc99
         lTFZNiWMrodo9bshzvJF55/vl2ZL1+O6hO7am8C62/kweqYcyRzTbJDPdtyXyur4du0/
         KV4lCtKeyBIPT8m2pbbZqs46TvExWe+q1/uHCWpDjCq+zR6dviTnfXPyZulisMYeIoIS
         eH4A==
X-Forwarded-Encrypted: i=1; AJvYcCWC4JPObglNT3v7oolPcT7OAB1I4lCFAiFDcaHRtnDAn0ZmBqQXs5T/mVxRDuu4gvcU1f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0B9cob5kEunqAzqGVGFMKWzlAP1XEXEpHHwP+f+iKvDcDBKB
	NE6XdRQ/Y/Yal5iH9IZRBugryz1zsc7G6t0JTSssNj8bJIoaBZXlgaIS
X-Gm-Gg: ASbGncvaON4i42Sf9W4BdbRj8No7eJ+CJPnk0gT1bD7HM5fOmKS2TpvHV2tXCLnn3Et
	VMx8VBGxd0R/9RtYK6pMV5W9YRXjzqtvYuzv7t7zFAwgCcfmX+rp6CWHo1jCee0i+rSR8rwGVEA
	zWQ44dP7ZDwHAwNQGGByUJhxhKEixfuWsSfxYSjoozsv0N+b+X0aO5GpoPUnOlH+qI+rkC3Evr8
	QgEP4kGx/u32plGkOZkShCZZ8RP8Zt0ZIZ1qEjgA33QoOLYDApsKaEe7BQ7dPGfQ3xUuayD07Ln
	F2711fDmDwKg8nXXJRzVEAZjAgYT8oSjU5v70xj1O6KCzuwXV3U7s35TZ/0OGS5OoO0Z3EjP22E
	Wn25lZ2D0Qsg=
X-Google-Smtp-Source: AGHT+IErQMD2FGdKbnnb7fk6AmHqGqQRD0DTqdCREBZjXom2Su8cHgDsQKYQWtK85tlxnt9AyfO9Fg==
X-Received: by 2002:a17:902:e5c9:b0:235:2ac3:51f2 with SMTP id d9443c01a7336-238240604ddmr71058625ad.45.1750874129954;
        Wed, 25 Jun 2025 10:55:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d839326asm137391155ad.32.2025.06.25.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 10:55:29 -0700 (PDT)
Message-ID: <11e00370d1f46ceae1cc13511216a017b8b6e73c.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Wed, 25 Jun 2025 10:55:28 -0700
In-Reply-To: <20250625164025.3310203-2-song@kernel.org>
References: <20250625164025.3310203-1-song@kernel.org>
	 <20250625164025.3310203-2-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 09:40 -0700, Song Liu wrote:
> Add range tracking for instruction BPF_NEG. Without this logic, a trivial
> program like the following will fail
>=20
>     volatile bool found_value_b;
>     SEC("lsm.s/socket_connect")
>     int BPF_PROG(test_socket_connect)
>     {
>         if (!found_value_b)
>                 return -1;
>         return 0;
>     }
>=20
> with verifier log:
>=20
> "At program exit the register R0 has smin=3D0 smax=3D4294967295 should ha=
ve
> been in [-4095, 0]".
>=20
> This is because range information is lost in BPF_NEG:
>=20
> 0: R1=3Dctx() R10=3Dfp0
> ; if (!found_value_b) @ xxxx.c:24
> 0: (18) r1 =3D 0xffa00000011e7048       ; R1_w=3Dmap_value(...)
> 2: (71) r0 =3D *(u8 *)(r1 +0)           ; R0_w=3Dscalar(smin32=3D0,smax=
=3D255)
> 3: (a4) w0 ^=3D 1                       ; R0_w=3Dscalar(smin32=3D0,smax=
=3D255)
> 4: (84) w0 =3D -w0                      ; R0_w=3Dscalar(range info lost)
>=20
> Note that, the log above is manually modified to highlight relevant bits.
>=20
> Fix this by maintaining proper range information with BPF_NEG, so that
> the verifier will know:
>=20
> 4: (84) w0 =3D -w0                      ; R0_w=3Dscalar(smin32=3D-255,sma=
x=3D0)
>=20
> Also updated selftests based on the expected behavior.
>=20
> Signed-off-by: Song Liu <song@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

