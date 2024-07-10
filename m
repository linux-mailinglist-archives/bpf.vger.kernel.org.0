Return-Path: <bpf+bounces-34378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AFD92CF93
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 12:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A25286829
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1718FA37;
	Wed, 10 Jul 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jkd/Ix7X"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AE43156;
	Wed, 10 Jul 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606210; cv=none; b=CWtO6rLfKJ9Y/IghzBWAcSP9GFyKn2XNGmntAFnzZVwyrAon1YeVe3/Lo78iKEoxPOVmnFzLUB7dapqEIMVxHDDEINBJBFyHBy9aug6lDaqU225pCqG5MQbM/DK/OyJ8HK0es3hb7rIa1GRbIEm313vMgrA49CKTibJcof1gyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606210; c=relaxed/simple;
	bh=Ng8S+1BcKoxumpudowjbxL6VLbDq5Q9gGByFKUUsFYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmM/y38IFIlbi+QqYBsAUrKxdngE+Aee50dPZ9O2NM02w4iLiJzTIl+8bb9UUj3NLMxHVPEurdPp/ABrsKGwV4Fh8W6zY1T6LIPcwfVGKvppTchiCJqmY4rRp00Zm8iMPQCowBwtbPvPZe0SZN3ialX2nw9xHQUkLAIGkH5Fqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jkd/Ix7X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1yWFMPrFqfyC61fi5S/A3/M+2F2s2Kz1I84XYYwzx1k=; b=Jkd/Ix7XQG2rIawzoekH1STabw
	yI8CzwNv25PfCc2ujPrznY6xNqZSWcGAq9+G0WUFcYXUiGqR3+/brumwIvfW2rmmnkeaH4rxFuV8C
	gnWJx7t+IDr/Gbns4iY+pNHM5so/se2bPWfQTmQwlBuo2rSYR/7HKoowlsnsTDc0GYzKHT3u4RWHE
	W1A5QTjIH2iJi0VlWu7tvLMeKPS0SO8P/1vnrRIaoPN7sfW0d16jsC9YTqce8GkZXEBiPolxLlncS
	tlgBrUSUGFEG1+PzEBeeRLQf5IRZoIW0kespIB3fX64LCL8E1kS1wq5bbQxCygUWsz1gGzrF30rQb
	qZ1Oa4PA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRUGy-000000095kw-0eN8;
	Wed, 10 Jul 2024 10:10:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C246B300694; Wed, 10 Jul 2024 12:10:03 +0200 (CEST)
Date: Wed, 10 Jul 2024 12:10:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, clm@meta.com,
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240710101003.GV27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090304.GG27299@noisy.programming.kicks-ass.net>
 <Zo0KX1P8L3Yt4Z8j@krava>
 <20240709101634.GJ27299@noisy.programming.kicks-ass.net>
 <20240710071046.e032ee74903065bddba9a814@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710071046.e032ee74903065bddba9a814@kernel.org>

On Wed, Jul 10, 2024 at 07:10:46AM +0900, Masami Hiramatsu wrote:

> > FFS :-/ That touches all sorts and doesn't have any perf ack on. Masami
> > what gives?
> 
> This is managing *probes and related dynamic trace-events. Those has been
> moved from tip. Could you also add linux-trace-kernel@vger ML to CC?

./scripts/get_maintainer.pl -f kernel/events/uprobes.c

disagrees with that, also things like:

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=probes/for-next&id=4a365eb8a6d9940e838739935f1ce21f1ec8e33f

touch common perf stuff, and very much would require at least an ack
from the perf folks.

Not cool.

