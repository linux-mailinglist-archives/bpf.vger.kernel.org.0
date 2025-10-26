Return-Path: <bpf+bounces-72270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC8C0B1B4
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5E3B5BBA
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0023EAB9;
	Sun, 26 Oct 2025 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/2Tx7MH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E122D795
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509140; cv=none; b=AxXEBr51SH4KaT4UWGTEZLVUf3ZjnqqFXchrPLZe21/k8YYnSBtk/aU0254bxA2FxerELLh7RPCSzh4WNujGSVvcwi4lRX0dqUAgLbUzkjjAXmPexoVlDwk+QDoDiMa39N1nkWwbTdXcbI9EL/cZ1ii880tCzGsA5jRnTOpxZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509140; c=relaxed/simple;
	bh=gwzxFIYA+EH2tUQMS6FSqJt4xozE2v1xKDfzbfQD8IM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKyLWCNs47NUhF8NlUxRyCj3CkhggGPlA5zJ3tKkHySY0toOPla4LtVGNI5mV2tnFcSfnljNDrInfFiPKNBdt88RB/OsEa8KVEsR2tDNuAWiCUIIs+55cFkOfe/xFx/FMYDlix6Yy4FTWUxG1gE61C9iyoNx4xByxp+PgePyyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/2Tx7MH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3179784f8f.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761509137; x=1762113937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09j/hR65hy6v3NaLfSDQsgAVNEKTKjHE6aSYhG6ONv0=;
        b=M/2Tx7MHToK1RMK+yDLTRFaJ8F+BXfH7E922OPb9K0YrgUbDRrw2oSIWRKq0OnaQQ1
         F10VjpC7CPKTCerGp1rPDuX/uvkgZcWRFaEgGD6ss6wtgwcewPE+PaauRJjwDw+8L/Tn
         DvAi3b1mP2kuZ7uiHjQ+yNtiS/ggNeWy1vthIu8OR/kU5yCWPGL8o0tNYKx9/aEUEcS/
         ccfrETUpP6wtq2Rodp6oDekhWtNhK/PUWSCv5RvtkySCbZUU8weJ7UlVHzJcNQ27/RG6
         sDhbOOK1TmG6xU8dpuVUOj/QykPJlM+xqxWW5dgnP/hd8PUw86Vh/9adWEQT6UCo2U+k
         OAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761509137; x=1762113937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09j/hR65hy6v3NaLfSDQsgAVNEKTKjHE6aSYhG6ONv0=;
        b=wZTPLrgtoevpIHQiHV0vAGcm9FUmifMWD/2Dl+aJxlHo68AnhT4ytbLql6lBX+emuP
         M5FS+/Vh9pFJZq6TPHIB/DwyC78qO7KWPPELDeuwpVYRAy/yPynZomtUfZS0uf2gKeF4
         LffUu7QQveSnqtpCE30OxkE2jW/QaDJ52CBOmPqFjQ7r3OFa7UlT+wm70LcHVnOsxhTq
         stq8yti5dXacimoVnF4iGmpuevZeoWe4h2mhud06z8nNberjqgdLhvLAH7dVvUDEaltR
         NcLrPdVjmszcTE0HGBZpG84zgIr+QnS7Ztym4hko2JkDNQaS1vjWNotKHYlfocrKC2Mi
         JRkQ==
X-Gm-Message-State: AOJu0Yyb2NsbfpTWrZWFRR/x5iVFs+Y9GeTUolzBB2ia+4aga+rJAtE0
	lpEzShSICHVNQqHUVha21ykAhzmOMy+kxk80LAYMJYC/TLLiCKfW+hU2jvc0zQ==
X-Gm-Gg: ASbGncsd+hE9+E7xhXUcWUbDfHm5l1r9Uue0F5/T+SrT9097sRSvNFBUUSUCxNHQRP2
	iGeoerNLVLps0hWx53uumcDukuo9ixU2JI/gXEPZ6P9CHBIbVIY/HmaSusvOo2fdTpNPTjWQg0P
	K9/9rBksqA3UVx2Xx19Sn7DpahZy/l5i0oLOMiFzzs7cS53P0ilR6noOaVj7n9xml+pITg1equK
	KB5ByqaA9xu78Z2Z0lUxOBST+0PvrEHbvoX4lYo6nKb3vf6IP89yr8ACF5+L/yhrGXXs1rtX6Ux
	cI3ipXhKoGCp0SFyRnyypODZV/09UAaYNav1CbabtowXi9SuRy4YqcjZKHIauxRevBZv0Krxwpj
	hqi4wjpnvxWM3D9051Vo52QSh2Cvj9VZUrH/2/R2Q1MsC2jNQ+e60m+qCEVpPF2Ml2CU2F5O+Rf
	ZbMGbXjTrjdQ==
X-Google-Smtp-Source: AGHT+IGG2DKlWipt/rl0aoj13UfXE2ALnL+Vve98EdDhKUAC7vzyASS6kOk/3MsmEkPiZUNd+5oWzA==
X-Received: by 2002:a05:6000:2503:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-4298f528dcfmr8686857f8f.10.1761509137049;
        Sun, 26 Oct 2025 13:05:37 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm10115681f8f.41.2025.10.26.13.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:05:36 -0700 (PDT)
Date: Sun, 26 Oct 2025 20:12:16 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v7 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
Message-ID: <aP6AoA+SCXh+wKEF@mail.gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
 <20251026192709.1964787-2-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026192709.1964787-2-a.s.protopopov@gmail.com>

On 25/10/26 07:26PM, Anton Protopopov wrote:
> [...]
> +#ifdef CONFIG_BPF_SYSCALL
> +void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
> +			       update_insn_ptr_func_t update_insn_ptr);
> +#else
> +static inline void
> +bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
> +			  update_insn_ptr_func_t update_insn_ptr);
> +{
> +}

AI found an issue here. The semi-colon was copy-pasted incorrectly.

> +#endif

> [...]

