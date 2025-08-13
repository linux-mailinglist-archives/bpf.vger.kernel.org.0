Return-Path: <bpf+bounces-65534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA4B25314
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2FD568483
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2892F49FD;
	Wed, 13 Aug 2025 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwbcUupB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AD291864
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110049; cv=none; b=YEnatuUV/GAFJ6GN2EDmw9NbRM3kAU83nLeSRuKJ//TTRcgJpAbiezn0jFe3Z1yJQaHQZmjFXCpCnN8OaHlrtPbPj4KlDOcCfE2j4NuCPj3rc6OU/aAt6DF7+Enl30GwCdZwgZ82oIB0XOjLhVi+VzbBkJkQm7TRzF+KSBWsUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110049; c=relaxed/simple;
	bh=pwwwZv/8useDNwSP1/lT7v0iLARn/mYf7boEh+nNb9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWnZnW4nhi1VgPl77fJiJho+MgHco3Lux5hjxFI+8X5mzB9+EmKl+2xn73OE9Qothsrca+SRIZpC6+8Jw72q0lGJ1IfRLgKNnEvvc2nkExN1mr2+ucPWYLcwnJauo4F7siENLjLW5Mi2PmTpwaAsDV5VD2f1SBOjivUvlBOE1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwbcUupB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323267b98a4so244806a91.1
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755110048; x=1755714848; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K0+piq9HyCSesXHSBrjcYqPk0QsxLirH4qHcyfN0fRY=;
        b=EwbcUupBnpbIfGrP2fH31fR/f3Gsv9r1VdS1st88qMe1DCd955ToFgJB2M+bE7Fspu
         qv3AuYo6+GG5mVUas3jDPgZRFHC0me7KLa4hkGCtknsnqqHJmYoM3NCYCNSQqwsulFo0
         An90twRJvy4lmxb3Kz8CZKYytkOjXNek3jnIrZl1TnRgD3AR6koMPJg3/KqHst1ahHhc
         SaF6EUXJwOltTlRkDXRaTuLiL8SE5e+94cbU/xuO4sogrJ4KOWtfq9BCyJdqjytz6p5W
         jA/maPXHaYL3no3gvmbI91C6TLGwyZ8RHQ28l0oFMj6jYkWBtJH4QLYhfpBGG9VfXLIq
         Ttww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110048; x=1755714848;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0+piq9HyCSesXHSBrjcYqPk0QsxLirH4qHcyfN0fRY=;
        b=Ry4meuBY5visbcy8Q/80Fw3ZQ8NdfUjRlCunI01dtbmWUz7PuWf697qH+V/uiWyvVs
         dS3X7glHjQY0rDHtkahONRh3x+L79mEVI4+bzLDMcgiMAvFWVNmpMj/5AoQaawIIfqKH
         O+SOIlk2adZbws0SnVrLQDitrjyTQ6HTkDjX0AnasDesKv9XBgrpR+13uhaAE6BibrjX
         kO8EUd4Jh6JELWsrRcj51mC/CaM3INOB3hljVxpOZhr3ucFqm8ydnrba9zcsDKEGdWE+
         jjcVVLejZIKz2sIrMnnxvuTTU0mrLYwvufc4HICOxf7z+6NKeIpwQhguSZQLHTZuOu1E
         RS0A==
X-Forwarded-Encrypted: i=1; AJvYcCX4HOI32RgzYuWfWMwIiBez4bngfG9fHQ9Sc5+oKPL2uYnb42lrKwgml0JoCBGSOu7EDb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsPJ0vHMWYqzS9dNxv5oKZ8Fk84vgtzX632/tIUlGbMxIONd6
	A1P6MbSmpIK6YQR+5jzd2JbK9LkM8Xv5gU9gAlRafxMNzsL3KJRd4asR
X-Gm-Gg: ASbGnctPmTLQHVn2SGLaqSI4TvvCeIcvb8ZnEIgPQSDjdPXEcuHndeaDD1yImg45q+f
	Y6MMY1MHIEsy1MxvyQrg3IfwlKwlucFq2jSBidtHFFaxHeGNOdMj0kK7EjGn5BzmKPrSxIYvtGg
	vdb/BgR9o6kGR6Df7u4aKisoVunAmIo0SwGYLPW5l1tcekEwhCZVsnf7osB8kw7wmnQkgIsWFOM
	31Kw8/UX6quc1/P65sijJLOYWC03B0PeIs+ngbqtDSIDxcr1rKmcVhXqcEiHkJJylhJlFsrEYqY
	caQwxm9XIY3gXOim3FIexoSgXF1pBKyACrnQHZ1y7oTSSlrW3oy87azMtFmUhF8f82gFN5WKOsO
	sS5harf+rl6n+QBkbwviZdYspmpoh
X-Google-Smtp-Source: AGHT+IGk/aRhikKIMMeXAVSXHoTN8bTHUaptf/B1g3ZgDMDn2PB1KAPYupOzlnjsTBXAvSI9UDOSiw==
X-Received: by 2002:a17:90b:530f:b0:313:2206:adf1 with SMTP id 98e67ed59e1d1-32327998e16mr585735a91.4.1755110047697;
        Wed, 13 Aug 2025 11:34:07 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::e47? ([2620:10d:c090:600::1:68a4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b471519d8bcsm360080a12.61.2025.08.13.11.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:34:06 -0700 (PDT)
Message-ID: <a4c4e38b669a05200570fdfc66f4bdfc29dbb3d1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Tests for
 is_scalar_branch_taken tnum logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Wed, 13 Aug 2025 11:34:04 -0700
In-Reply-To: <85f82f190955844509eb77ae95f4ef20a587acd7.1755098817.git.paul.chaignon@gmail.com>
References: 
	<ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
	 <85f82f190955844509eb77ae95f4ef20a587acd7.1755098817.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 17:35 +0200, Paul Chaignon wrote:
> This patch adds tests for the new jeq and jne logic in
> is_scalar_branch_taken. The following shows the first test failing
> before the previous patch is applied. Once the previous patch is
> applied, the verifier can use the tnum values to deduce that instruction
> 7 is dead code.
>=20
>   0: call bpf_get_prandom_u32#7  ; R0_w=3Dscalar()
>   1: w0 =3D w0                     ; R0_w=3Dscalar(smin=3D0,smax=3Dumax=
=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>   2: r0 >>=3D 30                   ; R0_w=3Dscalar(smin=3Dsmin32=3D0,smax=
=3Dumax=3Dsmax32=3Dumax32=3D3,var_off=3D(0x0; 0x3))
>   3: r0 <<=3D 30                   ; R0_w=3Dscalar(smin=3D0,smax=3Dumax=
=3Dumax32=3D0xc0000000,smax32=3D0x40000000,var_off=3D(0x0; 0xc0000000))
>   4: r1 =3D r0                     ; R0_w=3Dscalar(id=3D1,smin=3D0,smax=
=3Dumax=3Dumax32=3D0xc0000000,smax32=3D0x40000000,var_off=3D(0x0; 0xc000000=
0)) R1_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3Dumax32=3D0xc0000000,smax32=
=3D0x40000000,var_off=3D(0x0; 0xc0000000))
>   5: r1 +=3D 1024                  ; R1_w=3Dscalar(smin=3Dumin=3Dumin32=
=3D1024,smax=3Dumax=3Dumax32=3D0xc0000400,smin32=3D0x80000400,smax32=3D0x40=
000400,var_off=3D(0x400; 0xc0000000))
>   6: if r1 !=3D r0 goto pc+1       ; R0_w=3Dscalar(id=3D1,smin=3Dumin=3Du=
min32=3D1024,smax=3Dumax=3Dumax32=3D0xc0000000,smin32=3D0x80000400,smax32=
=3D0x40000000,var_off=3D(0x400; 0xc0000000)) R1_w=3Dscalar(smin=3Dumin=3Dum=
in32=3D1024,smax=3Dumax=3Dumax32=3D0xc0000000,smin32=3D0x80000400,smax32=3D=
0x40000400,var_off=3D(0x400; 0xc0000000))
>   7: r10 =3D 0
>   frame pointer is read only
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

