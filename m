Return-Path: <bpf+bounces-16494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C4801AB3
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 05:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3805281565
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1846A4;
	Sat,  2 Dec 2023 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="BGBZrvSG";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jheFlFzO"
X-Original-To: bpf@vger.kernel.org
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6871B1A8;
	Fri,  1 Dec 2023 20:35:44 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id D506FC021; Sat,  2 Dec 2023 05:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701491740; bh=EHtuY+ZTQozc/pAxW1sLN8rUDRz7/Fs/l38w+xtirgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGBZrvSGPoBSb+7CEuliH0XuPPca4bYOvO/7Y9xCh71Vs1L1EG4pJwy6Bctt6xMwL
	 td5rxZBBMq/pd5bfodfOJK3I0he2PRM/zU+OeIW6iBYuzJBa+qaN2J08RMZ5YgNJdv
	 WKhvMYFTvvq1AvqibeV/0I6jiReVYlIzY2ppwHIc/l1Es0AipYzTZJP11tj8TLAO/4
	 Wf5kA6k6v0mTmFHuGVsDE0ZLeV2wNgatF7zfrt4/9xLu9Vf71PhMRRhQrY8NQLy2Q3
	 KGzf0qkoeVhgGrrBjaOTgo879toGjlfiX+Yh/5b4lU9+uZhC6W57nzv2Dte7yTnl3Z
	 ljqBZwzJtJyFA==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id B4D1CC009;
	Sat,  2 Dec 2023 05:35:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701491739; bh=EHtuY+ZTQozc/pAxW1sLN8rUDRz7/Fs/l38w+xtirgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jheFlFzOb3OcVyhkYRH7zb3WFZij7taRROQrfocw0Apx3F68tOpey6Fu6adJmYI/N
	 jli+PjVcJosvb7bXdKYufhjI1VF9Bf1aj3Hne3KSru4mGdaSrzHvsHD5zO1Qp6Hgxb
	 nAASEEFzGHMEKbJYOOP1gYLET5uAF5LbNonwyFonDL79Y3CtH/LKctlKpSdFipd40F
	 W+9ABwq6il30TLZsZVkM7BbvgxE+sTApxs/H1XH6yjQhuo61lqpxuDYRUiwYHjgmpQ
	 mWP1m3z8p3gk8YeZJOIiO+4dd/orKgQgLlmguPw5jAwPnNdIz0Oq6xrCVulENFnIL2
	 wpowXciMxBLhA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 784fdc4a;
	Sat, 2 Dec 2023 04:35:33 +0000 (UTC)
Date: Sat, 2 Dec 2023 13:35:18 +0900
From: asmadeus@codewreck.org
To: JP Kobryn <inwardvessel@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <ZWq0BvPGYMTi-WfC@codewreck.org>
References: <20231202030410.61047-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202030410.61047-1-inwardvessel@gmail.com>

JP Kobryn wrote on Fri, Dec 01, 2023 at 07:04:10PM -0800:
> An out of bounds read can occur within the tracepoint 9p_protocol_dump().
> In the fast assign, there is a memcpy that uses a constant size of 32
> (macro definition as P9_PROTO_DUMP_SZ). When the copy is invoked, the
> source buffer is not guaranteed match this size. It was found that in some
> cases the source buffer size is less than 32, resulting in a read that
> overruns.
> 
> The size of the source buffer seems to be known at the time of the
> tracepoint being invoked. The allocations happen within p9_fcall_init(),
> where the capacity field is set to the allocated size of the payload
> buffer. This patch tries to fix the overrun by using the minimum of that
> field (size of source buffer) and the size of destination buffer when
> performing the copy.

Good catch; this is a regression due to a semi-recent optimization in
commit 60ece0833b6c ("net/9p: allocate appropriate reduced message
buffers")
For some reason I thought we rounded up small messages alloc to 4k but
I've just confirmed we don't, so these overruns are quite frequent.
I'll add the fixes tag and cc to stable if there's no other comment.

Thanks!

> 
> A repro can be performed by different ways. The simplest might just be
> mounting a shared filesystem (between host and guest vm) using the plan
> 9 protocol while the tracepoint is enabled.
> 
> mount -t 9p -o trans=virtio <mount_tag> <mount_path>
> 
> The bpftrace program below can be used to show the out of bounds read.
> Note that a recent version of bpftrace is needed for the raw tracepoint
> support. The script was tested using v0.19.0.
> 
> /* from include/net/9p/9p.h */
> struct p9_fcall {
>     u32 size;
>     u8 id;
>     u16 tag;
>     size_t offset;
>     size_t capacity;
>     struct kmem_cache *cache;
>     u8 *sdata;
>     bool zc;
> };
> 
> tracepoint:9p:9p_protocol_dump
> {
>     /* out of bounds read can happen when this tracepoint is enabled */
> }
> 
> rawtracepoint:9p_protocol_dump
> {
>     $pdu = (struct p9_fcall *)arg1;
>     $dump_sz = (uint64)32;
> 
>     if ($dump_sz > $pdu->capacity) {
>         printf("reading %zu bytes from src buffer of %zu bytes\n",
>             $dump_sz, $pdu->capacity);
>     }
> }
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  include/trace/events/9p.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/9p.h b/include/trace/events/9p.h
> index 4dfa6d7f83ba..8690a7086252 100644
> --- a/include/trace/events/9p.h
> +++ b/include/trace/events/9p.h
> @@ -185,7 +185,8 @@ TRACE_EVENT(9p_protocol_dump,
>  		    __entry->clnt   =  clnt;
>  		    __entry->type   =  pdu->id;
>  		    __entry->tag    =  pdu->tag;
> -		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
> +		    memcpy(__entry->line, pdu->sdata,
> +				min(pdu->capacity, P9_PROTO_DUMP_SZ));
>  		    ),
>  	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
>  		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),

-- 
Dominique Martinet | Asmadeus

