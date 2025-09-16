Return-Path: <bpf+bounces-68572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8577B7F6A9
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7DB1C033E4
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F42E973D;
	Tue, 16 Sep 2025 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTqDqXmf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DB2BE059
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063580; cv=none; b=BZCuUHlpfhbcxWobaW1pXHjBFNbaNtJkxXsRrlZA7rs1k0EgF529fNNrsOkvxlRNIXs2a3MeX0nd4O6V6YV8gTnrG4jh/m7fEO5MBQ40iBDWFmjmlCH5+DUwYJdPoyCoQ38gavcL+2wh0lQHjVyZ7rVYogedhrKsuHJLuT+TOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063580; c=relaxed/simple;
	bh=tPGnB6W8V2+1oCmv0j3Zz2bP5yCdnMpsIDDYeTAvBOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUMnzhwochp3UACBlePxbicmajFEPfVPDCN4HjfttEUG4dcj1g4bisJWmdyDGv5C1skFeIHFgiWokCvi+I1dIOdUKuZBAZp7JjSdnwhHrlboWhUJwwdonDdp59LfrSk2rDWeYb3oeWf1Y1tpZvIBB7iFOYS+xPhBxLw31566Lec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTqDqXmf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32e372c413aso2286979a91.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758063578; x=1758668378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S0FlaDdmidhcR8Sy73qdHacija4PnJkqCsQzapdYglc=;
        b=NTqDqXmfP4BLdXVJ30zhU8W1Y+DW1uda+UuNhd46J8HIIMMORxjVwkNmjVbIzzQTgP
         KjKx/R7wOzALjwHaxVszSPzuhRYNzLdqYQQz760uCuPZlTsxDSkhdOi55520Vbuw9Hgc
         M70j94pV5NtG5tN4ISCFs1mkhbKT+TQAOC47O6LxTSQ++dYCxjHwHK7iwU542XlghWVH
         FxM4LhbrGZIklnAWGA7rMkgvC5D3XmgHl+XGdFIiV36/hhZw9C7/2EeI0MSsqx4i6ZUv
         GQwk7BjsZG/ulPTm+DydS4SfVsuRKd1mpQlhGq3jp8CXZL5Qmsk8DkaKXovXo3xVXwkB
         KvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063578; x=1758668378;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0FlaDdmidhcR8Sy73qdHacija4PnJkqCsQzapdYglc=;
        b=fys4rLtiVJVGTlETaab46HQs5fhwA5CwLLKHfvCnkBX+bQewQIYC4wJybrmoTE7YHQ
         WSRoLC1X2SkWibRwNbcMQW5h3MQtyXAbdY1DdNJ2S16XjFzX3umi9dYBDPagt7hMZczc
         GBPmaI391SmJuxVQ7+8LgCwuyFGtkKKaHqQ887drV1mtgpIjXgRf80o6fkcVQA5ynoll
         GEmkcZnw6bJLU0Qm2WRDmyCrhLvwmqjp2y9TpSrmBMoumA5JgFRjjUhanPsF0A/HYqxC
         wlPnd6bk9HIXzzC8u6sglWFLxtykDxMTn9DSe5Staq/Eqv/0lhXhR5MOh7HDktcyPIoU
         nJFA==
X-Forwarded-Encrypted: i=1; AJvYcCUt+NGsm257yJjkSdaUjfANjnQFtOS39i96ymhfh5VWvoP1O2dYkAYbt1a+gW/JEMgWW/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhKx98syDUlLZpK1d/5lH7FZxFicD11cpKAIzV65Lk5UHWcWx
	BFeZLDIqj6ub+6P9EOQz46E3j29Gx3euhA/aC3+PpXYhWUgLb9q3TOAS
X-Gm-Gg: ASbGnctxCcvF8adOsilKaFqqsx2H4gRkASli5T5slNrTqYJ1VriesT+ktotSCL71SV5
	3/SSk4Bpzqw7eyYe7rz/U9YN1ZDM11ZW4XysuKnpS6CKHrA5b0/yluOXhKqIhs/zgOwIahiKwSM
	EU+a4WSgdTThUl53QdRilXgUtLHcVW5dKC30soQDQ2+Y5tE9uH2FqE7pOEA5+UJ/S8/2NNTQzIn
	FXPoDyPzvqGkAVTB7Y0BK47iD/ycCNF0VwHFkQ32029BIiw0PSNKWBfwk6TUY/YGK/gI7pfMWDL
	fJOhfNahKU6vN1ap8bfLaaXjRSzBRoS78+k67CGIlBsY+uMtUxYHEyKW2qR4lngIukNxvXvpNB0
	NgWA028OVPmH8K71/tnZLWcOxaFQj37KvP+p5obqJBie/KQ==
X-Google-Smtp-Source: AGHT+IF8JAjakJb69I4VWOObACBGqRZ5zZirDwAYS3ayqawrxgl18bSCO2wW1GRJ0yVxT3RHWhnyRg==
X-Received: by 2002:a17:90b:51ca:b0:32e:345c:54fe with SMTP id 98e67ed59e1d1-32ee3f759aamr60937a91.20.1758063577889;
        Tue, 16 Sep 2025 15:59:37 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a1:9747:e67f:953a? ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed257bbf8sm652413a91.0.2025.09.16.15.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:59:37 -0700 (PDT)
Message-ID: <5546d7d1074c1441a2fa0924eef0cf6eed5b98fc.camel@gmail.com>
Subject: Re: [PATCH bpf 3/3] selftest/bpf: Test accesses to ctx padding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>
Date: Tue, 16 Sep 2025 15:59:36 -0700
In-Reply-To: <6efe1666f4747c2c0da87467cf1c61910f64a687.1758032885.git.paul.chaignon@gmail.com>
References: 
	<f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
	 <6efe1666f4747c2c0da87467cf1c61910f64a687.1758032885.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 17:19 +0200, Paul Chaignon wrote:
> This patch adds tests covering the various paddings in ctx structures.
> In case of sk_lookup BPF programs, the behavior is a bit different
> because accesses to the padding are explicitly allowed. Other cases
> result in a clear reject from the verifier.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +#define padding_access(type, ctx, prev_field, sz)			\
> +	SEC(type)							\
> +	__description("access on " #ctx " padding after " #prev_field)	\
> +	__naked void padding_ctx_access_##ctx(void)			\
> +	{								\
> +		asm volatile ("						\
> +		r1 =3D *(u%[size] *)(r1 + %[off]);			\
> +		r0 =3D 0;							\
> +		exit;"							\
> +		:							\
> +		: __imm_const(size, sz * 8),				\
                                    ^^^^^^
			Surprised this works, but nice.

> +		  __imm_const(off, offsetofend(struct ctx, prev_field))	\
> +		: __clobber_all);					\
> +	}

[...]

