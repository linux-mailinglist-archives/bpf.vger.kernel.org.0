Return-Path: <bpf+bounces-68597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FFAB7C89D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AADE4855BF
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5521B918;
	Wed, 17 Sep 2025 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QppvF20h"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067A1C3BF7
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072368; cv=none; b=l+J1mdzMxCzcw8JsvjvFDyFM8sxIRgSC5R79GISUkBSy1JaDnAGx06Jewl7b3F0xK30JAhxJGdSi48dwZ0DsAySUCSXTL3XvXQY2w0XhnPpeUON5MZXBXpLOV8QqRfUjFltm79tAtRvxpSikWl5EHMW0ZYYzA9LLuAR/mPo3sx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072368; c=relaxed/simple;
	bh=qrwdS582Ql+tsYCi8nBeVnU0v9lf73ydrnVqX/BKwwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EM4HzcRveXYx3Dq3iONx0qXRpTlusWrRO59yt1x4sk3nfGOmFKV4QZLcKUeK5NpFNk8Eor3Q9Ynt04/qhtYFZVpnrlML2I9CHgZ6ktNutKpMDOd7jKnUSu21UVI3EdDFQZcevo2SGk3+LwJyMbm8nGzdb2Z324IBsbpLJ68aiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QppvF20h; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758072354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuRIqar5Bq7mbyRIhJVV2JptjbVueolXtHX+wWyAwEw=;
	b=QppvF20hTwuMZ3xgwgX1nX19tj3wwWbWUxFfGd3QyFEeeTesiEKL5ATZFt7BfGKZn5Y5/f
	W2nD3Og66bPI9T5uLiTTBwPzRXyHitfC4WPazRj5JRG84zCa2nWfVfdmYu74+syagrSIdx
	obQxDto0Aw6VN8z9pe86VcehWKC9+/w=
From: Menglong Dong <menglong.dong@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>, ast@kernel.org
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tzimmermann@suse.de, simona.vetter@ffwll.ch, jani.nikula@intel.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 2/3] sched: make migrate_enable/migrate_disable inline
Date: Wed, 17 Sep 2025 09:25:44 +0800
Message-ID: <5041847.31r3eYUQgx@7940hx>
In-Reply-To: <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
References:
 <20250828060354.57846-1-menglong.dong@linux.dev>
 <20250828060354.57846-3-menglong.dong@linux.dev>
 <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/16 19:07 Peter Zijlstra <peterz@infradead.org> write:
> On Thu, Aug 28, 2025 at 02:03:53PM +0800, Menglong Dong wrote:
> 
> > +/* The "struct rq" is not available here, so we can't access the
> > + * "runqueues" with this_cpu_ptr(), as the compilation will fail in
> > + * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
> > + *   typeof((ptr) + 0)
> > + *
> > + * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
> > + */
> 
> Please fix broken comment style while you fix that compile error.

It's a little embarrassing. The compile error is caused by the commit
1b93c03fb319 ("rcu: add rcu_read_lock_dont_migrate()") in bpf-next tree,
which uses migrate_enable/migrate_disable in include/linux/rcupdate.h
but include the <linux/preempt.h>.

I can fix it by replace the linux/preempt.h with linux/sched.h, but should
I fix it in this series? I mean, the commit 1b93c03fb319 doesn't exist in
the tip for now :/

Thanks!
Menglong Dong

> 
> 





