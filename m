Return-Path: <bpf+bounces-45706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9E9DA738
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8AA163B1A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6291F9EA7;
	Wed, 27 Nov 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBTvoZlk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F601917F1;
	Wed, 27 Nov 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708443; cv=none; b=kFTFtfS7dU9cmaCZ/xGvZEKfEdsAlEbbZXB0PigIrMDwrOsbbnSN2SARpZnKYlNsDEeyRj/I03JmPUVAkWpDRzwyUAkDFzSsfXMMaBbRynmvVPYr+x3ijGmtgHwI6oTZ6ercP0M4pZGwGtED1LHTgdsMTF5o8KxmT2BZjZhXLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708443; c=relaxed/simple;
	bh=nJcm3Dr5W+UBk3/8uwre6xyM1uPvek7SHuUpICuoy2k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN7KNNYovJbFxIxMOKpB2zPuoMsi4pK6gG2R3ic0EG118h9eXlAwLrS0LrT2BMvL+TtEQ3S3+zpNFTn8pGZpkRrobK7ieQNszcinzDVF8h9iRJjINhKw7rE2hgiBn/w2P9V2P+kVtWrI834XbpvluQ5ObHkLBr4zHwrNRH78xDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBTvoZlk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so49897731fa.1;
        Wed, 27 Nov 2024 03:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732708440; x=1733313240; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OOs9KrZ8bmGuTWUf23U0G5It2JNzTdjZoc7pAW2KegU=;
        b=eBTvoZlkohLgpyjePBC4M8osjJRfspStHXgbOIzsrx9WjegzILngVXITXEYtZ9H5RR
         tZ0GDedSDfhWYPb6XFsrSHFNDNmfB9PDmiMMwwBcaQonphBrcrrjeZa42n+ZtUrAGAkQ
         3yOZZ/25rF8tWcHSE0Yv04h5vNZvfCjdbzW8Zd9sEYs9ZStvVQSivOKL1vHyz2Pms+NV
         IliOc6Sm1wQDKG0awB5eB0OZbqVI4RsaXW5AxL9D1+aTLihEurMH35Mj7wVjEkyeFASq
         8ZBNzv7ziZ0wy/wcmuzLqrn2OtbjXgfti+JF6pPIRJmSmLIUbrn3xCeQQe9MRUVBYcz2
         u0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732708440; x=1733313240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOs9KrZ8bmGuTWUf23U0G5It2JNzTdjZoc7pAW2KegU=;
        b=vz05qMHbR37GMM7sPEYcPVi/oRiImZwFoybhjqMl29qa4O9gahjZJjMh1cwJ4D2Uoe
         hYNBjx2tmYaWfPoakdwuLHBKeQ4+CM+23recTDzR8cw0IygMeQiKvfnjZ4aLSAkn6xUy
         o+7zMh76R9AYnGjPzZM+iwEUSWvnlknhhb1qYPxn6zwD9x/6T2iY5dtM9sRmOVgqHLHc
         A3mpD5E8YXmRixpZgB7KjQBY2Jgccy+ytjVfI4ttLVBocFW8CWvnWa1hcnmY++doA6T1
         fmSAYT9/K3CQlBQOqM+i8ZWAW8JUe2f6FJYZeXE5ns0TVtAHFX1Em5g0RjST2HESCE1O
         6Zow==
X-Forwarded-Encrypted: i=1; AJvYcCWbz5q/dNt9XFZ88c6fAk5Ku/Pp4RV2QDvl8ZRRNlwXxtY41R7IBRF18mS6TJvtfjeKqmz18ObvUvm0RvIQuKYDkw==@vger.kernel.org, AJvYcCWsgV9JH0/L6v90opK4alq1LnNaAszUTu12RP0ZOXkWp3xnGOR/dViRCN3q+7gGVJrrDyrZSZlLuwlB6xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4zt6nPZ23paXYKXwsEvb0RsA58GfuTZt+hxZM8EDthmgTWA3
	t/l5Fzqi9Ga7xeyE9U4zFyCLIqWqA8NNjp+6MdQ02eduKnbOJZao
X-Gm-Gg: ASbGnctFr5e8i1yeKi0UEnExcP45BhH0G98BWyDH6ZGRsbUIk1iN03oapstaHo4SfPI
	Nz63eI6m0pIsOY+ig3Z7oiifsH9H/BkVMVGvrr8SeYSz1BwahXjvuSUjqu3p8cN0DvEfdGVjCFe
	aoxMUrFOSjQVbddYbHbBWbhU7HGyomJ0kvjFsbdR/aClkRkm6wO20QCu6hFuHuU7J+YA4ajkpYO
	xupm+IBS4giaKLDi+thOeyTEME4OyGxJCYMfSdpY6xtF4e7jtAg+MCcUk9F4fosCmHyCpEtk1Iv
	mS2dgPbLuaLamotcKJ31eaI=
X-Google-Smtp-Source: AGHT+IEdZzPpvtt5g2veZ28kg3Tnjg7fOynNz8QbLn502RI0VK50895DSX0/X2Tm45sPeRl6qJx+cA==
X-Received: by 2002:a05:651c:b14:b0:2ff:5c17:d57d with SMTP id 38308e7fff4ca-2ffd5fcc09emr22424751fa.2.1732708439476;
        Wed, 27 Nov 2024 03:53:59 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5372002aasm539318166b.66.2024.11.27.03.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:53:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Nov 2024 12:53:57 +0100
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Quentin Monnet <qmo@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Abdurachmanov <davidlt@rivosinc.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH bpf v2] tools: Override makefile ARCH variable if
 defined, but empty
Message-ID: <Z0cIVfgdU5XDoa7g@krava>
References: <20241127101748.165693-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127101748.165693-1-bjorn@kernel.org>

On Wed, Nov 27, 2024 at 11:17:46AM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are a number of tools (bpftool, selftests), that require a
> "bootstrap" build. Here, a bootstrap build is a build host variant of
> a target. E.g., assume that you're performing a bpftool cross-build on
> x86 to riscv, a bootstrap build would then be an x86 variant of
> bpftool. The typical way to perform the host build variant, is to pass
> "ARCH=" in a sub-make. However, if a variable has been set with a
> command argument, then ordinary assignments in the makefile are
> ignored.
> 
> This side-effect results in that ARCH, and variables depending on ARCH
> are not set.
> 
> Workaround by overriding ARCH to the host arch, if ARCH is empty.
> 
> Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> v2: Proper tree tag "bpf".
>     Collected *-by tags.
> 
> Andrii,
> 
> Apologies for missing out the tree tag in the patch. Here's a respin,
> and thanks for routing it via the BPF tree.
> 
> 
> Björn
> 
> ---
>  tools/scripts/Makefile.arch | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> index f6a50f06dfc4..eabfe9f411d9 100644
> --- a/tools/scripts/Makefile.arch
> +++ b/tools/scripts/Makefile.arch
> @@ -7,8 +7,8 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>                                    -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
>                                    -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
>  
> -ifndef ARCH
> -ARCH := $(HOSTARCH)
> +ifeq ($(strip $(ARCH)),)
> +override ARCH := $(HOSTARCH)
>  endif
>  
>  SRCARCH := $(ARCH)
> 
> base-commit: 3448ad23b34e43a2526bd0f9e1221e8de876adec
> -- 
> 2.45.2
> 
> 

