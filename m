Return-Path: <bpf+bounces-33774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB659263AB
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD79B25901
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE217C212;
	Wed,  3 Jul 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACOkvD4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9E171679;
	Wed,  3 Jul 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017816; cv=none; b=fO5rfJlJHsUzvgF0mM9QjFuZRAZj3v0yp3uPID+YHl8rirmIuUbI1CfltPE92klqvytbiefenmR2c2s/zVoGia9xUsmXAV54JQBRCqwIQJmnofP/8eZLQ1E3HjkmSJnsyTM+IUW7N0hOvHsKB0ec3HxVJxi4o4o0/qH/HrGNHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017816; c=relaxed/simple;
	bh=JCedJ2dy+bCxmrURA/4uvroV2Nju6rmF/YqUDZ01XCM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIKL6Y4r4VCH72Vuce/jm55hS9yP7e2sUurPTogwtw6wH2wv3ecNSlAAKBBG7J04OYnhoKIB25Qq2gfNWqN8rAo2+/2OyjT8wdeA/Ijr/rgHcMrPo/lR3apGBf6dvr3gAcSZdOhWHxcU5WKX17lEdZ59304lTmYAki4cIULEatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACOkvD4B; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ee794ec046so17817301fa.2;
        Wed, 03 Jul 2024 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720017812; x=1720622612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3HHbPMKL3WNij7DmW7SMt6gomhfzwDIxl+H2uk7UN0=;
        b=ACOkvD4BwQmn6DgbsMdU6AsmtP0rXO8gO0XY1C6VHFfgiqp1WKHMLjTvCDTOobVYn/
         YyT8nHXpYdvi+zID3YIRXPKcLeOkVN32pUdMfOQTtd+SdhdhUoSid9E2QPxUdja/YbiP
         1VXp2dQPFNYzgmzhObh8ZP+dAVQyGuaSvtTe6gz040tYqqAelR4Z4VbTefiIcrUjdRNq
         Yp/CHE2t1eUODVfB+4ctxHqc6uKf5G36OB7kwFY0AJ0u64r88QkR/GKysSePvsrfEkt2
         kV/jsQqmoViOkQXifQdNQiEOEPFUPIRKkFIZxEdJ1Li6qkV25A8yjVE4TLq+ynZhcWdg
         LQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017812; x=1720622612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3HHbPMKL3WNij7DmW7SMt6gomhfzwDIxl+H2uk7UN0=;
        b=Yc+cmFaaYFQZ/c25FKeWTBmuH2s8xXYCzxJn4NIYEj3lwW2BpDt3/ZXPIDxrTjhGwI
         Bj6T4mvIdZqjNp1eakxEhyZCTAMofzoJ2NFkDLB7ePzfbV2crJuKhUV97rXbISje7yNw
         t2n5cWyJxDptvrnv5FNLOnmn1ukC2thuRh5/7VU1Fp/pPkHdKkDljaMTL/Evg/H/TJXX
         JZc7XofwDb1JIMkWqEpsoaFEosjcL/J38oxNVbDzTRI4eE9hjf0/4ErL1VMlMIqKMVJ/
         7Yia8WFw4XnGI21xxXrhnscP9s6B9fRruSWz+9qhe8/YCG7649bDzaRLamRqkfA1xQxb
         +3bw==
X-Forwarded-Encrypted: i=1; AJvYcCWYsY1HoiW6x4Nm6B8P5v1rygDNCWiyc5/6DV4JYPvrCXv4ggz9+F1gE1ZWWBtn7+BuF82P/vnY8OLPErB6RWbf5nDoqK+JJfhCA8pI/MYRe71+r5L0Owl5gQUPz0Cacsz/HzBmo5LUPfwQlEBR7WW+r16VP2LRrFF1nBT0MmT9
X-Gm-Message-State: AOJu0YxVhAeqexdoQdHCQc6kp8CnGE6tDIpob3xtDgd9NSSCqUti+1in
	620lknLFxrLrm9VeaFCi4u1C8oUExm08DXAKgVFwWLViTTFzgc5l
X-Google-Smtp-Source: AGHT+IH0WrGBa4Zh+77cHbvKIKdlVlFNpd3eqtxLFlpSO/J4CvZAMFTPNa7djzYt0xpU2vOvZHukOg==
X-Received: by 2002:a05:651c:2229:b0:2ec:637a:c212 with SMTP id 38308e7fff4ca-2ee5e6e7256mr85801971fa.39.1720017812064;
        Wed, 03 Jul 2024 07:43:32 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9f9dsm16025724f8f.41.2024.07.03.07.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:43:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 16:43:28 +0200
To: Brian Norris <briannorris@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tools build: Avoid circular .fixdep-in.o.cmd
 issues
Message-ID: <ZoVjkIG83Bk2QWPE@krava>
References: <20240702215854.408532-1-briannorris@chromium.org>
 <20240702215854.408532-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702215854.408532-3-briannorris@chromium.org>

On Tue, Jul 02, 2024 at 02:58:38PM -0700, Brian Norris wrote:
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
> (no changes since v1)
> 
>  tools/build/Makefile | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
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

ok, looks like that will make things easier, also we won't need tools/build/Build

thanks,
jirka

