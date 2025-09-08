Return-Path: <bpf+bounces-67812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9664B49D0E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D863C685E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892A2EBDEB;
	Mon,  8 Sep 2025 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4jdBPwzU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988B4A06
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371333; cv=none; b=bUkeY0SDuqrYIPEIGvSrfZAi9khVB/mSZ6591WyzYDBLkLMjomzUDjlDURTNxqzRfVh316o4eGIrqFB5MPvD15QojRLV15Af2YTuxKm6JymxvisArnuysDNn3av4oAAQVYKuJaKd9gLMgGN4mactrsxXvN4ZDr3AVzg26M9WpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371333; c=relaxed/simple;
	bh=+MZ4kGiA6dcSq1uVjsBp2E4yGaNDjvN3CP9C1c61gSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejGaJgKg6ncZbANAyPNeDAia1+zeuX3hKfayFiKzPCKm4opPQbUG2d0/1HUD1xSQ9BlW6e1WYFAv4BT4tDJMC43ZOJG+NlPJMGVdvhyDHguXZSid2IsoYcrJi3Wmyk2WBh0Lmvx86M+McG8t2TfrYTlGEJDvFa19MrnsUMJBr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4jdBPwzU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b2337d1bfso466285ad.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371332; x=1757976132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhmLSMNs8zGKSTnxfu3cW4zshH+/OoAbeuppmS7194E=;
        b=4jdBPwzUpJPAtcxoeJPIcRhRZK3N1jrriK169D/E4/eC+k+M7ZoLWR7p1m6298e3c9
         SSG+dYG7mcFNRjHzVTY3e2mMOckUiEyk5r1NH+VXxMFmFY/qAFHoK4RhkgbnkwTQnv6n
         8ELHo3fAW8Sh/MKWaLbm/zxMuQTb3YIIBC/PJvM5ufaFy6pOyFI8JSnn9EDbbZEegzrn
         xk7j2s1/7MgomkAil4h2f3IvXi6Bd8nGPZArDWGjeQ/33+JMtw65xd3THoHy46oKcCtb
         jeyvIy1X33EShcTWrktDGvebY6gySZrbug+K617VhxscMkcYXq2ZOSwRHoGvs369yKsY
         eCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371332; x=1757976132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhmLSMNs8zGKSTnxfu3cW4zshH+/OoAbeuppmS7194E=;
        b=kA/alcg795Q5KBOisXSLt4YhL8b7ZKxdGgrkmeN4eP7+SPsOKp56QRMLigOXl9uaCX
         Macfgq6TrgqBwTw3vKfsygwY45I7lsC/bmPXMN6TK7xiMWkzBlbD1Ynw8TZAYlxAcA02
         py8yNLZ5WmqxhOMuNGAQtZgOSe2ihEb1RXRJMHsOcR/24QAt0SOtAD2IMSmsw9QnV04e
         WxfkZ0vWJaENm3ZZ/JjyT73v5sFWymHmlSb+2PrVINyBdCtGKIo88EIwfz4Zgiyl/707
         cDesGKu8/TNiMT9QwCLOw6twq53Zm0PwqG8+pDcgceSdQa3r3y1zKOsg+UcVnVyC03sP
         csYw==
X-Forwarded-Encrypted: i=1; AJvYcCUYBkxqQOuTZTjqzCJ74659Ga/dGxNOBHd1LVmEBLhD8JmXaFPiE4XxJs9Q1aTVX8IH9co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCW1LZZaQ0FehPDOyGn0oDnaIJPaUUKOUSJwVDmg0K5wcIvkZ
	CAHlOg/nn5CHYmrZ8PYQs1T6X1w/dZ2f7qOT6A+KSVn+zXZ/x7CJlLK5+WKPr3edyQ==
X-Gm-Gg: ASbGncsu8Ge/R42qeHjoaRFdbNb3ZnN76FbCUP+RiE+PO8Rd9/ch9NfzqTEdczihphz
	HwVTL0hCwe7GYR+YUmyMivDy5v02HtLgWKxgCB8bhlb9YaRmd/kKJqDXwZli53cpKoO+yyFTkXO
	KXtPRumpkWiBuw/MLx9EzRAs7bfAVsSLGH28mj0bljlEttyVLvXBQJZ9622sf7YFZ3rL4VusIzk
	Ui3uiP+H7ZK/CpLI94q8UyLvEsvM0iyUFYt02eLbCRB6DMgPJqlObDraQELmEYXxTp37BksM4F/
	+8ZlAFCRRBMS570HljFcUJGZlkT8Bo73sYZOofNCPdxReTmOeCnTjymipeYivsqWeUzAWpQKiPA
	QvgG6LjNDeRFV9xYuCCAWReJlSdHXqPGNkioYwFQs6+NSOuf5H8f1EhWBIUYZw85VsGYOrsfHQ+
	12Lg==
X-Google-Smtp-Source: AGHT+IHcriTUfuKv2XkeDae2mgTR9CK7g/GGogjFVgHVkosbFZ5LlWNgduBsv0eWd5zwzdRp0IgqFQ==
X-Received: by 2002:a17:902:d486:b0:249:1f6b:324c with SMTP id d9443c01a7336-251753d93bcmr8837095ad.13.1757371331533;
        Mon, 08 Sep 2025 15:42:11 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662f9cfdsm1193b3a.101.2025.09.08.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:42:11 -0700 (PDT)
Date: Mon, 8 Sep 2025 22:42:06 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kernel-patches-bot@fb.com,
	memxor@gmail.com, joshdon@google.com, brho@google.com
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
Message-ID: <aL9bvqeEfDLBiv5U@google.com>
References: <20250908044025.77519-1-leon.hwang@linux.dev>
 <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>

Hi all,

> > > [   35.955287] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48

FWIW, I was able to reproduce this pr_err() after enabling
CONFIG_PREEMPT_RT and CONFIG_DEBUG_ATOMIC_SLEEP.

On Mon, Sep 08, 2025 at 12:29:42PM -0700, Eduard Zingerman wrote:
> On Mon, 2025-09-08 at 12:20 -0700, Eduard Zingerman wrote:
> > On Mon, 2025-09-08 at 12:40 +0800, Leon Hwang wrote:
> > > When enable CONFIG_PREEMPT_RT, the kernel will panic when run timer
> > > selftests by './test_progs -t timer':
> 
> Related discussions:

[1]
> - https://lore.kernel.org/bpf/b634rejnvxqu6knjqlijosxrcnxbbpagt4de4pl6env6dwldz2@hoofqufparh5/T/
> - https://lore.kernel.org/bpf/lhmdi6npaxqeuaumjhmq24ckpul7ufopwzxjbsezhepguqkxag@wolz4r2fazu2/T/

[...]

> > The error is reported because of the kmalloc call in the __bpf_async_init, right?
> > Instead of disabling timers for PREEMPT_RT, would it be possible to
> > switch implementation to use kernel/bpf/memalloc.c:bpf_mem_alloc() instead?

Just in case - actually there was a patch that does this:

[2] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/

It was then superseded by the patches you linked [1] above however,
since per discussion in [2], "use bpf_mem_alloc() to skip memcg
accounting because it can trigger hardlockups" is a workaround instead
of a proper fix.

I wonder if this new issue on PREEMPT_RT would justify [2] over [1]?
IIUC, until kmalloc_nolock() becomes available:

[1] (plus Leon's patch here) means no bpf_timer on PREEMPT_RT, but we
still have memcg accounting for non-PREEMPT_RT; [2] means no memcg
accounting.

Thanks,
Peilin Ye


