Return-Path: <bpf+bounces-18010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8C6814D50
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A571F251F8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 16:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57D3DBBB;
	Fri, 15 Dec 2023 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdrd1LrA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1CF3DBA2
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so106070166b.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 08:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702658406; x=1703263206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oSbvyTjq6JivkqniOCi5yIzShOSA2Ci1jzGwP/cBVw=;
        b=Xdrd1LrAJubnkO5OD8fancLwo36LqL9/hsqhiDAIx+xunrXVVjMkrV2LcgJTgbf4h4
         1Wdbi4clhWj6oS5XNmPeltFk704yLketN/3pTznGcvpqIbqYQF65zJv/RQi7rbaulPyr
         oOw0KJM3chc5lAeny/KH/f7s/lGJpuaRW0GWGtO6anCymHy3AXip+JBRj3XnX5FISLm3
         xbITwCKBoi2H6n2ZBvs+n2Nyn+hAB0w1srZewsWEB4TL0X0FDI0DQ4LQCd3lrbQg/abY
         hK9ZPPthMRbNIFBQuSGUzY8sYwFpLdPCfUOsZ1ZxhzI7UX8a9Y7+KnSEoRHEef4mhg7k
         oWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702658406; x=1703263206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oSbvyTjq6JivkqniOCi5yIzShOSA2Ci1jzGwP/cBVw=;
        b=w/iPIAu+H8vJaqDL8tI/eIPzgyDh88AKYtMTHpGpq5Cr6UbQ+KpMhVgBi+hlUrNo8h
         UIXzCQISV+4sNvmlo/Vci7G+KJTEgr2LhDHsNZNew92Qgz+anwL3f+oxE8J45EAR/Ofo
         DRZvnU+9WHTsOLyNxBRsTWuja+0v5Is/prCxYYeOgh3zQvIiJeuvGLtIxlm7a6e2OZwM
         2fWTYnMWrLn2TtibY6wTL/Xrb69V18l6OTs/4gpi0GtjmgELOXYj1JBBqx6lDspzw/mO
         ahKMTh326+FDwd7qnjwAl6IHBfsTYRy+14MrAh7Ecz+i8pwYUWhKo19ZIk3/c/zRvxyA
         0IHg==
X-Gm-Message-State: AOJu0Yz7urT6aSaP4AaZTCYMbovsL8P0NaWOnEGhXJck4qblZnuzoHET
	gazjnJfVKTW/0JM3If1XWTZW4M+G3s51FA==
X-Google-Smtp-Source: AGHT+IEFmzxJ7GyHCmkjCX7cAyzz6v9GrqCHEiYx9zR23MWgN083Oo3ikh5KIDY3D8iyA+wH5AyueA==
X-Received: by 2002:a17:906:1042:b0:a22:e690:f09f with SMTP id j2-20020a170906104200b00a22e690f09fmr3502014ejj.143.1702658405421;
        Fri, 15 Dec 2023 08:40:05 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id sf22-20020a1709078a9600b00a1ca020cdfasm10904151ejc.161.2023.12.15.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:40:05 -0800 (PST)
Date: Fri, 15 Dec 2023 17:36:21 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v8 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231215163621.np4kmz324opmopb6@erthalion.local>
References: <20231212195413.23942-1-9erthalion6@gmail.com>
 <20231212195413.23942-2-9erthalion6@gmail.com>
 <ZXxnLzhAFxwepM_7@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXxnLzhAFxwepM_7@krava>

> On Fri, Dec 15, 2023 at 03:48:15PM +0100, Jiri Olsa wrote:
> > +	/* Bookkeeping for managing the prog attachment chain */
> > +	if (tgt_prog &&
> > +		prog->type == BPF_PROG_TYPE_TRACING &&
> > +		tgt_prog->type == BPF_PROG_TYPE_TRACING)
> > +			prog->aux->attach_tracing_prog = true;
>
> hi,
> this still looks bad, I think it should be:
>
> +	if (tgt_prog &&
> +	    prog->type == BPF_PROG_TYPE_TRACING &&
> +	    tgt_prog->type == BPF_PROG_TYPE_TRACING)
> +		prog->aux->attach_tracing_prog = true;
>
> other than that the patchset looks good to me

Never thought I would have so many troubles with code formatting :) To
make sure I got it right this time, this is how it should be (with
explicit vim-style tabs and spaces, last tab for "if" predicates is
expanded with spaces), right?

+^Iif (tgt_prog &&
+^I    prog->type == BPF_PROG_TYPE_TRACING &&
+^I    tgt_prog->type == BPF_PROG_TYPE_TRACING)
+^I^Iprog->aux->attach_tracing_prog = true;

Thanks for the review and patience.

