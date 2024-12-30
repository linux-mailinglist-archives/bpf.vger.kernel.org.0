Return-Path: <bpf+bounces-47695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6B9FE8FC
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0114D1882EA8
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B801A3BD8;
	Mon, 30 Dec 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXWrfF3Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89632B9B9;
	Mon, 30 Dec 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735575383; cv=none; b=Sbk+eEVHb9ZwX9491J7TRruuEQMiznrLlz7AuKk0W4e42BRpPcGgNvgRTO0QJe0G7SDv2f9zCLKjfItIJfSRpmoyVdVKMQSiCIuZZ4c60lUSjuU0GXgRdj+kWkc6LLID2H2QDWiSyQBsZUpIN4myzqKaLOSjaozubwQorPDG1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735575383; c=relaxed/simple;
	bh=klXLUdOPJkX9l7AyOXJptO2ZHbzloKcws47obpJ9eoQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5yvgYukVidHRkg8NX6JNfpivp7B6x80wIWDZgg2G/Bc92AiIrgA0s4zrwjRseuUSp2FQ/ierP5Mhjff4RsTPKJSktbBZ70fKfDgLszDneVxeFcfbEKwTjP2V9OyBJBBc3PvfPRVB/NJpHRyEOP85N5Z3ePv2Rp57Tqi4gBvajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXWrfF3Q; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so18929686a12.0;
        Mon, 30 Dec 2024 08:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735575380; x=1736180180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYTksivbBuRUZqYFhB2BFs8aYcBszDie4Sum0s5YpXM=;
        b=TXWrfF3Qr+arPjKqZncNSK6XxLwR+12Z8iq2Nh2hb219qzNUem2p3SdPdf7jwcksfv
         vN4BCCypMNI8ITcwXuUaiNqKG9F919sQ6cTEybzoYoRzgvUjUlVEtTbNchCLSm7xwEvy
         YOM5FJFfrfHw+z1Lj5i0vDtsGD+OfIQK6VV49BKrbSByPJLeGcVK05srGfRdUaGC7Cjf
         zuUci5RSyEJHxIaLrwdlQcyllLIpHw0Z8a/yUxkjMzE6dGpJrbFWqe9PGa35RlzHCaU5
         0EJfE5oZXpPpyfviWQIqv4OcGukvEYcBilJRKMzS2WMK72b2O86lTdUQoNHbbUk9Kit4
         11kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735575380; x=1736180180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYTksivbBuRUZqYFhB2BFs8aYcBszDie4Sum0s5YpXM=;
        b=hUfVrvOO39Wx1sug13k7xq2rW0AzhGD7so4rYfXcID7yC7XmQxyVef7fH4zWr2SZTz
         NWTQPpo+NufTuWID90IAy7aAudCUnrYg4Ir66jRxG7a1ZcWkSlkKipKNkOumKVBN7Ujm
         fox0PLz4g0nJdIfEjrgxxLtnyt8eOfh3pfxoc5c5+4wznqtDREIIDlPrbRLnLqeBvViC
         Viktut+Se/uQTft9/hz4QyDtGvKHqC4xpxCJEWJmp0e/B4t96Nti5Slz9P27yvLuJy3Z
         akRQPUi8EuqAi9Hlesf6TjDWOwdQ7N6KL5BIB4AI0R5b05qJdFTUwscCbkWGgAq3A/ex
         6Jdw==
X-Forwarded-Encrypted: i=1; AJvYcCVQpU+rpooJO/y+3vu5yWUSb/EY+9lGEFtTvAOX8pRW/epy5CpRaVRJ2cmrVkf8xtD8XhI=@vger.kernel.org, AJvYcCWfmL4gLv7PY/rJqeliakX6Rr75J8Zl0B9iLT4w/iWvvgXRsFhW/r+Nhe4UkbRSfoo5EYSmFHRsbti5CuSJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzvlXb2kld21G7+lBLVSHTGiRLPnM1axbZifsZt3ZCuRzvmfBSg
	kI1+0sG0V7IqS94KUSuXDWsR79YTsxt2YNBVVyVCNu+Gk49hOzb9
X-Gm-Gg: ASbGnctXWBgkMCYQR19djtHmauR2VMAPEnpOzLsVKeqRlM7IMe99g1i1iH//pt+WpQI
	S6LXTK1evo4NFj4steE7L+fmo65CQQ6BugPf+C9BnoDVWt1TwJO816wFS0GR1ipy1cnPUBT/eiB
	5JfChNzJWaamz9fClRIQDng9ZSRIbUUKcDFC9KtqC4JLfv1Y6g21illYxMxr0beRmvJna2swMej
	2guZ/WJZSDV0j2EfnkB8cg5CfQmqYLEOp/IggQd4Ds=
X-Google-Smtp-Source: AGHT+IFOtkwvjzvmFkYzhEZC9db7bLRIIorb3kv+7TaSx8Y/Gh8hfWvBOe/R8XSl66U1uAhRmFclgg==
X-Received: by 2002:a17:907:3f19:b0:aa6:75f4:20df with SMTP id a640c23a62f3a-aac08126683mr3329350966b.9.1735575379761;
        Mon, 30 Dec 2024 08:16:19 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e830ae6sm1486108366b.22.2024.12.30.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 08:16:19 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Dec 2024 17:16:17 +0100
To: Daniel Xu <dxu@dxuuu.xyz>, Andrei Enache <andreien@proton.me>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Set MFD_NOEXEC_SEAL when creating memfd
Message-ID: <Z3LHUWH8YyKGgNX7@krava>
References: <6bf30e1a22d867af9145aa5e94c3fd9281a1c98d.1735508627.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf30e1a22d867af9145aa5e94c3fd9281a1c98d.1735508627.git.dxu@dxuuu.xyz>

On Sun, Dec 29, 2024 at 02:44:33PM -0700, Daniel Xu wrote:
> Since 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC"), the
> kernel has started printing a warning if neither MFD_NOEXEC_SEAL nor
> MFD_EXEC is set in memfd_create().
> 
> To avoid this warning (and also be more secure), set MFD_NOEXEC_SEAL by
> default. But since libbpf can be running on potentially very old
> kernels, leave a fallback for kernels without MFD_NOEXEC_SEAL support.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

there's similar change posted by Andrei already:
  https://lore.kernel.org/bpf/eTid-pMaxx4d_gMkyFN6fgVGub01RRJYIl1SzTmRG7RtRlPUJOMrVfe2I1W8s0OBHBFy3UN2WGm_e6mak0nGcrZ4ZdxAYRUSDDcUSVMvNA4=@proton.me/T/#u

jirka

> ---
>  tools/lib/bpf/libbpf.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..46492cc0927d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1731,12 +1731,24 @@ static int sys_memfd_create(const char *name, unsigned flags)
>  #ifndef MFD_CLOEXEC
>  #define MFD_CLOEXEC 0x0001U
>  #endif
> +#ifndef MFD_NOEXEC_SEAL
> +#define MFD_NOEXEC_SEAL 0x0008U
> +#endif
>  
>  static int create_placeholder_fd(void)
>  {
> +	unsigned int flags = MFD_CLOEXEC | MFD_NOEXEC_SEAL;
> +	const char *name = "libbpf-placeholder-fd";
>  	int fd;
>  
> -	fd = ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
> +	fd = ensure_good_fd(sys_memfd_create(name, flags));
> +	if (fd >= 0)
> +		return fd;
> +	else if (errno != EINVAL)
> +		return -errno;
> +
> +	/* Possibly running on kernel without MFD_NOEXEC_SEAL */
> +	fd = ensure_good_fd(sys_memfd_create(name, flags & ~MFD_NOEXEC_SEAL));
>  	if (fd < 0)
>  		return -errno;
>  	return fd;
> -- 
> 2.47.1
> 

