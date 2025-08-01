Return-Path: <bpf+bounces-64923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D4B187F3
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4210AA6492
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241E1F4CBF;
	Fri,  1 Aug 2025 20:05:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3353DF71;
	Fri,  1 Aug 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078737; cv=none; b=l9DlDdXOUA5O+mN+nnHl/oyqsbbg6J2aDVVPzNZqxmetv/CDkKNnhLuQd/pkFKh34fjS16HZatSfG0CwLZqv0X6uNSLaAzESMMNhMeTBMdyt91Yy4oVULnSSPV1aEMThTa8cMbvV0EiSOEH+YSdB6O32NbShToALCah7NKUwnJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078737; c=relaxed/simple;
	bh=0kNVcx1VOUv7ma6BGFzQ0e+ndJcrC3qhn0pqnVKxK1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0J0qgJvAx+wDs+ZAodEp39OpeCePZCpGDOA2+1w7J+QBip+fRFNhhyxSu2Uca9gnVFOaJ6z96jY4K9iYz6urYnKbQYq2znMrqU/VAF+4Sk6AZgBmdtgWhVTZUMEhs29SMODI9y22ikBdpBshg/zqM85bgIkuXO7YIsFFKqQzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6C50457A6E;
	Fri,  1 Aug 2025 20:05:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 14E9560011;
	Fri,  1 Aug 2025 20:05:25 +0000 (UTC)
Date: Fri, 1 Aug 2025 16:05:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org, Douglas Raillard
 <douglas.raillard@arm.com>, LKML <linux-kernel@vger.kernel.org>, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Have unsigned int function args displayed as
 hexadecimal
Message-ID: <20250801160546.5629ef38@gandalf.local.home>
In-Reply-To: <604028fc-0a41-4323-b72a-7c61e069ef3c@linux.dev>
References: <20250731193126.2eeb21c6@gandalf.local.home>
	<604028fc-0a41-4323-b72a-7c61e069ef3c@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rqemqgur6z5ztmdob5w8z8secqe5e4p3
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 14E9560011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/2UbX+s8SdPCnXsMKqIMaYQY4gha3HBdE=
X-HE-Tag: 1754078725-163223
X-HE-Meta: U2FsdGVkX1+1qAEot2Q1E6hDn9C+BHctmRAldP59RlDKBbVclKjRhP9AfQJa7N60ihslZEc+dpHC6gQU1CNILKPWD5nJtLEf/0XOpAls1HnG5Um899b9zMklq81Q+ToK+/TdxPjCU79x/qNsuDVyNFNd8+O8lIv0y6i9HwwW8UScONSbtVvuGu5xGUGnCX24ievzH27CXW2RGDDdiwT057obijnpCrgGd2AtKBK/eJBYRQjNHP/RRoN+xSK8DqPOua186QbngNcxMNelf/1EXQWK5+OlJHypuuprgRUcCJEq7+bBTP7HalrRchxcevfb

On Fri, 1 Aug 2025 12:59:05 -0700
Martin KaFai Lau <martin.lau@linux.dev> wrote:

> On 7/31/25 4:31 PM, Steven Rostedt wrote:
> > +			int_data = btf_type_int(t);
> > +                        encode = BTF_INT_ENCODING(int_data);  
> 
> There is a btf_int_encoding(t) helper in btf.h, so only "encode = 
> btf_int_encoding(t);" will be simpler.

Thanks, I didn't see that. I was looking at the code in btf.c which had
this open coded.

-- Steve

