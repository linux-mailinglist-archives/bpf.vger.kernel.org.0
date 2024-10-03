Return-Path: <bpf+bounces-40825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA798F00C
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED4E1F2133E
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC971993A9;
	Thu,  3 Oct 2024 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW2B9l+Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357521494DB;
	Thu,  3 Oct 2024 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961048; cv=none; b=a3aC2i6womLUqu2iV7gnOpHWnS9v3W1HzEiQULGPm2vFZ1aKsJ2TLv2K3Ad4Kk+YTsic0byOIBPiMmYZd/RsZ7Fpdim0xiapz05la50cb196kYeRelDPrC8fW4s7JsZzzOkyfSaaxVOy5UMOM1rf4/cHgLjINaF72R9zbWIvnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961048; c=relaxed/simple;
	bh=yuxjLycDXsQA+qYkMSBlLIsX07+Dt7QGQjM7iyBv7rs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrvUmZ6ChvoYSJw3sdsQi5OrBI+tOLkx4PFLI11b126hoP584VhcHTy26Jm6huE6Z9KKzfaQ3AX5Ujv4grYxL0JwFl/IoHo8Dx3TCPVD3SALpGo2wTM2HqG5G8IQo1qTiTwy1+4dH4krwD06cDbiFZ1fyk2QITj/JTXwH4qIflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW2B9l+Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so9122235e9.3;
        Thu, 03 Oct 2024 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727961045; x=1728565845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnbhvdPe3iaI36lNxaNUpqLVXCvUoB8O9XzWj2+gJyY=;
        b=aW2B9l+ZZKNRjR2HUwIcnCsqBHys7YxfmRZ6vfcv8F8M2tJdxSkGXfAbc2qRvCxa5Q
         l6bEbiaToVQdc/0MoexEVlmY00D3vlALYHuz/+kRIN2VPrIC4IEPRZDa++xP0hoPud65
         vdBEUOuKCWL16W+RMkBW+mS78eKYPtso1GUBS/oj7GoI9lBG5qfBLbvepvQ9DP/sBOnZ
         /XbeZzkqF+tfY225TTmWhko868F55JIGdRnaS7oAyAhTPS/qtwJitdXGEiPt7AwL7TlN
         MzJs5wqR6JYpHedOLB2Yev5VebpcOU8d17kGXJMBCKJPtkDzHJp1sjtiKInN6SOAS2x/
         Yigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727961045; x=1728565845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnbhvdPe3iaI36lNxaNUpqLVXCvUoB8O9XzWj2+gJyY=;
        b=xAeT5c3oduHBpZLSC1OirpBT5P1j9QYqx8HEDESkkoyGNWV+OeYQ6bs2LKpqsAfV2q
         FhT8r18UlwC363/UpgEOwcaywwr80qtPyS7cNe1BHt3AsuNLbIIuk5HK3qG4kyvxe89e
         8GHJn1DzZ2N+/2qkMIzgUxDKvWTgbUWjFjp0+ZOiGolQF2mLuNXUs4lOLusdnV7KsVLP
         e9d3nehdjkQp6QHiGazrmmeHvkz2k4FeLPjZMMsPBMhWxUTjkyeym4x2oHOKRUo+nbYn
         UlA5u09lN2dxvE+vozScogyiHq8pLGlIbaf23nDuFf8z5uxAXNqy1mDqc7TPdfj4Ydpa
         qmqg==
X-Forwarded-Encrypted: i=1; AJvYcCVjOIylwhTbWSmqtdEwCGLKnJZKEpzZnroOu9ROJ9s+lBMMOg8uwi4SEOjPOh7fIOlbJ1UuLJXH2Q==@vger.kernel.org, AJvYcCXmWzLtfpKkgPsu4kZrBkwM3iO0f9Z2sBgsFIjDlxz//sFANShSpSeauRr0WxwNH6F5Bmk=@vger.kernel.org, AJvYcCXz6ANZW0x54W3C4KWKn6D7PD9JKumHow833iEBg71L7Q6XumBxoPiU5ExF4uDY4UqL/Rc8pd5FZwEr7MYWrMuz@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLPsYf7i/Jaa6ipmGQ0VsPpGwhwrruNo0Yq1rP0fX3WsUyzhO
	FH94Xnc+MvWYqnwF8977TqbvcdUYYo16dDqANO/jnt7P6SMjEUPX
X-Google-Smtp-Source: AGHT+IEkgd3jUCKaAPTey36kBSrlRa9GArLpAjS7bdp1xh77A485iF+9L4nC2+4CuxYTudICwe+oWA==
X-Received: by 2002:a05:6000:18a3:b0:37c:d522:af7a with SMTP id ffacd0b85a97d-37cfba04c24mr5138287f8f.39.1727961045067;
        Thu, 03 Oct 2024 06:10:45 -0700 (PDT)
Received: from krava (85-193-35-211.rib.o2.cz. [85.193.35.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a01f2sm15296725e9.30.2024.10.03.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:10:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 3 Oct 2024 15:10:42 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: add global_var feature to
 encode globals
Message-ID: <Zv6X0ij1UXhFq2CW@krava>
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
 <20240920081903.13473-5-stephen.s.brennan@oracle.com>
 <Zv1VQ0G_GpwCjjie@krava>
 <df3c21d4-9f42-4681-b7bb-78134f430f1c@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3c21d4-9f42-4681-b7bb-78134f430f1c@oracle.com>

On Wed, Oct 02, 2024 at 04:11:23PM +0100, Alan Maguire wrote:

SNIP

> >> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> >> index 0a9d8ac..4bc2d03 100644
> >> --- a/man-pages/pahole.1
> >> +++ b/man-pages/pahole.1
> >> @@ -230,7 +230,10 @@ the debugging information.
> >>  
> >>  .TP
> >>  .B \-\-skip_encoding_btf_vars
> >> -Do not encode VARs in BTF.
> >> +.TQ
> >> +.B \-\-encode_btf_global_vars
> >> +By default, VARs are encoded only for percpu variables. These options allow
> >> +to skip encoding them, or alternatively to encode all global variables too.
> >>  
> >>  .TP
> >>  .B \-\-skip_encoding_btf_decl_tag
> >> @@ -296,7 +299,8 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
> >>  	encode_force       Ignore invalid symbols when encoding BTF; for example
> >>  	                   if a symbol has an invalid name, it will be ignored
> >>  	                   and BTF encoding will continue.
> >> -	var                Encode variables using BTF_KIND_VAR in BTF.
> >> +	var                Encode percpu variables using BTF_KIND_VAR in BTF.
> >> +	global_var         Encode all global variables in the same way.
> > 
> > hi,
> > I tried to test this but I'm not getting DATASEC sections in the BTF,
> > is the change below enough to enable this in kernel build?
> >
> 
> Yep, that looks right to me and it's what I did to test with kernel
> builds. For me that was enough to get datasecs and all global variables,
> but if it doesn't work at your end we can take a look. Thanks!

I managed to get all that by running pahole directly,
will check it closely with the new version of that patchset

thanks,
jirka

> 
> Stephen, maybe for the respun patches we could add a note to the cover
> letter on how to test with kernel builds? Thanks!
> 
> Alan
> 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index b75f09f3f424..c88d9e526426 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
> >  else
> >  
> >  # Switch to using --btf_features for v1.26 and later.
> > -pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> > +pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,global_var
> >  
> >  ifneq ($(KBUILD_EXTMOD),)
> >  module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
> 

