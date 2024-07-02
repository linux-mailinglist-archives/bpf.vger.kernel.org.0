Return-Path: <bpf+bounces-33650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8974924380
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFB92878F2
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAEA1BD4E0;
	Tue,  2 Jul 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHtS5W+x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37521BC06B
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937680; cv=none; b=N3y8LnZiqCuKnTsv9mNgZ1E1gxgkentGIzRk27Jar+BFKqbWwuyevDMSvTOifzFO7R+uhhW4J3eGJt8ZXMNV3Zao2Eb6fOhth3HOR2dBdPnnwKVFn8YOITAHIvs5XFDK6I3mr7Ixe9ue5peNBK2mcNjNwdsddaerwmKJHgo6fLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937680; c=relaxed/simple;
	bh=eiXA8kGLcVEwkoAzXFZsmt9XRkiJMRmbI/f8dLlnMFc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkgAeqBFc2do840TIS3ssRs88KI1c/t+mv9bEClC3FPgumPnGEfhIaEkE5VT2bRb45QnEFVI7LuDGHvmjdi5h+uJ846CHZ/LLlb19tBHt7FsH37nbFZ29iiECyPbXeX4Ddf6byRlFYRik3P1oyb6nSwGwkeynMniddzsvSWrcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHtS5W+x; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367601ca463so2553445f8f.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719937677; x=1720542477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXxTGTD9skOKE+fdvPG7VeShgSc5xfSSAZFFBR+qHDg=;
        b=HHtS5W+xb32biIdzCi7+PQZZ+C1WgElP1cK0K68Hzt4JE3xdwFN5zSYfxth1uZjQSH
         WOc4YVlf3dPsGE2Rqbl5zKf/xuJDjlR2F/6uKfq8vy0DekTI86iYUA25fx2TOA/o8iJ5
         TXI09x5hbD9j9UbjG7p6PuJooNkR9C4UrP26TLU3uDwL4MiwvNClk4FgnKxUlRXnreb2
         nZuBXU8LjTno+QgGyUxCmPzmhbbtV0ZxWQCt6WaqOK/c129wHxWOvBtgUW5gLXnNOOfI
         05cQJkGDfeKHzYq7ra32B7BBAYdmmkY8YzL6ZRtO9W7HGunKziH6ntaAnKDJmrWzKZG4
         2jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719937677; x=1720542477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXxTGTD9skOKE+fdvPG7VeShgSc5xfSSAZFFBR+qHDg=;
        b=AmbTHLNlZQlzowBO7GwHKwT3taJsOoUUjJxl2gDSO6o8UBd17BOSkpzhs2IjNLhZQf
         RnAsG8ppGHAtbVV5CuMtSwVv5ml9zdWvMrSEOkzF8Hctg656Hbx/1vJx3XXMLjrHvKNY
         k819HT21p4jkux27i/F6a5KXL++LguU6sCu8tPP43UT3oNmeDncuS2igmlTNmJPbxrlE
         eRChvnxIh00rbUwRxqvrHD4v1yGy3yfQY3aqch16rjif6GAkj1F++XnpmZc4F4YFM3oe
         qAZWl1J5WwZ72KGfPYAsUWJfBCXkKU0J61mmQescZCjpES5IBxXWJ9+deqbn+tYZs0Xc
         fIjA==
X-Gm-Message-State: AOJu0YyRr+9zlGP4ix46TM37m2D3Z2ecED+mJOOlFm1KOdi8RUWorXS6
	GU2Rslmp7HKt+YADIX1FUCT2jv4StA7jkFg25/J2LLa5gPxR7FXB
X-Google-Smtp-Source: AGHT+IEWt5RqkcYak4rutvVYlcSTRIsNOM239XC7244yXmgtbnCMcfK8VUyonTP2BYHbdOYqpBLTew==
X-Received: by 2002:adf:f5d0:0:b0:360:82d6:5e96 with SMTP id ffacd0b85a97d-367756997bbmr6179022f8f.3.1719937677150;
        Tue, 02 Jul 2024 09:27:57 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103371sm13730941f8f.101.2024.07.02.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:27:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jul 2024 18:27:31 +0200
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 3/3] bpf: Implement bpf_check_basics_ok() as
 a macro.
Message-ID: <ZoQqc_dNjxF1-AR-@krava>
References: <20240702142542.179753-1-bigeasy@linutronix.de>
 <20240702142542.179753-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702142542.179753-4-bigeasy@linutronix.de>

On Tue, Jul 02, 2024 at 04:21:43PM +0200, Sebastian Andrzej Siewior wrote:
> sparse complains about the argument type for filter that is passed to
> bpf_check_basics_ok(). There are two users of the function where the
> variable is with __user attribute one without. The pointer is only
> checked against NULL so there is no access to the content and so no need
> for any user-wrapper.
> 
> Adding the __user to the declaration doesn't solve anything because
> there is one kernel user so it will be wrong again.
> Splitting the function in two seems an overkill because the function is
> small and simple.

could we just retype the __user argument? like

  bpf_check_basics_ok((const struct sock_filter *) fprog->filter, ...)


> 
> Make a macro based on the function which does not trigger a sparse
> warning. The change to a macro and "unsigned int" -> "u16" for `flen'
> alters gcc's code generation a bit.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/filter.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3f14c8019f26d..5747533ed5491 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1035,16 +1035,20 @@ static bool chk_code_allowed(u16 code_to_probe)
>  	return codes[code_to_probe];
>  }
>  
> -static bool bpf_check_basics_ok(const struct sock_filter *filter,
> -				unsigned int flen)
> -{
> -	if (filter == NULL)
> -		return false;
> -	if (flen == 0 || flen > BPF_MAXINSNS)
> -		return false;
> -
> -	return true;
> -}
> + /* macro instead of a function to avoid woring about _filter which might be a
> +  * user or kernel pointer. It does not matter for the NULL check.
> +  */
> +#define bpf_check_basics_ok(fprog_filter, fprog_flen)	\
> +({							\
> +	bool __ret = true;				\
> +	u16 __flen = fprog_flen;			\

why not use fprog_flen directly? I'm not sure I get the changelog
explanation 

thanks,
jirka


> +							\
> +	if (!(fprog_filter))				\
> +		__ret = false;				\
> +	else if (__flen == 0 || __flen > BPF_MAXINSNS)	\
> +		__ret = false;				\
> +	__ret;						\
> +})
>  
>  /**
>   *	bpf_check_classic - verify socket filter code
> -- 
> 2.45.2
> 

