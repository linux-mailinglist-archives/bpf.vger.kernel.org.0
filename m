Return-Path: <bpf+bounces-16496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D5E801B1C
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 08:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E891C20B7A
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 07:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD45BE64;
	Sat,  2 Dec 2023 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="bUN1wjHO";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="uVp9Vc0/"
X-Original-To: bpf@vger.kernel.org
X-Greylist: delayed 9838 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 23:19:40 PST
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E898C1B2;
	Fri,  1 Dec 2023 23:19:40 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 7E84BC01F; Sat,  2 Dec 2023 08:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701501579; bh=uj47G2ezwiDNNC0q8ArJKjE+ShMruYh4/IQySt2Q1kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUN1wjHOSw5o0/eviawkv+AlSLeshOFFp3xAGtkACAOwmo7t1M0fMJhxN8e3x6d2K
	 na9JJegTD/QySIbJlXHXg6BBdnqdBTeXozwO3byK+2+i9gZUlqbOl44hsZEHzSkLCa
	 s4JCT5gLxtIikPOZ5kCYcaLrG9zTonkscSyAhGoDoFQ1KjCsxiBtAQWP2J9OJ785wk
	 E75gu8ENQ9jw9hWTmGlzEIeXfHkF4mXVKqTuJqXF+qBUxaTt6RAAfFk6n+ukCfu3SX
	 gwwTwIlAGPmo4WQrHEyqMVJIp5e5b9qPpmM6kRSXpC3v+C9xa+3+mVWVY0ycW3wlJq
	 U0X0sdH6YNldg==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 8F83FC009;
	Sat,  2 Dec 2023 08:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701501578; bh=uj47G2ezwiDNNC0q8ArJKjE+ShMruYh4/IQySt2Q1kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVp9Vc0/KRnvmopALf4G/0UPptouI1+n9IgRRlCjiQFAGQLv8nPyTNhRIsQsB2Oyp
	 bGvszI4hInYNjSjOYoaktMrurw6RhrCZUul44kbFra3LtAb1FZpPBL9doWLuc2WqJP
	 5H6oIqqd54rDAjJXJy5ix2xVqXC2vVHXGo3/u2fDhvjXFPpO2mgudjjXJ+nUz/4z23
	 NuCGmOpEUR5wO33WZjuNeVFXQ07zRWsDx8FB2nzJyxJDFOfdyhGW4T7mxoj+7z24xm
	 CrHJ3+u+OJqVk1SpPqSPGACMvlEyEoqwIFedua2m3u7lPjK8juhoyk9gbEH6Gwb4D7
	 oZpnbuqgLYvqA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 767761df;
	Sat, 2 Dec 2023 07:19:31 +0000 (UTC)
Date: Sat, 2 Dec 2023 16:19:16 +0900
From: asmadeus@codewreck.org
To: JP Kobryn <inwardvessel@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <ZWradOa-e1SM8MDZ@codewreck.org>
References: <20231202030410.61047-1-inwardvessel@gmail.com>
 <ZWq0BvPGYMTi-WfC@codewreck.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWq0BvPGYMTi-WfC@codewreck.org>

asmadeus@codewreck.org wrote on Sat, Dec 02, 2023 at 01:35:18PM +0900:
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

Building with W=1 yields a warning:
./include/linux/minmax.h:21:35: warning: comparison of distinct pointer types lacks a cast
...
./include/trace/events/9p.h:189:33: note: in expansion of macro ‘min’
  189 |                                 min(pdu->capacity, P9_PROTO_DUMP_SZ));

I've updated the patch to:
+				min_t(size_t, pdu->capacity, P9_PROTO_DUMP_SZ));

and pushed to my -next branch:
https://github.com/martinetd/linux/commits/9p-next

-- 
Dominique Martinet | Asmadeus

