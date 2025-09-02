Return-Path: <bpf+bounces-67230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C633B40FA7
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 23:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7C1547AB6
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E135CEC1;
	Tue,  2 Sep 2025 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBfGambm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848032F77A;
	Tue,  2 Sep 2025 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850094; cv=none; b=tP2VmU7FvdWEDdYiUWdEUA2EJ2L23ptJIvtwO6FxDPzfwUAX4y+oV1Sfu/TRCPINvHqnUGc5IuefHS6BVeCUU4tH4UsbiBTOhvyjk7AyURf1Fm3UW5FW+sWrEkdhq5GQNwHIXXguCc121WIAgOAZzgKNHO8FUMQHcY4dJQW+zQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850094; c=relaxed/simple;
	bh=ht5xLYPSL9u/C0Fl23mE/X2sWS3wa4v02UNoJjTGKco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AboBx9sjJwJx7uNnieQvH3bV/lkQkA1wHmXWFBRz+u1Upciru4R8xWhMtSZByd8MvqWhBkd+S4nve6RmCIPHfhYm35m/czUUNlLF67CYHrcYc73GRqvZQSyx8sVat6eflAnxzWB5dwEUI4vRnSWwIao5lVFCjkQUHypTMfjb9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBfGambm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8E6C4CEED;
	Tue,  2 Sep 2025 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756850093;
	bh=ht5xLYPSL9u/C0Fl23mE/X2sWS3wa4v02UNoJjTGKco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBfGambmQ56HjzOv/P6l4EJVu78ziFOmiDfMRRCgXTwz4da7kDwrTximIsX/Yrrk5
	 ed+uG7MbeJ2ZSVEt5xWYjv8MaKDrphlSZRJZIhMfUCZ0KcqJeqvbLZV4AXbzMVLh10
	 ETOX4Nj4HGsXojiTlLuNyxByxTEWEttchC3p0qoI2KfqFBghuYG3yyPBKc8lYvUEU9
	 Ve0J+86bm1X3fqCXfwUpmSazghf2yo3Wx2RtxibKR1NJSxRZL5KDsyXI7rG8n2FKYv
	 07DOm5oFftcSCxb2umR+JlJV8KDdDXkAoopS66+/pjXTNgU05eV6sYfrthvb0UiVF7
	 Yx+aoRIcnnYdA==
Date: Tue, 2 Sep 2025 14:54:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Blake Jones <blakejones@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <songliubraving@fb.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Howard Chu <howardchu95@gmail.com>,
	song@kernel.org, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 0/3] Fix use-after-free race in bpf_prog_info synthesis
Message-ID: <aLdnq7EayjFVbGYp@google.com>
References: <20250902181713.309797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902181713.309797-1-irogers@google.com>

Hi Ian,

On Tue, Sep 02, 2025 at 11:17:10AM -0700, Ian Rogers wrote:
> The addition of more use of bpf_prog_info for gather BPF metadata in:
> https://lore.kernel.org/all/20250612194939.162730-1-blakejones@google.com/
> and the ever richer perf trace testing, such as:
> https://lore.kernel.org/all/20250528191148.89118-1-howardchu95@gmail.com/
> frequently triggered a latent perf bug in v6.17 when the perf and
> libbpf updates came together. The bug would cause segvs and was reported here:
> https://lore.kernel.org/lkml/CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com/
> 
> To fix the issue the 1st and 3rd patch are necessary. Both patches
> address a race of either the sideband thread updating perf's state or
> the kernel state changing over two system calls.

Thanks a lot for the fix!

> 
> The use-after-free was introduced by:
> https://lore.kernel.org/r/20241205084500.823660-4-quic_zhonhan@quicinc.com
> The lack of failing getting the bpf_prog_info for changes in the
> kernel was introduced in:
> https://lore.kernel.org/r/20211011082031.4148337-4-davemarchevsky@fb.com
> 
> As v6.17 is currently actively segv-ing in perf test I'd recommend
> these patches go into v6.17 asap.

Sure, I'll add them to perf-tools tree.

> 
> When running the perf tests on v6.17 I frequently see less critical
> test failures addressed in:
> https://lore.kernel.org/all/20250821221834.1312002-1-irogers@google.com/

Are they all from v6.17?

> 
> Ian Rogers (3):
>   perf bpf-event: Fix use-after-free in synthesis
>   perf bpf-utils: Constify bpil_array_desc
>   perf bpf-utils: Harden get_bpf_prog_info_linear

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/util/bpf-event.c | 39 ++++++++++++++++--------
>  tools/perf/util/bpf-utils.c | 61 ++++++++++++++++++++++++-------------
>  2 files changed, 66 insertions(+), 34 deletions(-)
> 
> -- 
> 2.51.0.355.g5224444f11-goog
> 

