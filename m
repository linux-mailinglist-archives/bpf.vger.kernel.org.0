Return-Path: <bpf+bounces-6568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8677F76B7DA
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62111C2105F
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910C94DC65;
	Tue,  1 Aug 2023 14:41:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499E815
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:41:37 +0000 (UTC)
Received: from out-96.mta0.migadu.com (out-96.mta0.migadu.com [IPv6:2001:41d0:1004:224b::60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367D39C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:41:36 -0700 (PDT)
Message-ID: <c643db9c-c9fb-9e8d-f35c-e5c9316f657d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690900894; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4lu9rl80wnpynbxYMmCvM9Rbb29PtC/a1L2v3oqVO0=;
	b=qVaXNcLloEZwQ2po8bFkXfXrg349uHQUgN8d/XBrekpVlt+0SSC30kHjxtrIdeMT1gDnTR
	CkVGzp5+BONOjUUfdt7ukfJMwMQ35o+ByfUy8Mhv0SsUFyiBPNK7tP+0UdeW2t38BnZefB
	8Gck6qbJnSiJKaq139e4ecgImIX7OUo=
Date: Tue, 1 Aug 2023 07:41:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH] [v5] bpf: fix bpf_probe_read_kernel prototype mismatch
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Dave Marchevsky <davemarchevsky@fb.com>, David Vernet <void@manifault.com>,
 Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230801111449.185301-1-arnd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801111449.185301-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 4:13 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bpf_probe_read_kernel() has a __weak definition in core.c and another
> definition with an incompatible prototype in kernel/trace/bpf_trace.c,
> when CONFIG_BPF_EVENTS is enabled.
> 
> Since the two are incompatible, there cannot be a shared declaration in
> a header file, but the lack of a prototype causes a W=1 warning:
> 
> kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]
> 
> On 32-bit architectures, the local prototype
> 
> u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
> 
> passes arguments in other registers as the one in bpf_trace.c
> 
> BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
>              const void *, unsafe_ptr)
> 
> which uses 64-bit arguments in pairs of registers.
> 
> As both versions of the function are fairly simple and only really
> differ in one line, just move them into a header file as an inline
> function that does not add any overhead for the bpf_trace.c callers
> and actually avoids a function call for the other one.
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/ac25cb0f-b804-1649-3afb-1dc6138c2716@iogearbox.net/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

