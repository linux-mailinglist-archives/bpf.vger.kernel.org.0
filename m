Return-Path: <bpf+bounces-16727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D3805336
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 12:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5BB1F214CE
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8345786F;
	Tue,  5 Dec 2023 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ipQCrbT6"
X-Original-To: bpf@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587979A;
	Tue,  5 Dec 2023 03:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=zwVfOTnPEwMgV+Q6MmlQtNUwKyYyS/fNwYtgjSme1Lg=; b=ipQCrbT6+r4M4gb9FBhdBPne78
	+9Befd+d/sTIdIwcuYCPdQNiDNa/t93zfRQHdj6mdyL/9Nz38bFxxsZ1kwuoqW+zTFnyacw0yDUMZ
	UgwcpQcYKUib7a35fJdtQTRkRtljJnkWtVfd3ZUMJLOBSgl1xl9E2Zg8f82RlCJiORmsLu3iFmFYZ
	Z78vXT0qoaX4z7y4Orn5eTQEszzfQBKgHyGgjU/ww9Tr+3jofAD6gDOYhXRSNTIzpyyNNHcRZHK/I
	/K4Gkfd9GL+1IYz6CzFxdMMgy/+rM93NDbRLH4vNOY/TezY8a9N9HYXDFCQmvAYxNBU9pRqfkrMEm
	794jlWl8me9VrvL93e3oGCc3a+hcp6eN3mr9DS9O1HxSc6X9ADYFtpQjhx73OmXCl6isgcZs/jmfJ
	a4xyk/ZfrE8EEhGwu+oeA7+VnF44hqWewQrnOzfH60RtHNcL3fmQTRI52BRxv8Hdn4uGhkX17IYPR
	9sVByoButV6zZe3NoKlJWk7G+gYtxuev0xROyNQM6czLB6iEjyJocVG/eSowlc8K1Ef0H0e674fV9
	ymCqhmNPl1npLw/xxBclISKhEVXv5lRislNBrw9s334umXEKETQw6mBhsR8ys17PYe04SkemZwDeY
	bJT7yzNPpAJgZ8CmGnzBTeVemzPWYz6V/C8DFskOo=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 JP Kobryn <inwardvessel@gmail.com>
Cc: v9fs@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] 9p: prevent read overrun in protocol dump tracepoint
Date: Tue, 05 Dec 2023 12:41:49 +0100
Message-ID: <8864880.fcQpaHM20G@silver>
In-Reply-To: <20231204202321.22730-1-inwardvessel@gmail.com>
References: <20231204202321.22730-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, December 4, 2023 9:23:20 PM CET JP Kobryn wrote:
> An out of bounds read can occur within the tracepoint 9p_protocol_dump. In
> the fast assign, there is a memcpy that uses a constant size of 32 (macro
> named P9_PROTO_DUMP_SZ). When the copy is invoked, the source buffer is not
> guaranteed match this size.  It was found that in some cases the source
> buffer size is less than 32, resulting in a read that overruns.
> 
> The size of the source buffer seems to be known at the time of the
> tracepoint being invoked. The allocations happen within p9_fcall_init(),
> where the capacity field is set to the allocated size of the payload
> buffer. This patch tries to fix the overrun by changing the fixed array to
> a dynamically sized array and using the minimum of the capacity value or
> P9_PROTO_DUMP_SZ as its length. The trace log statement is adjusted to
> account for this. Note that the trace log no longer splits the payload on
> the first 16 bytes. The full payload is now logged to a single line.
> 
> To repro the orignal problem, operations to a plan 9 managed resource can
> be used. The simplest approach might just be mounting a shared filesystem
> (between host and guest vm) using the plan 9 protocol while the tracepoint
> is enabled.
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

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  include/trace/events/9p.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/9p.h b/include/trace/events/9p.h
> index 4dfa6d7f83ba..cd104a1343e2 100644
> --- a/include/trace/events/9p.h
> +++ b/include/trace/events/9p.h
> @@ -178,18 +178,21 @@ TRACE_EVENT(9p_protocol_dump,
>  		    __field(	void *,		clnt				)
>  		    __field(	__u8,		type				)
>  		    __field(	__u16,		tag				)
> -		    __array(	unsigned char,	line,	P9_PROTO_DUMP_SZ	)
> +		    __dynamic_array(unsigned char, line,
> +				min_t(size_t, pdu->capacity, P9_PROTO_DUMP_SZ))
>  		    ),
>  
>  	    TP_fast_assign(
>  		    __entry->clnt   =  clnt;
>  		    __entry->type   =  pdu->id;
>  		    __entry->tag    =  pdu->tag;
> -		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
> +		    memcpy(__get_dynamic_array(line), pdu->sdata,
> +				__get_dynamic_array_len(line));
>  		    ),
> -	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
> +	    TP_printk("clnt %lu %s(tag = %d)\n%*ph\n",
>  		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),
> -		      __entry->tag, 0, __entry->line, 16, __entry->line + 16)
> +		      __entry->tag, __get_dynamic_array_len(line),
> +		      __get_dynamic_array(line))
>   );
>  
>  
> 



