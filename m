Return-Path: <bpf+bounces-52936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F33A4A696
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186D03B3261
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661BD1DF24D;
	Fri, 28 Feb 2025 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8P2l9Sx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451C1C5F18;
	Fri, 28 Feb 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785235; cv=none; b=mNJjaGf7nTGGb2lZgRVTMp74RUF7e1ccEgkm07cZ1M5Z9nPwk3u854+xwbeSf3MX1UdBGdQHIm9IL8PmK0/NYT2uYqCWyklHpSCxi98lEAQEV3N3yoOGLZ60OWMJdjsLqcrG5B7b0k1qEYjAPpO2keni91A1Xa45+ZNLRY29UJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785235; c=relaxed/simple;
	bh=KLaArApG8YyqszE7x4uMZYpATrK09gOkaqlY1CGh5Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9dxHXAqLLsUyvuocBFrK20om1KvIvGQxuQqxyJoU/Q4rFWn0v8/uKAStLEV/+8yZNGuZcgz1Lm7pBgCvnSg3fJYqwT/Hlie8vbEa8euQtXm8wet3RPlO/uoxhviH3aR6MtjAts6MugC7OCB5esAeUGAOnPBVNffkyxKRMdAHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8P2l9Sx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feaca4e99cso3621760a91.0;
        Fri, 28 Feb 2025 15:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740785232; x=1741390032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIKoqp4Ccf65DVrm3735G6n4LP3UGrdX5Chji1OGQRk=;
        b=f8P2l9SxbwGXGzaWLP8Ji9ydp4cJd0s9oJk8sGvwEoP54cpUF5gLMUdU8GQG1el+V/
         F8abx9om4DbCWNI+QtfiuVGOwvU/FLCgjYZvq6qBvCaqpSmtS/siQaDa+JsVp1CHJoA5
         me1k7RthlbHnS5eYDfZrke8EvOQeYLe/JFmMtV99kDWXfnZW/lHYsOpXjnM+jq/sOn2m
         HLflmXBhr6s7gOeI85cge32pT1dm0+YOUv8Z2dlBadVXvHuW/v+JKITqYOMaBjPNzouF
         TkH4HHG6yaJ4UWl3psIQx1Nnb+lXol9Qa2B64qb9hRln5aBHIG3cMDjItHkTdaNJ0HhK
         /q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740785232; x=1741390032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIKoqp4Ccf65DVrm3735G6n4LP3UGrdX5Chji1OGQRk=;
        b=N9g2+NPH4C0sNfHg5TbgW4YnMP25BzU4Rln6YKJ4UyeaG7Kxbbg9Vyt3rkVI7/HqiZ
         5uPoVIC5lNaCsQOccritaSWgjFuAX48Gv0E8Br2Ik65lhh8fjjCciCQ5CVlbbK1U/WQd
         dZSt5Mvv0nc3GyHpaCFKiiHEuK/Xso5d3ZwWCY9g6uchFD+zrmiBwcnPN2/OLs0aZYxJ
         XLfpZlBmFKYkCspCCC+4BCqEDxp0m//bHYU45JZXEdNRQ/wzqWwXvE3jPhoEJazu+Bfb
         MTaTkwHJ23+DBWcrVmNgYR8CKqJeqcs8ubEt3nPII8NbqTD2UahyPOTDi/rcOecbpAyH
         zHEw==
X-Forwarded-Encrypted: i=1; AJvYcCUwQxZPrei7jvQHEA1i1dFOaiwgz91i7msc2yN/VeSlJB0pBmzFnhuc/F26+8+MgcRjKECIASe9z160YrJl@vger.kernel.org, AJvYcCV0/ZBy/OdT0WuBsTQjYJtA8GkG2jZx80lBgPgO0FcGa6k85RkDwydiNGsPrMbQRFLEuZE=@vger.kernel.org, AJvYcCWnFxuWn+Cc0QLPzdvIwoRdEzBjht0apXoS14nD2vyAY2tVRijONPykGHzVG6oe28MS7gU3k8vwZkQTQTrrLs5y8KN7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgl9gPAGeOeRKcLqhAyLtVsUQ1HCLV+YA6fy6t5iAIoJCKCfLE
	0eODMYmES/mSZao92eInO0/zwXnZ0DRFJPUUldNZLZChoxOCMRLhVrhbzJhajzty6kQYsRvF36S
	ZGTwup+qAZpN8yMg8fuLmoSKyUcirlCbq
X-Gm-Gg: ASbGncv0zR9K92hvOw8NwcRnJMA1/KwihYiGtl0ie1J3xrLMODUX6t5987mb0lyZ5Ta
	wwNTFBAiIptymyqV94OG0jCxccjJChnlK1yOIRnfAS0MAIY/jzHHyxZYOHw7FS1wqS6S/zY9YZx
	HJ9Y3NuxacW4OkQUYCh29yd8YO5Avi9oL2nWUD+PXdqQ==
X-Google-Smtp-Source: AGHT+IH3pyk26MG+ndbFBtg0GuL4tEucubm0zc4+97/0l5h5AdxGxHLvC+lmQSTMZ37Hx2sMpX5Fcadv8hQymXGVneE=
X-Received: by 2002:a17:90b:3c02:b0:2fe:b8ba:62e1 with SMTP id
 98e67ed59e1d1-2febabf41afmr7845187a91.28.1740785232376; Fri, 28 Feb 2025
 15:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224140151.667679-1-jolsa@kernel.org> <20250224140151.667679-13-jolsa@kernel.org>
 <CAEf4BzbE1dhqZWpLYhZFo7cuuK04t9iM+1ykHA5_PbM_xdb1PQ@mail.gmail.com>
 <Z8I-24x1FHoBOQ6N@krava> <CAEf4BzbxLMB8RJWWZjtg6NkumHHZA=vhWZfHqZBf90O=aJVC+A@mail.gmail.com>
 <Z8JEPdAHkkEL4x7k@krava>
In-Reply-To: <Z8JEPdAHkkEL4x7k@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 15:27:00 -0800
X-Gm-Features: AQ5f1JrZlfpg64Y02X8g7nOluvzmcOJNpfIgBeVXVfGgKTZspN-KznMkcofpsuk
Message-ID: <CAEf4BzYbiPqdbOSKEkNZH=KKig+D5bhtn363+R2ixeVnyO_OVA@mail.gmail.com>
Subject: Re: [PATCH RFCv2 12/18] uprobes/x86: Add support to optimize uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:18=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Feb 28, 2025 at 03:00:22PM -0800, Andrii Nakryiko wrote:
> > On Fri, Feb 28, 2025 at 2:55=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Fri, Feb 28, 2025 at 10:55:24AM -0800, Andrii Nakryiko wrote:
> > > > On Mon, Feb 24, 2025 at 6:04=E2=80=AFAM Jiri Olsa <jolsa@kernel.org=
> wrote:
> > > > >
> > > > > Putting together all the previously added pieces to support optim=
ized
> > > > > uprobes on top of 5-byte nop instruction.
> > > > >
> > > > > The current uprobe execution goes through following:
> > > > >   - installs breakpoint instruction over original instruction
> > > > >   - exception handler hit and calls related uprobe consumers
> > > > >   - and either simulates original instruction or does out of line=
 single step
> > > > >     execution of it
> > > > >   - returns to user space
> > > > >
> > > > > The optimized uprobe path
> > > > >
> > > > >   - checks the original instruction is 5-byte nop (plus other che=
cks)
> > > > >   - adds (or uses existing) user space trampoline and overwrites =
original
> > > > >     instruction (5-byte nop) with call to user space trampoline
> > > > >   - the user space trampoline executes uprobe syscall that calls =
related uprobe
> > > > >     consumers
> > > > >   - trampoline returns back to next instruction
> > > > >
> > > > > This approach won't speed up all uprobes as it's limited to using=
 nop5 as
> > > > > original instruction, but we could use nop5 as USDT probe instruc=
tion (which
> > > > > uses single byte nop ATM) and speed up the USDT probes.
> > > > >
> > > > > This patch overloads related arch functions in uprobe_write_opcod=
e and
> > > > > set_orig_insn so they can install call instruction if needed.
> > > > >
> > > > > The arch_uprobe_optimize triggers the uprobe optimization and is =
called after
> > > > > first uprobe hit. I originally had it called on uprobe installati=
on but then
> > > > > it clashed with elf loader, because the user space trampoline was=
 added in a
> > > > > place where loader might need to put elf segments, so I decided t=
o do it after
> > > > > first uprobe hit when loading is done.
> > > > >
> > > > > We do not unmap and release uprobe trampoline when it's no longer=
 needed,
> > > > > because there's no easy way to make sure none of the threads is s=
till
> > > > > inside the trampoline. But we do not waste memory, because there'=
s just
> > > > > single page for all the uprobe trampoline mappings.
> > > > >
> > > > > We do waste frmae on page mapping for every 4GB by keeping the up=
robe
> > > > > trampoline page mapped, but that seems ok.
> > > > >
> > > > > Attaching the speed up from benchs/run_bench_uprobes.sh script:
> > > > >
> > > > > current:
> > > > >         usermode-count :  818.836 =C2=B1 2.842M/s
> > > > >         syscall-count  :    8.917 =C2=B1 0.003M/s
> > > > >         uprobe-nop     :    3.056 =C2=B1 0.013M/s
> > > > >         uprobe-push    :    2.903 =C2=B1 0.002M/s
> > > > >         uprobe-ret     :    1.533 =C2=B1 0.001M/s
> > > > > -->     uprobe-nop5    :    1.492 =C2=B1 0.000M/s
> > > > >         uretprobe-nop  :    1.783 =C2=B1 0.000M/s
> > > > >         uretprobe-push :    1.672 =C2=B1 0.001M/s
> > > > >         uretprobe-ret  :    1.067 =C2=B1 0.002M/s
> > > > > -->     uretprobe-nop5 :    1.052 =C2=B1 0.000M/s
> > > > >
> > > > > after the change:
> > > > >
> > > > >         usermode-count :  818.386 =C2=B1 1.886M/s
> > > > >         syscall-count  :    8.923 =C2=B1 0.003M/s
> > > > >         uprobe-nop     :    3.086 =C2=B1 0.005M/s
> > > > >         uprobe-push    :    2.751 =C2=B1 0.001M/s
> > > > >         uprobe-ret     :    1.481 =C2=B1 0.000M/s
> > > > > -->     uprobe-nop5    :    4.016 =C2=B1 0.002M/s
> > > > >         uretprobe-nop  :    1.712 =C2=B1 0.008M/s
> > > > >         uretprobe-push :    1.616 =C2=B1 0.001M/s
> > > > >         uretprobe-ret  :    1.052 =C2=B1 0.000M/s
> > > > > -->     uretprobe-nop5 :    2.015 =C2=B1 0.000M/s
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  arch/x86/include/asm/uprobes.h |   6 ++
> > > > >  arch/x86/kernel/uprobes.c      | 191 +++++++++++++++++++++++++++=
+++++-
> > > > >  include/linux/uprobes.h        |   6 +-
> > > > >  kernel/events/uprobes.c        |  16 ++-
> > > > >  4 files changed, 209 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/as=
m/uprobes.h
> > > > > index 678fb546f0a7..7d4df920bb59 100644
> > > > > --- a/arch/x86/include/asm/uprobes.h
> > > > > +++ b/arch/x86/include/asm/uprobes.h
> > > > > @@ -20,6 +20,10 @@ typedef u8 uprobe_opcode_t;
> > > > >  #define UPROBE_SWBP_INSN               0xcc
> > > > >  #define UPROBE_SWBP_INSN_SIZE             1
> > > > >
> > > > > +enum {
> > > > > +       ARCH_UPROBE_FLAG_CAN_OPTIMIZE   =3D 0,
> > > > > +};
> > > > > +
> > > > >  struct uprobe_xol_ops;
> > > > >
> > > > >  struct arch_uprobe {
> > > > > @@ -45,6 +49,8 @@ struct arch_uprobe {
> > > > >                         u8      ilen;
> > > > >                 }                       push;
> > > > >         };
> > > > > +
> > > > > +       unsigned long flags;
> > > > >  };
> > > > >
> > > > >  struct arch_uprobe_task {
> > > > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.=
c
> > > > > index e8aebbda83bc..73ddff823904 100644
> > > > > --- a/arch/x86/kernel/uprobes.c
> > > > > +++ b/arch/x86/kernel/uprobes.c
> > > > > @@ -18,6 +18,7 @@
> > > > >  #include <asm/processor.h>
> > > > >  #include <asm/insn.h>
> > > > >  #include <asm/mmu_context.h>
> > > > > +#include <asm/nops.h>
> > > > >
> > > > >  /* Post-execution fixups. */
> > > > >
> > > > > @@ -768,7 +769,7 @@ static struct uprobe_trampoline *create_uprob=
e_trampoline(unsigned long vaddr)
> > > > >         return NULL;
> > > > >  }
> > > > >
> > > > > -static __maybe_unused struct uprobe_trampoline *uprobe_trampolin=
e_get(unsigned long vaddr)
> > > > > +static struct uprobe_trampoline *uprobe_trampoline_get(unsigned =
long vaddr)
> > > > >  {
> > > > >         struct uprobes_state *state =3D &current->mm->uprobes_sta=
te;
> > > > >         struct uprobe_trampoline *tramp =3D NULL;
> > > > > @@ -794,7 +795,7 @@ static void destroy_uprobe_trampoline(struct =
uprobe_trampoline *tramp)
> > > > >         kfree(tramp);
> > > > >  }
> > > > >
> > > > > -static __maybe_unused void uprobe_trampoline_put(struct uprobe_t=
rampoline *tramp)
> > > > > +static void uprobe_trampoline_put(struct uprobe_trampoline *tram=
p)
> > > > >  {
> > > > >         if (tramp =3D=3D NULL)
> > > > >                 return;
> > > > > @@ -807,6 +808,7 @@ struct mm_uprobe {
> > > > >         struct rb_node rb_node;
> > > > >         unsigned long auprobe;
> > > > >         unsigned long vaddr;
> > > > > +       bool optimized;
> > > > >  };
> > > > >
> > > >
> > > > I'm trying to understand if this RB-tree based mm_uprobe is strictl=
y
> > > > necessary. Is it? Sure we keep optimized flag, but that's more for
> > > > defensive checks, no? Is there any other reason we need this separa=
te
> > > > look up data structure?
> > >
> > > so the call instruction update is done in 2 locked steps:
> > >  - first we write breakpoint as part of normal uprobe registration
> > >  - then uprobe is hit, we overwrite breakpoint with call instruction
> > >
> > > in between we could race with another thread that could either unregi=
ster the
> > > uprobe or try to optimize the uprobe as well
> > >
> > > I think we either need to keep the state of the uprobe per process (m=
m_struct),
> > > or we would need to read the probed instruction each time when we nee=
d to make
> > > decision based on what state are we at (nop5,breakpoint,call)
> >
> > This decision is only done in "slow path", right? Only when
> > registering/unregistering. And those operations are done under lock.
> > So reading those 5 bytes every time we register/unregister seems
> > completely acceptable, rather than now *also* having a per-mm uprobe
> > lookup tree.
>
> true.. I was also thinking about having another flag in that tree for
> when we fail to optimize the uprobe for other reason than it being on
> page alignment.. without such flag we'd need to read the 5 bytes each
> time we hit that uprobe .. but that might be rare case

that's another problematic part, IMO, that we'll be doing an upgrade
from int3 to call (for nop5) when uprobe is actually hit. So now you
need to do this mm_uprobe looking in the hot path, right? We spent
tons of effort to optimize the hot path and now we'll be adding
another lookup there :(

but I also don't have an alternative... I was thinking how do we
choose [vdso] address and whether we can use similar approach for
[uprobe-trampoline], but [vdso] doesn't have the constraint of being
within +/-2GB range, so that probably won't work.

anyways, just a bit unfortunate


P.S. Maybe we should keep the flag whether we tried to optimize (and
failed) in global uprobe information, not per-mm? I.e., if we failed
to find place for uprobe trampoline for any mm, no subsequent ones
would try this? It's likely that either all or none of processes will
fail/succeed nop5 optimization, right?

>
> jirka

