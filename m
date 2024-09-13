Return-Path: <bpf+bounces-39805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA788977AE0
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319F9B20DA3
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282801D67BE;
	Fri, 13 Sep 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0NrrPy7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A51BC088;
	Fri, 13 Sep 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215794; cv=none; b=DAuFv18X4DE3NLwSfC8ty/GDl0qrb+UI14KK/FpP4zi8WCRBl9p6hIHbUkIE1Kl37gahS0TqbcRglT3VIWuELGNLgzaSA8ljYrabXOE8uv6OcEu1JfiMLf2xSrbpWI/gB7XTaP+kHhoGph7+9HeFoMYowFaXuBI0b518G/WKSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215794; c=relaxed/simple;
	bh=F9WMN1ar99DkIYhBr9lSSfqYhs+Ra4MDhT7JouB7i88=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpFKFluv7Loy+NbACwfS0AMtZapt8lF8tA1KgRnKYjAGQAPWAszisnbXu4rW1h7zBFcvPDiqWwNXY4lv42TTDLps7CNQQgjyp4HCPugcD5Wer/IjO05zqIH3U6sPZaq9FxxaM9MEVIEtSD4Aivqcrvlw8qnMLvV737UNfdkBznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0NrrPy7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so5320285e9.3;
        Fri, 13 Sep 2024 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726215791; x=1726820591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+GhRQ3oG4bnaBAL9utcWm2F6HSh4ooNGToRsTRm4Zs=;
        b=f0NrrPy7Kd5Yfrx2F9q5HwV6+yA14i7gQBZPCHrp5EffxhUYIGUuhXfFWDKETyXDyf
         5ia7sWP1vuI3hLXmEJnl1rKM0dOHFCWVzILtJbTxUm8H3es2HfYpPcupSUoKSQQGIg0s
         0YrfYwb76ztu54TdxEJSpqcKioOWOnUEEgHDsv+ciPmkViGB4I7Kf9hBPnYa3b6X7weZ
         +G1oRzg1A+7hhW7DWKdzBuKKTIbqcsBCSHZuhaFo4yutQU6iQxni3Zp6+EHSvz9/DD8e
         Ihg0JhXvaxJsp2Wjdz0CHARRPHlCaDFnrLISkQq6b5vRx1kGlaYM05BmnYcTVA5misM5
         r1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726215791; x=1726820591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+GhRQ3oG4bnaBAL9utcWm2F6HSh4ooNGToRsTRm4Zs=;
        b=WEpyaJFWA0UvoHE6HfnbrXGGovbmGzCa6VGnc8j9tYB1HC4KIk/QUS51N3BQXYa1rW
         xFEjZ6suR6IdZD2t2nbtufZz6CbdNc7bBP6RsdQpL0qUoo0JG61dig7F261BCpYN8DdK
         qS+8iSLntdFSF4sAtKAbXU1dvH1O0n2IpWiYoAsF8QDgFaZ+ipa/J7a83CZuqa7LASSO
         5XQRE8KrsbNXhp2K4pfN5/4Xg/3CshqPu676l4NI/Y0rMefNNmG43Z9rmmryYNoXX14h
         R4fWZUiqBCspNkNMUxY5U5bYv0lDPVmt2OkFTbVqfVGV2yCvgiViulQ/xZhQB3rEP7OF
         RzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU9hJW+f2e/zgVjhN1pFoEKItDBxL5iWyvyvnhkXHqC57mLqo/n2+U2LeVRzN/32iACxbTOt+j2r9F0Frw@vger.kernel.org, AJvYcCVPO+JAeblaBE3YmPgC1X62DJJBthOcLQM3ujtzLjts1xSkRCWe3c9xGMtpa0C4akU0o7rS3kV12ysd56xp6up9yMDz@vger.kernel.org, AJvYcCX/DlcuOJkMOTxD9Ro0CuHeSvxBb92bhgq4sCgx7ZNevpiI5mtsFe6FAnaAtFV6wpkWTNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMPGhnrXdWBCsv2v8hdrqRbDXl1+p9sdhCEQGS8RfVpuNCtynO
	VsEfkoijgyDqrd2GVq/Zl3yqJubw4KXfwH4nuiENZH3ug9f3u1MT
X-Google-Smtp-Source: AGHT+IFqprEtHj/Ro4u+NSmvptLWA2EfkQYvDkdx7Rg+9np0yb2C4ytgTh1UjsimnK8NSXoqMHjiPQ==
X-Received: by 2002:a05:600c:350a:b0:42c:dce1:8915 with SMTP id 5b1f17b1804b1-42d964f84cbmr11969125e9.33.1726215790769;
        Fri, 13 Sep 2024 01:23:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b189a6asm15595165e9.38.2024.09.13.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:23:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Sep 2024 10:22:56 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <ZuP2YFruQDXTRi25@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912162028.GD27648@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912162028.GD27648@redhat.com>

On Thu, Sep 12, 2024 at 06:20:29PM +0200, Oleg Nesterov wrote:
> On 09/09, Jiri Olsa wrote:
> >
> >  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> >  {
> >  	struct uprobe_consumer *uc;
> >  	int remove = UPROBE_HANDLER_REMOVE;
> > -	bool need_prep = false; /* prepare return uprobe, when needed */
> > +	struct return_consumer *ric = NULL;
> > +	struct return_instance *ri = NULL;
> >  	bool has_consumers = false;
> >
> >  	current->utask->auprobe = &uprobe->arch;
> >
> >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > +		__u64 cookie = 0;
> >  		int rc = 0;
> >
> >  		if (uc->handler) {
> > -			rc = uc->handler(uc, regs);
> > -			WARN(rc & ~UPROBE_HANDLER_MASK,
> > +			rc = uc->handler(uc, regs, &cookie);
> > +			WARN(rc < 0 || rc > 2,
> >  				"bad rc=0x%x from %ps()\n", rc, uc->handler);
> >  		}
> >
> > -		if (uc->ret_handler)
> > -			need_prep = true;
> > -
> > +		/*
> > +		 * The handler can return following values:
> > +		 * 0 - execute ret_handler (if it's defined)
> > +		 * 1 - remove uprobe
> > +		 * 2 - do nothing (ignore ret_handler)
> > +		 */
> >  		remove &= rc;
> >  		has_consumers = true;
> > +
> > +		if (rc == 0 && uc->ret_handler) {
> 
> should we enter this block if uc->handler == NULL?

yes, consumer can have just ret_handler defined

> 
> > +			/*
> > +			 * Preallocate return_instance object optimistically with
> > +			 * all possible consumers, so we allocate just once.
> > +			 */
> > +			if (!ri) {
> > +				ri = alloc_return_instance(uprobe->consumers_cnt);
> 
> This doesn't look right...
> 
> Suppose we have a single consumer C1, so uprobe->consumers_cnt == 1 and
> alloc_return_instance() allocates return_instance with for a single consumer,
> so that only ri->consumers[0] is valid.
> 
> Right after that uprobe_register()->consumer_add() adds another consumer
> C2 with ->ret_handler != NULL.
> 
> On the next iteration return_consumer_next() will return the invalid addr
> == &ri->consumers[1].
> 
> perhaps this needs krealloc() ?

damn.. there used to be a lock ;-) ok, for some reason I thought we are safe
in that list iteration and we are not.. I just made selftest that triggers that

I'm not sure the realloc will help, I feel like we need to allocate return
consumer for each called handler separately to be safe

> 
> > +				if (!ri)
> > +					return;
> 
> Not sure we should simply return if kzalloc fails... at least it would be better
> to clear current->utask->auprobe.
> 
> > +	if (ri && !remove)
> > +		prepare_uretprobe(uprobe, regs, ri); /* put bp at return */
> > +	else
> > +		kfree(ri);
> 
> Well, if ri != NULL then remove is not possible, afaics... ri != NULL means
> that at least one ->handler() returned rc = 0, thus "remove" must be zero.
> 
> So it seems you can just do
> 
> 	if (ri)
> 		prepare_uretprobe(...);

true, I think that should be enough

thanks,
jirka

> 
> 
> Didn't read other parts of your patch yet ;)
> 
> Oleg.
> 

