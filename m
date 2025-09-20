Return-Path: <bpf+bounces-69087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C25B8BFAA
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 07:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B3B1BC2AE3
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4B22D9EB;
	Sat, 20 Sep 2025 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j24FtfcM"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664931A5B8A
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758345489; cv=none; b=PgdlvgVPX2rreiwfOUbLfIMQMgDUZDPpzvWtkLTw1VEfxa7X6a3Jh8MaEdKaLQ6JX1Cmgdnmym6yjQptnyj3T5RsKGQkIC7r/MlSV/Hkyz4EK9BDP3E8QvNn32auqUaoxsDcm3x0uVpKbR2pG2Skr5QERbJn2QgpGOjl+gBIejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758345489; c=relaxed/simple;
	bh=vI491iiWp7bT17ACgeQD/IjbbdxlYAlMp5kRHIn3774=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCg6B+XBcxT8V0GoN/AjYaCohNOTOPEvHJEV2h1dUsYPinYKB6c+1t6i2EcMQpikx219m9E528lUOZvtv/2PzyqFsAMtqZyLfHZdRlzFlVoPFIp2uGRAgEfNXrwx2/PnghExVJgzQxZAEL1MhI2ADi2/xh+bD7Xp0Y8TeZAqHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j24FtfcM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 22:17:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758345474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PntaZnDYX/QEEVIWmBGVBGCPkGUIte8JIXB6ZVeo8rE=;
	b=j24FtfcMKfLk1zGaPV+iRbntXu9JfU3X59WP5fTeivp0kAwohHy32yNT/wbHlQsH5+TUtb
	Kuo9QOj25sVXoZWZ7Ih4rDWMxu59CHcUKRze5iVl5/scgMv3eIKu4xF44s479kyolJLRhf
	BKcFaivHCCQYqzk70bD7M8YqPXGlIoA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	tj@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH] memcg: introduce kfuncs for fetching memcg stats
Message-ID: <ky2yjg6qrqf6hqych7v3usphpcgpcemsmfrb5ephc7bdzxo57b@6cxnzxap3bsc>
References: <20250920015526.246554-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920015526.246554-1-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

+linux-mm, bpf

Hi JP,

On Fri, Sep 19, 2025 at 06:55:26PM -0700, JP Kobryn wrote:
> The kernel has to perform a significant amount of the work when a user mode
> program reads the memory.stat file of a cgroup. Aside from flushing stats,
> there is overhead in the string formatting that is done for each stat. Some
> perf data is shown below from a program that reads memory.stat 1M times:
> 
> 26.75%  a.out [kernel.kallsyms] [k] vsnprintf
> 19.88%  a.out [kernel.kallsyms] [k] format_decode
> 12.11%  a.out [kernel.kallsyms] [k] number
> 11.72%  a.out [kernel.kallsyms] [k] string
>  8.46%  a.out [kernel.kallsyms] [k] strlen
>  4.22%  a.out [kernel.kallsyms] [k] seq_buf_printf
>  2.79%  a.out [kernel.kallsyms] [k] memory_stat_format
>  1.49%  a.out [kernel.kallsyms] [k] put_dec_trunc8
>  1.45%  a.out [kernel.kallsyms] [k] widen_string
>  1.01%  a.out [kernel.kallsyms] [k] memcpy_orig
> 
> As an alternative to reading memory.stat, introduce new kfuncs to allow
> fetching specific memcg stats from within bpf iter/cgroup-based programs.
> Reading stats in this manner avoids the overhead of the string formatting
> shown above.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Thanks for this but I feel like you are drastically under-selling the
potential of this work. This will not just reduce the cost of reading
stats but will also provide a lot of flexibility.

Large infra owners which use cgroup, spent a lot of compute on reading
stats (I know about Google & Meta) and even small optimizations becomes
significant at the fleet level.

Your perf profile is focusing only on kernel but I can see similar
operation in the userspace (i.e. from string to binary format) would be
happening in the real world workloads. I imagine with bpf we can
directly pass binary data to userspace or we can do custom serialization
(like protobuf or thrift) in the bpf program directly.

Beside string formatting, I think you should have seen open()/close() as
well in your perf profile. In your microbenchmark, did you read
memory.stat 1M times with the same fd and use lseek(0) between the reads
or did you open(), read() & close(). If you had done later one, then
open/close would be visible in the perf data as well. I know Google
implemented fd caching in their userspacecontainer library to reduce
their open/close cost. I imagine with this approach, we can avoid this
cost as well.

In terms of flexibility, I can see userspace can get the stats which it
needs rather than getting all the stats. In addition, userspace can
avoid flushing stats based on the fact that system is flushing the stats
every 2 seconds.

In your next version, please also include the sample bpf which uses
these kfuncs and also include the performance comparison between this
approach and the traditional reading memory.stat approach.

thanks,
Shakeel

