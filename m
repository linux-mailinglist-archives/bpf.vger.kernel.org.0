Return-Path: <bpf+bounces-53879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19A5A5D58F
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 06:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4A03B0CCF
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 05:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F41DF968;
	Wed, 12 Mar 2025 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWOMNkgk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F012F44;
	Wed, 12 Mar 2025 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741757428; cv=none; b=hJbyO0VBHXXA/QHN8Qm9NLUjN+AXrU1WOBm47qOKhcaw2Q/TFS1VoeiqKaUqvzy1I0teBRyu8rJhqU3yxev4ljYOOQyEgIuco0NGLf4OrD69UK6/ql7Hmh0ZQXWgvV0Z/TdU2oHZLEfDLnnkQwOnvua1gU0NvL8N8Ogm8HoGdD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741757428; c=relaxed/simple;
	bh=qVKAJ095eZtpEWRX/7W4qUS2hs13GQDgXgQcjU8U9Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3EMa/JwiI8i7tNZVtiC4hxqe19A3MsImiSsbmeY2qc0VB9PuKeb8ceWMzfM1csoZFaMLMkxhYd37LQCkYQZgKJ0GAcQ3HpEUIHnE1s09TMVjIrA+2CoOPEF4uA8U5Dw/jwFsl1tqWOW/7tveVdaTIGRGipbcnQxOY1M7k+Vf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWOMNkgk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741757427; x=1773293427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qVKAJ095eZtpEWRX/7W4qUS2hs13GQDgXgQcjU8U9Q4=;
  b=BWOMNkgkK70R4MFc4ue8AnXrON/QlvCguZqcNgVP5V5Zv7BsQWY3gbhb
   BvX9YjX1P2x7xumZnfZdkBnEnYeswhAjudhEeTilw5mVigPUK4hrWOXlr
   qcIsm1ZNqjYFOkA4+472PgTIQ+wZWby9s2xNPizov5UoS/0KdpYPSxNuP
   WKdtMYRU/zvTvfMzsnOa++mbyudF/w1qSa5MxWfUEZjCODeF2evrp6BTd
   /16b7NUa1nWeVFy5s0gP1ZGcpttlAkuESSSvYQrs6x9W+Og580fCryVrE
   AKWSpQbfKtRENIMGagIyiYTO5PTRj+gYzTA+si7xVLKSKFp4QYJTEM5hT
   w==;
X-CSE-ConnectionGUID: e7KHze8aSSugsBDkhZacNg==
X-CSE-MsgGUID: /tHcZHSGSHyEg4ifB+x5ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="41987919"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="41987919"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 22:30:26 -0700
X-CSE-ConnectionGUID: VePmY4qJR3O5YAgJ9CGgKg==
X-CSE-MsgGUID: P9/0jeAZTJqyypmrKWUY9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="125154825"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 22:30:20 -0700
Date: Wed, 12 Mar 2025 06:26:29 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	hawk@kernel.org, tglx@linutronix.de,
	shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net, v2] net: mana: Support holes in device list reply msg
Message-ID: <Z9Ea+EyJOLqxBMYv@mev-dev.igk.intel.com>
References: <1741723974-1534-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741723974-1534-1-git-send-email-haiyangz@microsoft.com>

On Tue, Mar 11, 2025 at 01:12:54PM -0700, Haiyang Zhang wrote:
> According to GDMA protocol, holes (zeros) are allowed at the beginning
> or middle of the gdma_list_devices_resp message. The existing code
> cannot properly handle this, and may miss some devices in the list.
> 
> To fix, scan the entire list until the num_of_devs are found, or until
> the end of the list.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Long Li <longli@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@microsoft.com>
> ---
> v2: Fix alignment, extra dmesg.
> 
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 14 ++++++++++----
>  include/net/mana/gdma.h                         | 11 +++++++----
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.34.1

