Return-Path: <bpf+bounces-40216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC52983A7F
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 01:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A7E1C21C82
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 23:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9742132106;
	Mon, 23 Sep 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwHgw9OY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DF2907;
	Mon, 23 Sep 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727135538; cv=none; b=ty7L+0u7fbj5ZKn2Oe4DBsHWSvlGP184dYQMa8vsUysTU5ijxrgGBhAZdLZA6UBGa/MmfjKBR0zYPfhj87Fe+sUPyyjmOsLaQBTYzqUk6J+J6T6mID3SlATNMCl0/Rmc1qkre46S0gPg2zNT7jLUyLbfMp2Hw+TM9WcUoGbRy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727135538; c=relaxed/simple;
	bh=liU3xrMhCJ00+SP18e8Pf+o8QqUPpogn+daULb1u5gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtbD3KucfanxvOpTfq1F/i0XKEid1XIgveKrNfGnX5OcURo+WE1Oj2C9d8eXZgjYQamlOZohxf4TvJznTvR5lmZ93xcr1NBH4ZaTolzGSunxsPkILtRaiDuytIulK4xM9O+Eqpst9LvJvUfo0FJ9fBnT/grkuHRi+fFdFL0kGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwHgw9OY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727135537; x=1758671537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=liU3xrMhCJ00+SP18e8Pf+o8QqUPpogn+daULb1u5gg=;
  b=cwHgw9OYgjB6tl2JKRDBD6M6kVvrvFvsVJ919+rzSz6CjO62DUvb1NXe
   Ck8eM6jkMS8htUsnyra8EI7EJnaENzHGmJl5ota8BVeC53s9lZ/t4lFm+
   QUAUJYhyNKVHtpbWH2JSIO/krqZ76eAcjC9B426cIgs0H6lp1XcFHB3vb
   iXM+CvMQ3dbearrEnR7dPKZKoPS98G6vhStcaA3OHyMZobym0TEOMDEPd
   PYPAEG6+Ou6TJ9p+qfQwAu/ltyRWOknD4blMCEK6425q+UcXYR5KUUZNJ
   BlQbAvunUJBGd+rzfkVCdrC03xhn1544Hgmpc+XMfqe1P01YLUBLg2iqR
   w==;
X-CSE-ConnectionGUID: nw+T26XTTKShSQneEeBCjA==
X-CSE-MsgGUID: RjQOmo4DQUuZ4Mp/KRqxGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37472806"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="37472806"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 16:52:16 -0700
X-CSE-ConnectionGUID: ebY8c56xTvWzZ2bYe8EGqA==
X-CSE-MsgGUID: buCkN+fmRTOabrQlEgwvMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="75755546"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 16:52:15 -0700
Date: Mon, 23 Sep 2024 16:52:14 -0700
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
Message-ID: <ZvH_LiUeOtAwommF@tassilo>
References: <20240918012752.2045713-1-liaochang1@huawei.com>
 <87jzf9b12w.fsf@linux.intel.com>
 <7a6ba3f3-dffa-cdac-73c7-074505ea4b44@huawei.com>
 <ZuwoUmqXrztp-Mzh@tassilo>
 <0939300c-a825-5b46-d86f-72ce89b2b95f@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0939300c-a825-5b46-d86f-72ce89b2b95f@huawei.com>

> Thanks for the suggestions, I will experiment with a read-write lock, meanwhile,
> adding the documentation and testing for the lockless scheme.

Read-write locks are usually not worth it for short critical sections,
in fact they can be slower due to cache line effects.

> Sorry, I may not probably get the point clear here, and it would be very
> nice if more details are provided for the concern. Do you mean it's necessary
> to make the if-body excution exclusive among the CPUs? If that's the case,
> I guess the test_and_put_task_slot() is the equvialent to the race condition
> check. test_and_put_task_slot() uses a compare and exchange operation on the
> slot_ref of utask instance. Regardless of the work type being performed by
> other CPU, it will always bail out unless the slot_ref has a value of one,
> indicating the utask is free to access from local CPU.

What I meant is that the typical pattern for handling races in destruction
is to detect someone else is racing and then let it do the destruction
work or reacquire the resource (so just bail out).

But that's not what you're doing here, in fact you're adding a
completely new code path that has different semantics? I haven't checked
all the code, but it looks dubious.

-Andi

