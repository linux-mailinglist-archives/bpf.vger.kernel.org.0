Return-Path: <bpf+bounces-64705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB52B161F2
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B81893EF0
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8802D9EEF;
	Wed, 30 Jul 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQhdQ2qO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DC2D948C;
	Wed, 30 Jul 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883626; cv=none; b=L+R2/GcDCNGKx7SZ9gZee6/sHj3tI7xV5fEXXwBwIw8qtHmxAUapMx9+k9O19ZDIJ+3RP7wBusj8CdDgY/oRt3+eBD8JIlkV6bGxuSn/UzaRv6TVK/tQt2wZBvSIYSR4jc+wIt91s81jnvz+5vE6rMVO4EnRJ4XRIFk6oo0wbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883626; c=relaxed/simple;
	bh=FrY1tORaOz9Dh269bjvURkmvNtbx8l98ZBz+dBh1xJ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NKhRQkgt/Y46IzvHgtXIiLZlvpSx/EnRep3Q6wlv43los/BDafwQ+zb4t7YwrJBeF2IAAFKIIm0andz8ff/KZngDCZnKgRsobAkyo2+GjzOebWXgGGrk5wFbzSDfm6hN/L7RVsyhkzSf+biFvVzWkJNJmEVgeeEJ/1JXQOmp3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQhdQ2qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B650DC4CEE7;
	Wed, 30 Jul 2025 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883626;
	bh=FrY1tORaOz9Dh269bjvURkmvNtbx8l98ZBz+dBh1xJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kQhdQ2qOBWXpkE1DrU/4qU/yR5lIzJ9aclPd5lCBmAQktWViebMW9IuzuE/gkD/pC
	 6YoJrIWRVbbCc1OYox8y+/GKsMWNHSQ97CpTCHyHzAgFxteIafr5rVkamodRWV5Npt
	 /cl/BY3jIZgZdtSbanADTKh6wAoCo8M+pCW26YlRaukJm1Lu2jdbeWMa17QwK9i5re
	 qTREek1c7yVZTpxv7yW33j0WF/nUkHuEHIksQ7cHFNy7vVAPIZEQITRAupL8Jhrps4
	 jSWhXeGogfSJvC4K9hvY7QE0zVH84b3uROEM3c7XkkbUCrq/eIuafl2Z+mvDR3ygaJ
	 g5fb57FTkpb9g==
Date: Wed, 30 Jul 2025 22:53:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
Subject: Re: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-Id: <20250730225340.92ead36268880e0bc098f12e@kernel.org>
In-Reply-To: <20250729113335.2e4f087d@batman.local.home>
References: <20250729113335.2e4f087d@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 11:33:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add syntax to the FETCHARGS parsing of probes to allow the use of
> structure and member names to get the offsets to dereference pointers.
> 
> Currently, a dereference must be a number, where the user has to figure
> out manually the offset of a member of a structure that they want to
> reference. For example, to get the size of a kmem_cache that was passed to
> the function kmem_cache_alloc_noprof, one would need to do:
> 
>  # cd /sys/kernel/tracing
>  # echo 'f:cache kmem_cache_alloc_noprof size=+0x18($arg1):u32' >> dynamic_events
> 
> This requires knowing that the offset of size is 0x18, which can be found
> with gdb:
> 
>   (gdb) p &((struct kmem_cache *)0)->size
>   $1 = (unsigned int *) 0x18
> 
> If BTF is in the kernel, it can be used to find this with names, where the
> user doesn't need to find the actual offset:
> 
>  # echo 'f:cache kmem_cache_alloc_noprof size=+kmem_cache.size($arg1):u32' >> dynamic_events

Great! This is something like a evolution of assembler to "symbolic"
assembler. ;)

> 
> Instead of the "+0x18", it would have "+kmem_cache.size" where the format is:
> 
>   +STRUCT.MEMBER[.MEMBER[..]]

Yeah, and using '.' delimiter looks nice to me.

> 
> The delimiter is '.' and the first item is the structure name. Then the
> member of the structure to get the offset of. If that member is an
> embedded structure, another '.MEMBER' may be added to get the offset of
> its members with respect to the original value.
> 
>   "+kmem_cache.size($arg1)" is equivalent to:
> 
>   (*(struct kmem_cache *)$arg1).size
> 
> Anonymous structures are also handled:
> 
>   # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events

So this only replaces the "offset" part. So we still need to use
+OFFS() syntax for dereferencing the pointer.

> 
> Where "+net_device.name(+sk_buff.dev($skbaddr))" is equivalent to:
> 
>   (*(struct net_device *)((*(struct sk_buff *)($skbaddr))->dev)->name)
> 
> Note that "dev" of struct sk_buff is inside an anonymous structure:
> 
> struct sk_buff {
> 	union {
> 		struct {
> 			/* These two members must be first to match sk_buff_head. */
> 			struct sk_buff		*next;
> 			struct sk_buff		*prev;
> 
> 			union {
> 				struct net_device	*dev;
> 				[..]
> 			};
> 		};
> 		[..]
> 	};
> 
> This will allow up to three deep of anonymous structures before it will
> fail to find a member.
> 
> The above produces:
> 
>     sshd-session-1080    [000] b..5.  1526.337161: xmit: (net.net_dev_xmit) arg1="enp7s0"
> 
> And nested structures can be found by adding more members to the arg:
> 
>   # echo 'f:read filemap_readahead.isra.0 file=+0(+dentry.d_name.name(+file.f_path.dentry($arg2))):string' >> dynamic_events
> 
> The above is equivalent to:
> 
>   *((*(struct dentry *)(*(struct file *)$arg2)->f_path.dentry)->d_name.name)
> 
> And produces:
> 
>        trace-cmd-1381    [002] ...1.  2082.676268: read: (filemap_readahead.isra.0+0x0/0x150) file="trace.dat"
> 

OK, the desgin looks good to me. I have some comments below.


> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/trace/kprobetrace.rst |   3 +
>  kernel/trace/trace_btf.c            | 106 ++++++++++++++++++++++++++++
>  kernel/trace/trace_btf.h            |  10 +++
>  kernel/trace/trace_probe.c          |   7 +-
>  4 files changed, 124 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index 3b6791c17e9b..00273157100c 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -54,6 +54,8 @@ Synopsis of kprobe_events
>    $retval	: Fetch return value.(\*2)
>    $comm		: Fetch current task comm.
>    +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
> +  +STRUCT.MEMBER[.MEMBER[..]](FETCHARG) : If BTF is supported, Fetch memory
> +		  at FETCHARG + the offset of MEMBER inside of STRUCT.(\*5)
>    \IMM		: Store an immediate value to the argument.
>    NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
>    FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> @@ -70,6 +72,7 @@ Synopsis of kprobe_events
>          accesses one register.
>    (\*3) this is useful for fetching a field of data structures.
>    (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
> +  (\*5) +STRUCT.MEMBER(FETCHARG) is equivalent to (*(struct STRUCT *)(FETCHARG)).MEMBER
>  
>  Function arguments at kretprobe
>  -------------------------------
> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index 5bbdbcbbde3c..b69404451410 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
> @@ -120,3 +120,109 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
>  	return member;
>  }
>  
> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> +
> +static int find_member(const char *ptr, struct btf *btf,
> +		       const struct btf_type **type, int level)
> +{
> +	const struct btf_member *member;
> +	const struct btf_type *t = *type;
> +	int i;
> +
> +	/* Max of 3 depth of anonymous structures */
> +	if (level > 3)
> +		return -1;

Please return an error code, maybe this is -E2BIG?

> +
> +	for_each_member(i, t, member) {
> +		const char *tname = btf_name_by_offset(btf, member->name_off);
> +
> +		if (strcmp(ptr, tname) == 0) {
> +			*type = btf_type_by_id(btf, member->type);
> +			return BITS_ROUNDDOWN_BYTES(member->offset);
> +		}
> +
> +		/* Handle anonymous structures */
> +		if (strlen(tname))
> +			continue;
> +
> +		*type = btf_type_by_id(btf, member->type);
> +		if (btf_type_is_struct(*type)) {
> +			int offset = find_member(ptr, btf, type, level + 1);
> +
> +			if (offset < 0)
> +				continue;
> +
> +			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
> +		}
> +	}
> +
> +	return -1;

	return -ENOENT;

> +}
> +
> +/**
> + * btf_find_offset - Find an offset of a member for a structure
> + * @arg: A structure name followed by one or more members
> + * @offset_p: A pointer to where to store the offset
> + *
> + * Will parse @arg with the expected format of: struct.member[[.member]..]
> + * It is delimited by '.'. The first item must be a structure type.
> + * The next are its members. If the member is also of a structure type it
> + * another member may follow ".member".
> + *
> + * Note, @arg is modified but will be put back to what it was on return.
> + *
> + * Returns: 0 on success and -EINVAL if no '.' is present
> + *    or -ENXIO if the structure or member is not found.
> + *    Returns -EINVAL if BTF is not defined.
> + *  On success, @offset_p will contain the offset of the member specified
> + *    by @arg.
> + */
> +int btf_find_offset(char *arg, long *offset_p)
> +{
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	long offset = 0;
> +	char *ptr;
> +	int ret;
> +	s32 id;
> +
> +	ptr = strchr(arg, '.');
> +	if (!ptr)
> +		return -EINVAL;

Instead of just returning error, can't we log an error for helping user?

trace_probe_log_err(BYTE_OFFSET, ERROR_CODE);

The base offset is stored in ctx->offset, so you can use it.
ERROR_CODE is defined in trace_probe.h. 

Maybe you can add something like

	C(BAD_STRUCT_FMT,		"Symbolic offset must be +STRUCT.MEMBER format"),\

And for other cases, you can use

	C(BAD_BTF_TID,		"Failed to get BTF type info."),\

> +
> +	*ptr = '\0';
> +
> +	id = bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);
> +	if (id < 0)
> +		goto error;
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(btf, id);
> +
> +	/* May allow more than one member, as long as they are structures */
> +	do {
> +		if (!t || !btf_type_is_struct(t))
> +			goto error;
> +
> +		*ptr++ = '.';
> +		arg = ptr;
> +		ptr = strchr(ptr, '.');
> +		if (ptr)
> +			*ptr = '\0';
> +
> +		ret = find_member(arg, btf, &t, 0);
> +		if (ret < 0)
> +			goto error;
> +
> +		offset += ret;
> +
> +	} while (ptr);
> +
> +	*offset_p = offset;
> +	return 0;
> +
> +error:
> +	if (ptr)
> +		*ptr = '.';
> +	return -ENXIO;
> +}
> diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
> index 4bc44bc261e6..7b0797a6050b 100644
> --- a/kernel/trace/trace_btf.h
> +++ b/kernel/trace/trace_btf.h
> @@ -9,3 +9,13 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
>  						const struct btf_type *type,
>  						const char *member_name,
>  						u32 *anon_offset);
> +
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +/* Will modify arg, but will put it back before returning. */
> +int btf_find_offset(char *arg, long *offset);
> +#else
> +static inline int btf_find_offset(char *arg, long *offset)
> +{

Here also should use 

	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\


Thank you,

> +	return -EINVAL;
> +}
> +#endif
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 424751cdf31f..4c13e51ea481 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1137,7 +1137,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  
>  	case '+':	/* deref memory */
>  	case '-':
> -		if (arg[1] == 'u') {
> +		if (arg[1] == 'u' && isdigit(arg[2])) {
>  			deref = FETCH_OP_UDEREF;
>  			arg[1] = arg[0];
>  			arg++;
> @@ -1150,7 +1150,10 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  			return -EINVAL;
>  		}
>  		*tmp = '\0';
> -		ret = kstrtol(arg, 0, &offset);
> +		if (arg[0] != '-' && !isdigit(*arg))
> +			ret = btf_find_offset(arg, &offset);
> +		else
> +			ret = kstrtol(arg, 0, &offset);
>  		if (ret) {
>  			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
>  			break;
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

