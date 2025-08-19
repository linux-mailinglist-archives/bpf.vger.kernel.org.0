Return-Path: <bpf+bounces-66009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38665B2C44A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D222D723C59
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70733CEBD;
	Tue, 19 Aug 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9yym+lj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933933CEAE;
	Tue, 19 Aug 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607807; cv=none; b=Adn2wQAkK7iuO/9790jGMvW4R/RV+wP+pTsUyKJdhEavbYq2YIDw4pNnJwr6MG+zor4WSxw8LnFL5ofeoSR5pW79QGxiJvi9t6mEVh88cas+IxGMnTRJs5FwTBNOb39cC8uOTj8rTv+TsJGe3fW132c4stbZhCynJOhNO6iwfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607807; c=relaxed/simple;
	bh=BNNqh4Chf6E3EnB46K487xZwNEbEQafwRyXVXiMt44I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hCUhsiuo4z+m92lD1f1Rt3Y8VGk4GR1JhCYiZPM7cIJSAECvvSTgdIIhCa1uv+V1xB07FEK14SHzaf6HFuFpY1BOx2QcfSAvXvxUvVt8wZ5AyjyQc/xjbMu9998V6IWzQ7nU57Msnd2xwQUSkezakzm4utFUO9EIB6ykc1/2hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9yym+lj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755607806; x=1787143806;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BNNqh4Chf6E3EnB46K487xZwNEbEQafwRyXVXiMt44I=;
  b=b9yym+lj455SemSvZlPiBPIJZvYceaU6V6xKv/eyVRd72Z9OhvgD+DGG
   dalceUxOHqzpLjf08nc+ufmUCmW/e/XRBT/RLQccUBKU8jxN1ISw0EVMF
   gHgSUdWVS4D7rXSl3p4ScjzecbJkBMjfjbe5cDsWFTkeD/DcoMaq/Ocyc
   HHYGpcoYx+g69tsyj5ItWZUtLd7vGyhEeeqiw9Ac3vRAsDo9s7jN199G5
   TRoH2KyN8SbeIOobd8Ah2VivztQpNHLjTcelgAhDko684aOXd27Z9y41l
   JKmky92FgAR4QWzkd52Ln/I+okDl17lqFjIR5rjwPGbcZS4TBkWfhYWQy
   g==;
X-CSE-ConnectionGUID: hCrE33GdTrat8SLim/S/vQ==
X-CSE-MsgGUID: zkDO+n1+QVqEITYCWfuQVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75300444"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="75300444"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 05:50:05 -0700
X-CSE-ConnectionGUID: 0aOZuD3URtSfFhgIgt/7WA==
X-CSE-MsgGUID: nkG19eSCRoC6qnJ+sLFSow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168245382"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.251])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 05:49:57 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Menglong Dong
 <menglong8.dong@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, simona.vetter@ffwll.ch,
 tzimmermann@suse.de, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched: make migrate_enable/migrate_disable inline
In-Reply-To: <20250819123214.GH4067720@noisy.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
 <20250819015832.11435-3-dongml2@chinatelecom.cn>
 <20250819123214.GH4067720@noisy.programming.kicks-ass.net>
Date: Tue, 19 Aug 2025 15:49:54 +0300
Message-ID: <42cbca3dc56a1fde7d472754430458e2de8412a1@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 19 Aug 2025, Peter Zijlstra <peterz@infradead.org> wrote:
>> +EXPORT_SYMBOL_GPL(runqueues);
>
> Oh no, absolutely not.
>
> You never, ever, export a variable, and certainly not this one.

Tangential thought:

I think it would be possible to warn about non-function exports at build
time, and maybe plug it in W=1 builds.


BR,
Jani.


-- 
Jani Nikula, Intel

