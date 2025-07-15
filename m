Return-Path: <bpf+bounces-63364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30102B06817
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FC14E7689
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2F2C1582;
	Tue, 15 Jul 2025 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4XVR0dN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0A2BEC53;
	Tue, 15 Jul 2025 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612564; cv=none; b=n+/8OQz9jh76k1Wm3snKlJCP6INJIPapRMQEfakMDvPIvLUOmTyBUhz32wTSByLMQmw/EydR0QqhJENht4fFr9UPolN4rRvXyFpuZAfkZCD3448Ctsc3WixUmi0lsmj/0MuI0QuY+aoT1HZV2U/wQ3XZpIVCsW6MmflcM0hbpTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612564; c=relaxed/simple;
	bh=2k6oOaOIoLK+z7m39WCUT29OW2ydOaBVNPxwBT9CTCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyFLewWsTQOuKpTf9GTRPNYFMQshC8nG0lOINX6gFmXWbJw2BLA7aKik3lWUyqX/1meBr9Xn1elUJ3hsiPSRXNDkbXg0xIxZkdLQyshz4E6wubtQIVU82kXRMqZLiU/MRu2cE3a22nLzZOGaK3Uf+YYaN0M38Bd7MSrcIjpBsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4XVR0dN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so241975a12.1;
        Tue, 15 Jul 2025 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752612561; x=1753217361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14hLQTWKqKRy13dDlgIc/p+KnWY5Barjhpd+yfegt8s=;
        b=m4XVR0dNidKmyJdlrMLF+6/0HyLycB3nMobz26Qz0VDVx16k4D3BREHwTOehh/czLn
         Xd5CmjkQJJRdHlpHBKf109MUputoFR41xpzDfG/bfi6v4+sJ6xGSTD2iLcejqKpS5IHP
         syKLnv3msFg0Jqt/ZXOwk9RzfUO7GgIJ3wta/RG0rSJIJTAOAVPyGny1UIHkK1WL4TXs
         u0Z69zR2oy7IY2Z8m7WPZukEiRu7BybXtNEaAGPWEj4osiUy6d8npoTbCIfnSBWX+1p8
         4wzeYPQM+IUr75zyz4ED1gv48RYSFUgq+Y5/uOuI4dhX6zZxVxLMbS2oj0wOorNVrFOr
         2Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612561; x=1753217361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14hLQTWKqKRy13dDlgIc/p+KnWY5Barjhpd+yfegt8s=;
        b=PxwHvviWOzOo+RKSHJvJyaVEB+jcUGzZXqiBCIN44K/+lf6vmUkg/3U+W5/LVe8uzk
         ZtdIrOVMFChqugx5E2oxBPblDgIkGNbWXENfNo1TAVxwYxqSa1YaIRFiqH40XEUJB+Wh
         nuIg6vhpd3SmCfE+k78fAUKajyp+MMyuelD2nruIs+qEYd/kRwDuHc+TMPWnSyPKkkQD
         sXnTWZct9wFEjaOSc/F3mr7dCnTK2+MmbEBXLNtoZVreDFssQI9B+nBR/EzYUux1Lqin
         ab/4G19k14spEHeYJPs7i6toIjS9r/oWYY9rQOAXmn6Ctz5YW2GAK6tAWvlLY0/oSE9I
         fo6g==
X-Forwarded-Encrypted: i=1; AJvYcCUUgnSI2Rv9ZPFjj9E7KDhrRPPSBfm4GfO2F7nX3Fh+F7++DFyPN96erepsuRV2O8UjQXA=@vger.kernel.org, AJvYcCUXXAPhDPw7bq6FyOyPv7qmydjNZ/v28H3MOD3AROcj515TMgxtwf8BDfrmNOZG/7SCJ0U0O1DbTXIcoL4K@vger.kernel.org, AJvYcCWEw0WxpTbmh6zSezv8K5OlrrJcw2CV9kY22XbBZRUpFdBDDqpAod171s7iKEKiOnzjAiww8OcjMYkf@vger.kernel.org, AJvYcCWu62wM3wgJjoR9DY1gbzTu0U3K16yYH665C69CLqbbs9MSa7IPYCnRwS3uGNcWq0EVvAGJFas3@vger.kernel.org
X-Gm-Message-State: AOJu0Yww07A+CqRYOKLXiz0w/n4PCYFwkEBEdnwQ9pwRIBK5LsQpYmSg
	cMcSp896w9V9p4qtGRKpu6szL4l+J7jXAOFff53lVTCfj6Vw6GbvpEM=
X-Gm-Gg: ASbGnctBykNkR3cL1VMWRsp+e6Ih+bjaH3o0FdFIrAVs5dWQhaNC2Zc+7KSpAyM4nUz
	ke4mOjWtZXaRUK4OaBZ6zSQCkf6+gqQWF/IzUKK+7ZlTjw4XRnp/YeShZWcCUvMOEnFU1LHq4I0
	A5ee++M8vWlnSVHYjgTH+lzEx1N4K1ds5xXB48TennUAcrrbaNLlBRaksR3w2Ujvbx+CYonYN8V
	CKHnGbk24s5cNCi7JOHGDbApXr0Iqyne9nL0Gj5Yj0scRMKqrM9cDrU7ppO6cdzasqLc37ocqmc
	iw8Gc/3lXI799OcH8CJ7W3oh4DSkcRP7fmS+ABTXQiIStn32hicB/lDMCtN33jm8wjYBR++jVE1
	Mt9KaQn75LVQnRb/deHwaV7S2QshKg4HxgEufyfu6YwRY7vzxqe8YD8QnBKeSPCRb7/L3Cg==
X-Google-Smtp-Source: AGHT+IHUnvTzwE3v7P+iYmq/aAJvJN5snakMmspvRxaiVwSsTvMAUABpmAowrZMJ4AO5lfSSL0O9lA==
X-Received: by 2002:a17:90b:3f8f:b0:315:f6d6:d29c with SMTP id 98e67ed59e1d1-31c8fbc1b65mr7446154a91.15.1752612560340;
        Tue, 15 Jul 2025 13:49:20 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c9f1fb8dbsm38527a91.22.2025.07.15.13.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:49:19 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:49:19 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next,v4 1/1] doc: clarify XDP Rx metadata handling
 and driver requirements
Message-ID: <aHa-zwLmFSLDKeBA@mini-arch>
References: <20250715071502.3503440-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715071502.3503440-1-yoong.siang.song@intel.com>

On 07/15, Song Yoong Siang wrote:
> Improves the documentation for XDP Rx metadata handling, especially for
> AF_XDP use cases. It clarifies that drivers must remove any device-reserved
> metadata from the data_meta area before passing the frame to the XDP
> program.
> 
> Besides, expand the explanation of how userspace and BPF programs should
> coordinate the use of METADATA_SIZE, and adds a detailed diagram to
> illustrate pointer adjustments and metadata layout.
> 
> Additional, describe the requirements and constraints enforced by
> bpf_xdp_adjust_meta().
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
> 
> V4:
>   - update the documentation to indicate that drivers are expected to copy
>     any device-reserved metadata from the metadata area (Jakub)
>   - remove selftest tool changes.
> 
> V3: https://lore.kernel.org/netdev/20250702165757.3278625-1-yoong.siang.song@intel.com/
>   - update doc and commit msg accordingly.
> 
> V2: https://lore.kernel.org/netdev/20250702030349.3275368-1-yoong.siang.song@intel.com/
>   - unconditionally do bpf_xdp_adjust_meta with -XDP_METADATA_SIZE (Stanislav)
> 
> V1: https://lore.kernel.org/netdev/20250701042940.3272325-1-yoong.siang.song@intel.com/
> ---
>  Documentation/networking/xdp-rx-metadata.rst | 47 ++++++++++++++------
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index a6e0ece18be5..2e067eb6c5d6 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -49,7 +49,10 @@ as follows::
>               |                 |
>     xdp_buff->data_meta   xdp_buff->data
>  
> -An XDP program can store individual metadata items into this ``data_meta``
> +Certain devices may utilize the ``data_meta`` area for specific purposes.
> +Drivers for these devices must move any hardware-related metadata out from the
> +``data_meta`` area before presenting the frame to the XDP program. This ensures
> +that the XDP program can store individual metadata items into this ``data_meta``
>  area in whichever format it chooses. Later consumers of the metadata
>  will have to agree on the format by some out of band contract (like for
>  the AF_XDP use case, see below).
> @@ -63,18 +66,36 @@ the final consumer. Thus the BPF program manually allocates a fixed number of
>  bytes out of metadata via ``bpf_xdp_adjust_meta`` and calls a subset
>  of kfuncs to populate it. The userspace ``XSK`` consumer computes
>  ``xsk_umem__get_data() - METADATA_SIZE`` to locate that metadata.
> -Note, ``xsk_umem__get_data`` is defined in ``libxdp`` and
> -``METADATA_SIZE`` is an application-specific constant (``AF_XDP`` receive
> -descriptor does _not_ explicitly carry the size of the metadata).
> -
> -Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
> -
> -  +----------+-----------------+------+
> -  | headroom | custom metadata | data |
> -  +----------+-----------------+------+
> -                               ^
> -                               |
> -                        rx_desc->address
> +Note, ``xsk_umem__get_data`` is defined in ``libxdp`` and ``METADATA_SIZE`` is
> +an application-specific constant. Since the ``AF_XDP`` receive descriptor does
> +_not_ explicitly carry the size of the metadata, it is the responsibility of the
> +driver to copy any device-reserved metadata out from the metadata area and
> +ensure that ``xdp_buff->data_meta`` is set equal to ``xdp_buff->data`` before a
> +BPF program is executed. This is necessary so that, after the BPF program
> +adjusts the metadata area, the consumer can reliably retrieve the metadata
> +address using ``METADATA_SIZE`` offset.
> +
> +The following diagram shows how custom metadata is positioned relative to the
> +packet data and how pointers are adjusted for metadata access (note the absence
> +of the ``data_meta`` pointer in ``xdp_desc``)::
> +
> +              |<-- bpf_xdp_adjust_meta(xdp_buff, -METADATA_SIZE) --|
> +  new xdp_buff->data_meta                              old xdp_buff->data_meta
> +              |                                                    |
> +              |                                            xdp_buff->data
> +              |                                                    |
> +   +----------+----------------------------------------------------+------+
> +   | headroom |                  custom metadata                   | data |
> +   +----------+----------------------------------------------------+------+
> +              |                                                    |
> +              |                                            xdp_desc->addr
> +              |<------ xsk_umem__get_data() - METADATA_SIZE -------|
> +
> +``bpf_xdp_adjust_meta`` ensures that ``METADATA_SIZE`` is aligned to 4 bytes,
> +does not exceed 252 bytes, and leaves sufficient space for building the
> +xdp_frame. If these conditions are not met, it returns a negative error. In this
> +case, the BPF program should not proceed to populate data into the ``data_meta``
> +area.
>  
>  XDP_PASS
>  ========

Can we move these details into a new section? Call it 'Driver implementation'
or something similar and explain all the above. Because the original
purpose of the doc was to explain the API to the user applications.
Since we are hiding these details from the users, explaining them
separately seems more clear.

