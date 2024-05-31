Return-Path: <bpf+bounces-31078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94D38D6CF5
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 01:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534391F267AB
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 23:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC7C12FB1B;
	Fri, 31 May 2024 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JM4VUaWy"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D9134BC;
	Fri, 31 May 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199068; cv=none; b=PL97nM1tzgeWJRQbjA/jZ7XZuxXLg+AYFSXZs4g8Es0yXcW0pHlyEns1LwDdMj+eI62a/pYksoS+Ejh6M2y86y+pNjfhdiLML7Rkb71NYOjqPHACvVeWVYZhli8tzTwpTMNUan2FR1LWFfFOQbo/IiI/CIkt68ptKNVosDuhXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199068; c=relaxed/simple;
	bh=+1lYI39XvWKgc3DpuRrlaTX27AIFQ1b7IGpUMM1waoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjbvYtJKkQsb3YYlhFxORYgduQZMH4M/q6GtvcHuSXKO6+yXpgUcQhWXllejqMxYd2ziJ23FfzUk88Saya5MA0FM5TJcZB2nntuNwbLNbnSQEuFk0R2QJcO1wUw0/5eTk/c9M+ZkpYRCwVpgg2pvGPq7ixOSUNr/EhG3budVzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JM4VUaWy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717199064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQSw4uPQgRlAk3kSFCT2kJLdIQ/8AieJ62AywbPlN10=;
	b=JM4VUaWyXQA4oPsqLQCYJRQ+U5ltEWNYbqydiC0118Lvw8ARSRQKxDtoz/LXNP3l36eZfL
	/0+mD9xqfT1uKyARczwtW716OzeJDqc/dzWzcB7fmug0ExijVA7JmuW/f4IgXve4nDh6uQ
	An09w1e8j9woSKGsMHLCxhQsgpbmDFs=
X-Envelope-To: akinobu.mita@gmail.com
X-Envelope-To: cl@linux.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: naveen.n.rao@linux.ibm.com
X-Envelope-To: anil.s.keshavamurthy@intel.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: mhiramat@kernel.org
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Date: Fri, 31 May 2024 16:44:16 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] mm, slab: add static key for should_failslab()
Message-ID: <Zlpg0OFOsOSxrh9I@P9FQF9L96D.corp.robot.car>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
 <20240531-fault-injection-statickeys-v1-3-a513fd0a9614@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-fault-injection-statickeys-v1-3-a513fd0a9614@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 11:33:34AM +0200, Vlastimil Babka wrote:
> Since commit 4f6923fbb352 ("mm: make should_failslab always available for
> fault injection") should_failslab() is unconditionally a noinline
> function. This adds visible overhead to the slab allocation hotpath,
> even if the function is empty. With CONFIG_FAILSLAB=y there's additional
> overhead when the functionality is not enabled by a boot parameter or
> debugfs.
> 
> The overhead can be eliminated with a static key around the callsite.
> Fault injection and error injection frameworks can now be told that the
> this function has a static key associated, and are able to enable and
> disable it accordingly.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

