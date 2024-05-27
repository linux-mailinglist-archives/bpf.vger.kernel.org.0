Return-Path: <bpf+bounces-30620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86EA8CF6E9
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 02:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6334A28168C
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 00:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEF624;
	Mon, 27 May 2024 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPHIv4TU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B94161;
	Mon, 27 May 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716768281; cv=none; b=JfLnv9pDaaC8echBKxcBAJyCvFJ2co7lXgXIt9LjNI48OPzLwzloV08Cb4k5QdteQdMSz24+QzQa/IM74XqHSN7iSS9rK/92cLSd23QmXj1Pmp7F30OWZKECR5HsFSk2UUF4iJUBkFPH6fkxXkI4t7suEtJD6h5hz31jAyOpIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716768281; c=relaxed/simple;
	bh=PcmYPBGo2XhGqyaercyt+IZ2k2DlEHd7kUXcc3kQ2Eg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Na0WHFF7aW9Q4nVEU4fthGx/N5WKgbf2qLTvr8BZCTbUR4ZYBKK94wZofRm/DiaA9bXZKjLdG16kmIZLs8xIXMcjuP+QCUB0uAbdtHNzGS1d2Vc1E/GnmjNg2HMbSuYEMlujl7muZ0Y3tNmqJs8IIqysy89qJzoA1yc436U3Npw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPHIv4TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68FBC2BD10;
	Mon, 27 May 2024 00:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716768280;
	bh=PcmYPBGo2XhGqyaercyt+IZ2k2DlEHd7kUXcc3kQ2Eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XPHIv4TUHywo6ZiY57edG8kmeD1+Rq26K8hDgEJMBVnMLGbM9vHo1Oy8CL+dTsGpY
	 mQi3lpj9L/726bC4JQz4oY48jQrnT+iM0YOR/2HpzfJd7W6XAaGEGAiMXMACo67O+L
	 GNzm3KMhZzmiWDLJNW5Gg0I8O0kjMSIdE0VNnU03cxndP5IqGF+0tc54/lM5e+q910
	 pVM/rise3d+5ZJpDNoYYZZiLQrL1UorcdoXt7grS4Mb/kRLrNxWYlnBrOsT9J533qJ
	 nTcaXRdGOy0UE84Xl/Kmq29Vp5v+Ohkq4WG8rJJwouDUZh5CeloxpfkGyYb6ekbATa
	 M20Pi0Yu92zfw==
Date: Mon, 27 May 2024 09:04:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 19/20] function_graph: Use for_each_set_bit() in
 __ftrace_return_to_handler()
Message-Id: <20240527090434.37e309d0280d6d8f116edc85@kernel.org>
In-Reply-To: <20240525023744.231570357@goodmis.org>
References: <20240525023652.903909489@goodmis.org>
	<20240525023744.231570357@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 22:37:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of iterating through the entire fgraph_array[] and seeing if one
> of the bitmap bits are set to know to call the array's retfunc() function,
> use for_each_set_bit() on the bitmap itself. This will only iterate for
> the number of set bits.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 4d503b3e45ad..5e8e13ffcfb6 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -827,11 +827,10 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
>  #endif
>  
>  	bitmap = get_bitmap_bits(current, offset);
> -	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
> +
> +	for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
>  		struct fgraph_ops *gops = fgraph_array[i];
>  
> -		if (!(bitmap & BIT(i)))
> -			continue;
>  		if (gops == &fgraph_stub)

Ah, nit: maybe this is unlikely()?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

