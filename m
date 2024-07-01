Return-Path: <bpf+bounces-33553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D847D91EB40
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722101F21DB4
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8C17108D;
	Mon,  1 Jul 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGDH8UC7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EB4779E;
	Mon,  1 Jul 2024 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719875268; cv=none; b=rxRn84J3/ERe7pxVv9iiqm00aVwBjPsl0lk+bhzNCzNB/NJ5I85EakslefnSTruhm0pkX/kU7rv/m2Us6xR+OavFGTb4BBQ5OAC9xroag53j29U4V1TNosI411yRV1rGqnfLu0n08Jg6tyZpUF68m2gMT74yEMV0K688ybr4dwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719875268; c=relaxed/simple;
	bh=M7czOSRKOIRX5JH6HXvecYDnGFIb55joVKbl2MRoo5U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghmWSob7w9zdZCVaKijDfhMphnphDslhTEdMUkw059VreSC/KnyncjF20jEKUGhHpoy/ZHvQ7tw8V0PdGVq+QBQ15SA18ZrDCmqU+9LtSiX3+RtWJN+t7wxu7Y0HUX58xbT275QLfo4fivPuPaPTxYQb3QJKroFOuMz60Lg2fwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGDH8UC7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-424acf3226fso27645145e9.1;
        Mon, 01 Jul 2024 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719875265; x=1720480065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZVQHhUUk7x9I4JpNIiFb5udRfPCwCAGhgmfk8TmLpM=;
        b=iGDH8UC7UsFlZ27Fec8wzCCT/90GAv1fk6uQj1P5Hr+zppUZMpDJm9f6s3F1TJHxlk
         59dZ8PmwhjDMhBB3ebRu6k8fcQl8xdlWbUGrdeZTx5m7095+Gx915HJRhwLS5N7Ro2ap
         L0JzcYCvNYfp/ovF3628M0gso22tS7ZpKwzufsBP4RTP5J+tB4qXFtZPs6i91ZfgpdO1
         xehAgs/vB4ZUw4m0bW/OMW4/YFxdDM6sb7HGtNiHlBUxLamjaIqVnm6EZOAd48IrjC+o
         nVolPwaApS0LPB95v0rqm1Q23viwi3woWkwuYQbt0cZqu4Sv6fPeUMcwpWARUxS+G6z2
         Ohrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719875265; x=1720480065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZVQHhUUk7x9I4JpNIiFb5udRfPCwCAGhgmfk8TmLpM=;
        b=e+6Qu1rKZXwAJY/ZcD5ekLHszF+9XxOwmUs1zyGP6rOUP7PCo92UqB0pvSS9r5QxFv
         amLqfxCh9y39lRjjSWdJ7hMUjcPMag32mQbcOWPzToDbFYw8jyDLk35XFvFC4/GX6TcH
         srmouKab5vSIOrjcudg/BoDsXXbDA9Jt5e3XZUjieNDpb7bBS+4oDCS1VIjv9f8Zq01C
         qGPjH7nB6vMV93CfvyP7PmHSBb8LUyVIreqJ2GW0g3LyYg+80WBT4p/B5I+6dDf25mIB
         zzxHCrxnobbnjjNHQkobRQyxvJDhhAzCVe+fphW0ewQq36vOjr5JDMK9Ektpwk3KyrTZ
         VXRw==
X-Forwarded-Encrypted: i=1; AJvYcCU7TKhZQi9P50raa/aSBq6GlGjBpvTiL6fIcYNPi7Yl7wK05Js4+q2awzct+V+N8D0069s9cOuCZ0Fu36V0Ev23jQIP/8MeV7YqLB2/lRCc+rMJLdUfODrmbzdJBIUHjZmv
X-Gm-Message-State: AOJu0YxT/XSkvG8gxgaePlZ7EzXzmgOj5DMEK5Y5/wlm/YhF4HI7XLVI
	/HYKa4kW0fGZn70SFm+AJuOTWzJ5hMPh6ON2U8tW+L2QtHV1zrcC
X-Google-Smtp-Source: AGHT+IEmm550W2ESxOY+/QRIU615EPOdhIUP63Ugurh9Pb5DER1Up2XkcSVttysW4Gl4T+WiZH2BeQ==
X-Received: by 2002:a05:600c:178f:b0:425:5e9e:82e0 with SMTP id 5b1f17b1804b1-4257a06d505mr44268575e9.33.1719875264948;
        Mon, 01 Jul 2024 16:07:44 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd778sm11485196f8f.5.2024.07.01.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 16:07:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jul 2024 01:07:33 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, masahiroy@kernel.org,
	daniel@iogearbox.net, nathan@kernel.org, nicolas@fjasle.eu,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
	asmadeus@codewreck.org
Subject: Re: [PATCH bpf-next] kbuild, bpf: reproducible BTF from pahole when
 KBUILD_BUILD_TIMESTAMP set
Message-ID: <ZoM2tY2QdD-41g80@krava>
References: <20240701173133.3283312-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701173133.3283312-1-alan.maguire@oracle.com>

On Mon, Jul 01, 2024 at 06:31:33PM +0100, Alan Maguire wrote:
> Reproducible builds [1] require that the same source code with
> the same set of tools can build identical objects each time,
> but pahole in parallel mode was non-deterministic in
> BTF generation prior to
> 
> dba7b5e ("pahole: Encode BTF serially in a reproducible build")
> 
> This was a problem since said BTF is baked into kernels and modules in
> .BTF sections, so parallel pahole was causing non-reproducible binary
> generation.  Now with the above commit we have support for parallel
> reproducible BTF generation in pahole.
> 
> KBUILD_BUILD_TIMESTAMP is set for reproducible builds, so if it
> is set, add reproducible_build to --btf_features.
> 
> [1] Documentation/kbuild/reproducible-builds.rst
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

makes sense

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  scripts/Makefile.btf | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index b75f09f3f424..40bb72662967 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -21,6 +21,10 @@ else
>  # Switch to using --btf_features for v1.26 and later.
>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
>  
> +ifneq ($(KBUILD_BUILD_TIMESTAMP),)
> +pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=reproducible_build
> +endif
> +
>  ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
>  endif
> -- 
> 2.31.1
> 

