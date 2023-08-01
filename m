Return-Path: <bpf+bounces-6492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E100F76A58C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3711C20D8C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2717C10FC;
	Tue,  1 Aug 2023 00:30:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282CED3
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 00:30:04 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DB5133;
	Mon, 31 Jul 2023 17:30:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8050404e87.2;
        Mon, 31 Jul 2023 17:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690849801; x=1691454601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP0ss+QFrEDr1W853Rw5boHV+kOYmqr8XMFUdINABY4=;
        b=UnHjPYlKzePkM6jaAezL/Oz1naX+R2xTssxu/YDfCgIEk9OKvo+Zr1NwgplFVh5wYh
         Nu8Gn9NgifSqEDUMSps1FPZU7QoNYlffON1zPM/PaeW2J1A6EwJxKFHqtBrRmnzKtFGP
         VHGhj85Z3vviSlkeQzoy22OkqscKCGzuk2WDkrcGHF6YNUTmV3tYvxS/EIm+stNEr5fZ
         Dda9dteptkuq4IiV8oQB+25qsCFdNaIpgc3m7V+uWjwyctEQ2z01HhwglI2ELhOtkz/1
         7+urBeDBtqnJVN3PLJt94akoOsI/33FqMpHTFJ0rseY2qX6icgJq7/U0ZrultIDdLfh8
         yuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690849801; x=1691454601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP0ss+QFrEDr1W853Rw5boHV+kOYmqr8XMFUdINABY4=;
        b=j24/CTflhoIWMft3A31IX3hgeg3LmwMbmn79WM/itb5u9vxkMyhYdP2aI/QpTkdRQz
         kn6UsNqII/1+64/ryb9wXRBVzSJv8Jj2UKc89iTSZQain0QAE0XC6tdEhrPgTn88T1F1
         fqvkyLIs7jnLqF//u9OyXLIJB906Ji7iL7o28WE8ASqwBcBTwD1Y7U6Rh1pYznsVRHoO
         GdPxTSeB48KvO5V3Zx5pDMwwG2kEBb6NLUYy5nNQ83gTmU5ly65+DAFVGfaYBo33tJAL
         dWRz6y0eerhGwspwEET6pqvAALoGmaXvtPkpL/99DXiKxa4/vsrFIdC8BU1jM7maIHVG
         Xr9g==
X-Gm-Message-State: ABy/qLa5Trp4d/dO2ZO4fkAHyFKr2OVGClvLcFph1+FFZseblWEWje4Z
	yHWsfQfKRKRHmgL9NgqwCOsMzOSW8GZYVJ7mFNQ=
X-Google-Smtp-Source: APBJJlGbcB7idTGp1DG44yuQk8uVjeLpj1gIntNzbeoudVEFdAMQd5AEuyi0vN24WE4L3cvSs5UpLJRXwI115dfirDc=
X-Received: by 2002:a2e:80c3:0:b0:2b7:3633:2035 with SMTP id
 r3-20020a2e80c3000000b002b736332035mr1121930ljg.32.1690849800775; Mon, 31 Jul
 2023 17:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
In-Reply-To: <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Jul 2023 17:29:49 -0700
Message-ID: <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 4:57=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Mon, 31 Jul 2023 14:59:47 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Mon, Jul 31, 2023 at 12:30=E2=80=AFAM Masami Hiramatsu (Google)
> > <mhiramat@kernel.org> wrote:
> > >
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > Add btf_find_struct_member() API to search a member of a given data s=
tructure
> > > or union from the member's name.
> > >
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > ---
> > >  Changes in v3:
> > >   - Remove simple input check.
> > >   - Fix unneeded IS_ERR_OR_NULL() check for btf_type_by_id().
> > >   - Move the code next to btf_get_func_param().
> > >   - Use for_each_member() macro instead of for-loop.
> > >   - Use btf_type_skip_modifiers() instead of btf_type_by_id().
> > >  Changes in v4:
> > >   - Use a stack for searching in anonymous members instead of nested =
call.
> > > ---
> > >  include/linux/btf.h |    3 +++
> > >  kernel/bpf/btf.c    |   40 ++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 43 insertions(+)
> > >
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index 20e3a07eef8f..4b10d57ceee0 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -226,6 +226,9 @@ const struct btf_type *btf_find_func_proto(const =
char *func_name,
> > >                                            struct btf **btf_p);
> > >  const struct btf_param *btf_get_func_param(const struct btf_type *fu=
nc_proto,
> > >                                            s32 *nr);
> > > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > > +                                               const struct btf_type=
 *type,
> > > +                                               const char *member_na=
me);
> > >
> > >  #define for_each_member(i, struct_type, member)                     =
   \
> > >         for (i =3D 0, member =3D btf_type_member(struct_type);      \
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index f7b25c615269..8d81a4ffa67b 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -958,6 +958,46 @@ const struct btf_param *btf_get_func_param(const=
 struct btf_type *func_proto, s3
> > >                 return NULL;
> > >  }
> > >
> > > +#define BTF_ANON_STACK_MAX     16
> > > +
> > > +/*
> > > + * Find a member of data structure/union by name and return it.
> > > + * Return NULL if not found, or -EINVAL if parameter is invalid.
> > > + */
> > > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > > +                                               const struct btf_type=
 *type,
> > > +                                               const char *member_na=
me)
> > > +{
> > > +       const struct btf_type *anon_stack[BTF_ANON_STACK_MAX];
> > > +       const struct btf_member *member;
> > > +       const char *name;
> > > +       int i, top =3D 0;
> > > +
> > > +retry:
> > > +       if (!btf_type_is_struct(type))
> > > +               return ERR_PTR(-EINVAL);
> > > +
> > > +       for_each_member(i, type, member) {
> > > +               if (!member->name_off) {
> > > +                       /* Anonymous union/struct: push it for later =
use */
> > > +                       type =3D btf_type_skip_modifiers(btf, member-=
>type, NULL);
> > > +                       if (type && top < BTF_ANON_STACK_MAX)
> > > +                               anon_stack[top++] =3D type;
> > > +               } else {
> > > +                       name =3D btf_name_by_offset(btf, member->name=
_off);
> > > +                       if (name && !strcmp(member_name, name))
> > > +                               return member;
> > > +               }
> > > +       }
> > > +       if (top > 0) {
> > > +               /* Pop from the anonymous stack and retry */
> > > +               type =3D anon_stack[--top];
> > > +               goto retry;
> > > +       }
> >
> > Looks good, but I don't see a test case for this.
> > The logic is a bit tricky. I'd like to have a selftest that covers it.
>
> Thanks, and I agree about selftest.
>
> >
> > You probably need to drop Alan's reviewed-by, since the patch is quite
> > different from the time he reviewed it.
>
> OK. BTW, I found a problem on this function. I guess the member->offset w=
ill
> be the offset from the intermediate anonymous union, it is usually 0, but
> I need the offset from the given structure. Thus the interface design mus=
t
> be changed. Passing a 'u32 *offset' and set the correct offset in it. If
> it has nested intermediate anonymous unions, that offset must also be pus=
hed.

With all that piling up have you considering reusing btf_struct_walk() ?
It's doing the opposite off -> btf_id while you need name -> btf_id.
But it will give an idea of overall complexity if you want to solve it
for nested arrays and struct/union.

> >
> > Assuming that is addressed. How do we merge the series?
> > The first 3 patches have serious conflicts with bpf trees.
> >
> > Maybe send the first 3 with extra selftest for above recursion
> > targeting bpf-next then we can have a merge commit that Steven can pull
> > into tracing?
> >
> > Or if we can have acks for patches 4-9 we can pull the whole set into b=
pf-next.
>
> That's a good question. I don't like splitting the whole series in 2 -nex=
t
> branches. So I can send this to the bpf-next.

Works for me.

> I need to work on another series(*) on fprobes which will not have confli=
cts with
> this series. (*Replacing pt_regs with ftrace_regs on fprobe, which will t=
ake longer
> time, and need to adjust with eBPF).

ftrace_regs?
Ouch. For bpf we rely on pt_regs being an argument.
fprobe should be 100% compatible replacement of kprobe-at-the-func-start.
If it diverges from that it's a big issue for bpf.
We'd have to remove all of fprobe usage.
I could be missing something, of course.

