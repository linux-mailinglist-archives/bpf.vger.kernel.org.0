Return-Path: <bpf+bounces-28129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E38B5FC2
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A981282441
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C286653;
	Mon, 29 Apr 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sgbkYWiU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936284E1A
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410695; cv=none; b=pJrpdPhwOtTsu088sIJIBGTdAv+8YjQFZGeIzz3ubKrN6ndcqWRCqAibEAq8DF04MTDY/JW4aarXqUHkuHkIJBRDCKvIvizxjr++TD797PK54k6nx0vyD+iaXxeGhU7RK2FyeB3vU5KG1aZAp1i4BloGl750fiBbbV+Jpa3qo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410695; c=relaxed/simple;
	bh=gHKyucjbhj8cfFBnv6FeWZ+CCqaY0W6eus79r1bDca4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu9e6McdgTsXqfTrRkbRiGXIN+eIhXV8SLphPkfs/vjMAl3RcF1N+Mx0Aw2BcoHbo39sa/NFeq1TpTfRDSrnglngC5x1G3lOWfRQwSAgFKk6pJjoU1PzOg+gq3v8O2JIIVPLGj4zeo3RlRIxTHZrcxFj+rHFMUiL2zVl06aOe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sgbkYWiU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34d13789e2fso921754f8f.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714410691; x=1715015491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RYAqBXsNEvrSMnv0mKSil9XtJ+T/DO6BwhlxG7738Uw=;
        b=sgbkYWiUhRKgWieli5Dji3GWJ+NeTrPzU62B2/jZHn9HwRvae1xhVr75BKT7u+DHQg
         uiC05d0TelGfUcLZrpLvnVa7OcZuzDf/ppVCsNh1R6dHj/N6ZlT8ESmEIWcn6eA8/njn
         wideUNKCIiWPHzIJ7LsfhFBX7tsg+o7pTXMwRvnNhDr/eKDsrDgUpaBZV/TkvYqr7Fzi
         6hJ2SmnB+VrbKGKLHFh7PuR0DyNuueZxBrxmcPKh2gdQNTSTQl3Myehswnm4XMMW/FRI
         tBWvUqv+0GeHdpJD4VoYYQ1Uwnvpx/RID3dx8Mk7GbUH8w2uyKG76gLA/4jzGoF/COog
         2vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410691; x=1715015491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYAqBXsNEvrSMnv0mKSil9XtJ+T/DO6BwhlxG7738Uw=;
        b=Q/o2BY/8vqluBWi2m6iDP+VhSqtLJBShCzySQsWMTpFqhh50tz+ybzJkBp0A2SVlzE
         8Mhv4C0QtdTLWS65hiJ8ubSRP539yGyWkqvEK9grNhWl2K2ielbZOjJvZx39NILXSDLS
         Q+T7TPShyjVyFo2iWCEO2iS/O9pE7EURZwvDtoQvGVyWvUPxKeHo+njBF/2yB6Ei9aG/
         T/d+o3GpI670CYohLIS+XPA+sec0m64J74unJObvU8+4V9LhL4lyLIo0O8pd2lkuc/P/
         GMyQZuPZodKzZwkuPfrK9/Upot5wkn5xFjOo4FjkMq9dro2eMPjI0TBtFo0ORoKdDP6S
         b7sA==
X-Forwarded-Encrypted: i=1; AJvYcCX+FRTwX9rOLlHkhYpVSd94Te9HnkFjIGTVCSjefChfESLK3FKACV4DjMAdzcPVJ3p67UlEM4EMGJbewW+ERdziEXot
X-Gm-Message-State: AOJu0Yw3hl8nJ1bJ55e7naXjxCfSlteN/K3idDkDDgNMva5/Qeixk/x1
	bUnWmN9JvKVXOkJIc50UWXiNGtG+idOG+PHmg6ym88Z/8PAurKplcfkFC2YnZCw=
X-Google-Smtp-Source: AGHT+IG8umBD7o5FzAImUqAN8DYBJskAD7XTKjpSpsopHoP+FSd3CORx51YP8n2Ws0Pw8hnEOok6ug==
X-Received: by 2002:a5d:45cb:0:b0:33e:7896:a9d7 with SMTP id b11-20020a5d45cb000000b0033e7896a9d7mr292530wrs.67.1714410691396;
        Mon, 29 Apr 2024 10:11:31 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d6207000000b00346f9071405sm30075412wru.21.2024.04.29.10.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:11:31 -0700 (PDT)
Date: Mon, 29 Apr 2024 18:11:45 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] tools/build: Add clang cross-compilation flags to
 feature detection
Message-ID: <20240429171145.GA241057@myrica>
References: <20231102103252.247147-1-bjorn@kernel.org>
 <ZUOWcXDpCOzxbFW0@krava>
 <87o79wxvnu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o79wxvnu.fsf@all.your.base.are.belong.to.us>

On Fri, Apr 26, 2024 at 12:31:17PM +0200, Björn Töpel wrote:
> Jiri Olsa <olsajiri@gmail.com> writes:
> 
> > On Thu, Nov 02, 2023 at 11:32:52AM +0100, Björn Töpel wrote:
> >> From: Björn Töpel <bjorn@rivosinc.com>
> >> 
> >> When a tool cross-build has LLVM=1 set, the clang cross-compilation
> >> flags are not passed to the feature detection build system. This
> >> results in the host's features are detected instead of the targets.
> >> 
> >> E.g, triggering a cross-build of bpftool:
> >> 
> >>   cd tools/bpf/bpftool
> >>   make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- LLVM=1
> >> 
> >> would report the host's, and not the target's features.
> >> 
> >> Correct the issue by passing the CLANG_CROSS_FLAGS variable to the
> >> feature detection makefile.
> >> 
> >> Fixes: cebdb7374577 ("tools: Help cross-building with clang")
> >> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Waking up the dead!
> 
> Arnaldo, Jean-Philippe: I'm still stung by what this patch fixes. LMK
> what you need from me/this patch to pick it up.

I guess the problem is these files don't have a specific tree. Since you
mention BPF maybe it should go through the BPF tree, in which case you
could resend to the tools/bpf maintainers (and "PATCH bpf" subject prefix)

FWIW the change looks good to me:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>



