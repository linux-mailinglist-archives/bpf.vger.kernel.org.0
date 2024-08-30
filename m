Return-Path: <bpf+bounces-38555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED96C9662D2
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B371B2867F2
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6F21A7AF2;
	Fri, 30 Aug 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQfBLhUg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60741199FC1;
	Fri, 30 Aug 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024237; cv=none; b=UEDqjL8hhhM4LBRinW5wmXd+WhFsemBbUa1DVGHa+LT0Z7rZsftQrK44JnpNOnlB2BHBeJbimOJr4F84PGHTicJ2rXuEOhFqMdoPrmNqw5UDSp0xAcVFr1AJrALLC1XQEAI/9I7/3p6PCCKdroBRJpoaJWWUYZj/qDMuloAcEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024237; c=relaxed/simple;
	bh=BeUFvG3g23EoF+Sspwm+nDZPfo9Aj3wb4zAD5LLwJvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5V2SiOBfN+ngP4EUME65PMoFqUlAtnmnJzhPWvnrAl03h5rvaryCs53wB1l76s/MpF2wvBb2HgD+JcFziyPjDMNbn7Evyj8SvC4LgJcoHFFTQ55PjU9otLzgcYm9RjCXC5hRCTovjGG/UygicIPVsKnij+0lGem6+HnuUvciP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQfBLhUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B35C4CEC2;
	Fri, 30 Aug 2024 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024237;
	bh=BeUFvG3g23EoF+Sspwm+nDZPfo9Aj3wb4zAD5LLwJvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQfBLhUgH2VZ1hakh/IyEYNbx4cnVCWdWFt1vfmxaFOnzzzfQbdOLu+KM5UutHm+f
	 +0MlJE30cKdkBmvTgZvpTWbS+yP29M4nUCLhytRrgM7fiEQVcQRMjD0ydCbmYGCNfM
	 NsWuXndN9YRlipr4buCMez/w7r6lmcnWCs4JXdaKDPb8UyuAyIkMnL4dTRw6bHPfqC
	 wZCM3pCEg/zatP9HEfGwhvh4jh++88yuc278bZw83COO18HqJFazw32KnXLhgyr2WO
	 WpzEibMw4BFLOPUmWSFMhaBasEE96kmO5KwFlio6qDGbXN6marrWxBGQsDqtwYYZ3d
	 rRODRkXpWw/hA==
Date: Fri, 30 Aug 2024 10:23:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Xi Wang <xii@google.com>
Subject: Re: [PATCH] perf lock contention: Fix spinlock and rwlock accounting
Message-ID: <ZtHH6JcfNUBAQAen@x1>
References: <20240828052953.1445862-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828052953.1445862-1-namhyung@kernel.org>

On Tue, Aug 27, 2024 at 10:29:53PM -0700, Namhyung Kim wrote:
> The spinlock and rwlock use a single-element per-cpu array to track
> current locks due to performance reason.  But this means the key is
> always available and it cannot simply account lock stats in the array
> because some of them are invalid.
> 
> In fact, the contention_end() program in the BPF invalidates the entry
> by setting the 'lock' value to 0 instead of deleting the entry for the
> hashmap.  So it should skip entries with the lock value of 0 in the
> account_end_timestamp().

Thanks, applied to perf-tools-next,

- Arnaldo

