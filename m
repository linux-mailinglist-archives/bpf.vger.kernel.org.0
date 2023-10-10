Return-Path: <bpf+bounces-11811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9972B7BFFB6
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E122281E7A
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5724C95;
	Tue, 10 Oct 2023 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990A24201;
	Tue, 10 Oct 2023 14:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252DAC433C8;
	Tue, 10 Oct 2023 14:53:23 +0000 (UTC)
Date: Tue, 10 Oct 2023 10:54:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf/btf: Move tracing BTF APIs to the BTF library
Message-ID: <20231010105443.7ed2a2a8@gandalf.local.home>
In-Reply-To: <169694605862.516358.5321950027838863987.stgit@devnote2>
References: <169694605862.516358.5321950027838863987.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 22:54:19 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -912,6 +912,121 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf,
>  	return t;
>  }
>  
> +/*
> + * Find a function proto type by name, and return the btf_type with its btf
> + * in *@btf_p. Return NULL if not found.
> + * Note that caller has to call btf_put(*@btf_p) after using the btf_type.
> + */

If these functions are going to be available via include/linux/*.h then
they really should have kerneldoc comments attached to them.

-- Steve


> +const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
> +{
> +	const struct btf_type *t;
> +	s32 id;
> +
> +	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
> +	if (id < 0)
> +		return NULL;
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(*btf_p, id);
> +	if (!t || !btf_type_is_func(t))
> +		goto err;
> +
> +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> +	t = btf_type_by_id(*btf_p, t->type);
> +	if (!t || !btf_type_is_func_proto(t))
> +		goto err;
> +
> +	return t;
> +err:
> +	btf_put(*btf_p);
> +	return NULL;
> +}
> +
> +/*
> + * Get function parameter with the number of parameters.
> + * This can return NULL if the function has no parameters.
> + * It can return -EINVAL if the @func_proto is not a function proto type.
> + */
> +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> +{
> +	if (!btf_type_is_func_proto(func_proto))
> +		return ERR_PTR(-EINVAL);
> +
> +	*nr = btf_type_vlen(func_proto);
> +	if (*nr > 0)
> +		return (const struct btf_param *)(func_proto + 1);
> +	else
> +		return NULL;
> +}
> +
> +#define BTF_ANON_STACK_MAX	16
> +
> +struct btf_anon_stack {
> +	u32 tid;
> +	u32 offset;
> +};
> +
> +/*
> + * Find a member of data structure/union by name and return it.
> + * Return NULL if not found, or -EINVAL if parameter is invalid.
> + * If the member is an member of anonymous union/structure, the offset
> + * of that anonymous union/structure is stored into @anon_offset. Caller
> + * can calculate the correct offset from the root data structure by
> + * adding anon_offset to the member's offset.
> + */
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +						const struct btf_type *type,
> +						const char *member_name,
> +						u32 *anon_offset)
> +{

