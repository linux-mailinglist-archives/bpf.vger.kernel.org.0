Return-Path: <bpf+bounces-18796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BAA8221C7
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10476283BFE
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59A615ACB;
	Tue,  2 Jan 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtnYK6wb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3515AD2
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a287be6dbc0so33118666b.1
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704222605; x=1704827405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pCASdLLzD10L7upCS8lK+gQbaRuRgH9yhB7td0UZdE=;
        b=EtnYK6wbBHqwkzxmh7tZouOrIJevN7RMTWHf2nitQWXnMCMXaZNYoylL0yurzlZ/+j
         ghkCN+B07fU4rD8V2MXFL8AJF5MDF2sgIXkcS3WgJLYMCUUR1/ODchpTvVv7exjDqZwL
         SzWKY8vZuevVjvAqANnKe/L3vlekSxO2obbmNS1fsH4U0EsYFN+9rkHWB18HL2XnJcGT
         hNRWYHGpBDm+SreMmJH5cxH2R7PnZRg+affBTKJdPFPTpMWKoLAQA7JrqhfBBD5AMiF/
         ZdOKSyTWV4YGzUdjDH5cCDc+YT7+WbTGI591uhaRLiRTmSE+a6H63L7kr+GMPajwNKhL
         7Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704222605; x=1704827405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pCASdLLzD10L7upCS8lK+gQbaRuRgH9yhB7td0UZdE=;
        b=OR/Dy7ffKzy2TdIi/goGx8MUrv4s42rhVQQm6Y9uSqhTxYUAFSca2rVyfg34l+C2Bs
         rrUbI9Q7x3whehxo39bg1/y8cHyFOxM+hyzZiePUpsgGKvhOnCqvPNgLuU2V2mYvyhHN
         2f392zogqLsQBllXCl4okWu03cI+erNn/H6Eg6/C+z/4B9myO/ODU8Oihe2QbXPPuOmk
         Or8GPDKn0bfXnpUYmTO4K4h5TNGu+RfYPLO0H3mA6LF2r8YbUqazoNAaXqhLIyvXZujH
         Xlc2Y7l2Z8uwmXe7/puXnbNHbsp/a73DWWCeG9LvHIUXMAwOVFJ/cjvYDxXM1/ChCCn4
         9Zag==
X-Gm-Message-State: AOJu0YyyzMagjAO0IRD/O7gThfXbpL/Yo149Df1PFr3oyyWESFLC1qJR
	Ho6nyC6DskrbFMO1dakdvqb9oYcIhpBY/Q==
X-Google-Smtp-Source: AGHT+IEZ+jyi2ir4NYyVz7+jfCViuf3KZeiGXlIeLLGB4CXo0EvoMec8GASNJmTAmghzb/kZXnHETA==
X-Received: by 2002:a17:907:36c4:b0:a27:6615:1654 with SMTP id bj4-20020a17090736c400b00a2766151654mr5615177ejc.118.1704222604712;
        Tue, 02 Jan 2024 11:10:04 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090791cf00b00a1db76f99c8sm12085736ejz.93.2024.01.02.11.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:10:04 -0800 (PST)
Date: Tue, 2 Jan 2024 20:09:55 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v11 0/4] Relax tracing prog recursive attach
 rules
Message-ID: <20240102190955.y24pg46e2yy3wprx@erthalion.local>
References: <20231222151153.31291-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222151153.31291-1-9erthalion6@gmail.com>

> On Fri, Dec 22, 2023 at 04:11:46PM +0100, Dmitrii Dolgov wrote:
>
> Currently, it's not allowed to attach an fentry/fexit prog to another
> fentry/fexit. At the same time it's not uncommon to see a tracing
> program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs for
> offloading certain part of logic into tail-called programs, but the
> use-case is still generic enough -- a tracing program could be
> complicated and heavy enough to warrant its profiling, yet frustratingly
> it's not possible to do so use best tooling for that.
>
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. But currently it seems impossible to load and attach tracing
> programs in a way that will form such a cycle. Replace "no same type"
> requirement with verification that no more than one level of attachment
> nesting is allowed. In this way only one fentry/fexit program could be
> attached to another fentry/fexit to cover profiling use case, and still
> no cycle could be formed.
>
> The series contains a test for recursive attachment, as well as a fix +
> test for an issue in re-attachment branch of bpf_tracing_prog_attach.
> When preparing the test for the main change set, I've stumbled upon the
> possibility to construct a sequence of events when attach_btf would be
> NULL while computing a trampoline key. It doesn't look like this issue
> is triggered by the main change, because the reproduces doesn't actually
> need to have an fentry attachment chain.
>
> [1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/
>
> Dmitrii Dolgov (3):
>   bpf: Relax tracing prog recursive attach rules
>   selftests/bpf: Add test for recursive attachment of tracing progs
>   selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
>
> Jiri Olsa (1):
>   bpf: Fix re-attachment branch in bpf_tracing_prog_attach

I guess this got lost during the holiday season. Is there anything else
I can do to make some progress on this topic?

