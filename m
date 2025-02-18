Return-Path: <bpf+bounces-51877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CB7A3ABF0
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 23:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E6D188E6F1
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848D1DC184;
	Tue, 18 Feb 2025 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBNPFVpv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59E1CAA6C;
	Tue, 18 Feb 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918707; cv=none; b=hfaKIyxyAbn3pHt/0eLermGGM/rLwaqu2eUwK2qW8KaXYldBHrfY1ydmYT5VjZ/S7IFDC9jCUGBokdpC6II3PITraPJy5qnMglf3OWWkuSC2QcFV7LSPdS41XdV7tgDvjvXJPrGvmgWFj2DIhguqZQCPFhgDp2GtYdDk6hxZ4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918707; c=relaxed/simple;
	bh=9GLvbr+EZDhM+VWlulgPJZ388/8UPBsqDbNlXOdiAdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qw2nUBRZ1HLVkEr2LQ2j4zcAEiULKOV/L7D/g5X8sIgvsvf5xS3iMgu2F3n8hArGQT49cgqOx1Ulo2H7/Pgv2IykXDcaTWVWWBOUJGk5TE3pFLagNSYSR0yjQTK46vP1xlEW9Fz448WaXgfHLFcvNZFPtZhfELHQyffan0jNDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBNPFVpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF681C4CEE2;
	Tue, 18 Feb 2025 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918706;
	bh=9GLvbr+EZDhM+VWlulgPJZ388/8UPBsqDbNlXOdiAdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fBNPFVpvTkpmo5FAhYwjt2/WsrpFAIaBSH7Ij/cGgcDwUSKGXlerD5EM+0sFcl4jQ
	 ZBejOXhXS6MSISO+1dPcZpsVaWw9FIaK65ELkLtrAxsN7jJPqHQXlqIw4GPKoTFbGl
	 5KciUU0ky+cHg7Z8u8Dznht0lrhQgP8f1jSAMea0coyPXnZETN56VtJDKNk0jq0oJT
	 kO/4/D94BZ9K6sflgn+/6ZTM475avtaGC/AYXcvCYRHvl0CTVfd8HMTgJTvW+XP8Ko
	 9asjcE2Qp4A6Q/gcbDq/T5C94ZLSUOQKxMAJhZlT1AIiuWL4KeQPqd7XbDFz8PexT4
	 a0DOZqz7EQzTQ==
Date: Tue, 18 Feb 2025 16:45:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, bpf@vger.kernel.org
Subject: Re: [PATCH] tools/Makefile: remove pci target
Message-ID: <20250218224505.GA198220@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
> Fixes: e19bde2269ca ("selftests: Move PCI Endpoint tests from tools/pci to Kselftests")

Applied to pci/endpoint-test for v6.15, thanks!

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

