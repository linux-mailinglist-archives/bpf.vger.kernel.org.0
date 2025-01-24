Return-Path: <bpf+bounces-49672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE11A1B946
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7322188F932
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9821CFEF;
	Fri, 24 Jan 2025 15:26:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A41CEAC1;
	Fri, 24 Jan 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732415; cv=none; b=mpgLgDtfMSNcpD6geyCr+5jqccaGRKqXTJ1UwmfMnA9QC6fjlR1lUbMzjfba+SzVcllPEbu7W4YfjTTFphK+oS9Bn0l/Aag3qBrMH8PDLYp0BpctqKMV7x6LaBwDb+1XGTcumhig+lTy2y4R9CA84p0DfQkb+flMCmodqP6oGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732415; c=relaxed/simple;
	bh=AgT+TKrcpd+6Khw9eLQ2rx4VQh9+UqGgZnONhArutv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVUzCZl2DL1xDuSAWKoUOG5qTWEE2wKWTZdMBwnijLufon7z3SaltJ3GEUYx1izL8tR/kgJedEuLW8baixMhHGDIkziLR5CP14xZa+JBv7vRW9VlkXn39LuksYtp16eF3jU7rPwAQURuhFqmobPs9F4jp3CgXoOE/PbpwUA5sA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF4C4CED2;
	Fri, 24 Jan 2025 15:26:52 +0000 (UTC)
Date: Fri, 24 Jan 2025 10:27:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: <mhiramat@kernel.org>, <oleg@redhat.com>, <peterz@infradead.org>,
 <mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
 <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
 <jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
 <kan.liang@linux.intel.com>, <andrii.nakryiko@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] uprobes: Remove redundant spinlock in
 uprobe_deny_signal()
Message-ID: <20250124102702.6ff0ccc5@gandalf.local.home>
In-Reply-To: <20250124093826.2123675-2-liaochang1@huawei.com>
References: <20250124093826.2123675-1-liaochang1@huawei.com>
	<20250124093826.2123675-2-liaochang1@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 09:38:25 +0000
Liao Chang <liaochang1@huawei.com> wrote:

> Since clearing a bit in thread_info is an atomic operation, the spinlock
> is redundant and can be removed, reducing lock contention is good for
> performance.

Although this patch is probably fine, the change log suggests a dangerous
precedence. Just because clearing a flag is atomic, that alone does not
guarantee that it doesn't need spin locks around it.

There may be another path that tests the flag within a spin lock, and then
does a bunch of work assuming that the flag does not change while it is
doing that work. That other path would require a spin lock around the
clearing of the flag elsewhere.

I don't know this code well enough to know if this has that scenario, and
seeing the Acked-by from Oleg, I'm assuming it does not. But in any case,
the change log needs to give a better rationale for removing a spin lock than
just "clearing a flag atomically doesn't need a spin lock"!

-- Steve


> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

