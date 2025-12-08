Return-Path: <bpf+bounces-76292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A70BCADA8F
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 16:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8F403027A0A
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502732D46CE;
	Mon,  8 Dec 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMFFqxFM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B427814C;
	Mon,  8 Dec 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209013; cv=none; b=Cb2D/GF/PCAr3lXbSRTT8dpGWgIUq1Ec4v/eOJkphAELJX6me+pnga8MCP+Q4znlUKwF8niLFY0cg09yw76qUldIWiHuKpwFKfqJjgUhQqrdTHcCH2NVViGaef8sDXjpDGPuAAioC9BdETAS5xukCaojT4+mKodeowWHX1X4phQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209013; c=relaxed/simple;
	bh=e+lbjpNNPHZ9AzdnDqKqzmkizClb/GMGtE/Uve9x97A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb9Z++2nMISLYVy0emciRb7UGihSarDLP3AN4Wkfb7GLvyNAb4ax3rhp+7j+ZSU5duC3ypSWLpURbegB4jZqE1lnQZ/UoUbWJRN06JBwkqMXN8kFOfSM0+IN1h0LEbdVMK0qsvB8+qR7fCRK50kjg8u5KmCVoR9oMuT5DtEzen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMFFqxFM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765209012; x=1796745012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e+lbjpNNPHZ9AzdnDqKqzmkizClb/GMGtE/Uve9x97A=;
  b=aMFFqxFMiKyfF5OjGUiM5sBEUFPiWny/+0T5f/9LERGhK4j5cmlj9ODp
   KqJddH2yyDgCHjhndnlULT2+blr8vi90ab7/JIyY2qFrzN+mP72JlXl3l
   h2v11nnVKByyJ/Ku+D4F6zvhei0yaTUCPQCUerVdM8+zNJmUyNvJcAsp4
   7ZvyiikPAXYJafxuKwQ/mRZc5t91g2pEeqPO/Dp6z+siU4mM5DnCu/HDv
   VgtAA4JBUUzlhJIZefXOcHKd2P9O6cHsVzKAmxqhccpR3Qn9nQUQbocmY
   KhfSK+P9+LzyKd5l89f/hFB/n+35rWj35+cAY//gtFGCeHU39YZHWYWfm
   A==;
X-CSE-ConnectionGUID: j51U9IRwTUOzmU33z+r+aw==
X-CSE-MsgGUID: O9QIYohJTXOo36BCN9nMWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="92628493"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="92628493"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:50:12 -0800
X-CSE-ConnectionGUID: jHuPHL+PRzeBw6Q55hWxsw==
X-CSE-MsgGUID: Rg/rmh8LS8+Ex0+Ih9BWmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="196422323"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:50:07 -0800
Date: Mon, 8 Dec 2025 17:50:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mirsad Todorovac <mtodorovac69@yahoo.com>
Subject: Re: [PATCH v1 1/1] : Mark BPF printing functions with __printf()
 attribute
Message-ID: <aTbzrSs9PhBe_6Tx@smile.fi.intel.com>
References: <20251208154733.2901633-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208154733.2901633-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 04:47:33PM +0100, Andy Shevchenko wrote:
> The printing functions in BPF code are using printf() type of format,
> and compiler is not happy about them as is:

Sorry, this is noise that has to not be sent, it's WIP.
I will send it later when I provide a proper commit message.

-- 
With Best Regards,
Andy Shevchenko



