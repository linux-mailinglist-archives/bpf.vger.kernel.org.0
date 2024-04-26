Return-Path: <bpf+bounces-27927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970788B39E4
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AD01C24034
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B551E14885C;
	Fri, 26 Apr 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2M9n8hF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B915253B;
	Fri, 26 Apr 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141544; cv=none; b=jlShXCLpMxx7Fyaohgq+uooiaVhfuA7y6uv8zpQeqjaNtnw6VcUWa/4rC0GQ0fIxNZv+8p5bSlFbbiAsWSx0LShxp/3I9XHtb9yJBlA8PLzW0VmtQ0ZpGh9cmDis0p6JzWRao+xGV+lI21ylDSsuPxBkDpLse1y6ri3iZuhhlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141544; c=relaxed/simple;
	bh=9Jv2lMCoOjT7EeOuL6dC/ZsAnuxaNdyuZC9T66XtNpc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CmGWm3YHou/3egOc51/cxP7HLPVPRorr0yfBgtbkyTeiSOCz3vdvHuphqNix+VkjD8ri1PbaZ+r6p48+CZ1KaJ9SneQ/iZbUesQiwa9lneuYvbWsbtdfEDpXHT6kHCvSWKMTEHflALjl4V535NIsybIIMXpyOperVXX7L+xjDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2M9n8hF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3BFC113CD;
	Fri, 26 Apr 2024 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141543;
	bh=9Jv2lMCoOjT7EeOuL6dC/ZsAnuxaNdyuZC9T66XtNpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y2M9n8hFUX4oPeHAJatqxUJCLDntUzc8cUJC/A34vi78H0byqEq3K88br+gCJkuoh
	 1rHsxQY+xCetV+UVSKI7vg5O0S9ykbsqE8i8PcW2ZvYLSAridyYOeYF45GNnE3C7ER
	 wFAF6dcFxG2ndqGNWygmnptFJlKsw9FOMIqgNCIT5mltfj1CXct3HnqMY/XOSqWI1u
	 iiPFtCC0Ie9vxtLvJW/oU49/kdL33lWMv5aMTEAR5/gnDTssS3two0IbTww368dq2t
	 EoC4qLs+UwCHi43OanjbxXEOZvpVzOlUTFxSq0JWfjsHTIdzSL1kJ8S7lqsdL+kCGP
	 jL+ZEI65G/7EQ==
Date: Fri, 26 Apr 2024 23:25:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 bpf@vger.kernel.org, wuqiang.matt <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH 0/2] Objpool performance improvements
Message-Id: <20240426232539.faf453fb71e6af7017c7967b@kernel.org>
In-Reply-To: <20240424215214.3956041-1-andrii@kernel.org>
References: <20240424215214.3956041-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Andrii,

On Wed, 24 Apr 2024 14:52:12 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Improve objpool (used heavily in kretprobe hot path) performance with two
> improvements:
>   - inlining performance critical objpool_push()/objpool_pop() operations;
>   - avoiding re-calculating relatively expensive nr_possible_cpus().

Thanks for optimizing objpool. Both looks good to me.

BTW, I don't intend to stop this short-term optimization attempts,
but I would like to ask you check the new fgraph based fprobe 
(kretprobe-multi)[1] instead of objpool/rethook.

[1] https://lore.kernel.org/all/171318533841.254850.15841395205784342850.stgit@devnote2/

I'm considering to obsolete the kretprobe (and rethook) with fprobe
and eventually remove it. Those have similar feature and we should
choose safer one.

Thank you,

> 
> These opportunities were found when benchmarking and profiling kprobes and
> kretprobes with BPF-based benchmarks. See individual patches for details and
> results.
> 
> Andrii Nakryiko (2):
>   objpool: enable inlining objpool_push() and objpool_pop() operations
>   objpool: cache nr_possible_cpus() and avoid caching nr_cpu_ids
> 
>  include/linux/objpool.h | 105 +++++++++++++++++++++++++++++++++++--
>  lib/objpool.c           | 112 +++-------------------------------------
>  2 files changed, 107 insertions(+), 110 deletions(-)
> 
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

