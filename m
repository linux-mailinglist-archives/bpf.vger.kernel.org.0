Return-Path: <bpf+bounces-20817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D9843D87
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 12:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF6C29532F
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8247AE5E;
	Wed, 31 Jan 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1YWadyW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AF7AE43;
	Wed, 31 Jan 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698730; cv=none; b=gr3W30VnrFUkzJkTJzmKD1k/ytUp6nUWHcEzG3oFb9SSR+M3jYNMPNk56wV12NizThXTkkzw0aBPIR1vQUN683UhfwDyT+auK7D/VnqrO9Wi7W8CQ6IO+yxqg0Z7AB/Qe10aPm9aIYnwM/LFWPA//DvrqGJCPgvbY4Wp55d+irQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698730; c=relaxed/simple;
	bh=miXEls7aCVwLJDABniQxOKAOmoSskv8EQdi+pLuHLaQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QwOWNTDb95YpARaEoxumWZtlXldGKKisUqeHUqJ9kodpaEU6bMNrFR9WYnRbueFgAy/McHkKuftSPlpzDF1/rvj8NbzY1obXxZYYTdsOsxAAT2Le4EColJVFteOMzUpGLH1eJwsInCsctVFD0NgUMohglsi1ASR63eLNVCnyaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1YWadyW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706698729; x=1738234729;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=miXEls7aCVwLJDABniQxOKAOmoSskv8EQdi+pLuHLaQ=;
  b=f1YWadyW5wLSEx/hBtT+dc0UJcLQKxv1VhNXglxWmTj1Xghm1e3msDFe
   eCpuNZiYGc1apXqZjzBPzex1dEpFvb/al24zKwwj9H50bEzELgCuTKat2
   mNkICMHhz8j+jnVxF+0tT6Qc0w/C7NDIOl6uZs8OgqEv3fPk9lxJDvHCL
   lu7KLTy+pJtrNC+8HC9J/fMpzXH++DHSlcUdiQejmoz6Ixb5JtBX5QJXH
   Mjmw7APDBNo9xx6LXFWDisiP2B4dQaFEgT7Wc6IkBbzDUlPHeKoun+mRE
   5ckjWP/xwom/f/CJMJHDk1IRsRdm9jKEWVmO7Jr5V2GbFVX99/Ciauz1V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3407460"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3407460"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:58:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119583211"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="1119583211"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.167])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:58:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 31 Jan 2024 12:58:32 +0200 (EET)
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
Subject: Re: [PATCH net-next v4 08/11] stmmac: intel: configure SerDes
 according to the interface mode
In-Reply-To: <20240129130253.1400707-9-yong.liang.choong@linux.intel.com>
Message-ID: <99d78f25-dd2a-4a52-4c2a-b0e29505a776@linux.intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com> <20240129130253.1400707-9-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jan 2024, Choong Yong Liang wrote:

> From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
> 
> Intel platform will configure the SerDes through PMC api based on the
> provided interface mode.
> 
> This patch adds several new functions below:-
> - intel_tsn_interface_is_available(): This new function reads FIA lane
>   ownership registers and common lane registers through IPC commands
>   to know which lane the mGbE port is assigned to.
> - intel_config_serdes(): To configure the SerDes based on the assigned
>   lane and latest interface mode, it sends IPC command to the PMC through
>   PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
> - intel_set_reg_access(): Set the register access to the available TSN
>   interface.
> 
> Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 113 +++++++++++++++++-
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  75 ++++++++++++
>  3 files changed, 188 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 85dcda51df05..be423fb2b46c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -273,6 +273,7 @@ config DWMAC_INTEL
>  	default X86
>  	depends on X86 && STMMAC_ETH && PCI
>  	depends on COMMON_CLK
> +	select INTEL_PMC_IPC

INTEL_PMC_IPC has depends on ACPI but selecting INTEL_PMC_IPC won't 
enforce it AFAIK.

-- 
 i.


