Return-Path: <bpf+bounces-18666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACE81E30C
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 01:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6BA1F21E8B
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 00:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020881852;
	Tue, 26 Dec 2023 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGulxQ0a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400715CB;
	Tue, 26 Dec 2023 00:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ECEC433CA;
	Tue, 26 Dec 2023 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550029;
	bh=viWaVDgZggRIC+o1djZ9IF495Y7uvJgX50ROW6lgb8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EGulxQ0aRmTNruUx3GKzXeud8BJciXVftEVkUSyTpcOIM3yhzQuVhvCx5B9WS1ARx
	 bg41Z/eMW1yPZASeWOrhYDYnZTdeW044e9NidLVmOIAnzU5UhyMCIZKgYgrtedg6dc
	 2xDec3CDR5P8CE7J6UeZsWwU3Mtg+td3ATN0DqSmA0R9nWvUsETe5phgQXIL5Mul+L
	 EPrIfxggPTVih0FGqZPxlxbOthFTyJ+nbXCzfr1U2twCPPGyrbUqBRk+B0TSr7IrO3
	 9RNrFlvNi3Hm8nDBzg/XqV8g5GBnPKu3Wd9gM9Tb3mIexbcPpplmAQqhUe2gGD8mcY
	 yZtgOYUUuThaQ==
Date: Tue, 26 Dec 2023 09:20:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 11/34] function_graph: Have the instances use their
 own ftrace_ops for filtering
Message-Id: <20231226092023.2383d0d05c1120c094302685@kernel.org>
In-Reply-To: <170290522555.220107.1435543481968270637.stgit@devnote2>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
	<170290522555.220107.1435543481968270637.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 18 Dec 2023 22:13:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -408,15 +395,51 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  	return -EBUSY;
>  }
>  
> +/* This is called from ftrace_graph_func() via ftrace */
> +int function_graph_enter_ops(unsigned long ret, unsigned long func,
> +			     unsigned long frame_pointer, unsigned long *retp,
> +			     struct fgraph_ops *gops)
> +{
> +	struct ftrace_graph_ent trace;
> +	int index;
> +	int type;
> +

Here,  I found that this needs to check whether the fgraph_array[gops->idx]
is still valid or not. When unregistering the fgraph, fgraph_array[idx] is
cleared (with fgraph_stub) and disable ftrace. So there is a chance to hit
this and it will mess up the shadow stack because gops->idx is already invalid.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

