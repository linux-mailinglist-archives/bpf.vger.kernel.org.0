Return-Path: <bpf+bounces-16530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5441802047
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 02:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C425280ED5
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD9E65A;
	Sun,  3 Dec 2023 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="dF+iWg1W";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="2J/MlFY1"
X-Original-To: bpf@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E55FB;
	Sat,  2 Dec 2023 17:33:55 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 924ACC01F; Sun,  3 Dec 2023 02:33:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701567234; bh=ECgSr30p8KK6xp1lQByvmsYjnpt14zgJu5/41PhPXB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dF+iWg1WlOt6+enLiLI3H4Qjsnshsqw7Q4XHjtf8E4pf+4m/XEnzfoZeCwNK4Bz65
	 XGYGjtwkJFvjrsurRwBHt+URQMVGv+sFnCsFWzfR9onuEanSgKyWKzijjHtn1e152y
	 u8TJPZXUf3i/Y7Wcx2EFCd+LfDPBnJvzRmx8BNw655DCZHGVZmgw3sJeJnntwJzME9
	 nN9YIPycEBihrfy2dIlINKvFD1894Az0labxEjp/o9KjoVr+gZb4hqQHi7E31wdOk3
	 dLMZ20DeUXRGr5nHb21dPEkItEKiSGQ9NYwlD5//0A6AS0LipMzoqza8PVKRSH6jbp
	 W0JCk1AnxcaAQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 7EF83C009;
	Sun,  3 Dec 2023 02:33:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701567233; bh=ECgSr30p8KK6xp1lQByvmsYjnpt14zgJu5/41PhPXB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2J/MlFY1zZTnaaeAiYHSQsIo249YUO3MmgdVkDwLdulVpdfdFI0ywkI+GqG3rd4ba
	 qIH3qFFVFFPtrFLjCPPdDwrDUgUyvvumyCDczCH5aBsCtzBLJ3vU8xW7x+QRo2AMqv
	 8pn7ELCiGo4YlElD2fpB350hVp6HltGNixDH1fnOdMzJpXCsl4djnAlHWZCqs8K8EK
	 +SRBk2L8LnzS+XTOWDo32VihIdExN0KSs54Hx6fOlyVGrOGVGxp+sokz8P8sHs7vpm
	 TGsQ+bEkYjrFDDIrZeiHvcmsMazZO76iR2tYu89nz8gnjdZ4z7Atefty0QTcF272Ix
	 feF+FKr4Qh6ZA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 575af7a3;
	Sun, 3 Dec 2023 01:33:47 +0000 (UTC)
Date: Sun, 3 Dec 2023 10:33:32 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	JP Kobryn <inwardvessel@gmail.com>, ericvh@kernel.org,
	lucho@ionkov.net, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <ZWva7DYTPUG95xv8@codewreck.org>
References: <20231202030410.61047-1-inwardvessel@gmail.com>
 <ZWq0BvPGYMTi-WfC@codewreck.org>
 <1881630.VfuOzHrogK@silver>
 <20231202201409.10223677@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202201409.10223677@rorschach.local.home>

Steven Rostedt wrote on Sat, Dec 02, 2023 at 08:14:09PM -0500:
> > AFAICS __entry is a local variable on stack, and array __entry->line not
> > intialized with zeros, i.e. the dump would contain trash at the end. Maybe
> > prepending memset() before memcpy()?

Well spotted!
Now I'm thinking about it we weren't initializing the source buffer
either back when we had (>32) msize allocations, so these already had
been printing garbage, but might as well get this sorted out while we're
here.

> __entry is a macro that points into the ring buffer that gets allocated
> before this is called. TRACE_EVENT() has a __dynamic_array() field that
> can handle variable length arrays. What you can do is turn this into
> something like:
> 
> TRACE_EVENT(9p_protocol_dump,
>             TP_PROTO(struct p9_client *clnt, struct p9_fcall *pdu),
> 
>             TP_ARGS(clnt, pdu),
> 
>             TP_STRUCT__entry(
>                     __field(    void *,         clnt                            )
>                     __field(    __u8,           type                            )
>                     __field(    __u16,          tag                             )
>                     __dynamic_array(unsigned char,  line, min(pdu->capacity, P9_PROTO_DUMP_SZ) )
>                     ),
> 
>             TP_fast_assign(
>                     __entry->clnt   =  clnt;
>                     __entry->type   =  pdu->id;
>                     __entry->tag    =  pdu->tag;
>                     memcpy(__get_dynamic_array(line), pdu->sdata,
> 			   min(pdu->capacity, P9_PROTO_DUMP_SZ));
>                     ),
>             TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
>                       (unsigned long)__entry->clnt, show_9p_op(__entry->type),
>                       __entry->tag, 0, __get_dynamic_array(line), 16,
> 		      __get_dynamic_array(line) + 16)

This was just printing garbage in the previous version but %16ph with a
dynamic alloc would be out of range (even the start of the next buffer,
_get_dynamic_array(line) + 16, can be out of range)

Also, for custom tracepoints e.g. bpftrace the program needs to know how
many bytes can be read safely even if it's just for dumping -- unless
dynamic_array is a "fat pointer" that conveys its own size?
(Sorry didn't take the time to check)

So I see two ways forward:
 - We can give up on the 16 bytes split here, add the size in one of the
fields, and print with %*ph using that size.
 - Or just give up and zero the tail; I'm surprised there's no "memcpy
up to x bytes and zero up to y bytes if required" helper but Christian's
suggestion of always doing memset first is probably not that bad
performance-wise if someone's dumping these out already.

I don't have a hard preference here, what do you think?
-- 
Dominique Martinet | Asmadeus

