Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0792663BC9
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGITR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 15:17:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfGITR4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jul 2019 15:17:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A952E30821AE;
        Tue,  9 Jul 2019 19:17:55 +0000 (UTC)
Received: from treble (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CFD15F9A6;
        Tue,  9 Jul 2019 19:17:53 +0000 (UTC)
Date:   Tue, 9 Jul 2019 14:17:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kairui Song <kasong@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
Message-ID: <20190709191751.24eq5zx2c7hoqot6@treble>
References: <20190707013206.don22x3tfldec4zm@treble>
 <20190707055209.xqyopsnxfurhrkxw@treble>
 <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
 <20190708223834.zx7u45a4uuu2yyol@treble>
 <CAADnVQKWDvzsvyjGoFvSQV7VGr2hF2zzCsC9vnpncWMxOJWYdw@mail.gmail.com>
 <20190708225359.ewk44pvrv6a4oao7@treble>
 <20190708230201.mol27wzansuy3n2v@treble>
 <CAADnVQ+imsK-reGBiSzY02e+KdyGYZxm1su7T1bWvti=YmSV-Q@mail.gmail.com>
 <20190709174744.dtbjm72cbu5fepar@treble>
 <CAADnVQJ+iCZ8g38XJkOiawS=p1mZU5XBqaBWc8_zCKVe8hMxTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJ+iCZ8g38XJkOiawS=p1mZU5XBqaBWc8_zCKVe8hMxTQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 09 Jul 2019 19:17:55 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 09, 2019 at 11:02:40AM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 9, 2019 at 10:48 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Mon, Jul 08, 2019 at 04:16:25PM -0700, Alexei Starovoitov wrote:
> > > total time is hard to compare.
> > > Could you compare few tests?
> > > like two that are called "tcpdump *"
> > >
> > > I think small regression is ok.
> > > Folks that care about performance should be using JIT.
> >
> > I did each test 20 times and computed the averages:
> >
> > "tcpdump port 22":
> >  default:       0.00743175s
> >  -fno-gcse:     0.00709920s (~4.5% speedup)
> >
> > "tcpdump complex":
> >  default:       0.00876715s
> >  -fno-gcse:     0.00854895s (~2.5% speedup)
> >
> > So there does seem to be a small performance gain by disabling this
> > optimization.
> 
> great. thanks for checking.
> 
> > We could change it for the whole file, by adjusting CFLAGS_core.o in the
> > BPF makefile, or we could change it for the function only with something
> > like the below patch.
> >
> > Thoughts?
> >
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index e8579412ad21..d7ee4c6bad48 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -170,3 +170,5 @@
> >  #else
> >  #define __diag_GCC_8(s)
> >  #endif
> > +
> > +#define __no_fgcse __attribute__((optimize("-fno-gcse")))
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 095d55c3834d..599c27b56c29 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -189,6 +189,10 @@ struct ftrace_likely_data {
> >  #define asm_volatile_goto(x...) asm goto(x)
> >  #endif
> >
> > +#ifndef __no_fgcse
> > +# define __no_fgcse
> > +#endif
> > +
> >  /* Are two types/vars the same type (ignoring qualifiers)? */
> >  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 7e98f36a14e2..8191a7db2777 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1295,7 +1295,7 @@ bool bpf_opcode_in_insntable(u8 code)
> >   *
> >   * Decode and execute eBPF instructions.
> >   */
> > -static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> > +static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> 
> I prefer per-function flag.
> If you want to route it via tip:
> Acked-by: Alexei Starovoitov <ast@kerrnel.org>
> 
> or Daniel can take it into bpf tree while I'm traveling.

Thanks!  I''ll probably send it through the tip tree, along with an
objtool fix for the other optimization.

-- 
Josh
