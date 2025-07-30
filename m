Return-Path: <bpf+bounces-64730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D1B16474
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DD3622075
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024C2DE71B;
	Wed, 30 Jul 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISdH6fY/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC12D8368;
	Wed, 30 Jul 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892016; cv=none; b=qMnhroOWiM8ZNguxhOPpx00/QRcfLjlEM4oMcoqToAhyNqbX1mY3S/L+6NhBzw+Yxx4lLRaH+/ZaH2F+mbxJ9TnXzeqqpswU8yDloTLJk4wQtVFwrxU7GhbwMS63DPW0DwpP2ryz0yDr1HKiWo2zCL6GIBFz42/9DRiCxhysbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892016; c=relaxed/simple;
	bh=0PF5NUEd0WyI2Xp2HpSr440L/r7appM8CdBDYgI55iM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkfNHGGPponLm7aLNkP8/E8wIGw3c+KKqiH24NNulA2GirWjpry9gduVSijRXKyz2LtmP6SmcHQTzXc7Rxdit5FJuFSd5CeRt/wPDrKJ4xCI8cOKp4xsjiREOhjYSX0eUsfwChTTyfn9noWTm+L/r4gsFanAX46H1DWKuotgCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISdH6fY/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23fe2be6061so9605215ad.0;
        Wed, 30 Jul 2025 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753892014; x=1754496814; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dQUCXzvYt5b3ohSOIHozCTQslzQ/AVFvh6qH07LQ54U=;
        b=ISdH6fY/BcimD01z+0ACrvXiutCu7kwLBF/V4gIswJz7aDd+QRn8Npq7sz6d46nRTz
         DPgh0GGqLGgTdk0oVbjj2vuRzGCoN2c4wL32OF1UsT9puRTyeW9srpAA4LjuiMtsj8kX
         flS1/JzdPvXHWbIbbY8iHOs9zropAxQopYvnw6AmijJAQpeAsApdf7YEwERh5+S1k/I0
         HRLnEAvJoTfuICpL4q+B/Cn0FPvUmARlG/qtRvIYmgVgvMK88jGInVu71Mo5gva84u9T
         TLCxVjAomzBUUprgwUbxwmaynrr/Y4HGomdMIeUsCjljOxtMLNcOR6dTWnE2128hjpS1
         Ng7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892014; x=1754496814;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQUCXzvYt5b3ohSOIHozCTQslzQ/AVFvh6qH07LQ54U=;
        b=gL9T2+3coqJJIENuxF/K984HT+Z2RKe99NL6c8vVKEJu75BNDtAFo46kGVc17q2dWA
         OYgRXRbiLHDylBVQ2vDCnqQnuOp5Jry3irugSMs+Eu9ZelYsky7vyWVku0avABJldQDi
         pMPYFbvnBjpHUqPDfb+BGuk1XlEyDjKbM9NpwdikYc4TezYxOfOlmXtqWSls3HhQ2m5c
         O6L2YctrkHQY+5vs7NuJax2KluOD+LX5yzN+A0jgDBlFaQguqZfNSf9ubn/RwnQhMF8W
         B/oC5+KZuw5+bVqogVOQkbSCWforzvDCWCwOWKsB56GPKOnayZdPd7h+xfgDO31oxgVn
         hUXw==
X-Forwarded-Encrypted: i=1; AJvYcCXLnzs+NdU/L/l84cnULd7cXSFKzZJP/bF4LCiKqV/ynEn0nAuh1nSKicrM7DX9IJUxBRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3uWIZ/L8oTyBsX0wDUS95lXTOsGFwUKxQZpcU4LQNBLy2yen
	HN71Q8YHWKF7h1iLt7ZiBk2Hq3+9N6vnsCSU/TPIKcyoeuqlLIRB/6RO
X-Gm-Gg: ASbGncspuiwHTfmYM2SNJlsYHM+vo5tKBwVW4Baf2kmfYI4QswRFjI8ImplE0Wre9jQ
	wHf3MMTlgloKE+Lsw0eYA64swzTQHmAOzxYwRA8NQxd24S3CFePMZIRutGgdnN034TpoL7jSoeY
	iCQyfJmipFR4GMyKLL2qt9vNjLGDk1C6CF5OakeS2+yhnPXTqE5TE7i4r4cx0eJ4D+Dk2BMCf1e
	Jy1mtKnxAHCqg7+y9LpgqkwPLV+pOY8k/rVvKEiHowLMz3ZM6YnPfFe4wwvrzHyKukIZtarPddu
	LTDANPHVq1cn98IQvS/rTIBEKOhQLj1r5gBicmJ/TJ7Y+PjNXsUeT2lfRcYo6P0F8Y5ufl4Y7CT
	5kxa0Gt/Xyw1lX6kkJe++fVK1aP5d7fFMiIXE57A=
X-Google-Smtp-Source: AGHT+IGeFSOw+/X0Z7X4n9ogZ/o87Th6ejMZXu2HkaiuIh3jZZvvHw0QjHjI57QITzDcg0qs70orEw==
X-Received: by 2002:a17:902:fc50:b0:240:20a8:cc22 with SMTP id d9443c01a7336-240967c5fb9mr54261485ad.4.1753892014219;
        Wed, 30 Jul 2025 09:13:34 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::1cf? ([2620:10d:c090:600::1:f0da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff71916f0sm87534415ad.147.2025.07.30.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:13:33 -0700 (PDT)
Message-ID: <a74ec917c2e3bf4d756a5ce2745f0f0a2970805a.camel@gmail.com>
Subject: Re: [PATCH] libbpf: avoid possible use of uninitialized mod_len
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Achill Gilgenast
	 <fossdd@pwned.life>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Viktor Malik
	 <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Jul 2025 09:13:32 -0700
In-Reply-To: <49c6b3ba-7860-4b13-944f-5f503eb201fd@linux.dev>
References: <20250729094611.2065713-1-fossdd@pwned.life>
	 <49c6b3ba-7860-4b13-944f-5f503eb201fd@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-29 at 09:17 -0700, Yonghong Song wrote:
>=20
> On 7/29/25 2:45 AM, Achill Gilgenast wrote:
> > If not fn_name, mod_len does never get initialized which fails now with
> > gcc15 on Alpine Linux edge:
> >=20
> > 	libbpf.c: In function 'find_kernel_btf_id.constprop':
> > 	libbpf.c:10100:33: error: 'mod_len' may be used uninitialized [-Werror=
=3Dmaybe-uninitialized]
> > 	10100 |                 if (mod_name && strncmp(mod->name, mod_name, m=
od_len) !=3D 0)
> > 	      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> > 	libbpf.c:10070:21: note: 'mod_len' was declared here
> > 	10070 |         int ret, i, mod_len;
> > 	      |                     ^~~~~~~
> >=20
> > Fixes: 8f8a024272f3 ("libbpf: support "module: Function" syntax for tra=
cing programs")
> > Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
>=20
> The code itself is actually okay. The error is triggered due to'maybe-uni=
nitialized'.
> To silence the compilation error, I think this change is okay.
>=20
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

I agree with Yonghong, `mod_len` is only read if mod_name !=3D NULL,
meaning that "if (fn_name) { ... mod_name =3D ...; mod_len =3D ... }"
block was executed.

Please drop the "Fixes" tag.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

