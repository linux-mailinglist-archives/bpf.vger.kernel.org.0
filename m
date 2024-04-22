Return-Path: <bpf+bounces-27401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8B8ACC8F
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E521F215FF
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE31474A2;
	Mon, 22 Apr 2024 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFHTz0AC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC1146D66
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787900; cv=none; b=artANhV4DR32H5IzrVL/TtPlqSpFwJ/mthkY1SJwZaFe2HDn2bWCZA/ES9wHVDKdcijlYW8MN9lzcDfti4j+k7VWJgRAHVmBWnspUJo8arynUk1Un/pr6BoDqsuCGa6wup5VJBscD9x2JZ1PHKT2K8DySXnEk5espT0KBbAZT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787900; c=relaxed/simple;
	bh=P+ngD7651DKaxK2xXQRIyCnuFIb7V6Y5I4v0Y+4liW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiYpLaoJ1gNUTyjO5YX7qfaH2obKB1zbvwWpLywHumv8e/BYZsS1PsSC62tSy9gWhy0oFbFs5Fgf+DdZoqXWT6FYrMzysyuaZqyQoKcpHS91/9uWp8gbf/X6omxWYvNkAmgOw+oZYtN8vGe7ytOhcsfTHr0wBDZ1JuMKp53Yw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CFHTz0AC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4187c47405aso28692765e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713787897; x=1714392697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCRnuZK0O/QOXHu1Ldkstjl1doP0jCVLWLbPZKH0WnQ=;
        b=CFHTz0ACeA5cePDuWJvlh0c8tKCX+vdZE51F+lymx2ic2Y7hs2eXx05OW4IBWO5NY7
         enwTee91Ffu3VfDwyIkmea7VIvN1ABlqbVpYWHDO8qGLChX0hoAO+wasQMUtc896zpHB
         QxjKoTPskxJNDiDIqOlKG4CIT6U73cuCt0Vs9fgQM0ezVMx0psIJB9CigTkRj5XWIUKW
         xaeJd3fUGhkumQtrwTPbnfBgS5vg69UeFthGeF6sKzOfXwJNG5K2/VFS9jCmhxkfP77J
         31QAA9xu9VEv3dBKe3932dOMZdSw5hMYLReIRTM78EV4NCYcxeN6zzWPjQTuz5Shh7PR
         Wv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713787897; x=1714392697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCRnuZK0O/QOXHu1Ldkstjl1doP0jCVLWLbPZKH0WnQ=;
        b=i6JveurZtPiYUlbUjQ+lVDfNYLwHKwz1HasaTyMaUl9+HFnbSuj/+HSt4t2f3znyGT
         +0au0yrz0W2f31hDpKCWYSwHxyIPqxC8JS+2wjcm9UvPLEEJX8y8lSfGnZ0Is3IHEdLg
         aWKWMlSoss6Z+vcgUK6PqSGyhjphIdUNeqsCtuwRW3rLEfCBCEdlTs4ilmSattPnOeiF
         YZ5sFPcaKS7fG586M4MC5PPmaxRkMHSavlnIS+sEG7ETDZ4oxEoHdTh2y5zxlAGNPXJh
         k0C5E6SHZfxzJB1tsbjAA88GIZeAI+Acb+KaN0Dj763xA0MTKSx+e8TmkipYd2bOe5xn
         ghdg==
X-Forwarded-Encrypted: i=1; AJvYcCXlbMGq7IGaB6RwDGSCeJrOPxa8Hj+MN7ppUSCbBRQjRqNaBQ7V6XOK7u37pU1rPOQA5Egpr0IswCF+GL6qHKRbpAhV
X-Gm-Message-State: AOJu0YzAx4XtJu42prpuViTVRXt8ZDby9FW5YY0JII4ZIHQetQosgGNQ
	+klKhPuNXd21JrMPAlPf66Dp5/S5yr9zOQaWWtFydVU9O9ubmKRjxIAe1kmSPjk=
X-Google-Smtp-Source: AGHT+IHynTNWSPs7rYJt+CqENDAY0rj5tOUJ3mwkpUrvPfTTqXCsLGZ4LMBMh1xVXt1DdTNJhAB4yQ==
X-Received: by 2002:a05:600c:3552:b0:419:7fd:2fbe with SMTP id i18-20020a05600c355200b0041907fd2fbemr5536580wmq.11.1713787897251;
        Mon, 22 Apr 2024 05:11:37 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr. [83.193.250.196])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm16503881wmo.34.2024.04.22.05.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 05:11:36 -0700 (PDT)
Message-ID: <fb942d49-1c72-40a6-8309-ef3331d8f8dc@linaro.org>
Date: Mon, 22 Apr 2024 14:11:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/15] arch: make execmem setup available regardless of
 CONFIG_MODULES
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Russell King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
References: <20240422094436.3625171-1-rppt@kernel.org>
 <20240422094436.3625171-12-rppt@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422094436.3625171-12-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/4/24 11:44, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> execmem does not depend on modules, on the contrary modules use
> execmem.
> 
> To make execmem available when CONFIG_MODULES=n, for instance for
> kprobes, split execmem_params initialization out from
> arch/*/kernel/module.c and compile it when CONFIG_EXECMEM=y
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/arm/kernel/module.c       |  43 ----------
>   arch/arm/mm/init.c             |  45 +++++++++++
>   arch/arm64/kernel/module.c     | 140 ---------------------------------
>   arch/arm64/mm/init.c           | 140 +++++++++++++++++++++++++++++++++
>   arch/loongarch/kernel/module.c |  19 -----
>   arch/loongarch/mm/init.c       |  21 +++++
>   arch/mips/kernel/module.c      |  22 ------
>   arch/mips/mm/init.c            |  23 ++++++
>   arch/nios2/kernel/module.c     |  20 -----
>   arch/nios2/mm/init.c           |  21 +++++
>   arch/parisc/kernel/module.c    |  20 -----
>   arch/parisc/mm/init.c          |  23 +++++-
>   arch/powerpc/kernel/module.c   |  63 ---------------
>   arch/powerpc/mm/mem.c          |  64 +++++++++++++++
>   arch/riscv/kernel/module.c     |  44 -----------
>   arch/riscv/mm/init.c           |  45 +++++++++++
>   arch/s390/kernel/module.c      |  27 -------
>   arch/s390/mm/init.c            |  30 +++++++
>   arch/sparc/kernel/module.c     |  19 -----
>   arch/sparc/mm/Makefile         |   2 +
>   arch/sparc/mm/execmem.c        |  21 +++++
>   arch/x86/kernel/module.c       |  27 -------
>   arch/x86/mm/init.c             |  29 +++++++
>   23 files changed, 463 insertions(+), 445 deletions(-)
>   create mode 100644 arch/sparc/mm/execmem.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


