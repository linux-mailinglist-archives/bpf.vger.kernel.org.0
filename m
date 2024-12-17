Return-Path: <bpf+bounces-47124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7AC9F4DB2
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 15:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4239B1891282
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0C1F4E43;
	Tue, 17 Dec 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxLEbmkQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889B3398A;
	Tue, 17 Dec 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445710; cv=none; b=jQQKJM1g5UPRixfXScAD0p3TuhEQ7ESsTS8XEfEHeh+TxAtUTUaqFQJMH9YJQAoihGarTXCYCXDS4eiSGJdkTCY4KHwM9+gB8saHDS73vElVp1k7cb4UPMvLTpN9ysYYD+2G7it/uBMOikRC9+HGnBFWBimIK65ycfExEKf9Onw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445710; c=relaxed/simple;
	bh=ORnPEhG/btUbZYpsTi4A4T2Pqz+SCl+GfVGEg37ZEW8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkMhCxofpcU8F7NgWVGP9/Iz/6kWBqMsQjuAvHTay0B4PNvD6VzdVjqZ9eo8UX1zyrEIC+y+HXk7ri8N4Rl1ToycJj+knHu4ryxHJr9yLXwvTlAUhnIkh84MIW47Whye7Du6bG576ujCdeXqgQYUQdWWOSdIAJrAjSYaeAkqQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxLEbmkQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa670ffe302so992866566b.2;
        Tue, 17 Dec 2024 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734445706; x=1735050506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IiVnwmp6sXattZvPbilIy7krIJ3DVv5UKIAfZVX61WA=;
        b=mxLEbmkQjFKh1D8WG1X+Mge6Lh5R+XVmPqOnsVePKNg0fdoLBiGKdKwkAAEY73LYjt
         hBJQszLwthQr6BM5PvKwA5gHgOk2JcvKJwuSwXZrg2zAK7M8yRfQw6WtIaLAO9uWF70a
         GxpPlf70akbC6NQydMX4kX0gBq7/gixFm7PP7cEY/lq2gKMAQs3PbvvX3CxjU279Hr8T
         Bf0x0dNZQt7xwfpcFGaTSQ3m8y/K7CSx7xmVOeEtjUIuz+gaDZv9CL/Ysaz1OKMHiCR2
         lgFpnDzC3JVZfPLz1MVJ1oLo/6G6hFra/Hi92944PLw5yg6SKKhBO40PcYKyX7pG2gLb
         lDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445706; x=1735050506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiVnwmp6sXattZvPbilIy7krIJ3DVv5UKIAfZVX61WA=;
        b=Nm7REwVdIlQ4dZOJzkip0Pj0RVHzTfyQ49MLPYCEEiZPBf7NspdELk+pSKkrWYbCFX
         5a2n3WN3eP9nU9IvT0IorDSEHMRi+iZ6wTSuJkGY5eINdfMaVfoF9Y3mhLfpcLGAzQDT
         OxAH8Gl0rZ9p6o/LO6AQKdxjcYTleziJXMqtB4bZ0OWTcOxoF5Pc7m+gcBtXYOiK+tfF
         SDQoL40vT0nESOc854SF2vgwo1DhiY4VQAjAoKyfLfbs4oa879i0YpBFmoJGLmJG1IzW
         A7wxpQiEIyQWNnxx3Df5WgGaukUnHvQjXfVBbrS90APKvUOe4TjvP688kUsjUseqLpvb
         5YhA==
X-Forwarded-Encrypted: i=1; AJvYcCUiOpvJQnh921mcbcUb7u4qvMU0df9DrylwOex8Wvx8x+5aDazCZsuh+KG/7e4G/rL0vMsNDjvCHw==@vger.kernel.org, AJvYcCUowtTj867gY7kTW4rsmG3zRudGqMsiow9q4nmFcn1kVpFejbTxJ1kNz1Hs+GAkEHqD644=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUh9KG2TQFg6PHc8aEAafTFY6JIbRQhswfE319/MGQYazwQUeH
	+Ugiad4Ick2IqZyhjDp1kN87ekh8Rh325+kFbH4EZS4i+jVZHTJX
X-Gm-Gg: ASbGncv/zgCuNvv99D19oRQSILWQALQgr/m4cSvZlEGSejVZL339pcZkXtqg5vz7h16
	DSqqTLXAJDGtMKNUu/hmJnHkgPA0u/5Vb7PdhQBWeiBkoViDnUlbUkZhBwOLY/M0kAOAqyIBuH9
	77cxrqzMpPGDxVF80AthgGURd58lCTCEkdFQhMUz2ykOtC72421WFd8iG3qkIaFtaw6k1316dhn
	+F+AIWTee4/1r0RJ9yofwtDRrfp/KZHW/9ZEjMzxXK7TzXj/rgrbGNfa2+MVGmhjDGN/oMF7Mbd
	q5NQnnu5eUlgQk9On98igwo1R/5FjA==
X-Google-Smtp-Source: AGHT+IG8MgsKYwwgy1oLD4d0uwoM9xY+0cv+YV5GALhC2hcHZLkFmga/prYmbhzyJ2Y644Q17WlBPA==
X-Received: by 2002:a17:907:9816:b0:aa6:89b9:e9c0 with SMTP id a640c23a62f3a-aab778c7b9amr1506968366b.8.1734445705737;
        Tue, 17 Dec 2024 06:28:25 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aabcde10752sm184424166b.23.2024.12.17.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:28:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Dec 2024 15:28:23 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, yonghong.song@linux.dev, dwarves@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
	olsajiri@gmail.com, stephen.s.brennan@oracle.com,
	laura.nao@collabora.com, ubizjak@gmail.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: verify 0 address DWARF variables
 are really in ELF section
Message-ID: <Z2GKh5NziEvjXEWG@krava>
References: <20241217103629.2383809-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217103629.2383809-1-alan.maguire@oracle.com>

On Tue, Dec 17, 2024 at 10:36:29AM +0000, Alan Maguire wrote:
> We use the DWARF location information to match a variable with its
> associated ELF section.  In the case of per-CPU variables their
> ELF section address range starts at 0, so any 0 address variables will
> appear to belong in that ELF section.  However, for "discard" sections
> DWARF encodes the associated variables with address location 0 so
> we need to double-check that address 0 variables really are in the
> associated section by checking the ELF symbol table.
> 
> This resolves an issue exposed by CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> kernel builds where __pcpu_* dummary variables in a .discard section
> get misclassified as belonging in the per-CPU variable section since
> they specify location address 0.
> 
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Tested/Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  btf_encoder.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3754884..04f547c 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2189,6 +2189,26 @@ static bool filter_variable_name(const char *name)
>  	return false;
>  }
>  
> +bool variable_in_sec(struct btf_encoder *encoder, const char *name, size_t shndx)
> +{
> +	uint32_t sym_sec_idx;
> +	uint32_t core_id;
> +	GElf_Sym sym;
> +
> +	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
> +		const char *sym_name;
> +
> +		if (sym_sec_idx != shndx || elf_sym__type(&sym) != STT_OBJECT)
> +			continue;
> +		sym_name = elf_sym__name(&sym, encoder->symtab);
> +		if (!sym_name)
> +			continue;
> +		if (strcmp(name, sym_name) == 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  {
>  	struct cu *cu = encoder->cu;
> @@ -2258,6 +2278,13 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		if (filter_variable_name(name))
>  			continue;
>  
> +		/* A 0 address may be in a "discard" section; DWARF provides
> +		 * location information with address 0 for such variables.
> +		 * Ensure the variable really is in this section by checking
> +		 * the ELF symtab.
> +		 */
> +		if (addr == 0 && !variable_in_sec(encoder, name, shndx))
> +			continue;
>  		/* Check for invalid BTF names */
>  		if (!btf_name_valid(name)) {
>  			dump_invalid_symbol("Found invalid variable name when encoding btf",
> -- 
> 2.31.1
> 

