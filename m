Return-Path: <bpf+bounces-35809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A4293DFAA
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 16:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9F1F21AE9
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27E017107C;
	Sat, 27 Jul 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBEFKJJL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUwHRryQ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A509C16F904;
	Sat, 27 Jul 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722089325; cv=none; b=Lph2vFEFhAE1vpSWSGV6kTNRdsbhlMPn45YGj9TGksIuYZVhZVg9mbh0uBK9TCjW3ofTX69YVrrUZ5dYd7Rj9/6aZ8fVg3CFyrXy4E4dxtNy+BtTIrxVVi9KdYnnRxsVrpbYAKkkE94ktRQSkE0yHyczrmCA3shlWXN/PUJ6vus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722089325; c=relaxed/simple;
	bh=JdVpZbX4TYs6TEGs3dkOZTu4SjMER0GQiXIieByL/2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZQqMRpvpI+iHgYkIGGIufIOqpeJVr3uKKgouEIwYY04MK49pDBE52Pm9A6bkRWQoBukXglfYBytTxuXZhir6DqS4h9bSqN1I9Los8VW2Y+8MHkebmrxX6VPfveGz9m7qZK1LlJTUBR5UYUd4r7uOtYNyLWdFIzo4Hej+caIl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBEFKJJL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUwHRryQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722089322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N13OAhaELBgeVcPvm7OycULd91H2iBHXkcWHOWbzuPE=;
	b=qBEFKJJLGDq+P8PrIawihTfYkYy+Dq2vdSfA67f+HhVxwZ6xp0Y0Kko1nRtTLbWMYPa7JM
	SItAtKRwXjEUULmnHZep3buYjd9zuHlH8UhJmJZx01ayWRpFrCNbGhgSVBHZSCVfKg8mYr
	+4NepnTP8uMFQ3FMkvD4BnbXnER9qjDXIO1ecdyWBkbfnuTO2z4S9OoXRpFu/4lDUfix4I
	N9OUQCujFNHV7xB3LCYM4M4MQ/f+STiav0ziVK8Bq3tpoA/HmKNWBMooMcZv0eOb49oBzl
	M+MdDCY+ESACSOKeXWT7ivJ3ErARl/f0S+YTLWBtARivb3xZXJsqGJ3RreYeVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722089322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N13OAhaELBgeVcPvm7OycULd91H2iBHXkcWHOWbzuPE=;
	b=MUwHRryQL9qiUiSh+i1vXHHp/hmsm9K0eGXM+BKxtH2nxf49qgfhsCRyY2V5icZbhIbBZY
	gRlJdibhI+qPtMDg==
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Luc Michel <luc@lmichel.fr>, Jules Maselbas <jmaselbas@zdiv.net>,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH v3 35/37] kvx: Add IPI driver
In-Reply-To: <20240722094226.21602-36-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-36-ysionneau@kalrayinc.com>
Date: Sat, 27 Jul 2024 16:08:41 +0200
Message-ID: <87le1nsz9y.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 22 2024 at 11:41, ysionneau@kalrayinc.com wrote:
> +/*
> + * IPI controller can signal RM and PE0 -> 15
> + * In order to restrict that to the PE, write the corresponding mask

This comment is undecodable

> + */
> +#define KVX_IPI_CPU_MASK	(~0xFFFF)
> +
> +/* A collection of single bit ipi messages.  */
> +static DEFINE_PER_CPU_ALIGNED(unsigned long, ipi_data);
> +
> +struct kvx_ipi_ctrl {
> +	void __iomem *regs;
> +	unsigned int ipi_irq;
> +};
> +
> +static struct kvx_ipi_ctrl kvx_ipi_controller;
> +
> +void kvx_ipi_send(const struct cpumask *mask, unsigned int operation)

Why is this global? It's only used in this file, no?

> +{
> +	const unsigned long *maskb = cpumask_bits(mask);
> +	unsigned long flags;
> +	int cpu;
> +
> +	/* Set operation that must be done by receiver */
> +	for_each_cpu(cpu, mask)
> +		set_bit(operation, &per_cpu(ipi_data, cpu));
> +
> +	/* Commit the write before sending IPI */
> +	smp_wmb();
> +
> +	local_irq_save(flags);
> +
> +	WARN_ON(*maskb & KVX_IPI_CPU_MASK);

> +#define KVX_IPI_CPU_MASK	(~0xFFFF)

This means the system is limited to 16 CPUs, right?

How should a bit >= NR_CPUs be set in a valid cpu mask?  Also above you
happily iterate the full cpumask. This does not make sense.

> +	writel(*maskb, kvx_ipi_controller.regs + IPI_INTERRUPT_OFFSET);
> +
> +	local_irq_restore(flags);
> +}
> +
> +static int kvx_ipi_starting_cpu(unsigned int cpu)
> +{
> +	enable_percpu_irq(kvx_ipi_controller.ipi_irq, IRQ_TYPE_NONE);
> +
> +	return 0;
> +}
> +
> +static int kvx_ipi_dying_cpu(unsigned int cpu)
> +{
> +	disable_percpu_irq(kvx_ipi_controller.ipi_irq);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ipi_irq_handler(int irq, void *dev_id)
> +{
> +	unsigned long *pending_ipis = &per_cpu(ipi_data, smp_processor_id());

  this_cpu_ptr() ?

> +	while (true) {
> +		unsigned long ops = xchg(pending_ipis, 0);
> +
> +		if (!ops)
> +			return IRQ_HANDLED;
> +
> +		handle_IPI(ops);
> +	}

        for (ops = xchg(pending_ipis, 0); ops; ops = xchg(pending_ipis, 0))
        	handle_IPI(ops);

Hmm?

> +	return IRQ_HANDLED;
> +}
> +
> +int __init kvx_ipi_ctrl_init(struct device_node *node,
> +			     struct device_node *parent)
> +{
> +	int ret;
> +	unsigned int ipi_irq;
> +	void __iomem *ipi_base;
> +
> +	BUG_ON(!node);
> +
> +	ipi_base = of_iomap(node, 0);

What's the point of this ipi_base indirection? Just use controller.regs
directly.

> +	BUG_ON(!ipi_base);
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

That leaves the half initialized IPI handler around.

> +		return ret;

Thanks,

        tglx

