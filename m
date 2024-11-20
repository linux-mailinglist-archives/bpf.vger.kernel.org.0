Return-Path: <bpf+bounces-45285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D39D4030
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0979B3C94D
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCB414F132;
	Wed, 20 Nov 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBRUWNLH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B413B58A;
	Wed, 20 Nov 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118605; cv=none; b=ARlfOLutSs6zUMqnattwFzuSR49fEUpHiAOTio0YbvIL1lXGhFQuWBBjekPv75SfL/Reoitjowr7NgVM4ign6bfg2iPjmFqiDA7kY4QkQVUps7Jyr6ohLxtFSbEADntyI1hdXdGkZ/cPidZG5RxmUqCOFDRNyUXTEcEOgKEo3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118605; c=relaxed/simple;
	bh=l9At4QAU1UWOdiHd0AM/zaIAhJIXZNKutllsFxhd04c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovfen8eFRUGC4ijEPOY/ufR7D838CcGe2ZXMv21Q+N7izwqpoTVahfTAuX6Tary8DltZmxA3kn3zJVJNTXIsafZoUF4u+FKQW50uoPxj11p3U+JzeX0Irkdb68IBTwLmkdTFdcXpAxgXaV6QeOpXN7jKg8ST8vhCKsZ8YsNpp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBRUWNLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3DCC4CECD;
	Wed, 20 Nov 2024 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118604;
	bh=l9At4QAU1UWOdiHd0AM/zaIAhJIXZNKutllsFxhd04c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBRUWNLHRfZeQXMu7YAN3oI6Uslc8DdiOozdXsGOLr5vSQVyQBykU8uvU1q668mLY
	 TMtblbKYRnL24mIoJatHJ2AZiGKghQBFG/eTgfk4sIjgVRqe8TfyJ/xk2vwnX1WnHA
	 wLA6aGH16h/F9Bis7foCon/OkCF9RPqyCsY9TCjStwVdBSUbWembvOCPmjIF4GOvVj
	 tvbF11Dc4XbXwkRf0KNuvjtSsjT634wGzdQ1R5MtHwraGXLVV/LWT0FSyqQ25APhJs
	 coRzeI/IFJZzzvtDkp8ZglyDCN+ym0jqz5AWZqyiCK8smJvW+qPsrJTsUl1y8VlJI2
	 +dPiw54jhcWWQ==
Date: Wed, 20 Nov 2024 17:03:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com,
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, vbabka@suse.cz,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, david@redhat.com, arnd@arndb.de,
	richard.weiyang@gmail.com, zhangpeng.00@bytedance.com,
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH v4 tip/perf/core 0/4] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
Message-ID: <Zz4IQaF9CCfjS28S@gmail.com>
References: <20241028010818.2487581-1-andrii@kernel.org>
 <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
 <CAEf4Bza=pwrZvd+3dz-a7eiAQMk9rwBDO1Kk_iwXSCM70CAARw@mail.gmail.com>
 <CAEf4BzbiZT5mZrQp3EDY688PzAnLV5DrqGQdx6Pzo6oGZ2KCXQ@mail.gmail.com>
 <20241120154323.GA24774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120154323.GA24774@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 20, 2024 at 07:40:15AM -0800, Andrii Nakryiko wrote:
> > Linus,
> > 
> > I'm not sure what's going on here, this patch set seems to be in some
> > sort of "ignore list" on Peter's side with no indication on its
> > destiny.
> 
> *sigh* it is not, but my inbox is like drinking from a firehose :/

And I've been considering that particular series WIP for two reasons:

 1) Oleg was still unconvinced about patch 5/5 in the v2 discussion. 
    Upon re-reading it I think he might have come around and has agreed 
    to the current approach - but sending a v3 & not seeing Oleg object 
    would ascertain that.

 2) There was a build failure reported against -v2 at:

       https://lore.kernel.org/all/202410050745.2Nuvusy4-lkp@intel.com/t.mbox.gz

    We cannot and will not merge patches with build failures.

Andrii did get some other uprobes scalability work merged in v6.13:

    - Switch to RCU Tasks Trace flavor for better performance (Andrii Nakryiko)

    - Massively increase uretprobe SMP scalability by SRCU-protecting
      the uretprobe lifetime (Andrii Nakryiko)

So we've certainly not been ignoring his patches, to the contrary ...

Thanks,

	Ingo

