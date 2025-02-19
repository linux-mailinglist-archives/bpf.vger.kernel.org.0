Return-Path: <bpf+bounces-51902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86551A3B026
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 04:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6392C189828F
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FCA1A8F9E;
	Wed, 19 Feb 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcN0zwnV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA6191F6A
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936582; cv=none; b=LdihbitQtmF5TM4zFFTeYcnEgHTJeZf8lg9to/xWx3zef+xS5mj5z9vwJrw1AN4w1R0iqbNNRMiMsy6cqzTq2z+YoHtd7HDw/QSGsRQ8viGxTVZUaRGpEAZr9mi0SjShqddeIwwYYYVpWKfYgM71uy7qFTJO1k0NnS050DGnpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936582; c=relaxed/simple;
	bh=rt8OZok4krwD/vISwT+RLOvyIFREjov9zpbLM62Rv8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7cIGuDVBTrDZAZjesSeEqK+1t2IxFF32cn4VjOzZ78W1W+ycghGrstgIyXGzTLwTmDw/qCZ8PtI7u/8C0otbUG47f+i8dVlu6Nuwhzz+G1l7XQUhnb7OTn9Wdu2mH0IQBy0x8htEJVfKoY+P3CCvIWdZ2sID5B1oueRvG/2Am8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vcN0zwnV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-219f8263ae0so114228485ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 19:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739936579; x=1740541379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yzzzNklTSdOBRiVdzYnFdDhkqK4+d5jKptup1SFuREM=;
        b=vcN0zwnV/BNNY9xGJdeTr3JxiH2L9fOsA33GkEG+U1Wyp0rWtvlUTQlAXb+F8Md3rk
         +LEfJpdwz2Zbg51GHxG1ZJF2tvKiVpbr54YCUrNtm609lVTczSoDlBZM8mXsQ8Ejv7EP
         6wJoDfNFBpHDihKcDJMtV5zUtH/EFkGxg4N3ztZNYLl8ArACsAzR4aKw885aVlGEzee8
         oSttYhWg6FC0MwhraVL7dMtYJ25zQtkqv2QrThVtPQGoR/DReKlfbvO5dBflL50Mbryq
         2YI7Y27UjfQD0d6JSU/1fMtvpv7hRLsa0A4GMZa8oc0pTbOhJFqHiaXm6qBq5GpD06jr
         OUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739936579; x=1740541379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzzzNklTSdOBRiVdzYnFdDhkqK4+d5jKptup1SFuREM=;
        b=h0Em62yNgzBPdP2ONxWmrA0GjO8RhqWCL54L2VTpVmmMB7VGrX6ohKavJJtkuXy57o
         jJbIOXDuWjdoHBMxfz/aYfjnJXpoAc8qj5v3AJuq353xDGem5DOuYZrgx2Jxu+fLD5s8
         dl8AME2FHYDXUhjgV9flHB4QatlNZz089tDOydvtdefjgdaQJi/RPc+GfXFp/RbEIoxM
         2PrskBH4oPKR2r0FAud/jagGlK9nEw4DndQI0tvVKMBc8aPzDV8nP6iq0Tc898BWX7iD
         Ajd86meNvvVpwtj/aiS7Z+/6HSL0et00KtiOipFoXBQzt8KWRzvw0rDCANarswc8erlf
         G/mw==
X-Forwarded-Encrypted: i=1; AJvYcCW8zAC0mlD7JPDUse8UV5ujuOBRhR4UG+3LWscmkl6KIk/XaBhbJ9ejF8tuXmy0iuWGldQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8b4qDCLv/Vc5R+MGrUl4fhVZZMhQFrDEu8MN5HUAu352Kcte
	6KC4G/oazIFF0ycFStwd9HRgeP4HWASz99j7tTLzmzR9yM/2EJSCApdo+hatNA==
X-Gm-Gg: ASbGncu9ObaGILniPMjpzEjttwbC+jAHhgjbH00VgC/zf0wl+xcoHPFzYP+AQcyQKM5
	8+/pdcRlR5rLfu9iVXrA4m/LyqFl1tNmZABsihI0N3s6uEJqlD1SaLlZCK+sy4+DOU775jFiSsE
	Qlz19sqRn+0Vz1fh1iOYLJCnq2osYhdCuljmwcdfmRQSheY9aR6lTEdXPYnITLRYTVXBvzoPo+d
	b4R6ebHTuA4uBa4vRXupr1MfJBA9bzgWSFUYz0z2IYfmgZo+c25IGaLUlgPryA8A1z7GX29gpVx
	tXqza5vnxo9FMnyKO5z1moHoRes=
X-Google-Smtp-Source: AGHT+IGnSkIYwRiNrwLaXKiKj/KL0r5B+zTe86T9DDgnkUKidbTIZVM8Yj1hqnJGGJXPq3VCAE+zTQ==
X-Received: by 2002:a17:903:1c5:b0:220:f509:686a with SMTP id d9443c01a7336-2210407b939mr285989715ad.29.1739936579463;
        Tue, 18 Feb 2025 19:42:59 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364403sm94758825ad.62.2025.02.18.19.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 19:42:58 -0800 (PST)
Date: Wed, 19 Feb 2025 09:12:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, bpf@vger.kernel.org
Subject: Re: [PATCH] tools/Makefile: remove pci target
Message-ID: <20250219034255.oadrso2u7xppjmo2@thinkpad>
References: <20250217115159.537920-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217115159.537920-1-liujianfeng1994@gmail.com>

On Mon, Feb 17, 2025 at 07:51:52PM +0800, Jianfeng Liu wrote:
> Commit e19bde2269ca ("selftests: Move PCI Endpoint tests from tools/pci to
>  Kselftests") moves tools/pci directory to
>  tools/testing/selftests/pci_endpoint, which will cause build failure
> when running "make pci" under tools:
> 
> linux/tools$ make pci
>   DESCEND pci
> make[1]: *** No targets specified and no makefile found.  Stop.
> make: *** [Makefile:73: pci] Error 2
> 
> This patch updates the top level tools/Makefile to remove reference to
> building, installing and cleaning pci components.
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

Thanks for spotting!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Fixes: e19bde2269ca ("selftests: Move PCI Endpoint tests from tools/pci to Kselftests")
> ---
> 
>  tools/Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 278d24723b74..5e1254eb66de 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -25,7 +25,6 @@ help:
>  	@echo '  leds                   - LEDs  tools'
>  	@echo '  nolibc                 - nolibc headers testing and installation'
>  	@echo '  objtool                - an ELF object analysis tool'
> -	@echo '  pci                    - PCI tools'
>  	@echo '  perf                   - Linux performance measurement and analysis tool'
>  	@echo '  selftests              - various kernel selftests'
>  	@echo '  sched_ext              - sched_ext example schedulers'
> @@ -69,7 +68,7 @@ acpi: FORCE
>  cpupower: FORCE
>  	$(call descend,power/$@)
>  
> -counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
> +counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
>  	$(call descend,$@)
>  
>  bpf/%: FORCE
> @@ -123,7 +122,7 @@ all: acpi counter cpupower gpio hv firewire \
>  		perf selftests bootconfig spi turbostat usb \
>  		virtio mm bpf x86_energy_perf_policy \
>  		tmon freefall iio objtool kvm_stat wmi \
> -		pci debugging tracing thermal thermometer thermal-engine
> +		debugging tracing thermal thermometer thermal-engine
>  
>  acpi_install:
>  	$(call descend,power/$(@:_install=),install)
> @@ -131,7 +130,7 @@ acpi_install:
>  cpupower_install:
>  	$(call descend,power/$(@:_install=),install)
>  
> -counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
> +counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
>  	$(call descend,$(@:_install=),install)
>  
>  selftests_install:
> @@ -163,7 +162,7 @@ install: acpi_install counter_install cpupower_install gpio_install \
>  		perf_install selftests_install turbostat_install usb_install \
>  		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
>  		tmon_install freefall_install objtool_install kvm_stat_install \
> -		wmi_install pci_install debugging_install intel-speed-select_install \
> +		wmi_install debugging_install intel-speed-select_install \
>  		tracing_install thermometer_install thermal-engine_install
>  
>  acpi_clean:
> @@ -172,7 +171,7 @@ acpi_clean:
>  cpupower_clean:
>  	$(call descend,power/cpupower,clean)
>  
> -counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
> +counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
>  	$(call descend,$(@:_clean=),clean)
>  
>  libapi_clean:
> @@ -219,7 +218,7 @@ clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
>  		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
>  		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
>  		freefall_clean build_clean libbpf_clean libsubcmd_clean \
> -		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
> +		gpio_clean objtool_clean leds_clean wmi_clean firmware_clean debugging_clean \
>  		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
>  		sched_ext_clean
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

