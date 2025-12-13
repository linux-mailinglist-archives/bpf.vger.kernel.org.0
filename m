Return-Path: <bpf+bounces-76556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3ECBA65E
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 08:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC25230022C8
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05F921C9F9;
	Sat, 13 Dec 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vdv2tyi9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E23B8D4B
	for <bpf@vger.kernel.org>; Sat, 13 Dec 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765609543; cv=pass; b=ah2And6RrZySlWDl6WwC03NHxDCRNPju/g9VpApBThfDzpWCeMdnfzDuk/qzWXKkAkJlOrbfrUkRCnVJ9a42gVjPy8B5KVL5Z3Ad1vAeNXE80JozvlNDW15+k5Tm3WE8Tj1u09X/FwxXuJlq8yfFMxSG9K72zPybkw7+Zf2ccyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765609543; c=relaxed/simple;
	bh=oveY6ghAYYW1/assJTaVUMOm3ALmNhblLmKgXg0pPvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NP04iTBHiwl5leHsVRKKeAaBadSkHbUE9/pobfS8csAMhZNBp9WENlJI8rIOPnuMLARHAOQkOTAzvWVKVuaMfnSSmS1l6wUwtrGObOEfPIyHfPrUeapI6M0AhDhOEvTxC7M656nE8p2Lfe8KKwW0IXr8k8NHEzaxm0MsV0gCchc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vdv2tyi9; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-597ceef6eebso23725e87.0
        for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 23:05:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765609539; cv=none;
        d=google.com; s=arc-20240605;
        b=iFa1BPjyhDOjVokdNwPghcMiE/8nkQZMyb8FOt8fbSParoOAi2a+9NVO1nruvctzz2
         W7WljRbF3Y0yzXsCDyUbRdA+nNfu1NsEemlrkNOc8YnFvHiwtCtNeiSsC2rG+wo/9Ic6
         ceEATAne5jfKU7X66Vm4Y5HhUUsBrqLqelO9wQpVXgQorDiBYAaiCzwY+rYpiXhc9mZ6
         YzE48vhQd1EkcPQDPPdbGs+XGJcM6Un0XLmEQl3WwHrI4Kat5KjNQ9uLJkY35vkmZqAl
         KQtZFCBt+C9ZtTOgxtdoaodfVMpxaN20i1pe+eUC4ZtTapgUoofScZTRmdVpsyvyTJr+
         J02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ot7CTaOEn9MEJkbjFKG93I03AklZCblxqt7tGVu1gvM=;
        fh=qbJFKFqzdfJaFKB/RYnglY6WNlWDTwE5bgkfHZSCfOw=;
        b=eULocHWzT4HGwXOjR60jZ+u1j/0nA6v+icYNnw/+czXKyQjaSv67iHPVYlZK4VL4qa
         p/WExc4Bps68YSkuwdwDg+RgKOIEPAIcmnKQfPRgHLMITZnxxJNVh5IylSDAkd2vCWsc
         Qt/SYMtj1UlwlW5BsyN1oE1lDJqZCQzi6LsbntTrPnYGrOEvVtjdyEqe18mPZQ+elACU
         Q7VgVnJueZB0yOVL2mmgBlUOm3Cw+6ZEW5SD94/2rI6rcYXfwcJzNFjq6U2qCqT/iojO
         59jTocB129XwlYVrBjXsqrKC4+roE/pNLML2vMYq6BITeKqcLn1IT8o3/OK0t4rhpTqv
         C9tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765609539; x=1766214339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot7CTaOEn9MEJkbjFKG93I03AklZCblxqt7tGVu1gvM=;
        b=Vdv2tyi9knIUdlja7hzSYMktwhyhJuhZ8lIgx5gHRiSkRkoxTUosUXuYRs7RsM76yK
         u7lXmEiAoR9gDvc5YhEpjPtpQ03Jf3/WmDLkyEGtNdYa1mo70jX3emQ7DXqrreVobIli
         xhmJcU8t8LwBy4C+pqDee/3cF4Mle3y+FUGVJm1KWfuG84/LPwT0FvnleKY2NTNvT1Mx
         0thMASTd8FHDO5f7WnxgBz7eLn3gzvtiJEML69hXLgdSUs3RYaesKvvnVvPJE5npGw+1
         5D9a7ncnK4u8c3JrihC0ko9A3uNOUyw/x5eY7uVgMFLKGb3PzLjywG73mavmpslqB5/p
         XArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765609539; x=1766214339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot7CTaOEn9MEJkbjFKG93I03AklZCblxqt7tGVu1gvM=;
        b=rv1Tf1HSWhzItw/WjOV4itEy4ku3HpMdkEMrhPSLjt061aw43rLT+lSqsCWa/ojewG
         DkndBnW95vIAsWtpliFlRRDJcW1Oziu9xtoyaAPLsZYKvUDqHlNPeuS30vL8qgEZH/qJ
         /ToX38QliRyN2MowCvlmFhvWkr+EV2sUq8tQMUPefXo2UwUlrKgXjWYXtG0b7kah3MTn
         L/bpAMm0YaXBFPkaTVS/RFa3T9GEE3/5PZQZuasxhwIF//P5Xt6x/DhwtBd6hXChCvF1
         DCnjrU97mjxKcPO2NJXIAmtKuBd/7gdnDP5jgfd9CiLMD3RWwgid4zPlORKbHMzn8yEY
         2LsA==
X-Forwarded-Encrypted: i=1; AJvYcCUkwjC6G6LVNMMB6quAq1DsdxFwQUUUvTYRoS4fdub/L60YKEb6XU1F6R+mud7V34E0ox4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVdKfff6NXqUFXDeSmgxH3aX4slgFlHFIULa/761lTGAWNqV+
	SfIdowXy45mDNpwJmEVdAqL3dNdpL84UdkXHbbDXuluJFBIb6pFmo40QyLmQdXRnRD8RNtPtR5J
	apI6s7ERdMzuKgyA65DLeVLhgesLGckefOwtOmFxm
X-Gm-Gg: AY/fxX4lsS22jP+CBe1TZr/Ti6p28ogucNGU4reFKeT5KUKNP1GFv0CmHZ0h8mOdlen
	rWp47FqikVfqad7bZ1ddtXgn6RUxvICsY2wJ9e9LgbFs2M11kF3nZOkLvERf/hPbQsvnEDlhZBW
	VV0TBCpGW+UEyUpTpFDDzqKluuVNQhQ1zilSwQJ2za2IP/HmjtqJh/C6UO0OIlhV34s8KrVlUl4
	+DiQFv0+/ZWqenj99oWhag6Ud425pK1K/SPT/6/hEdheh8DoLN74mwGJPwR9/r6VdyUFsMm
X-Google-Smtp-Source: AGHT+IFxhjah2N2uFy306dItOjP0R93hkCDyo1Kn++vNhOwiYTt8khSjxmS7193oFeZUUiU7KewI20Oqx5FGrhIwBmA=
X-Received: by 2002:ac2:5de3:0:b0:594:43e1:ed43 with SMTP id
 2adb3069b0e04-598fe1eb38cmr60101e87.2.1765609539221; Fri, 12 Dec 2025
 23:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
In-Reply-To: <20251212161832.2067134-3-yeoreum.yun@arm.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Sat, 13 Dec 2025 16:05:20 +0900
X-Gm-Features: AQt7F2rPm7R-wCwVHPTjXe_bQj-qNecTeNkHkP5H4J7QvG1ylb2YhWsPANW--u8
Message-ID: <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org, 
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org, 
	ryan.roberts@arm.com, kevin.brodsky@arm.com, dev.jain@arm.com, 
	yang@os.amperecomputing.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Dec 2025 at 01:18, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> linear_map_split_to_ptes() and __kpti_install_ng_mappings()
> are called as callback of stop_machine().
> That means these functions context are preemption disabled.
>
> Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
> __get_free_pages() couldn't be called in this context
> since spin lock that becomes sleepable on RT,
> potentially causing a sleep during page allocation.
>
> To address this, pagetable_alloc_nolock().
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2ba01dc8ef82..0e98606d8c4c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -475,10 +475,15 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>                                        enum pgtable_type pgtable_type)
>  {
> -       /* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> -       struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> +       struct ptdesc *ptdesc;
>         phys_addr_t pa;
>
> +       /* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> +       if (gfpflags_allow_spinning(gfp))
> +               ptdesc  = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> +       else
> +               ptdesc  = pagetable_alloc_nolock(gfp & ~__GFP_ZERO, 0);
> +
>         if (!ptdesc)
>                 return INVALID_PHYS_ADDR;
>
> @@ -869,6 +874,7 @@ static int __init linear_map_split_to_ptes(void *__unused)
>                 unsigned long kstart = (unsigned long)lm_alias(_stext);
>                 unsigned long kend = (unsigned long)lm_alias(__init_begin);
>                 int ret;
> +               gfp_t gfp = IS_ENABLED(CONFIG_PREEMPT_RT) ? __GFP_HIGH : GFP_ATOMIC;
>
>                 /*
>                  * Wait for all secondary CPUs to be put into the waiting area.
> @@ -881,9 +887,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
>                  * PTE. The kernel alias remains static throughout runtime so
>                  * can continue to be safely mapped with large mappings.
>                  */
> -               ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
> +               ret = range_split_to_ptes(lstart, kstart, gfp);
>                 if (!ret)
> -                       ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
> +                       ret = range_split_to_ptes(kend, lend, gfp);
>                 if (ret)
>                         panic("Failed to split linear map\n");
>                 flush_tlb_kernel_range(lstart, lend);
> @@ -1207,7 +1213,14 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>         remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
>
>         if (!cpu) {
> -               alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       alloc = (u64) pagetable_alloc_nolock(__GFP_HIGH | __GFP_ZERO, order);
> +               else
> +                       alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> +
> +               if (!alloc)
> +                       panic("Failed to alloc kpti_ng_pgd\n");
> +

I don't have the context on what this code is doing so take this with
a grain of salt, but...

The point of the _nolock alloc is to give the allocator an excuse to
fail. Panicking on that failure doesn't seem like a great idea to me?

