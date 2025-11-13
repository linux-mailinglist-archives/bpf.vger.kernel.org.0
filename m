Return-Path: <bpf+bounces-74415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE2C58C20
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DD874FF9A5
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2742F0C46;
	Thu, 13 Nov 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jByxble7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C402FA0C4
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049601; cv=none; b=b3tkcCJUrjFZTKg2zZGd+jKuoPNM/QwGJ2E+VVbQPRmK9EOI6i4n15OOyHmZnZMXYocC3DlhRQ04G5a5eOwjKx7g36QbFJbJDWPyxngvEgwktRqBMErCA0CnYY/0SJs01lL/ZxSGfzuZrvwJkO/QOUgx8LPom3Sql317SUj0kuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049601; c=relaxed/simple;
	bh=7IAIbw8sUkJ3o5wJTa1jHQt6cOZpyAPl1Nc270silZc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGX9VU0ARCeUQL91iZk+uPZLi5IrfXRL8pIlgI69Jq05fJrwgRCvfoDoCgWpQbWFqVlGIGamDvnEpcSX9ort9y+S7xY8Y60+TL61rFZJciRaf7R89XNFaCrgWPFm8il2NjIDd7pYTDsakaJMZwXWk46knpj+ElTBBgbZxiThTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jByxble7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so1651162a12.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049598; x=1763654398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSWIHRyyO3hooO64JACSCpnVieSk/9Ppr4dvEYGltzw=;
        b=jByxble7o6DshXjcI0EPPa7DkVmHoAFdAPxfcaruTGYZGcp2H6gq9OE3fuNEvaoMNW
         Zygpz6ycJ1HXX/mcIv5pCOtvk6YAmKuzWju3ritevEYKcWQ8p9scRqkgCzCqmwDCenDX
         lJCbFYkLXLMTnULmLJ+6pPgvWZNQP0kMnkP4k08fsp3LDFDYJlkrlp7b1BTocKL6o9rb
         heQ3Z/Bv0xvEpjvcBTkWMeJkCTbDjzgJXc4TT5HygIYBb5ppvWpN4DeBjHNtMTFnY3lg
         q9djjueyjEecbXx1BjRtaFcJ8gDpX7UmVcQg83CpgwRQ/VBIuxGNLVpIXVcxtx4XMKFA
         9bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049598; x=1763654398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSWIHRyyO3hooO64JACSCpnVieSk/9Ppr4dvEYGltzw=;
        b=TELOGH6bxjoNYEW71Pe8qTIRQMHjUdwjjsyGBZOLbjKOHYGJjEZHCDZCk4dUtULpP0
         o8lLymjaYr3aW/V1hqrPKp8I3x/wk8TrF5dAkz/QSVWudHnP/NRRq1RQTvVykNgBHLLB
         FotaFIC9CRcwWgi2I9FPuAs22Z8OWmj0rtZ6YnmMjLPXUWi1evvcBDPDvw4vTvNmLrtt
         zo1nJ5PXkhb+az6k6frMzh1yvkaZS/sWMEuxqV0kLJyDSomHswU2SWQ7FESFMPmmGpkE
         +BuzvUruMc6iAnn1X7H1TAulL0h9/vCBzUszW4JYZsbUBy2u6MYnOZI11g+fqATAfXt/
         FzGg==
X-Forwarded-Encrypted: i=1; AJvYcCWyklFNxE6IaHEaec40Gun4GroXrGipL9nnl0iTn62nmtq1NdWpyMAnk/8VYuA6kOGIRK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9duic1I41uIJZnYDP+bm0NVLo1BWBHTf/6fGzkz1lCfWRDJCR
	+uqUsSyiOqLCDIYm0dGHARoMJqCrURGIg3EaknMer/glZLWFSXJZk+Zp
X-Gm-Gg: ASbGncs6Ngws65l9om4FBvwsijpR0+U2fiST+srrRD7dOiZm7zdyGZjFN/KdBoUzpNh
	XrqZybIRVpPoMnKThfW+xg6fWcuUFhiSginasBBE3egjzj94kBdbT4oUrwDsAz6KDRUSSCilBNs
	G/MlTWrD8+x/ns0Hlabt2AkwmmtbzNGB0TLOMNk1XaBgR5Y3gI7Bvi9oKMu8KfVlI64pVe13zWj
	BbLgmSh674rhxkb1GbBerksqOPVSz5uvH1ueR8acgFTAwAYMzIkJ5+Gdap+QJ8LIdPg8YRbgkZz
	6Kc8PKNJJHSMP1SI/2QN8ypK4QvDfPolCkvzjGIEFNSpIzEx9MKMOTGKFg+Eb1oWC48w5dMdHSo
	ZyM60uIoQphWr/b/nEC9OHpm6WMtbr1UudrUUkH83biipZlhHc8aPiqF/NZUawl2khy12AvzEtg
	VzZ92UwgLWkGqa/HLsCtcoBTM=
X-Google-Smtp-Source: AGHT+IFoy3Qrt2T/zWrqrEncmeovSM7PWIvEMpppfNPTs0PN5vcTlJFJgXzZBDKyyQYJxY9NrZnMDA==
X-Received: by 2002:a05:6402:40c6:b0:640:c454:e9 with SMTP id 4fb4d7f45d1cf-6431a395d46mr6335604a12.4.1763049597599;
        Thu, 13 Nov 2025 07:59:57 -0800 (PST)
Received: from krava (37-188-200-155.red.o2.cz. [37.188.200.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b2615sm1675323a12.32.2025.11.13.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:59:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Nov 2025 16:59:50 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 3/8] ftrace: Add update_ftrace_direct_add
 function
Message-ID: <aRYAdoHh0S95C4wA@krava>
References: <20251113123750.2507435-4-jolsa@kernel.org>
 <c341189e76b2cf9bb2fe712c074bdd652f73edd5ea2f409655b2d78a62bd332f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c341189e76b2cf9bb2fe712c074bdd652f73edd5ea2f409655b2d78a62bd332f@mail.kernel.org>

On Thu, Nov 13, 2025 at 01:02:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index e23e6a859..ded3a306a 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> 
> [ ... ]
> 
> > @@ -568,6 +570,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
> >  	return -ENODEV;
> >  }
> >
> > +int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> >  /*
> >   * This must be implemented by the architecture.
> >   * It is the way the ftrace direct_ops helper, when called
> 
> Should this stub function have static inline qualifiers? All the other
> stub functions in this section (ftrace_find_rec_direct,
> register_ftrace_direct, unregister_ftrace_direct, modify_ftrace_direct,
> and modify_ftrace_direct_nolock) use static inline. Without it, this
> could cause multiple definition linker errors when the header is
> included in multiple compilation units.

yep, also the other ones are missing it, will add.. thanks

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19332026793


