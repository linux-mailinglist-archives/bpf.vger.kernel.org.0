Return-Path: <bpf+bounces-70177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D645FBB2223
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 02:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0676416C260
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 00:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D462BAF7;
	Thu,  2 Oct 2025 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyM5HyaD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E2918C31
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364328; cv=none; b=o1EEG75hpIAPTc3qBC0Th7OCo94WYMam3BbP9E3dJTxyqmyva3ICFspJU2f3ATpOdGmh84NHN04h1HHSS2wA8X2un3icTTKHnrkUsognSBvOAv0iET69VkJ6D7taJpyFWRO3ZPT67DRL6s5xwJhTqzU7Gl+qbe+DQCdlWrQE2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364328; c=relaxed/simple;
	bh=nenZGwa9qivWflYE/s9LCj8gK7P3c8sHGYY0XU9pt70=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dq8mymZvSP72oE+2qUaSMBXOcBvdDLcNpNBTy/yu1YFDcAv1i65NuLvA9tSg+xf3ays/HYVZbdBTwFj0vVwySKXzMVZncUCsTShSm0voXaRGv7iVbclTCuL5tdnWJkjMQa66xMlQDe2xcopONKSOAAbKrHmLDuodJX4JpZZHHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyM5HyaD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b551350adfaso386025a12.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759364326; x=1759969126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5uujUu9jC/xmCXWechBuEKQVVF2Pi9bLFVuVeYLObA=;
        b=kyM5HyaD02g6PO041czituLwEsBfEkXDtNbq4qv/c/djd6qVnRTSfHtwfXVyS9rYIR
         xqPdWSl3tlcQNmhlGqKcaE/loRpq4W993T0YDVv6w4rhYEc67DhT5HpFG+L3vH2x1Vnu
         k69qzjh3jqfJw462EeoffZu/PK42Z0/b0SdHYFmegFbBb/jg9zvy4M3RrItFNMSwtuQg
         T7lrrchHw+2BQ6LVPF/1gtqo8WA5wCUCDCXJmrbAynHSeBKbF7JRqtLtTVqqd52kHTPt
         RkSZxgtj3oHmybd4eKxso2NaMbqxfjJB40OZuh2fzIBnYwrnt+BxskCYJw2sKs60Wf9u
         yBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759364326; x=1759969126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5uujUu9jC/xmCXWechBuEKQVVF2Pi9bLFVuVeYLObA=;
        b=pLlF+BiHoJUUvGkTg1R14tVpr1fF0wtuRSal5pijCyHlhb3Ih6/uDR3M++s2TneDMA
         9gfPFwWkQsGvnuIIhI5TGi1tf/fe0hvPnJXHuoWkk4PnZ1WZAnb0PINK4uVRTLoiZbfT
         icmdq8McDcU5QmBzcluVqyY9L6SGG0KThlwxEganYi/BWcf0hQ25wptvIazAupMKNPdU
         6S9Mei/RWsUUBGToP+1tM6HhK+7YYBiziEo9dXZwTwidXImBGimAqyTTjRO4ca0iOon1
         cS/DnOYsnHR6lhXBn5I8iWyA3fn3Nt/8caVWNfiDwLnTB/RS33WSDZctYI9LNQU4GkD5
         ftSg==
X-Forwarded-Encrypted: i=1; AJvYcCWGf772H95qdvYo3yVZfM9j7OGSFPXenjsk5ZQkKtile63fbtlNRXUKbJ0A5m05ktDmMs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hSC3PK1wToCb64M8NBzSjhJKK6S500yBy5ZaXYsoNQ/vwuhR
	BgDro3QOCOeTF3OBkI+xmHVtAxBCu8COwMFx2kKpmfKM63Ypc8V2F01S
X-Gm-Gg: ASbGnctMQLto+4Fp2eaN///VODsI0CMczahkLD1Uym9qchguFVwuYI2Q3zvwMBa57r5
	KQHH6IEcND5GF2k/Ifnk8tqsCnf/wDDXHAm/N6vo3FXLPLHhogg927A8u6h/sBAzxyc/vooDYF0
	d6TpS+C+4HeayyNxsFXSjPA8ofkw1kO7k0NwpoAxFkJ7TeOWjjZwWS34HjOb0yJwgsRIG7RLE8W
	fFHkyO/G44N4gDnFV5ckSgx+fLXPG3W8B+12DfRbizo66mMQSCqyZswGfEla4KEiocy6UrL1eL4
	yPYLj19qjWwOTawCKSs0SrV3cdL5GiM4BS9f+Oix99wgN/z6vbKnIkH9nLdMJM7a2gRDlx7dwUe
	ZpbqbqMR9Hamf5iuZ9jLOCyThk8HoUg+oLXaO5cDZF/HnWWVuwatc0ke6pP/Ob4c+T2ob3oe8AG
	+8DxF28Q==
X-Google-Smtp-Source: AGHT+IFkg19mlldX9Pn/0pCzdDMQFXiwIFZfOZdmSLaG5yXFL061esEosEqE8gtdtRdYX5e/G9U6gA==
X-Received: by 2002:a17:903:fa7:b0:28e:873d:91 with SMTP id d9443c01a7336-28e873d0446mr32867155ad.29.1759364326284;
        Wed, 01 Oct 2025 17:18:46 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b9e19sm7848755ad.80.2025.10.01.17.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 17:18:45 -0700 (PDT)
Message-ID: <c0626a7e12038a7afa4a4fda7c0f8e99b99596c2.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 11/15] bpf: disasm: add support for
 BPF_JMP|BPF_JA|BPF_X
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 01 Oct 2025 17:18:44 -0700
In-Reply-To: <20250930125111.1269861-12-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-12-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:

[...]

> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 20883c6b1546..4a1ecc6f7582 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -183,6 +183,13 @@ static inline bool is_mov_percpu_addr(const struct b=
pf_insn *insn)
>  	return insn->code =3D=3D (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off =3D=
=3D BPF_ADDR_PERCPU;
>  }
> =20
> +static void print_bpf_ja_indirect(bpf_insn_print_t verbose,
> +				  void *private_data,
> +				  const struct bpf_insn *insn)
> +{
> +	verbose(private_data, "(%02x) gotox r%d\n", insn->code, insn->dst_reg);
> +}
> +

Nit: there is no need for this to be a separate function,
     can be a direct verbose call, like for any other instruction.

>  void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>  		    const struct bpf_insn *insn,
>  		    bool allow_ptr_leaks)
> @@ -358,6 +365,8 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>  		} else if (insn->code =3D=3D (BPF_JMP | BPF_JA)) {
>  			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
>  				insn->code, insn->off);
> +		} else if (insn->code =3D=3D (BPF_JMP | BPF_JA | BPF_X)) {
> +			print_bpf_ja_indirect(verbose, cbs->private_data, insn);
>  		} else if (insn->code =3D=3D (BPF_JMP | BPF_JCOND) &&
>  			   insn->src_reg =3D=3D BPF_MAY_GOTO) {
>  			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",

