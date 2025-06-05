Return-Path: <bpf+bounces-59805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22042ACF94D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3351E3AD405
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 21:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99CF27F165;
	Thu,  5 Jun 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtlSw+hd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8A28E17;
	Thu,  5 Jun 2025 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749160440; cv=none; b=fyLlm99aUsgNQDM5CBpsro7B7pRRPMswNZi5o1PO1P6nRZjL7UMJ9Y+pAOMxSgqSbfqctfQew9wHJeFQcGFNFp9gDm2b2JjmqqGW4UfIlX0U0uy+aUguw23lVRqSxC2SCvNdn9HA5vHsxXEzQaUt7jMtI2KE0UIVaEZF5Lj5MXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749160440; c=relaxed/simple;
	bh=TtAnK+ifHJsVnnqMC5yqz588+gnYzlaQls4UgU5+eF8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKAaOfbTmiFI55rldgbR2bB1xCs6Wrb7tMjwDO7Dn8dm3VKOO4OrnRCG+rn9Siw4iDXIxaWivfaTPFosd3aZgMwFkOJN3Yb/f9mNtQu0SSQCTC/nAQYrCHSwFR9iQ1ks+ZY6eKrt4VYLHizaZHJ2IIV8bD7e1Q/VAipT0Vwyzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtlSw+hd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45024721cbdso12488215e9.2;
        Thu, 05 Jun 2025 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749160437; x=1749765237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQaPLGjmqdute3+CVxHV4+IFNfw1ZJTcI8Xx1uO8iBg=;
        b=BtlSw+hdfZSLQQnZyA2QtzjNlWjr4ruP2RDjnKIJvGzWjGPsxfGpyw17D0CbXUDO85
         +h2g7LEOxWB01E+6q5pSjG2Idp1QhGIJgbVhBlVHYoBu3N56I94kNgBKnzSAmxfXsDBz
         mVd07Eyl0mSp2/u6SZXgROdd2YA154qg/f1McJiSSg4esT8xmMq0NzAEL6pX61ZH2LA5
         MHoAkvPyYt6HT00IDcyl4IRxEP8JR1+WZpvCT65QgxWRv0uZ1sHr3yXSX1RmPh4cyIFZ
         uT/zbnju9s65FOb7JFnRyE47Yv00xZR622lwfH9hW6tWQ9LXaod0179DCzm1Jcsh71In
         LUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749160437; x=1749765237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQaPLGjmqdute3+CVxHV4+IFNfw1ZJTcI8Xx1uO8iBg=;
        b=tYZjRKONUy+GjY5rbjV8mKV2cj7mQy/AKFvNrxvV6aT3nGQh+v0gY/2NYTxC1OtDcx
         X+eD9qX67X7whr9DnUCk5bXcSqsSkVjenqLsh8ywyi6tvzkvvZ7Qh7qNP9l9ZnU8QPba
         Ed04G9iqJao+k/PkRRpz1CdekFBZDcTNJ/I0PDH0QAv+/pqVbWFAI6lnXt6JKgNZIKb1
         rv9zufcZZxJwHdci3xv/c5cvAtMgxg+RiupO3xrRihx8ytViwEp0ZYHA4vjzk2qKd7nq
         5O9HFiWVptWdkHvbuSYw746jJY61Ny2XCjaDSHIinPwILisvZ4XwxFyox1+DeH+L9EYY
         2Q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJTiWU0/ahXx46OYfb5jqLsqTqPAk2d77vp7os9h5CWk9r1Np1768vWnIIPTIj8/ispTw=@vger.kernel.org, AJvYcCXb3CtVFTIe0geANHij4xyDcq8BSbRrarV59+lM8ddtylUoZAS2wlBSvuFXBlpccFNQfok76gfgtIEEf1+B@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoOd7MvuWWyZx031R6S9GoDGYxp6ZAYkNdIJB8Vgvh1G4EGHu
	06/wOZ8iAa+iLocqbnt4DFZINOhQLw6gYNvOgw6HJqeyPbLgbjKkxEEe
X-Gm-Gg: ASbGncuZASHgFkW4/Mg8eyqrRsQfgiMcXWTsznPsQZV7HzjnXBoY3RwBMUfKpQtIujK
	4OYruPFrWwiEGBga4YEUAKxJi1SudczOh06zGmkrk9DpyCuM9l11ldu8AbzVzWRyHvtjBZPbcyI
	z1JXKDzw05u8KN5SCZ/lZzr/N9aeZ1erHafZXO+hosb7h3a8ThLzOXdK6h8u/VhkKElhfEuaWqN
	5pJCC8KofB4EI9c+/HEfbHMjcbuterywSKhAcAyLpGxIJPwzdZDJ5P5hWKDCOwUXVWvdIHeMq0H
	N4huKgeIGFw+HYAnX3gRj8Dtlc3NYIZPtGMc3ow4wWHA9eBp2Q==
X-Google-Smtp-Source: AGHT+IFGi6qPNQfhxX2FCHXVObAnqtUImxntP4+xBd3XDrJiL3C4i9nCu/klostaQ3/BqxMpiFx7oQ==
X-Received: by 2002:a05:6000:288c:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a53188d91emr797074f8f.5.1749160436720;
        Thu, 05 Jun 2025 14:53:56 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b3992sm278798f8f.35.2025.06.05.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 14:53:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Jun 2025 23:53:53 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add show_fdinfo for perf_event
Message-ID: <aEIR8SBXrV9PgQ0L@krava>
References: <20250604163723.3175258-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604163723.3175258-1-chen.dylane@linux.dev>

On Thu, Jun 05, 2025 at 12:37:22AM +0800, Tao Chen wrote:

SNIP

> +static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
> +					struct seq_file *seq)
> +{
> +	const char *name;
> +	int err;
> +	u32 prog_id, type;
> +	u64 offset, addr;
> +	unsigned long missed;
> +
> +	err = bpf_get_perf_event_info(event, &prog_id, &type, &name,
> +				      &offset, &addr, &missed);

hi,
addr now gets ref_ctr_offset:
  823153334042 bpf: Add support to retrieve ref_ctr_offset for uprobe perf link

so let's display that

thanks,
jirka



> +	if (err)
> +		return;
> +
> +	if (type == BPF_FD_TYPE_URETPROBE)
> +		type = BPF_PERF_EVENT_URETPROBE;
> +	else
> +		type = BPF_PERF_EVENT_UPROBE;
> +
> +	seq_printf(seq,
> +		   "name:\t%s\n"
> +		   "offset:\t%llu\n"
> +		   "event_type:\t%u\n"
> +		   "cookie:\t%llu\n",
> +		   name, offset, type, event->bpf_cookie);
> +
> +}
>  #endif
>  

SNIP

