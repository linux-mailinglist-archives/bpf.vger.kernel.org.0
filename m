Return-Path: <bpf+bounces-46024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F549E2CEB
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 21:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CA9281A76
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 20:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA85204F8E;
	Tue,  3 Dec 2024 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOEBYBHD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE412500D3
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257168; cv=none; b=UbutgLuBRO6t43r982lEZia07/F5Aqrp2X8EbodOQz0CKdo6Bdu74zyIZ1xcrJoDmhk0v+VaTH+9DxMwzQwvxB82+B/9XygtvaBddsydLgBcKbMIWTOBed8BRQiqHArYEXaQlQk56D6NX7J7qUK3qBB9jLT9ZEF3rb2ypx0rGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257168; c=relaxed/simple;
	bh=bAFxSx/q5gm/0wSygIG0DxQZ3HmxNstyvjSWiUJ0ulA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RTRo2iSOCsUkjRZdF4g4Nv14cNgIjLRVeWNqW/g1295Yx7ToNGJ/dirnayZO/ngRmCbG0z46BYqyU+yZ1MZkRvdUIpVmkuIwmXWs0MqXJFDGqD7mZOMc1LCtL5Lf7sU+OVfQE07QXGhGc8k89bDQN40Yrx/OWniETJjD1fMFEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOEBYBHD; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so4100168a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 12:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733257166; x=1733861966; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKnYgaX8MkaMjdhIbc+5cvkLu65UodV/R01j6NvY5vw=;
        b=YOEBYBHDHTXHtq8jzb9twysIM/zMPIbYm2++IwufKHD2rCr1XZ/86Y8wsqQoySaEp0
         5uE0oMzTkeI6VfbaffoMav0PoFFDrhrX5bixRb6f7zpFFqSNij69f62ZlJjLHGChdY9B
         IHTrzTaK2GnZdOjnN6D61nUXiDfeuBthVjGQPh0Ee7I60M18iDbXuaLSjLruCbk+slsQ
         6n32BhHBBawAdLmWp33wBIxuxPa8DITid9kww+vvf49kwZMqnU7QdwLW7r6TkH98i0Uv
         +TL64+JThMQ+zYqBGjik+w88yZh4Cwqcnd2kpezkvOoXfM9+tjai0RbDAl1phkT3/FVT
         VunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733257166; x=1733861966;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKnYgaX8MkaMjdhIbc+5cvkLu65UodV/R01j6NvY5vw=;
        b=Centx7lOx3CLrwQDee1NjrES3C2W1GGy2OJ58C5XBf9Fl7lgekCEKbi+w+a8hXiJEK
         StJP+y7YKL2TAN2Cug9EbhuT1Yh6KQOno3FItOXHgTgtgLpH+eqDbmNot0Qk9bn7BPRM
         XQCm2NVTa+F6aQIevEoCxHIStsSgXsIHJNV5DzJ5+H0oHn4G4iysGKpiCvg42G9Nk8EX
         JWoLTZSPS58PPd6ED/hPS8jGU2RC20ezKqQsrAs/5ikqiEg2qcqrArR+oBa+xaSQC8pE
         14v07qLD1Ol9AcqnsqynsLnYdzvxMpm8d9Zbxg+URtJnlpIrAVik2yde7EZTUXRMVslg
         6m0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7+AAapiGXlPFLqRXY7BCN8pxkZO5OzAYZRQ+fcGYoAP0092mNAXpPgU3LB4LIyeklLmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbpQr588A3kTGh0hyz21DLuSFvLeBHp7n9q0rIDhNooVbV8Ce
	quH8v8CrOnB1ZYzZ3MyeW/1U6XRqu6ZZK4SUv56G4sLmsC4Ce3ZZ/Rq37A==
X-Gm-Gg: ASbGncvXXMvj2YA0WQJuPK8Hb3Mel5m6oMnoSN7V2Q2GK8mZnRepbmP0Lay9tn0qZi5
	inCFLiqne4nXl20ZqbREryppiGkF0AjF9avVT6c75iN9a+zOJ2CeTEVpxM4o2pdeXnXMQqrswIb
	KM0gCwEhPvyKZ0kGEMDCooy7W528AXF8USbfCiE1sSZw5lElFy6gyfFgtKyikVStuoN2HdkNeHg
	0EPdzuSCed8xUX9OdFf8eLfCckwi5Vn0nwW/2yB+hMhYko=
X-Google-Smtp-Source: AGHT+IHaqmqJfjbNCLQxiA9TL9O2l2cHzsOt8FBKuEln4bp/zmlzVijbamtLjpRHyIw/IHp7zANTNg==
X-Received: by 2002:a05:6a21:339c:b0:1e0:d2f5:6ed3 with SMTP id adf61e73a8af0-1e1653a2a94mr4949982637.3.1733257165864;
        Tue, 03 Dec 2024 12:19:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbae3sm11196735b3a.102.2024.12.03.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:19:25 -0800 (PST)
Message-ID: <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nick Zavaritsky <mejedi@gmail.com>, bpf@vger.kernel.org
Date: Tue, 03 Dec 2024 12:19:20 -0800
In-Reply-To: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 17:26 +0100, Nick Zavaritsky wrote:
> Hi,
>=20
> Calls to helpers such as bpf_skb_pull_data, are supposed to invalidate
> all prior checks on packet pointers.
>=20
> I noticed that if I wrap a call to bpf_skb_pull_data in a function with
> global linkage, pointers checked prior to the call are still considered
> valid after the call. The program is accepted on 6.8 and 6.13-rc1.
>=20
> I'm curious if it is by design and if not, if it is a known issue.
> Please find the program below.
>=20
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
>=20
> __attribute__((__noinline__))
> long skb_pull_data(struct __sk_buff *sk, __u32 len)
> {
>     return bpf_skb_pull_data(sk, len);
> }
>=20
> SEC("tc")
> int test_invalidate_checks(struct __sk_buff *sk)
> {
>     int *p =3D (void *)(long)sk->data;
>     if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DROP;
>     skb_pull_data(sk, 0);
>     *p =3D 42;
>     return TCX_PASS;
> }
>=20
> If I remove noinline or add static, the program is rejected as expected.
>=20

Hi Nick,

Thank you for the report. This is a bug. Technically, packet pointers
are invalidated by clear_all_pkt_pointers() called from check_helper_callf(=
).
This functions looks through all packets in current verifier state.
However, global functions are verified independent of call sites,
so pointer 'p' does not exist in verifier state when 'skb_pull_data'
is verified, and thus is not invalidated.


