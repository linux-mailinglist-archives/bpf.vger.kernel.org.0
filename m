Return-Path: <bpf+bounces-35810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3393DFB1
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 16:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881C21F218CF
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9017A92D;
	Sat, 27 Jul 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cqoUKebv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P5RYtd7t"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242D1741EB;
	Sat, 27 Jul 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722090164; cv=none; b=kATW3iLoxOp0hm36PsijivVbwEhVHKS5vFYzEX7/KICEEWjaq/yAuCdKIeqY/mfUV50fBkmJbl7cDq90gET2nlkC2R/mqd1JEf7j2FtFJsOrEB1eGXZcK64CgpVi67c1wac3Xtn7h6byZChJdfOZORYhNy0hwU+0hzzDEF3FtHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722090164; c=relaxed/simple;
	bh=hsV53QaQje/Nq0MxE5lD4ayKZ4Sp/6SGF3CZOpBFrUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OLIWjyovbGtVg3AS7sQtTH9+rc9Q1KfgEWkIGU57Xd0vOD0pIlXjYoCYddnTggMZ8L1WjqsQ6Gb7AcELpP8bdk45VakpVbqTvegJsuHxFgtFTwEjPc1g687H4dEh4nm8hkugQheKL8pvArdCxcs68xqOzkMnYkxw8QjidVWklw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cqoUKebv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P5RYtd7t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722090160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfyUrm2SempW7ID5gaaJ5w5nwP+tis0SN656zuj998I=;
	b=cqoUKebvmL0nha8ga1nu0ngGoaMFr64Vkipd72aWw3lDEQAW4Icvq2LSn+Xlyn/dGzVxa7
	NAnEAVwdYHnaPVHzC7eHrN5yqYRRh5KMVhisTPg30NcTDdT4dXlSi83yuAsp85Yx1yJR/C
	MkI3u3y20hwFcKjg2ZjQjJFpGem1nHSp8ntfDF7ziL5BMTIzvP78Mwcvmobl5MqfaQuPCJ
	RvvJwIkRz2vqDzR68KooaWyXujn3mm5rmmSsHGcgNz8e8E7lXRJ84GsoIQ9Lh3rhz/SS8G
	IIJhDXhjA5GnKZ67Z0CIFeLWxC9Sdi4cZjul+PLkk0Uqd7RhFdVfJn+CswcLuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722090160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfyUrm2SempW7ID5gaaJ5w5nwP+tis0SN656zuj998I=;
	b=P5RYtd7tGnnYZ0YFYJoN2LAGQG3+8yWBJ0iN0JcaRdFgk0ef9Eh+qmfzCDf9wFN2hKN0hJ
	yODtXzD6rnsv7YAw==
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Julien Hascoet <jhascoet@kalrayinc.com>,
 Louis Morhet <lmorhet@kalrayinc.com>, Luc Michel <luc@lmichel.fr>, Marius
 Gligor <mgligor@kalrayinc.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v3 30/37] kvx: Add multi-processor (SMP) support
In-Reply-To: <20240722094226.21602-31-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-31-ysionneau@kalrayinc.com>
Date: Sat, 27 Jul 2024 16:22:40 +0200
Message-ID: <87ikwqud73.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 22 2024 at 11:41, ysionneau@kalrayinc.com wrote:
> +
> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +{
> +	int ret;
> +
> +	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
> +	__cpu_up_task_pointer[cpu] = tidle;
> +	/* We need to be sure writes are committed */
> +	smp_mb();
> +
> +	if (!smp_ops.smp_boot_secondary) {
> +		pr_err_once("No smp_ops registered: could not bring up secondary CPUs\n");
> +		return -ENOSYS;
> +	}
> +
> +	ret = smp_ops.smp_boot_secondary(cpu);
> +	if (ret == 0) {
> +		/* CPU was successfully started */
> +		while (!cpu_online(cpu))
> +			cpu_relax();

Please use the generic CPU hotplug synchronization mechanisms CONFIG_HOTPLUG_*_SYNC

Thanks,

        tglx

