Return-Path: <bpf+bounces-47699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1539FE990
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2683E7A16D5
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FFD1ACEDF;
	Mon, 30 Dec 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImClPUJ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00114EDE
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735581768; cv=none; b=PhQWwvWkHM3AJP2J2F5zB8dn9VRuDI9q8+RAG0iYJpSnadvg5VwNilZmZDdihfqylRV+/Nqy0TE043d19iihxFsg18rLdFd6OTOfVjQbZ7to3zSKLsCcTnIWn5Y10v0pjsapE5FARz7PxbEV0KDB2UjyL6rk7+xlb12zPjhMuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735581768; c=relaxed/simple;
	bh=MYVNnzB7iJQBXMrjk+/33YLZPav+FOMgB9kqsFqi/u8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdUUhfFWCVju/EC/3K3PglEH07gtkXQqzoAXS6E/hxBRZpPPpHKyjefBIkKtiYgKtCbCeKTqIA0C2AUUrRk5TM16ta7SzI0vtxpgSkrx1rDzK9nPcJGSibO3wqjS69mKdfj3zsDwhWnGbhomr3YCtIlBXRIHc6Kx5dw8Uc8Qy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImClPUJ2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436ae3e14b4so5151275e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735581765; x=1736186565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16iMQTA3yLJ1QlfHU0z1vMcVYOqrhRkI7zvdXHZSoHA=;
        b=ImClPUJ2JLuKgXM+r0oZiSyixgz00u9jioDDYKtVErjD18LLSxU9IrDKZpPh79FnlM
         5B8hnBVUQg45//AkfX1OHmViogvQCvXyw4VRJlo2qB0DOiOyHlX/ecZ8m4FVN3jLEYux
         cOGAss/N8lvIFJFxI70qv1jt6fLL8S3Hy6OgciA28E/VjhaaVoYMjE+3yiniFrYjnNik
         89zpKxtT7Ml86PDEHlpoL1pZEAi9brOLrwJqb8YHtPRyPYZcS7jXDIOqe/i5VjWLCwbO
         sVnLr+TiPM7HtU1AdxogV1Tz4y/mMMFD7seKLg/JOZY+VL/wgjYUdNcmCffjikOTaO7w
         0BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735581765; x=1736186565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16iMQTA3yLJ1QlfHU0z1vMcVYOqrhRkI7zvdXHZSoHA=;
        b=svzdp5/M0VrAQghKrfMM0EjBPxYf0L9clLoyXuGYIidT0v+fPNvt7SjFfRmpJmSXUD
         RI+PPUkIqxvgqFxnJtnvKOoFwjK3chFWDmF4G5t3x1jPjxE9502V14ZxV/tfQnU77jY0
         VNmiSWMCzJSXPg8jMvwXvUouEdCk+xOn6yNVcjVBQX3S95KzMV7bgG25ScffXVHphbkc
         mPJtJa4sb/ayU9Ll51Wemx5wgaQM3z2+tb2nAX38lyqW/FcQ91AuXvVKfdFSC92O10Vr
         3l0JWMx35Paq5WHHJ0dAgg5IdcoEuftoneCZXWvqJaIKxS6Jxk+aPBreLXm0yGyYKiIr
         SXYQ==
X-Gm-Message-State: AOJu0YzU9B77LWZnz3UW2rvgGSb3616heLKrSv6JDkO3KPAbVgj3LuUP
	7trYT7W/yLyGGOmv8WpC0XH2at2tiOPph8kqqxIXkxLhrYN4BShe
X-Gm-Gg: ASbGnctqVTpe+l3Wx9ZDUqp1T0Kol/x9EqpBRKw1GRPku8lo4XvlCuwhLAMYnVx1Ewf
	RO5rmfMlbsJBZQsYaB9y4E5mlxYc89OlnCDOK2v29wwMYp4h25Kj9nGcnLGqlyn8uDYnbGBzHMZ
	5D5EDAbJMU/tufS1kRHdq5iZ13jid5DlTD0vqKiLLVWayArEasRGyIS73j9bcIiCS4dxiih7+FQ
	6rI654TdBqgCIMDdC7dpCObxAScDZKtsYRCowEWZqo=
X-Google-Smtp-Source: AGHT+IFBpFTYNRfnvzdGW0WPnW62pQqswePByMRjlWhFqLkyLpkR/mWsfve/EKdVvTACbahqL1ir4A==
X-Received: by 2002:a05:600c:6a87:b0:434:f623:9fe3 with SMTP id 5b1f17b1804b1-4366fb8a411mr304648795e9.16.1735581765026;
        Mon, 30 Dec 2024 10:02:45 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436604e9c2csm363918175e9.43.2024.12.30.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 10:02:44 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Dec 2024 19:02:43 +0100
To: Andrei Enache <andreien@proton.me>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next] bpf: Use non-executable memfds for maps
Message-ID: <Z3LgQwjTHKq_xi4Z@krava>
References: <2NK63_D3A4XK54XvOAywlNwXaq6bq2I2nc2nU9g-YVdEkYaPPKcbcQ3RI0yRDc65N2LmtEx1e2aWDKXS0BabHqkihS2gtXBcghhwM5TfDeE=@proton.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2NK63_D3A4XK54XvOAywlNwXaq6bq2I2nc2nU9g-YVdEkYaPPKcbcQ3RI0yRDc65N2LmtEx1e2aWDKXS0BabHqkihS2gtXBcghhwM5TfDeE=@proton.me>

On Mon, Dec 30, 2024 at 05:18:31PM +0000, Andrei Enache wrote:
> This patch enables use of non-executable memfds for bpf maps. [1]
> As this is a recent kernel feature, the code checks at runtime to make sure it is available.
> ---
> Changes in v3:
> - Check return value before checking errno
> - Update newline style
> - Link to v2: https://lore.kernel.org/bpf/Z3LHcCgqY7kHs08S@krava/T/
> 
> [1] https://lwn.net/Articles/918106/
> 
> Signed-off-by: Andrei Enache <andreien@proton.me>
> ---
>  tools/lib/bpf/libbpf.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5..3a30c094d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1732,11 +1732,22 @@ static int sys_memfd_create(const char *name, unsigned flags)
>  #define MFD_CLOEXEC 0x0001U
>  #endif
> 
> +#ifndef MFD_NOEXEC_SEAL
> +#define MFD_NOEXEC_SEAL 0x0008U
> +#endif
> +
>  static int create_placeholder_fd(void)
>  {
>  	int fd;
> +	int memfd;
> +
> +	memfd = sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC);
> +
> +	/* MFD_NOEXEC_SEAL is missing from older kernels */
> +	if (memfd < 0 && errno == EINVAL)
> +		memfd = sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC | MFD_NOEXEC_SEAL);

hum, you need to try 'MFD_CLOEXEC | MFD_NOEXEC_SEAL' first, right?

jirka

> 
> -	fd = ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
> +	fd = ensure_good_fd(memfd);
>  	if (fd < 0)
>  		return -errno;
>  	return fd;
> --
> 2.47.1




