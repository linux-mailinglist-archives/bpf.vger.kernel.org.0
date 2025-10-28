Return-Path: <bpf+bounces-72629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F307CC16AEB
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 20:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A334D356854
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507534DB4C;
	Tue, 28 Oct 2025 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GokpmF4j"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA92BE04B;
	Tue, 28 Oct 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681270; cv=none; b=Dv9DIwiU7AlO5oFABsrOZo4zXtZl9JmZcF5VHgp5+L47wsUrQQ8Z4Lrr8vfaBOaSiuqqR1veHJOgF5fwmHeNg/jOmSidALesZeuHgjfLapDlCIrbWIQLggyVFeVw1VHFkrwM04yjh+WmMum2wk/C+DMV/tiux5bRES3YeWhhPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681270; c=relaxed/simple;
	bh=PjuO3FlWFh2/k0xrW5JQXDEz6+CkeOl/301PZpppegE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSuZRP3hsdtgwAuJhRjbD6fiFjCn66XykAjRsv3nwpBAfoo9AF2FdzeQg0PcuR24dzieR4BobtzU2rknVjL09kUQeyAj/E8k/gzbwzQd93T8m1ofs5jfe2sss2ABVDJBxjUucI3y+E1jlAAIgRvWrzgEq2szPr6NHRz2BEsNVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GokpmF4j; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761681264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1vfNH1OtxcVF1Jg9QAf61yzDR/63k5WefYxmSxcqt4=;
	b=GokpmF4jfTl+pwsmQbtDT5ic/PNmqZi3UwNtLBQo6WzF05jogM1a4ra3TXZ0+gSmuQhSt9
	0tM68yBrWrIn74Ess33qfXZCGPme1h6MljFE/w427Ce82/ru+IdWwypGezWDhGWJSCFv/D
	y+QdscXaBfltrFgGplzm1qPNl8ODy0M=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 20/23] sched: psi: implement bpf_psi struct ops
In-Reply-To: <aQEM7LXpZdOpsgvU@slm.duckdns.org> (Tejun Heo's message of "Tue,
	28 Oct 2025 08:35:24 -1000")
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
	<20251027232206.473085-10-roman.gushchin@linux.dev>
	<aQD_-a8oWHfRKcrX@slm.duckdns.org> <877bweswvo.fsf@linux.dev>
	<aQEM7LXpZdOpsgvU@slm.duckdns.org>
Date: Tue, 28 Oct 2025 12:54:16 -0700
Message-ID: <87cy66pztj.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> On Tue, Oct 28, 2025 at 11:29:31AM -0700, Roman Gushchin wrote:
>> > Here, too, I wonder whether it's necessary to build a hard-coded
>> > infrastructure to hook into PSI's triggers. psi_avgs_work() is what triggers
>> > these events and it's not that hot. Wouldn't a fexit attachment to that
>> > function that reads the updated values be enough? We can also easily add a
>> > TP there if a more structured access is desirable.
>> 
>> Idk, it would require re-implementing parts of the kernel PSI trigger code
>> in BPF, without clear benefits.
>> 
>> Handling PSI in BPF might be quite useful outside of the OOM handling,
>> e.g. it can be used for scheduling decisions, networking throttling,
>> memory tiering, etc. So maybe I'm biased (and I'm obviously am here), but
>> I'm not too concerned about adding infrastructure which won't be used.
>> 
>> But I understand your point. I personally feel that the added complexity of
>> the infrastructure makes writing and maintaining BPF PSI programs
>> simpler, but I'm open to other opinions here.
>
> Yeah, I mean, I'm not necessarily against adding infrastructure if the need
> is justified - ie. it enables new things which isn't reasonably feasible
> otherwise. However, it's also a good idea to start small, iterate and build
> up. It's always easier to add new things than to remove stuff which is
> already out there. Wouldn't it make more sense to add the minimum mechanism,
> see how things develop and add what's identified as missing in the
> process?

Ok, let me try the TP approach and see how it will look like.
If there won't see any significant downsides, I'll drop the BPF PSI triggers
infrastructure.

Thanks!

