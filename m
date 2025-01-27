Return-Path: <bpf+bounces-49852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EDA1D550
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 12:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D7C7A3BCE
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359631FECCD;
	Mon, 27 Jan 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C409MVTC"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36125A646;
	Mon, 27 Jan 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977308; cv=none; b=e3oeWDKRtViA2Jz+3SUaT0nTwm9AeSAqBVkonh7CmwItMYYfZMk9S2qQggyAoJlGKgarP+xyd8FJ9pqmKJxe7syk8BVBwi7FltFzxw45UWbSMdjsLMCg/ZE7H9Rn6GO53Pe1BZXghgGGQJa2XWoHot0WXvJA5E/NyHgRQy+OdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977308; c=relaxed/simple;
	bh=GQoYB4Aob3xWAWnF8gpzfqf/CV52pRYvErqC2avKG9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8mb/q00HQv/DgC5A/qsXCqOqII37GEJtI2Ms4PpQlbtp9wAIECSy4JsFdfW7yo6z+b+imVrFe5Q227g5U0WtiUcJ6HpvVAM4lfWK9huv+Pj8rGkJ/H3EJOSe4Kbsn9YGYYVeVGR9J2mO76KN0izsYLNmdGA39JPLHiSiwJWaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C409MVTC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4+JW8sEw705PBUez1KwWSHcwOqxXtNjS9aj2SZZoj6w=; b=C409MVTCGBuNGnsP7NfupJWvCO
	j7bs5f+qVTftz6QUX1SsYFmln0BxeHtnpJpo4yQiXa5XV1pEgMdU08nN01nXgjtZgEMMzrBYtSU4K
	ZSjNdMpPjdYbgwySosjw6Ddo8aMegkxy0z1UpwKsCiUS43fA0o024TOK8ZkAeNk5hVxx/ldsPDuDn
	C35tlEBeg0eyzGIt4NaFRd/ynbK5cN1XlriwCUwMUrw0JnwT63QQzlv9nAAlBDrTI4mKmLhaKmMIM
	ScUH9EXYFcwHksl7V4hHQ+VIq8nbv9K4vxYImv0U0FeDFg3Vy4xVO77PFD/5qLCduY+74cRppMpcY
	voGtm/YQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcNHr-0000000EhMe-0X1s;
	Mon, 27 Jan 2025 11:28:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8AA523004DE; Mon, 27 Jan 2025 12:28:14 +0100 (CET)
Date: Mon, 27 Jan 2025 12:28:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, andrii.nakryiko@gmail.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 0/2] uprobes: Improve scalability by reducing the
 contention on siglock
Message-ID: <20250127112814.GH16742@noisy.programming.kicks-ass.net>
References: <20250124093826.2123675-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124093826.2123675-1-liaochang1@huawei.com>

On Fri, Jan 24, 2025 at 09:38:24AM +0000, Liao Chang wrote:
> Liao Chang (2):
>   uprobes: Remove redundant spinlock in uprobe_deny_signal()
>   uprobes: Remove the spinlock within handle_singlestep()
> 
>  include/linux/uprobes.h |  1 +
>  kernel/events/uprobes.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Thanks, I've picked up the patches but will not merge them until post
-rc1.

