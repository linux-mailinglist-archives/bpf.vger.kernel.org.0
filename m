Return-Path: <bpf+bounces-64166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E369B0F350
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50634188705D
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9862E62C7;
	Wed, 23 Jul 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbzNAY7c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807E27462;
	Wed, 23 Jul 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276131; cv=none; b=i2myZvOVoz0lixKK+DtPk62g0AYRPVc1lX611THIAsluRsDhf3Pa0P8psUORNXN93d2J2ftgRtuZ13NfaCk9ip0v60thU8XmIHHYWXnR+gOXMwxuc9qryboFCnTSGurpSWLW84gQIWfhh7a8i3h9gjKnevIHG8Hdjj7i7Xp/QQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276131; c=relaxed/simple;
	bh=yfmGsiFC+dIczt/LBxNUwbIxH2mD71bvoQ0IaVpl/E8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRii9kB4+h7LAEqDrB2v4EQ8oHnLxIplyHxSH0/m25ioLEHQCTG8dSkGRU/tH6phs7oNozetkySRWml0/vmirNs+0fFRyNopy/qJxZOjEyQ6dlfIOWRhFdP/xNKTvEutgtLpnLofRqU6XubGHvpvAAdLS4wpxxAhseyL4PrPNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbzNAY7c; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1273554466b.1;
        Wed, 23 Jul 2025 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753276127; x=1753880927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63bvutfPWfULysxs/Y7lfFZ/UW1E0YotNd+dud8Jgvw=;
        b=cbzNAY7cfrWYOmfAeN3uljifXjlfZFgO0gKDH5ayw+s1p5d2d1QtXvYdJdK/36nXl1
         zIdJ1frh18AnKQD9kbiX8CLu+EImOJ8ep06e/vs7HvG5KsZRCL2jkb1CXov4pSRvlEgN
         yf1JBUYnD2O6CG/kKFRmj9owdkAOXN5u3NHNZSRyGPEzPamPQCrqdWPnfVVpILfsP0nk
         utukMmvQcBpcvNXzOccWiQRHk29/uUYhbUuzzPFtrEHhEERJorS5icVgLyqjbwS3j42z
         F1mIETB52X0IUTpRcu+97VNmDnI+zixZy/BF78oYpLUomaiM+8p7CZQVPY5fT+lywXTt
         3HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753276127; x=1753880927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63bvutfPWfULysxs/Y7lfFZ/UW1E0YotNd+dud8Jgvw=;
        b=W86O6f8V3EYarMDUX1KHSTq497l4OEySRyqbHla/2ogJddTTVMUwWAvp1nGm72vQUw
         M8IBcUtc2O7CHgiE+aR1472zXiWdawm6WpPBFNHKYp1B3YIYpeG09CDf112XtYvK/JWg
         1aX5SwYtjuhFArl8Rvk5R/kSAPi9P/0kgKxfyXh6+sPMvPjaWFkZ4L4voiJqATWoyVgg
         RAvtRBdo8b86wZ+r+U/5sVbonDzWqAeB3u4DBol7OGgYPd1oReU6Qpue+rORgz95FCQs
         ResXpJCi+WXn9JE7qrgiR6FpzvCI/xmACWaqaOQYoHy2SxGs3HqJMcmMomwIu8CrwAlh
         5yGA==
X-Forwarded-Encrypted: i=1; AJvYcCUeWiWYCYUY7QBES1PasUSit3PBAeDbDCBY0VewGT2R1OHbc6SBqPMTEUWu9Hpb+u797qr/OrjU9Kw2PCDc@vger.kernel.org, AJvYcCVWxuAi5bKfcX6aio0QAXn3HtZpDDq5iux/fmj2xl/JEegmRfLHbOoWNBNtjXPQEcbYMyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZrU27yXwCP8sZQ2XYLjG3kLbeauegwNlaFUuIllsTZ3dLzI/
	8bFO2hydbg5rt0G861LY4CvOL2/c2ukWeXKu6pOF26LfqUbXT2zZaD2U
X-Gm-Gg: ASbGncvPdkGR7m0bUzH8SPOhv1kQOGNTy/d7f/7FSp2tZlxrKJ78q6/5iF/k2RyVAFx
	JK3c94dGbPkxtiYe+xgv/+E0zIHJA1q8q0fZtMGsXfVdZfiH8+scW4WUS0XMAo+NQ11E82JDRN9
	TrGX4Kvo/y4XqcBip/K+bYuApPHPNusDc6qunsgb0h40wiih0WGYFHaWh5+tExxTYmn8JNQb/DP
	ftA1parbY2DfM/7v94M0buoDcgtdQJxtpkMXHIjdQE1LFWzQQo3voVIHWT5qngdCE/F9ps7Gv78
	hJz13pe1StoEBq7U9x42DyJNeiL+O1fUnTFpTpzNuORxaCA67yRcCmRsPdGZLFrfRczLVxx+yQB
	fH+K20jlp
X-Google-Smtp-Source: AGHT+IHLWOHAMOHHN8FAga9AKPQXGXhOOXxYaMY0Wv9st5zkKMY4THWH5NR6RqITn0MxRf2fWTJh5Q==
X-Received: by 2002:a17:907:3d89:b0:ae0:dfa5:3520 with SMTP id a640c23a62f3a-af2f88579f4mr307934466b.31.1753276126835;
        Wed, 23 Jul 2025 06:08:46 -0700 (PDT)
Received: from krava ([173.38.220.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79c279sm1044081766b.28.2025.07.23.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:08:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 23 Jul 2025 15:08:44 +0200
To: aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>
Subject: Re: [PATCH v5] bpftool: Add CET-aware symbol matching for x86_64
 architectures
Message-ID: <aIDe3IR2SR6S0WM9@krava>
References: <20250723022043.20503-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723022043.20503-1-chenyuan_fl@163.com>

On Wed, Jul 23, 2025 at 10:20:43AM +0800, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> Adjust symbol matching logic to account for Control-flow Enforcement
> Technology (CET) on x86_64 systems. CET prefixes functions with
> a 4-byte 'endbr' instruction, shifting the actual hook entry point to
> symbol + 4.
> 
> Changed in PATCH v4:
> * Refactor repeated code into a function.
> * Add detection for the x86 architecture.
> 
> Changed int PATH v5:
> * Remove detection for the x86 architecture.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/link.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index a773e05d5ade..288bf9a032a5 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -282,6 +282,28 @@ get_addr_cookie_array(__u64 *addrs, __u64 *cookies, __u32 count)
>  	return data;
>  }
>  
> +static bool
> +symbol_matches_target(__u64 sym_addr, __u64 target_addr)
> +{
> +	if (sym_addr == target_addr)
> +		return true;
> +
> +#if defined(__x86_64__)
> +	/*
> +	 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
> +	 * function entry points have a 4-byte 'endbr' instruction prefix.
> +	 * This causes kprobe hooks to target the address *after* 'endbr'
> +	 * (symbol address + 4), preserving the CET instruction.
> +	 * Here we check if the symbol address matches the hook target address
> +	 * minus 4, indicating a CET-enabled function entry point.
> +	 */
> +	if (sym_addr == target_addr - 4)
> +		return true;
> +#endif

looks good.. perhaps it might be too much, but should we try to read
CONFIG_X86_KERNEL_IBT value and do the check based on that? there's
already some code reading options in probe_kernel_image_config

jirka

> +
> +	return false;
> +}
> +
>  static void
>  show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  {
> @@ -307,7 +329,7 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  		goto error;
>  
>  	for (i = 0; i < dd.sym_count; i++) {
> -		if (dd.sym_mapping[i].address != data[j].addr)
> +		if (!symbol_matches_target(dd.sym_mapping[i].address, data[j].addr))
>  			continue;
>  		jsonw_start_object(json_wtr);
>  		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
> @@ -744,7 +766,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  
>  	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
>  	for (i = 0; i < dd.sym_count; i++) {
> -		if (dd.sym_mapping[i].address != data[j].addr)
> +		if (!symbol_matches_target(dd.sym_mapping[i].address, data[j].addr))
>  			continue;
>  		printf("\n\t%016lx %-16llx %s",
>  		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
> -- 
> 2.25.1
> 
> 

