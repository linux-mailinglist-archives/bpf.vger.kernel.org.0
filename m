Return-Path: <bpf+bounces-16532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 585D0802099
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 05:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C48B20AD1
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 04:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D7EDC;
	Sun,  3 Dec 2023 04:15:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610381A;
	Sun,  3 Dec 2023 04:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E80C433C8;
	Sun,  3 Dec 2023 04:15:01 +0000 (UTC)
Date: Sat, 2 Dec 2023 23:15:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, JP Kobryn
 <inwardvessel@gmail.com>, ericvh@kernel.org, lucho@ionkov.net,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <20231202231524.4ce1d342@gandalf.local.home>
In-Reply-To: <ZWva7DYTPUG95xv8@codewreck.org>
References: <20231202030410.61047-1-inwardvessel@gmail.com>
	<ZWq0BvPGYMTi-WfC@codewreck.org>
	<1881630.VfuOzHrogK@silver>
	<20231202201409.10223677@rorschach.local.home>
	<ZWva7DYTPUG95xv8@codewreck.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Dec 2023 10:33:32 +0900
Dominique Martinet <asmadeus@codewreck.org> wrote:


> >             TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
> >                       (unsigned long)__entry->clnt, show_9p_op(__entry->type),
> >                       __entry->tag, 0, __get_dynamic_array(line), 16,
> > 		      __get_dynamic_array(line) + 16)  
> 
> This was just printing garbage in the previous version but %16ph with a
> dynamic alloc would be out of range (even the start of the next buffer,
> _get_dynamic_array(line) + 16, can be out of range)
> 
> Also, for custom tracepoints e.g. bpftrace the program needs to know how
> many bytes can be read safely even if it's just for dumping -- unless
> dynamic_array is a "fat pointer" that conveys its own size?
> (Sorry didn't take the time to check)

Yes, there's also a __get_dynamic_array_len(line) that will return the
allocated length of the line. Is that what you need?

-- Steve



