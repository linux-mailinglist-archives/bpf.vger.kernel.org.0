Return-Path: <bpf+bounces-19155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD9E825D59
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 01:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931CA1C23546
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841F627;
	Sat,  6 Jan 2024 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFE6JrY2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C815AB
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d45f182fa2so750895ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 16:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704500296; x=1705105096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gjq9mjf6eEqvekSgusK/cnKeVKPkZO0U9WoLU0i31ig=;
        b=jFE6JrY24UW9DO20EVVE+2u9WtOQxIq3lWTd/R7v+PMYe03XaW9JzfCzM5SXl+b28k
         6rCGBS1FJlZWpBX8EiBcgRcaJ4WeI1DTHNenXGFSEm/7VdWdIZo15jY5eawbV+0T9oU6
         tEYr25yb8L57LbV416e+dKxWIf9ShcdbSKGf9DRDdRj5AAA4my5GHKblNYOy1AB8p3Ji
         MzmoMdZHBrKXJ2/QbQRIas3OyK91kgmv9Y7relld/xRstpEW9ONoRej8bUrG2e97R335
         wSu/kK2+Tjhrl3PqFhPwjO21iNFsahd0Tq6COYZGIskgasfsR3VLeeC19U71hfxF7zmH
         sabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704500296; x=1705105096;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gjq9mjf6eEqvekSgusK/cnKeVKPkZO0U9WoLU0i31ig=;
        b=GBnPYTXeTKpovae20aTu0OpbhQkNs+TTt9mbJtNON3JAoOXTvnJ6haav8OKD2hZc/M
         vCM1E8V6wrCE0MQXQaJ/hrd6QqftU97sMPV+ghEMLMoG9Lu3P3McTRYNXnKqJhMwNXNr
         YrbycrYjpY8wHbwuzVxHF8ebxR6Vr2XVdcpT5Mjrk9EMIb1aQDF+xHcVlhzi1mje2/7h
         DAy7wqhRv2YyNLDmfiGrkej3Zl+IWsLOs9itM+OEWyFx9HqnHf3TX3Q5Ytgu0PyIZzMJ
         8KY9PVLkYhX17jIpAgxeaSv1hsxKg687w4RDpAlgUHXcxQpk6PJWmTpSj99dS1xsHNms
         DoSw==
X-Gm-Message-State: AOJu0YzZJRTnalWFXxCu4zibx+DFOvB6k8wmRrtfagWUd81eO3mna+YY
	G7OTuU8iNF698XBWETZri6k=
X-Google-Smtp-Source: AGHT+IF9sOTntDVTxrGMhTZXGIW/vhdSs0aIMQ/v/Ekbm+ed46lGxo4kzyi753EZg2wPnTj674RUbQ==
X-Received: by 2002:a17:902:c10d:b0:1d4:58d9:345a with SMTP id 13-20020a170902c10d00b001d458d9345amr266157pli.61.1704500295807;
        Fri, 05 Jan 2024 16:18:15 -0800 (PST)
Received: from localhost ([98.97.36.36])
        by smtp.gmail.com with ESMTPSA id bd3-20020a170902830300b001d4872d9429sm1952256plb.156.2024.01.05.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 16:18:14 -0800 (PST)
Date: Fri, 05 Jan 2024 16:18:13 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, 
 bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Hengqi Chen <hengqi.chen@gmail.com>, 
 kernel-patches-bot@fb.com
Message-ID: <65989c459a6b6_3a2dc208c1@john.notmuch>
In-Reply-To: <ZZf4uXuSvFq1JwU1@krava>
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
 <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <ZZf4uXuSvFq1JwU1@krava>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Olsa wrote:
> On Thu, Jan 04, 2024 at 08:15:36PM -0800, Alexei Starovoitov wrote:
> > On Thu, Jan 4, 2024 at 6:23=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.co=
m> wrote:
> > >
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_com=
p.c
> > > index fe30b9ebb8de4..67fa337fc2e0c 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -259,7 +259,7 @@ struct jit_context {
> > >  /* Number of bytes emit_patch() needs to generate instructions */
> > >  #define X86_PATCH_SIZE         5
> > >  /* Number of bytes that will be skipped on tailcall */
> > > -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
> > > +#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
> > >
> > >  static void push_r12(u8 **pprog)
> > >  {
> > > @@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 sta=
ck_depth, bool ebpf_from_cbpf,
> > >          */
> > >         emit_nops(&prog, X86_PATCH_SIZE);
> > >         if (!ebpf_from_cbpf) {
> > > -               if (tail_call_reachable && !is_subprog)
> > > +               if (tail_call_reachable && !is_subprog) {
> > >                         /* When it's the entry of the whole tailcal=
l context,
> > >                          * zeroing rax means initialising tail_call=
_cnt.
> > >                          */
> > > -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
> > > -               else
> > > -                       /* Keep the same instruction layout. */
> > > -                       EMIT2(0x66, 0x90); /* nop2 */
> > > +                       EMIT2(0x31, 0xC0);       /* xor eax, eax */=

> > > +                       EMIT1(0x50);             /* push rax */
> > > +                       /* Make rax as ptr that points to tail_call=
_cnt. */
> > > +                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */=

> > > +                       EMIT1_off32(0xE8, 2);    /* call main prog =
*/
> > > +                       EMIT1(0x59);             /* pop rcx, get ri=
d of tail_call_cnt */
> > > +                       EMIT1(0xC3);             /* ret */
> > > +               } else {
> > > +                       /* Keep the same instruction size. */
> > > +                       emit_nops(&prog, 13);
> > > +               }
> > =

> > I'm afraid the extra call breaks stack unwinding and many other thing=
s.
> > The proper frame needs to be setup (push rbp; etc)
> > and 'leave' + emit_return() is used.
> > Plain 'ret' is not ok.
> > x86_call_depth_emit_accounting() needs to be used too.
> > That will make X86_TAIL_CALL_OFFSET adjustment very complicated.
> > Also the fix doesn't address the stack size issue.
> > We shouldn't allow all the extra frames at run-time.
> > =

> > The tail_cnt_ptr approach is interesting but too heavy,
> > since arm64, s390 and other JITs would need to repeat it with equally=

> > complicated calculations in TAIL_CALL_OFFSET.
> > =

> > The fix should really be thought through for all JITs. Not just x86.
> > =

> > I'm thinking whether we should do the following instead:
> > =

> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 0bdbbbeab155..0b45571559be 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -910,7 +910,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map=
 *map,
> >         if (IS_ERR(prog))
> >                 return prog;
> > =

> > -       if (!bpf_prog_map_compatible(map, prog)) {
> > +       if (!bpf_prog_map_compatible(map, prog) || prog->aux->func_cn=
t) {
> >                 bpf_prog_put(prog);
> >                 return ERR_PTR(-EINVAL);
> >         }
> > =

> > This will stop stack growth, but it will break a few existing tests.
> > I feel it's a price worth paying.
> > =

> > John, Daniel,
> > =

> > do you see anything breaking on cilium side if we disallow
> > progs with subprogs to be inserted in prog_array ?
> =

> FWIW tetragon should be ok with this.. we use few subprograms in
> hubble, but most of them are not called from tail called programs

We actually do this in some of the l7 parsers where we try to use
subprogs as much as possible but still use prog_array for calls
that might end up being recursive.

I'll think about it Monday my first thought is some refactoring and
using bpf_loop or other helpers could resolve this.

If its just bpf-next and not backported onto stable we can probably
figure something out.

> =

> jirka
> =

> > =

> > Other alternatives?
> > =

> =

