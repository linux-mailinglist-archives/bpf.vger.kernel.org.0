Return-Path: <bpf+bounces-48256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392AA05FF0
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 16:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE0F18886BF
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327051FE451;
	Wed,  8 Jan 2025 15:23:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488719F133;
	Wed,  8 Jan 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349794; cv=none; b=bMuKMyZbuMK6BcXEPdFTaEjSfgN0s3uHbjrAbTDoOnUpxkzcxlqUy9YKK+/ulb+ozNnZXHJV08rauM4VjOU5z44me2OL620TywuThcy8P/S/vY46gXjVatDkvyA9NRT/6SzXTAjZ55+V7Nmvoxok6rNTzN8MJHKWDelWb+l5lOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349794; c=relaxed/simple;
	bh=TyRrmQgxzQK/2vkObaTIrS0YJV7Wp8WpknOHDtGHQ94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srZ7WbfWjwSHumQyyNXtl0R7ULVwwJTq1WD/LapdOc/QlM+ecr7eH4GWQMIj+bM5j0jvc8DJFU6oFFWBkqyL2iJN8ol/UmbwitB3i7XAx1noMBx1EIgXdmhZY+r3wvU+IWCEJhXr68SdEPJxdJwmvpM4xc5ESaybJP5I9+ZazJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBC0C4CED3;
	Wed,  8 Jan 2025 15:23:12 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:24:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Donglin Peng
 <dolinux.peng@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Zheng
 Yejian <zhengyejian@huaweicloud.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ftrace: Add print_function_args()
Message-ID: <20250108102443.415495e1@gandalf.local.home>
In-Reply-To: <41a44111-fa49-460a-afa3-2bad7758c60e@oracle.com>
References: <20241223201347.609298489@goodmis.org>
	<20241223201541.898496620@goodmis.org>
	<CAErzpms4g8=3486Uv-PPxiA0GSkNQQm1Ez67eo-H3LtAhTAJCA@mail.gmail.com>
	<20250108135217.9db8d131835acfb6ce4baa88@kernel.org>
	<41a44111-fa49-460a-afa3-2bad7758c60e@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 11:19:11 +0000
Alan Maguire <alan.maguire@oracle.com> wrote:

> >>> +       trace_seq_printf(s, "(");
> >>> +
> >>> +       if (!args)
> >>> +               goto out;
> >>> +       if (lookup_symbol_name(func, name))
> >>> +               goto out;
> >>> +
> >>> +       btf = bpf_get_btf_vmlinux();
> >>> +       if (IS_ERR_OR_NULL(btf))
> >>> +               goto out;  
> >>
> >>
> >> There is no need to the retrieve the BTF of vmlinux, as btf_find_func_proto
> >> will return the correct BTF via its second parameter.  
> > 
> > Good catch! The second parameter of btf_find_func_proto() is output.
> >  
> 
> One thought here - with btf_find_func_proto(), we will try kernel BTF
> and then proceed to module BTF, iterating over all modules to find the
> function prototype. So where we are tracing module functions this could
> get expensive if such a function is frequently encountered, and it also
> opens up the risk that we end up using the wrong function prototype from
> the wrong module that just happens to match on function name.
> 
> So I wonder if we could use the function address to do a more guided
> lookup. Perhaps we could use kallsyms_lookup(), retrieving the
> (potential) module name. Then maybe modify the signature of
> btf_find_func_proto() to take an optional module name parameter to avoid
> iteration? None of this is strictly needed, but it may speed things up a
> bit and give us more accurate parameter info for those few cases with
> name clashes, so could be done as a follow-up if needed. Thanks!

Well, every place this is called, we first get the function name from
kallsyms. Perhaps I can modify the code to get the module name as well, and
if it exists, we can pass that too?

-- Steve

