Return-Path: <bpf+bounces-16529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE3802028
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 02:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6CC280FE6
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 01:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BC64F;
	Sun,  3 Dec 2023 01:14:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B17635;
	Sun,  3 Dec 2023 01:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842D9C433C7;
	Sun,  3 Dec 2023 01:14:12 +0000 (UTC)
Date: Sat, 2 Dec 2023 20:14:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, asmadeus@codewreck.org,
 ericvh@kernel.org, lucho@ionkov.net, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <20231202201409.10223677@rorschach.local.home>
In-Reply-To: <1881630.VfuOzHrogK@silver>
References: <20231202030410.61047-1-inwardvessel@gmail.com>
	<ZWq0BvPGYMTi-WfC@codewreck.org>
	<1881630.VfuOzHrogK@silver>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 02 Dec 2023 14:05:24 +0100
Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> > > --- a/include/trace/events/9p.h
> > > +++ b/include/trace/events/9p.h
> > > @@ -185,7 +185,8 @@ TRACE_EVENT(9p_protocol_dump,
> > >  		    __entry->clnt   =  clnt;
> > >  		    __entry->type   =  pdu->id;
> > >  		    __entry->tag    =  pdu->tag;
> > > -		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
> > > +		    memcpy(__entry->line, pdu->sdata,
> > > +				min(pdu->capacity, P9_PROTO_DUMP_SZ));
> > >  		    ),
> > >  	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
> > >  		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),  
> 
> AFAICS __entry is a local variable on stack, and array __entry->line not
> intialized with zeros, i.e. the dump would contain trash at the end. Maybe
> prepending memset() before memcpy()?

__entry is a macro that points into the ring buffer that gets allocated
before this is called. TRACE_EVENT() has a __dynamic_array() field that
can handle variable length arrays. What you can do is turn this into
something like:

TRACE_EVENT(9p_protocol_dump,
            TP_PROTO(struct p9_client *clnt, struct p9_fcall *pdu),

            TP_ARGS(clnt, pdu),

            TP_STRUCT__entry(
                    __field(    void *,         clnt                            )
                    __field(    __u8,           type                            )
                    __field(    __u16,          tag                             )
                    __dynamic_array(unsigned char,  line, min(pdu->capacity, P9_PROTO_DUMP_SZ) )
                    ),

            TP_fast_assign(
                    __entry->clnt   =  clnt;
                    __entry->type   =  pdu->id;
                    __entry->tag    =  pdu->tag;
                    memcpy(__get_dynamic_array(line), pdu->sdata,
			   min(pdu->capacity, P9_PROTO_DUMP_SZ));
                    ),
            TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
                      (unsigned long)__entry->clnt, show_9p_op(__entry->type),
                      __entry->tag, 0, __get_dynamic_array(line), 16,
		      __get_dynamic_array(line) + 16)
 );

-- Steve

