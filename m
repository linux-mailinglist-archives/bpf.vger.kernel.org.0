Return-Path: <bpf+bounces-40104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072A97CA2B
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 15:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787C51C22F5D
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083B419E83E;
	Thu, 19 Sep 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ID87dfxr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475D41746;
	Thu, 19 Sep 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752854; cv=none; b=IPYsUnLYgVJsQnGrVtODNIayurbvj+OEaxyjBsuGgK4pN1rIFDjyqtZiSQt9JOnmNgK9otZ4IXiedXAeb6dJS46iframflZkwDWK2lIZEl/eMETkshrgbo3Ql+D6NZ36HFiiCh4wWIJKJsU3v/kulhKOFJ38F5fGfKY9hCtvurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752854; c=relaxed/simple;
	bh=J6I5LoVXfcU39JpBCU/5fJc/ayssxvwodGSPH59Yh3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I73hObEwBeDvJwX73VZmSOn7ObnB97WNa/HHApFY5suovpj3do+yj9tpN58DSPjNa+E7VX8p6Irl6mCi1l21llBWd24TsTIrU0zKJkB9hlzMP1thfdnOkqnQgPaasQgogLvUW+FW+uH8Adywe32+vSqCnmzxCHalCzpXCPsFgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ID87dfxr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726752853; x=1758288853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J6I5LoVXfcU39JpBCU/5fJc/ayssxvwodGSPH59Yh3A=;
  b=ID87dfxrQ9wUep/Sa/Mv3rAU6YQ3BIYn2FgZG27KyfTPgpjmQUUg6TxI
   A0srIE5T6BqgJwKMyU/k3Alq//NVHIdQggRl8D8EehfzA40XTZdAs8d2P
   iACAnHJjlBvQ9Dv8aPsUcTGWWx+fE6CXRQsz5k09VeY7SNXwQ/k2S6kcY
   yt+d9Hh5QjuoCmv42Cn5zM0o95PI99ACzHbOiaTZDC9hAWnV4EbAKCwB+
   EOgH23PoserIGWBLP3n3H81WSU/u+YRY8y6fDsNXU6C6gKHkiNsX3Z1Gq
   VFxb5Y5wzYgObFckiPQ8M9TwGDNwTnoQMs7ulXdVzzLXHTKL4zv0EruT0
   Q==;
X-CSE-ConnectionGUID: 1rYYBDZOTxqeNoA8UUglRw==
X-CSE-MsgGUID: AcNcQMGeROm3sLVXHIKDDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29503812"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="29503812"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 06:34:13 -0700
X-CSE-ConnectionGUID: HgB11EeXQGunjZweSXhUEQ==
X-CSE-MsgGUID: bMuo+53oQl+qth8N4GGRMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="69535638"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 06:34:12 -0700
Date: Thu, 19 Sep 2024 06:34:10 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, andrii@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] uprobes: Improve the usage of xol slots for better
 scalability
Message-ID: <ZuwoUmqXrztp-Mzh@tassilo>
References: <20240918012752.2045713-1-liaochang1@huawei.com>
 <87jzf9b12w.fsf@linux.intel.com>
 <7a6ba3f3-dffa-cdac-73c7-074505ea4b44@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6ba3f3-dffa-cdac-73c7-074505ea4b44@huawei.com>

> Sorry, I know nothing about the ThreadSanitizer and related annotation,
> could you provide some information about it, thanks.

Documentation/dev-tools/kcsan.rst

> > Would be good to have some commentary why doing so
> > many write operations with merely a rcu_read_lock as protection is safe.
> > It might be safer to put some write type operations under a real lock. 
> > Also it is unclear how the RCU grace period for utasks is enforced.
> 
> You are right, but I think using atomic refcount routine might be a more
> suitable apprach for this scenario. The slot_ret field of utask instance

Does it really all need to be lockless? Perhaps you can only make the 
common case lockless, but then only when the list overflows take a lock 
and avoid a lot of races. That might be good enough for performance.

If you really want a complex lockless scheme you need very clear documentation
in comments and commit logs at least.

Also there should be a test case that stresses the various cases.

I would just use a lock 
> is used to track the status of insn_slot. slot_ret supports three values.
> A value of 2 means the utask associated insn_slot is currently in use by
> uprobe. A value of 1 means the slot is no being used by uprobe. A value
> of 0 means the slot has been reclaimed. So in some term, the atomic refcount
> routine test_and_pout_task_slot() also avoid the racing when writing to
> the utask instance, providing additional status information about insn_slot.
> 
> BTW, You reminded me that since it might recycle the slot after deleting the
> utask from the garbage collection list, so it's necessary to use
> test_and_put_task_slot() to avoid the racing on the stale utask. the correct
> code might be something like this:
> 
> @@ -1771,16 +1783,16 @@ static void xol_free_insn_slot(struct task_struct *tsk)
> 
>         spin_lock_irqsave(&area->list_lock, flags);
>         list_del_rcu(&tsk->utask->gc);
> +       /* Ensure the slot is not in use or reclaimed on other CPU */
> +       if (test_and_put_task_slot(tsk->utask)) {
> +               clear_bit(tsk->utask->insn_slot, area->bitmap);
> +               atomic_dec(&area->slot_count);
> +               tsk->utask->insn_slot = UINSNS_PER_PAGE;
> +               get_task_slot(tsk->utask);
> +       }

I would have expected you would add a if (racing) bail out, assume the
other CPU will do the work type check but that doesn't seem to be what
the code is doing.

-Andi


