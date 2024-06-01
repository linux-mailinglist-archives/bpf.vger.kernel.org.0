Return-Path: <bpf+bounces-31095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC48D7077
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 16:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8761C212D2
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5729D15250C;
	Sat,  1 Jun 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVTLHHGN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD57187569;
	Sat,  1 Jun 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717253116; cv=none; b=rekAgOd6cscoB4BQ6Ngh+SinZdYrOYUfmBwuGbsymiUuUc0G3/qgJzgn5jB0xhzPvdvi1Q9LQL4226w4HDDjnXDP2QTyfJsJiGFczEIbuH1+nxvsMuzbZ4f7ujzYeMxGcyUW+X+uRjOT/9fpgZsKgUbr45W6Y0DSrkWlG4KIsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717253116; c=relaxed/simple;
	bh=emp5z/uF5BiqP/IJHpyMR8XWVHdbgEX2O7qtRn16QTM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWTRd57JZvKxouosdlJWpyIwyjWapWz72dNpleK0G2OXcKgPbTMSiyeO81KrTWByENGuBL4RWo0zRiixWWd109qZCPZLnUoZYs9ppEOZIow/iJ6V/XEQCye0TarIMr2QCg8BLyasfoqk9JSkVeVWaFq2DNS84SKV+9zY/uyilrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVTLHHGN; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b92e73e2fso502585e87.2;
        Sat, 01 Jun 2024 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717253113; x=1717857913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1DIBX0+WK7EodjH2ldEnpV6XI1bwn41T/4K0vTK+fQ=;
        b=XVTLHHGNrGHMCp/zwiBr7vLsn00EO6UavrduEnqd5bOfmPy7JXIH+/9Q9lSfY+Nk25
         cVKtupILXMz4/HCsk3zFZMj7OsJL6eo+HZOHCvcHL8zs8I6xQpRGm1DG9nHZz55JYiH0
         tf41+GG7HwvDXhjZSr6k77g7MnjXBn7FlnGNnEt6UFpbqS/sM2FR+nle+s9z5L7tsTyR
         zat9VErolEZTYeWmUCOMYHIuj3yL4LQ7bcNPwHDlMNDAScJtwXrorsKWdC9/QvR9hlMt
         IWMGKGZ0qicOn1bS9OOLd6V7J6KJLm5TRo+Kx/tvoIJehMyweb/vCdMprktsuL/C4p1w
         /qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717253113; x=1717857913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1DIBX0+WK7EodjH2ldEnpV6XI1bwn41T/4K0vTK+fQ=;
        b=d518qmK+enJT6jnxnsU2PXjitWkXvJa3R+opXNGx47KdU3urU8P/wAIfJ9YKDd5zj7
         DfN2CjaWRZk8xaVng7pMvgNzESl3GZNWFyiuuX10Vp6U4jXfCasNV3is1lpOSlFddxYm
         RsOM7T1isyr2uVCIeGe0xOu0gttmlrS0mBLbjzS5Zl5CnOQiDGIFOcifn/Io9or8p5os
         fEGAEQ5vgByN+2SnhG7tx62ii+l0i/6ejLTG+05lwNKFPB5FDNr2aQtL7kZ51peKKCi/
         KtY5sIszXyq8t7mfHkTawdvYqxHi9ZgKrfR0DwHDw7EEa/+nBrM7HnB9C1TpvZruNpK1
         u9ng==
X-Forwarded-Encrypted: i=1; AJvYcCXHoKPIkfo4ZB8Pwp9R+eXA4Spi8w/Ib7GUQsfHy5miSAlkxqQ80Z7sHo2pHAa0HmKhGWOsjmBqs9jzApw72AMFt+wgUiIf7fMx8Y2Xrbza2Aqn5pQy/QVxLjpTNeIzvw4p
X-Gm-Message-State: AOJu0YxMfDz1uI+mhu0kBpekk2MOYf4v8jx8nvuGbgqTSHGStYaPogWw
	f3roXqVvtbfoIs/zdYEgooPHbB4zMJ3f53LWJJ0D/MkKqrPEKNBv
X-Google-Smtp-Source: AGHT+IHSi6cFEuaUTRWCJ/+T7XxnAmTFKzV5cuNLzAW7JkzxGdKZuGz2HW/ofd2uZmc9JEzhiz/sdg==
X-Received: by 2002:a05:6512:521:b0:52b:853e:4d44 with SMTP id 2adb3069b0e04-52b895892cfmr2875628e87.35.1717253112948;
        Sat, 01 Jun 2024 07:45:12 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d330sm2279589a12.67.2024.06.01.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 07:45:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 1 Jun 2024 16:45:10 +0200
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: plug a warn about bpf_session_cookie without
 CONFIG_FPROBE
Message-ID: <Zlsz9pTiT2Ad04i6@krava>
References: <20240601133224.674784-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601133224.674784-1-mjguzik@gmail.com>

On Sat, Jun 01, 2024 at 03:32:23PM +0200, Mateusz Guzik wrote:
> Building a kernel without said option results in:
> WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> 
> This is a bare-minimum patch to sort it out.
> 
> There are other uses of the bpf_session_cookie thing spread out
> thorought the file, they don't seem to break anything though.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> I don't care how this gets addressed, I just want the warning gone.
> So I am not going to fight any ideas how to do it, as long as it gets
> done.

it's fixed by:
  https://lore.kernel.org/bpf/20240531194500.2967187-1-jolsa@kernel.org/

thanks,
jirka

> 
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 48f3a9acdef3..b081bdd6f477 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11128,7 +11128,9 @@ BTF_ID(func, bpf_iter_css_task_new)
>  #else
>  BTF_ID_UNUSED
>  #endif
> +#ifdef CONFIG_FPROBES
>  BTF_ID(func, bpf_session_cookie)
> +#endif
>  
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> -- 
> 2.39.2
> 
> 

