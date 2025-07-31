Return-Path: <bpf+bounces-64809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1EDB17210
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 15:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6710A3AA75F
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB22C327E;
	Thu, 31 Jul 2025 13:29:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02BE2BE633;
	Thu, 31 Jul 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968583; cv=none; b=SkYG1w60V4ib7mDOcPQH66q0aNPqdlej5dMqRq9/FcdUeQhDUsjZL31sxPMICxnANT7E+1V1W1TLNuM1mMmWtAf8PP2xy7KdFnVwEdaN3NpraR3YClL1Q8EvRBkNths2SEq6SofGYaqpEcDYlOUWKgSx4gf1PuutUZV0wQAOL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968583; c=relaxed/simple;
	bh=EWZ6pgYKok987NH2oz9xI9u+YMbPGCsIzCxP5dd9HKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnYR4Ukul/kU1/3pMIqRg1N38W/3KiT2kXUhvwInkBim1x2Ld9dmA7F1jbUYx/QVaByCluSxyF3lmRBEOSaWQICg8+lR0t73TuNjpTElYLJwK7ACHv6+xv8ihRpht5qcH3xkwK6sE/uO88cN+eqY5H8YZ95VcOUzKyFUy7kLJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 869231406C8;
	Thu, 31 Jul 2025 13:29:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 6DE2B2000F;
	Thu, 31 Jul 2025 13:29:35 +0000 (UTC)
Date: Thu, 31 Jul 2025 09:29:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>, Tom
 Zanussi <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
Subject: Re: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <20250731092953.2d8eea47@gandalf.local.home>
In-Reply-To: <dc817ce7-9551-4365-bd94-3c102a6acda8@arm.com>
References: <20250729113335.2e4f087d@batman.local.home>
	<dc817ce7-9551-4365-bd94-3c102a6acda8@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6DE2B2000F
X-Stat-Signature: bw8ibe9b7c4kmub1p7k63nj1y9jnbfk4
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+L8H5s3fdXXyd6+hVzM+9/MXwV9vc+1vc=
X-HE-Tag: 1753968575-312415
X-HE-Meta: U2FsdGVkX1/sB+1YBbj7sOeT7/ppwTtWX8fJq/gHqBP+1upiwecpSHNCj+rKik7kiR3DvZ6o7wjwaxBH+W0qcaErSKH2GWFRHUt93RP8s03VfapcEoU3sUzpWLuXxu2NzuWEah3X0v8NQArwY23fJBmVXZHjKNRuKwee9I3Ppc/h/yAD1ZZ7u7zl5kPnZP0UrnD7nUIa/F+maaM1Tzznhashi7FKbnho11NbLc1FYhAFmA5hiJ1pzyxOY1YXLjp6u7sCUexh1CtiPH+/DP3rZBLHdqeAdG714auqmmY514yn/MEEj+l5vCGkPEBOx1MpjP2RFA5+AZlA5YeBg10j3TN7iSCiWca7Neje6Z7mwYtMlexnsrEZ6A7T4iOe7gcz/RfvDyPL+YoojjFSPKLjlPOuc4bf+GFEOknrrUMFbeg+5HexO9M3HEQG0ZGQC3BEh+5yzQbwlYURZXkA52ZFuRljCMqacBiqdmWVf65fFo8=

On Thu, 31 Jul 2025 12:44:49 +0100
Douglas Raillard <douglas.raillard@arm.com> wrote:

> > The delimiter is '.' and the first item is the structure name. Then the
> > member of the structure to get the offset of. If that member is an
> > embedded structure, another '.MEMBER' may be added to get the offset of
> > its members with respect to the original value.
> > 
> >    "+kmem_cache.size($arg1)" is equivalent to:
> > 
> >    (*(struct kmem_cache *)$arg1).size
> > 
> > Anonymous structures are also handled:
> > 
> >    # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events  
> 
> Not sure how hard that would be but the type of the expression could probably be inferred from
> BTF as well in some cases. Some cases may be ambiguous (like char* that could be either a buffer
> to display as hex or a null-terminated ASCII string) but BTF would still allow to restrict
> to something sensible (e.g. prevent u32 for a char*).

Hmm, should be possible, but would require passing that information back to
the caller of the BTF lookup function.



> > diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> > index 5bbdbcbbde3c..b69404451410 100644
> > --- a/kernel/trace/trace_btf.c
> > +++ b/kernel/trace/trace_btf.c
> > @@ -120,3 +120,109 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
> >   	return member;
> >   }
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
> > +
> > +	for_each_member(i, t, member) {
> > +		const char *tname = btf_name_by_offset(btf, member->name_off);
> > +
> > +		if (strcmp(ptr, tname) == 0) {
> > +			*type = btf_type_by_id(btf, member->type);
> > +			return BITS_ROUNDDOWN_BYTES(member->offset);  
> 
> member->offset does not only contain the offset, and the offset may not be
> a multiple of 8:
> https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/btf.h#L126
> 
>  From the BTF spec (https://docs.kernel.org/bpf/btf.html):
> 
> If the kind_flag is set, the btf_member.offset contains
> both member bitfield size and bit offset.
> The bitfield size and bit offset are calculated as below.:
> 
> #define BTF_MEMBER_BITFIELD_SIZE(val)   ((val) >> 24)
> #define BTF_MEMBER_BIT_OFFSET(val)      ((val) & 0xffffff)

So basically just need to change that to:

		if (strcmp(ptr, tname) == 0) {
			int offset = BTF_MEMBER_BIT_OFFSET(member->offset);
			*type = btf_type_by_id(btf, member->type);
			return BITS_ROUNDDOWN_BYTES(offset);

?

> 
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

And here too.

-- Steve

> > +		}
> > +	}
> > +
> > +	return -1;
> > +}
> > +

