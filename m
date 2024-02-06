Return-Path: <bpf+bounces-21307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920A84B58D
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 13:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A531C23E70
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16D12B142;
	Tue,  6 Feb 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ0MnUrv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B5B1EA80
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223821; cv=none; b=miU99wX6ELWvzGJ0G5TsbqRx5YSr2lJzK4KHiZJu2itYl+lSkkfoFhDgpaOtvwXFNPzZMj0FhWcQDiE8QuIV/VLitYT5AyhhHFB5P7g9nXsHK8g50qnJ2h3pDJzw3PJnn7FCgk+uIr81GwHvsHzvBmNB3Xut32v0gdggJZ4VOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223821; c=relaxed/simple;
	bh=4chHFJa4wPNrdMZkC5LD/z7NDKWyj1o7SEVfihhozM8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJf20GvCwBwFkjrgBWVX3W/sXcldP9Eh7W28PlmDRz0De0Hou+djB5Ylo6cRX+5iwERLy6bh2C8w1A4hAhTT1kqNsnhspWjop2p3Ptdol6gfXI4Y1eUFPOZh3aMfq9Ue2mqHK3xpqJYJ7/EgJXL/cEdGJi811sF0MuqHZA/Kbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ0MnUrv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5605c7b0ca2so2723000a12.3
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 04:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707223818; x=1707828618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Itc/ksvrRJ83eDKyP1kfz2WlXT7HIX5clOua8VoHPEE=;
        b=iQ0MnUrvxs24T/Oub6rMjiZxrpCS8ElvzdU59R1i+LxQlUGARQ1GbNKbOo1NSC1F8O
         yrKntmue32YHtryEMAvjwzu/lsCtQM/ieRGsUbE6fFCezioJJe/CHmirXqTEoA3NqPjH
         T+3eIBx5c5rMRUsIf4ONHABjz2GCa+J2GyrodzWNhvH8N9xyKRgOT3/gHjJgYgejm3NH
         eUOK9MB9Ze1Kd0H+SgnuirDAMWQTF9ZObvhll8k7qXSRVJ1XBcmaLyYhuaKSTTlk4UGk
         qfbTfoi6/tsRNobfvNdKFlvkTfK/4S4UTaPoEbDN4ssajesxo/DmwVgLlZz5ByElvb7L
         uX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707223818; x=1707828618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itc/ksvrRJ83eDKyP1kfz2WlXT7HIX5clOua8VoHPEE=;
        b=EkkjX4PDBh6Ev3Jv0F1GHm0SCaWoMeAeHK0QTGcKggCDhWql5Suy3paYjTAO14IlkG
         U5DHL4//41NJdxTdFUFO0ksiZGBErAA99BI7UB3fC4KVXFqcT3sYx3bz6SPbK9XCaRip
         X6vVLQe53oXOxrOGtsqr3jakGfv4Dw+u/pOe89jcAvVFR+T/TaSy+KcO1AHZK2U9x+jD
         5Yq9W9TkLgbe1vuX8nEbZ3CaycOXn7gWm/8jYkqT5ngiPqnMEhlBpFtL7q9qGJ+b8UPo
         OeAf+Q7SLgHog5WGFSDSMrfcEl8LMjzrrtRYwMtqCk5pnxveqMkRdr2rO7/auBrJGHTp
         1Azg==
X-Gm-Message-State: AOJu0YxCgFlgcRKg7GD+d01+3jygB95lPQfjOj2xtZzj2s1lsJNJN6Ei
	SOdS77fNleO6y6PYnID5GVLRwozw2PolB19Pp/f3nl3OSJ/38pu2
X-Google-Smtp-Source: AGHT+IEFeb0op/N4wBj+CqUqGl1sCmOLt4NTjLgW7pN1vUt0K2S0xkHl3/dONqYPVSnf47iHmTSgkw==
X-Received: by 2002:aa7:c713:0:b0:55e:e829:1461 with SMTP id i19-20020aa7c713000000b0055ee8291461mr1452714edq.42.1707223818301;
        Tue, 06 Feb 2024 04:50:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbWiZ98xPMmcrMPdFa4GYaw0IUqDFhtr48ULbUxEqwQ4q82Jr6LEOM/RUmXqjvSoWZSBxAMRgTOk2pMNGG09SZG/GQ6MYWmX1Bt41MUlGcYgzYyMaHKdyYR76f1eRYDNlK0RVjSVVSYs+3bczALwf215Y2nigFgITPKyFBrgaXK0VAsw6ZjcwjsoBzW8yaAez2eK0PJTXHBC2yrZEEms7m20iKCZp+UcUGC20b
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id p3-20020a05640243c300b0055c60ba9640sm994572edc.77.2024.02.06.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:50:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Feb 2024 13:50:16 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org, quentin@isovalent.com,
	andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZcIrCIUh8jqYUf2O@krava>
References: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
 <ZboeMyIvGChjaBLY@krava>
 <ifkoiqmxww5cwm2zfsf56rxiikichw53o6gwo4hyaxqmyij4tu@hvemdh2fqfhv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ifkoiqmxww5cwm2zfsf56rxiikichw53o6gwo4hyaxqmyij4tu@hvemdh2fqfhv>

On Sun, Feb 04, 2024 at 11:08:45AM -0700, Daniel Xu wrote:
> On Wed, Jan 31, 2024 at 11:17:23AM +0100, Jiri Olsa wrote:
> > On Sun, Jan 28, 2024 at 06:30:19PM -0700, Daniel Xu wrote:
> > > This commit teaches pahole to parse symbols in .BTF_ids section in
> > > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > > 
> > > Example of encoding:
> > > 
> > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
> > >         121
> > > 
> > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> > >         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
> > >         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> > > 
> > > This enables downstream users and tools to dynamically discover which
> > > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > > available in /sys/kernel/btf.
> > > 
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > 
> > > ---
> > > Changes from v2:
> > > * More reliably detect kfunc membership in set8 by tracking set addr ranges
> > > * Rename some variables/functions to be more clear about kfunc vs func
> > > 
> > > Changes from v1:
> > > * Fix resource leaks
> > > * Fix callee -> caller typo
> > > * Rename btf_decl_tag from kfunc -> bpf_kfunc
> > > * Only grab btf_id_set funcs tagged kfunc
> > > * Presort btf func list
> > > 
> > >  btf_encoder.c | 347 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 347 insertions(+)
> > > 
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index fd04008..4f742b1 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -34,6 +34,11 @@
> > >  #include <pthread.h>
> > >  
> > >  #define BTF_ENCODER_MAX_PROTO	512
> > > +#define BTF_IDS_SECTION		".BTF_ids"
> > > +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> > > +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> > > +#define BTF_SET8_KFUNCS		(1 << 0)
> > > +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> > >  
> > >  /* state used to do later encoding of saved functions */
> > >  struct btf_encoder_state {
> > > @@ -79,6 +84,7 @@ struct btf_encoder {
> > >  			  gen_floats,
> > >  			  is_rel;
> > >  	uint32_t	  array_index_id;
> > > +	struct gobuffer   btf_funcs;
> > 
> > why does this need to be stored in encoder?
> 
> I suppose it doesn't. It's used in multiple functions so I figured it'd
> be less verbose than passing it around. Also since it's fairly generic.
> 
> I can move it to explicit arg passing if you want.

I spent some time trying to figure out why it'd need to be in the
btf_encoder object, so if it's not needed there I'd move it out

thanks,
jirka

