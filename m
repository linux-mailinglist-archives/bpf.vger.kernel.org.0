Return-Path: <bpf+bounces-35225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A202938F2B
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 14:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7608281E47
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7716D4D8;
	Mon, 22 Jul 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6hJnp1U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B6322E;
	Mon, 22 Jul 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651965; cv=none; b=EaZQRusJScHnDeZvUtYPRpqmr70LRkHP9v0QpRineosRgWiKQb9LUnghKJnLAJzp9idEZYG5pM5Kf0B3M6xmOFpBaJpNolN9YdXhg0ZdpCHoqlpPS7o9qIn7SoitsUYTq7JoQ0aE0TK9649ICGYVSL8jkVMNY8nAzU0KLqghi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651965; c=relaxed/simple;
	bh=SELQ0MrBYDCfMJnBuPgc7Pd3x+mV2lIoEI4SkYrg3po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/rfq+8Z2RuC+oECR7dIPQ+VOh56CoqPlgmgxpJnJ77Eg9kVFwUYjg5mQkqnX5W401/fd38+Qgbj/ygjm13WyXRElXjcoDRy8kNv2A0YtDyRcBee+CXl93qgEfr9Moaf3Z/GLaZvXTe+5V0InDND/OIEOPcTWoYfoeFEhyuxmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6hJnp1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBE8C116B1;
	Mon, 22 Jul 2024 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721651965;
	bh=SELQ0MrBYDCfMJnBuPgc7Pd3x+mV2lIoEI4SkYrg3po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j6hJnp1UzGR89VbGQbk8rZlvAgl01bDtb6Hnme4lz7Ecu04pmCatoa9eWs9u4JhxZ
	 JVd/XQkXq9Qm/H8E7d4W/fYXzL37Uqk+t5AFJkaZiH2zSqiyvJV2KpfxyUqt5ZVvDk
	 UvpTdAxvAlE7G8m7WyGbq6AjyS/GCGTZ9h2gT8Ury62tAeNRFaktMNooAqQ1ilon44
	 tTbPC1+RWyvU6C/1uaZTw99jgxCGc4T4/+ZsWliJFvf8qlBw4a3hHRNsQi0Xpyw45e
	 8mjjbiIFw+RUstszrC0Rn6Uk9k5pdgs2YCEzI9dy53A05autdcLCL0JML2rinS58zY
	 f4a/qWEzmEYiA==
Message-ID: <cbd74fa5-d4ad-4ed0-a680-6ff5e3b8ff84@kernel.org>
Date: Mon, 22 Jul 2024 14:39:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 35/37] kvx: Add IPI driver
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>,
 Julian Vetter <jvetter@kalrayinc.com>,
 Clement Leger <clement@clement-leger.fr>,
 Guillaume Thouvenin <thouveng@gmail.com>, Luc Michel <luc@lmichel.fr>,
 Jules Maselbas <jmaselbas@zdiv.net>, bpf@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-36-ysionneau@kalrayinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240722094226.21602-36-ysionneau@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> The Inter-Processor Interrupt Controller (IPI) provides a fast
> synchronization mechanism to the software. It exposes eight independent
> sets of registers that can be used to notify each processor in the cluster.
> 
> Co-developed-by: Clement Leger <clement@clement-leger.fr>
> Signed-off-by: Clement Leger <clement@clement-leger.fr>
> Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
> Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
> Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> Co-developed-by: Luc Michel <luc@lmichel.fr>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>

...

> +
> +int __init kvx_ipi_ctrl_init(struct device_node *node,
> +			     struct device_node *parent)
> +{
> +	int ret;
> +	unsigned int ipi_irq;
> +	void __iomem *ipi_base;
> +
> +	BUG_ON(!node);

Fix your code instead.

> +
> +	ipi_base = of_iomap(node, 0);
> +	BUG_ON(!ipi_base);

No, handle it by returning.

> +
> +	kvx_ipi_controller.regs = ipi_base;
> +
> +	/* Init mask for interrupts to PE0 -> PE15 */
> +	writel(KVX_IPI_CPU_MASK, kvx_ipi_controller.regs + IPI_MASK_OFFSET);
> +
> +	ipi_irq = irq_of_parse_and_map(node, 0);
> +	if (!ipi_irq) {
> +		pr_err("Failed to parse irq: %d\n", ipi_irq);
> +		return -EINVAL;
> +	}
> +
> +	ret = request_percpu_irq(ipi_irq, ipi_irq_handler,
> +						"kvx_ipi", &kvx_ipi_controller);
> +	if (ret) {
> +		pr_err("can't register interrupt %d (%d)\n",
> +						ipi_irq, ret);
> +		return ret;
> +	}
> +	kvx_ipi_controller.ipi_irq = ipi_irq;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_IRQ_KVX_STARTING,
> +				"kvx/ipi:online",
> +				kvx_ipi_starting_cpu,
> +				kvx_ipi_dying_cpu);
> +	if (ret < 0) {
> +		pr_err("Failed to setup hotplug state");
> +		return ret;
> +	}
> +
> +	set_smp_cross_call(kvx_ipi_send);
> +	pr_info("controller probed\n");

Drop this simple probe successes. This is not the way to trace system
bootup. Keep only reasonable amount, not every driver printing that its
initcall started.

Best regards,
Krzysztof


