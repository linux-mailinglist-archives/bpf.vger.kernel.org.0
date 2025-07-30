Return-Path: <bpf+bounces-64709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E9B162E4
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE70160B03
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789272D9ED8;
	Wed, 30 Jul 2025 14:33:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE041DE3D6;
	Wed, 30 Jul 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886001; cv=none; b=ip2th2lmz60sbQsb0sHz/xoQE+sNp4EcVXBicyTCvwoAQ4Njt6MCJVBsVb/oQ2EHl9sLfEqvINS/yPZVCBGbf5mvXtHM+ECtwYaZtMqaoqlXm2qxisbxoqry025X2XmpotSZRstJmDkFt2rxQnvuURa9gRrbsbIxkwgYNo75b4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886001; c=relaxed/simple;
	bh=PlM6vG64I7c9NulyIvT028yULjYuIv0uAORqJQLB7Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icBfK0prgktdpYXQ1GPgIaBRc+MnpoOtjJmMg3P4q+06N10bIQGakULqtN0I5ATQVm3mG2LPKThs6WVRgmcp1xk/pYlVImhzYt73g+HdmR5e6G9LaG3d0Yi9dBq0M80RjgyK0ky/+tUnok4LDd0BN0hadhOVE917k79YQWM9108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 82C3A8029E;
	Wed, 30 Jul 2025 14:33:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 5B6A732;
	Wed, 30 Jul 2025 14:33:12 +0000 (UTC)
Date: Wed, 30 Jul 2025 10:33:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Namhyung Kim
 <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, aahringo@redhat.com
Subject: Re: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <20250730103328.40bb6da5@gandalf.local.home>
In-Reply-To: <20250730225340.92ead36268880e0bc098f12e@kernel.org>
References: <20250729113335.2e4f087d@batman.local.home>
	<20250730225340.92ead36268880e0bc098f12e@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: owht7mijtbqgypkt8zazaa3mkppuz44d
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5B6A732
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18KjGCoIIafpUQP6IflbDC2HCE3gjnzJUw=
X-HE-Tag: 1753885992-619570
X-HE-Meta: U2FsdGVkX1/uAB27RqUDe8L3UhaDhi+jNIDHMCg5551QroW6nIJzxG79cAkGo7qKAtEV+reGYZwKCbaNHq7Ux5XR6zwIQonhyqcX5eJmJmVfGyh3Kub/R5CfINaXsnvAMca+ZHfNOAkGN+AXMZ7crdG0izHXlwyN4RqrInJzuD5ykkDMDANkVKOGjalCDeKnerN2EoUp83W1iAz7Dc/3+sPlXAPvdXyMv6kL9JEKwoIj9WxuE7ck7URQb2fY+LOZTdVetE4U6MqM9taeG0r8rAjlUD2EyLWBMpHiFbBhS3lFOl5a2pqBhDB1miKuGrvItP3YYnja2uhAIrVFWISg13Z1YPV6J9NnwrA10KfS3LCkgz6I7m/PZt62SHqNJqjW

On Wed, 30 Jul 2025 22:53:40 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:


> > If BTF is in the kernel, it can be used to find this with names, where the
> > user doesn't need to find the actual offset:
> > 
> >  # echo 'f:cache kmem_cache_alloc_noprof size=+kmem_cache.size($arg1):u32' >> dynamic_events  
> 
> Great! This is something like a evolution of assembler to "symbolic"
> assembler. ;)

Yep!

> 
> > 
> > Instead of the "+0x18", it would have "+kmem_cache.size" where the format is:
> > 
> >   +STRUCT.MEMBER[.MEMBER[..]]  
> 
> Yeah, and using '.' delimiter looks nice to me.

I know I initially suggested using ':' but then it hit me that a structure
uses '.' and that made a lot more sense. Also, it made parsing easier as I
had a hack to get around the ':' parsing that extracted the "type"
(like :u64 or :string)

> 
> > 
> > The delimiter is '.' and the first item is the structure name. Then the
> > member of the structure to get the offset of. If that member is an
> > embedded structure, another '.MEMBER' may be added to get the offset of
> > its members with respect to the original value.
> > 
> >   "+kmem_cache.size($arg1)" is equivalent to:
> > 
> >   (*(struct kmem_cache *)$arg1).size
> > 
> > Anonymous structures are also handled:
> > 
> >   # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events  
> 
> So this only replaces the "offset" part. So we still need to use
> +OFFS() syntax for dereferencing the pointer.

Correct.


> > And produces:
> > 
> >        trace-cmd-1381    [002] ...1.  2082.676268: read: (filemap_readahead.isra.0+0x0/0x150) file="trace.dat"
> >   
> 
> OK, the desgin looks good to me. I have some comments below.

I'd expected as much ;-)

This is for the next merge window so we have plenty of time.

> >  
> > +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> > +
> > +static int find_member(const char *ptr, struct btf *btf,
> > +		       const struct btf_type **type, int level)
> > +{
> > +	const struct btf_member *member;
> > +	const struct btf_type *t = *type;
> > +	int i;
> > +
> > +	/* Max of 3 depth of anonymous structures */
> > +	if (level > 3)
> > +		return -1;  
> 
> Please return an error code, maybe this is -E2BIG?

OK.

I was thinking that perhaps we should update the error_log to handle these
cases too.

> 
> > +
> > +	for_each_member(i, t, member) {
> > +		const char *tname = btf_name_by_offset(btf, member->name_off);
> > +
> > +		if (strcmp(ptr, tname) == 0) {
> > +			*type = btf_type_by_id(btf, member->type);
> > +			return BITS_ROUNDDOWN_BYTES(member->offset);
> > +		}
> > +
> > +		/* Handle anonymous structures */
> > +		if (strlen(tname))
> > +			continue;
> > +
> > +		*type = btf_type_by_id(btf, member->type);
> > +		if (btf_type_is_struct(*type)) {
> > +			int offset = find_member(ptr, btf, type, level + 1);
> > +
> > +			if (offset < 0)
> > +				continue;
> > +
> > +			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
> > +		}
> > +	}
> > +
> > +	return -1;  
> 
> 	return -ENOENT;

Ah. This return doesn't propagate up to the caller. It's a static function
and just returns "not found". Which means that the "-E2BIG" will not be used.

If we want the -E2BIG to be used as well, then we can return the result of
this function.


> 
> > +}
> > +
> > +/**
> > + * btf_find_offset - Find an offset of a member for a structure
> > + * @arg: A structure name followed by one or more members
> > + * @offset_p: A pointer to where to store the offset
> > + *
> > + * Will parse @arg with the expected format of: struct.member[[.member]..]
> > + * It is delimited by '.'. The first item must be a structure type.
> > + * The next are its members. If the member is also of a structure type it
> > + * another member may follow ".member".
> > + *
> > + * Note, @arg is modified but will be put back to what it was on return.
> > + *
> > + * Returns: 0 on success and -EINVAL if no '.' is present
> > + *    or -ENXIO if the structure or member is not found.
> > + *    Returns -EINVAL if BTF is not defined.
> > + *  On success, @offset_p will contain the offset of the member specified
> > + *    by @arg.
> > + */
> > +int btf_find_offset(char *arg, long *offset_p)
> > +{
> > +	const struct btf_type *t;
> > +	struct btf *btf;
> > +	long offset = 0;
> > +	char *ptr;
> > +	int ret;
> > +	s32 id;
> > +
> > +	ptr = strchr(arg, '.');
> > +	if (!ptr)
> > +		return -EINVAL;  
> 
> Instead of just returning error, can't we log an error for helping user?

Yeah, but that will require the caller of this to handle it. I rather not
have the probe error logging code put in this file.

That means the negative numbers will need to mean something so that the
trace probe logic can know what to report.

> 
> trace_probe_log_err(BYTE_OFFSET, ERROR_CODE);
> 
> The base offset is stored in ctx->offset, so you can use it.
> ERROR_CODE is defined in trace_probe.h. 
> 
> Maybe you can add something like
> 
> 	C(BAD_STRUCT_FMT,		"Symbolic offset must be +STRUCT.MEMBER format"),\
> 
> And for other cases, you can use
> 
> 	C(BAD_BTF_TID,		"Failed to get BTF type info."),\

OK, so the caller can handle this (see below).

> 
> > +
> > +	*ptr = '\0';
> > +
> > +	id = bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);
> > +	if (id < 0)
> > +		goto error;
> > +
> > +	/* Get BTF_KIND_FUNC type */
> > +	t = btf_type_by_id(btf, id);
> > +
> > +	/* May allow more than one member, as long as they are structures */
> > +	do {
> > +		if (!t || !btf_type_is_struct(t))
> > +			goto error;
> > +
> > +		*ptr++ = '.';
> > +		arg = ptr;
> > +		ptr = strchr(ptr, '.');
> > +		if (ptr)
> > +			*ptr = '\0';
> > +
> > +		ret = find_member(arg, btf, &t, 0);
> > +		if (ret < 0)
> > +			goto error;
> > +
> > +		offset += ret;
> > +
> > +	} while (ptr);
> > +
> > +	*offset_p = offset;
> > +	return 0;
> > +
> > +error:
> > +	if (ptr)
> > +		*ptr = '.';
> > +	return -ENXIO;
> > +}
> > diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
> > index 4bc44bc261e6..7b0797a6050b 100644
> > --- a/kernel/trace/trace_btf.h
> > +++ b/kernel/trace/trace_btf.h
> > @@ -9,3 +9,13 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
> >  						const struct btf_type *type,
> >  						const char *member_name,
> >  						u32 *anon_offset);
> > +
> > +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> > +/* Will modify arg, but will put it back before returning. */
> > +int btf_find_offset(char *arg, long *offset);
> > +#else
> > +static inline int btf_find_offset(char *arg, long *offset)
> > +{  
> 
> Here also should use 
> 
> 	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
> 

Again, this should be from the caller.

> 
> Thank you,
> 
> > +	return -EINVAL;

So this can return -ENODEV;


> > +}
> > +#endif
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 424751cdf31f..4c13e51ea481 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -1137,7 +1137,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  
> >  	case '+':	/* deref memory */
> >  	case '-':
> > -		if (arg[1] == 'u') {
> > +		if (arg[1] == 'u' && isdigit(arg[2])) {
> >  			deref = FETCH_OP_UDEREF;
> >  			arg[1] = arg[0];
> >  			arg++;
> > @@ -1150,7 +1150,10 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  			return -EINVAL;
> >  		}
> >  		*tmp = '\0';
> > -		ret = kstrtol(arg, 0, &offset);
> > +		if (arg[0] != '-' && !isdigit(*arg))
> > +			ret = btf_find_offset(arg, &offset);

Here we could have:

			if (ret < 0) {
				int err = 0;
				switch (ret) {
				case -ENODEV: err = NOSUP_BTFARG; break;
				case -E2BIG: err = MEMBER_TOO_DEEP; break;
				case -EINVAL: err = BAD_STRUCT_FMT; break;
				case -ENXIO: err = BAD_BTF_TID; break;
				}
				if (err)
					trace_probe_log_err(ctx->offset, err);
				return ret;
			}

-- Steve

			


> > +		else
> > +			ret = kstrtol(arg, 0, &offset);
> >  		if (ret) {
> >  			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
> >  			break;
> > -- 
> > 2.47.2
> >   
> 
> 


