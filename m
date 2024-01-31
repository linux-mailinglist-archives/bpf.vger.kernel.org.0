Return-Path: <bpf+bounces-20816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D853843D56
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 11:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E252229B7DA
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0821A6F08E;
	Wed, 31 Jan 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uo4hb0y+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A336A03E;
	Wed, 31 Jan 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698515; cv=none; b=iMWMGKakaj9I4IpZIy8lwsWwmwO2QfdiVUQDFSidgScTRvga4MI2/127F8askKouNm/kUHD4/PS2cz2Bn457r6qViJHhDayOCAaCeHLkb8hn67fd0cxfVXXmISYZw25+BnjdcV8gpk8HNVqqxvbCjw3HY0nASa3A/cytIKPiqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698515; c=relaxed/simple;
	bh=eubTaO2Xn3E5tDtt+RwQYETkethSKNEFLYxSws5vnIE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i+8XoTzffanln3Uhl2E5+rZy6Faov4U6lKLE1Nl11Z3IRqIs/OkT4/PEXsIvGb9hnbFoQlEaKq8GiEESfiw/Qy4qdLyYCTDJ/+D7OtHkXav5Lr8vYnq3fEoTiIHakae5EIkbTqZQuswnDUNecp5VAb470VM4kjCM+xoLWJzHh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uo4hb0y+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706698514; x=1738234514;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eubTaO2Xn3E5tDtt+RwQYETkethSKNEFLYxSws5vnIE=;
  b=Uo4hb0y+sPjv/Y/sL98dG4HkiTCqL4Pjn4c2r+6F9Htnen2GCi4t+4Is
   9RjlPI1fBoRx0HA8RFBPNLAr8pD+/M/UQY6KUBSdEkyV0GVh3ylNruRY4
   d+WglQbH63q+TSM5esVFFSczrTglmXohSq67j9SKS2B/GxvbXJR8k0U2k
   HEaHbcL8KLsmCXttD+Ma7eL2vU5imgxFCu9nVJ0ThK1VqsMsFVvTbrp7/
   Ax0qows7PvBtjq53yr09RXlMiCALZouQkDd9V4ourEj9mGevpwVklN6gf
   2LkZ+SEKjIo0xo6NC5N3JkAZ+O2RDfomu/a8Zj1JYwLu9hxtJ4y6Lo0rh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10666997"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10666997"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4009100"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.167])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:55:03 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 31 Jan 2024 12:54:58 +0200 (EET)
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
    David E Box <david.e.box@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <Jose.Abreu@synopsys.com>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Richard Cochran <richardcochran@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Jesper Dangaard Brouer <hawk@kernel.org>, 
    John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    Philipp Zabel <p.zabel@pengutronix.de>, 
    Andrew Halaney <ahalaney@redhat.com>, 
    Simon Horman <simon.horman@corigine.com>, 
    Serge Semin <fancer.lancer@gmail.com>, Netdev <netdev@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, bpf@vger.kernel.org, 
    Voon Wei Feng <weifeng.voon@intel.com>, 
    Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>, 
    Lai Peter Jun Ann <jun.ann.lai@intel.com>, 
    Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
Subject: Re: [PATCH net-next v4 07/11] arch: x86: Add IPC mailbox accessor
 function and add SoC register access
In-Reply-To: <20240129130253.1400707-8-yong.liang.choong@linux.intel.com>
Message-ID: <1fccbf0d-5b96-447b-80f1-19af70628edc@linux.intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com> <20240129130253.1400707-8-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jan 2024, Choong Yong Liang wrote:

> From: "David E. Box" <david.e.box@linux.intel.com>
> 
> - Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
> - Add support to use IPC command allows host to access SoC registers
> through PMC firmware that are otherwise inaccessible to the host due to
> security policies.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Chao Qin <chao.qin@intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  MAINTAINERS                                   |  2 +
>  arch/x86/Kconfig                              |  9 +++
>  arch/x86/platform/intel/Makefile              |  1 +
>  arch/x86/platform/intel/pmc_ipc.c             | 75 +++++++++++++++++++
>  .../linux/platform_data/x86/intel_pmc_ipc.h   | 34 +++++++++
>  5 files changed, 121 insertions(+)
>  create mode 100644 arch/x86/platform/intel/pmc_ipc.c
>  create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8709c7cd3656..441eb921edef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10973,8 +10973,10 @@ M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>  M:	David E Box <david.e.box@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> +F:	arch/x86/platform/intel/pmc_ipc.c
>  F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
>  F:	drivers/platform/x86/intel/pmc/
> +F:	linux/platform_data/x86/intel_pmc_ipc.h
>  
>  INTEL PMIC GPIO DRIVERS
>  M:	Andy Shevchenko <andy@kernel.org>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..bceae28b9381 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -666,6 +666,15 @@ config X86_AMD_PLATFORM_DEVICE
>  	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
>  	  implemented under PINCTRL subsystem.
>  
> +config INTEL_PMC_IPC
> +	tristate "Intel Core SoC Power Management Controller IPC mailbox"
> +	depends on ACPI
> +	help
> +	  This option enables sideband register access support for Intel SoC
> +	  power management controller IPC mailbox.
> +
> +	  If you don't require the option or are in doubt, say N.
> +
>  config IOSF_MBI
>  	tristate "Intel SoC IOSF Sideband support for SoC platforms"
>  	depends on PCI
> diff --git a/arch/x86/platform/intel/Makefile b/arch/x86/platform/intel/Makefile
> index dbee3b00f9d0..470fc68de6ba 100644
> --- a/arch/x86/platform/intel/Makefile
> +++ b/arch/x86/platform/intel/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_IOSF_MBI)			+= iosf_mbi.o
> +obj-$(CONFIG_INTEL_PMC_IPC)		+= pmc_ipc.o
> \ No newline at end of file

New line missing.


-- 
 i.


