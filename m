Return-Path: <bpf+bounces-36065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547D9412FC
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFCC1F24C1A
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878219F471;
	Tue, 30 Jul 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+xp08ja"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B118FC6E;
	Tue, 30 Jul 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345614; cv=none; b=njtzooQ1HNC8E+8pWwB7zE2SNbyuO5Azelzs1WyFgbdzIcPRG+eQcbBkIQpJx0XS4ST93KRUzLNrzodxq+Vt2aGM13chavUCe0BXpwz1a3uhXYMqEfQj5pM16WBYnRKbRWTvOdSfXHXOTyZ3rVDS68F4M4qyatBbxcFWHJ59P3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345614; c=relaxed/simple;
	bh=4WoU61Vx3nzFnQurU5bcJ0jaUgAlCcaSHaueq7y7y3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTbuncW6lSJkMGb1u8B3qKWWg7NSBsU5+VmVmCvUD7tSYHH7hdvs7+wyVua8yM3ydo659zI/HnYz2O5XGoSEYr58UkBdn6WlD9SssL/+5xHaBFJAO1Y/jYi/pNN+9LdG93g2AR75/GMdCCy7/XXESo01CGHTZlGdfmLjMIN0Sbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+xp08ja; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722345613; x=1753881613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4WoU61Vx3nzFnQurU5bcJ0jaUgAlCcaSHaueq7y7y3c=;
  b=a+xp08jaaVdHjWv4dj25y9v1stn4R5niOewALIAfHSyohJPuMylz3E+G
   a2dkIDwOo1NQ9KHzqIoSwvg0Al/p1k6NFdBng9A8vHGI1Htsll427E+Zp
   kd42DgfsLzZQ36vN/YmM1R/YbnwnEDJWUUiMNa27qFKcp9vfJnFmFh2On
   T4+LaiQa5R0mrwyWV/c2m1GdFshrFz3OVK5guM6kbnPaMM1le5P7AeI6J
   e4bl+zVp1hFuwgSbI+1/Nhdu0VNlZEat3/aR2/ArTU/1NCx4Lupq7t60O
   VzRyqIWo9Lm6ZMqnlYFztm+B2R9cG3hv/8iGWovwE16Vr6XxLXBwf97PE
   A==;
X-CSE-ConnectionGUID: gnFi0SqXTgeCjup60xrQmQ==
X-CSE-MsgGUID: JD+Ww44FRKOpHhaOcQNo2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="31552997"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="31552997"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 06:20:12 -0700
X-CSE-ConnectionGUID: AW9RkDl8QZKVLzkDaKeX8A==
X-CSE-MsgGUID: Nc/WlqjXR6ehXpYeCd0ahA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85271327"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.245.99.83]) ([10.245.99.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 06:20:06 -0700
Message-ID: <9216e5a5-c2aa-4f08-8c53-7622b95b92ca@linux.intel.com>
Date: Tue, 30 Jul 2024 15:19:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next, v1 2/3] igc: Add default Rx
 queue configuration via sysfs
To: Song Yoong Siang <yoong.siang.song@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Shinas Rasheed <srasheed@marvell.com>, Kevin Tian <kevin.tian@intel.com>,
 Brett Creeley <brett.creeley@amd.com>,
 Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, Sasha Neftin <sasha.neftin@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240730012312.775893-1-yoong.siang.song@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240730012312.775893-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.07.2024 03:23, Song Yoong Siang wrote:
> From: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
> 
> This commit introduces the support to configure default Rx queue during

Use imperative mood.

> runtime. A new sysfs attribute "default_rx_queue" has been added, allowing
> users to check and modify the default Rx queue.
> 
> 1. Command to check the currently configured default Rx queue:
>    cat /sys/devices/pci0000:00/.../default_rx_queue
> 
> 2. Command to set the default Rx queue to a desired value, for example 3:
>    echo 3 > /sys/devices/pci0000:00/.../default_rx_queue
> 
> Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile    |   3 +-
>  drivers/net/ethernet/intel/igc/igc_main.c  |   6 +
>  drivers/net/ethernet/intel/igc/igc_regs.h  |   6 +
>  drivers/net/ethernet/intel/igc/igc_sysfs.c | 156 +++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_sysfs.h |  10 ++
>  5 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_sysfs.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_sysfs.h
> 
> diff --git a/drivers/net/ethernet/intel/igc/Makefile b/drivers/net/ethernet/intel/igc/Makefile
> index efc5e7983dad..c31bc18ede13 100644
> --- a/drivers/net/ethernet/intel/igc/Makefile
> +++ b/drivers/net/ethernet/intel/igc/Makefile
> @@ -8,5 +8,6 @@
>  obj-$(CONFIG_IGC) += igc.o
>  
>  igc-y := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
> -	 igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
> +	 igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o \
> +	 igc_sysfs.o
>  igc-$(CONFIG_IGC_LEDS) += igc_leds.o
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index cb5c7b09e8a0..6a925615911a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -18,6 +18,7 @@
>  
>  #include "igc.h"
>  #include "igc_hw.h"
> +#include "igc_sysfs.h"
>  #include "igc_tsn.h"
>  #include "igc_xdp.h"
>  
> @@ -7069,6 +7070,9 @@ static int igc_probe(struct pci_dev *pdev,
>  			goto err_register;
>  	}
>  
> +	if (igc_sysfs_init(adapter))
> +		dev_err(&pdev->dev, "Failed to allocate sysfs resources\n");
> +
>  	return 0;
>  
>  err_register:
> @@ -7124,6 +7128,8 @@ static void igc_remove(struct pci_dev *pdev)
>  	if (IS_ENABLED(CONFIG_IGC_LEDS))
>  		igc_led_free(adapter);
>  
> +	igc_sysfs_exit(adapter);
> +
>  	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
>  	 * would have already happened in close and is redundant.
>  	 */
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index e5b893fc5b66..df96800f6e3b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -63,6 +63,12 @@
>  /* RSS registers */
>  #define IGC_MRQC		0x05818 /* Multiple Receive Control - RW */
>  
> +/* MRQC register bit definitions */
> +#define IGC_MRQC_ENABLE_MQ		0x00000000

Just 0.

> +#define IGC_MRQC_ENABLE_MASK		GENMASK(2, 0)
> +#define IGC_MRQC_DEFAULT_QUEUE_MASK	GENMASK(5, 3)
> +#define IGC_MRQC_DEFAULT_QUEUE_SHIFT	3
> +
>  /* Filtering Registers */
>  #define IGC_ETQF(_n)		(0x05CB0 + (4 * (_n))) /* EType Queue Fltr */
>  #define IGC_FHFT(_n)		(0x09000 + (256 * (_n))) /* Flexible Host Filter */
> diff --git a/drivers/net/ethernet/intel/igc/igc_sysfs.c b/drivers/net/ethernet/intel/igc/igc_sysfs.c
> new file mode 100644
> index 000000000000..34d838e6a019
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/igc_sysfs.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Intel Corporation */
> +
> +#include <linux/device.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include "igc.h"
> +#include "igc_regs.h"
> +#include "igc_sysfs.h"
> +
> +/**
> + * igc_is_default_queue_supported - Checks if default Rx queue can be configured
> + * @mrqc: MRQC register content
> + *
> + * Checks if the current configuration of the device supports changing the
> + * default Rx queue configuration.
> + *
> + * Return: true if the default Rx queue can be configured, false otherwise.
> + */
> +static bool igc_is_default_queue_supported(u32 mrqc)
> +{
> +	u32 mrqe = mrqc & IGC_MRQC_ENABLE_MASK;
> +
> +	/* The default Rx queue setting is applied only if Multiple Receive
> +	 * Queues (MRQ) as defined by filters (2-tuple filters, L2 Ether-type
> +	 * filters, SYN filter and flex filters) is enabled.
> +	 */
> +	if (mrqe != IGC_MRQC_ENABLE_MQ && mrqe != IGC_MRQC_ENABLE_RSS_MQ)
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * igc_get_default_rx_queue - Returns the index of default Rx queue
> + * @adapter: address of board private structure
> + *
> + * Return: index of the default Rx queue.
> + */
> +static u32 igc_get_default_rx_queue(struct igc_adapter *adapter)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	u32 mrqc = rd32(IGC_MRQC);
> +
> +	if (!igc_is_default_queue_supported(mrqc)) {
> +		netdev_warn(adapter->netdev,
> +			    "MRQ disabled: default RxQ is ignored.\n");
> +	}
> +
> +	return (mrqc & IGC_MRQC_DEFAULT_QUEUE_MASK) >>
> +		IGC_MRQC_DEFAULT_QUEUE_SHIFT;
> +}
> +
> +/**
> + * igc_set_default_rx_queue - Sets the default Rx queue
> + * @adapter: address of board private structure
> + * @queue: index of the queue to be set as default Rx queue
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int igc_set_default_rx_queue(struct igc_adapter *adapter, u32 queue)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	u32 mrqc = rd32(IGC_MRQC);
> +
> +	if (!igc_is_default_queue_supported(mrqc)) {
> +		netdev_err(adapter->netdev,
> +			   "Default RxQ not supported. Please enable MRQ.\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (queue > adapter->rss_queues - 1) {

if (queue >= adapter->rss_queues)

> +		netdev_err(adapter->netdev,
> +			   "Invalid default RxQ index %d. Valid range: 0-%u.\n",
> +			   queue, adapter->rss_queues - 1);
> +		return -EINVAL;
> +	}
> +
> +	/* Set the default Rx queue */
> +	mrqc = rd32(IGC_MRQC);
> +	mrqc &= ~IGC_MRQC_DEFAULT_QUEUE_MASK;
> +	mrqc |= queue << IGC_MRQC_DEFAULT_QUEUE_SHIFT;
> +	wr32(IGC_MRQC, mrqc);
> +
> +	return 0;
> +}
> +
> +static ssize_t default_rx_queue_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)

Why no igc_ prefix (and function doc)?

> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	u32 default_rx_queue = igc_get_default_rx_queue(adapter);
> +
> +	return sysfs_emit(buf, "%d\n", default_rx_queue);
> +}
> +
> +static ssize_t default_rx_queue_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)

Ditto

> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	u32 default_rx_queue;
> +	int err;
> +
> +	err = kstrtou32(buf, 10, &default_rx_queue);
> +	if (err) {
> +		netdev_err(adapter->netdev,
> +			   "Invalid default RxQ index. Valid range: 0-%u.\n",
> +			   adapter->rss_queues - 1);
> +		return err;
> +	}
> +
> +	err = igc_set_default_rx_queue(adapter, default_rx_queue);
> +	if (err < 0)
> +		return -EINVAL;

Why discard return error here?

> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(default_rx_queue);
> +
> +static struct attribute *attrs[] = {
> +	&dev_attr_default_rx_queue.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group attr_group = {
> +	.attrs = attrs,
> +};
> +
> +int igc_sysfs_init(struct igc_adapter *adapter)
> +{
> +	int err;
> +
> +	err = sysfs_create_group(&adapter->pdev->dev.kobj, &attr_group);
> +	if (err) {
> +		netdev_err(adapter->netdev,
> +			   "Failed to create sysfs attribute group.\n");
> +	}
> +
> +	return err;
> +}
> +
> +void igc_sysfs_exit(struct igc_adapter *adapter)
> +{
> +	sysfs_remove_group(&adapter->pdev->dev.kobj, &attr_group);
> +}
> diff --git a/drivers/net/ethernet/intel/igc/igc_sysfs.h b/drivers/net/ethernet/intel/igc/igc_sysfs.h
> new file mode 100644
> index 000000000000..b074ad4bc63a
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/igc_sysfs.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2024 Intel Corporation */
> +
> +#ifndef _IGC_SYSFS_H_
> +#define _IGC_SYSFS_H_
> +
> +int igc_sysfs_init(struct igc_adapter *adapter);
> +void igc_sysfs_exit(struct igc_adapter *adapter);
> +
> +#endif /* _IGC_SYSFS_H_ */

Thanks,
Marcin

