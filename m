Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0263A6C
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfGISCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 14:02:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38221 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfGISCy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jul 2019 14:02:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so20459889ljg.5;
        Tue, 09 Jul 2019 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9R0OFCUL3jMQABVdwSMXWLYp20n1lUt8oNSbrQL6kM=;
        b=LLKg8zsIA8LoxKo96qzf1ltd7oFHbAEMTv7sEzYlSUfxvJhWHa5kNcnFprPNsJSyFk
         MAla6ZNU7L6FPV0o0NwCiJxVTIeBi9F97Cw0D4PbDLsrOa38sMh3XGRCslhfI7L4l8aT
         r5zhgmBQUj2L4FHou33rW3C23oeMfHlKugXRSx/L6q/SQQiRopmb3Lx+gerH9xFATKp5
         v02WgvmqKuVNyUdkxakNxbV7si+wiiF7L1u5sXik5M5eGAJcl6+4tgAHWb+QZBJjKH8B
         TNXFbfuE/gnFXhJHje4fcL5OqkmWdVovl12y6ZYfyf7OkGb7kvMX/Twou4xK5CEReCUm
         3GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9R0OFCUL3jMQABVdwSMXWLYp20n1lUt8oNSbrQL6kM=;
        b=W6ejJJkTKnuIHIpMxKTFxLh8s/MITZHhsShDTcZ2bOG+V/PBml0ZwZFwzvyrwZab/z
         PiZeLuO5JUnV6b0GwDV20hnGj14O+q5tF/1e9a7a+gZYJFFyVZfsVScNZpFLjIvLTTGe
         a8ovzG29JCrAT0OBbRB68ZEHjH32X7L8I3KCC40AZsyl23hjbwnhcqrjxmAPWt3fYji/
         ouS2vDv7rfsJt1XvnyjuL2pRbM4pvDU+/hImmyDm/1FcN2YTj6clKSWPhE700dXfnjH9
         nl0jlgTnfK5DeZ5KQpf09n4ChrPlICC0PvuUdijRf8CYzkgHwlpdEqsh4fUhR4+ACjZo
         vi4A==
X-Gm-Message-State: APjAAAW+Dnfj5mrIgG2clyrq3WXjfcXnpUblUkPpeKU4yDy59OF9tp5j
        7E6JQH3wYzmzO3f1U5a0iMzMc+wobcE3R9qf5ZI=
X-Google-Smtp-Source: APXvYqzr2uFkaqKlsoNwGNU7LSd8YW4kpX7SYjqvh7+7Anv8Q4YNjZL8knxebPlanpW4K1W1kulGTHw5sqh5AeLX2xc=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr14115937lje.214.1562695372462;
 Tue, 09 Jul 2019 11:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com> <20190707013206.don22x3tfldec4zm@treble>
 <20190707055209.xqyopsnxfurhrkxw@treble> <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
 <20190708223834.zx7u45a4uuu2yyol@treble> <CAADnVQKWDvzsvyjGoFvSQV7VGr2hF2zzCsC9vnpncWMxOJWYdw@mail.gmail.com>
 <20190708225359.ewk44pvrv6a4oao7@treble> <20190708230201.mol27wzansuy3n2v@treble>
 <CAADnVQ+imsK-reGBiSzY02e+KdyGYZxm1su7T1bWvti=YmSV-Q@mail.gmail.com> <20190709174744.dtbjm72cbu5fepar@treble>
In-Reply-To: <20190709174744.dtbjm72cbu5fepar@treble>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Jul 2019 11:02:40 -0700
Message-ID: <CAADnVQJ+iCZ8g38XJkOiawS=p1mZU5XBqaBWc8_zCKVe8hMxTQ@mail.gmail.com>
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kairui Song <kasong@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 9, 2019 at 10:48 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Jul 08, 2019 at 04:16:25PM -0700, Alexei Starovoitov wrote:
> > total time is hard to compare.
> > Could you compare few tests?
> > like two that are called "tcpdump *"
> >
> > I think small regression is ok.
> > Folks that care about performance should be using JIT.
>
> I did each test 20 times and computed the averages:
>
> "tcpdump port 22":
>  default:       0.00743175s
>  -fno-gcse:     0.00709920s (~4.5% speedup)
>
> "tcpdump complex":
>  default:       0.00876715s
>  -fno-gcse:     0.00854895s (~2.5% speedup)
>
> So there does seem to be a small performance gain by disabling this
> optimization.

great. thanks for checking.

> We could change it for the whole file, by adjusting CFLAGS_core.o in the
> BPF makefile, or we could change it for the function only with something
> like the below patch.
>
> Thoughts?
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index e8579412ad21..d7ee4c6bad48 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -170,3 +170,5 @@
>  #else
>  #define __diag_GCC_8(s)
>  #endif
> +
> +#define __no_fgcse __attribute__((optimize("-fno-gcse")))
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 095d55c3834d..599c27b56c29 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -189,6 +189,10 @@ struct ftrace_likely_data {
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
>
> +#ifndef __no_fgcse
> +# define __no_fgcse
> +#endif
> +
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7e98f36a14e2..8191a7db2777 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1295,7 +1295,7 @@ bool bpf_opcode_in_insntable(u8 code)
>   *
>   * Decode and execute eBPF instructions.
>   */
> -static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> +static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)

I prefer per-function flag.
If you want to route it via tip:
Acked-by: Alexei Starovoitov <ast@kerrnel.org>

or Daniel can take it into bpf tree while I'm traveling.
