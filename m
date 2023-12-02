Return-Path: <bpf+bounces-16499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE2801D27
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 14:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ACB1C20927
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165451865D;
	Sat,  2 Dec 2023 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="VmJxgIZo"
X-Original-To: bpf@vger.kernel.org
X-Greylist: delayed 2539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Dec 2023 05:48:05 PST
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A42107;
	Sat,  2 Dec 2023 05:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=vrA/Bsu18m2ZIdNoKhXm9iuia2igasRXnU26BS1yMLQ=; b=VmJxgIZo3RvcJSB9PQVIeyXX0z
	6v0Y7/0qzTn5XFM1waGWXpe2MTjYmfhlBCQ+ETuA86F1xDHf2WHGyy5WiM3ZVw2OP94w6/PsHK6yH
	v0y1E6BsJxhA3DuRqbw2Py81WlDygFp1OlacSPL+5GewB4r98+EUQiKFFABLHV+ZY7hRU2mZiQ+eb
	F9Yg2drrwWzCjT1oM2nogxi+yfhObS/43JYgU/aNT2bq5ghtXNZpdspSxZOllLCYTXQqXMDpAHa95
	bGBa6HB+EjUeI7n9sIKAnzXB+G90+3Z5suUmVBsglW3csewUK74/GC0pEl61sPwfT/2CYYbZp9ACl
	1UKZWrgefXpMcmZptV0tICoDtXII0J7BW7TfPE5hbxRHljbu7dNeRWQHtl8tYHHRW3FClhXcJO4As
	r/w1Ge2eHlXPhpMYKUpwTUa4+ALE3B7/TPKL5BnBBEqBMK7s7LdlJ+AJkiPQDuk00vdQIVMcBe9os
	Dy3zqWQoyOmA60smpvBl4DIKAfT1ghEihPXzQgW/gEr6kUXL1HSkTWOGBYHP1pBMNpbW7KO+OCVtD
	K19KWSAy3uq6izJUK00PEQu4u2U4l84bD1emFjho603PUVkGCyGASYVSQuF14wGJHs6O9Cy5YKfwa
	yzU0Uu1E5zTl9FzOp1+wRCEK1BcU++YxJg8ni3YvE=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: JP Kobryn <inwardvessel@gmail.com>, asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Date: Sat, 02 Dec 2023 14:05:24 +0100
Message-ID: <1881630.VfuOzHrogK@silver>
In-Reply-To: <ZWq0BvPGYMTi-WfC@codewreck.org>
References:
 <20231202030410.61047-1-inwardvessel@gmail.com>
 <ZWq0BvPGYMTi-WfC@codewreck.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, December 2, 2023 5:35:18 AM CET asmadeus@codewreck.org wrote:
> JP Kobryn wrote on Fri, Dec 01, 2023 at 07:04:10PM -0800:
> > An out of bounds read can occur within the tracepoint 9p_protocol_dump().
> > In the fast assign, there is a memcpy that uses a constant size of 32
> > (macro definition as P9_PROTO_DUMP_SZ). When the copy is invoked, the
> > source buffer is not guaranteed match this size. It was found that in some
> > cases the source buffer size is less than 32, resulting in a read that
> > overruns.
> > 
> > The size of the source buffer seems to be known at the time of the
> > tracepoint being invoked. The allocations happen within p9_fcall_init(),
> > where the capacity field is set to the allocated size of the payload
> > buffer. This patch tries to fix the overrun by using the minimum of that
> > field (size of source buffer) and the size of destination buffer when
> > performing the copy.
> 
> Good catch; this is a regression due to a semi-recent optimization in
> commit 60ece0833b6c ("net/9p: allocate appropriate reduced message
> buffers")

Indeed, didn't have this one on screen! Thanks!

> For some reason I thought we rounded up small messages alloc to 4k but
> I've just confirmed we don't, so these overruns are quite frequent.
> I'll add the fixes tag and cc to stable if there's no other comment.

Yeah, in p9_msg_buf_size() [net/9p/protocol.c] the smallest allocation size
for message types known to be small (at compile-time) is hard coded to 4k.

However for all variable-size message types the size is calculated at runtime
exactly as needed for that particular message being sent. So these 9p message
types can trigger this case (<32). They are currently never rounded up.

[...]
> > diff --git a/include/trace/events/9p.h b/include/trace/events/9p.h
> > index 4dfa6d7f83ba..8690a7086252 100644
> > --- a/include/trace/events/9p.h
> > +++ b/include/trace/events/9p.h
> > @@ -185,7 +185,8 @@ TRACE_EVENT(9p_protocol_dump,
> >  		    __entry->clnt   =  clnt;
> >  		    __entry->type   =  pdu->id;
> >  		    __entry->tag    =  pdu->tag;
> > -		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
> > +		    memcpy(__entry->line, pdu->sdata,
> > +				min(pdu->capacity, P9_PROTO_DUMP_SZ));
> >  		    ),
> >  	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
> >  		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),

AFAICS __entry is a local variable on stack, and array __entry->line not
intialized with zeros, i.e. the dump would contain trash at the end. Maybe
prepending memset() before memcpy()?

/Christian



