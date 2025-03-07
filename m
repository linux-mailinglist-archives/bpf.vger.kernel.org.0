Return-Path: <bpf+bounces-53557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B5DA56553
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F5F3B59E5
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6C20E700;
	Fri,  7 Mar 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B9wZSuE2"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590C20E70B;
	Fri,  7 Mar 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343373; cv=none; b=sxWyV3lULyCTUr851kTTENWXNC4kQ92D1HXozK6yAa49yyTn6GWNPbQCg/pHFMwGdQfwDQK3n0EBQlJbmPIYd/NKkIfETOP89IyBhgskmncbzKiX+jEXeqJaGMlDhjv84pXxeqfDwsrilhFrXHEIYxYH3CXhIzC4mP1WvTG+k3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343373; c=relaxed/simple;
	bh=tYxJZJX1pI5K8wuGH/dKzuf43ukR/Ftn3/DZih3kce0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWUGVECo5P3aBFMN0R5PaqMKby22nEOZ085g37IjvvV8lCjh0mQIdFzF4yGZvsyp5eLf6eKsWKMRJYN+Ue2OGqGjsVjIjAJifKomYicxLgQiYheDm2Z/kkIhUdfdRePakVHNhxcA4mp2dUw9ntJGW7RjMl7I61o+QwlGLKlxX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B9wZSuE2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id F38862038F2B; Fri,  7 Mar 2025 02:29:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F38862038F2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741343370;
	bh=ZLRe45/BtNn0ARC6EnETrMfwdNw8kA9gyMB/wm3koXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9wZSuE2kzmUxireaWKyvy5UKChwThSlRZubsF9gBfpmi53lZEe37WpfRI+SoXT65
	 WPQ9BJpyQg4GNw46xfuqWdUVYdiElM4jiSt0b8UmTRcH8Z3Owpsi83CKdnFtWn9c8H
	 cHefJlMZgampk2OjFnv61yfu4AI9gh8CJitpl4KM=
Date: Fri, 7 Mar 2025 02:29:29 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	hawk@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Support holes in device list reply msg
Message-ID: <20250307102929.GA21981@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Mar 05, 2025 at 01:46:21PM -0800, Haiyang Zhang wrote:
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
> 
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 16 ++++++++++++----
>  include/net/mana/gdma.h                         | 11 +++++++----
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index c15a5ef4674e..df3ab31974b1 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -134,9 +134,10 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
>  	struct gdma_list_devices_resp resp = {};
>  	struct gdma_general_req req = {};
>  	struct gdma_dev_id dev;
> -	u32 i, max_num_devs;
> +	int found_dev = 0;
>  	u16 dev_type;
>  	int err;
> +	u32 i;
>  
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_LIST_DEVICES, sizeof(req),
>  			     sizeof(resp));
> @@ -148,12 +149,19 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
>  		return err ? err : -EPROTO;
>  	}
>  
> -	max_num_devs = min_t(u32, MAX_NUM_GDMA_DEVICES, resp.num_of_devs);
> -
> -	for (i = 0; i < max_num_devs; i++) {
> +	for (i = 0; i < GDMA_DEV_LIST_SIZE &&
> +		found_dev < resp.num_of_devs; i++) {
>  		dev = resp.devs[i];
>  		dev_type = dev.type;
>  
> +		/* Skip empty devices */
> +		if (dev.as_uint32 == 0)
> +			continue;
> +
> +		found_dev++;
> +		dev_info(gc->dev, "Got devidx:%u, type:%u, instance:%u\n", i,
> +			 dev.type, dev.instance);
> +
>  		/* HWC is already detected in mana_hwc_create_channel(). */
>  		if (dev_type == GDMA_DEVICE_HWC)
>  			continue;
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 90f56656b572..62e9d7673862 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -408,8 +408,6 @@ struct gdma_context {
>  	struct gdma_dev		mana_ib;
>  };
>  
> -#define MAX_NUM_GDMA_DEVICES	4
> -
>  static inline bool mana_gd_is_mana(struct gdma_dev *gd)
>  {
>  	return gd->dev_id.type == GDMA_DEVICE_MANA;
> @@ -556,11 +554,15 @@ enum {
>  #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
>  #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
>  
> +/* Driver can handle holes (zeros) in the device list */
> +#define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
> +
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
>  	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
> -	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT)
> +	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
> +	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
>  
>  #define GDMA_DRV_CAP_FLAGS2 0
>  
> @@ -621,11 +623,12 @@ struct gdma_query_max_resources_resp {
>  }; /* HW DATA */
>  
>  /* GDMA_LIST_DEVICES */
> +#define GDMA_DEV_LIST_SIZE 64
>  struct gdma_list_devices_resp {
>  	struct gdma_resp_hdr hdr;
>  	u32 num_of_devs;
>  	u32 reserved;
> -	struct gdma_dev_id devs[64];
> +	struct gdma_dev_id devs[GDMA_DEV_LIST_SIZE];
>  }; /* HW DATA */
>  
>  /* GDMA_REGISTER_DEVICE */

Reviewed-by: Shradha Gupta <shradhagupta@microsoft.com>
> -- 
> 2.34.1

