Return-Path: <bpf+bounces-52945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753BDA4A6D5
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CB6167B63
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56079EC5;
	Sat,  1 Mar 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq8mEuT0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC2A935
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787419; cv=none; b=LRDDwMf13oQT3mpg1fl2ABP/WqgMzqfdItN5bBlg/6xrToqM/kKrKxnWje5oszClZEEuP9zjIdJJ1vKa1Qu3rXgZ//NaG2Y3CXYxrfff7vLcmCitDq5Ya22udGQhhq+P0rG2sBuVD/NHTqCmbyS58UX4noCQRu5Xd/JYD9egZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787419; c=relaxed/simple;
	bh=++evnjTV4JelVSAN3mL90dHw8fpasns7R1AKyI6HypU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxiGR86ozBqAxysvba2kQgtwCQ2d7Itkzccdl6HHVuj8svFqRu4nkSq7mZhacjGVBtRmyKzBkyJ9Z3h31XD2Pit7B0dH1wceDwlnDXaw9AriHIXXPjSjxiWjhWgzbb7PEQN1oYmOSpmmKaM4IdsbdBsZMW5BTXXgY1XOjtoVUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq8mEuT0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22339936bbfso41758215ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740787418; x=1741392218; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=85zx5W6intt/CvnbJWBwkycIcKOJ3flENeqlWGyFoX0=;
        b=gq8mEuT0dgBrBrykbSYGb4XR5wvOzClA8hIPgRnjhBUr0p6shkZSDbZZPZ0UZTiM1O
         R+KctqLIptlmRrGh/MaRkA1xtOU3IOG1xbUsoIFlnXPkJY3Op2uhwZzGLA3b2R5Pc50q
         fW6fzSpsRhMAKq8S82gIYI/+IhvqWz6s5qGWK0AU12KQD8s/joUMJHGCbNsv9krFa2x5
         dIvRmDprECZut1qq9zBfXdP8GcoOxeRx+PgyszOEk88EZ2vrTOEj51XM8yyuk4xVsV2I
         hep1qrGifB/DtpHvGiygsqqPdl49UvZkI4JJ7h7R6gkSjcNs7z8NR8eMnuNu8Tr7R0cg
         agjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787418; x=1741392218;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85zx5W6intt/CvnbJWBwkycIcKOJ3flENeqlWGyFoX0=;
        b=bOWQhyLQTYMNuPZ5roxNn46E856/JHmLTjjPsbevndGaqtY4Fs1tCzmfchq6Mnwlm6
         AUdoLSN3c6ViQInxxF//DcZrgAVo9KaQ4Ms0DBKK4tuR918UMprB4Va6LtfU1QQJOhUM
         ioizm8d2R/rGo4y+EHWskGeAm59/sk2LMK+dudkFGuHSIoKoLZ2dnoMDgTZeCN1TYQNk
         PSNgvxm07RBJjZzx0YxMngtXE/3gida4MSBE1DiqaSZn8hAy5fdxxRAMJ1syYVzTtE+u
         ZJzfZVwy/MNu04XHH/Tm+LdWHaTphd//Q5LVu/QXK6fqtwCj8R2NRVP/T8mRP6xKfpHl
         +I5w==
X-Forwarded-Encrypted: i=1; AJvYcCVRaCQydn4BqWSHFU2aUMufcKn8rkAmPD2paJE2YViDBAJm6nbHmSOjVY+nKyidorsKthc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+gAjlzIJuiGf6HEAY5bx49ofduPNl6WXfGSV8QE1l5ANS2HT
	slPxbKTpLxp3SVof5ipXH7ZKRwqsR7CXIAmtmSgXWge2stalLdmr
X-Gm-Gg: ASbGncuXAKjdoCRD3NSD0v1vio+0RHHvmPCY+0LTnk3vPp6OKrsg9on0lLAbwNoWln7
	tVe25Yz7uDY7PyvAP1HabHDB6dluO/NRWywF+tb+TYW32OQfgNC69guWtkPsZdLTANJjkK86pex
	VSExwETTLAl4Tp1fwRNyB3Kb3RAoF6SGF9nTGiNMqAgjxNgHStJEbB1AG4yZECueEChQDkWKZTU
	pqfLm7yOpmPEh3Kf72RitQrK0KttW4S6lGP0EqCbvJzhGkvVw5Jpf3irM1h061VdTsiLnd4EopL
	XDAGwJM5gC62/R43Rdl6DSnIFajt3JIYrMNY3MfHPw==
X-Google-Smtp-Source: AGHT+IHePxYcn/qu17nTcGS7R33QgECk9zGRbZmWhicWsuGch7lxGnYzCAyt3IywE6Pw7lShoM0bRA==
X-Received: by 2002:a05:6a00:92a2:b0:730:7d3f:8c70 with SMTP id d2e1a72fcca58-734ac42cad0mr7348346b3a.21.1740787417799;
        Fri, 28 Feb 2025 16:03:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19c14sm4003797a12.20.2025.02.28.16.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:03:37 -0800 (PST)
Message-ID: <d8375327d6b697e0bac6f837c8d595a629133317.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] veristat: @files-list.txt notation for
 object files list
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Fri, 28 Feb 2025 16:03:33 -0800
In-Reply-To: <3ee39a16-bc54-4820-984a-0add2b5b5f86@gmail.com>
References: <20250228191220.1488438-1-eddyz87@gmail.com>
	 <3ee39a16-bc54-4820-984a-0add2b5b5f86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 23:33 +0000, Mykyta Yatsenko wrote:
> On 28/02/2025 19:12, Eduard Zingerman wrote:
> > A few small veristat improvements:
> > - It is possible to hit command line parameters number limit,
> >    e.g. when running veristat for all object files generated for
> >    test_progs. This patch-set adds an option to read objects files list
> >    from a file.
> > - Correct usage of strerror() function.
> > - Avoid printing log lines to CSV output.
> >=20
> > Eduard Zingerman (3):
> >    veristat: @files-list.txt notation for object files list
> >    veristat: strerror expects positive number (errno)
> >    veristat: report program type guess results to sdterr
> >=20
> >   tools/testing/selftests/bpf/veristat.c | 70 +++++++++++++++++++++----=
-
> >   1 file changed, 57 insertions(+), 13 deletions(-)
> Patch set looks good to me.
> Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
>=20

Thank you for taking a look!


