Return-Path: <bpf+bounces-6491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE376A545
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063C21C2080C
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B771EA94;
	Mon, 31 Jul 2023 23:57:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49811DDDE
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 23:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10E4C433C7;
	Mon, 31 Jul 2023 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690847848;
	bh=/fXRZCNesM6Jdmzd6pG7zKjXwQs/gOTB7uIKTKjjBhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lh+ZSGwO9a84DLcxRLblMXnPWJD2G3DLI2MuLQfBJ1FsagzBnfDWSb/68SCPbqWqE
	 LcujAdnbnK2H7BmCjf01IICkUbUA1WmuVSiTENhoKr0Cf8C8/WG+4zTgsNtvtuv9dN
	 XEsdIX4okLgnXWKJp1imMWf2EG/BS1wvjgikTmv/Om1jg7EyxhHs0lkcomeXw8a6Ot
	 UThV8uAshPubBdwB9Kxjpl2DhO8+AvY94WTObjjKlJYhMc6tzJNTgm90bnNRHCW2i3
	 GSpsjc5kihrp4EAbYLhX+JBfxmPxPuHRzwejctU2H9MSsBfE75kIrgPl2hrwYb0iBo
	 bqNm14DAiAnug==
Date: Tue, 1 Aug 2023 08:57:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
In-Reply-To: <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 31 Jul 2023 14:59:47 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Jul 31, 2023 at 12:30 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Add btf_find_struct_member() API to search a member of a given data structure
> > or union from the member's name.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  Changes in v3:
> >   - Remove simple input check.
> >   - Fix unneeded IS_ERR_OR_NULL() check for btf_type_by_id().
> >   - Move the code next to btf_get_func_param().
> >   - Use for_each_member() macro instead of for-loop.
> >   - Use btf_type_skip_modifiers() instead of btf_type_by_id().
> >  Changes in v4:
> >   - Use a stack for searching in anonymous members instead of nested call.
> > ---
> >  include/linux/btf.h |    3 +++
> >  kernel/bpf/btf.c    |   40 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 20e3a07eef8f..4b10d57ceee0 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -226,6 +226,9 @@ const struct btf_type *btf_find_func_proto(const char *func_name,
> >                                            struct btf **btf_p);
> >  const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> >                                            s32 *nr);
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +                                               const struct btf_type *type,
> > +                                               const char *member_name);
> >
> >  #define for_each_member(i, struct_type, member)                        \
> >         for (i = 0, member = btf_type_member(struct_type);      \
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index f7b25c615269..8d81a4ffa67b 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -958,6 +958,46 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
> >                 return NULL;
> >  }
> >
> > +#define BTF_ANON_STACK_MAX     16
> > +
> > +/*
> > + * Find a member of data structure/union by name and return it.
> > + * Return NULL if not found, or -EINVAL if parameter is invalid.
> > + */
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +                                               const struct btf_type *type,
> > +                                               const char *member_name)
> > +{
> > +       const struct btf_type *anon_stack[BTF_ANON_STACK_MAX];
> > +       const struct btf_member *member;
> > +       const char *name;
> > +       int i, top = 0;
> > +
> > +retry:
> > +       if (!btf_type_is_struct(type))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       for_each_member(i, type, member) {
> > +               if (!member->name_off) {
> > +                       /* Anonymous union/struct: push it for later use */
> > +                       type = btf_type_skip_modifiers(btf, member->type, NULL);
> > +                       if (type && top < BTF_ANON_STACK_MAX)
> > +                               anon_stack[top++] = type;
> > +               } else {
> > +                       name = btf_name_by_offset(btf, member->name_off);
> > +                       if (name && !strcmp(member_name, name))
> > +                               return member;
> > +               }
> > +       }
> > +       if (top > 0) {
> > +               /* Pop from the anonymous stack and retry */
> > +               type = anon_stack[--top];
> > +               goto retry;
> > +       }
> 
> Looks good, but I don't see a test case for this.
> The logic is a bit tricky. I'd like to have a selftest that covers it.

Thanks, and I agree about selftest.

> 
> You probably need to drop Alan's reviewed-by, since the patch is quite
> different from the time he reviewed it.

OK. BTW, I found a problem on this function. I guess the member->offset will
be the offset from the intermediate anonymous union, it is usually 0, but
I need the offset from the given structure. Thus the interface design must
be changed. Passing a 'u32 *offset' and set the correct offset in it. If
it has nested intermediate anonymous unions, that offset must also be pushed.

> 
> Assuming that is addressed. How do we merge the series?
> The first 3 patches have serious conflicts with bpf trees.
> 
> Maybe send the first 3 with extra selftest for above recursion
> targeting bpf-next then we can have a merge commit that Steven can pull
> into tracing?
> 
> Or if we can have acks for patches 4-9 we can pull the whole set into bpf-next.

That's a good question. I don't like splitting the whole series in 2 -next
branches. So I can send this to the bpf-next.
I need to work on another series(*) on fprobes which will not have conflicts with
this series. (*Replacing pt_regs with ftrace_regs on fprobe, which will take longer
time, and need to adjust with eBPF).

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

