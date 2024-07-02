Return-Path: <bpf+bounces-33591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B19291EC5D
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 03:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8BD1C2146C
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7244A06;
	Tue,  2 Jul 2024 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfH4ROsX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80894883D
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882686; cv=none; b=u9B08RvGw+4LY3JBSHZ/mZkqrAJDirU8m6pMigg9PJnnDu35TureTgoo/e1AGU6KdsXiDuTDYmCiBot8VUTLkNGIfiDvy3dlhmc4D1CSN2NbO32M1NRcmxzQrH97SoST+GUzbYEoMYlVS8orbuX489VtGbWFQDVKxLq7L5Eklpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882686; c=relaxed/simple;
	bh=biT3U/JccAbT2ojx0tZxE5iP92A3N2y/C6UXL+enRrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsGhjwL7Qe21e8ca58ewPRIoDQ+g2lbkREzjwGWIsNPrh/M5pLdTMV/UhURgFw6LASFixyNjJpqR+R4EjQap8qvxUzmHupSmdGXE0RLjn93DEZ8jsTGcv1kc676yZIM72Vl6fXvMdqjTqcJBz4qXzQWsImeO1qacJhMc5j7SaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EfH4ROsX; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3738690172eso17482685ab.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 18:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719882684; x=1720487484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uX6X6yvrHwqLhmQHKxP9UTvaXr+RRFTXVS2da0ydaXo=;
        b=EfH4ROsXN6xs5exZDDyginzKlAnuc5tTQc6L6dNV6gUYfVSK2yg9uQE/ioZng5QScR
         MPeHYLAqCm543JDTpPtLqa+DMM+Q/l/2BQdDNMd7C0Tz4a0WMl+09B62ORLg4XhPEGH4
         FO9DJBN3rkySrW+7hsUAVVeSJt52apMan4WBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719882684; x=1720487484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX6X6yvrHwqLhmQHKxP9UTvaXr+RRFTXVS2da0ydaXo=;
        b=vz1ro5kNDHMLV23DixwTZIf9mTmgnw+Bzs1wA+8GqQXqL/0DPwMIGAB00mx7yBH62f
         mbbf7dqRKA7sjM52jRcicauA/uqZqS+/TtQ5FtcNNjU1d4arZRdpWTlPNK2WTgD2vdv8
         P4iQS7WKcyCuB7jijJhUXjY/edQ0kWGMjEPjYvZQjzCdH8hdr0yUMhYD3xAxpmUF/8u7
         vmks4NssDYnBfEzybAE8ftp6ZIMMIr+ks65lWTMpI01SqKwP+MMOHsWPCyYRneLUiXPs
         K6inLZcEC8RNyfvNi6Cz7AbFzDKmjWBKgG1TWvV6/OeMhnB7vOGyTccrf/fVbZofXNVq
         Y0nA==
X-Forwarded-Encrypted: i=1; AJvYcCXOObxCXeq4gaZguZk7gssoi5AH08V75l2ZNMpAQtZiWFlRMZVDyOQSbK1Gkco1BV5z4ARdDueBCS38vUqBEHY2R02f
X-Gm-Message-State: AOJu0YyiIDrTH8++QGQxhsLfVPCGbZnmwgno69o9ICThGhkDYQ37inWj
	GQzaSTGLtON2XFK3KYpwzKK7Y0Qh97Z20hz1CTX3F9162ERs/Gd4SwExP3Aosw==
X-Google-Smtp-Source: AGHT+IHKvM67M6eFvhtx26GdTIevtvHk/JUwsJ5jHaRe/vO4GAOUaipYYggq2lOfLdjdexOoMh93bg==
X-Received: by 2002:a05:6e02:1d1c:b0:375:dad7:a65e with SMTP id e9e14a558f8ab-37cd2bed7a1mr105954005ab.24.1719882684580;
        Mon, 01 Jul 2024 18:11:24 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:32ea:b45d:f22f:94c0])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-708045a69a6sm7187177b3a.165.2024.07.01.18.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 18:11:24 -0700 (PDT)
Date: Mon, 1 Jul 2024 18:11:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 3/3] tools build: Correct bpf fixdep dependencies
Message-ID: <ZoNTuvhq3tSNpXT4@google.com>
References: <20240702003119.3641219-1-briannorris@chromium.org>
 <20240702003119.3641219-4-briannorris@chromium.org>
 <CAEf4Bzbxu_PJsDE_ex_FBi+SKnWZjVA8vA11vL2BxUhyBB6CAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbxu_PJsDE_ex_FBi+SKnWZjVA8vA11vL2BxUhyBB6CAw@mail.gmail.com>

On Mon, Jul 01, 2024 at 05:50:35PM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 1, 2024 at 5:32 PM Brian Norris <briannorris@chromium.org> wrote:
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -153,7 +153,11 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
> >         echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
> >         $(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
> >
> > -$(BPF_IN_STATIC): force $(BPF_GENERATED)
> > +$(STATIC_OBJDIR):
> > +       $(Q)mkdir -p $@
> > +
> > +$(BPF_IN_STATIC): force $(BPF_GENERATED) | $(STATIC_OBJDIR)
> 
> wouldn't $(BPF_IN_SHARED) target need a similar treatment?

Hmm, probably. I'll admit, I only debugged errors that show up in the
top-level kernel build. The only tools/bpf stuff tied to the top-level
build is resolve_btfids, which uses the static library, not the shared.

And now that I poke around at some other build targets, this highlights
that my patch introduced some problems with the independent libbpf
build. Particularly, $(OUTPUT) is a relative path in some cases, and
that relative path gets interpreted differently in recursive make (when
we change cwd). So please don't accept this patch as-is.

Brian

> > +       $(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(STATIC_OBJDIR) $(STATIC_OBJDIR)fixdep
> >         $(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
> >
> >  $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h

