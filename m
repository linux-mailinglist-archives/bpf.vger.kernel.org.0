Return-Path: <bpf+bounces-52408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F658A42BEA
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CDD18878AF
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B9265CD5;
	Mon, 24 Feb 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joQbmD8D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE711185;
	Mon, 24 Feb 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422815; cv=none; b=a5ldrw44t0aTBfTzJBDP8o+wnMmdzltFnT2yYppe64fYSi5dOugWfl7bGCp6KEBhfbtkLup4igCYAhsoYBJ6E1LjBc39dsVci+Vt8LLcNdgiISXaRh6BEQYZTpJ+Vcr07L8gIeWqpdQxEaHmnJTrjhloKSBVGwFsH6IsQ+hisHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422815; c=relaxed/simple;
	bh=/9XEwpYnicVuWAD8/l1pDfwiKoB8ajZoewUaq9rOkwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deQAgR7QBe/Ps4RtXvCqp4gqwhRfwCWnyVSf+aPFcs8P8F/j/nmYUXNZeEuCUoODS68ssaPRlWvqglOVW7lEnGYBqzWSlJWKao4sHqn/iE121KaaQiC8OZdt8pTUp61E5zoMBHW1P7RRtc9Z6wvAKI5GOJrCln7f1AaS2pQLUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joQbmD8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BEEC4CEDD;
	Mon, 24 Feb 2025 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740422815;
	bh=/9XEwpYnicVuWAD8/l1pDfwiKoB8ajZoewUaq9rOkwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joQbmD8Dlm/rcU8cHKF28oFBH+pplRZ7yq8Yk9ZphffAC71lrqqxFB+eN5TuIdLai
	 +BVlmZQgJHYOT1knIYJPgSqxOyJtcxgahK/sf8kx75xsKq3jr6PXMl10xtxcm4z2KR
	 8RIARDh/LN43obOLl3q27+nPYOqG7i0neP8qmZCBUNG+E1oY/DKoEpyIO/IssA5ZGC
	 psnaVDQp7K5HW6cxTk/VDLS1QcD8/tMqrksuuIaU4KONXMrVQXJ6Li6XIgJi5DE84o
	 /p8TsZZn697oYw4lBQhPoNnNMfmyxkXEnxS/e4fOBTsWLIU34LMCrZ2dudnvEKnHeO
	 QzZYI/O52QU8A==
Date: Mon, 24 Feb 2025 19:46:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv2 00/18] uprobes: Add support to optimize usdt probes
 on x86_64
Message-ID: <Z7y-kwkXZzbv-CQs@gmail.com>
References: <20250224140151.667679-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>


* Jiri Olsa <jolsa@kernel.org> wrote:

> hi,
> this patchset adds support to optimize usdt probes on top of 5-byte
> nop instruction.
> 
> The generic approach (optimize all uprobes) is hard due to emulating
> possible multiple original instructions and its related issues. The
> usdt case, which stores 5-byte nop seems much easier, so starting
> with that.
> 
> The basic idea is to replace breakpoint exception with syscall which
> is faster on x86_64. For more details please see changelog of patch 8.
> 
> The run_bench_uprobes.sh benchmark triggers uprobe (on top of different
> original instructions) in a loop and counts how many of those happened
> per second (the unit below is million loops).
> 
> There's big speed up if you consider current usdt implementation
> (uprobe-nop) compared to proposed usdt (uprobe-nop5):
> 
>   # ./benchs/run_bench_uprobes.sh 
> 
>           usermode-count :  818.386 ± 1.886M/s
>           syscall-count  :    8.923 ± 0.003M/s
>   -->     uprobe-nop     :    3.086 ± 0.005M/s
>           uprobe-push    :    2.751 ± 0.001M/s
>           uprobe-ret     :    1.481 ± 0.000M/s
>   -->     uprobe-nop5    :    4.016 ± 0.002M/s
>           uretprobe-nop  :    1.712 ± 0.008M/s
>           uretprobe-push :    1.616 ± 0.001M/s
>           uretprobe-ret  :    1.052 ± 0.000M/s
>           uretprobe-nop5 :    2.015 ± 0.000M/s

So I had to dig into patch #12 to see the magnitude of the speedup:

# current:
#         usermode-count :  818.836 ± 2.842M/s
#         syscall-count  :    8.917 ± 0.003M/s
#         uprobe-nop     :    3.056 ± 0.013M/s
#         uprobe-push    :    2.903 ± 0.002M/s
#         uprobe-ret     :    1.533 ± 0.001M/s
# -->     uprobe-nop5    :    1.492 ± 0.000M/s
#         uretprobe-nop  :    1.783 ± 0.000M/s
#         uretprobe-push :    1.672 ± 0.001M/s
#         uretprobe-ret  :    1.067 ± 0.002M/s
# -->     uretprobe-nop5 :    1.052 ± 0.000M/s
# 
# after the change:
# 
#         usermode-count :  818.386 ± 1.886M/s
#         syscall-count  :    8.923 ± 0.003M/s
#         uprobe-nop     :    3.086 ± 0.005M/s
#         uprobe-push    :    2.751 ± 0.001M/s
#         uprobe-ret     :    1.481 ± 0.000M/s
# -->     uprobe-nop5    :    4.016 ± 0.002M/s
#         uretprobe-nop  :    1.712 ± 0.008M/s
#         uretprobe-push :    1.616 ± 0.001M/s
#         uretprobe-ret  :    1.052 ± 0.000M/s
# -->     uretprobe-nop5 :    2.015 ± 0.000M/s

That's a +169% and a +91% speedup - pretty darn impressive!

Thanks,

	Ingo

