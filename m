Return-Path: <bpf+bounces-59848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE4ACFE02
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 10:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A66177AAB
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8AA2853EE;
	Fri,  6 Jun 2025 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtpAb7rw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE62356B8;
	Fri,  6 Jun 2025 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749197519; cv=none; b=aM6emf6h6MFqDU1ungCVPbPX4/zPl7PF/wq7/QTSdXDdNy1DseFQ2K5Qc9lNQpIQmds8v46XIpKnEDHKx4z9tVX72oU2uaRYJPlDUtPm4hcVVPs4nu1JoGIkC5mQpHIUCYd35SPrZNqI3Opr/T1McRSG2NIc7FrAciXIsj9YudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749197519; c=relaxed/simple;
	bh=ZuDJMQx0bckQqQYAX8ktUsiM7fLLnYTzUNDL9d0esbs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv8sokWta3jBAaeXtsSPELUaO9EBllVNOM40Z5U4kvbDP39aBdJfXt/3b+xW1XeFpspHhwcuXuBe4dx1ZDnD7O+6XXyFJBvhazi0zJh9BC6BNxpGHG51BTYmT8kvBPt+7Hl+QniH4X1I3g8kPkjPyikk9b94Mf+7Vw+SsnOp5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtpAb7rw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso2910569a12.1;
        Fri, 06 Jun 2025 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749197516; x=1749802316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TgApWI0+BVOjkWxGB075M4gC4i26wr9y4+tNmb0C/Mg=;
        b=KtpAb7rwJFao9JAOAvvkHOcO+DKApjMcr9ZFF0EOX1p87BGDIhmkKGNeJl/AcPHJtv
         AZ7xmIiNGewHniRCvqJY5kMBwm32Xxo1Um+SNuZCnn7oJu/53RZ93RtSlLqunRWbW1q0
         m/v1HxoeuFgzaRilL3bE5Kb7o7v74epLPRy8TOOA2DwEtjaGYudKkcwR8fs6KSlZMuYN
         rmen9R71rTGppi3F/jc8r72xtzmKmNG7K+wYvdET+u4hFv8GGyxjpUwpqcw8qBnLjPee
         vFb/WDQU/4iQ66g2ucGGtmMnr4h2CLcBrnuLMI6rCVJDZoqJdlKmzzTUN/rs8DsKqZrS
         aD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749197516; x=1749802316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgApWI0+BVOjkWxGB075M4gC4i26wr9y4+tNmb0C/Mg=;
        b=QXpOEYS5GjgiL58dKtFEyyX+ZrErV+K8zXyrX/3sCcw6K4CUWzJvmdT7ZHs8b8Oiq8
         0zZ8specE/sLfg10RlNJtZZ3GssBV6JEgkox7LpP3ieELPM8fKefW4Akrdl1+JrT+IS+
         9dmrb8PeWrE5fz50VkEyy8iZ/QjbPDKBmLwRGRDnrk80wZu62YJzp9+LhcfCFk7NQ3xH
         V6pl74sIlHR1S+1nt4CBPwMhrwcYsBYjsX25gBO8v9vvC4C/Rp2hnPjmLXlZ/L9h38IE
         jIFNi38g1itXVK/vtXzeHko1hpHvANiBN6u4mxQ0wE+Fn350x42leyIBK2ADvsuhnypV
         jhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNA8kdYHokTaZbgCxycGTpxHMrFK0cF3162sUDvHVWsoO9IjmWPIoRb+kMK2lYdlrAst/yrwGT@vger.kernel.org, AJvYcCVsC+BUgIFvhBtnz0xKPAPATJL5y4U0vOBWAOgo3pIgqxe8piyYiFOg0u/u5kQiGAZj5Gc=@vger.kernel.org, AJvYcCX4Rl1132zoNpdT9jkGaHa7sXWoXwGb0EqkMgX7AavuMuCiIRZXL7LXaJtXsheUBcUk/+O/M9TYQQ6fxwW8@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDn48VRkbrrx1rszO8Gc4IS7/jdqKJCd6kaCzhgEcEk3XCYH3
	TktJHBxtTAseqq27VfcaAnTTOaWcKiL6VJSGetHEX9G3VVoBoyviLRM1
X-Gm-Gg: ASbGncsM/wUa82JIVLOEbw9se+QZTruKd/jdb28KkitBAkDJZCDMzaYMWj0Z9G/x3r3
	4MxcQIcoLFh3xneykZ8tTpwJZI7WYQv6UvrbLD9eLSlVB09ilg8l1wdG/GFZvNAnMmDjwawYUv9
	4oG6yDh3JDAXky1J32u9MvBeHnsP9fM8xEv80hH/ina5x2QwTk8MlU2FcjNO5RXpsWE6TLFsfbz
	KFVpqo+zSXTyKVQTiw7tVVMHBntFTa3yyNjKRD7aUHRU7eVXUSbwMhLho9BGY+kBv/xX/C4jTvE
	OLUSJ76BET0dhPAxviKHsjruJ0q42UO+lCiNQg==
X-Google-Smtp-Source: AGHT+IHf3kWkZJUnkGKGDtasZxLAsJqT2XOamn0NT4qFa01M0qYWTtrfBtVc1Eqbs4sG8b8aQ7MZtQ==
X-Received: by 2002:a17:907:c25:b0:ad8:8c52:d61f with SMTP id a640c23a62f3a-ade1aab9f4dmr176003166b.35.1749197515955;
        Fri, 06 Jun 2025 01:11:55 -0700 (PDT)
Received: from krava ([173.38.220.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7542b1sm79027666b.35.2025.06.06.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 01:11:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Jun 2025 10:11:53 +0200
To: Suleiman Souhlal <suleiman@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Masahiro Yamada <masahiroy@kernel.org>,
	Ian Rogers <irogers@google.com>, ssouhlal@freebsd.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] tools/resolve_btfids: Fix build when cross compiling
 kernel with clang.
Message-ID: <aEKiyUwKGDUAs3sf@krava>
References: <20250606074538.1608546-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606074538.1608546-1-suleiman@google.com>

On Fri, Jun 06, 2025 at 04:45:38PM +0900, Suleiman Souhlal wrote:
> When cross compiling the kernel with clang, we need to override
> CLANG_CROSS_FLAGS when preparing the step libraries.
> 
> Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
> when building tools in parallel"), MAKEFLAGS would have been set to a
> value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
> fact that we weren't properly overriding it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
> Signed-off-by: Suleiman Souhlal <suleiman@google.com>

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
> v2:
> - "Signed-off-by:" instead of "Signed-of-by".
> 
> v1: https://lore.kernel.org/lkml/20250606052301.810338-1-suleiman@google.com/
> ---
>  tools/bpf/resolve_btfids/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index afbddea3a39c..ce1b556dfa90 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -17,7 +17,7 @@ endif
>  
>  # Overrides for the prepare step libraries.
>  HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> -		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
> +		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
>  
>  RM      ?= rm
>  HOSTCC  ?= gcc
> -- 
> 2.50.0.rc0.642.g800a2b2222-goog
> 

