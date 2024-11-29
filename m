Return-Path: <bpf+bounces-45892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012949DED3D
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 23:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2D16398B
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 22:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03911A08CA;
	Fri, 29 Nov 2024 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSft4afV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0F54279;
	Fri, 29 Nov 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919257; cv=none; b=QeeZ0FlYQoRoBf78kRQfz8Wv7fMWNntQtBgjEVeTtazX4CeUt2ys6S/nEJBCA7SazfWARSvNFNCJ+kHYXv3Jwq3cFDySdyxq1uZxz5MBoY7Qb3U0+V8QrbxpsryhfgnfZIXYQUi2qAOI5liwsaQ2TjUQLLI4epyyKoLqwnZ07BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919257; c=relaxed/simple;
	bh=DlUzC6889p3FgikhVtH2/k6Bzf+zXhaZmA00DipMv+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b4deA6R27cJgvfimJPZaZnVFeMW+MeeqtQuQWdCVzYbMvX1+cLJI0iGFStKSUUVitOos9Q3Vs0GJRRYP+wgMJiT7CvcXXvB3IVFzmeFmMRiv1DnKm2hATAYPwv1nAlQGO10YDWflSoXeEYezNnGB1iybedTiunKsV60Yyxqper0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSft4afV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2124ccf03edso22242855ad.2;
        Fri, 29 Nov 2024 14:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732919255; x=1733524055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DlUzC6889p3FgikhVtH2/k6Bzf+zXhaZmA00DipMv+Y=;
        b=mSft4afVGYg0vvX9v4fJZ1+vND0e/i5WJtO+i6VCPCSdag8rlBlgk+/IyFOQjuQZdc
         anSZCKYOeZ7MdP80ZjCeMtpUIn3Rq4NUoICejnBXqEEvjqOINKsS0yFX8a6jSxO1gXUV
         bsdCKX25ugKvskq7x9QYV22232x44B8wXhvNOm2nfVvzKxI6d9sP3mhC8QpJbeKzXa38
         DuHtRp1tzzaicuZukTW1dHnDxpnDzsMUQri/4qAh96IM5nHh93zB931kQujjhjbGx7xw
         GKA9DlnZCe9jNoXo8nwvDH7iRiG/0an1bCDhQW/FlkoDV7MXkDru8Ows1hLmbRPU2AzD
         UmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732919255; x=1733524055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlUzC6889p3FgikhVtH2/k6Bzf+zXhaZmA00DipMv+Y=;
        b=lcFxa6204mEtgblrfRWZ1y7xm642dV6Gts68DkhVKEH3Y7vLIGCtwfqwJsu2y6IyAX
         r6U37x/2WzbIwHK4RcfXiUhoyeUAG3IboGfRTq6OlVbS0mx/uRaefr9EKi2c1O7yWCBq
         lhmymKDHO+YCK3rxsCltic3ZCdfFgCofdqEVKgMPf+iuCPdHK3h4oJdEUSyvGluebnW5
         1snTY+/RDktnq2IinhgP+vMQBGdVYZw7Hu1ShjI8Tc5F/9cVWpq7HimYsNkjYO63OdJL
         YdylahciPuFzCkdo36XfgLKoueRFCy+6yx1zwsddgb5G/z5VpDFB6mKZXgcPp9CU0iNy
         bSyw==
X-Forwarded-Encrypted: i=1; AJvYcCXXCP0jKbp3+mHoahzZhP4YXxAuLaty6E6q/gp9oVXtUe7uF+8yaTl1DCSdzMPA4ynmOFPxAu/f@vger.kernel.org
X-Gm-Message-State: AOJu0YwTlQFIdFNZaJy4Vifm0ZHSZCqhJBM3yAiD2ojbk5AglfQkVpQY
	b7Oep467oeFL+SwXYdzcwkgccaw9vM389g/ZwQCLMuz5KXkBQT2O
X-Gm-Gg: ASbGncuuKACuVJ9qZs+BZFxGQjDLZPcfJTXfCGlSyv/nPNLCJsTi+23vfcpsQ6EQJbk
	4pM42v2j65LkdBcqlRXfQehfEoSdk4IEg7vRsF1CjUmF7BdPFPko07KZ9L2iXZCJ6H/Wi4wKBGH
	ULa+G8UOBebDjktYKMHbVd73GLuULrRG9MAWNsH0XFEfmqN86F6W/yQQWiELvOAB8bGxm515rlB
	PdGdLzUjIjpAgkcsjGlbC0FGYGrre2vJ1pU4GFlNqLPQkE=
X-Google-Smtp-Source: AGHT+IETLme99rlyQFdxLov9fAwnFuZFoAdEegJgTvuNtfNJZopjmJuDCogbH+SkLO5bG9FkWcWcvQ==
X-Received: by 2002:a17:902:ebce:b0:212:13e5:3ba4 with SMTP id d9443c01a7336-2150109b05amr152677065ad.21.1732919255083;
        Fri, 29 Nov 2024 14:27:35 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219cc8efsm35339285ad.262.2024.11.29.14.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 14:27:34 -0800 (PST)
Message-ID: <8a15663d9f57056e05e8a2687175c2abd0f7c530.camel@gmail.com>
Subject: Re: [RFC PATCH 6/9] btf_encoder: collect elf_functions in
 btf_encoder__pre_load_module
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 14:27:29 -0800
In-Reply-To: <20241128012341.4081072-7-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
	 <20241128012341.4081072-7-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 01:24 +0000, Ihor Solodrai wrote:
> Introduce a global elf_functions_list variable in btf_encoder.c that
> contains an elf_functions per ELF.
>=20
> An elf_functions structure is allocated and filled out by
> btf_encoder__pre_load_module() hook, and the list is cleared after
> btf_encoder__encode() is done.
>=20
> At this point btf_encoders don't use shared elf_functions yet (each
> maintains their own copy as before), but it is built before encoders
> are initialized.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


