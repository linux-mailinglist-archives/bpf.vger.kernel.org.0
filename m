Return-Path: <bpf+bounces-29120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC658C060C
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B6BB21DF0
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BE131BAE;
	Wed,  8 May 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NKzU9+SN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93114A9F
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202603; cv=none; b=QAaRDSzlQcFtOoeV7YDDRdmP87PNMhv2w60zjfG8RXK3yEeKsopY4lWs0glWJ/ovj8D8mNsaCu2OWXQnNz1pIap2pzVukSeFTa+8oYEHeKavj5dRYKKGq7dNZ8ugmTE/a9g2xXUe3AmO6QzC2Abo6JY/wIrhDaZw2IdZcGcJ8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202603; c=relaxed/simple;
	bh=vFL4B3wK6V0zyeCGMUE/eo8ppygLhYYUWQCOaznNGKA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6Ye5T1a4qkR2a7POL09PID9E1K1umfUVxNWM4oH8gL+JXesiijUVXQIVtEt58OOztCiRrOPVdf6ZOE5tNCQf0E9+r/YAVQlMmWhsU3zRHSk/zTNKXJ3JS51F4D9x2ppQsISQ4J67H+PqQX096s6zEtyLnOvS3/EsZiDo3IIqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NKzU9+SN; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c97a485733so151794b6e.2
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715202601; x=1715807401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=malKjFparRZHby6p2gcvIikID9eemr65ODf87siiN6w=;
        b=NKzU9+SNHU4gmkfECNrn+IB9sOoXSd4NtcHgBrmp+w2E2ynUDHqRVS/FaGLIPaEt7e
         wS+uFPZAepuSK4ldrMU2CrhXGDNuDPxFn6bBOEIpoq6ylGyxuDDK402Jy6Xa+07XVwZS
         bRQgd0aaOjXzg0sQlp67b0n+PAtyFq4sRMWlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715202601; x=1715807401;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=malKjFparRZHby6p2gcvIikID9eemr65ODf87siiN6w=;
        b=o6tZoQX6h5v8DwBfl9zhv+UccT7R0YLaz2IeAx8c/L/MUtbf9grMzXmBv7u6NJVWYh
         NAuLU4Ul6vLTT1xy8rieFV+MDCx11sm5qSKXzPw4kN1KEQ1D3ES4XnujGamgxvi2Noh9
         OTUDPTJbeTP3OiZQjQWmfI9BEF8XZlIH30WhItMEuFSsPJ/E6cQNhw3Lk2KRn5iNCF72
         VYqdlP/SIHnma20q0wm0PqKsV9rYIyO6KSRg2T7uc4edScsuW8w/YQSCRPwgU/1m2WIG
         GtHbBa/1+dwWTBHEBhU/o+HXJKDSJW+BxBNaI5rPCZf2TXPMudWOUxxadbKA4fsejhsk
         2gUA==
X-Forwarded-Encrypted: i=1; AJvYcCU0VEOx5aLAIJ2AipPbypXyIRRxzy5xRznBX+QsAD8v3QbxpdgAgJ9fnxWSJEdtoGerFxxD65qoAMPw1QXuoa3aWkBv
X-Gm-Message-State: AOJu0Yx4TlOt0rfjypqie1+PcFURlkLaRWfMw2gQfy7RAIw+OeX5yHVq
	nxW/uqWYD7ngrQ7bS8a2sL2rYIZSqsb5AmOTPoyW24hlBhacHUzO+0Gt9KT6RX20+U8aa6Dz7q3
	YyoUSyTSRJzHXeoGZZElC71tjReCv6qqY6XD8
X-Google-Smtp-Source: AGHT+IEdt693kG5CsvJhhJKxEwutqN4U04lOEMxarSx84uS+eZ/8glpfYJEhQ71dRPpHXu+PbW6nNTnvO6fe3wEXqgw=
X-Received: by 2002:a54:4604:0:b0:3c9:6cfb:bf4e with SMTP id
 5614622812f47-3c9852927aamr4063549b6e.7.1715202601233; Wed, 08 May 2024
 14:10:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 17:10:00 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240503171847.68267-1-puranjay@kernel.org>
References: <20240503171847.68267-1-puranjay@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 17:10:00 -0400
Message-ID: <CAE-0n50Pcmjq7b3F7OiU066FR3vk9avU22H0OEcoGcbGVd14dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64/arch_timer: include <linux/percpu.h>
To: Catalin Marinas <catalin.marinas@arm.com>, Douglas Anderson <dianders@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"

Quoting Puranjay Mohan (2024-05-03 10:18:46)
> arch_timer.h includes linux/smp.h since the commit:
>
>   6acc71ccac7187fc ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
>
> It was included to use DEFINE_PER_CPU(), etc. But It should have
> included <linux/percpu.h> rather than <linux/smp.h>. It worked because
> smp.h includes percpu.h.
>
> The next commit will remove percpu.h from smp.h and it will break this
> usage.
>
> Explicitly include percpu.h and remove smp.h
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

