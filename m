Return-Path: <bpf+bounces-62133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16273AF5D79
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA951884F37
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7302D77FA;
	Wed,  2 Jul 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtnVEJSE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5E2D0C9A;
	Wed,  2 Jul 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470557; cv=none; b=kLNN7qylyYUHhv7r54lZkmWOHjwWV/P8drwFgukROOahaJ2NK14j0nu1uzfwBBYea+3T2xSUOeijVz0BYptiSOPFf53nkNGnmb8DOTQKA7e+H4O8dLgO6ku2FXumCZubGSNGTsQ9KFaed6J2N/HCCJew1dSiUg343pstUnzgy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470557; c=relaxed/simple;
	bh=5ZysWWShpATP1Cz4waZmq4BSldDVqMnJt/uhhMdfLns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJrLnp3Ka2neMNifehVxSUg6O3HHbUMNCt7RmecBkVm/jXYtjanRO6u1fxqYv8KmO5iKz2pejqPGHvs8d8B+SF7nZqtWk0vQrH3rqnb08jqvYICrpQDEkhN7tgvHkNztsnub5yeA8eXT97JpS8PyQ24umrhYZWVKmEvGvvZmKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtnVEJSE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d366e5f2so66356355ad.1;
        Wed, 02 Jul 2025 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751470555; x=1752075355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYI9k0erkW3DaeZ1w94ClfFFUCJ2iHj8bWnvlW0HhZg=;
        b=MtnVEJSEw3Je99i3kwR4h90R9vVFV+kgTPLFA/u74Yeq/5iyrT10CLrBwUaZHSFDUq
         SFbpoUT31hbAW9ujWBUjMPOEC+A+yCfT1SjyTyUQ756nuTCJHkKM2lDbTVn60JhZpbwB
         XgDRR/dSpHjXqzVZ5CWAtrh73AczuqNGEN+akyvA+5Vhj0YKZop1kNAojNGgrz8snIEi
         6fBYPgN3JNOtxi/jNb1ZnNGOiTyFgnY2Gl4In6O+dZji21IELQ/G4C0qwe3S3t0LGC/x
         MbIRyNiTOwYpT0cZX3SFv1RnvpEdC9MVs/z1B56V0PIQ60Uvep9Ulf9mNWna4JMOS94X
         B7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470555; x=1752075355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYI9k0erkW3DaeZ1w94ClfFFUCJ2iHj8bWnvlW0HhZg=;
        b=bhorjtG6BTmjqnL2Fr2rGoF0bGKt76opw1RL1dXvNsd4hNE3Q6FrxqC4uJvC+GoodL
         3z4qERUeb7/sEfPJE5raB2EDsEVN2HG0t0K4FOYNICBnu6YZoUOXvaHpEtk5WyMOtin2
         T1ztHjSZB34cd/OUoRT4TXF5Hb0lXdehuKTaPfGbOGLhh4m6f1xo7rjFiCXKROGgpKB0
         4+OkISZFAijW8cBEmcHz+5Tw1+MkTWPftRzvQGtzkqiLrWDibhwZNlDVCEvQvot54jDc
         BJlGtewcE38R2XbXOZVTWd08PaHRrdqkyHBg+egeetqnW+87t54t0purKtiEaEqhRQTW
         SUiw==
X-Forwarded-Encrypted: i=1; AJvYcCVESxq/bbu+vhmLemVE2sm6c9jUBP9b6W69xX4Db8qlCfZ+kYv/nf5JsZs2GehDBLNMIw4=@vger.kernel.org, AJvYcCXniv2SsQr39C/z9qAHF13WbOontWFghhRv/NBSGY+X9etsRP9gdGOpWg1ywTHfjURJCKKNdrbP@vger.kernel.org
X-Gm-Message-State: AOJu0YwsjsbvoILwY2jlgYywxqL/xef3NK1Gn6OCyza6IjeEgBfODMrW
	sgo+PpSR7E42mpcGYkSJj4o+V6SSOvgwNW5BJEBEK2KukPf+mUwbJvk=
X-Gm-Gg: ASbGncuuY/ZaLiin5O/rBXTiaOhfc5V+uKKtj/a1gv3klaemnhYjAZXS4IthMDfdJqR
	+3shAFDKEMJvB4tB0l7R5u6ka7xbf4N8Fs3KeQLKh6z7EGG1c3rNjkZT/8IQm+lZpdpZ7+Fqi+u
	sfeWAvIpI+jLLYvwFfSBtvtb7D7ZDuRUIEK8xx3JWUKBkfNgXlVsLwP6k0mso99/FwJ+5yCTiv6
	8JJshbbBTXmAkmIv5bON3d9/9CrM6ma96jaNQf90lhTCNXz05nmTv9Ly8WMNNYdp2cXcvI5eXIo
	eKiNSER2vqcQ3orXWoAlwhoy3r59n+w5dah9oJBLOi08/OaWZIG1rjHEXUZ+crugRYn0y9EjqVz
	Ot0J2MBgaJHyltj9Y2GBrGA8=
X-Google-Smtp-Source: AGHT+IF2nwGNPU+ljFdzemNVRiZe9t6jcy16X+LtWxO5zSwGlB8gKifIsETNoDTX8Ist+kFtRhn0ew==
X-Received: by 2002:a17:902:ce0c:b0:235:f4f7:a633 with SMTP id d9443c01a7336-23c6e58ac78mr54167105ad.28.1751470554744;
        Wed, 02 Jul 2025 08:35:54 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2f1b31sm132609655ad.69.2025.07.02.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:35:54 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:35:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] Documentation: xsk: correct the obsolete
 references and examples
Message-ID: <aGVR2YqVLaWykAfV@mini-arch>
References: <20250702075811.15048-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702075811.15048-1-kerneljasonxing@gmail.com>

On 07/02, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The modified lines are mainly related to the following commits[1][2]
> which remove those tests and examples. Since samples/bpf has been
> deprecated, we can refer to more examples that are easily searched
> in the various xdp-projects, like the following link:
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
> 
> [1]
> commit f36600634282 ("libbpf: move xsk.{c,h} into selftests/bpf")
> [2]
> commit cfb5a2dbf141 ("bpf, samples: Remove AF_XDP samples")
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> V2
> Link: https://lore.kernel.org/all/20250628120841.12421-1-kerneljasonxing@gmail.com/
> 1. restore one part of doc and keep modifying a bit.
> ---
>  Documentation/networking/af_xdp.rst | 39 +++++++++++++----------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index dceeb0d763aa..a206c3636468 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -209,13 +209,10 @@ Libbpf
>  
>  Libbpf is a helper library for eBPF and XDP that makes using these
>  technologies a lot simpler. It also contains specific helper functions
> -in tools/lib/bpf/xsk.h for facilitating the use of AF_XDP. It
> -contains two types of functions: those that can be used to make the
> -setup of AF_XDP socket easier and ones that can be used in the data
> -plane to access the rings safely and quickly. To see an example on how
> -to use this API, please take a look at the sample application in
> -samples/bpf/xdpsock_usr.c which uses libbpf for both setup and data
> -plane operations.
> +in ./tools/testing/selftests/bpf/xsk.h for facilitating the use of

nit: the paths are always relative from the git root,
maybe drop ./ from ./tools?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

