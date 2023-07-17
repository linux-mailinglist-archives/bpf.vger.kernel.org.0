Return-Path: <bpf+bounces-5146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A57570AC
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 01:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E38A1C20BDB
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C18C134C3;
	Mon, 17 Jul 2023 23:51:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A152C2C2
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 23:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753CAC433C7;
	Mon, 17 Jul 2023 23:51:31 +0000 (UTC)
Date: Mon, 17 Jul 2023 19:51:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Martin
 KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-ID: <20230717195129.14759151@gandalf.local.home>
In-Reply-To: <20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
	<168960741686.34107.6330273416064011062.stgit@devnote2>
	<20230717143914.5399a8e4@gandalf.local.home>
	<20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 08:46:34 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > + * Get function parameter with the number of parameters.
> > > + * This can return NULL if the function has no parameters.  
> > 
> >   " It can return EINVAL if this function's parameters are NULL."  
> 
> No, as you can see the code, if btf_type_vlen(func_proto) returns 0 (means
> the function proto type has no parameters), btf_get_func_param() returns
> NULL. This is important point because user needs to use IS_ERR_OR_NULL(ret)
> instead of IS_ERR(ret).

I didn't mean to replace what you had, I meant you left that part out. In
other words, you have to check for IS_ERR_OR_NULL(ret), not just "!ret".

-- Steve

> >   
> > > + */
> > > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> > > +{
> > > +	if (!func_proto || !nr)
> > > +		return ERR_PTR(-EINVAL);
> > > +

