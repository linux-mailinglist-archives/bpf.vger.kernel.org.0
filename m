Return-Path: <bpf+bounces-66011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E638DB2C4CD
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B177D188EFA3
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5406333A033;
	Tue, 19 Aug 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2frB2JB"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561C347B4;
	Tue, 19 Aug 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608900; cv=none; b=lr1zqNvltkrQ8YKsMx8STRSVWFoMD4GVayIyDQUpfyZFgJH7Lo0n04lQVq/elKQ8X5a6EJLTrxUlPmxJuXh6PJeTMUzjuZXP/YoU/YcPgUCsUcVilqmOQ6DxIXt6NvYvaKVWTkiDwWFtKNnp6jq8YO9SnK4xt2/NhMXx1BNpZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608900; c=relaxed/simple;
	bh=lWjbkJ6DsX0tge/yzaZSVEzhZ4O05tRpOoktEGkDuZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwXCIXE3ODF3sfWHB1cSXpCL3Jrr3vXLgZXNVFEqiawtzcQjafyrq4+iOlpD8avhRAdTPVBAx4EbYm0Cq5sbXHlx0ls2qvjLXpqheRhY5G7ooq4zaS3nPx2r9drMssIIFrUa1o/cbJA7QMKt1RACgmCW3wMhmkT4p6FrpVK6QMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p2frB2JB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nQDEYM8xlpla7R3p9JD6tQp7FVqm+1JWuvetqvNUnv0=; b=p2frB2JBrOOyp1JGPYK23NJCJF
	J3HK7GfbEjb9EKQV3dac8Ah6sG/M145iHMs+EFCCpwBdCn8AbDWuenWOFvXskmNRVfhY52YIwKbWO
	mDGbhfHspavLbbKgghtVIwB762PujqhRkBzU7Ql6k7VB5hSwijqxm6/j98QwpsP2fNbKjxuf3RXoe
	E99hd5pIOeopKkJ8p4X7FUQwtggMRK/4PHyejlnh2RQ7iElPnnMm2JgAMwdKKBXg9SahIgHADS+Fn
	RRb3mmFZu0q9ko1BnV3/So9780BeCw0Lo0AjBnx+5PS7ncf8ksy1yYUzVx91uf4VRbKZHQA/VHd/A
	mcuDK6VA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoM4I-00000005dqP-43vP;
	Tue, 19 Aug 2025 13:08:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AE4DD30036F; Tue, 19 Aug 2025 15:08:02 +0200 (CEST)
Date: Tue, 19 Aug 2025 15:08:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, simona.vetter@ffwll.ch,
	tzimmermann@suse.de, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched: make migrate_enable/migrate_disable inline
Message-ID: <20250819130802.GI3245006@noisy.programming.kicks-ass.net>
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
 <20250819015832.11435-3-dongml2@chinatelecom.cn>
 <20250819123214.GH4067720@noisy.programming.kicks-ass.net>
 <42cbca3dc56a1fde7d472754430458e2de8412a1@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42cbca3dc56a1fde7d472754430458e2de8412a1@intel.com>

On Tue, Aug 19, 2025 at 03:49:54PM +0300, Jani Nikula wrote:
> On Tue, 19 Aug 2025, Peter Zijlstra <peterz@infradead.org> wrote:
> >> +EXPORT_SYMBOL_GPL(runqueues);
> >
> > Oh no, absolutely not.
> >
> > You never, ever, export a variable, and certainly not this one.
> 
> Tangential thought:
> 
> I think it would be possible to warn about non-function exports at build
> time, and maybe plug it in W=1 builds.
> 

Too much noise, there's a metric ton of variables exported. Sometimes
its unavoidable.

I just try and avoid wherever possible.

