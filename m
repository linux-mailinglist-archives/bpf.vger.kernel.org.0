Return-Path: <bpf+bounces-56224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42ECA93329
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 09:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E331A178890
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 07:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C0269CE5;
	Fri, 18 Apr 2025 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD1MaHrQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957F25487A;
	Fri, 18 Apr 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744959884; cv=none; b=Qercxyl2dND9XEynJ7glzP5KYYNBv71rczlz3Gue8vvJVZNEgxaS1bfUnH0BfFUKBg0v3fyBajafZ5jbAnO2ZgDZG6Y1r7oUK52vAgJ5W44p5J/CjgHeqQSDD94WujRCP6wmDyURFYhYabCH0fYDkJLfSMGpBNw57KsU068ZLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744959884; c=relaxed/simple;
	bh=+KIilC/KK10PFDQbziKDb23AVy0Bd3WaO5GJCqpwodc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqkGwK3jmJON2DucK1seF/Nw/NbJA3BlGMCqpE41FKX46uTdmrIH5KZNLQ0rkxKA78ULbl1rYDL3C39NS8xUK3gUddnGcW0gdEZs1hNwzSU0S0TCViYLchEWPd7gwCAao2c1ipxiMVmyxF+dJ5A3Q3nOCl2tR7BIxEaonQA5r+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD1MaHrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3221AC4CEE2;
	Fri, 18 Apr 2025 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744959883;
	bh=+KIilC/KK10PFDQbziKDb23AVy0Bd3WaO5GJCqpwodc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GD1MaHrQf7F4sFX62+d0KZnhJ+YiUfKB9JdvR7t5uihY6MeMLljCCGOKOsWkU1ncW
	 yGI7Ce+N+9XvByDTP45l69juq3Mt6582wIiKgUGmYhiHR0NKl7eGTbiNTP34iwyIOU
	 qZujrxatZ1SmU2ORTFHM3rYosNtbpRjjPIWxv5e8AGBP00tKCjxGkD83nyF+hy2wFy
	 QncPStZS8OOpskiVwJZCC9CWbnNTwGi7wWmoNmodyZS7bVBiK1NP4k571Pyanrr7z0
	 iF27zPXDTWJS3cViu41U9hSbT7e0JTzYYD8yb+i97ROc+dUTOHaau/ioy7SX7i7Pou
	 VjroniTZSoUCA==
Date: Fri, 18 Apr 2025 09:04:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv3 perf/core 2/2] selftests/bpf: Add 5-byte nop uprobe
 trigger bench
Message-ID: <aAH5hvMQ41FUlKPu@gmail.com>
References: <20250414083647.1234007-1-jolsa@kernel.org>
 <20250414083647.1234007-2-jolsa@kernel.org>
 <CAEf4Bzadf-k7vcDWm40yjpq7P4dYEr5pKTKsgthvWs_GqvoRNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzadf-k7vcDWm40yjpq7P4dYEr5pKTKsgthvWs_GqvoRNA@mail.gmail.com>


* Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Apr 14, 2025 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add 5-byte nop uprobe trigger bench (x86_64 specific) to measure
> > uprobes/uretprobes on top of nop5 instruction.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c           | 12 ++++++
> >  .../selftests/bpf/benchs/bench_trigger.c      | 42 +++++++++++++++++++
> >  .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
> >  3 files changed, 55 insertions(+), 1 deletion(-)
> >
> 
> LGTM. Should we land this benchmark patch through the bpf-next tree?
> It won't break anything, just will be slower until patch #1 gets into
> bpf-next as well, which is fine.
> 
> Ingo or Peter, any objections to me routing this patch separately
> through bpf-next?
> 
> But either way:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

I've applied this to the perf tree with a few readability edits to the 
changelogs and the new tags added in.

Thanks,

	Ingo

