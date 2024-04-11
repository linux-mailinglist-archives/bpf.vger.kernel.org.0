Return-Path: <bpf+bounces-26500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A78A1113
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B881C20BEE
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D786147C9B;
	Thu, 11 Apr 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXQ09oU2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A01465BE;
	Thu, 11 Apr 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832011; cv=none; b=uOUERWG5KnUe+CYG5FWzHJ5EAQSn8HGIyfkuemlwRQhvBmcW5WydlfNag5vkN2Vo/F0FImboTv5EZJ5TxvpJK+LsEKCCtLRQ0AtmyHPRymTDPz93eZphyzcuDigQYSuAf5PneXovHhGObkQnawKEmdGHVvGI+6ipwc9zL9IWkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832011; c=relaxed/simple;
	bh=hpHx+uOqhydUGZSasb67Ow7X+dFwqqZUN364silypig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzilwVK9l7yHYl621d8+7zYjbEWA77ODB0Vfp87faBOXHuHTfvNB6Nyy/bqeaelwkb/OQTVS8kwe6Q3X1GjXJ3Vgz+pGYOB7eJuJ9aToYyHrwWV7ffx2Yy3wkqIxovUqOTK7/FpJU04peevzeyUtabWhGJZTlKw1QrqazIL337o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXQ09oU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA64C433C7;
	Thu, 11 Apr 2024 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712832011;
	bh=hpHx+uOqhydUGZSasb67Ow7X+dFwqqZUN364silypig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXQ09oU2VnI4KsMJ9w1UNOYBpWvS7I8TTWkoeFqg2uZrnc5jQP5O7iYYnJy6nyWDZ
	 Uf8FV7ZuKR2lZNLPgDrl7gyNTv/4w5qEjvgvObCdfwq5mzm9DuaKx5tr4Ca9ZSaJm4
	 Dw6FcyEXFr/oOept7DH5ZtknWqy3m0Ia5tgzYkwNGdl1JPcUicCBvSPlBkwo99QlIg
	 iMRRkV9McN0VaJnUlcIK83OkLVWFqS/9TAw+o5xwfOw1YMXHp7CsgsJ2uPjU8GOY5H
	 GYol5A1SRk4C/infMphBC9T5gMGZSGE0rg7cfgkoUAcciDM9bbf1cplYX7L8zbcuZ1
	 PtBQSPFc3yysg==
Date: Thu, 11 Apr 2024 11:40:07 +0100
From: Lee Jones <lee@kernel.org>
To: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: Re: [PATCH v2 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf
 trigger
Message-ID: <20240411104007.GC1980182@google.com>
References: <cover.1711415233.git.hodges.daniel.scott@gmail.com>
 <da92268495053af38f6ae8e8efb12ceec0947130.1711415233.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da92268495053af38f6ae8e8efb12ceec0947130.1711415233.git.hodges.daniel.scott@gmail.com>

On Mon, 25 Mar 2024, Daniel Hodges wrote:

> This patch adds a led trigger that interfaces with the bpf subsystem. It
> allows for BPF programs to control LED activity through calling bpf
> kfuncs. This functionality is useful in giving users a physical
> indication that a BPF program has performed an operation such as
> handling a packet or probe point.
> 
> Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
> ---
>  drivers/leds/trigger/Kconfig       | 10 ++++
>  drivers/leds/trigger/Makefile      |  1 +
>  drivers/leds/trigger/ledtrig-bpf.c | 73 ++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+)
>  create mode 100644 drivers/leds/trigger/ledtrig-bpf.c
> 
> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
> index d11d80176fc0..30b0fd3847be 100644
> --- a/drivers/leds/trigger/Kconfig
> +++ b/drivers/leds/trigger/Kconfig
> @@ -152,4 +152,14 @@ config LEDS_TRIGGER_TTY
>  
>  	  When build as a module this driver will be called ledtrig-tty.
>  
> +config LEDS_TRIGGER_BPF
> +	tristate "LED BPF Trigger"
> +	depends on BPF
> +	depends on BPF_SYSCALL
> +	help
> +	  This allows LEDs to be controlled by the BPF subsystem. This trigger
> +	  must be used with a loaded BPF program in order to control LED state.
> +	  BPF programs can control LED state with kfuncs.
> +	  If unsure, say N.
> +
>  endif # LEDS_TRIGGERS
> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
> index 25c4db97cdd4..ac47128d406c 100644
> --- a/drivers/leds/trigger/Makefile
> +++ b/drivers/leds/trigger/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
>  obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+= ledtrig-pattern.o
>  obj-$(CONFIG_LEDS_TRIGGER_AUDIO)	+= ledtrig-audio.o
>  obj-$(CONFIG_LEDS_TRIGGER_TTY)		+= ledtrig-tty.o
> +obj-$(CONFIG_LEDS_TRIGGER_BPF)		+= ledtrig-bpf.o
> diff --git a/drivers/leds/trigger/ledtrig-bpf.c b/drivers/leds/trigger/ledtrig-bpf.c
> new file mode 100644
> index 000000000000..99cabf816da4
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-bpf.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LED BPF Trigger
> + *
> + * Author: Daniel Hodges <hodges.daniel.scott@gmail.com>

Any copyright?

> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/rcupdate.h>
> +
> +
> +DEFINE_LED_TRIGGER(ledtrig_bpf);
> +
> +__bpf_kfunc_start_defs();

__bpf_hook_start()?

> +__bpf_kfunc void bpf_ledtrig_blink(const char *led_name__str, unsigned long
> +		delay_on, unsigned long delay_off, int invert)

Nit: Try to keep the variable types and names together please.

I.e. break before the 'unsigned' or after 'delay_on'.

> +{
> +	struct led_classdev *led_cdev;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(led_cdev, &ledtrig_bpf->led_cdevs, trig_list) {
> +		if (strcmp(led_name__str, led_cdev->name) == 0) {
> +			led_blink_set_oneshot(led_cdev, &delay_on, &delay_off,
> +					invert);

Use 100-chars to avoid the break.

> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +__bpf_kfunc_end_defs();

_bpf_hook_end()?

> +BTF_KFUNCS_START(ledtrig_bpf_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_ledtrig_blink, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(ledtrig_bpf_kfunc_ids)

Why not a single macro to output the full struct?

Or better yet, be less opaque and not use a macro at all?

> +static const struct btf_kfunc_id_set ledtrig_bpf_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &ledtrig_bpf_kfunc_ids,
> +};
> +
> +static int init_bpf(void)
> +{
> +	int ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
> +			&ledtrig_bpf_kfunc_set);
> +	return ret;

return register_btf_kfunc_id_set()?

Or again, better yet, put the single function call directly into
ledtrig_bpf_init()?  Creating a whole function just for a single
invocation seems superfluous.

> +}
> +
> +static int __init ledtrig_bpf_init(void)
> +{
> +	led_trigger_register_simple("bpf", &ledtrig_bpf);
> +
> +	return init_bpf();
> +}
> +
> +static void __exit ledtrig_bpf_exit(void)
> +{
> +	led_trigger_unregister_simple(ledtrig_bpf);
> +}
> +
> +module_init(ledtrig_bpf_init);
> +module_exit(ledtrig_bpf_exit);
> +
> +MODULE_AUTHOR("Daniel Hodges <hodges.daniel.scott@gmail.com>");
> +MODULE_DESCRIPTION("BPF LED trigger");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.43.2
> 

-- 
Lee Jones [李琼斯]

