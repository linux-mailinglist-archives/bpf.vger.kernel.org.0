Return-Path: <bpf+bounces-45984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2AF9E10E5
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BB92815A0
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6592455897;
	Tue,  3 Dec 2024 01:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GErbfeiB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D428F6C
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190278; cv=none; b=Zwhvq14OhJSkkdsqRPUB6Ggexmbq+ipjDdH1ozBqSUL49WEYlE1iWKEFam9pNTK8BWBt5msY/y8ViathGzhO4dxSVApNNvV7KGJ4+V7saDEjsZLul4SEj68/dTQ3U4i5Jo60FPzOoAbxQzLP3acJqtEIBLH93Ox+uD54eFYlsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190278; c=relaxed/simple;
	bh=bob74A1lUjkGIbVDjvB72Vwzu1hpWVhthbzNJCJEevM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qN01P62UEzYIdH4WmckZYaOw5BNcCDV5Yk46aaiiJbs2A4Icf5CoHZkIpiFxmnN0WGLPOxi/eKOwftYCH1MxwQJI0BPYcJfIEWXPFqkHr8fOTtBOkaFnbVMSzalpZ/HerH0yIVUBeH8gbPL1Fm1RXcb9b3N4Ysubb4bdNQ+w+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GErbfeiB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21583cf5748so16330715ad.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 17:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733190276; x=1733795076; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ngcbhXquf2VwEW4hAdUHcBm7unUFnOvrrWV0tlhF2w=;
        b=GErbfeiBqsI9g2XLOXpiD977TnTXGykm53+YMfSmIZrL0GM3ZocTGQB8LThrMUy8bG
         ap0gn5U4btZ4NRsj0c5gxN02NDAu7zFDQVPIDpMlqSfVTBEEZONS4PSkXnpEh6i6dB4M
         ZTy5vAcvibHTdywkT/iWPGe2kA0bO6r7kaHHYxbBG/pA35yIbrzq820uy6YUZQs31n3V
         MgTeSTzcjSvMqSmqjt0X25+wDdWWFEVFBnabYhUjDOXkwvgiqyT3QdhXflC2saNlP5vr
         ahSiz+9cFG3z8FebRxRqQRBs/UxxOCnhv37z6/yasT7N6aXmfX7T9ulbSBXco+b9+88S
         Bc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733190276; x=1733795076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ngcbhXquf2VwEW4hAdUHcBm7unUFnOvrrWV0tlhF2w=;
        b=u0yOP6HNnxnfzWEiTHHp1H6/a0Yrhl898bqYBiDbBb6pq2H+RBU1/fnKZwp8DzdRnY
         Y95+nsqMaB4wmdDZ2y7NLWNSDe7zf6QHbGy1EjyQroS+/GRMW0koG5pfV5snpEZ0PcQh
         AlysSNtcEqMddQ4carx++Tja8Mt5gDVYTt8eLj4MgcXgSQ4GpTxZeH11OjU3VrTvbBGf
         PHRXN6uCbcfGM5+Kj9/I70ThVEuKjrFcuy/iiOwHZhXLe2XzbGaBRzISX50cdChMMycI
         uKBu2i+KwMQ05I31+YqH0z79+0PCWb7VMw1M/1alIfvIQhK30iuyZsYG58x0ONFRCC2A
         BEOg==
X-Gm-Message-State: AOJu0Yzt35DuTE4xJcfqlgMIOxt7y1E4ku7IVcwSR8kuSUM9EuI+NYj0
	xOmshMY/kdePEshPvDoXJmgOmcPO/Wqoc2Lb5a6302nbyQ8Zq+oi
X-Gm-Gg: ASbGncvNt1gUthOzrq4H7o7jXEfg0CTy0PAxenyaR0QX4z194N3tzQL/3d2801lHjdK
	KHP4y9qvSLgWACvGf/A9cD7duSHDnxhzQunmWiyRUNP7h10WsDtLglW0G01jY1NkmDyVlEWSbbg
	HjbFrASoOjvtn5cqeln8mcyTomYFEQzAC7DUUTSevoUfUk65jmsxAM+uemar7u7S4XHZz4RAeeg
	G9M5QgCl7PwGLLjH0aguO9NRT+5xc/WJB9fDpULgeNybxo=
X-Google-Smtp-Source: AGHT+IEjuJUlkrElcQrQEnyZ6zFkV9cHgfInk9PKh5sFWzOai6PTC942H9phaQIMXqg1e+gZNdajLg==
X-Received: by 2002:a17:902:d4c3:b0:215:431f:268f with SMTP id d9443c01a7336-215bcfc3783mr8961975ad.10.1733190275906;
        Mon, 02 Dec 2024 17:44:35 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215413d053esm66430165ad.226.2024.12.02.17.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 17:44:35 -0800 (PST)
Message-ID: <d451820d25395d013e716884bb037af2aff50115.camel@gmail.com>
Subject: Re: [PATCH bpf v2] samples/bpf: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	masahiroy@kernel.org
Date: Mon, 02 Dec 2024 17:44:30 -0800
In-Reply-To: <ed5cd40f87b28528cd6a9a6db55e9879e34d9e92.camel@gmail.com>
References: <20241202234741.3492084-1-eddyz87@gmail.com>
		 <Z05PkpUCQb7T_rk3@mini-arch>
	 <ed5cd40f87b28528cd6a9a6db55e9879e34d9e92.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-02 at 16:52 -0800, Eduard Zingerman wrote:

[...]

> > Naive question: why pass EXTRA_CFLAGS to libbpf at all? Can we drop it?
>=20
> This was added by the commit [0].
> As far as I understand, the idea is to pass the following flags:
>=20
>     ifeq ($(ARCH), arm)
>     # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
>     # headers when arm instruction set identification is requested.
>     ARM_ARCH_SELECTOR :=3D $(filter -D__LINUX_ARM_ARCH__%, $(KBUILD_CFLAG=
S))
>     ...
>     TPROGS_CFLAGS +=3D $(ARM_ARCH_SELECTOR)
>     endif
>=20
>     ifeq ($(ARCH), mips)
>     TPROGS_CFLAGS +=3D -D__SANE_USERSPACE_TYPES__
>     ...
>     endif
>=20
> Not sure if these are still necessary.
>=20
> [0] commit d8ceae91e9f0 ("samples/bpf: Provide C/LDFLAGS to libbpf")
>=20

But this means that I should include sysroot part in the COMMON_CFLAGS.
I'll get the arm cross-compilation environment and double check.


