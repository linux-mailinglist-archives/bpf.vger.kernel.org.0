Return-Path: <bpf+bounces-59294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260AAC7FEC
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 16:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5091167DC7
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8E21CC64;
	Thu, 29 May 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKqHj12B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2839FD9
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530667; cv=none; b=qE8s9MVwmh9L+pKRTGZjZVMAbHAky4/jKukZ+QekH+y/LYm8QR8CkArCugVi8u0fvxI4Iihp5DLj0dpFUOwknk2DuIHdydoTUDZEtV2gx2cS8GrAjPQmImct/Imv6P3bHw8180bfMzOQfWpc6zGLIT1/oU1zZM5ikvciBhzh0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530667; c=relaxed/simple;
	bh=psfZLHeyREHCVQegkY7Zsa7aT/U9kQb26jNSQ0iTYzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK2Z3ndCiBIi7CVz7a8ZSUXQodjc1Oi1SSCYaAKC8CH8bw/lCHtGDok1JC3Rm+fSuIqutXBz6eayrTTpyAUIcCs7S5W7GzsHAKgCMv8avUwx3eDp04bCKuI9waevqAnuqiYzm7pTn1BQ850OdvL+RuxO8pj9bOQM5tCBmUJf6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKqHj12B; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad883afdf0cso175371166b.0
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748530664; x=1749135464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AdqwIO7K6IALlSgcSE/H7dgnTcHvkA3eSwPXu7IMbgw=;
        b=SKqHj12B3D2UsYJdfXcMEPwrX4kxNs+NEmc6q8yAKZCsG5NOAgC6TZqaPMpARdWUrS
         5U1VIFxm6xiGp7ZW0nBh3MV3JV72Itf/64LYz0Le08B1A7I3/y83qNFSsK5z/dpHWxmv
         nvA3HqOsx/yofD6mgZEUVBqr/gQSGmmxYbTvuIpaSYqWzcEW1wppPKu3nI5RzJnP1aNt
         VwLp4hQQxp1Ja6dJEqSwxKQAEKg3PfqRHuhgOh4yimUneJVfryLV0lD/leDud7oNoIeK
         kXP0PU+ULX+JwCmjqnB4YUNUNB7V34r9EWoI7AyPKJG1OmSaoBdkxQ/XJyyhrC8pCr36
         xsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748530664; x=1749135464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdqwIO7K6IALlSgcSE/H7dgnTcHvkA3eSwPXu7IMbgw=;
        b=w3SANo8HiWhd+E9YbsOPdLp8HmM6WWjYj81KUucZFrCnGIizaQonbMqpaJM3R8Msu3
         YkqSSAl2j7jCFTxI/rnRzk1+fEyjmg2FEqFtChIxvZrXeajA+h6d4KjQKC1vQnYOuFJ3
         wVKFKNHocrR/9FKJLBEL1t7qLsWBZ6KvKzRYdKiuhcIzWYP78PTx04KJ0qM4xDWZJx36
         5Dq8DIciQzDp3LaQWn/vREqJdqDv3gWZBRt8LB95lnob9A9RDlI34OF76/6Mij+2RkOv
         +m4GxjzpBdkNq8kfRU+0M0+f4+wLKPEiyR2m9s0nuuoVMR6kg1v4dZxSZJPSMliBaRR3
         979g==
X-Gm-Message-State: AOJu0YyFBKs2/VGi9QF8GXgg/SnIMbTnKi8TLZltqdyZht8PnNb+N2cl
	IcI86WBJg10/Tlh9fqBxGox9MTykUa49sz806tRbXjRuvRAuhvfhjYcgT7B+iX5ci+x9JTELktL
	LVRw5xShX4pziaWDY/Rj3CQeJrfs6hWs=
X-Gm-Gg: ASbGncsIgQMk2GydrVyYgzjyEUXUhK1nZ+wX6mwUOT1/5iXD334i3s9EpRHeYJ3sA+7
	377wBfIpUQjXxI7Qp5bYBKTQxKFG96YqSrjgWY5vwgHflxxc8mrP+LZzqFcA/EQ0qJ1Mkdzaeg/
	VL/FVn/98yag5/1QTYJPGmYpKTfAjLnbWm+5NT77baU618UOVKx9QBgo6WHV5PYGDoOGo=
X-Google-Smtp-Source: AGHT+IFB3LG3YTb+pYGMMX/aif8T7yR7bvKEYAZWJbeifhQMf1ObJDUEfPAG5BpgYt18bRCtZCU8B2vBNBOGMnNYnW4=
X-Received: by 2002:a17:907:7245:b0:ad8:9466:3344 with SMTP id
 a640c23a62f3a-ad894663456mr1028555266b.43.1748530663916; Thu, 29 May 2025
 07:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-12-memxor@gmail.com>
 <m2wma01xaz.fsf@gmail.com>
In-Reply-To: <m2wma01xaz.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 29 May 2025 16:57:06 +0200
X-Gm-Features: AX0GCFtDeBWNJT5AQtb0VQ7c5jPndSnNY3hOpslNa9x0HU8zaG9HoUlT9eOfYIA
Message-ID: <CAP01T77AyzvwW7p7BBpNTdzWCEU7PLFqMgN3xg1dG5ahz_K=Bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/11] selftests/bpf: Add tests for prog streams
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 19:04, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> [...]
>
> > +struct {
> > +     int prog_off;
> > +     const char *errstr;
> > +} stream_error_arr[] = {
> > +     {
> > +             offsetof(struct stream, progs.stream_cond_break),
> > +             "ERROR: Timeout detected for may_goto instruction",
> > +     },
> > +     {
> > +             offsetof(struct stream, progs.stream_deadlock),
> > +             "ERROR: AA or ABBA deadlock detected",
> > +     },
> > +};
>
> Wild idea: instead of hand-coding this for each test, maybe add
> __bpf_stderr, __bpf_stdout annotations to test_loader.c?
> With intent for them to operate like __msg.

Good idea. But we'll have to run the program, which is slightly
different for each type.
I guess I can just support tc, syscall etc. for now with some default
setup to support this.

>
> [...]

