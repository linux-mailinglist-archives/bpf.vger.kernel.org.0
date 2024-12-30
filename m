Return-Path: <bpf+bounces-47696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF369FE8FE
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DA93A0581
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6E84FAD;
	Mon, 30 Dec 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLkMAnW1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BF1991D2
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735575414; cv=none; b=dYRvZYNBanr2XCVKrHgY4I7+ZDaksMVu2crjCDAxWXX3GYbiAkLk3ctd15UcKgFAsaTVwhqZ3moVVvkqxtbZx+dcHldUQ8DEEUQYzk7RpVGHDYRO0/5YDuICFnGCQmzzDjjPOupWCz/UinnXGQKFzSRhnj0csX/jHVRwgwxFh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735575414; c=relaxed/simple;
	bh=m8YJdKCI0IzyOaU8MTCg31wgEmmm/WkSgm23lBS4Ovk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNqoN3Z+g6J5L2H/c0TyCBmYFaMzFi8jT/Z0C6MKR7jTdD/W03zaRnBUFT1hZ9s+8VCrS7Tahcn2UBarGg3kEgAnBiuDf4rbUOfJhR6WHz/ueuCrmy3YbVrS0MnBMo2zE362FCQgzTO5/xAG0caasQTkrxpWi687DHpuA7uXIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLkMAnW1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso15996467a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 08:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735575411; x=1736180211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=myzJkT0MwJWbLgXZ5T8fUSGjF+RLCxU0gNQQVmUc0F4=;
        b=MLkMAnW1cHrFPTf8kV4rgsAsad5MsUe9vmWBhQGrdLRsSYAM79znjW0TEBgoIZL5dI
         vfM3obxNsIpMdO2gS90D7CfxIn53guXCEJLvNK03WHUvYRW1g21NYhVYrqp6g0RMWLky
         GTy9+G+If3NXHKrNYETcs28wQAzLNligF8a2h7bWMreadplCSywz8tawcLzvlFlkVTmU
         tEuIP4m5HgECVvtkZTRkO9/Mzrxi1Dh3OpNt01cpy+Rw7R5GwPtWlRCLgY8AiqvBX5cg
         FW79tb8xZD0kZeff2tsLwt8OdiodGVvLrc/9OB9BJ7xEFCHFBAMfgryrWwwHfpgb7zFV
         yRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735575411; x=1736180211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myzJkT0MwJWbLgXZ5T8fUSGjF+RLCxU0gNQQVmUc0F4=;
        b=hDh4l9S2z00PyK89vJGca9+i7pFKALc1J7vMUYoAiZxg7Yh8r4XDLO50Nqf/VjYY0p
         r8fjign7ac/SotnUlqER183dLzJwN+fRshY8JCNXHf7sTFwNSmdsy51xGep9R7qrCXbO
         guT932pjoLhf/dcuH5FxVzTXVgcN9HD3fx/uMJj+BGY9BbZ9Rn47/2PIqKE0VH33KNUB
         i3m3PhEbknKYyeNJxmnjvSeAy5fYrmLKp3PzZ9zzXJrtB2wvGUBJaEnpd1wgMj8smHCf
         2RnAcbkx29hVv6YDjtiCX5NH9BaJ8nDcfyudBmACWqW+QNymTlMLhQz6qITRdYg7dPYM
         DD2Q==
X-Gm-Message-State: AOJu0YyUM/PEBu6nY5gdPNPWtPSLBhjXDlzOePLvAPAgsxFrcQ61+Ato
	jTsGNRx6F6Ta4NMWIB0XAOPd8T3h5RMVnC0qWI6wv1XkmbIyedMf
X-Gm-Gg: ASbGncu2tpE61xyjz6kgG5P1NhQVcE9oYBYDL+811+jsXmJQhl5zTVUXjNcnbAMP5Id
	vLD4ekHyPKWFefFf4CdUwNdC6Vki/2e94zT7vebVY9m9+mm0hh/GrucNp4N6kOVBXQV3bmvm8L+
	8wSXhQ78amQfMNgMTMpW8PwOeNYXRwNsoiPHlcPqJZTpllujVi7rQmm5cijMGLCeLjywDJgh1Rt
	7MhekQZ7slThV7pgVYJD5NhIAz6RadK2E6fFgV6nkA=
X-Google-Smtp-Source: AGHT+IHgVg0P59lPEk+SP9d7lPKMJPn86B6pXq5IIkyJJxnYSLJXFrZ6wHwBbj2YIEdKla6bkvli9g==
X-Received: by 2002:a17:907:2d1e:b0:aa6:bcc2:4da1 with SMTP id a640c23a62f3a-aac2874a98amr3254778666b.7.1735575410727;
        Mon, 30 Dec 2024 08:16:50 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06f847sm1458557466b.202.2024.12.30.08.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 08:16:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Dec 2024 17:16:48 +0100
To: Andrei Enache <andreien@proton.me>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Use non-executable memfds for maps
Message-ID: <Z3LHcCgqY7kHs08S@krava>
References: <eTid-pMaxx4d_gMkyFN6fgVGub01RRJYIl1SzTmRG7RtRlPUJOMrVfe2I1W8s0OBHBFy3UN2WGm_e6mak0nGcrZ4ZdxAYRUSDDcUSVMvNA4=@proton.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eTid-pMaxx4d_gMkyFN6fgVGub01RRJYIl1SzTmRG7RtRlPUJOMrVfe2I1W8s0OBHBFy3UN2WGm_e6mak0nGcrZ4ZdxAYRUSDDcUSVMvNA4=@proton.me>

On Sat, Dec 28, 2024 at 06:00:48PM +0000, Andrei Enache wrote:
> This patch enables use of non-executable memfds for bpf maps. [1]
> As this is a recent kernel feature, the code checks errno to make sure it is available.
> 
> ---
> Changes in v2:
> - Rebase on dad704e
> - Link to v1: https://lore.kernel.org/bpf/6qGQ7n8-hGVRUbVaU4K2NOdK93nEC-Ytb1ZCWhJyHoeIJgs0plTiTHLLQ8ghWSxjdhsu7VRiTD8SSqEW0eJyssE0FGOp4fn3wNG7TS-jsq8=@proton.me/
> 
> [1] https://lwn.net/Articles/918106/
> [2] 
> 
> 
> Signed-off-by: Andrei Enache <andreien@proton.me>
> ---
>  tools/lib/bpf/libbpf.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5..490b41e2d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1732,11 +1732,22 @@ static int sys_memfd_create(const char *name, unsigned flags)
>  #define MFD_CLOEXEC 0x0001U
>  #endif
>  
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
> +	memfd = sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC | MFD_NOEXEC_SEAL);
> +
> +	/* MFD_NOEXEC_SEAL is missing from older kernels */
> +	if (errno == EINVAL)

I think you need to check memfd < 0 before checking errno

> +		memfd = sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC);
>  
> 

nit, extra empty line in here (already)

jirka

> -	fd = ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
> +	fd = ensure_good_fd(memfd);
>  	if (fd < 0)
>  		return -errno;
>  	return fd;
> -- 
> 
> 2.47.1

