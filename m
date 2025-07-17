Return-Path: <bpf+bounces-63608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CDB08FCB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFAC5601C3
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479F2F7CF1;
	Thu, 17 Jul 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo38WBMM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6412ED16D
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763726; cv=none; b=lO8gAIkj+6UGujvE5DB7U6hxxSzAhcCTiW1fgYg8TWiBcbZ2z5y3EoqCCGJj46cZMGm1GPOUXF4SDm0xljXJbavfrZSoCDBQY3gcAQ0YbWq5xvGk+XbYQnXBEpmPnDkISeRb842hRmJfl8J++hFq2Rg3ged/h0kugkm8oze3Wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763726; c=relaxed/simple;
	bh=T4kaRAGegsGNL02EHEAOd+xPxcbsrg2pfxrrvo0cJ/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js7TkxAkE+VIyrYESi/FbOko16FZTJ99IIejdJ4gOs+31YpBlxMBfZvd0b77WBbuHLko6peBqZWpqu3FVZKkHewUpMdaWym9Uoeii5LW5CEwgDeVYwXgLgL7if51280GxIw/Rg1u30M+MlHHeR9bruIKCEyoVXeCZxojPv+6Axc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo38WBMM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-611f74c1837so1860643a12.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752763723; x=1753368523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iw/Wu22cnB7NCngBl0TR+xjDDf5pHdg2GDKrviJBZ3c=;
        b=Mo38WBMMWYO8vh8dWD2zd46zTKwCucZfgDmaEa2MoB9yRNMdCYmrlMEuatj9M4WHAj
         G1EN5oU1ejyr0gdp8dvJePGi4G/ueiU6uFSZuvdEjuW35c06CU56VN6A3+gv6JG+SzHL
         5oExlEVZW76dBng/14Zh94RpfIix4VSpEON8U/QAkyRf/YIFWRPOR/Tv5+POkWV04mrP
         6WrOvmUqlTseoI9Aq0w8aRSNNsBVhTN+fSudh0siYRJUg5J+7ELu5OMXpcSWF1uQfz3m
         KDWnnXLJWqEPMXPhtqcy990xEEJtTtLr9SFNTTE5go6y3J2yDDA0cYLyM1Uc9G399oc9
         JuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763723; x=1753368523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw/Wu22cnB7NCngBl0TR+xjDDf5pHdg2GDKrviJBZ3c=;
        b=AJtZaBLnBMXuEb7wJhCY+vs17sV4rdF32Qu654Xu/F1TchwLdS8sHogLDv8NJ820Nr
         mLnfUkmy2EMEQg1CfKdsF6ory+VeVROV/g/Om9K3kFO0e11hjEGwHSTlHGvhjELIec9p
         z6dnB5wWIUC/C6+GrDvVsHDGUpqqGxAnpgVLDZstt3eyskRbduTZKc3LtPom3+JEL5k+
         fMitUT3a5OZsQhFs+Y3gvMO+bMuZ3Ix/O0/clMkVx8vv3dywI6AxhszfZzPHJ86o+zHO
         liy0qFhMNmRM39pcpfM1bY9katEu0oUaTd6KGie0SHfFIElGOsZZBAAqVtbf30VfEzSJ
         rXGQ==
X-Gm-Message-State: AOJu0YxDfx8c8M/MX0X6Ex203QFvph7PxP05MbEj0l7L3twCQhpIEm1f
	/JxjVVSSZf/BV5EGYnm9BVspcQ83UhYbuK1JH6iqbs+d7iQ8hloYHlgb
X-Gm-Gg: ASbGncsOFnN+f/NSECHWfwR3L1WM1fqVhFCowfDJ3p3GFor6zoqoLa1kMX7zaugFqFL
	uA8BsB/+SzxIG+RwepBjEX9vpvaeLSSDV2oN8qyngfIqVHLlEGKLeyUEA5Ko9twPqbuAwGX8ff9
	w5/nHztzmzZAqY69e8OVAhb8SMlREWgFTbPuLO7ByLyr/gAuHc9T3P0wpFL1eai2hG+Omsc5xX6
	JbA6xgrausAd7H3qKwkz8+/+OdY23xO+jtlW6YHyWXiZf4NY3n8b5F+1/xIdbFgLuWTRJdacoTe
	o+4P4QV4U0/j3ZNVXjRKKwkquI3XUPkuTrjL9J4gyKDm/M5xNNS83d2P5Lvn98XYY6/dY1W9ix1
	d0Sf+Jh/43nA7P7QXc2nVJaNEZvgy3FHo0x03JOtIf0xA5jmZfZ2Fqub5rJ+xgiCDkYl2Oo4=
X-Google-Smtp-Source: AGHT+IF+ZlqtPhXZntOTf7k0IhgSZ5eOF3kN2nKesocfNZywTkRlH6l4yVpCGS0SF12qy1k2Tg4cXA==
X-Received: by 2002:a05:6402:27cb:b0:608:64ff:c9b5 with SMTP id 4fb4d7f45d1cf-61281eca285mr6839430a12.8.1752763722542;
        Thu, 17 Jul 2025 07:48:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8a92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61268c93b63sm3889881a12.9.2025.07.17.07.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 07:48:41 -0700 (PDT)
Message-ID: <58c82190-e7b7-499b-9463-527312a28a3d@gmail.com>
Date: Thu, 17 Jul 2025 15:48:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] mm, thp: use __thp_vma_allowable_orders() in
 khugepaged_enter_vma()
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <20250608073516.22415-2-laoar.shao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250608073516.22415-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/06/2025 08:35, Yafang Shao wrote:
> The order has already been validated in hugepage_pmd_enabled(), so there's
> no need to recheck it in thp_vma_allowable_orders().
> 


The checks are not equivalent.

hugepage_pmd_enabled just checks if the sysfs entries allow hugification.
thp_vma_allowable_orders modifies the orders that can be used based on vm_flags,
which is not done in hugepage_pmd_enabled.

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/khugepaged.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 15203ea7d007..79e208999ddb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -474,8 +474,8 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>  	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
> -					    PMD_ORDER))
> +		if (__thp_vma_allowable_orders(vma, vm_flags, TVA_ENFORCE_SYSFS,
> +					       BIT(PMD_ORDER)))
>  			__khugepaged_enter(vma->vm_mm);
>  	}
>  }



