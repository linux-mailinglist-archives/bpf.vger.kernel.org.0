Return-Path: <bpf+bounces-45704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B889DA720
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B671F165DC3
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7A1F9AA7;
	Wed, 27 Nov 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIiDiutT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6531917F1;
	Wed, 27 Nov 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708174; cv=none; b=ZF2wxtKS3rSHQ72qgpotuCWQ8kKsQCRIrKGsqIqxKbcbtc4XamK+8gKnSg0FTPkRn1CkUI8w4+9Fk3TgsWMCRcHdAuTrMjlOq9XOrJahc5ru4fR6cBbAYNDMO76RiZh+FuM3bAw0YvSgTgi7y13yZN9ZTrRucANUTebc9bhsWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708174; c=relaxed/simple;
	bh=8UByTi9O0eUrokO20BPe2tCop1WK6r2tySiCZSUd08U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSlgvDRqmPoeGbG9k6Fi4++oQsyy5QNUBVWMWY+jkVFtZtkpJyxD/mzh5QEJQlyrExeqeKxGpFwOZWyrBzWATZqirmHyq5T97Tpu0w8b3ozsF0+R99MNMGwYMXl+pivzUBlh55NXkF66pGvK+oxNq5HKfQo9qKRJ41nI17XMDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIiDiutT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso2087953e87.1;
        Wed, 27 Nov 2024 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732708170; x=1733312970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhM5k6V9GFL2Pc6HBmI3l+duYh7dw9XHt8yRGSBrdY0=;
        b=aIiDiutTLXOE+0R/17EfEOqFoHpBF73bdpTvN72zJRYelX1U9UO82ZJ8/BWpQciGq5
         xxKvFV6c6bKo2f+BNPJwaydoDJTLymwN+4FoM1fSNA9bJKI6/3y+zdXhX8yeyK8wdldv
         FjhX62muTxR4ZaPtHOYqeE07JNJKOqbwhyZb/WJL43CKUlG5ra6obwybhctCxZsspack
         z6WDGsyK4ycd7xsZGCHA6O1CeUDaq2fxIkssqAuJDIgKtZnnzqQl3CzWi9JjHiA65aAe
         mW1LPx9shlmEvK8sjS+lObtBOKMrGQmn0o4XXnswXkvMfbwGCb6KF2GrcE4h+T4oW242
         Iz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732708170; x=1733312970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhM5k6V9GFL2Pc6HBmI3l+duYh7dw9XHt8yRGSBrdY0=;
        b=IZqdANWq1Txzase1uN2WnSA4dIHYXIUXj1XwotegFHBRX9v/nbigIjf1/h+SqzQvft
         VIEGTtsG1LgqyIKIkX0Qi56f/o/abKmXdyECRnRVC/JOVP18q+nu+mEmiugnwxiASLim
         cr87mUdsKs1ivAnEVbEMCKZ2kp8jN/huoNj/qrLKXox4nOql9V7l2oC8SLFfl2inBO9x
         zc1+0cdthKLodMCycD26Y5ihm3S7v4xO/677t8I15EqI4mOEFgDfNMk1tYLKeqcJBLyt
         M2TY4PSFv7nNyy4Td9Jjzvpn7uKangVs2bPir6oeFtwPqF3E1Bl91f72bZDACNHM4ULu
         76RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/YnHTAjtwepWXeJFNNeha9b5yImVNlIDWr/QAS8HSJfY00in5F2vXGsOmVqtL55dVnhWGN8AkzfIbfhcelWE+Cpv3@vger.kernel.org, AJvYcCW7Ph63E1I+FZPQ5naqZps3vVevG/FWe7/bLPi8+9tctAhrvCq8ARGf50a/oZUHw++DLOpq9ot4XfE+jan+@vger.kernel.org, AJvYcCWXH2yzfSa57a1Dq9LvngDoC9q8SmJAhyqQB73RLeadomY7kB/KR5HAXjGIYPrhL+tQA5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQK3jJt7UL7jwnk3dc3VwSrLcorqZtreFR3oYhCbRoQfokPgQ
	ehRa0Z0Qw9Q7j5JcwaHarFFEaFi00PAh91RWyyOkKyolqulGsiLd1Wx3IQ==
X-Gm-Gg: ASbGncvFoJmWM20uuAN681TGZ9eTIhVq/iaXqMp8+DoVQnr2umhsefe4ur6joYoOmDt
	J4YyncuQo7P8Uj4RWphXIqchWLoSEsiGDvA1oEsEMcX1QJ0TibwDSn8v3HvlNZA7bWF/Iim+bLW
	O4ZTYT+v37EIj6hZUi/CyQf6LHzFYdn7XFi31PqAwakUT1RNm+MbKYtsqf0hQE4MQQ6n27lBLI9
	fznlcws/RYzFdt4MQQWifY6jxE3bWVq6ENT9M+9QVlz/7FTDmOx7QSPQHkPyRPM6gpV1GJy6QYg
	f5zjS904qXN8Whh44bidoPI=
X-Google-Smtp-Source: AGHT+IECGFrwM5m5TNZXo5pYG5pnOKYvkhiO8omVyK57Iv+f/4G4vSINdGNMG3b3likCc/8Jx83lcA==
X-Received: by 2002:a05:6512:124f:b0:53a:bb9:b54a with SMTP id 2adb3069b0e04-53df010e386mr1540541e87.48.1732708169914;
        Wed, 27 Nov 2024 03:49:29 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0fc1sm6105834a12.28.2024.11.27.03.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:49:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Nov 2024 12:49:27 +0100
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Refactor bpf_tracing_func_proto()
 and remove bpf_get_probe_write_proto()
Message-ID: <Z0cHRzM3NDwhLPTE@krava>
References: <20241127111020.1738105-1-elver@google.com>
 <20241127111020.1738105-2-elver@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127111020.1738105-2-elver@google.com>

On Wed, Nov 27, 2024 at 12:10:01PM +0100, Marco Elver wrote:
> With bpf_get_probe_write_proto() no longer printing a message, we can
> avoid it being a special case with its own permission check.
> 
> Refactor bpf_tracing_func_proto() similar to bpf_base_func_proto() to
> have a section conditional on bpf_token_capable(CAP_SYS_ADMIN), where
> the proto for bpf_probe_write_user() is returned. Finally, remove the
> unnecessary bpf_get_probe_write_proto().
> 
> This simplifies the code, and adding additional CAP_SYS_ADMIN-only
> helpers in future avoids duplicating the same CAP_SYS_ADMIN check.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * New patch.

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/trace/bpf_trace.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0ab56af2e298..d312b77993dc 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -357,14 +357,6 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
>  	.arg3_type	= ARG_CONST_SIZE,
>  };
>  
> -static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
> -{
> -	if (!capable(CAP_SYS_ADMIN))
> -		return NULL;
> -
> -	return &bpf_probe_write_user_proto;
> -}
> -
>  #define MAX_TRACE_PRINTK_VARARGS	3
>  #define BPF_TRACE_PRINTK_SIZE		1024
>  
> @@ -1417,6 +1409,12 @@ late_initcall(bpf_key_sig_kfuncs_init);
>  static const struct bpf_func_proto *
>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> +	const struct bpf_func_proto *func_proto;
> +
> +	func_proto = bpf_base_func_proto(func_id, prog);
> +	if (func_proto)
> +		return func_proto;
> +
>  	switch (func_id) {
>  	case BPF_FUNC_map_lookup_elem:
>  		return &bpf_map_lookup_elem_proto;
> @@ -1458,9 +1456,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_perf_event_read_proto;
>  	case BPF_FUNC_get_prandom_u32:
>  		return &bpf_get_prandom_u32_proto;
> -	case BPF_FUNC_probe_write_user:
> -		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
> -		       NULL : bpf_get_probe_write_proto();
>  	case BPF_FUNC_probe_read_user:
>  		return &bpf_probe_read_user_proto;
>  	case BPF_FUNC_probe_read_kernel:
> @@ -1539,7 +1534,18 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_trace_vprintk:
>  		return bpf_get_trace_vprintk_proto();
>  	default:
> -		return bpf_base_func_proto(func_id, prog);
> +		break;
> +	}
> +
> +	if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
> +		return NULL;
> +
> +	switch (func_id) {
> +	case BPF_FUNC_probe_write_user:
> +		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
> +		       NULL : &bpf_probe_write_user_proto;
> +	default:
> +		return NULL;
>  	}
>  }
>  
> -- 
> 2.47.0.338.g60cca15819-goog
> 

