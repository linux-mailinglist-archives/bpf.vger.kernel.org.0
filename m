Return-Path: <bpf+bounces-66371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E903AB32C8F
	for <lists+bpf@lfdr.de>; Sun, 24 Aug 2025 01:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B290A5A171E
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F32459C5;
	Sat, 23 Aug 2025 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bcr34Lfp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537F15747D;
	Sat, 23 Aug 2025 23:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755992055; cv=none; b=JC7mVC3CpN7v4Wp2IoeAe/gjIvYJQx8qFenJJxEUh8vtvNhlp/2EUG44C8+tb1BpsEa9Co6aQQFOzw6JpYwUWGAT2rBgqqwzDjd5VdWoeUQUi9fV5YJtoa79bSJ3uzOAxy4y0ac5jASsxHd2xGbkrrVE/LaxO6iGaroAB6mQV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755992055; c=relaxed/simple;
	bh=Ou3GlU1zQOJmmU8eVp2MTK0zN6BUCjEfv4fi+1eMtfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWhVU/tXsH7mDSNGM7I994De+SGMALfBa+Bx1wQbRy0Wa/LkEWfPIIy6/qQGY1KqGpkvdKO3Lj5ZIXBKtk/cAnlFQoSZm5KcN3OeMigGfQOzvi5vCkrkpiRayCNyC3/CGqWtg49vla3zkO5nlFyFJSrQv2VpvcF+3HrIt7XySQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bcr34Lfp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755992054; x=1787528054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ou3GlU1zQOJmmU8eVp2MTK0zN6BUCjEfv4fi+1eMtfw=;
  b=Bcr34Lfpdm0vT/cd4AeZygOGwO6Gp+pTP4ydVS82TgV65pZgHO9/23LI
   hVbsGuV1W/pq7nq+/dkJH9SE1DOY1+0wUPQclnr+kd181O+YJi1DiT0zM
   ukoyD28f4FKfLfky69XvCgINU3u1xBdB9i6KY50ZCK7b7P7yKsTWIQqZ5
   +HrSFHtl//2Q3I7i2C2Lm++QSb6NGpExZbycwlckCEAycfRopPN1LDyaX
   H592LAmRbpzltguZxWzF+iVNjJNdqZJL5ivIkdXCrrfwCs68f5YhMvah6
   YVuIZzMX1Wujgl27H/9IxWJMS3I7TNlb4BteGqDXo5uTmArbClQ/wJhet
   Q==;
X-CSE-ConnectionGUID: tEsf2KUjRHKivExVJLJObw==
X-CSE-MsgGUID: WYgvD3MKQCCv1qiYBd6wBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58321427"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58321427"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 16:34:13 -0700
X-CSE-ConnectionGUID: NCL5O3N7ToavV6fTIcGBhQ==
X-CSE-MsgGUID: /IWkKDaTTIe/tD0cjwJ2Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168502721"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 16:34:12 -0700
Date: Sat, 23 Aug 2025 16:34:11 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Changbin Du <changbin.du@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 00/19] Support dynamic opening of capstone/llvm remove
 BUILD_NONDISTRO
Message-ID: <aKpP8yn7hoyQJe9h@tassilo>
References: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823003216.733941-1-irogers@google.com>

> BUILD_NONDISTRO is used to build perf against the license incompatible
> libbfd and libiberty libraries. As this has been opt-in for nearly 2
> years, commit dd317df07207 ("perf build: Make binutil libraries opt
> in"), remove the code to simplify the code base.

The last time I tried the LLVM stuff was totally broken, couldn't
resolve many things. The only workaround was to go back to the actually
working libbfd. Please don't remove the only working option.

Thanks,

-Andi


