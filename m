Return-Path: <bpf+bounces-5618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21175C9C0
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4695A2819A5
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C01ED22;
	Fri, 21 Jul 2023 14:22:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F181E539
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 14:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A42C433C9;
	Fri, 21 Jul 2023 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689949357;
	bh=cUi296eF2C9WP9mdZeH5Yfe9jXUUyl8wU5SfLNXEuow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jslEWqJpZB+dAEEOMcBXFkjAFSWnknZmIMUx78ERpYKIrThT+ORkwLZm1wsAB/B4/
	 jTyJe+MGfJM6xBmJ/l3omp5knCBjGhJn/8LI9D49Vr+N6vWptgLNRF90vRMaeXcwuJ
	 JwQ5SnZiLw7CubWdtdn0PKd5DS6NTYlQpQ+Evfbjr8MS3lCVWHYMAuYK+f7zrTJ5sl
	 Q8gw6fYaK/MMWM/RWCymcPG+sKhGbvHy+MJXrB9/ywNYVlLQCihnjvl5hAtlgx4Qqu
	 bnqBg0PRXd/xh3c72irxbSCI2qHsQdTH0Xq6a7TUn9C7HlQI5S2JovQ//kJYiTUfYp
	 y/Jo6VJWEqljQ==
Date: Fri, 21 Jul 2023 23:22:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230721232233.d1e9456d23bbbab88f05f480@kernel.org>
In-Reply-To: <dbb5500e-f623-77fb-2606-c3073371e979@oracle.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
	<168960742712.34107.9849785489776347376.stgit@devnote2>
	<dbb5500e-f623-77fb-2606-c3073371e979@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 23:34:42 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> On 17/07/2023 16:23, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add btf_find_struct_member() API to search a member of a given data structure
> > or union from the member's name.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> A few small things below, but
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks

> 
> > ---
> >  include/linux/btf.h |    3 +++
> >  kernel/bpf/btf.c    |   38 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 98fbbcdd72ec..097fe9b51562 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -225,6 +225,9 @@ const struct btf_type *btf_find_func_proto(struct btf *btf,
> >  					   const char *func_name);
> >  const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> >  					   s32 *nr);
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +						const struct btf_type *type,
> > +						const char *member_name);
> >  
> >  #define for_each_member(i, struct_type, member)			\
> >  	for (i = 0, member = btf_type_member(struct_type);	\
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index e015b52956cb..452ffb0393d6 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1992,6 +1992,44 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
> >  		return NULL;
> >  }
> >  
> > +/*
> > + * Find a member of data structure/union by name and return it.
> > + * Return NULL if not found, or -EINVAL if parameter is invalid.
> > + */
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +						const struct btf_type *type,
> > +						const char *member_name)
> > +{
> > +	const struct btf_member *members, *ret;
> > +	const char *name;
> > +	int i, vlen;
> > +
> > +	if (!btf || !member_name || !btf_type_is_struct(type))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	vlen = btf_type_vlen(type);
> > +	members = (const struct btf_member *)(type + 1);
> > +
> > +	for (i = 0; i < vlen; i++) {
> 
> could use for_each_member() here I think, or perhaps use
> btf_type_member(type) when getting member pointer above.

Thanks! I missed that macro.

> 
> > +		if (!members[i].name_off) {
> > +			/* unnamed union: dig deeper */
> > +			type = btf_type_by_id(btf, members[i].type);
> > +			if (!IS_ERR_OR_NULL(type)) {
> > +				ret = btf_find_struct_member(btf, type,
> > +							     member_name);
> 
> You'll need to skip modifiers before calling btf_find_struct_member()
> here I think; it's possible to have a const anonymous union for example,

Yeah, it is possible. Let me add it.

> so to get to the union you'd need to skip the modifiers first. Otherwise
> you could fail the btf_type_is_struct() test on re-entry.

Indeed. 

Thank you!

> 
> 
> > +				if (!IS_ERR_OR_NULL(ret))
> > +					return ret;
> > +			}
> > +		} else {
> > +			name = btf_name_by_offset(btf, members[i].name_off);
> > +			if (name && !strcmp(member_name, name))
> > +				return &members[i];
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
> >  {
> >  	while (type_id < btf->start_id)
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

