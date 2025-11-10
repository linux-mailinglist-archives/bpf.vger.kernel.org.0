Return-Path: <bpf+bounces-74065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76FBC46E5B
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 14:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826993AC008
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422B3101C8;
	Mon, 10 Nov 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5qqUFsl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2883101BB
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781218; cv=none; b=dm0NVembmeUJLJ7g6sgEatrbK+TCVRSY4G+65FER0PtsisDfbm7u9KL53+nkxRjc0PEF2RShPyd3/hagnNaDcP76IFZaYRhZQmr9L8j/nBRzc45u2aq1WuQas8fSzgPfUj6H61fAkP82IcvUVTBW/P9MYL3pe1uhTpVm3oxksAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781218; c=relaxed/simple;
	bh=7zBlKI19nm4l57l+GSpU34xDjL4DbJLxfBwZWCrg3No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu07nGpzMrPbrVpM0IrD14+vgG2OUfjlpoVu70OYtklo5/bOTDb6dKz9cagI2Ij6DELnnNxjmtKTiXcPoSuBN80jlzmDqkRyt2rNEmrqH4qhsqkEVFCVm8PTqDNTYJoUBEwMsLjKfTHctnVvT9bhniT/OA6mV6tnBXnisnLqGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5qqUFsl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b5a8184144dso389585566b.1
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762781215; x=1763386015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhaZSZSH3JxixsGOb3+NSOpxTTK16V/bDeAhAAUpFzE=;
        b=E5qqUFslVJXWPHhafsxsLihzT2Hp1H7ZL3bmTpHc1vF2FQcxh/aQ06ldMfj/Vuroos
         6hElXI3/nIMU2tmAI7rb47W4ouuJ2zEDvb8xbb8ffZIju8HaIU51HE4S6tnw71CNQ3Bf
         SgKBbPLG2cJ7UoeLIsWfFCk78xyOgWyvCGN2fFCZjODv9YM0tjvAzWt8o0pPmpRbmKjq
         5gvS9Pg1mDvRrHYdnSJIGr093yv9UAsFVNVIGZbrH8Ga2I9QDAIM+z0ttJolmmxcgcpQ
         aZjjcynCrC/094+Dg13xfDzZR5iiIEW/g6WMD43PJ1HEEajIHDCWJfXyimpxSn2TnjQ4
         JyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781215; x=1763386015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhaZSZSH3JxixsGOb3+NSOpxTTK16V/bDeAhAAUpFzE=;
        b=IBUlRuputH7QBVTsxYTY47XKW7aoP2mjdcAd16SvzfUObgqPSr9kdnJE2V6cJsFbYm
         x8/c1dTAuqAyvrcjCL0UgERZm1ZFCZsbpvjDNmLvq1kENEVsCE5Jl4BGIiPUIy2M9srF
         1OIDqz4VHq5nI40l1UXTm9n8A4qalxQdBEhHlTGUy2tL2Cs5I1UWIJrX1E+C34sZ4eEF
         rBhkpmEw8YLKNSgpu/x5jAgXzF2xqsYyAtTQPYNNmsH0MTxraTfIfFiLaiIEzwkM1o2j
         CMFRf4yz5vbmwegjYT3q+MSgnGSAO+sJ4vMwuGVoDzHq4D7htKLGLW42J/FmMxfWhZX7
         gDEg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8fu2d8EdduHKwm6pr81lJ0KwHnaUComFe7XFrZXsW8Rh40Pwh908DuLMt6B1gQYxuYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSLUJihg9LTXlyjYwQG6c/Un4BHtLR5qUwCqh9LuznGqumzKS
	5kla7XZpCA64yj/rEvO5z8aQVi1oePYHs2MAW7j4k9dfvL5ILmA+IBqmuRPQJrKAcbs=
X-Gm-Gg: ASbGncvJal+uP6tEd8NUtPPxIZhJ3FkJo25MpRFuxMhfiDCQntCyd/Pi87zsWduEUyc
	Jfe9VW90KrIFZS0X9s6yxMny3G0t5XjLWndjgHB8bzqhB7x3SEb6cuDgU4xtlNIt7x/ibHH/K51
	/hmpyjqDExHK2ecuqhjCRU9yysWNlOB+VpoIyGtdNhFcdGHxpL5RE8c5iWk3Xs1C5OBfe4y2y6U
	6n1eHHVkKGjnfiebn9i+0DwlrLEiRmylwT12DXFBjfPnJDRhJvqkV7ivnNdcPd+M6Wo7SO84Yce
	2Rft0LZwspxBzv4PDHzdTZBa8c603JjW5lY+afV8YJEHdMmoAjM+BiCl2FJEVK+X0B5V0jVoLlM
	mDTMnlRkX3IbPimYAAdAVHrT7o994jaWxLZoAFuLDlQ9QjL9nIpqDODtkthC2AqFvPWxKW7vWNi
	N80jGWJQ0qfFFEkw==
X-Google-Smtp-Source: AGHT+IEFvin7sLruegH2ZxQ0SW44BHRX6xFr54ZAVGaHqC0y7M8M930cBHeCWlcadsxgJM1CQZ9cXw==
X-Received: by 2002:a17:907:7b96:b0:b40:fba8:4491 with SMTP id a640c23a62f3a-b72e0310d6fmr928514366b.17.1762781214802;
        Mon, 10 Nov 2025 05:26:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d43bsm1129492566b.45.2025.11.10.05.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:26:54 -0800 (PST)
Date: Mon, 10 Nov 2025 14:26:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] kallsyms: Prevent module removal when printing
 module name and buildid
Message-ID: <aRHoHMJYAhSoEh1e@pathway.suse.cz>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-7-pmladek@suse.com>
 <kubk2a4ydmja45dfnwxkkhpdbov27m6errnenc6eljbgdmidzl@is24eqefukit>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kubk2a4ydmja45dfnwxkkhpdbov27m6errnenc6eljbgdmidzl@is24eqefukit>

On Fri 2025-11-07 19:36:35, Aaron Tomlin wrote:
> On Wed, Nov 05, 2025 at 03:23:18PM +0100, Petr Mladek wrote:
> > kallsyms_lookup_buildid() copies the symbol name into the given buffer
> > so that it can be safely read anytime later. But it just copies pointers
> > to mod->name and mod->build_id which might get reused after the related
> > struct module gets removed.
> > 
> > The lifetime of struct module is synchronized using RCU. Take the rcu
> > read lock for the entire __sprint_symbol().
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  kernel/kallsyms.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index ff7017337535..1fda06b6638c 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -468,6 +468,9 @@ static int __sprint_symbol(char *buffer, unsigned long address,
> >  	unsigned long offset, size;
> >  	int len;
> >  
> > +	/* Prevent module removal until modname and modbuildid are printed */
> > +	guard(rcu)();
> > +
> >  	address += symbol_offset;
> >  	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
> >  				       buffer);
> > -- 
> > 2.51.1
> > 
> > 
> 
> Hi Petr,
> 
> If I am not mistaken, this is handled safely within the context of
> module_address_lookup() since f01369239293e ("module: Use RCU in
> find_kallsyms_symbol()."), no?

The above mention commit fixed an API which is looking only for
the symbol name. It seems to be used, for example, in kprobe
or ftrace code.

This patch is fixing another API which is used in vsprintf() for
printing backtraces. It looks for more information: symbol name,
module name, and buildid. It needs its own RCU read protection.

Best Regards,
Petr

