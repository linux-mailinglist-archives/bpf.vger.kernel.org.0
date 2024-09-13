Return-Path: <bpf+bounces-39825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E311978053
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297DD1F23437
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9751DA2E2;
	Fri, 13 Sep 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1fuVgCF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199591D9348
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231520; cv=none; b=asOgtmG1hlvdeM69yKD6/qqQht3wcOGRncwg9HFy4EpoqM84bUPT2EPKx3NGpXY2Dr1KAK2E4Wvvdz9ENX1W9pxCvnZaYol/RNaDBlJr5YtKYvbUdgdL8BAZDl6rqgC0ayG5kusb2KS2Nrt5Y189i3tcSqNKtX9JukajCwRVbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231520; c=relaxed/simple;
	bh=cGyOYOSjyHdELfZ+B0zzPen0DIFwtI6GvpI4dgZ+Zq0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kAjcHFjAJPPZhRAG1MfSf5bP1R3AVeot4jdG9VEvvMXdgVFovNyO76ymcoNiTPwD1w4+z8foBwEBvyPqs1my8RYUphXOObAcdtedgfakrpnwecyD+DGqFa/s6G/EQZooPA7faUPWYkGw1ZyxtQBkOmGWMhL77J9u62pgURwkxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1fuVgCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F29C4CEC0;
	Fri, 13 Sep 2024 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726231519;
	bh=cGyOYOSjyHdELfZ+B0zzPen0DIFwtI6GvpI4dgZ+Zq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A1fuVgCFvuQvRpz7K74HMNLLM8rwL6M82/ALm5qTbnpe2kK8ApjZ5O35w3rGjShG4
	 cOpHUutAUKbleDAzHoX5BZrrcXe8/ZSxrJ8V4J0mjCNWg+RYaWxCyHNmJ6QSm8XQNO
	 uQL4YOJ9RQsWnVmdq4SP5cFGVTvPd/m3NdxFnwk2DED0NgtDTK/O9Bx1YYdNYzp7wV
	 M/NkqhV8PkwkAyPQF6nASHpz4C/WSStThDTitk0dlaGfLVo5rrNt0x3LKHIuAn1Cn9
	 srGNhoIRtquTVtQFq45edOYbsQLNgs4ZtDJjU6dIAmefiPfjrV/RLpasXEVJD/v1/Q
	 IxowZKmc0M29A==
Date: Fri, 13 Sep 2024 21:45:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, kernel-ci@meta.com,
 bot+bpf-ci@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, bpf <bpf@vger.kernel.org>, Jiri Olsa
 <jolsa@kernel.org>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240913214515.894c868a1ef4968550553b86@kernel.org>
In-Reply-To: <20240913175935.bb0892ab1e6052efc12c6423@kernel.org>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
	<CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
	<20240913085402.9e5b2c506a8973b099679d04@kernel.org>
	<CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
	<20240913175935.bb0892ab1e6052efc12c6423@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 17:59:35 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > Taking failing output from the test:
> > 
> > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> > 
> > kretprobe_test3_result is a sort of identifier for a test condition,
> > you can find a corresponding line in user space .c file grepping for
> > that:
> > 
> > ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1,
> > "kretprobe_test3_result");
> > 
> > Most probably the problem is in:
> > 
> > __u64 addr = bpf_get_func_ip(ctx);
> 
> Yeah, and as I replyed to another thread, the problem is
> that the ftrace entry_ip is not symbol ip.
> 
> We have ftrace_call_adjust() arch function for reverse
> direction (symbol ip to ftrace entry ip) but what we need
> here is the reverse translate function (ftrace entry to symbol)
> 
> The easiest way is to use kallsyms to find it, but this is
> a bit costful (but it just increase bsearch in several levels).
> Other possible options are
> 
>  - Change bpf_kprobe_multi_addrs_cmp() to accept a range
>    of address. [sym_addr, sym_addr + offset) returns true,
>    bpf_kprobe_multi_cookie() can find the entry address.
>    The offset depends on arch, but 16 is enough.

Oops. no, this bpf_kprobe_multi_cookie() is used only for storing
test data. Not a general problem solving. (I saw kprobe_multi_check())

So solving problem is much costly, we need to put more arch-
dependent in bpf_trace, and make sure it does reverse translation
of ftrace_call_adjust(). (this means if you expand arch support,
you need to add such implementation)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

