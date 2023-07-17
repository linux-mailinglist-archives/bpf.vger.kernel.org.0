Return-Path: <bpf+bounces-5145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE17570A4
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 01:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF16E1C20BF7
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94508134BD;
	Mon, 17 Jul 2023 23:46:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A212B66
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 23:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F048C433C7;
	Mon, 17 Jul 2023 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689637598;
	bh=REIKK+GYTqurzTzbZxP05tzFxdn6X/x0balz5jGPgPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fJCnQBhmxmIQUzEYcTjYMxHrWY0iPO5UB7ZBb0oM2hWvK370DNSbOpznYz8GqCbAr
	 /zSw9h2iJMphVpWH6ILSBBTbhPO85ardV+Fl4HtAv3uZtH7aVhZXU+7tB8nX2RkTK8
	 ipr031XuxYUFjermtn1Fa2zwbNgKwimrgaFK/K8T2kqI5PFBA0H0QV5/jhT/aGzvj0
	 t7fDAJbdqXwpy1Ije0PudcXP8r+1zxwhXzQPbOqhOZ4DB0L/U0M8RGbEzJ7XGNr1c+
	 9vxWzWaIDw5EeB3k/KyTz71ZuafX3Oy04m6MgMH5TWmo00/UVVLwwZY3cQrD7FaT70
	 lmNymzHn21gAw==
Date: Tue, 18 Jul 2023 08:46:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Martin
 KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
In-Reply-To: <20230717143914.5399a8e4@gandalf.local.home>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
	<168960741686.34107.6330273416064011062.stgit@devnote2>
	<20230717143914.5399a8e4@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 14:39:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 18 Jul 2023 00:23:37 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Move generic function-proto find API and getting function parameter API
> > to BTF library code from trace_probe.c. This will avoid redundant efforts
> > on different feature.
> 
>  "different features."

Thanks!

> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  include/linux/btf.h        |    4 ++++
> >  kernel/bpf/btf.c           |   45 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_probe.c |   50 +++++++++++++-------------------------------
> >  3 files changed, 64 insertions(+), 35 deletions(-)
> > 
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index cac9f304e27a..98fbbcdd72ec 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -221,6 +221,10 @@ const struct btf_type *
> >  btf_resolve_size(const struct btf *btf, const struct btf_type *type,
> >  		 u32 *type_size);
> >  const char *btf_type_str(const struct btf_type *t);
> > +const struct btf_type *btf_find_func_proto(struct btf *btf,
> > +					   const char *func_name);
> > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> > +					   s32 *nr);
> >  
> >  #define for_each_member(i, struct_type, member)			\
> >  	for (i = 0, member = btf_type_member(struct_type);	\
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 817204d53372..e015b52956cb 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1947,6 +1947,51 @@ btf_resolve_size(const struct btf *btf, const struct btf_type *type,
> >  	return __btf_resolve_size(btf, type, type_size, NULL, NULL, NULL, NULL);
> >  }
> >  
> > +/*
> > + * Find a functio proto type by name, and return it.
> 
>   "function"

Oops.

> 
> > + * Return NULL if not found, or return -EINVAL if parameter is invalid.
> > + */
> > +const struct btf_type *btf_find_func_proto(struct btf *btf, const char *func_name)
> > +{
> > +	const struct btf_type *t;
> > +	s32 id;
> > +
> > +	if (!btf || !func_name)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	id = btf_find_by_name_kind(btf, func_name, BTF_KIND_FUNC);
> > +	if (id <= 0)
> > +		return NULL;
> > +
> > +	/* Get BTF_KIND_FUNC type */
> > +	t = btf_type_by_id(btf, id);
> > +	if (!t || !btf_type_is_func(t))
> > +		return NULL;
> > +
> > +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> > +	t = btf_type_by_id(btf, t->type);
> > +	if (!t || !btf_type_is_func_proto(t))
> > +		return NULL;
> > +
> > +	return t;
> > +}
> > +
> > +/*
> > + * Get function parameter with the number of parameters.
> > + * This can return NULL if the function has no parameters.
> 
>   " It can return EINVAL if this function's parameters are NULL."

No, as you can see the code, if btf_type_vlen(func_proto) returns 0 (means
the function proto type has no parameters), btf_get_func_param() returns
NULL. This is important point because user needs to use IS_ERR_OR_NULL(ret)
instead of IS_ERR(ret).

Thank you,

> 
> -- Steve
> 
> 
> > + */
> > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> > +{
> > +	if (!func_proto || !nr)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	*nr = btf_type_vlen(func_proto);
> > +	if (*nr > 0)
> > +		return (const struct btf_param *)(func_proto + 1);
> > +	else
> > +		return NULL;
> > +}
> > +
> >  static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
> >  {
> >  	while (type_id < btf->start_id)
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index c68a72707852..cd89fc1ebb42 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -371,47 +371,23 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
> >  	return NULL;
> >  }
> >  
> > -static const struct btf_type *find_btf_func_proto(const char *funcname)
> > -{
> > -	struct btf *btf = traceprobe_get_btf();
> > -	const struct btf_type *t;
> > -	s32 id;
> > -
> > -	if (!btf || !funcname)
> > -		return ERR_PTR(-EINVAL);
> > -
> > -	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> > -	if (id <= 0)
> > -		return ERR_PTR(-ENOENT);
> > -
> > -	/* Get BTF_KIND_FUNC type */
> > -	t = btf_type_by_id(btf, id);
> > -	if (!t || !btf_type_is_func(t))
> > -		return ERR_PTR(-ENOENT);
> > -
> > -	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> > -	t = btf_type_by_id(btf, t->type);
> > -	if (!t || !btf_type_is_func_proto(t))
> > -		return ERR_PTR(-ENOENT);
> > -
> > -	return t;
> > -}
> > -
> >  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> >  						   bool tracepoint)
> >  {
> > +	struct btf *btf = traceprobe_get_btf();
> >  	const struct btf_param *param;
> >  	const struct btf_type *t;
> >  
> > -	if (!funcname || !nr)
> > +	if (!funcname || !nr || !btf)
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	t = find_btf_func_proto(funcname);
> > -	if (IS_ERR(t))
> > +	t = btf_find_func_proto(btf, funcname);
> > +	if (IS_ERR_OR_NULL(t))
> >  		return (const struct btf_param *)t;
> >  
> > -	*nr = btf_type_vlen(t);
> > -	param = (const struct btf_param *)(t + 1);
> > +	param = btf_get_func_param(t, nr);
> > +	if (IS_ERR_OR_NULL(param))
> > +		return param;
> >  
> >  	/* Hide the first 'data' argument of tracepoint */
> >  	if (tracepoint) {
> > @@ -490,8 +466,8 @@ static const struct fetch_type *parse_btf_retval_type(
> >  	const struct btf_type *t;
> >  
> >  	if (btf && ctx->funcname) {
> > -		t = find_btf_func_proto(ctx->funcname);
> > -		if (!IS_ERR(t))
> > +		t = btf_find_func_proto(btf, ctx->funcname);
> > +		if (!IS_ERR_OR_NULL(t))
> >  			typestr = type_from_btf_id(btf, t->type);
> >  	}
> >  
> > @@ -500,10 +476,14 @@ static const struct fetch_type *parse_btf_retval_type(
> >  
> >  static bool is_btf_retval_void(const char *funcname)
> >  {
> > +	struct btf *btf = traceprobe_get_btf();
> >  	const struct btf_type *t;
> >  
> > -	t = find_btf_func_proto(funcname);
> > -	if (IS_ERR(t))
> > +	if (!btf)
> > +		return false;
> > +
> > +	t = btf_find_func_proto(btf, funcname);
> > +	if (IS_ERR_OR_NULL(t))
> >  		return false;
> >  
> >  	return t->type == 0;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

