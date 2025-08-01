Return-Path: <bpf+bounces-64913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5CEB185AA
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D51CA877B6
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3EF28CF40;
	Fri,  1 Aug 2025 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv/cTzVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273328C871;
	Fri,  1 Aug 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065472; cv=none; b=OKNoq3Yi7tvDnv6LBeiOJH2EdPvll+cEe2MByMErGaiZFZFnznI1A0gbjGYCLfscpThcNicfqzDEjEU4Q8m0bo4/X69SmhSkTQ2w3k5m0wZ7BS8tzZU/ivallgeQl3U952TAgTJpU1aIOaKnqeOuvR8bF9I6dbDUWqL1Sc14CI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065472; c=relaxed/simple;
	bh=cJDWvFXmksu3eXeiSRm2D4LtywUxqHA5CdeKE+97npI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMB6exPoJg41KHzRpwAVRaUWu3jsX8puGcfuwrUzq8XUc3M10t+6lXlEzqwcqB4STAsQwzlZO3S6lNvIfIy5ee1uTwjdjQdyevKHIYTynCOcDU6EAXwVG6LrQSyiWFSAtvgDMpPgIi4Z4zQgzMzEQPUDucMtXcc/eAekYxRR0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv/cTzVZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748e63d4b05so683621b3a.2;
        Fri, 01 Aug 2025 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754065471; x=1754670271; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WfOr68nFi7RZ75J6VereNbDc1xtULTqyasJ/724p6zI=;
        b=Uv/cTzVZcjCXw4NukrvkzUiDAlKCMc8YiDisPyuNUDaFkyRMEHguZNzRBRSP8H3Cdu
         fCrLYqXpRv0HKEIY39xVmMkuSuxPMM4uTRCxuoX3UfzYLYHGkOLJ78bXZkWPZtBRMEjM
         64GbooTQ94wYotkyazY2VJKa+iIXcD5/sTPL9XDEPVYoJCWBjDf0k21W9akLXxqs9okX
         BPMaJX9kfTPRXHEekByCLUDRYjHZ5PaOfXzmAv8bWXXK4C0tIm1Igr5zgfwcfvHQtPoK
         UvIYtQMqNuxBIDEeiqPG9SWV1Dv/4ncLm6XXRXPQlivBtmpK2cyDCmNC2zEOoaPfa8+p
         68nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065471; x=1754670271;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfOr68nFi7RZ75J6VereNbDc1xtULTqyasJ/724p6zI=;
        b=k9FryFKp5QThsZ3Ysu0PrUT3aQLSXIqJKZyol5a+VlH69DLHDJA0FI+9RqyDgqSHlF
         36wtWKLgMGf4rj8W7FKEuSefswgz8+pPCF8Ggsft/k4g+YKs6VNpwWeW7cX5IhrIxc+j
         Zi/VvmhQ98qLYTOM8v4xzG3Jj42dHBhwFQDOc1W0CRmBrPtJmklWiih1DXu2XoSPj1Zy
         ZQI3TSEwpV9woaTegE7cju2G1VeGsDjQA/JyGNV6Ml23Sb0uvEXzj+ECIzE/Hqju02uO
         AyLqCNYgkLYps0bnF+Psuw62sYzaFmF2SggiSDdr/iXteGnTWHm5l7jHDV3HNtVDGWrr
         4Q6A==
X-Forwarded-Encrypted: i=1; AJvYcCUq2jfvdEjIvEc/XpFBSmiPQ3aoxMahpmcumI2gW42RO1LGmM0nBRY++4dkKoE5HYo+PoOOu7c2FSevVecYz4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGRoicMLr6f9SC4jBDgXBo6N4JZwD2W/c3rZiXdaGhmpCWuiV
	IP+nR5RkPspHuTsn+UxziuevcoO1jQsu5twxtkoIQrgOPhkMyET8785U
X-Gm-Gg: ASbGncsOyMlqqwX9acvf8rb8qpUFgW2vwEaatMZvUncTtg0bhmA1qw6E3Tj3y0nzqOt
	sapbQI6lj3eorAa/IIACR2ffbdoabWTgmQePwJX9zh4GLHvU2GAuLnpxLes43wyME4mE8F9vz3v
	sRQp1xaf5B+SJmM7moPYLD2+DwbAJioS+4pEBpvtIQOoil563OtCYTMOIxWFZyDdrQgYh8aQxMz
	nXXQy4vu0zw0d3fHbDkWf3qwLQdMttnLH8qDoTrQdp3B0wx+4MI0I98JR4m0r5Og7XWBmdFCnKl
	a9hliNCzTVsNeknx69+KEvmjeskXIXOMwqRJXw+g8tdngjY/IQeioFGR0odCe85ydAl1armmPpC
	bIJykFm8cbS3Rh+W1z+Y=
X-Google-Smtp-Source: AGHT+IHy5TrgS2VCjYWkDpAA2RBcH5M444iKyKHRsYBHp4pDeIKtU/5mdDRlG0F9pqQGtjY711VrEw==
X-Received: by 2002:a05:6a00:2351:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-76bec2fb5camr2155b3a.4.1754065470598;
        Fri, 01 Aug 2025 09:24:30 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcfa0sm4477502b3a.75.2025.08.01.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:24:30 -0700 (PDT)
Message-ID: <85804ed8118715985eb484d3d649b77d754df598.camel@gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: Improve ctx access verifier error message
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, netfilter-devel@vger.kernel.org,
 Pablo Neira Ayuso	 <pablo@netfilter.org>, Jozsef Kadlecsik
 <kadlec@netfilter.org>, Petar Penkov	 <ppenkov@google.com>, Florian
 Westphal <fw@strlen.de>
Date: Fri, 01 Aug 2025 09:24:26 -0700
In-Reply-To: <aIzpKu2PChlhVGsq@mail.gmail.com>
References: 
	<cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
	 <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
	 <5e7b3c728c88b238224d3dffde4abbd7567b8d1c.camel@gmail.com>
	 <aIzpKu2PChlhVGsq@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 18:19 +0200, Paul Chaignon wrote:

[...]

> > > @@ -21445,7 +21445,7 @@ static int convert_ctx_accesses(struct bpf_ve=
rifier_env *env)
> > >  					 &target_size);
> > >  		if (cnt =3D=3D 0 || cnt >=3D INSN_BUF_SIZE ||
> > >  		    (ctx_field_size && !target_size)) {
> > > -			verifier_bug(env, "error during ctx access conversion");
> > > +			verifier_bug(env, "error during ctx access conversion (%d)", cnt)=
;
> >=20
> > Nit: maybe print the rest of the fields as well?
>=20
> I considered it but didn't want to unnecessarily bloat the message.
> Knowing cnt is enough to know which of the three conditions is true. If
> the last one is true, then knowing the values of ctx_field_size and
> target_size doesn't really help us because the issue is just that one is
> set (ctx_field_size in _is_valid_access) while the other wasn't
> (target_size in _convert_ctx_accesses). That indicates a mismatch
> between the two functions for that particular program type.

Ack, makes sense. Thank you for explaining.

