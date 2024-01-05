Return-Path: <bpf+bounces-19136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE8825949
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 18:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AD21F242BA
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B48321B5;
	Fri,  5 Jan 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdfeqZAo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A0328B7
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e3ab65709so5640705e9.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 09:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704476631; x=1705081431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95VdpUhA9MrNzncCSC+fHbqmAm/ZfAqnVD0xuy0EJ6I=;
        b=TdfeqZAoQ9ZbF80pji0LLfA8m4kTCoF6duvyanvwNqBdGMJ4rhS1/hAJWkuZ2kq1ob
         C+uQYqKCQoXoemsfsQyfi1Ki96nxrT6kHznC8cYEvrLRTLdBaQHKtPcxzFo8ZfR4iEzM
         KBw+QHndw6tK2G4DRdWmZXWQGoWeWfjy0pGUsD98Tq+LHytSXBVqndeqzefq6Yti/iP9
         73w7IcVe6eVssFyz5mcvkLLWGLPaSOjW86BmjE2cOIZEiD8dTcxNV385Pe1NT8wXDGCq
         2H6u1rs1RebkRrbvCC5vEgwVgUDzw+nB8YPpIISyqbpRHEETkB/rkZngx1iJrNaqEhRx
         iiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476631; x=1705081431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95VdpUhA9MrNzncCSC+fHbqmAm/ZfAqnVD0xuy0EJ6I=;
        b=R/WnYK+2cvwswt9uIG3NU4JJ561+49jy7rIEZvI/jJOTrOezzu88+MV6wISPANb+I6
         6TOxaBD3NR6FPEvHZZpP3GSnHAzNW0RYM9VLcONFRgDnf8ds8bKpujmNzLw8VpSYq/er
         Fo16agIlTdTW1hZ7NyzpArGNbQa0G4CMKiUt4OJbQqpgre1r0zJqO3wBVTTEj30aBcVr
         VPcGRSBjhcXxFIXw1p+J1+lwCbAFd5xrTKLsGkFuuu2DnqtIwIRLMYrDc7nhAaRXI8//
         bOkffE5lH8FEsmkADkwUPQ5I3nL2w86afDIwScpPmXzDOFElNf7vNfCSXtGUkdYgJvvn
         MQWg==
X-Gm-Message-State: AOJu0YxLZzdMI/nBBp0nMb7jRzGdaIQqltgy+9mPsdTgRntzCeUr5USQ
	vzQL5PplIn2OyDYBOsSD5kJUy1nMmdIvZL0jPCQ=
X-Google-Smtp-Source: AGHT+IE4lUMwYMiaYCUt+0eAI/e0A2l3j/v9AkXw6D0WXYap534tb/+6iQvQ6PyhpQQcHFgdfdXS03xfZz6XEF6LJlI=
X-Received: by 2002:a05:600c:243:b0:40b:5e59:cc9e with SMTP id
 3-20020a05600c024300b0040b5e59cc9emr1592566wmj.127.1704476630904; Fri, 05 Jan
 2024 09:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com> <43499e38-f395-4efd-867f-8a2fa0571ecd@gmail.com>
In-Reply-To: <43499e38-f395-4efd-867f-8a2fa0571ecd@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Jan 2024 09:43:39 -0800
Message-ID: <CAADnVQLhxem1m5Nfkf7GhDKRcYaD+g9k3ZW_BD6t58OACr3fQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:16=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 5/1/24 12:15, Alexei Starovoitov wrote:
> > On Thu, Jan 4, 2024 at 6:23=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com>=
 wrote:
> >>
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index fe30b9ebb8de4..67fa337fc2e0c 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -259,7 +259,7 @@ struct jit_context {
> >>  /* Number of bytes emit_patch() needs to generate instructions */
> >>  #define X86_PATCH_SIZE         5
> >>  /* Number of bytes that will be skipped on tailcall */
> >> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
> >> +#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
> >>
> >>  static void push_r12(u8 **pprog)
> >>  {
> >> @@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 stack_=
depth, bool ebpf_from_cbpf,
> >>          */
> >>         emit_nops(&prog, X86_PATCH_SIZE);
> >>         if (!ebpf_from_cbpf) {
> >> -               if (tail_call_reachable && !is_subprog)
> >> +               if (tail_call_reachable && !is_subprog) {
> >>                         /* When it's the entry of the whole tailcall c=
ontext,
> >>                          * zeroing rax means initialising tail_call_cn=
t.
> >>                          */
> >> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
> >> -               else
> >> -                       /* Keep the same instruction layout. */
> >> -                       EMIT2(0x66, 0x90); /* nop2 */
> >> +                       EMIT2(0x31, 0xC0);       /* xor eax, eax */
> >> +                       EMIT1(0x50);             /* push rax */
> >> +                       /* Make rax as ptr that points to tail_call_cn=
t. */
> >> +                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
> >> +                       EMIT1_off32(0xE8, 2);    /* call main prog */
> >> +                       EMIT1(0x59);             /* pop rcx, get rid o=
f tail_call_cnt */
> >> +                       EMIT1(0xC3);             /* ret */
> >> +               } else {
> >> +                       /* Keep the same instruction size. */
> >> +                       emit_nops(&prog, 13);
> >> +               }
> >
> > I'm afraid the extra call breaks stack unwinding and many other things.
>
> I was worried about it. But I'm not sure how it breaks stack unwinding.
>
> However, without the extra call, I've tried another approach:
>
> * [RFC PATCH bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
>   https://lore.kernel.org/bpf/20231005145814.83122-2-hffilwlqm@gmail.com/
>
> It's to propagate tail_call_cnt_ptr, too. But more complicated:
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8c10d9abc..001c5e4b7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -313,24 +332,15 @@ static void emit_prologue(u8 **pprog, u32 stack_dep=
th, bool ebpf_from_cbpf,
>                           bool tail_call_reachable, bool is_subprog,
>                           bool is_exception_cb)
>  {
> +       int tcc_ptr_off =3D round_up(stack_depth, 8) + 8;
> +       int tcc_off =3D tcc_ptr_off + 8;
>         u8 *prog =3D *pprog;
>
>         /* BPF trampoline can be made to work without these nops,
>          * but let's waste 5 bytes for now and optimize later
>          */
>         EMIT_ENDBR();
> -       memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
> -       prog +=3D X86_PATCH_SIZE;
> -       if (!ebpf_from_cbpf) {
> -               if (tail_call_reachable && !is_subprog)
> -                       /* When it's the entry of the whole tailcall cont=
ext,
> -                        * zeroing rax means initialising tail_call_cnt.
> -                        */
> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
> -               else
> -                       /* Keep the same instruction layout. */
> -                       EMIT2(0x66, 0x90); /* nop2 */
> -       }
> +       emit_nops(&prog, X86_PATCH_SIZE);
>         /* Exception callback receives FP as third parameter */
>         if (is_exception_cb) {
>                 EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
> @@ -347,15 +357,52 @@ static void emit_prologue(u8 **pprog, u32 stack_dep=
th, bool ebpf_from_cbpf,
>                 EMIT1(0x55);             /* push rbp */
>                 EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
>         }
> +       if (!ebpf_from_cbpf) {
> +               if (tail_call_reachable && !is_subprog) {
> +                       /* Make rax as ptr that points to tail_call_cnt. =
*/
> +                       EMIT3(0x48, 0x89, 0xE8);          /* mov rax, rbp=
 */
> +                       EMIT2_off32(0x48, 0x2D, tcc_off); /* sub rax, tcc=
_off */
> +                       /* When it's the entry of the whole tail call con=
text,
> +                        * storing 0 means initialising tail_call_cnt.
> +                        */
> +                       EMIT2_off32(0xC7, 0x00, 0);       /* mov dword pt=
r [rax], 0 */
> +               } else {
> +                       /* Keep the same instruction layout. */
> +                       emit_nops(&prog, 3);
> +                       emit_nops(&prog, 6);
> +                       emit_nops(&prog, 6);

Extra 15 nops in the prologue of every bpf program (tailcall or not)
is too high a price to pay.

Think of a simple fix other on verifier side or
simple approach that all JITs can easily do.

