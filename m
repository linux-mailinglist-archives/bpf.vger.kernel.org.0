Return-Path: <bpf+bounces-34899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E8E932189
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 09:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0DE1C20E9B
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 07:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E674436B;
	Tue, 16 Jul 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHMmSw4C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEF3CF4F;
	Tue, 16 Jul 2024 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116550; cv=none; b=Oirs8RByM12Wf1zZUvRL7MeSX8upmYV5EZxKdATfJtGNHjSi+Qghfz6STVx1LB9ZSNCNNGEMi/TBcxPPNt81Y/FO+K6gSzMiKLnr3NudzfYS7UGosjwnpQb3cPwf2F/0l2fZFrUe9oQeZdZLu1dbH8ujrVuHlBiAkaq8V2yIfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116550; c=relaxed/simple;
	bh=VUIIZrHzOwEEm5cB+TL42vBNtOSE9lCB8C6Ys9ONHus=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8Hc4j6u4+eho1uEkYXZumeltA/rE0VYNNOF9wN53Rb1vNxR+N/YqClQ7QXzNTWE+sDemiQ16bbqRpMFDQ655rBaPZOLsCpnnwnMSx50yjNVgiKk7XF3z6yOAfp/4X9FMMX3pVscK5NkZ/QPd4GAqwMoLIUkyF3uKgmGJPhm+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHMmSw4C; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso6677458a12.2;
        Tue, 16 Jul 2024 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721116547; x=1721721347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRFgk4J9OtsnR5pAPK7NU8AHqlcZY++xBR0Qunk1Dvs=;
        b=AHMmSw4CwHwZCEUW42IYQ46D5rIZp2EaviGKxPmayX2AxiEQNuDtfA4//ze7ietHoM
         mV8M0jSImX+RC9wnlzcrL1oz8Gjjd4e3M3uDW/SqXFxZlmTJmobOEdDshix5+VPK+7cC
         pCYn164oK0b1ASbQFfs4cb/C0S1yg3HNHqmBAqE7FXHt5RBNfOgWipfdhgxhpiStN+0T
         IegAYxL/rim3Bi2c87UJuW8k1KX5YsrCnkVfaABM8CxwQBlMKfxrTzA+PyZo1vUUx85a
         AENpKXKL4QhdnwRpLBrDKeYHhpOpTJHLcngYAJzMPMQ+4YFv1kZmicUST0wYPoFkvutR
         d06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116547; x=1721721347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRFgk4J9OtsnR5pAPK7NU8AHqlcZY++xBR0Qunk1Dvs=;
        b=G2cCsbrM2Q4vAoZQUqMRsMWr0LC/JjabSwE7yQW/oXf1yiotz4vMXqfyu/gzP+mcHq
         oFDWMBl08YPBjO7BTpN3y5gSoQ9+5Pfxafmn6msbE36FSAQuc4rgS4xlDCwCGrhECx7l
         Ya7vvgrrgoZXYN9TwOZgQ3XXvqSXH2vXwW5qj1SNKW0Ogy6ULsAQETE9HRub5WKAbhXi
         /dbqJ7Rj3muBUn5rTcRUtmpgBBx9W6N73iKM23CDE06iCrkIbrhwo+B+aLikXnDoUcRv
         dmlNodjteHzG+WihmCZeNNDt557cutGPIApvl0Ql2znRz1F6L3cu8d5co2PannTXNQC3
         moRA==
X-Forwarded-Encrypted: i=1; AJvYcCUV4NABJP3SExvO2cDyzfb1sNUAKQMsiIvV5yQ7zVBYfXc7jVAPQpZDe3xvo0D8hJO8rraHDk1gvmAxdJaMD4TZO++CsBTYrYuRTfG5VRrhzSv0+us3tDFoaDnV4yz/U/eqc3trdtfHp54pXMpKOOTBtkV2ErxMMK9eq1x1MX+E
X-Gm-Message-State: AOJu0YxZRmZzFgNWnibqj4jml5x6JECJYOSL33rEYt3BXYmB3pHp3R+4
	h6h72OBcgV2XVm/E7iH5hWup3xEnzbQyWnFp9EyVGEFquVXbw02F
X-Google-Smtp-Source: AGHT+IEpe8ipckoQcGp0wb6rgF31k/oDCBveycrdeMSjKi3vFGiQbxCBqBqGGOdNLrSHs1Px47Vxkw==
X-Received: by 2002:a50:9512:0:b0:58d:c542:2539 with SMTP id 4fb4d7f45d1cf-59eef14c81bmr792984a12.24.1721116546597;
        Tue, 16 Jul 2024 00:55:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a770cesm4428227a12.19.2024.07.16.00.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:55:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Jul 2024 09:55:44 +0200
To: Brian Norris <briannorris@chromium.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4 2/3] tools build: Avoid circular .fixdep-in.o.cmd
 issues
Message-ID: <ZpYngEl9XKumuow5@krava>
References: <20240715203325.3832977-1-briannorris@chromium.org>
 <20240715203325.3832977-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715203325.3832977-3-briannorris@chromium.org>

On Mon, Jul 15, 2024 at 01:32:43PM -0700, Brian Norris wrote:
> The 'fixdep' tool is used to post-process dependency files for various
> reasons, and it runs after every object file generation command. This
> even includes 'fixdep' itself.
> 
> In Kbuild, this isn't actually a problem, because it uses a single
> command to generate fixdep (a compile-and-link command on fixdep.c), and
> afterward runs the fixdep command on the accompanying .fixdep.cmd file.
> 
> In tools/ builds (which notably is maintained separately from Kbuild),
> fixdep is generated in several phases:
> 
>  1. fixdep.c -> fixdep-in.o
>  2. fixdep-in.o -> fixdep
> 
> Thus, fixdep is not available in the post-processing for step 1, and
> instead, we generate .cmd files that look like:
> 
>   ## from tools/objtool/libsubcmd/.fixdep.o.cmd
>   # cannot find fixdep (/path/to/linux/tools/objtool/libsubcmd//fixdep)
>   [...]
> 
> These invalid .cmd files are benign in some respects, but cause problems
> in others (such as the linked reports).
> 
> Because the tools/ build system is rather complicated in its own right
> (and pointedly different than Kbuild), I choose to simply open-code the
> rule for building fixdep, and avoid the recursive-make indirection that
> produces the problem in the first place.
> 
> Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
>  - Drop unnecessary tools/build/Build

Acked-by: Jiri Olsa <jolsa@kernel.org>

so usually Arnaldo takes changes for tools/build, Arnaldo, could you please take a look?
but still there'are the tools/lib/bpf bits..

thanks,
jirka

> 
>  tools/build/Build    |  3 ---
>  tools/build/Makefile | 11 ++---------
>  2 files changed, 2 insertions(+), 12 deletions(-)
>  delete mode 100644 tools/build/Build
> 
> diff --git a/tools/build/Build b/tools/build/Build
> deleted file mode 100644
> index 76d1a4960973..000000000000
> --- a/tools/build/Build
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -hostprogs := fixdep
> -
> -fixdep-y := fixdep.o
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 17cdf01e29a0..fea3cf647f5b 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -43,12 +43,5 @@ ifneq ($(wildcard $(TMP_O)),)
>  	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
>  endif
>  
> -$(OUTPUT)fixdep-in.o: FORCE
> -	$(Q)$(MAKE) $(build)=fixdep
> -
> -$(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
> -	$(QUIET_LINK)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> -
> -FORCE:
> -
> -.PHONY: FORCE
> +$(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
> +	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> -- 
> 2.45.2.993.g49e7a77208-goog
> 
> 

