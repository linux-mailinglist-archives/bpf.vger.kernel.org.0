Return-Path: <bpf+bounces-73955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1C7C40108
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 14:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F0D18852DB
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763002D7DC3;
	Fri,  7 Nov 2025 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BlHoPCu3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93B2D7D2F
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521305; cv=none; b=oXsJgUq+UeFkbgDtuLz018DYedPUvzii1HpJA/fJQNx4xxuDOJKUSCq68MyLTOyNKU5OScDnJeWkbGBrbzi16Wjf4MPPX3Y7wPUGwmFl3UPHygyFxRtadx356aWYv5ZhqJLmwHjsTAXBtwItL5Qtc6arGki7b+mXDKepezySXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521305; c=relaxed/simple;
	bh=0mPhFFV27EI4HWkCT/K0CutZwM23pABS/zg6xhegD68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDZUUj7GyQsFCrI1Dgn9Q2wbLpd/nWsoRz9PDaX0s+DZGOltrFRzU+EDr0bvw5tGze9PYjZ+RhDEKgQvQPDdZ9h3GLeIRfc8O1722ht4OTonO1lrjxjps0Ofx0KFzbA35t54Isqw6sMrYm0cDOiLbKMjzo/8A5KfuvVteh6Zu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BlHoPCu3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so1292027a12.3
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 05:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762521300; x=1763126100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HZ8kO1EbOdno/Z6LWKvw9cCt6xKTq52Mcwxm+AjrMQ=;
        b=BlHoPCu3NqtLtozYF0ZyHTBdobJJ/cANVGnsDwuY6T8dx2F6BpG8CLWuG2V1KWCPn9
         rJqzhFhR33ZMV++LnBz96/RuLoQJElQKD/XgdMcwXWV7h9QKhE6GKnV5S15pYGxSNGqu
         KqaXf2ahPz1ifbkNBO7u8j2yiZH6M0K6PrgMzHi6k6ovXdGBxghrOCwCc/pEwIl/Eo01
         Pk2HH4fQOf3Bw6VYHGk0nxbI0DXzJSh5ufcLRQ9l6RwgF98tgxr22FjT0cjpknUAGNCF
         BA2TawykZDjdpivWUQQk7vyA0EjOpZxziWhEOwjmij06OkYHzpG2iI9J48haI79hsRab
         cxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521300; x=1763126100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HZ8kO1EbOdno/Z6LWKvw9cCt6xKTq52Mcwxm+AjrMQ=;
        b=TX9Dz0cPNaG7cLNg4gPZWz7XK0lp4R9H0D17sBgJsG87RXyp2VF6Y5NKZosDGDy5Wl
         peYAjD55j3DTXVZCGhWLE0HtMrGQQG0zv+3DWDtnoGQbJvMz/TaCvO56FTj9CyXSdrDM
         /9/s2PEgSXgcC12wPRNhcghv6732qjm/bWwOknd5H1s7T5WCc1bQQxYg+hGsvLX6ST7x
         pmLkQf9Oogiw861pHw3uBlGUcSvpEvmPhj4JVcX7kEAhwdeKr5nIz5byQ/KFXkErcwpA
         gXUkmubL/b03r1MiDn8FfwQhcjl+Mi2MnhNAWYw+xxitOvShMSPD9pFiI3PwdNbfcuwm
         R6/g==
X-Forwarded-Encrypted: i=1; AJvYcCXdFUuT6cnNq8OdXn08KCEIcSriPIZW9sqD6QOwtmBAy80SNKy6+E6UIFFgdJZai6jDKEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SYnyPyGfIR9BolvK4L5ODKvs1K8OZcalhHNXOhc2ryRaq5Tv
	QJAaiJAZaI0kqiZ4PFLpwj+6GELW6hJp1JUmPO0IeUZjgb9bVK+qekbo0Zh5KQIXqIU=
X-Gm-Gg: ASbGncv9cvKt1RmM2uFXfuq/dRRJUg7No1N35Egtpxnh2XUcETR2E9R785yP2qK9zqx
	Ceg54jLpDahlRUtIQ+hfsHjQS9oh6Xbcgj4ofjw03K541m/Bvx2uwEF/tNWQge/mlslCEuda8ij
	T1Co2hk3yY3pvoquoKKkplXSScLo9B/oegLvxgc03ymJNTEFsDia3LhenlBoIbYXDTHZov4efJ2
	1UmqC4/kKOQPTs+29S8pVtIje1kMqVk55Re4YNFjS87sRdrt+HBRdJIsOMah8RuASThHEZ6yQJF
	n1aq0YexnrFLRVqDKHT6LGu6NxzS/5hNAZGbgvkg7CVNRBTtDKifdYcGEpQBIp0NYkj6xM+tf7z
	tfoPtLFV2gGtxe84HO07XhSj5fhV+qNiN4pF7SpIlmoWVgjljt6ODr8FMNg2W7yQXuDOvRNmdMZ
	7E4dc=
X-Google-Smtp-Source: AGHT+IFE2eYy0+Px5WausE/jRL0XZhUzH9bbFk8nsiudCpX/vMQhbSO5rZNKcgvz0+P/IDwF6D5asw==
X-Received: by 2002:a17:907:2da2:b0:b6d:5914:30c with SMTP id a640c23a62f3a-b72c090e4b7mr299535266b.34.1762521300369;
        Fri, 07 Nov 2025 05:15:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d1fsm233492666b.73.2025.11.07.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:14:59 -0800 (PST)
Date: Fri, 7 Nov 2025 14:14:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: bot+bpf-ci@kernel.org
Cc: petr.pavlu@suse.com, rostedt@goodmis.org, ast@kernel.org,
	akpm@linux-foundation.org, kees@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, mhiramat@kernel.org, mark.rutland@arm.com,
	mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/6] kallsyms: Cleanup code for appending the module
 buildid
Message-ID: <aQ3w0awU61mrS_AF@pathway.suse.cz>
References: <20251105142319.1139183-3-pmladek@suse.com>
 <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>

On Wed 2025-11-05 14:59:53, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 1e7635864..9455e3bb0 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -423,6 +423,37 @@ int lookup_symbol_name(unsigned long addr, char *symname)
> >  	return lookup_module_symbol_name(addr, symname);
> >  }
> >
> > +#ifdef CONFIG_STACKTRACE_BUILD_ID
> > +
> > +static int append_buildid(char *buffer,  const char *modname,
> > +			  const unsigned char *buildid)
> > +{
> > +	if (!modname)
> > +		return 0;
> > +
> > +	if (!buildid) {
> > +		pr_warn_once("Undefined buildid for the module %s\n", modname);
> > +		return 0;
> > +	}
> 
> When ftrace_mod_address_lookup() succeeds in kallsyms_lookup_buildid(),
> it sets *modname but doesn't initialize *modbuildid. This leaves the
> buildid variable uninitialized when __sprint_symbol() calls
> append_buildid().

Just for record. This is a great analyze. This patchset is fixing
this bug in a later patch. ;-)

> Can the check above read uninitialized memory?> 
> Looking at kallsyms_lookup_buildid():
> - module_address_lookup() properly initializes both modname and
>   modbuildid
> - bpf_address_lookup() sets modname=NULL (so append_buildid isn't
>   called)
> - ftrace_mod_address_lookup() sets modname=mod_map->mod->name but has
>   no modbuildid parameter
> 
> The commit message mentions wanting to catch when lookup functions don't
> handle buildid, but shouldn't kallsyms_lookup_buildid() initialize
> *modbuildid=NULL before calling the lookup functions to avoid undefined
> behavior?

It seems that we are going this way, see
https://lore.kernel.org/all/aQ3vWIqG31BgE4YD@pathway.suse.cz/

Best Regards,
Petr

