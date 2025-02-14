Return-Path: <bpf+bounces-51618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269AA3682B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4ED1890387
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F01FC109;
	Fri, 14 Feb 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYKGEZP9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347741DDA18;
	Fri, 14 Feb 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571272; cv=none; b=Qb7ujbdRLk63GM4nAEtHpb36Nzvot3P5ChpIpkFNVX+sQuSVLTI2XC6fTogR3x331Q14d6T0bfebML12UZ/sYbe5pCqQU08dug4TQtIn2fzsWqWXCiy/uTAhWQnIDRIdCeAnq/0jDSZDj0l3KuG18Jd6grVCW1UN4S3Bks2t0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571272; c=relaxed/simple;
	bh=HIsehv+iWAWVMHHYckz3gqMXnT7YI+cVRjsvqR6vsrQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRpCo9FjoVST6lBK6YWsF8YkGWDIEQWp9xsq6W9QjJ5JFkw62iV195bdi7LxjY6mskY9uEq/Fh5vVGP0WuSI0Qt7xKrpF9Oa638m/Ex96bUkr1q+ZpDOeDi1KYAciVnH2MFO1/FPqUezjxIPgplfox19NhGl7jYVrGUY/B2cFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYKGEZP9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so4090234a12.3;
        Fri, 14 Feb 2025 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739571269; x=1740176069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEB+wipqpxDExoX7XkJyi7zxDfuglvJ+HC5Ljm+PuFY=;
        b=EYKGEZP95Mh5IUFfOEHxXs2I9qpTnoCE2q/sbx98ayfP2Kb92NBL7w9N2Q3Y1nisDR
         ulFPQcJA2mNxp/BiFLODSGtO1X5YZt/6C9nRtYmkKfYuRhp19ab0HR4r2rYhznHq1byD
         xrXUXr31gPU1MpT4dmPlchcoeLI/EJbxjX8f0bGlDTHORPF1S0Du9GabCvbX+4ohEaRM
         E954HyhnQnpxWdZsoqyUlO5G9fLJKvyNFngqiIwwVTts2iYavQJAMU177YlYvQCsH8cQ
         RiR+6W7gfVPKLVk3nL20RxgW9FaEqwt2LUCPjbChbAFNBygt3kTgZ9827DPmlKXklbOg
         qXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739571269; x=1740176069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEB+wipqpxDExoX7XkJyi7zxDfuglvJ+HC5Ljm+PuFY=;
        b=B/mXjqKwD7TzZE6AUZXztYny1vlYpi9Yrj8JPC4DhNmJizJMlS+/Qfqz9nQwzaHYgQ
         oAF2WnRpCdnr6KZP/8EJYdcYFFQnwJJ0T6o9SurcNQNPBA5INphKZZ2C2dtjirFcC/9C
         QYQXW8JxyQF4+++tnYIoltFcDlEguC6t1o4yo1y/AYLuk50Iiwn+YU4/kjFnU+pkBqEN
         S+UDs9UcsWV3F+2gHw47iDjxBeZlkH6fLoe3MT+XZPXmnsq2zDJULa1niKuHT1CUSeVj
         GNqhrcvQ1yow6ena8TxqbPldZG1XodgrUqRyqMie/JpHeK3r0l4ghzqUa5G9dSGQ2QzD
         MIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBNVGf7FF6B6I0k4Rr5WWRtuk+xq3++ip9uZS7K5Wr4ZbRgOJ72WPY8UFIrvKWUK6thhmr+lVrj85eWg==@vger.kernel.org, AJvYcCUBtk0+AVl/cF/Qbul9soD61IUE6n29xpTAQIoKkMccBgbVVqVopaDgdiC1igNrZM/dvGI=@vger.kernel.org, AJvYcCVZq7ROyxVQ7xL1NaOry5yXMnmuMyi9TsUM5GPDDA4nweSSIwAu8dz9DBd0CSzol/gKhLP/hCaLoGBBZZcG@vger.kernel.org, AJvYcCW78kdoJUbcS8Ci6PKzpGQPGj2K1sYN09N93CfyCIDPsIFW8zibRlsCocBlczC2r3E5m76+sx9kpPUIoYk6Rk9gMTIC@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsfeTYTwNLFispEsCCZDhEZnrNEah6/HwYlXIUXxm4UUvm+4g
	pdYh/EFMuTSm3xX9lKPHYCoW+KSnuRShtalrdY4Pm7duNp305I1x
X-Gm-Gg: ASbGncu26dkFW4irT/qU9laTdGnVt+5Jwaiq2AFdjjE8qcYp+NT2Yq2sQ68tPCDw8Br
	SRSQMebSMuk0+YEA9o28s1wCwDEvAVOkaAwSPUz4fn7EH4hA+mziSkYk5Ho1AFf9q8tIJnKRS1m
	HuJCQtjh2g8GYF+rpwcuyiqmdVcuNaWjbiJG343huimvzS/nJpdSsy6rDk3X9iSLKnaK/FlLW3I
	xwAYgp+7RvQP8UH/T5hcFlqk1yOSANRMFEuECEIHDFpOhc7VdWpg/+RnQZ62zM0JAdb8ka3P/0e
	8DR0+9x6BbYFNBpS9s96FZxPROiXWZymowmN
X-Google-Smtp-Source: AGHT+IGhKMUt6pQQ2eEdpEq9Kp47Mlkh7KYX18Dx2znHH1AwQvYGHh0IRemg9M7NamftnrBLcT9VIw==
X-Received: by 2002:a05:6402:5210:b0:5de:dc08:9cc5 with SMTP id 4fb4d7f45d1cf-5e0360a1fb6mr766609a12.7.1739571269178;
        Fri, 14 Feb 2025 14:14:29 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c46b3sm3547034a12.21.2025.02.14.14.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:14:28 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 14 Feb 2025 23:14:26 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 4/6] scripts/sorttable: Zero out weak functions in
 mcount_loc table
Message-ID: <Z6_AQmaUWAekeB5B@krava>
References: <20250213162047.306074881@goodmis.org>
 <20250213162145.986887092@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213162145.986887092@goodmis.org>

On Thu, Feb 13, 2025 at 11:20:51AM -0500, Steven Rostedt wrote:

SNIP

> +static int cmp_funcs(const void *A, const void *B)
> +{
> +	const struct func_info *a = A;
> +	const struct func_info *b = B;
> +
> +	if (a->addr < b->addr)
> +		return -1;
> +	return a->addr > b->addr;
> +}
> +
> +static int parse_symbols(const char *fname)
> +{
> +	FILE *fp;
> +	char addr_str[20]; /* Only need 17, but round up to next int size */
> +	char size_str[20];
> +	char type;
> +
> +	fp = fopen(fname, "r");
> +	if (!fp) {
> +		perror(fname);
> +		return -1;
> +	}
> +
> +	while (fscanf(fp, "%16s %16s %c %*s\n", addr_str, size_str, &type) == 3) {
> +		uint64_t addr;
> +		uint64_t size;
> +
> +		/* Only care about functions */
> +		if (type != 't' && type != 'T')
> +			continue;

hi,
I think we need the 'W' check in here [1]

jirka


[1] https://lore.kernel.org/bpf/20250103071409.47db1479@batman.local.home/

