Return-Path: <bpf+bounces-23113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB1D86DB04
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 06:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3E5B21FE1
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 05:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76915026D;
	Fri,  1 Mar 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqU3aFZF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AC50255
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709270650; cv=none; b=rze3/HZBpzMGYexHAmEPZOxSq+wxE5m1SzCocIlod0wRoG2BbhWdXvuunfVN4x7UelTcvdzXrfnmrXxnnHXO7+btxskaXmJPA/HUu4deyORmC6uKGHwjIljhvoKvgrBPW+0Axh++gb6iijEy6kJVPb2/mlXehwu+Y7/8rF57VeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709270650; c=relaxed/simple;
	bh=Wm5NBwIRT5KKMr5yQtDWjoDLkC6KOgGHMq/F0U5ciMk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RxmWzKm7WvLtfHMVoJfF3iSA04TVwqaVEmIl9QKqJ3cJWAhGyBYLLUKoNYXwpHx9OkKw1wypXfp10pQ0XAiQCXlIywtBMNo5r0AEnAxym58CFAd5s6kIfx+IVqrztNIHCWVCAPAqIlp01bM9Wew/a6rA5vyh5wtrpwt1i4Tq0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqU3aFZF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e56d594b31so959879b3a.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 21:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709270648; x=1709875448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWqm/JLP5b6YDg7EBDqC78oeBhNRqG3Eb3S/kiNKP5E=;
        b=RqU3aFZF9BQeurnAe+rfRnpQz6a4EWRSboVmbYxGcVHrjzrJyuxtEftAXqPCELCsac
         nA3AX4v0CBwH08ZkIK/d2uZVKxFniqw2L+HiMkNQ6TIpAxIBMIIJ/xu7AqZfSQm88TVv
         KI5JgEG2Wsz1VGRjzMO2gUuPwnbX8qbKWlK/R5rtkBYwZ9h8osDMBb7TIRvXnsV1IQ/J
         wky45ZFzPSHhJ4bNICqYLbxpiiLQjAuau1UrXsykaUT93D8jHPvBQsRQuIml8YYLcByg
         j85g1EMn+3HNE6IqJ6HmdMCpViBeuPRIGvszpvNHhxHHV/ToCw7gw7p2pBAWb6OaUjay
         QMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709270648; x=1709875448;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWqm/JLP5b6YDg7EBDqC78oeBhNRqG3Eb3S/kiNKP5E=;
        b=oyYWgoxUeLC4qGEei8SzWmoGepKiysqApMlFLI4vsmAIl+QRJHtzUFChCt44F5AT4/
         8Z1Vq5Wf8SmbIUMwP90DyD+TyOhdgCYmB6pGWaW5ls0pw4YAAZnIS6RJz+j9vyA9MvYp
         Ev1WP2gkFvx4MBA0//fgIT/2+Suf9UBsj4GIJro5xHRCwiGdYc1eozYA3N1Qbyd5c3rN
         RRIzKkcX5RsLY2qSY0cVhH6F+zTicK6x8iXW6czwMABcRakLeE64dU9UKKXAx4lWmBa4
         k/zvu3oF9c/XVnX27vmrjGknY7CUELBY+ttSacXrsBRAxKiM4mQpVM8BZvaPSVCj7Tda
         UKDw==
X-Forwarded-Encrypted: i=1; AJvYcCUfpuZPJp1WVffwb7e2Z0l22GFRP3T4xu/0SoRTyjSa2E/RJpEz9fm65jlyYkwSetn3fdLYKJK2U/OeMRUedWuaOdWO
X-Gm-Message-State: AOJu0YySVnq9C0Gud8mhKwZmUEXYMNC1q3z0XNpKZTgBNdIKjqXoFqpW
	S7jNH7SqaJCc5wZDgziw6inwPoFtuUZFePnVH6lxDLgmAsgC4vpg1tfoTYPG
X-Google-Smtp-Source: AGHT+IEZ+YzvH/JiK/+esK3IOFVWhVFn0i2xnGNBrauA1cjiA3mK/YcbC06H2H29Vh7nIrSPznyyOg==
X-Received: by 2002:a05:6a00:1a8b:b0:6e5:4f19:c863 with SMTP id e11-20020a056a001a8b00b006e54f19c863mr981182pfv.33.1709270648110;
        Thu, 29 Feb 2024 21:24:08 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id u2-20020aa78482000000b006e48b41aba7sm2213534pfn.12.2024.02.29.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 21:24:07 -0800 (PST)
Date: Thu, 29 Feb 2024 21:24:06 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 bpf@vger.kernel.org
Cc: daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@kernel.org, 
 memxor@gmail.com, 
 eddyz87@gmail.com, 
 kernel-team@fb.com
Message-ID: <65e166766200b_46ebe20895@john.notmuch>
In-Reply-To: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
Subject: RE: [PATCH v3 bpf-next 0/4] bpf: Introduce may_goto and cond_break
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v2 -> v3: Major change
> - drop bpf_can_loop() kfunc and introduce may_goto instruction instead
>   kfunc is a function call while may_goto doesn't consume any registers
>   and LLVM can produce much better code due to less register pressure.

Nice back to the original instruction idea for loops. I was walking
around thinking about this for last day or so and had the same thought,
but you beat me to it.

The original troublesome parts was jumps into the loop. But will read
on to see the solution.

> - instead of counting from zero to BPF_MAX_LOOPS start from it instead
>   and break out of the loop when count reaches zero
> - use may_goto instruction in cond_break macro
> - recognize that 'exact' state comparison doesn't need to be truly exact.
>   regsafe() should ignore precision and liveness marks, but range_within
>   logic is safe to use while evaluating open coded iterators.

I will need to review last bit is too dense for me to process right now.

I think this will be useful for lots of cases.

> 
> Alexei Starovoitov (4):
>   bpf: Introduce may_goto instruction
>   bpf: Recognize that two registers are safe when their ranges match
>   bpf: Add cond_break macro
>   selftests/bpf: Test may_goto
> 
>  include/linux/bpf_verifier.h                  |   2 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/core.c                             |   1 +
>  kernel/bpf/disasm.c                           |   3 +
>  kernel/bpf/verifier.c                         | 269 +++++++++++++-----
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../testing/selftests/bpf/bpf_experimental.h  |  12 +
>  .../bpf/progs/verifier_iterating_callbacks.c  |  72 ++++-
>  9 files changed, 291 insertions(+), 71 deletions(-)
> 
> -- 
> 2.34.1
> 
> 



