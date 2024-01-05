Return-Path: <bpf+bounces-19123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1EE825366
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 13:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C4A1C23031
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9102C6A7;
	Fri,  5 Jan 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKiggGu/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A662C866
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd37c0b8e5so1590331fa.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704458428; x=1705063228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9xylIBBAQXzAFQAicy5nw4p6iD5j3rKJwt/VNt0O4o=;
        b=kKiggGu/eeg5C6/r9ff/aR9M0zc7Gaf56GneG0QTf/B29qHVqyx7Y1Mmv3sgwQLm25
         kzin95X4WyEiuWrMICewSb1YIDS6dBz2eqSnFwtVFjzn4Q2KjRKKb9YMj4LHC63d3pjH
         MghCp9nrOgLMWZjKSQt6OGVNwFJkN9p3oKEsa03s8aKoCqtzU3WAfqyV8qbOyC4GKGTI
         0fkHedJqIc+5vmmVEvuVEewCaGtNSxIU7fjhSG4Co4OvL+jIuEAhua9ccVnBxuNTyREg
         busGbY/LT3b/I9ju/4mEYwZ9FoxdAGELRU8tjo5sViRcQ3bEmNIgxHoXMRZg+D2WbwcD
         ZhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704458428; x=1705063228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9xylIBBAQXzAFQAicy5nw4p6iD5j3rKJwt/VNt0O4o=;
        b=Z8yg2t+Xzj5IGY2CV5Bs5nYy9IfoLFibtktwKQl+FwGIjDbO1StNBsL3u1ao/ACZls
         bjwqWFWFRNHWtBZUUJFbGkUC9Ic7Nwy+bQnoVLA5X+lgEAJsFNvshf9oZjF++k44sBtC
         wbeiOE8pbwcxp4QSo/74OCKbiJW5i+iKPjAHe0PaWGD4r7UXeAf1+nCa6CwD5kpJsy/5
         UlUQrEzDKe1SiVdH+PkprROt7O1Hnm2eZ1XGSMrVbEfeyPmMOr1TK+5yGzaB18lyC8rG
         DnZO7HUog1j/R7b3A2CBdFQVXBrIQl1MNcHrTTbK/DLbBvwc+5OWSVvJk8Rsi1/TxWtY
         Uyww==
X-Gm-Message-State: AOJu0YwfdQrgJJWL1VeJf1Um6n4Se3NyMAg7ODmRCCuUhOc5Zjt8BO8f
	wt4wyaMkIVDYJL9pp1pEttA=
X-Google-Smtp-Source: AGHT+IGj/m0KdG396Q9BYFRZktCXcQo4IsSUVfMPxFi/WW4BkdOrGiZysD+WSxvlrvajaLnQ6/N9lA==
X-Received: by 2002:a19:ae1a:0:b0:50e:7f5e:59b with SMTP id f26-20020a19ae1a000000b0050e7f5e059bmr985351lfc.60.1704458428022;
        Fri, 05 Jan 2024 04:40:28 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906724800b00a26a5f83cecsm841630ejk.79.2024.01.05.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 04:40:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Jan 2024 13:40:25 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Message-ID: <ZZf4uXuSvFq1JwU1@krava>
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
 <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>

On Thu, Jan 04, 2024 at 08:15:36PM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 4, 2024 at 6:23 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
> >
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index fe30b9ebb8de4..67fa337fc2e0c 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -259,7 +259,7 @@ struct jit_context {
> >  /* Number of bytes emit_patch() needs to generate instructions */
> >  #define X86_PATCH_SIZE         5
> >  /* Number of bytes that will be skipped on tailcall */
> > -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
> > +#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
> >
> >  static void push_r12(u8 **pprog)
> >  {
> > @@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
> >          */
> >         emit_nops(&prog, X86_PATCH_SIZE);
> >         if (!ebpf_from_cbpf) {
> > -               if (tail_call_reachable && !is_subprog)
> > +               if (tail_call_reachable && !is_subprog) {
> >                         /* When it's the entry of the whole tailcall context,
> >                          * zeroing rax means initialising tail_call_cnt.
> >                          */
> > -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
> > -               else
> > -                       /* Keep the same instruction layout. */
> > -                       EMIT2(0x66, 0x90); /* nop2 */
> > +                       EMIT2(0x31, 0xC0);       /* xor eax, eax */
> > +                       EMIT1(0x50);             /* push rax */
> > +                       /* Make rax as ptr that points to tail_call_cnt. */
> > +                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
> > +                       EMIT1_off32(0xE8, 2);    /* call main prog */
> > +                       EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
> > +                       EMIT1(0xC3);             /* ret */
> > +               } else {
> > +                       /* Keep the same instruction size. */
> > +                       emit_nops(&prog, 13);
> > +               }
> 
> I'm afraid the extra call breaks stack unwinding and many other things.
> The proper frame needs to be setup (push rbp; etc)
> and 'leave' + emit_return() is used.
> Plain 'ret' is not ok.
> x86_call_depth_emit_accounting() needs to be used too.
> That will make X86_TAIL_CALL_OFFSET adjustment very complicated.
> Also the fix doesn't address the stack size issue.
> We shouldn't allow all the extra frames at run-time.
> 
> The tail_cnt_ptr approach is interesting but too heavy,
> since arm64, s390 and other JITs would need to repeat it with equally
> complicated calculations in TAIL_CALL_OFFSET.
> 
> The fix should really be thought through for all JITs. Not just x86.
> 
> I'm thinking whether we should do the following instead:
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 0bdbbbeab155..0b45571559be 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -910,7 +910,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
>         if (IS_ERR(prog))
>                 return prog;
> 
> -       if (!bpf_prog_map_compatible(map, prog)) {
> +       if (!bpf_prog_map_compatible(map, prog) || prog->aux->func_cnt) {
>                 bpf_prog_put(prog);
>                 return ERR_PTR(-EINVAL);
>         }
> 
> This will stop stack growth, but it will break a few existing tests.
> I feel it's a price worth paying.
> 
> John, Daniel,
> 
> do you see anything breaking on cilium side if we disallow
> progs with subprogs to be inserted in prog_array ?

FWIW tetragon should be ok with this.. we use few subprograms in
hubble, but most of them are not called from tail called programs

jirka

> 
> Other alternatives?
> 

