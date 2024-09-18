Return-Path: <bpf+bounces-40063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B5597BC32
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9962DB2204F
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B31898F7;
	Wed, 18 Sep 2024 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpKYRb2D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF3176FB8;
	Wed, 18 Sep 2024 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662346; cv=none; b=vBLR5XD+G70Mq5pV4w+6ZJ/42oK3cwBpAOeeFMxLE9Rew4f174AwI3b196SDzTIm4l1z6cfzerKNnv1kE3WS21MDNKJMYtPhbNIWnivRudGxFSAbze18TsQtfXvtA8xKLh5L9CFHMd2thdAwlSgSwxvmzOm1e3Sq60GcPwQBdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662346; c=relaxed/simple;
	bh=f0P4n/JcY4cnbnO0t/v39t25A6vObIXGBoFXI6yVxvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwdFK2VNbBcWhZKyspFO5hhQAitR53/OKKDitdzZnOzgXcYe5BSNtlJ8XNcBIqjA7y4EzOgXHVAALGmjy3RZ3A1PaYGN+ccRV01s+3RLKiJXOw9Gsn1kV2qR/dH3LlAn+GDV6okCBJhYcjvxSiOacHP43G6sBsvjf8z7ObMjEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpKYRb2D; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726662346; x=1758198346;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=f0P4n/JcY4cnbnO0t/v39t25A6vObIXGBoFXI6yVxvw=;
  b=NpKYRb2DfDqTlORO/Vzxf6z/Rj9UybSccYaC3zwMBjUPV8vuw113QlF2
   xiG150npvJPcN1fPHPFKmj1KHQLWFlCzDgMUV69eooYOv5sNqW5bE1rPG
   G3atTnN4JKfmvXtGGWzSiVlLfa6jnFfiAjkgb4gF7cIi0yWGRYHmywQHw
   100gkt19QE85dEIj9zstrZMiUEqHDKtFkczNlx+5CFuA3ravhVwgaNFYv
   9ai+FVfELHcwKlzusM9PyAN5rZ8r75tL2FcexAP/yQSA/e2oJ40NkL0mH
   cp9/dP3D/axXC97DcvIMz10dLh8uOMIOz1SGoMJ5JCGtzzzIt6g5Znupn
   g==;
X-CSE-ConnectionGUID: fIn0MrMvS1GyTl0BJbW8dQ==
X-CSE-MsgGUID: hHy31EAJQJKo3/zSqsTwKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43089790"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="43089790"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 05:25:45 -0700
X-CSE-ConnectionGUID: QAFKuqHKQbKOw0Z5dM+1AQ==
X-CSE-MsgGUID: IFquy0hURG2dQnmbvR7JBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="74105620"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa004.fm.intel.com with ESMTP; 18 Sep 2024 05:25:43 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id CC4AF30125A; Wed, 18 Sep 2024 05:25:43 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: <mhiramat@kernel.org>,  <oleg@redhat.com>,  <andrii@kernel.org>,
  <peterz@infradead.org>,  <mingo@redhat.com>,  <acme@kernel.org>,
  <namhyung@kernel.org>,  <mark.rutland@arm.com>,
  <alexander.shishkin@linux.intel.com>,  <jolsa@kernel.org>,
  <irogers@google.com>,  <adrian.hunter@intel.com>,
  <kan.liang@linux.intel.com>,  <linux-kernel@vger.kernel.org>,
  <linux-trace-kernel@vger.kernel.org>,
  <linux-perf-users@vger.kernel.org>,  <bpf@vger.kernel.org>
Subject: Re: [PATCH] uprobes: Improve the usage of xol slots for better
 scalability
In-Reply-To: <20240918012752.2045713-1-liaochang1@huawei.com> (Liao Chang's
	message of "Wed, 18 Sep 2024 01:27:52 +0000")
References: <20240918012752.2045713-1-liaochang1@huawei.com>
Date: Wed, 18 Sep 2024 05:25:43 -0700
Message-ID: <87jzf9b12w.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Liao Chang <liaochang1@huawei.com> writes:
> +
> +/*
> + * xol_recycle_insn_slot - recycle a slot from the garbage collection list.
> + */
> +static int xol_recycle_insn_slot(struct xol_area *area)
> +{
> +	struct uprobe_task *utask;
> +	int slot = UINSNS_PER_PAGE;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(utask, &area->gc_list, gc) {
> +		/*
> +		 * The utask associated slot is in-use or recycling when
> +		 * utask associated slot_ref is not one.
> +		 */
> +		if (test_and_put_task_slot(utask)) {
> +			slot = utask->insn_slot;
> +			utask->insn_slot = UINSNS_PER_PAGE;
> +			clear_bit(slot, area->bitmap);
> +			atomic_dec(&area->slot_count);
> +			get_task_slot(utask);

Doesn't this need some annotation to make ThreadSanitizer happy?
Would be good to have some commentary why doing so
many write operations with merely a rcu_read_lock as protection is safe.
It might be safer to put some write type operations under a real lock. 
Also it is unclear how the RCU grace period for utasks is enforced.


-Andi

