Return-Path: <bpf+bounces-19108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C00824D98
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 05:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D28B230B4
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 04:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDDD46A1;
	Fri,  5 Jan 2024 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZggQXsCu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BA5228
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5d8a6730so10261425e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 20:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704428148; x=1705032948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyM74IVGEcKbzENuOTZSrX7LdiTYgGUOMDuD3w6eI2s=;
        b=ZggQXsCuDdaKUN6mo02MmKebQI2PLqY4ty8hrn5m8SlXKdV5vBj+mfDcR4k4CIfNCz
         9DJcQI6P7nFtRH8Jlg0RiYCy1lcteif4Gxe9UpcjurjHu5hfZqamFXr2cI41A0x282PO
         m7iQ0UA5C8wPAW7UBi9cqudZxxZpuivRuKbeiQKqZ+5XAm/x5K1ePs5jbDEU+bL/PkPV
         HRnMt2DMQD5n5blYapkXqWIom65k1rCrKHf+SPrx9dZEmt25+V1CGMaMZTeC+J1x6Nbp
         4Uw0KnLTgtEK5Wa9HAwnOBtjRPKO0QfEmcs535g+eQPEsNFS44N7K+qZe/LE79iWGuhn
         Fdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704428148; x=1705032948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyM74IVGEcKbzENuOTZSrX7LdiTYgGUOMDuD3w6eI2s=;
        b=mYvdwP6n7FzZ0NBa64zRBg9IPD7gwzgYHmLtwLnJ4kIOllATdyhl87c/9o07SDgrpt
         eSp9tGmj+46cLkaZdme4Y239NqV/stp/MhCpcieyUY+Cowuh2SJJCSpnR7csOsixtnvx
         hI4Vc4nI/HzC0S7jMiPzaZKBgDTuz3i0U3VDrZvQuRJLK+Io5tbS21e5ey0RGDklNMH5
         QisW4Wnxy4qYGkl70k+qrEE2aXeWFG1x7iID3dNQtsCg9nEdgqtArOdsP+beC7ARQ9xv
         HYeqvAkEYGw4by1PwpB5jS4K6TUKkotJGzczpJWzw3FjCqy08zUix3xetV/SoNNv/Cej
         3ZhQ==
X-Gm-Message-State: AOJu0Yyf8XpMaLyRfEzTLUa25XK18mPbnvzdipWMp9lN01U9jP3PJq18
	3xn6rRLm04gpX0ukr0gvNOR7AXCjlHFMeIP8WAyIGSwcs5M=
X-Google-Smtp-Source: AGHT+IFEmOqhzfbeyBNbjqmOftqeXME/bcqO15L40SpSXHrFZlTjrtSI8xMfZ8T5Ax3a8YC4Pw5DKroGSIt4MgcJ5PQ=
X-Received: by 2002:a05:600c:138d:b0:40d:88a8:21a0 with SMTP id
 u13-20020a05600c138d00b0040d88a821a0mr845344wmf.67.1704428147592; Thu, 04 Jan
 2024 20:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
In-Reply-To: <20240104142226.87869-3-hffilwlqm@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 20:15:36 -0800
Message-ID: <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:23=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index fe30b9ebb8de4..67fa337fc2e0c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -259,7 +259,7 @@ struct jit_context {
>  /* Number of bytes emit_patch() needs to generate instructions */
>  #define X86_PATCH_SIZE         5
>  /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
> +#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
>
>  static void push_r12(u8 **pprog)
>  {
> @@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 stack_dep=
th, bool ebpf_from_cbpf,
>          */
>         emit_nops(&prog, X86_PATCH_SIZE);
>         if (!ebpf_from_cbpf) {
> -               if (tail_call_reachable && !is_subprog)
> +               if (tail_call_reachable && !is_subprog) {
>                         /* When it's the entry of the whole tailcall cont=
ext,
>                          * zeroing rax means initialising tail_call_cnt.
>                          */
> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
> -               else
> -                       /* Keep the same instruction layout. */
> -                       EMIT2(0x66, 0x90); /* nop2 */
> +                       EMIT2(0x31, 0xC0);       /* xor eax, eax */
> +                       EMIT1(0x50);             /* push rax */
> +                       /* Make rax as ptr that points to tail_call_cnt. =
*/
> +                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
> +                       EMIT1_off32(0xE8, 2);    /* call main prog */
> +                       EMIT1(0x59);             /* pop rcx, get rid of t=
ail_call_cnt */
> +                       EMIT1(0xC3);             /* ret */
> +               } else {
> +                       /* Keep the same instruction size. */
> +                       emit_nops(&prog, 13);
> +               }

I'm afraid the extra call breaks stack unwinding and many other things.
The proper frame needs to be setup (push rbp; etc)
and 'leave' + emit_return() is used.
Plain 'ret' is not ok.
x86_call_depth_emit_accounting() needs to be used too.
That will make X86_TAIL_CALL_OFFSET adjustment very complicated.
Also the fix doesn't address the stack size issue.
We shouldn't allow all the extra frames at run-time.

The tail_cnt_ptr approach is interesting but too heavy,
since arm64, s390 and other JITs would need to repeat it with equally
complicated calculations in TAIL_CALL_OFFSET.

The fix should really be thought through for all JITs. Not just x86.

I'm thinking whether we should do the following instead:

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0bdbbbeab155..0b45571559be 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -910,7 +910,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
        if (IS_ERR(prog))
                return prog;

-       if (!bpf_prog_map_compatible(map, prog)) {
+       if (!bpf_prog_map_compatible(map, prog) || prog->aux->func_cnt) {
                bpf_prog_put(prog);
                return ERR_PTR(-EINVAL);
        }

This will stop stack growth, but it will break a few existing tests.
I feel it's a price worth paying.

John, Daniel,

do you see anything breaking on cilium side if we disallow
progs with subprogs to be inserted in prog_array ?

Other alternatives?

