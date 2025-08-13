Return-Path: <bpf+bounces-65588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 262F4B257E3
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 01:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645DC1BC7363
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05BE2FE075;
	Wed, 13 Aug 2025 23:53:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDED28B7F9;
	Wed, 13 Aug 2025 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129210; cv=none; b=YEKrb9DZzal8r2lAuv8U6KCZM0GQy2+jX3IzwoYYArdkND2v+5NFT12BTaYw4m/ItpN4lmN7+wp2yp9g/Gsnoo6cds1QOXea0OScTN3Rsdqu8MQaJl6frFUMelXvsfTEhLuZuOGXYoQ4FqwGBSWXRwluKH6+fKwaldX9LfEM9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129210; c=relaxed/simple;
	bh=wcUdQkTJ7IV/p3A7DgChTP1Bqgk5rMEVbafp6vUdmxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usuEJODFcbrR7QmLaaOqGUnVK1syUMRmZuIe96JJtBb5QMNPlinbxwynEs5wF1z/ueSDJc+LDkmayQwBXHNmcKm3OeDd9yLPXm/Ff/eRdXaYWi/FUxtAB/Qu6wnou9bHOA32954qGUOaAMMGkSIQMBTpaNypK4JJdJVDgwZcAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id D607916046F;
	Wed, 13 Aug 2025 23:53:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 9D5A820024;
	Wed, 13 Aug 2025 23:53:16 +0000 (UTC)
Date: Wed, 13 Aug 2025 19:53:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250813195317.508a29aa@batman.local.home>
In-Reply-To: <aJaxRVKverIjF4a6@lappy>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<aJaxRVKverIjF4a6@lappy>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uu7x1hrokrb99unu8dj1ujno5qjt5p8d
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 9D5A820024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+HPF6zc+Fq7HDozljgVIZFEoX/jina3WA=
X-HE-Tag: 1755129196-978234
X-HE-Meta: U2FsdGVkX1+00n9ZlSbYdfJM38C+mwzZfjjFjptzs2clG1ZBMsHK1gpngHaoGukdEeSJR/yFjzJ9/wvviAKnVIFFQwYwQd5jhjkTjkl3X5FpLGSJSOdUuIYkykSyIR/UAif3BSL3LBors0ThJxi+Ih++M1wT6ul9RDUAE6fisbj/eC1fX0IXuJpbcTXITov7helTIM0xnwo10MJ0lPIP6P8uQ9PW5HRiSJd9sc5AeS7zxaBX8G4Sr1bJ4EhulDD/VKKBOssRe5EsznGIHVOVjoSzsoWnPerSoWs0yCZXK5pfmxL4zf9Vyz1znmkJwOFPPVF8spncswberAUmDbIf+H91nLxqwiyx

On Fri, 8 Aug 2025 22:24:05 -0400
Sasha Levin <sashal@kernel.org> wrote:

> So we've added a dynamically sized array to the end of
> ftrace_graph_ent_entry, but in struct fgraph_data, the saved entry is
> defined as:
> 
>    struct fgraph_data {
>        ...
>        union {
>            struct ftrace_graph_ent_entry ent;
>            struct fgraph_retaddr_ent_entry rent;
>        } ent;
>        ...
>    }
> 
> Which doesn't seem to have room for args?

No it doesn't :-p

> 
> The code in get_return_for_leaf() does:
> 
>    data->ent.ent = *curr;
> 
> This copies the struct, but curr points to a larger entry with args
> data. The copy operation only copies sizeof(struct
> ftrace_graph_ent_entry) bytes, which doesn't include the dynamic args
> array.
> 
> And then later functions (like print_graph_entry()) would go ahead and
> assume that iter->ent_size is sane and make a mess out of everything.
> 
> I can't test right now whether this actually fixes the issues or not,
> but I wanted to bring this up as this looks somewhat odd and I'm not too
> familiar with this code.

Thanks for the detail analysis, can you test this patch?

-- Steve

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 66e1a527cf1a..25ea71edb8da 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -35,6 +35,11 @@ struct fgraph_data {
 		struct ftrace_graph_ent_entry	ent;
 		struct fgraph_retaddr_ent_entry	rent;
 	} ent;
+	/*
+	 * The @args must be right after @ent, as it is where they
+	 * are stored in case the function graph tracer has arguments.
+	 */
+	unsigned long			args[FTRACE_REGS_MAX_ARGS];
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
 	int				cpu;
@@ -623,14 +628,29 @@ get_return_for_leaf(struct trace_iterator *iter,
 		next = ring_buffer_event_data(event);
 
 		if (data) {
+			int args_size;
+			int size;
+
 			/*
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT))
+			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
 				data->ent.rent = *(struct fgraph_retaddr_ent_entry *)curr;
-			else
+				size = offsetof(struct fgraph_retaddr_ent_entry, args);
+			} else {
 				data->ent.ent = *curr;
+				size = offsetof(struct ftrace_graph_ent_entry, args);
+			}
+
+			/* If this has args, then append them to after the ent. */
+			args_size = iter->ent_size - size;
+			if (args_size > sizeof(long) * FTRACE_REGS_MAX_ARGS)
+				args_size = sizeof(long) * FTRACE_REGS_MAX_ARGS;
+
+			if (args_size >= sizeof(long))
+				memcpy((void *)&data->ent.ent + size,
+				       (void*)curr + size, args_size);
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can

