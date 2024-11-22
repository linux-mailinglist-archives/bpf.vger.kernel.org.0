Return-Path: <bpf+bounces-45473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27CF9D621D
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 17:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C90160E42
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5751DFE12;
	Fri, 22 Nov 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1uSW2Ml"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D81DFE06
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292442; cv=none; b=PklFV0xRR1KkHyMlT94XZexYOts+dF2nC5+iMYB/0VNr3pCP6HzK483cF7nG4MSgGMoLr4sgni/0bC8vTVo7XOJQPHdALyptWhYUrvopUpX4j6qr3I4HjQtWMVi3PAPi6rPR4gkLkWk01aeAU6VsZvA/yt8tlAi2N3VUMlaOW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292442; c=relaxed/simple;
	bh=wbzJg7Rh0/IJD93w2qv9ayIORHCQa+JXkVfav46PNLg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMRfICKYrzn5i2fsPF5zKqOtM4hLIyxBUKyiRqpToMPu2OxuVIN9CtIcgMvlpDpsSM3dx7+ak2dn01+e1GhxdAPkjyjaycWpNDXe/1U6ch6XkiN6tIgoRt77Bu9A7Za1p6vDRx33cXOp++wJ8g1UeYhK0bXdoSg9BSoMscYi8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1uSW2Ml; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso337950966b.1
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732292438; x=1732897238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3dwNOyYmk12DopNVn2ZcrR1xTULhE8ZG0b8p3Tx9hLw=;
        b=L1uSW2Mlvt+Dwt5d3LWaCqgxfCit3lO2ob/BsVYxbLK9+ZrhOaskVb7kQh/ZBlweV/
         aSh7+rLalrcqij5znUn0T5P0rIFaM4HHhJJV5ASZRNkxGQfBZVaNGJhxhLjjq1ClO1rA
         ZeVsKAUqcoc+lQWDtOqiuqyalOOLsH19d36Xpt2wdxwly7UH8D69bugrdfvuiOY/a07a
         7hZHsIjN/Gg5XhBFa0eIvbrcPu4GVnFv2usp5eQ9c2nbJ/t2K8fjQrNM/bpy8Cw93JGR
         9PVgRQRRs1mzs1iGTp5XiPMdOWbhRxyIDXj1DrJESeeaX0rG1syJdhjmpKhuWi2MZKhP
         U0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292438; x=1732897238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dwNOyYmk12DopNVn2ZcrR1xTULhE8ZG0b8p3Tx9hLw=;
        b=FpTPjl5MKeFvRc7oIqXmSxzUj0d6qHfdNGVVE6IksiBod4ZV1Qej85mZi3CvVbsohN
         +UZaBVC16KAKF010IrLAgtguJGkkgSs9j2IXrFWrOZBU8drGyN+3TIf1Zmj1TEIH+J5/
         Zjzjpk1UjXdih3+uc3V8+8fD6T1UPc3hHPWXADVoVjULto/+hr0TO3wxbuPn7TlM/s3X
         EsoH6y3dsYXvJgSKZPGNkK5NcUqm+OBTr0KqxAf4bNFThur1f93+FqDfH8uAQubtNREz
         jVue5e0ZhL+rGJ26IEVMT16kV5dmLgk9xKQ8XBCOMUfC7/+y4WYX2QziF3d4yPgEcLnQ
         FzNQ==
X-Gm-Message-State: AOJu0YyXmji3fw7mXx26C81JjRQcRS4mOHsPp8r09rDktPvyEeg7a8c7
	h14gT9dYQpOQmtV1IbrbyHO0hL3OXTinfd/+N9Mjkk11duA5qKtk
X-Gm-Gg: ASbGncttyGzJ7Kh5kPS/OgEp8siAOMu+63jm+k6KRyDqTlm9Rb7bMjAd8Dh/IxwxLgW
	+3Mxf6qOILwj3igKJRi+x2DeS301JpXzjTHLHxqeJAIJX/jjWZAoW/dJ8dZDLhx3GU6wBRpA8i4
	qNjxgZ1b/B/9eWgVo7L2gGsVfAEMsFynmnPk/dYsjsRky76QXoC1gLHIbX/S6yEKex5jPtjaqzl
	8VDAgeeQsiAEohwbD27uZ38Rk2KX/RTed8DAdfkNAW4YaziBh4CMq4drKsYWyWrlxhfxI2n
X-Google-Smtp-Source: AGHT+IEUl+DE92Rw6d+0Gq3IkP2D0aXdQ0krI9rjQGtooA895zp+kIvHGxvy3w8gIDqi/jkSh8ek4A==
X-Received: by 2002:a17:907:7751:b0:a8d:6648:813f with SMTP id a640c23a62f3a-aa5099065afmr299549166b.3.1732292438278;
        Fri, 22 Nov 2024 08:20:38 -0800 (PST)
Received: from krava (static-84-42-143-70.bb.vodafone.cz. [84.42.143.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f9e25sm117017666b.78.2024.11.22.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:20:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Nov 2024 17:20:36 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] libbpf: don't adjust USDT semaphore address if
 .stapsdt.base addr is missing
Message-ID: <Z0CvVOjlaknq-vZ5@krava>
References: <20241121224558.796110-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121224558.796110-1-andrii@kernel.org>

On Thu, Nov 21, 2024 at 02:45:58PM -0800, Andrii Nakryiko wrote:
> USDT ELF note optionally can record an offset of .stapsdt.base, which is
> used to make adjustments to USDT target attach address. Currently,
> libbpf will do this address adjustment unconditionally if it finds
> .stapsdt.base ELF section in target binary. But there is a corner case
> where .stapsdt.base ELF section is present, but specific USDT note
> doesn't reference it. In such case, libbpf will basically just add base
> address and end up with absolutely incorrect USDT target address.
> 
> This adjustment has to be done only if both .stapsdt.sema section is
> present and USDT note is recording a reference to it.
> 
> Fixes: 74cc6311cec9 ("libbpf: Add USDT notes parsing and resolution logic")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

nice, lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/lib/bpf/usdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 5f085736c6c4..4e4a52742b01 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -661,7 +661,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
>  		 *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
>  		 */
>  		usdt_abs_ip = note.loc_addr;
> -		if (base_addr)
> +		if (base_addr && note.base_addr)
>  			usdt_abs_ip += base_addr - note.base_addr;
>  
>  		/* When attaching uprobes (which is what USDTs basically are)
> -- 
> 2.43.5
> 
> 

