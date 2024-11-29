Return-Path: <bpf+bounces-45889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3989DECC8
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 22:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8986316328C
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 21:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53B1A070E;
	Fri, 29 Nov 2024 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv3Mrzy/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBB39ACC;
	Fri, 29 Nov 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732914198; cv=none; b=H7ZXLERphe6k+O0mizeawU9+Ox7bdDwEm41VW9VRU5g65p4tfSHo30wzSg/pIICGKogum5JDJ/AXWnRImmB81d2XrAe6FZQxhq81jD8XFobXGDunh0Yc7zL6qSJDso8gPcdLne1+SdWvMFAj84HK2D+Lub5CBrkB23OkXy9H+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732914198; c=relaxed/simple;
	bh=1fJAl9Z9QC5AEKrnrqAwKDeSFicf0G71GTC+0UDbFQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEEAuWKdeWMlcCT1jmFfcRSMoEWaMF1AQYCRudJFPv0Nh3+9S3fBBues8IJJDLyBUw7B5tN8rmAWHyrjuB6eecZdpy+awABR2fF+sx2wW5ibBCQpzBG9RA3qjcBDI1hwEdufPqLPEsKmGb4QRgXutlUFuVbPzSmo8yBMtbi/Y8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv3Mrzy/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f74d6457so2288316b3a.0;
        Fri, 29 Nov 2024 13:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732914196; x=1733518996; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2gM8cn7cYQVh0IrMqhO3bozfhaPSUnBQGF8gqaz4rrI=;
        b=Zv3Mrzy/3VAJGvzAGs1QpVSaliDYYRla1PLhvEGRkb0DQb3kRGW2d7TT6sqHFkzsKD
         7CnMMupyOlLx+Hpb+glM4llmDbqLryJLSUOhWDAumSpP6V2DoBbLyTkRADSGiL3BRH5d
         AY1NyITzKzzXhS8h6DBpp1Untgm8wigW7m+3mmzmxtLkZ3hnsUuU0LhEnRN+KE1MQ9+o
         +DXY6yz5Tz4ULNxDqE06HGR/JFGGRmb6MeqCA0ZwEH0mKvO3nLhWcyH++hfIXz7ekfuJ
         W6znGa1K/ANhAdbhlBo2uBgTEqTI5VoCveFdsa5nv/HnFliegk94qnBMqgs4y6WJx9GX
         2qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732914196; x=1733518996;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gM8cn7cYQVh0IrMqhO3bozfhaPSUnBQGF8gqaz4rrI=;
        b=WVt6rws5sgEjWT56InRhralIDF83veNSz8gfJGpdi/npOsnYBgF7W60VVZElI6u3HD
         PmBQjWR4xRNUISUEPiLVXZsqj9VU5Wm20QyE3ZzySoEe47YkRqq8riRoQqNudawp4vQa
         WxJfyQLyu65udsKGw5bhxJD/3l73tNibS6YVrjMYkue4DApNZkwfqBUHgqrUTxfWxFua
         5Iy4QojiD/tWlZ4sDzwWg4LvRCRgCOkwXQJhKADd8L1kJHbZDxTwJ+waVeaO5NyWXIwW
         aQKqpnJLREEYvMvex77JpEqGrcgjJw4vGYnih9homN+NoQvP8O3ufs5cMEz/Z+Vnplgm
         +MIA==
X-Forwarded-Encrypted: i=1; AJvYcCXnCdQih6QfuEjmhr0O6PaxBMPbG/SF2yLw+7bmEGbfUULJOogpuwiJvP467mul+lajH0kSR8j+@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbxoGyqh0ZB/JKzNTH6AIhYarIUEzsxytvX9+zcaGlnVuS4be
	zYrlTbDQ5pjYni5XetOgPQH+CuOZ2tipb0SMZWKI3mwxqYyoMwF1
X-Gm-Gg: ASbGncuGKtHX435Ylzxq4fHexFSNWNEomqghQjSRvSQWxC9zVDXvo9vc6IDZYtPSPGD
	TpqFXkaSsLppLJt7mjVgYhY9LdcKqG6I0chIoiAg3kO51mB6WDy924AImD+cgfRzMkoinoRrsp6
	4LA5QeH0RJy78gFOCl2soNninaCjswaNjGgAWFwdbX5qptLKiw9VsadUoQrfnnVXpmHIl3EFwx1
	2f4UnvDbJvXwmPMfhizm5RQOajTTyAz9VODq8e48prVwTg=
X-Google-Smtp-Source: AGHT+IFcnQ8VSsonKsmOwedrY9E1XgrEJI358Xch4LkI9YBMCX+nCpqJlDZF83x7FM6BiBtMGzT/TQ==
X-Received: by 2002:a17:90b:3887:b0:2ea:77d9:6346 with SMTP id 98e67ed59e1d1-2ee08e9fe11mr16264002a91.11.1732914196055;
        Fri, 29 Nov 2024 13:03:16 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2edeed251besm4087537a91.0.2024.11.29.13.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 13:03:15 -0800 (PST)
Message-ID: <f1962647c94b3f34ed5a908d1eeaba3a883801f6.camel@gmail.com>
Subject: Re: [RFC PATCH 4/9] dwarf_loader: introduce pre_load_module hook to
 conf_load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 13:03:10 -0800
In-Reply-To: <20241128012341.4081072-5-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
	 <20241128012341.4081072-5-ihor.solodrai@pm.me>
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
> Add a function pointer to conf_load, which is called immediately after
> Elf is extracted from Dwfl_Module in cus__proces_dwflmod.
>=20
> This is a preparation for making elf_functions table shared between
> encoders. Shared table can be built as soon as the relevant Elf is
> available.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  dwarf_loader.c | 14 +++++++-------
>  dwarves.h      | 11 +++++++++--
>  2 files changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 598fde4..5d55649 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3796,13 +3796,6 @@ static int cus__load_module(struct cus *cus, struc=
t conf_load *conf,
>  	return DWARF_CB_OK;
>  }
> =20
> -struct process_dwflmod_parms {
> -	struct cus	 *cus;
> -	struct conf_load *conf;
> -	const char	 *filename;
> -	uint32_t	 nr_dwarf_sections_found;
> -};
> -

This is probably a leftover, moving this structure is not necessary.

>  static int cus__process_dwflmod(Dwfl_Module *dwflmod,
>  				void **userdata __maybe_unused,
>  				const char *name __maybe_unused,
> @@ -3826,11 +3819,18 @@ static int cus__process_dwflmod(Dwfl_Module *dwfl=
mod,
>  	Dwarf *dw =3D dwfl_module_getdwarf(dwflmod, &dwbias);
> =20
>  	int err =3D DWARF_CB_OK;
> +	if (parms->conf->pre_load_module) {
> +		err =3D parms->conf->pre_load_module(dwflmod, elf);
> +		if (err)
> +			return DWARF_CB_ABORT;
> +	}
> +
>  	if (dw !=3D NULL) {
>  		++parms->nr_dwarf_sections_found;
>  		err =3D cus__load_module(cus, parms->conf, dwflmod, dw, elf,
>  				       parms->filename);
>  	}
> +

Nit: useless white space change.

>  	/*
>  	 * XXX We will fall back to try finding other debugging
>  	 * formats (CTF), so no point in telling this to the user

[...]


