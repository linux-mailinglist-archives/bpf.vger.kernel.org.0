Return-Path: <bpf+bounces-18044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4AA8151E7
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85C51C241D2
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C647F6E;
	Fri, 15 Dec 2023 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL5Xiodo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1282ED1
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336447f240cso729710f8f.3
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 13:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702675547; x=1703280347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qv6K56UfOA2v/91pnnPCmeRYUwRiLoxwDl7rRkRE1mk=;
        b=lL5XiodoucXoMS4B1wKVMkEHqXHx5GDJJ4crMNJt7k5/qMnggPTguVhgNxj1yasoqz
         V0au3uDbvZds+80WDFGOYWyxE5xbWSM1qRqqtekVirKB8GMpUY8brVUbkm0361ipClPt
         en7qUauT26l2CUpFPxLK2+xn+fbDlrwxDwTfQManqzaej7exW06jHkPcndExzqxyjyCU
         Rj0meb+QNZs+xf53AaRVlbZodUzfnxlvgSxRayJiMjxieWJRpTebejZQgCzNb44Dlwab
         wsGZTp27UTdx+2QzVgYEFa9SsOij8t6l7/DBCS2xxzIagyea1tFDS3VF8fX41TlAMDij
         4lsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702675547; x=1703280347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qv6K56UfOA2v/91pnnPCmeRYUwRiLoxwDl7rRkRE1mk=;
        b=r0TZ+zFSQfPt/LPX1H6vX0DeKQbbb0uz+cd/dSumaU08tCydgDTlwARLsyNC13rgVQ
         SO2AJqgKKuhQaSptlJw2klN1nmbJAHmtUM8O4Q1rz7qd2avaCrxOmn4EkgsHjtNj7E6e
         UdFwQFIYEtqOMkWOVnJS9nmU/PWl6cJ7oGMJcPb4lFWohzJT1xerjQKhdXyNAmIQgnlw
         xwFoXiykeQ2YFZe+WIV3QZWxr7vmkDCFqN7TOkL982rkufqSziXOw4XfJQYU/NYNRsnj
         KT2ynuKqTAncGVC2Qcjlw72ZERupuIMO/iNR8b7ayswacG4Uk6iDjoUGlB21hXOEFqLj
         x6Ng==
X-Gm-Message-State: AOJu0YyUuw28In9xcP0wPrFuctpX10Rk3URWD86hM6SOQ6QFO1hxGEPQ
	HK4MxKjtJl4Zylr/sKupL2g=
X-Google-Smtp-Source: AGHT+IEOxlBI/AXTFq+Ewh+jH4Rg827kK3li5kBPPxmR9HTcjZ+68LDFNZc1qXUjc1HHxfZMqTi7nw==
X-Received: by 2002:a5d:474d:0:b0:336:48e3:8c7b with SMTP id o13-20020a5d474d000000b0033648e38c7bmr1931238wrs.140.1702675547131;
        Fri, 15 Dec 2023 13:25:47 -0800 (PST)
Received: from krava ([83.240.61.143])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4d01000000b003365aa39d30sm1261486wrt.11.2023.12.15.13.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 13:25:46 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Dec 2023 22:25:44 +0100
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v8 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZXzEWIDDKPmYRz06@krava>
References: <20231212195413.23942-1-9erthalion6@gmail.com>
 <20231212195413.23942-2-9erthalion6@gmail.com>
 <ZXxnLzhAFxwepM_7@krava>
 <20231215163621.np4kmz324opmopb6@erthalion.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215163621.np4kmz324opmopb6@erthalion.local>

On Fri, Dec 15, 2023 at 05:36:21PM +0100, Dmitry Dolgov wrote:
> > On Fri, Dec 15, 2023 at 03:48:15PM +0100, Jiri Olsa wrote:
> > > +	/* Bookkeeping for managing the prog attachment chain */
> > > +	if (tgt_prog &&
> > > +		prog->type == BPF_PROG_TYPE_TRACING &&
> > > +		tgt_prog->type == BPF_PROG_TYPE_TRACING)
> > > +			prog->aux->attach_tracing_prog = true;
> >
> > hi,
> > this still looks bad, I think it should be:
> >
> > +	if (tgt_prog &&
> > +	    prog->type == BPF_PROG_TYPE_TRACING &&
> > +	    tgt_prog->type == BPF_PROG_TYPE_TRACING)
> > +		prog->aux->attach_tracing_prog = true;
> >
> > other than that the patchset looks good to me
> 
> Never thought I would have so many troubles with code formatting :) To
> make sure I got it right this time, this is how it should be (with
> explicit vim-style tabs and spaces, last tab for "if" predicates is
> expanded with spaces), right?

right

> 
> +^Iif (tgt_prog &&
> +^I    prog->type == BPF_PROG_TYPE_TRACING &&
> +^I    tgt_prog->type == BPF_PROG_TYPE_TRACING)
> +^I^Iprog->aux->attach_tracing_prog = true;

yep ;-)

> 
> Thanks for the review and patience.

thanks,
jirka

