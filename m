Return-Path: <bpf+bounces-35224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B94938F24
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 14:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FFE281E20
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F2516CD21;
	Mon, 22 Jul 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6PqFaex"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2517597;
	Mon, 22 Jul 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651862; cv=none; b=gnkv8xoWBvtMcruecZ60zSj+NSwxLIu9Uc1n+CHsUlynDsMo35IBv59yYKygI+bAcygSJFJEqz1+HN1GbYicDUfUxjf2kd2ZocJZak4t3xXqz2UsZPVsdbSDSIHWVTxUx2Csbz1PWBKzPPS9g9rdL59/I0eqD6IBcUge6+IdBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651862; c=relaxed/simple;
	bh=TygWs13EGpZICGbiqrNSJqWpyf5yTBhooAGO1AoAC60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjhzoucDU9C/wbuc66HOClczKYk6kf0jjmyGvZ06yUTdS8XZMhJGvoO84qPoJ25SBFj7hElDxEBl/Cl5dKfTkabRvzbNaxHNsHKSPeBeeEbLnCojIBk1m0oJP9wq+7wOfpYq/RHkOD2whrgEpeoB+NfTH/ye+3LzkA2OH0s+gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6PqFaex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5820AC116B1;
	Mon, 22 Jul 2024 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721651861;
	bh=TygWs13EGpZICGbiqrNSJqWpyf5yTBhooAGO1AoAC60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D6PqFaexDWWeDa8U6Uh+twv8KXP80uxsKidrrpMKrdQ5UgWP+RjhdNI//B67Ke0Sc
	 8qiwOnMJEqYIaPjG9SyBaIqSAL9Wkth5O57Zm0JbLoS/SN+kl+AZu5ylFPQlbMaB5H
	 caurK8RKZj68N2Q15GKkply1wRq7hgP+VMFShh76WEde2ajmeahd4HVoBqSROkE+cH
	 AgZTvX3JTq/8j1pgZhWrCoQI57Ll/rDRdiiEMk7cOkFBqRw2CPD1iXao+uWBAKZMzo
	 9202U7idbwIKV6CJMsNYbYGwE/EyudQIBWIvcm2uBi5BBcke0rvqsMZNvDUrsHHaLt
	 GnWLYz+n9FZNA==
Message-ID: <daa59ab0-08d6-4a65-9367-c34bb42b8ad8@kernel.org>
Date: Mon, 22 Jul 2024 14:37:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 34/37] kvx: Add power controller driver
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>,
 Julian Vetter <jvetter@kalrayinc.com>,
 Clement Leger <clement@clement-leger.fr>,
 Louis Morhet <lmorhet@kalrayinc.com>, Marius Gligor <mgligor@kalrayinc.com>,
 Jules Maselbas <jmaselbas@zdiv.net>, bpf@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-35-ysionneau@kalrayinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240722094226.21602-35-ysionneau@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> The Power Controller (pwr-ctrl) controls cores reset and wake-up
> procedure.
> 
> Co-developed-by: Clement Leger <clement@clement-leger.fr>
> Signed-off-by: Clement Leger <clement@clement-leger.fr>
> Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> Co-developed-by: Louis Morhet <lmorhet@kalrayinc.com>
> Signed-off-by: Louis Morhet <lmorhet@kalrayinc.com>
> Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
> Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> V1 -> V2: new patch
> V2 -> V3:
> - Moved driver from arch/kvx/platform to drivers/soc/kvx/
>   see discussions there:
>   - https://lore.kernel.org/bpf/Y8qlOpYgDefMPqWH@zx2c4.com/T/#m722d8f7c7501615251e4f97705198f5485865ce2
> - indent
> - add missing static qualifier
> - driver now registers a cpu_method/smp_op via CPU_METHOD_OF_DECLARE
>   like arm and sh, it puts a struct into a __cpu_method_of_table ELF section.
>   the smp_ops is used by smpboot.c if its name matches the DT 'cpus' node
>   enable-method property.
> ---
>  arch/kvx/include/asm/pwr_ctrl.h     | 57 ++++++++++++++++++++
>  drivers/soc/Kconfig                 |  1 +
>  drivers/soc/Makefile                |  1 +
>  drivers/soc/kvx/Kconfig             | 10 ++++
>  drivers/soc/kvx/Makefile            |  2 +
>  drivers/soc/kvx/coolidge_pwr_ctrl.c | 84 +++++++++++++++++++++++++++++
>  6 files changed, 155 insertions(+)
>  create mode 100644 arch/kvx/include/asm/pwr_ctrl.h
>  create mode 100644 drivers/soc/kvx/Kconfig
>  create mode 100644 drivers/soc/kvx/Makefile
>  create mode 100644 drivers/soc/kvx/coolidge_pwr_ctrl.c
> 
> diff --git a/arch/kvx/include/asm/pwr_ctrl.h b/arch/kvx/include/asm/pwr_ctrl.h
> new file mode 100644
> index 0000000000000..715eddd45a88c
> --- /dev/null
> +++ b/arch/kvx/include/asm/pwr_ctrl.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2024 Kalray Inc.
> + * Author(s): Clement Leger
> + *            Marius Gligor
> + *            Julian Vetter
> + *            Yann Sionneau
> + */
> +
> +#ifndef _ASM_KVX_PWR_CTRL_H
> +#define _ASM_KVX_PWR_CTRL_H
> +
> +#ifndef __ASSEMBLY__
> +
> +static int kvx_pwr_ctrl_probe(void);
> +
> +int kvx_pwr_ctrl_cpu_poweron(unsigned int cpu);
> +
> +#endif
> +
> +#define PWR_CTRL_ADDR                           0xA40000
> +
> +/* Power controller vector register definitions */
> +#define KVX_PWR_CTRL_VEC_OFFSET                 0x1000
> +#define KVX_PWR_CTRL_VEC_WUP_SET_OFFSET         0x10
> +#define KVX_PWR_CTRL_VEC_WUP_CLEAR_OFFSET       0x20
> +
> +/* Power controller PE reset PC register definitions */
> +#define KVX_PWR_CTRL_RESET_PC_OFFSET            0x2000
> +
> +/* Power controller global register definitions */
> +#define KVX_PWR_CTRL_GLOBAL_OFFSET              0x4040
> +
> +#define KVX_PWR_CTRL_GLOBAL_SET_OFFSET          0x10
> +#define KVX_PWR_CTRL_GLOBAL_CLEAR_OFFSET        0x20
> +#define KVX_PWR_CTRL_GLOBAL_SET_PE_EN_SHIFT     0x1
> +
> +#define PWR_CTRL_WUP_SET_OFFSET  \
> +		(KVX_PWR_CTRL_VEC_OFFSET + \
> +		 KVX_PWR_CTRL_VEC_WUP_SET_OFFSET)
> +
> +#define PWR_CTRL_WUP_CLEAR_OFFSET  \
> +		(KVX_PWR_CTRL_VEC_OFFSET + \
> +		 KVX_PWR_CTRL_VEC_WUP_CLEAR_OFFSET)
> +
> +#define PWR_CTRL_GLOBAL_CONFIG_SET_OFFSET \
> +		(KVX_PWR_CTRL_GLOBAL_OFFSET + \
> +		 KVX_PWR_CTRL_GLOBAL_SET_OFFSET)
> +
> +#define PWR_CTRL_GLOBAL_CONFIG_CLEAR_OFFSET \
> +		(KVX_PWR_CTRL_GLOBAL_OFFSET + \
> +		 KVX_PWR_CTRL_GLOBAL_CLEAR_OFFSET)
> +
> +#define PWR_CTRL_GLOBAL_CONFIG_PE_EN \
> +	(1 << KVX_PWR_CTRL_GLOBAL_SET_PE_EN_SHIFT)
> +
> +#endif /* _ASM_KVX_PWR_CTRL_H */
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 5d924e946507b..f28078620da14 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -12,6 +12,7 @@ source "drivers/soc/fujitsu/Kconfig"
>  source "drivers/soc/hisilicon/Kconfig"
>  source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/ixp4xx/Kconfig"
> +source "drivers/soc/kvx/Kconfig"
>  source "drivers/soc/litex/Kconfig"
>  source "drivers/soc/loongson/Kconfig"
>  source "drivers/soc/mediatek/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index fb2bd31387d07..240e148eaaff8 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
>  obj-y				+= hisilicon/
>  obj-y				+= imx/
>  obj-y				+= ixp4xx/
> +obj-$(CONFIG_KVX)		+= kvx/
>  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>  obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
>  obj-y				+= loongson/
> diff --git a/drivers/soc/kvx/Kconfig b/drivers/soc/kvx/Kconfig
> new file mode 100644
> index 0000000000000..96d05efe4bfb5
> --- /dev/null
> +++ b/drivers/soc/kvx/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config COOLIDGE_POWER_CONTROLLER
> +	bool "Coolidge power controller"
> +	default n
> +	depends on KVX
> +	help
> +	  The Kalray Coolidge Power Controller is used to manage the power
> +	  state of secondary CPU cores. Currently only powering up is
> +	  supported.
> diff --git a/drivers/soc/kvx/Makefile b/drivers/soc/kvx/Makefile
> new file mode 100644
> index 0000000000000..c7b0b3e99eabc
> --- /dev/null
> +++ b/drivers/soc/kvx/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_COOLIDGE_POWER_CONTROLLER)	+= coolidge_pwr_ctrl.o
> diff --git a/drivers/soc/kvx/coolidge_pwr_ctrl.c b/drivers/soc/kvx/coolidge_pwr_ctrl.c
> new file mode 100644
> index 0000000000000..67af3e446d0e7
> --- /dev/null
> +++ b/drivers/soc/kvx/coolidge_pwr_ctrl.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2017-2024 Kalray Inc.
> + * Author(s): Clement Leger
> + *            Yann Sionneau
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +#include <linux/types.h>
> +
> +#include <asm/pwr_ctrl.h>
> +#include <asm/symbols.h>
> +
> +struct kvx_pwr_ctrl {
> +	void __iomem *regs;
> +};
> +
> +static struct kvx_pwr_ctrl kvx_pwr_controller;
> +
> +static bool pwr_ctrl_not_initialized = true;

Do not use inverted meanings.

> +
> +/**
> + * kvx_pwr_ctrl_cpu_poweron() - Wakeup a cpu
> + * @cpu: cpu to wakeup
> + */
> +int __init kvx_pwr_ctrl_cpu_poweron(unsigned int cpu)
> +{
> +	int ret = 0;
> +
> +	if (pwr_ctrl_not_initialized) {
> +		pr_err("KVX power controller not initialized!\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Set PE boot address */
> +	writeq((unsigned long long)kvx_start,

Addresses use kernel_ulong_t

> +			kvx_pwr_controller.regs + KVX_PWR_CTRL_RESET_PC_OFFSET);
> +	/* Wake up processor ! */
> +	writeq(1ULL << cpu,

That's BIT

> +	       kvx_pwr_controller.regs + PWR_CTRL_WUP_SET_OFFSET);
> +	/* Then clear wakeup to allow processor to sleep */
> +	writeq(1ULL << cpu,

BIT

> +	       kvx_pwr_controller.regs + PWR_CTRL_WUP_CLEAR_OFFSET);
> +
> +	return ret;
> +}
> +
> +static const struct smp_operations coolidge_smp_ops __initconst = {
> +	.smp_boot_secondary = kvx_pwr_ctrl_cpu_poweron,
> +};
> +
> +static int __init kvx_pwr_ctrl_probe(void)

That's not a probe, please rename to avoid confusion. Or make it a
proper device driver.

> +{
> +	struct device_node *ctrl;
> +
> +	ctrl = of_find_compatible_node(NULL, NULL, "kalray,coolidge-pwr-ctrl");
> +	if (!ctrl) {
> +		pr_err("Failed to get power controller node\n");
> +		return -EINVAL;
> +	}
> +
> +	kvx_pwr_controller.regs = of_iomap(ctrl, 0);
> +	if (!kvx_pwr_controller.regs) {
> +		pr_err("Failed ioremap\n");
> +		return -EINVAL;
> +	}
> +
> +	pwr_ctrl_not_initialized = false;
> +	pr_info("KVX power controller probed\n");
> +
> +	return 0;
> +}
> +
> +CPU_METHOD_OF_DECLARE(coolidge_pwr_ctrl, "kalray,coolidge-pwr-ctrl",
> +		      &coolidge_smp_ops);
> +
> +early_initcall(kvx_pwr_ctrl_probe);

Best regards,
Krzysztof


