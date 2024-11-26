Return-Path: <bpf+bounces-45643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC49D9E0E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F50165471
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D91DED79;
	Tue, 26 Nov 2024 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUg4edmO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7701DD525;
	Tue, 26 Nov 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649483; cv=none; b=GaQ3zd0+pPqwkuHAlsvXJr9z9Nm0Nq7xWSu47Syq7sDtpL8MNszSTW4c6fSJbArbmlxnhniwsfG0pnJpQzs4E+bTkX3XZR6mhcGdmiYRxNleVYfG9KXYupLTq5WzEa3QiBhg4ui8UGSDC59YowVe21GrZFNffeio7P7seO4arhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649483; c=relaxed/simple;
	bh=CR+5ihcOztN4AtU1hXOgD0WzFQvbuJt1Ofh4dBJY0oM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DGZE7/el0kQ3sC54/x9sRKX87QwW52dxkcbJNfcRCJy4EANtB2BAeFFic5Y89lpWsbPnkSsC2yUqpL5Xd9We31Ad38XEEnILe9DGEXX27lz/fho821rlWzsi9zBbZvAtXzi1VExOfJLgen+TCTOI9GL+dCilozhGzCLxCxxLfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUg4edmO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so4835471a12.1;
        Tue, 26 Nov 2024 11:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732649481; x=1733254281; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SLb7oedvGUBw0GUjxMzbeJP7gRUHPB6OTZd4J1q/g2E=;
        b=BUg4edmOZ5TfqxZCVqlQHZWbXbgaGuEFKLD7972hfxJOfWI3EkthOHTFlmPEJ6EMkS
         Zia2IeQMj34wNEGvp7BHZt2qKNgui0RcE6m7d2EsYmKZwCR0XKtsEKVw+US12KHIrCTR
         NLZpipd+yTUa/SX9CUV8qy0HH2wOiQaFd5rY4Liu8HTiiZ0GEFnGX+CunEJD/YpsROKz
         N3OE6huwon2C4ZSj/tgCu7dGEPFgZIwtf/WwJQDrvXDahxHyY92AtZnbkqTjbNvF7NNb
         DNOUDAEGmKiBprTtwNBK/z9OH97P/EFPBx2lQ4t5mPssqFbt6cHGWvZYVqZVFUfs64bD
         SYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732649481; x=1733254281;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLb7oedvGUBw0GUjxMzbeJP7gRUHPB6OTZd4J1q/g2E=;
        b=stejaNc6lL4lWnc0KuYaWf3zT+eWZB1ZbAckxlOO0yGoyy5aFZKjVbD8LaJBbV7Ne/
         WvSGuYxsNgngJ8uUIpgAYl/+WexWs+fIi4K5xAbGgA2zg5a4DhahSuRwioUv2jb5jKKK
         DLgtcOV+dRjHFutBaA/SIdQHPK+H08qiuReOmAU5uX5KDYyheWzDG/QmioyZtiRAkCEc
         gaXxP9LNTG41bghLrEeae1rpC6T67EDs9oberSSVTr7rO86U8yT+aZK/+Djd04YhVIx0
         i1SSNmlaXArEaDSKEvcabfBhnKxDOclxOgpwLsJGtN+oMvmEv3DBGZT6lIzgvjwUWhYr
         cqtA==
X-Forwarded-Encrypted: i=1; AJvYcCXma/F3qDamBkPaZ5kiJh+sTky984L5KjWpi+eaybKRx7o9CUsWRgGDRzevyBxR1/iHVos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqgazgMQ3YklzcvjUoQErF/bqpdMRIccphs8iYgqSwxvtPvrb
	ZEOM7nqDLjcfgVezszvEGL1fuMRC0uGJ7kPnim0nLwm2B6T/0PyE
X-Gm-Gg: ASbGnctYsf/zO6vmXntA4gk9hyku8Uu67tAgRSRk10ih3fnLPbAD2sIVrUyQrlbbpZG
	IiIiVsqV+2zy0qO2GfrY2QOFrJk4wgC4DwIW1Qcp/yKPJEGQ+4OTEm1LwTOIzgleP5IyhIMcE15
	W5/QSjMZbGHuXp2pLXFxIDpw+MCNNJ6JU3Kzq4t7OfosL+9i0CU1hp8863b0Ulaq15zGCLs1iPF
	/fCHrQ9APA/khxDQG33t+OnEUhjuJG8B+yA3VQj0UCq4tA=
X-Google-Smtp-Source: AGHT+IHD3RXwJEwlW8bWedkOQAg82KIr9rOhOfzPveXRKRH/CUwgwAUhzTqiOPbcsa/eYThci+YFSw==
X-Received: by 2002:a05:6a20:258f:b0:1db:db67:4d78 with SMTP id adf61e73a8af0-1e0e0b2c780mr1097337637.22.1732649481096;
        Tue, 26 Nov 2024 11:31:21 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1d21c5sm7826788a12.20.2024.11.26.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 11:31:20 -0800 (PST)
Message-ID: <69af35e3718748b99e4d295bead4072588a50296.camel@gmail.com>
Subject: Re: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section
 endianness when cross-compiling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	yonghong.song@linux.dev, Alan Maguire
 <alan.maguire@oracle.com>, Daniel Xu	 <dxu@dxuuu.xyz>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Vadim Fedorenko	 <vadfed@meta.com>
Date: Tue, 26 Nov 2024 11:31:15 -0800
In-Reply-To: <CAEf4BzakAiPWF9x2h-F737LbJ9ovXCJLbXV9R5vKg0Et5CbqSQ@mail.gmail.com>
References: <20241122070218.3832680-1-eddyz87@gmail.com>
	 <CAEf4BzakAiPWF9x2h-F737LbJ9ovXCJLbXV9R5vKg0Et5CbqSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-26 at 11:26 -0800, Andrii Nakryiko wrote:
> On Thu, Nov 21, 2024 at 11:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> > kfuncs present in the ELF being processed. This section consists of
> > records of the following shape:
> >=20
> >   struct btf_id_and_flag {
> >       uint32_t id;
> >       uint32_t flags;
> >   };
> >=20
>=20
> Can we just set data->d_type to ELF_T_WORD and let libelf handle the byte=
 swap?

When I tried 'data->d_type =3D ELF_T_WORD' + gelf_xlatetom() snippet
suggested by Tony Ambardar some time ago, I got a write protection error.
Concluded that this is so, because file is opened in O_RDONLY mode.

(Also please note v2 of this patch).

[...]


