Return-Path: <bpf+bounces-46905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0279F1827
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C7C166032
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48336198E90;
	Fri, 13 Dec 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAzuuK3O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA23192B84;
	Fri, 13 Dec 2024 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126741; cv=none; b=PD7xuPg9F7OqMO31sbDL5B+6EUXv9+z71U+GGl9MN1rxgTxmj8sOdEyMVg2XGhFBCSfhwbtLnMYyyaHSZ5A3g3k4mjSYlPi6v39M79/vQ0l58rSfg9tIlLbnrZNYmMCBiXG6xqtsCZZxw1uLOoi6QGKChgCx1odpnvUQ0obeON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126741; c=relaxed/simple;
	bh=Lq0Y5AnpNC4nNc7wS+5+Pgdx1g3gLPqv7XRdShJasfw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5gJgNRYIim8zW6Sx+cmEu+kzb4BHYhJ6tux2MMhXvS1nhu2idUuEM35zmA+l5dMB1rb/DudIQBO/fH+5PDXSJOj+Ce46iGWiA/n/2LUZz937S+3IkCtLgo1BeUOnCrPqZAI2Hqd+NvbFq8oO7kkJ3lKfqhsBwAzklg0YFw8o4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAzuuK3O; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so3324713a12.0;
        Fri, 13 Dec 2024 13:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734126738; x=1734731538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSKQa3FlNAhUch3aZbcAaHTatYPy7h4jdLhwCiPQ3L4=;
        b=bAzuuK3OLsXDUqG4DOcnqkFvuYWY6GSEKwJSlntxYBuMr0rV8WT0NW8wC/OAXDdilH
         nJlhRQqVMR+b2uHBCsohrzQo3O1QxH9dSRSlxA+yY6IjVy8PmtHgXkz4EI1KM6bjamhn
         /2lbSRHFpoGIT1hwJxk4n1o5rMTDDnrWQyUxJisno/CRYIKXEr0aOWthRhXv/xqFerQ2
         wBINaUUKuCKuOqO1zcfwPw0j3nhEmheKi3FvJkDDMFyWu8GC/Qbmp9HWIIulS2/tS/X5
         QMxdoT9BNMmOIqSj63tnl4u8NrZytAtSlUTt8a/Y54IKSHq6Xc2BZiFNdsavlS65JNkt
         osdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126738; x=1734731538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSKQa3FlNAhUch3aZbcAaHTatYPy7h4jdLhwCiPQ3L4=;
        b=dohx4dqkGrTa3lCH02GfZEkxXsru7UYx/6d/MsWHN19nS5T+l8cOg3QBExZkTceZ/W
         40Bo69PG85nLSFb6W6/MoJ+PwCjO/PyX3aOe2/vLmk/sCTMsS2QufzEgMbkITTzWjyxv
         Eyv4BF3AE+xWIUc9vbBoxT9wWHTkBVImJBGDLxKFAzUvyf62qpoWrCJbn13KE0CJrheo
         MOxK/m6Vl9fN52lNpiQnZjQIy2I91dDejAAGnFvAwgSinNq5OOmqud+ClaMmvLwzCKVq
         Kzz1KxTD9X8j9z6df/rkp2sZQDiDp2mxaLu26O1tiHPfN25CJV0Wz1zyu/ufoDucGlfL
         xgaA==
X-Forwarded-Encrypted: i=1; AJvYcCUSurx0udgfbzZRTjaDrXbEIK/dA8C5/yvH/6uduLO4WVING+1gxrw5DJTe3D0kb6Zr2uhK51XANmfl3o7i9fMSrYCM@vger.kernel.org, AJvYcCVQMG/wACGkMKvyr+0oFvuwfLneQgezUcGlwmnY8ix7nItCIjXv4UitmBnmsN5tnWHMPLk=@vger.kernel.org, AJvYcCWD50pl6srhAsUTgOriloxz0wjmmD6eAdzxKM8qOq9fg/MHlLx9a/AY54nc3ZPmtKB4gV3VA/qWk3ESSFQe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FN5IG9DXQrZSgaORd3f6eG70Y9tcgbSuRFPx8M3mOe3R/Aik
	+wTdZXOHF/UMAFiqUxGWuTRPfFj97aI6JFqw1xEQBn4U1GIuXd3V
X-Gm-Gg: ASbGncvnxki5US0afo1CzKqD+aAgxQmb/HzcgAFENAYNVkVrJl3v7id3Dq1n9I72cZs
	qOneWh/knj3ERCXogiKtV4QPsV/GnZ98qDoZmSIcLwPO9tOgMk2dDXeuSL4CCh/9nUkmXUy5isV
	vZ2dPtCXp0VAvmyn2iaCQSfne5fEH4s/fC+0YdinyCXRx6iv2oWk1BICBgDlr8KbbeVPqmf3iN3
	WEIwXq/RliNGDwia51CVQLmJlsHu085kjrgZunGWJkC/wB/ykwRbIw/8sGtdWdQQg==
X-Google-Smtp-Source: AGHT+IFybzOL8TUrFhQX96saOJMKlvfnCmP3KorzvmKfgdnTHMmKCGCyO058R2feN8+x1n33WNoGdA==
X-Received: by 2002:a17:906:6a04:b0:aa6:800a:1295 with SMTP id a640c23a62f3a-aab778d9d9cmr454235666b.5.1734126738176;
        Fri, 13 Dec 2024 13:52:18 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b2611sm16857666b.174.2024.12.13.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:52:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 22:52:15 +0100
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/13] uprobes/x86: Add uprobe syscall to speed
 up uprobe
Message-ID: <Z1ysj_PXy51WeAT2@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-7-jolsa@kernel.org>
 <66e85401-b2ec-442d-bebe-c4ff3151e7e2@t-8ch.de>
 <Z1xKAKnX3su21JZu@krava>
 <bd095061-f43b-4b99-bb94-40cdeac76f4c@t-8ch.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd095061-f43b-4b99-bb94-40cdeac76f4c@t-8ch.de>

On Fri, Dec 13, 2024 at 04:12:46PM +0100, Thomas Weißschuh wrote:

SNIP

> > > > +static int __init arch_uprobes_init(void)
> > > > +{
> > > > +	unsigned long size = uprobe_trampoline_end - uprobe_trampoline_entry;
> > > > +	static struct page *pages[2];
> > > > +	struct page *page;
> > > > +
> > > > +	page = alloc_page(GFP_HIGHUSER);
> > > 
> > > That page could be in static memory, removing the need for the explicit
> > > allocation. It could also be __ro_after_init.
> > > Then tramp_mapping itself can be const.
> > 
> > hum, how would that look like? I think that to get proper page object
> > you have to call alloc_page or some other page alloc family function..
> > what do I miss?
> 
> static u8 trampoline_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
> static struct page *tramp_mapping_pages[2] __ro_after_init;
> 
> static const struct vm_special_mapping tramp_mapping = {
> 	.name   = "[uprobes-trampoline]",
> 	.pages  = tramp_mapping_pages,
> 	.mremap = tramp_mremap,
> };
> 
> static int __init arch_uprobes_init(void)
> {
> 	...
> 	trampoline_pages[0] = virt_to_page(trampoline_page);
> 	...
> }
> 
> Untested, but it's similar to the stuff the vDSO implementations are
> doing which I am working with at the moment.

nice idea, better than allocating the page, will do that

> 
> > > 
> > > Also this seems to waste the page on 32bit kernels.
> > 
> > it's inside CONFIG_X86_64 ifdef
> > 
> > > 
> > > > +	if (!page)
> > > > +		return -ENOMEM;
> > > > +	pages[0] = page;
> > > > +	tramp_mapping.pages = (struct page **) &pages;
> > > 
> > > tramp_mapping.pages = pages; ?
> > 
> > I think the compiler will cry about *pages[2] vs **pages types mismatch,
> > but I'll double check that
> 
> It compiles for me.

ok

thanks,
jirka

