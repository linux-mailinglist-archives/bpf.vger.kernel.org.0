Return-Path: <bpf+bounces-63351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD235B0654A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D006D1AA1A84
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E5285C9D;
	Tue, 15 Jul 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebpZ0Ha1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C32CCC0;
	Tue, 15 Jul 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601102; cv=none; b=MCNgH0O61MjW0u3+nGBWYVmNILsQCmgZrwLg9tATzSWXX8XsR+4jim7V30wUes2xYGbT/E0292TMlMf1MjNQk7V3YOhJ9aBBiiXACzgtVnqZNGuN+TcgDqsp+jYqRtuNeLRgavCGCYvIGKRWGPRizXXMX5v8NgKksA+pP6WB4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601102; c=relaxed/simple;
	bh=7qOz6bO8oow6/lj2V2t39LS5oFJRjWFbm4P2eTmWqE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q3wLJ2mUxss6TlPWp0X+oRnis3v9G72Dwaj7aRlwx86M/wITi4H+RtowIijeSEFZI0eGOJjQrfT9dS95h1jU6eFAR5HIptPz/ZGsRglD72GCudBSATC78lgzuJ3KJEc64cZwZOTBAvgf0Kzu8r6H9RPz+jIvQv3YwobWm6EiGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebpZ0Ha1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4C8C4CEF4;
	Tue, 15 Jul 2025 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752601101;
	bh=7qOz6bO8oow6/lj2V2t39LS5oFJRjWFbm4P2eTmWqE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ebpZ0Ha17SLFFqZl7HcgzPyO/dW7XJTYJEf82O7beE4LGJOvErYHU+7IF0CzGD9/Z
	 FKbC1eWfgloojN5sIz59hOxtjN2U41T2BcEt9+fESGvW/L7sslSX5pu9VIwMuIC5kR
	 1ljv3IQ1SM+9h67akl/5mTOia34oJYnFVc/f16RhUp/o3RsptcOlLtTLrMNx3jOHJp
	 8pJMGkxHzLpZOAI5ITPDxuxHivJTw5XQm3ePNdMOXIFiOiXvOAk4HtS+yG5KRpqkTR
	 LM8XPvTAeB16Pf02eZ3q9BOV4ESiOj9QIw8kVud6J9qXISF7jhNM9MRcSPhiFDaU/m
	 cRaccjIdatc0A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Song Liu <song@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20250714052143.342851-1-namhyung@kernel.org>
References: <20250714052143.342851-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] perf ftrace latency: Add -e option to measure time
 between two events
Message-Id: <175260110062.3546942.14666650771483286173.b4-ty@kernel.org>
Date: Tue, 15 Jul 2025 10:38:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 13 Jul 2025 22:21:43 -0700, Namhyung Kim wrote:
> In addition to the function latency, it can measure events latencies.
> Some kernel tracepoints are paired and it's menningful to measure how
> long it takes between the two events.  The latency is tracked for the
> same thread.
> 
> Currently it only uses BPF to do the work but it can be lifted later.
> Instead of having separate a BPF program for each tracepoint, it only
> uses generic 'event_begin' and 'event_end' programs to attach to any
> (raw) tracepoints.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



