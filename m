Return-Path: <bpf+bounces-45052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872EC9D0628
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 22:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F61B219CB
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C41DDA0F;
	Sun, 17 Nov 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="EUc0xoFd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD071DDA30
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878495; cv=none; b=EEdy4tSTjEcx/k0XteXqw9o7GE59mbXLmo9Q7rtvcIkh85WcfVtJiGtrNpAXKD9U+J6IxiQdSyk8ujIUceF+q6cjKHWH9oYZLxD5ZofhWTM+dTIYW/Kcc6GIrUasalbMK11aVASxfzZmk+pIfcnOCJWLRlM+WMQVFY26N/doxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878495; c=relaxed/simple;
	bh=Kk0ehcahFJc+mJIo8h+wjIC7rB+ZTQ0xag6GiXr/5js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6MrB/6UI/leSNeK86Y3mZhGCSBj+VCjLR6MKaZbRdjkF+tsgZ1J/rhsetnghz2FX/rnXnpwrMyNruIWMsGeskBaYczwwYtavK3Eyc8yDU7gqePEOZz705sJ0gl3cSj86x/Ldv3XixrJO5NlEp86mXc1yKj7/KkxaMfMzoAuH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=EUc0xoFd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so2022230a12.0
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1731878492; x=1732483292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+WA6zYLqnUjQ947xocV1ZUiDTAVxqMfxx3/8iKYRNQ=;
        b=EUc0xoFdwrzU7JoSJfHFVO1q4NI6Hmhw28kJYChMULwc+ZrskdpYPgvu0lSt6f1bFv
         OY9d8LPmbZdl45R3bc6IqdaXn9mNJPwKuVadXVG1SSX9ULzxV42YW6ugilZpx6PNtr8l
         6A3nU0F3c1ZdphrowjTRiTAABqG/2iQtnT0x7taB3s6FsYsyBTZUobctMu3WGU/ZQOKX
         yroOGfu7psk9TV+t5RL0okRruIh+bSIW7/hVazveonrh8lyVYEdyk2Q/xsbpXdIg7Vap
         bn7vBv1IZL7qtvH5pROZfCp+Vjljs13IracFh0fNpkziZDuDfn/06Z5U0dOvrysBvWt+
         029w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731878492; x=1732483292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+WA6zYLqnUjQ947xocV1ZUiDTAVxqMfxx3/8iKYRNQ=;
        b=NZEJu+WBIa+IDZ3wdqKQ4KH+dw0E4CgRig9jJFGS61EvL11JTxU6C9wMwTQdi93HdX
         hIzdtFoMEbKhivs1Ce+bB/GTCIpHD3RZ1w5jyDK5Vqw4LcJFi7AxSNR/ds8Tmi3i0Lmv
         fpr/3rj0rM7jzJ2TFBgNKPdhny6VrMn1hWqxy6p1g+U53Hkrehg47giY1Gwt5au+j2Ix
         zN/FWrIPb98ue5jDxl+BG6OPooXqaXdAwFCwEf8FavMdJnFHpC+4iAXyfGp0a27882so
         1mr08muM4lGkavXfmtlfPYxqhLHFKu7rslhZdcsqNcy4Bju//MiPhBX2R90+uwbpPknO
         0nxw==
X-Gm-Message-State: AOJu0Yy60Ofj10egnYSTZ8mzfsOCrrO2vKXdOwuYjU6L4CPGmEax0aJS
	p/rLnBotMpj9n4jqZR0Jfh3jDZDs/u5GYuBxPojbSfsk7/7XhSGE6egd7oSgg18=
X-Google-Smtp-Source: AGHT+IETgwl/mzXIyfncq9JBE6Ep4zK/CQo7DcPwVaX4WbiBpzHlbVMFuKOpl/7jUfyQi8aPIXpung==
X-Received: by 2002:aa7:cf97:0:b0:5cf:c303:c59b with SMTP id 4fb4d7f45d1cf-5cfc303c7c9mr1460305a12.28.1731878492303;
        Sun, 17 Nov 2024 13:21:32 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfbba90daesm1026214a12.74.2024.11.17.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:21:31 -0800 (PST)
Date: Sun, 17 Nov 2024 21:24:30 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/5] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <ZzpfDvL8CeiZCztK@eis>
References: <20241115004607.3144806-1-aspsk@isovalent.com>
 <20241115004607.3144806-4-aspsk@isovalent.com>
 <a21258aa3de7f478ff7144d0d453adc610f3797b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21258aa3de7f478ff7144d0d453adc610f3797b.camel@gmail.com>

On 24/11/15 07:06PM, Eduard Zingerman wrote:
> On Fri, 2024-11-15 at 00:46 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > @@ -22537,6 +22543,76 @@ struct btf *bpf_get_btf_vmlinux(void)
> >  	return btf_vmlinux;
> >  }
> >  
> > +/*
> > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.  In
> > + * this case expect that every file descriptor in the array is either a map or
> > + * a BTF, or a hole (0). Everything else is considered to be trash.
> > + */
> > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > +{
> > +	struct bpf_map *map;
> > +	CLASS(fd, f)(fd);
> > +	int ret;
> > +
> > +	map = __bpf_map_get(f);
> > +	if (IS_ERR(map)) {
> > +		if (!IS_ERR(__btf_get_by_fd(f)))
> > +			return 0;
> > +
> > +		/* allow holes */
> > +		if (!fd)
> > +			return 0;
> > +
> > +		verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > +		return PTR_ERR(map);
> > +	}
> > +
> > +	ret = add_used_map(env, map);
> > +	if (ret < 0)
> > +		return ret;
> > +	return 0;
> > +}
> 
> Nit: keeping this function "flat" would allow easier extension, if necessary.
>      E.g.:
> 
>     static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
>     {
>     	struct bpf_map *map;
>     	CLASS(fd, f)(fd);
>     	int ret;
> 
>     	/* allow holes */
>     	if (!fd) {
>     		return 0;
>     	}
>     	map = __bpf_map_get(f);
>     	if (!IS_ERR(map)) {
>     		ret = add_used_map(env, map);
>     		return ret < 0 ? ret : 0;
>     	}
>     	if (!IS_ERR(__btf_get_by_fd(f))) {
>     		return 0;
>     	}
>     	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
>     	return -EINVAL;
>     }

Thanks, this makes sense, I will change it to a flat version in v2.

> [...]

