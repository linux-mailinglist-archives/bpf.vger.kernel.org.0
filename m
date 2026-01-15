Return-Path: <bpf+bounces-79128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEFD280A7
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 652A9302E221
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A73BC4DC;
	Thu, 15 Jan 2026 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoyRHDKF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473C396B75
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503139; cv=none; b=FYrfqL+9K2sYr6nz5aKR+oUl7Ny7LwGH37ke8/PxBnvKkP2oNJuDUzRPnmxKz2o4fRkGVJP5pqweG0f9yPdf/hUcxLjoVJJWTbFgkQKxNWB9nU+1SoDLPr2DIjWFy6b4UjC6pa515U1hoo1jigC91PcF3SpuzIS0xHcwCFzdpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503139; c=relaxed/simple;
	bh=2Rd+T2fxxjOULfBFXLH5UIRvtWG8/G7q1lCPuJeByr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBsns1fMtt4sq46wxSyKqgV4M/ku86hmnxvgPcdDGkIGBSwig8rEaMdCM+ecmre8DF11okkr6cvHRYkZleKDjtrGyZA78VdJYJozOqJSxBzdhkxE4ZGYBapagIvLAaaBA/vhP2xDtSOdbLvuDI6QHaqomTKwpz8CxsmVF5Hkfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoyRHDKF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso981618a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503137; x=1769107937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD0n2wghIe+hwlFHDxEK9qHpYzp/XoQTH/HMSUPUjZc=;
        b=KoyRHDKFWEaz7VDX0iAPtNbdlfdOOQiudOkt5yX/eWexixakiQVh7iP+9x1hB/8ZZA
         4UbDI8BeaC4H5Uf2Q8WrIfb+Je6lqmUz+34cSPQlF5x4i/qxejJebo1G33UT5E2feYgH
         Myi1uZevgZsnfQMuvUbP23XcXIMNQzqxtVZaCdSwVRyzL/WtzH+xY9eIHIQl39HqInln
         XNno268/AfaRaoZehmgM+8J/HlLBO35aUelaiSRCc7ETRJYHekpxCNFKILHdq2RN5/W7
         /m2JRNSrzkSa6SiD+zB1yj7z6IMMeX7WtlxqZTgg0/+Ymo9w9mpFz93WaRQ1LmNfvB+1
         VzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503137; x=1769107937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tD0n2wghIe+hwlFHDxEK9qHpYzp/XoQTH/HMSUPUjZc=;
        b=j2NlJ+69JSBmlGf7ty4fCp6NX5/db+zq87JsjX3RK63xdNzrsDU6o27+sdP0Eh1FC7
         MXgrvWwV6FOhin3r+P92/8LT54/AsIVNhBEfnwiEYnX/wIu23OnLFSewueGY2HwbfRVZ
         HyKl53y5hy4+rVhu3/5uZ0yXOTwW8akiWCxgV7G6GW0wEyLBgcaTkANtDiPhGdp4xGEX
         CsHgHQenl9zyd26Mj2l4Cpwzs4G508mT2ow/VWpfNyQB01WL1NEd7hqwzW2j+tK0fJAB
         T5wFMoIZVrFIIuHQ/KXUur8XVGcuAV6K2fcnFVmZKdD7SznIUpWj0+1Hd6eVCsNgmkFu
         ktOA==
X-Forwarded-Encrypted: i=1; AJvYcCUliDB2igrCEtZ8yZSpW/t6nauZFe0gHxTC0vLO42P+fzRW+koiF+HLfqs/1JOiNZd2BP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiEMTqLtTYVIj7H12CzIhb1l9nju+byKseZ8hznx+HcWRecB9
	vu96DDh276M1eeZKAbk5FJO/qZuUjtmODP8A61ofsWpROws7Oc52NlJL8zH4BFqR4Xm5C/k+i79
	sZJkV5T8eXL5/j0oIf4TqliUwKELmlhzUcg==
X-Gm-Gg: AY/fxX6kmc+70XdBqXMluwKF9Sx5EsFwzxcD+mKge2SCmmOj5qnX02ydhu9URnFAXyy
	Bmnu9MnYHPdihyJz+VX7sHCVYO2JFBmrMhyZ0tPyCkhal7/WkV6iKHNRxU0qNJEJUKDPezoXKSe
	PiPGftrXyScuzvYr/E1i7wNrYH0r9xTxSHSKDuBsk7AcfJnW1Z6ZZHP4dI0G8J2awAvaME8LaER
	8BVuJPa9wpvFsxg2Jt7b0iq5psoblyGD40YgLXAaf/6FUm0AK3ZbNK+P4wiL52erX/cmvJwo06Q
	SkEpnZyA
X-Received: by 2002:a17:902:c407:b0:2a0:99f7:67b4 with SMTP id
 d9443c01a7336-2a71756c272mr4420715ad.8.1768503137511; Thu, 15 Jan 2026
 10:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112214940.1222115-1-jolsa@kernel.org> <20260112214940.1222115-3-jolsa@kernel.org>
 <20260112170757.4e41c0d8@gandalf.local.home> <aWYv6864cdO2PWbb@krava>
In-Reply-To: <aWYv6864cdO2PWbb@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 10:52:04 -0800
X-Gm-Features: AZwV_QjXO-yhEtC-_YSLoFVniP-2k2iYTwX1IjXIqEh7rIM5iZ-xHOytlXiEqcY
Message-ID: <CAEf4BzZ-sPD4UZF-TL2ep-zQOyeOC3K5XC2o3Gsx4Q6XpN-zQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi program
 stack unwind to hw_regs path
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mahe Tardy <mahe.tardy@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 3:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jan 12, 2026 at 05:07:57PM -0500, Steven Rostedt wrote:
> > On Mon, 12 Jan 2026 22:49:38 +0100
> > Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > > To recreate same stack setup for return probe as we have for entry
> > > probe, we set the instruction pointer to the attached function addres=
s,
> > > which gets us the same unwind setup and same stack trace.
> > >
> > > With the fix, entry probe:
> > >
> > >   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
> > >   Attaching 1 probe...
> > >
> > >         __x64_sys_newuname+9
> > >         do_syscall_64+134
> > >         entry_SYSCALL_64_after_hwframe+118
> > >
> > > return probe:
> > >
> > >   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
> > >   Attaching 1 probe...
> > >
> > >         __x64_sys_newuname+4
> > >         do_syscall_64+134
> > >         entry_SYSCALL_64_after_hwframe+118
> >
> > But is this really correct?
> >
> > The stack trace of the return from __x86_sys_newuname is from offset "+=
4".
> >
> > The stack trace from entry is offset "+9". Isn't it confusing that the
> > offset is likely not from the return portion of that function?
>
> right, makes sense.. so standard kprobe actualy skips attached function
> (__x86_sys_newuname) on return probe stacktrace.. perhaps we should do
> the same for kprobe_multi

but it is quite nice to see what function we were kretprobing,
actually... How hard would it be to support that for singular kprobe
as well? And what does fexit's stack trace show for such case?

>
> I managed to get that with the change below, but it's wrong wrt arch code=
,
> note the ftrace_regs_set_stack_pointer(fregs, stack + 8) .. will try to
> figure out better way when we agree on the solution
>
> thanks,
> jirka
>
>
> ---
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.=
h
> index c56e1e63b893..b0e8ce4934e7 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -71,6 +71,9 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  #define ftrace_regs_set_instruction_pointer(fregs, _ip)        \
>         do { arch_ftrace_regs(fregs)->regs.ip =3D (_ip); } while (0)
>
> +#define ftrace_regs_set_stack_pointer(fregs, _sp)      \
> +       do { arch_ftrace_regs(fregs)->regs.sp =3D (_sp); } while (0)
> +
>
>  static __always_inline unsigned long
>  ftrace_regs_get_return_address(struct ftrace_regs *fregs)
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 6279e0a753cf..b1510c412dcb 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -717,7 +717,8 @@ int function_graph_enter_regs(unsigned long ret, unsi=
gned long func,
>  /* Retrieve a function return address to the trace stack on thread info.=
*/
>  static struct ftrace_ret_stack *
>  ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *r=
et,
> -                       unsigned long frame_pointer, int *offset)
> +                       unsigned long *stack, unsigned long frame_pointer=
,
> +                       int *offset)
>  {
>         struct ftrace_ret_stack *ret_stack;
>
> @@ -762,6 +763,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trac=
e, unsigned long *ret,
>
>         *offset +=3D FGRAPH_FRAME_OFFSET;
>         *ret =3D ret_stack->ret;
> +       *stack =3D (unsigned long) ret_stack->retp;
>         trace->func =3D ret_stack->func;
>         trace->overrun =3D atomic_read(&current->trace_overrun);
>         trace->depth =3D current->curr_ret_depth;
> @@ -810,12 +812,13 @@ __ftrace_return_to_handler(struct ftrace_regs *freg=
s, unsigned long frame_pointe
>         struct ftrace_ret_stack *ret_stack;
>         struct ftrace_graph_ret trace;
>         unsigned long bitmap;
> +       unsigned long stack;
>         unsigned long ret;
>         int offset;
>         int bit;
>         int i;
>
> -       ret_stack =3D ftrace_pop_return_trace(&trace, &ret, frame_pointer=
, &offset);
> +       ret_stack =3D ftrace_pop_return_trace(&trace, &ret, &stack, frame=
_pointer, &offset);
>
>         if (unlikely(!ret_stack)) {
>                 ftrace_graph_stop();
> @@ -824,8 +827,11 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs=
, unsigned long frame_pointe
>                 return (unsigned long)panic;
>         }
>
> -       if (fregs)
> -               ftrace_regs_set_instruction_pointer(fregs, trace.func);
> +       if (fregs) {
> +               ftrace_regs_set_instruction_pointer(fregs, ret);
> +               ftrace_regs_set_stack_pointer(fregs, stack + 8);
> +       }
> +
>
>         bit =3D ftrace_test_recursion_trylock(trace.func, ret);
>         /*
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/to=
ols/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> index e1a9b55e07cb..852830536109 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> @@ -74,12 +74,20 @@ static void test_stacktrace_ips_kprobe_multi(bool ret=
probe)
>
>         load_kallsyms();
>
> -       check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss-=
>stack_key, 5,
> -                            ksym_get_addr("bpf_testmod_stacktrace_test")=
,
> -                            ksym_get_addr("bpf_testmod_stacktrace_test_3=
"),
> -                            ksym_get_addr("bpf_testmod_stacktrace_test_2=
"),
> -                            ksym_get_addr("bpf_testmod_stacktrace_test_1=
"),
> -                            ksym_get_addr("bpf_testmod_test_read"));
> +       if (retprobe) {
> +               check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), sk=
el->bss->stack_key, 4,
> +                                    ksym_get_addr("bpf_testmod_stacktrac=
e_test_3"),
> +                                    ksym_get_addr("bpf_testmod_stacktrac=
e_test_2"),
> +                                    ksym_get_addr("bpf_testmod_stacktrac=
e_test_1"),
> +                                    ksym_get_addr("bpf_testmod_test_read=
"));
> +       } else {
> +               check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), sk=
el->bss->stack_key, 5,
> +                                    ksym_get_addr("bpf_testmod_stacktrac=
e_test"),
> +                                    ksym_get_addr("bpf_testmod_stacktrac=
e_test_3"),
> +                                    ksym_get_addr("bpf_testmod_stacktrac=
e_test_2"),
> +                                    ksym_get_addr("bpf_testmod_stacktrac=
e_test_1"),
> +                                    ksym_get_addr("bpf_testmod_test_read=
"));
> +       }
>
>  cleanup:
>         stacktrace_ips__destroy(skel);

