Return-Path: <bpf+bounces-14913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F077E8E7F
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 06:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07591C203DE
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 05:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16233E3;
	Sun, 12 Nov 2023 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJzsm43b"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF42568
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 05:57:11 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF9D8
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 21:57:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso28662115e9.2
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 21:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699768628; x=1700373428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcZqb1i9IztXtqrbd3S2IHFs4ju/R4DGpnEXVNx/Cjg=;
        b=RJzsm43bSsZzGhdadTJ/N4HmdFih4wTLJsshWSdOa2ioGYQ9tZoMNuVop22f+i/l/Z
         J7+7FZ9jV4JWzEQQgQOuNWftHqUTNzQkvjbpElxqivLSu4M5IMJ3Ht+EKx9SZoKEgWOy
         lOFQpiJKzGv9EtZNnuL+DIDgMpor1b7atBSc2gwtxgrLm7at2Nfy04y3SFz89wB/jhi4
         9SPB+X8s1j97sUMmB+hBfxELZZ6Nq+nCohyLQV3ZKy9aMXOirOVKI++gPDWtiZ5nug6I
         ewnrCpQRBx7i/4ZB9LVck4DovbYxcxgHf4dUGqSW1d1YfWwm8d8dY+B/Lewo2r8doN4e
         3TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699768628; x=1700373428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcZqb1i9IztXtqrbd3S2IHFs4ju/R4DGpnEXVNx/Cjg=;
        b=BvBFFk/v0j+OUBvQM+JxR4yL3Jwh8mHRRJdp1FVHUDTVhtJN4E0UwiBkG7Pae0XehE
         CdCz8+bmUcF47RBWD9zuqP3/IcK0QOyW85HbsbFTxH3rAXuqct9EIUonZTE4bO01uZir
         TrghH+C6ayZZVLxzYhbfGQQZW0Vd8nOhcdTajosUAQSE6HgoOAkmc338b2vgOO5zvXra
         f/ky8lfr1Ds5d9AP5BptF31Ooa1vrBiiVXn1iUwwfB2Zzrc7xT0zdJKHl259HZVLdbWn
         UfViIs7NDhHjItdt6GhSJ4vcAs9DoE1SMC1iIULGdkF6Q2qIT+RMxgVXP07vKWmXLaMg
         EZMA==
X-Gm-Message-State: AOJu0YwqISwSPFKHHJVMO+LZV7vO0uhL/RgbK6QdEGx5D39TYR0Z/Qz8
	0nk9hGQtC8OX1ol7nGVckas=
X-Google-Smtp-Source: AGHT+IFOiLMqJpIErcx3mJ/k3FeFhdgDpyKmU7DSgBCz576/gAscey1oAdh7m1RMh9dzoD+XgsRK2w==
X-Received: by 2002:a05:600c:3b9b:b0:405:367d:4656 with SMTP id n27-20020a05600c3b9b00b00405367d4656mr3075221wms.29.1699768627535;
        Sat, 11 Nov 2023 21:57:07 -0800 (PST)
Received: from krava (brn-rj-tbond04.sa.cz. [185.94.55.133])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b004090798d29csm4023135wmq.15.2023.11.11.21.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 21:57:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 12 Nov 2023 06:57:04 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 09/17] bpf: switch to --btf_features, add
 crc,kind_layout features
Message-ID: <ZVBpMLvqhrFpnd3d@krava>
References: <20231110110304.63910-1-alan.maguire@oracle.com>
 <20231110110304.63910-10-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110110304.63910-10-alan.maguire@oracle.com>

On Fri, Nov 10, 2023 at 11:02:56AM +0000, Alan Maguire wrote:
> For pahole v1.26 and later, --btf_features is used to specify BTF
> features for encoding.  Since it tolerates unknown features, no
> further version checking will be needed when adding new features.
> Add crc, kind_layout features.

hi,
this commit got merged:
  72d091846de9 kbuild: avoid too many execution of scripts/pahole-flags.sh

so this change needs rebase

jirka

> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/pahole-flags.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 728d55190d97..30a3e270308b 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -26,5 +26,8 @@ fi
>  if [ "${pahole_ver}" -ge "125" ]; then
>  	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
>  fi
> +if [ "${pahole_ver}" -ge "126" ]; then
> +	extra_paholeopt="-j --lang_exclude=rust --btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,crc,kind_layout"
> +fi
>  
>  echo ${extra_paholeopt}
> -- 
> 2.31.1
> 

