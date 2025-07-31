Return-Path: <bpf+bounces-64804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00B5B1707F
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 13:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF6BA81971
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09912C1581;
	Thu, 31 Jul 2025 11:44:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140C62288F9;
	Thu, 31 Jul 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962297; cv=none; b=SYifgVqI8hzpcosPxZwxEydY4JPOu6nsSJoNBmCxLc+MRrRmc3yIInMN/1AvopFQYi/KjNXaOI6Awp3IZ0kEpNMsYJRfJvaGDCWWnhvwwsZbUJ78GckKvYtwCKz2iYCOTMAluLaLFn3g4/Ay6p93jegG8iKJbFMNuhcGJrS0sLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962297; c=relaxed/simple;
	bh=LJNQfAF8Kt9OcJY3Z38eJMuKjA7FmANAqcEo9McyXGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B68OGwf/OIBKTIaVBHd7hiXVeujsaA3vPHKGDeLtDYVPy5NRi50w0PW/09lHGkWkBhJQ5yC3r2dpzq4uS8O+fyQCRHXh0+lfG/Bssv8dMrYW2ATHMqj+UAA1yq3NjtuvPXTvYxniPEER8HPVayk+JcUADlVDfisNjR7TsyHlBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 167821D13;
	Thu, 31 Jul 2025 04:44:46 -0700 (PDT)
Received: from [10.1.29.75] (e132430.arm.com [10.1.29.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89A9F3F66E;
	Thu, 31 Jul 2025 04:44:51 -0700 (PDT)
Message-ID: <dc817ce7-9551-4365-bd94-3c102a6acda8@arm.com>
Date: Thu, 31 Jul 2025 12:44:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
References: <20250729113335.2e4f087d@batman.local.home>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250729113335.2e4f087d@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29-07-2025 16:33, Steven Rostedt wrote:
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
>   # cd /sys/kernel/tracing
>   # echo 'f:cache kmem_cache_alloc_noprof size=+0x18($arg1):u32' >> dynamic_events
> This requires knowing that the offset of size is 0x18, which can be found
> with gdb:
> 
>    (gdb) p &((struct kmem_cache *)0)->size
>    $1 = (unsigned int *) 0x18
> 
> If BTF is in the kernel, it can be used to find this with names, where the
> user doesn't need to find the actual offset:
> 
>   # echo 'f:cache kmem_cache_alloc_noprof size=+kmem_cache.size($arg1):u32' >> dynamic_events
> 
> Instead of the "+0x18", it would have "+kmem_cache.size" where the format is:
> 
>    +STRUCT.MEMBER[.MEMBER[..]]
> 
> The delimiter is '.' and the first item is the structure name. Then the
> member of the structure to get the offset of. If that member is an
> embedded structure, another '.MEMBER' may be added to get the offset of
> its members with respect to the original value.
> 
>    "+kmem_cache.size($arg1)" is equivalent to:
> 
>    (*(struct kmem_cache *)$arg1).size
> 
> Anonymous structures are also handled:
> 
>    # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events

Not sure how hard that would be but the type of the expression could probably be inferred from
BTF as well in some cases. Some cases may be ambiguous (like char* that could be either a buffer
to display as hex or a null-terminated ASCII string) but BTF would still allow to restrict
to something sensible (e.g. prevent u32 for a char*).

> 
> Where "+net_device.name(+sk_buff.dev($skbaddr))" is equivalent to:
> 
>    (*(struct net_device *)((*(struct sk_buff *)($skbaddr))->dev)->name)
> > Note that "dev" of struct sk_buff is inside an anonymous structure:
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
>      sshd-session-1080    [000] b..5.  1526.337161: xmit: (net.net_dev_xmit) arg1="enp7s0"
> 
> And nested structures can be found by adding more members to the arg:
> 
>    # echo 'f:read filemap_readahead.isra.0 file=+0(+dentry.d_name.name(+file.f_path.dentry($arg2))):string' >> dynamic_events
> 
> The above is equivalent to:
> 
>    *((*(struct dentry *)(*(struct file *)$arg2)->f_path.dentry)->d_name.name)
> 
> And produces:
> 
>         trace-cmd-1381    [002] ...1.  2082.676268: read: (filemap_readahead.isra.0+0x0/0x150) file="trace.dat"
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   Documentation/trace/kprobetrace.rst |   3 +
>   kernel/trace/trace_btf.c            | 106 ++++++++++++++++++++++++++++
>   kernel/trace/trace_btf.h            |  10 +++
>   kernel/trace/trace_probe.c          |   7 +-
>   4 files changed, 124 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index 3b6791c17e9b..00273157100c 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -54,6 +54,8 @@ Synopsis of kprobe_events
>     $retval	: Fetch return value.(\*2)
>     $comm		: Fetch current task comm.
>     +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
> +  +STRUCT.MEMBER[.MEMBER[..]](FETCHARG) : If BTF is supported, Fetch memory
> +		  at FETCHARG + the offset of MEMBER inside of STRUCT.(\*5)
>     \IMM		: Store an immediate value to the argument.
>     NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
>     FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> @@ -70,6 +72,7 @@ Synopsis of kprobe_events
>           accesses one register.
>     (\*3) this is useful for fetching a field of data structures.
>     (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
> +  (\*5) +STRUCT.MEMBER(FETCHARG) is equivalent to (*(struct STRUCT *)(FETCHARG)).MEMBER
>   
>   Function arguments at kretprobe
>   -------------------------------
> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index 5bbdbcbbde3c..b69404451410 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
> @@ -120,3 +120,109 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
>   	return member;
>   }
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
> +
> +	for_each_member(i, t, member) {
> +		const char *tname = btf_name_by_offset(btf, member->name_off);
> +
> +		if (strcmp(ptr, tname) == 0) {
> +			*type = btf_type_by_id(btf, member->type);
> +			return BITS_ROUNDDOWN_BYTES(member->offset);

member->offset does not only contain the offset, and the offset may not be
a multiple of 8:
https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/btf.h#L126

 From the BTF spec (https://docs.kernel.org/bpf/btf.html):

If the kind_flag is set, the btf_member.offset contains
both member bitfield size and bit offset.
The bitfield size and bit offset are calculated as below.:

#define BTF_MEMBER_BITFIELD_SIZE(val)   ((val) >> 24)
#define BTF_MEMBER_BIT_OFFSET(val)      ((val) & 0xffffff)

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
>   						const struct btf_type *type,
>   						const char *member_name,
>   						u32 *anon_offset);
> +
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +/* Will modify arg, but will put it back before returning. */
> +int btf_find_offset(char *arg, long *offset);
> +#else
> +static inline int btf_find_offset(char *arg, long *offset)
> +{
> +	return -EINVAL;
> +}
> +#endif
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 424751cdf31f..4c13e51ea481 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1137,7 +1137,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>   
>   	case '+':	/* deref memory */
>   	case '-':
> -		if (arg[1] == 'u') {
> +		if (arg[1] == 'u' && isdigit(arg[2])) {
>   			deref = FETCH_OP_UDEREF;
>   			arg[1] = arg[0];
>   			arg++;
> @@ -1150,7 +1150,10 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>   			return -EINVAL;
>   		}
>   		*tmp = '\0';
> -		ret = kstrtol(arg, 0, &offset);
> +		if (arg[0] != '-' && !isdigit(*arg))
> +			ret = btf_find_offset(arg, &offset);
> +		else
> +			ret = kstrtol(arg, 0, &offset);
>   		if (ret) {
>   			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
>   			break;


