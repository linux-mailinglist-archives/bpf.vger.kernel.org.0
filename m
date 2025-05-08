Return-Path: <bpf+bounces-57798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BAAB0428
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 21:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28104B27134
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821C28B7DA;
	Thu,  8 May 2025 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvs5N6ry"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7F28B3FF;
	Thu,  8 May 2025 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734163; cv=none; b=WppB3PgsVp1TuQInRS4NdUZhW0cTPmEvmNQPFHVOxgXwIEL85XaEcB6iqVNvYoUTNfmZimW5XVUgD1LF2jq85C0mgemNcwXyk/4kYpRUxPLMpMYbLyJGQtJQDYlN7Uzt6bK9W/g/SMyfWLRkiQ70BWf7A2fkfqz1TqQROEhP0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734163; c=relaxed/simple;
	bh=i55yyCYs9Dt3rXnaFOCk8AYoNdtlA/BZ9TyZhfIZYD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTuWztp2hLryUh3f4oOd0LjbRlb3QCmH4qOzySi7heqsIPsg0RgBCEaXool5f6hwin7vQ1PBzEwsuI2UZRwgn9ND4dYaZAnCTpaqOMFqz/yrKcAxMcjppFrKWjtqBNJjghB9VZPdm6wmK1itXMA6Nk2RY4M+ruSD/bJP8vzVD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvs5N6ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD9AC4CEE7;
	Thu,  8 May 2025 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746734162;
	bh=i55yyCYs9Dt3rXnaFOCk8AYoNdtlA/BZ9TyZhfIZYD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hvs5N6ryFk59z6pPXVxhcYl2MryOdOtS5sYfit97fKLoaEYK8e9HM//Afqzthne4x
	 yigk2HE3LKMqIjok5etCP8+6I2eXaoMSu0d3Ouh+2CGDLwUnvGt+Obq3KhPXpYf9Ez
	 mThrt+/MZl2qozdwK3uYcgkikoFczV6SOFyq8WkkWYpPQ7GCC9/4eWGEkrvOnbjEEl
	 l3vTRYZHUdEQ/Ncc7/oY9MvNzRfjwzdeGlKnLgUmEjgz22oi0fi+kiNlDRDjTKddFr
	 jHo+Ju3uD6TlQIJZFdYvOFtMsCwPm2qCoJxDybbDTJZavJKMoIvSEpSy6UpWd2CJnH
	 AiqbZRj0ybM2Q==
Date: Thu, 8 May 2025 16:55:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [RFC/PATCH] perf lock contention: Add -J/--inject-delay option
Message-ID: <aB0MSvrGA5fgH5Hj@x1>
References: <20250225075929.900995-1-namhyung@kernel.org>
 <aBzDpi25-LBgAjEj@x1>
 <aBzqGn0Ktbl38sOF@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBzqGn0Ktbl38sOF@google.com>

On Thu, May 08, 2025 at 10:30:02AM -0700, Namhyung Kim wrote:
> On Thu, May 08, 2025 at 11:45:58AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Feb 24, 2025 at 11:59:29PM -0800, Namhyung Kim wrote:
> > > This is to slow down lock acquistion (on contention locks) deliberately.
> > > A possible use case is to estimate impact on application performance by
> > > optimization of kernel locking behavior.  By delaying the lock it can
> > > simulate the worse condition as a control group, and then compare with
> > > the current behavior as a optimized condition.

> > So this looks useful, I guess we can proceed and merge it?

> That'd be great. :)

Can you please refresh it?

⬢ [acme@toolbox perf-tools-next]$        git am ./20250224_namhyung_perf_lock_contention_add_j_inject_delay_option.mbx
Applying: perf lock contention: Add -J/--inject-delay option
error: patch failed: tools/perf/util/bpf_skel/lock_contention.bpf.c:11
error: tools/perf/util/bpf_skel/lock_contention.bpf.c: patch does not apply
error: patch failed: tools/perf/util/lock-contention.h:140
error: tools/perf/util/lock-contention.h: patch does not apply
Patch failed at 0001 perf lock contention: Add -J/--inject-delay option
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbox perf-tools-next]$ git am --abort
⬢ [acme@toolbox perf-tools-next]$ 
⬢ [acme@toolbox perf-tools-next]$ patch -p1 < ./20250224_namhyung_perf_lock_contention_add_j_inject_delay_option.mbx
patching file tools/perf/Documentation/perf-lock.txt
Hunk #1 succeeded at 216 (offset 1 line).
patching file tools/perf/builtin-lock.c
Hunk #2 succeeded at 2003 (offset 30 lines).
Hunk #3 succeeded at 2508 (offset 30 lines).
Hunk #4 succeeded at 2652 (offset 30 lines).
patching file tools/perf/util/bpf_lock_contention.c
Hunk #1 succeeded at 261 (offset 78 lines).
Hunk #2 succeeded at 373 (offset 80 lines).
patching file tools/perf/util/bpf_skel/lock_contention.bpf.c
Hunk #1 succeeded at 14 with fuzz 2 (offset 3 lines).
Hunk #2 succeeded at 152 (offset 35 lines).
Hunk #3 FAILED at 153.
Hunk #4 succeeded at 397 (offset 39 lines).
Hunk #5 succeeded at 835 with fuzz 1 (offset 230 lines).
1 out of 5 hunks FAILED -- saving rejects to file tools/perf/util/bpf_skel/lock_contention.bpf.c.rej
patching file tools/perf/util/lock-contention.h
Hunk #2 succeeded at 146 with fuzz 1.
Hunk #3 succeeded at 156 (offset 1 line).
⬢ [acme@toolbox perf-tools-next]$

