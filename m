Return-Path: <bpf+bounces-61440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200FAE712E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0E83BFF38
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C2718DB02;
	Tue, 24 Jun 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7BXV8A3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C0366
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798833; cv=none; b=JBERJwZ+TDsKl9PRSxBF7Msc/SCHlDMYswOi3yDe1CMUv2hHkDGhUgHBIGZty0WKB09GlEgozu+C26PlKOlX/fhSselH7V739FKsutQvPrnlA62pgQwHO1zYenR5l3mNQAFdOUWibx1qBrzH45OAGoBou5eH9O0MpzMIr73NFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798833; c=relaxed/simple;
	bh=gClDrvb/6PGJvBljb5BAEmmL8XW8DnZpA9Yi7IljITs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MH8E+KMOHQwAlIcdl3XAeOgrbgd/YxI1vC77p119+FfJzwKhICpFiLBNBqUw+Q8F8F0DNayGnjLuhPIc5ggtqQIYKZhgPSGaK0uKTKcb1XpVX4KNs+K3w4HJPiuqcdZUb7XEK29AwhjUrpIq/7sPnwPXsizMJiPwOxGmHKQnYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7BXV8A3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748d982e92cso458534b3a.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750798831; x=1751403631; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zk6qdMLUDTabU9Az6GSpDMkI3DyhzWLukmk+m1DAp6I=;
        b=F7BXV8A3+Yuf1rCxW41c1ZyR+H9g7phbBcJzdKBk+J3wEr214hkT2G9buufs5hKjz3
         UJ19o8KmU22qWhzd2ZrC3MWuFrRiVaGJK37XwprXt7ZS3HwdKp82gErqbWbcCyCa1oRg
         5jc46fbQlcOEJTvX0zIsakejUxeB2hN5Q8WGXSyJcy84fwMI8xrbKfhKo4+OMijH3SO8
         RTfVHi1nTc1IOJbrpov/tlNXkJgUH25E+Z6VsuCj+5qAKau6O3yC9cQ5uX/B/AAUYHZ9
         9poJctbrbEFzIbVYrcqF4H88/rInxWQDupDLpXoj+FrdsWZ6zqkp3oo10QAh6LMffOZX
         BxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750798831; x=1751403631;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zk6qdMLUDTabU9Az6GSpDMkI3DyhzWLukmk+m1DAp6I=;
        b=r9Od9rJo7cu+cNHEdNWmYsbWyuw/YxTM4TEQ+9UbLyPgfIOyfd45y3Iv7PyIN7D1D3
         uangwTgtOsV1QaEOdo9kFwopx82hqJLtnFF2BMzMKh0+T/nOucI+R23uZ0SnU0AQrIT4
         2iG1ab0ggz3F+fe+tNfcsBIY7Ftmq4tRS1KwOy45V7Dwl0hFYy1gQpakJJLT+IabuHAS
         8OWxLEV1dc+XJtnV4E+/0z16PDbEPISgEiuJhz0HzbQsPmTuQfod5Q6pYeVaoUgLPN/5
         Quy2C5JaMnIvYQamvNXZrdeAd5h73e5hAl3BbMGaZRvS1J/FXHSlJ8tojCtkNWosMF/F
         T0pA==
X-Forwarded-Encrypted: i=1; AJvYcCWWf7mmCQRzdRF5rNwPcfNW4Do4TqZmau/a/Y5qrMFBVPfMPBhT4NY3jq/02OOdgwmE1tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7o14vNjJndrbMr2ADlAdxjchQq9rBxaiqetm8Q2Sg8+9f/WL
	kXybgwM2ecNEFCCWkWM9LCG0jDNZnDSMedRkSzt9v0tp2b1djB6lcTny
X-Gm-Gg: ASbGncsW7JlFYUJUYZOFTgczTGXkXJIw3W4S+ksPwVjWmEBS18GMpNzCTTig2Ncrogo
	3EOZ0EMk8MqXfw1upmm0AaX52QIc9TLZb8Y0p+W3b4FQDJGlYG7wLM8GpPQoecWgWvvHoLDh1AN
	vL9RxxJrTUvMx35rQhH7LEn7ZLM5bcpBsVR2uZ28yIhplnXv3wCHb1nRCNwT+d0oqtsbsrV2foR
	bPbeck0dtuGf5oL9Y+I083z2sFZ1kD4I5oDIZnl1TxNtMXJT3CqeGSSJtx3W/OapBjqB9+/5JY7
	F6ZaaKSQoO7xXqE81RnEPSREdeFbKBO3n6nD7h0EGzP/1oFfZ4nIQi7NDImu7o4u3sVo/YXABiX
	ss0KL1WtQdOnaJ1IIAftn
X-Google-Smtp-Source: AGHT+IH9cM6eO7gtwQVZ/AGaxkBjPY3lvfqSMGPrUnCYgdjRxLRlGjyPJO9JfpA7TR60vcT1GqVIfw==
X-Received: by 2002:a05:6a20:c793:b0:21a:ed12:bdf9 with SMTP id adf61e73a8af0-2207f19700cmr676375637.17.1750798831090;
        Tue, 24 Jun 2025 14:00:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8854878sm2753018b3a.135.2025.06.24.14.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:00:30 -0700 (PDT)
Message-ID: <4be25f7442a52244d0dd1abb47bc6750e57984c9.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add range tracking for BPF_NEG
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  Kernel Team <kernel-team@meta.com>, "andrii@kernel.org"
 <andrii@kernel.org>, "ast@kernel.org"	 <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,  "martin.lau@linux.dev"	
 <martin.lau@linux.dev>
Date: Tue, 24 Jun 2025 14:00:29 -0700
In-Reply-To: <11CF7792-6165-499B-96E7-BF28BD74F9B4@meta.com>
References: <20250624172320.2923031-1-song@kernel.org>
	 <96b5c623be2b07ecab82a405637c9e4456548148.camel@gmail.com>
	 <11CF7792-6165-499B-96E7-BF28BD74F9B4@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 20:50 +0000, Song Liu wrote:

[...]

> > Note, bpf_reg_state->id has to be reset on BPF_NEG otherwise the
> > following is possible:
> >=20
> >  4: (bf) r2 =3D r1                       ; R1_w=3Dscalar(id=3D2,...) R2=
_w=3Dscalar(id=3D2,...)
> >  5: (87) r1 =3D -r1                      ; R1_w=3Dscalar(id=3D2,...)
> >=20
> > On the master the id is reset by mark_reg_unknown.
> > This id is used to transfer range knowledge over all scalars with the
> > same id.
>=20
> I think we should use "__mark_reg_known(dst_reg, 0);" here?

That's an option, yes.

[...]

> > Nit: I'd match __log_level(2) output to check the actual range
> >     inferred by verifier.
>=20
> I tried __log_level(2). However, this program is so simple that
> the verifier log is really simple:
>=20
> VERIFIER LOG:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> So I didn=E2=80=99t include __log_level(2) here.=20

When __log_level(2) is specified every instruction visited by verifier
should be printed in the log with range info etc.
E.g. see verifier_precision.c:bpf_cond_op_not_r10().

If that is not working for you could you please share a branch on gh
or something like that?

