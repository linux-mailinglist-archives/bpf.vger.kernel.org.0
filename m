Return-Path: <bpf+bounces-79372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93A8D38E36
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A749300B347
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5411335571;
	Sat, 17 Jan 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nODvOxn6"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9633509B
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768649305; cv=none; b=Xqa1DqcJsm3tIWER4AM230Uo1HmzANQc2Xy4DMGRGtVYqIGAHHh9cdJycAZ80wASH0jsRUlB0yuVWx2hnjrffVo6d9r3XSNbHbZljt8DBNdLdcFazhuq+Qp3bZi1casPEykx/4TIXG4PD5Dnc4A7euX/b+ufkVRxXZmh0tJTSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768649305; c=relaxed/simple;
	bh=CiA1jnqw1srxfLnD1VEzULBPMZw6ET7wjQDQ1skNWzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuRymGTd0rZLeED9Z3Lxez74QuBc/2nAK5HZue8VVdKTFuwkkJF0oVjPu14flleONavolNnb5I9kpnYqsfdvQ9pbi+yKrq+6OnVmcXOml84sajo17cp882CULCtNDjB4jZ7iAmi4kdPwhita7geEqR52mnzvVMoVrmKJ37cgduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nODvOxn6; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768649291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBYBa+bR3weY3dPCVl0KKP8zl+ey+FgUq867VRynmI0=;
	b=nODvOxn6UUM9ljgyDnNwlTHzuIOw2iJyhM8Lpx/FwqZZwcrVQ0QDUTI3oq2yo8ZuA/Jsa1
	Hqu2WNtgHTB7/MeViy6e4We7XC2MsuyvzVNWZM1KPq/YssnR4P5h7G2c4F7uAhg8khfZf9
	7GeEQF8scRuNs+WARyzrYK2ENSuwz6c=
From: Menglong Dong <menglong.dong@linux.dev>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, realwujing@gmail.com, realwujing@qq.com, sdf@fomichev.me,
 song@kernel.org, yonghong.song@linux.dev, yuanql9@chinatelecom.cn
Subject:
 Re: [PATCH v2] bpf/verifier: implement slab cache for verifier state list
Date: Sat, 17 Jan 2026 19:27:53 +0800
Message-ID: <6205668.MhkbZ0Pkbq@7950hx>
In-Reply-To: <20260117032612.10008-1-yuanql9@chinatelecom.cn>
References:
 <14011562.uLZWGnKmhe@7950hx> <20260117032612.10008-1-yuanql9@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/17 11:26, Qiliang Yuan wrote:
> On Fri, 16 Jan 2026 22:50:36 +0800, Menglong Dong <menglong.dong@linux.dev> wrote:
> > On 2026/1/16 21:29, Qiliang Yuan wrote:
> > > The BPF verifier's state exploration logic in is_state_visited() frequently
> > > allocates and deallocates 'struct bpf_verifier_state_list' nodes. Currently,
> > > these allocations use generic kzalloc(), which leads to significant memory
> > > management overhead and page faults during high-complexity verification,
> > > especially in multi-core parallel scenarios.
> > > 
> > > This patch introduces a dedicated 'bpf_verifier_state_list' slab cache to
> > > optimize these allocations, providing better speed, reduced fragmentation,
> > > and improved cache locality. All allocation and deallocation paths are
> > > migrated to use kmem_cache_zalloc() and kmem_cache_free().
> > > 
> > > Performance evaluation using a stress test (1000 conditional branches)
> > > executed in parallel on 32 CPU cores for 60 seconds shows significant
> > > improvements:
> > 
> > This patch is a little mess. First, don't send a new version by replying to
> > your previous version.
> 
> Hi Menglong,
> 
> Congratulations on obtaining your @linux.dev email! It is great to see your
> contribution to the community being recognized.
> 
> The core logic remains unchanged. Following suggestions from several
> reviewers, I've added the perf benchmark data and sent this as a reply to the
> previous thread to keep the context and review history easier to track.

You can put the link of your previous version to the change log. I
suspect the patchwork can't even detect this new version if you send
it as a reply.

> 
> > > Metric              | Baseline      | Patched       | Delta (%)
> > > --------------------|---------------|---------------|----------
> > > Page Faults         | 12,377,064    | 8,534,044     | -31.05%
> > > IPC                 | 1.17          | 1.22          | +4.27%
> > > CPU Cycles          | 1,795.37B     | 1,700.33B     | -5.29%
> > > Instructions        | 2,102.99B     | 2,074.27B     | -1.37%
> > 
> > And the test case is odd too. What performance improvement do we
> > get from this testing result? You run the veristat infinitely and record the
> > performance with perf for 60s, so what can we get? Shouldn't you
> > run the veristat for certain times and see the performance, such as
> > the duration or the CPU cycles?
> 
> Following suggestions from several reviewers, I aimed to provide perf
> benchmark data for comparison. However, existing veristat tests do not
> frequently trigger the specific state list allocation paths I modified. This
> is why I constructed a dedicated stress test and included the code in the
> commit message to clearly demonstrate the performance gains.
> 
> > You optimize the verifier to reduce the verifying duration in your case,
> > which seems to be a complex BPF program and consume much time
> > in verifier. So what performance increasing do you get in your case?
> 
> The performance gains are primarily seen in the 31.05% reduction in Page Faults
> and the 4.27% increase in IPC. These metrics indicate that moving to a
> dedicated slab cache significantly reduces memory management overhead and
> improves instruction throughput. Specifically, the reduction in CPU cycles
> (-5.29%) confirms that the verifier spends less time on internal allocation
> logic, which is crucial for complex BPF programs that involve deep state
> exploration.

You introduce the slab cache to speed up the verifier, so I think we need
a comparison, such as how long a complex BPF program can take in
the verifier. If it is no more than 1ms, then I think it doesn't make much
sense to obtain the 5% speeding up. After all, it's not a BPF runtime
overhead.

> 
> > > Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > 
> > You don't need to add all the reviewers here, unless big changes is
> > made.
> 
> That makes sense, thanks for the advice. I'll refine this in the next version.
> 
> > > Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> > > ---
> > > On Mon, 2026-01-12 at 19:15 +0100, Kumar Kartikeya Dwivedi wrote:
> > > > Did you run any numbers on whether this improves verification performance?
> > > > Without any compelling evidence, I would leave things as-is.
> > 
> > This is not how we write change logs, please see how other people
> > do.
> 
> Actually, the content following the 'Signed-off-by' line and the '---' marker 
> is specifically designed to be ignored by 'git am' when the patch is applied. 
> Only the text above the triple-dash is preserved as the permanent commit 
> message. I intentionally placed the responses to previous reviewer comments 
> in that section so that you could see the context and history during review 
> without those discussions being permanently recorded in the git log. You can 
> verify this behavior by testing 'git am' on a similar patch.
> 
> It's for this very reason that I decided to include the reply to reviewers 
> directly within the v2 patch.

I think we don't do it this way, and it makes the patch look a mess. You can
reply directly in the mail.

> 





