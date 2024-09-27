Return-Path: <bpf+bounces-40426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4B09889A1
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 19:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DF2826C9
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CD1C1ACD;
	Fri, 27 Sep 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdxJwMKN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFAA1C1AB5
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457548; cv=none; b=Ao3rGqEtBWxK4RACshS9yIY2KVYts2xCa+Pmk+xoaNlPWCzzZKQc/EmAFPfF5yE9IaRikzGVnrEaEbRNPCmyDAUI1dZ93n0jkuoOBDJZ/+CRlxcBcoBDgapu+f/caJzJLq0QWUdOtWhnzseEEMlQ0pH7wjl1/Z39qF8xNteWaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457548; c=relaxed/simple;
	bh=Zp6SyMPgdhEkHqeCFYD6sX1hBb7DHCkuERt7Hc0a3xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izCj/2vtRNKH5xAyQNDSYBeY5r9cOKW7BkybylKW3HesRDUpIhBc1qJIcaoFEShm1MlzwcmNssq5iVw/4gItEVVFG2AXFuTyupAt6AMyphBtqliSGakiAerL/8vMPjv8lAP2w/7f2pTBGtPChYo/lC+vCnZP5IuvwHctoIojgCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdxJwMKN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727457546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkF/xzfEMxIlkPDkfo2c1lZs/o5nQk9VkvqNorbPdc4=;
	b=fdxJwMKNCxFwQ2qTya4YZuQRFGxZFBdz/0Nuy2H8xzYZGPA2FgiZRN6wSPO4FgyZEzI0hf
	hubMw7YJJ6UyZmY92JAIB4640HNPHd7aTAAGrD/zarABAxRT5663Ah7IJ8+sbZdNeAE8pW
	MDMmpLSrCatsNGZQ5nyzbq4rp+9Cibw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-sWABljdNP5uxXiN9FFPMhw-1; Fri,
 27 Sep 2024 13:19:03 -0400
X-MC-Unique: sWABljdNP5uxXiN9FFPMhw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81B0219792DE;
	Fri, 27 Sep 2024 17:19:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 70CBD1956054;
	Fri, 27 Sep 2024 17:18:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 27 Sep 2024 19:18:47 +0200 (CEST)
Date: Fri, 27 Sep 2024 19:18:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: ak@linux.intel.com, mhiramat@kernel.org, andrii@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] uprobes: Improve the usage of xol slots for better
 scalability
Message-ID: <20240927171838.GA15877@redhat.com>
References: <20240927094549.3382916-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927094549.3382916-1-liaochang1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/27, Liao Chang wrote:
>
> +int recycle_utask_slot(struct uprobe_task *utask, struct xol_area *area)
> +{
> +	int slot = UINSNS_PER_PAGE;
> +
> +	/*
> +	 * Ensure that the slot is not in use on other CPU. However, this
> +	 * check is unnecessary when called in the context of an exiting
> +	 * thread. See xol_free_insn_slot() called from uprobe_free_utask()
> +	 * for more details.
> +	 */
> +	if (test_and_put_task_slot(utask)) {
> +		list_del(&utask->gc);
> +		clear_bit(utask->insn_slot, area->bitmap);
> +		atomic_dec(&area->slot_count);
> +		utask->insn_slot = UINSNS_PER_PAGE;
> +		refcount_set(&utask->slot_ref, 1);

This lacks a barrier, CPU can reorder the last 2 insns

		refcount_set(&utask->slot_ref, 1);
		utask->insn_slot = UINSNS_PER_PAGE;

so the "utask->insn_slot == UINSNS_PER_PAGE" check in xol_get_insn_slot()
can be false negative.

> +static unsigned long xol_get_insn_slot(struct uprobe_task *utask,
> +				       struct uprobe *uprobe)
>  {
>  	struct xol_area *area;
>  	unsigned long xol_vaddr;
> @@ -1665,16 +1740,46 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>  	if (!area)
>  		return 0;
>
> -	xol_vaddr = xol_take_insn_slot(area);
> -	if (unlikely(!xol_vaddr))
> +	/*
> +	 * The racing on the utask associated slot_ref can occur unless the
> +	 * area runs out of slots. This isn't a common case. Even if it does
> +	 * happen, the scalability bottleneck will shift to another point.
> +	 */

I don't understand the comment, I guess it means the race with
recycle_utask_slot() above.

> +	if (!test_and_get_task_slot(utask))
>  		return 0;

No, we can't do this. xol_get_insn_slot() should never fail.

OK, OK, currently xol_get_insn_slot() _can_ fail, but only if get_xol_area()
fails to allocate the memory. Which should "never" happen and we can do nothing
in this case anyway.

But it certainly must not fail if it races with another thread, this is insane.

And. This patch changes the functions which ask for cleanups. I'll try to send
a couple of simple patches on Monday.

Oleg.


