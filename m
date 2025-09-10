Return-Path: <bpf+bounces-68029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B8B51D62
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D0B17191C
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75333A016;
	Wed, 10 Sep 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo/cER+n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7033769E;
	Wed, 10 Sep 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521004; cv=none; b=uhel+9aKLf5p6dUjUAbUuxm/s4yxF3I1rrEgwiXS6M1StaKNPaIQ8MAw8Nj5pypx1plaAGTuHRFPiXIAt+okT+D4RfYdVp4C1pJ8yFylD0pe6qFnaVCRZb08UFygQ62MagS+Vphd9Ho74Qrbyw+ulgwb05Q9DyxZTKjnLkBWI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521004; c=relaxed/simple;
	bh=NVFM3neR7N0A2HmQoK+ROHkmwptFlxIoqcQa9WgQUMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+v0wlSyL7RsWm4Stg0Shij8nRFBtENEU0cfUGoIPlosd6vHhmpnv6s2p29x5VEUDdKhbTEprj3dy/Bt3Bz7SUvPX0yp0v9AubDm5oXrosNfz/6VZCAJDjd4kx0VUUy9YgNH0/TWUtnWQuD74warXIY/qLyAsoaCm0H2dyzY0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo/cER+n; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5823439b3a.0;
        Wed, 10 Sep 2025 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757521002; x=1758125802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JB5WUshzKYeKBoYX6JQ+1Pxk+oTXaSsiBLCl8BznXVo=;
        b=Eo/cER+n3jygBbPbgSvY+hWayAi+QVounCoxBA/Beczp8VxmD+R5EVPwsJBNk992S3
         Y3qGtDAm8ZK5jHszjk8YygyyIZETKFC9EdbSTXE0vnL0ASsZyTlfn6bmfYFh6FdJhpGV
         ggg6SFoXOq8XBpghgSNgEl2T2JZzVT4ctZzux/YL5845YMyjHhXBK4Lrsr0Dg2V+YHVf
         Q8267gKWD/IhFWzkf+u/J7MPTK7lchuHi2NgD4PCaJ5X9aYveLKzXFuhTTBgDofI/UVZ
         u7xb6w721WlXhnR1+s1+J5YsXnAEzXGHM46Ciu3Rki++VrccuSxOKvhIQXDRHxw8uQHk
         TAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521002; x=1758125802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB5WUshzKYeKBoYX6JQ+1Pxk+oTXaSsiBLCl8BznXVo=;
        b=VqL7aMrC8fVMAF8ZdlH9t6CjtOPGqRzREtqEiB6j1uFpz+0g0WpAEWVrCcmLp2Enh2
         e4LAv5O6NCuYdQXHlJHb/fHhqXhgKiNTXSD7xb6coo048BOV5Nx2+qVLNoUa1+3+d0R+
         lo9ALW1U8jnFzOndNvL1C+z/RasqM1cYBnA83F20026jqQYcfcKjxywq4tdpTuKRL1sY
         Kzug7zpxLaMtbw7rm8w/tlAaCl9GAl/uPlUFjeN52kgr/gYM1+9umv8heuqh8j8Sm9LK
         +NMf2zrM3bxuRbFJgvN5kTxNtLkwG3gvuE+9kPnhkWvWh7F69tBs7Yo7hmYuk7kjQP5f
         UQTA==
X-Forwarded-Encrypted: i=1; AJvYcCU/yII+9e3002EkpEXYYVBzLszZ+bvZut8100rEomw4dnB1POoUHb4glu1poqsProCwfwzOhuHCUwsuz7bR@vger.kernel.org, AJvYcCUznDVscwyL6NONsVtWE/gAEghxQDTckLLFg8h0yt26rvCMGsVOvB4jz8Cko8RRgf6HeWw=@vger.kernel.org, AJvYcCV0cwWke8/FNVDg0ruN1qm+oAUKk+7MZKd7Zxd2TRWF2XxBCdEHV3/2CaTRWaV+GdsiZY6MBnXpTddQ@vger.kernel.org, AJvYcCVWgqOxjZHw5oHCsHg23i0oxaBNwXPAykzXSIfkerfMxHmlLJk4Vy5tyCsruC5kGGmjTGHzlkofCrAnXA==@vger.kernel.org, AJvYcCW3yYoVfe17+AHeoYXvh4BllagSUKkGlJa5snwFoFgNsBVlfjFeipeImz3lr9M/aGXCGXqcoZVx@vger.kernel.org
X-Gm-Message-State: AOJu0YwES8YfXGQ4IjpQ1IVERrGcApFMG+qYMms2h8SuEymnlx2OX8PR
	eb5TrL17lJKrnMooDrnTxsVNwjYufX7Oy5EbClu3VOnDkJ+TqFEAKok=
X-Gm-Gg: ASbGnct0PkWmvpzV3weMbHapnADMGBOYbs4/zdX2sdoEhKEoAlpUqpttCCueSlghx1v
	j+rB3N2kchu1OCiBroimAyGVg8JUI2hODM6uLZfiabLqvZpY14A2/rqgx6A13adKPRrG4a0AG++
	NSnvqTEGlaCwm5mYpeda5yeh04XFygNH2DQDNSQceHjgcWeChMlmLRcW5tfvJCdYQtxTAjZH+fu
	E3686VljGE8ja6Zq/1ZYHUtJ9MvujIf1GORpX9ZlqHHiEC0N/WiHmYG6ubRxNtpAi2TMHltHR2C
	aNHnW+hz7X73411rjLxkNjrUDbosy8OtsLNV50D1K9dV0qOh/b/dni6SwJPWW2T3Awt1Ph9+1VZ
	m5UTeXLOJ3JD8KGxj/WuHk+CTehUsp5r98+899nGHo5wQkk7BMDiXuNGDa2xv5kDIgkjQNcYN0k
	AZnJyZbGMx4JDB/qmP8+lDbNbjHq9Nwx4XQ3dL1xfc4Kcgj0l47T9EFgA5olZInTru8btgHCLjG
	kibs1Hsm2mGaZY=
X-Google-Smtp-Source: AGHT+IHqLINn057ngCZaw/jpWSqhs/u7NZ2CDFe0dasDSVTaVkcAUe46x0lZQDpoIcwp7hoWMZQPvg==
X-Received: by 2002:a17:903:2b05:b0:24e:81d2:cfe2 with SMTP id d9443c01a7336-2516f04ffeamr229403285ad.7.1757521001758;
        Wed, 10 Sep 2025 09:16:41 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a2742590csm32206725ad.8.2025.09.10.09.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:16:41 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:16:40 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 10/10] net/mlx5e: Use the 'num_doorbells'
 devlink param
Message-ID: <aMGkaDoZpmOWUA_L@mini-arch>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
 <1757499891-596641-11-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1757499891-596641-11-git-send-email-tariqt@nvidia.com>

On 09/10, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Use the new devlink param to control how many doorbells mlx5e devices
> allocate and use. The maximum number of doorbells configurable is capped
> to the maximum number of channels. This only applies to the Ethernet
> part, the RDMA devices using mlx5 manage their own doorbells.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  Documentation/networking/devlink/mlx5.rst     |  8 ++++++
>  .../net/ethernet/mellanox/mlx5/core/devlink.c | 26 +++++++++++++++++++
>  .../ethernet/mellanox/mlx5/core/en_common.c   | 15 ++++++++++-
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
> index 60cc9fedf1ef..0650462b3eae 100644
> --- a/Documentation/networking/devlink/mlx5.rst
> +++ b/Documentation/networking/devlink/mlx5.rst
> @@ -45,6 +45,14 @@ Parameters
>       - The range is between 1 and a device-specific max.
>       - Applies to each physical function (PF) independently, if the device
>         supports it. Otherwise, it applies symmetrically to all PFs.
> +   * - ``num_doorbells``
> +     - driverinit
> +     - This controls the number of channel doorbells used by the netdev. In all
> +       cases, an additional doorbell is allocated and used for non-channel
> +       communication (e.g. for PTP, HWS, etc.). Supported values are:
> +       - 0: No channel-specific doorbells, use the global one for everything.
> +       - [1, max_num_channels]: Spread netdev channels equally across these
> +         doorbells.

Do you have any guidance on this number? Why would the user want
`num_doorbells < num_doorbells` vs `num_doorbells == num_channels`?

IOW, why not allocate the same number of doorbells as the number of
channels and do it unconditionally without devlink param? Are extra
doorbells causing any overhead in the non-contended case?

