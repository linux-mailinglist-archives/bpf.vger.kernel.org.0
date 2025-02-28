Return-Path: <bpf+bounces-52927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE30A4A64E
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A4A16C256
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDDD1DE880;
	Fri, 28 Feb 2025 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuHBeKA+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6D157A55;
	Fri, 28 Feb 2025 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783640; cv=none; b=uIueLJohnnpN3qp2C9u5tV09rX9890tYR8zM8SzFv0IIPRg+TZ1x94JA/5JcyZsxKst4SEBmUqdi7L3oF0dSPhP2IJFhifFriw+Ka2KAG/YMDsqudvlLZccnUo9TJvzMVO8Uefs2oKH1zBhFs6nBdJED8pCyP2e49RdUG3CQSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783640; c=relaxed/simple;
	bh=xatLn8TFdZue+sTPfH7qA1/Tl/XoCnRNRN8aOVzxaOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIGo1Elfffo/K87GZD25EAnvLN2bPZCM9d7bzEjPJorf6BCkZ8lgjfmGx6TdOvmLltqjFUzvoE9Rv7xu/pHxfgZBb1PZfMKAQhYxd6eKio9fh2bMMpHAGtfdVDCKQbY+WcGek6iZzZIXqTQBmiuTxh236cIin7kiH9MggEy5dn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuHBeKA+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f44353649aso4441131a91.0;
        Fri, 28 Feb 2025 15:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783638; x=1741388438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3BWlfZEtR/3Qj/pvRsVQaL3c5ye28zMKMUTBH3QofI=;
        b=GuHBeKA+KPHC5zIkq3/r+OfjKh5CbwbmV9lNePh441mPy6f7gDdkaSPi9/lwfCGEkQ
         8aueeQf95UHgdtqt8I5QNwdFUKLYeshOJoWnh6EGVrhv3GGcg7y/VTlWTFUTABZC2j6G
         MlS6CYivlc/P9X5ql2EbHdlkquWGB2IKbAahG/P1TDUnHnPwD9+NuGdQ8P29/nymtUtZ
         fwuWB+J2l0bWaYdqQ2OG1DugEVr1v0pHWmWUcSKuO45xNCVvBblLTjLlxT8Ik3x0N0hq
         csqtRSq1GOdMR+PLGOj4rF9maX22AOvGmde2hkCjMOC0iIkVp7l3x+UeueVhRjpN88+5
         AsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783638; x=1741388438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3BWlfZEtR/3Qj/pvRsVQaL3c5ye28zMKMUTBH3QofI=;
        b=IlLrgLXNtmb7emmIJJhZ5RucIlXDU5dQTHZKgsTaA62UyfPH3uvXTBOgzXyG+m1/qj
         IbSz9pV4gR6+QtS61WbGRGhGtvpUf3acJ8YwrBx5wwtBu1PO4GK2OX+yL6jS19aBaP5D
         XzdKcXTA48cRTjDzqsCzHr/tj/lcTOKVOg2hGZ3J3hc4KuzATGMgky/1Imba+5bEybuh
         IMMBIyADSEvSwPs28AIKSXt8wOxqcn6GsfdaOgxtuyM2wtI1MHBgOJqUmtyOr3EWkt5/
         CUh+PAnfp2PS+5F4jKpnZRK9IvTTs2N8A0Qv93b3uSAwXowQwbdVPTZt70xq+GXwVNFj
         PuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/UGwjpLKv0ktoqrqrfMzQGunZYb5l5Zb37KIdAVx6eL32np3pPNtPGgcwEC6mjg6xqmY=@vger.kernel.org, AJvYcCVB6YRC/QSHHRk2zHNGly+91gHg27i9fF0m1wQ6irrgpXRtjKPjZ0XdxxE6RtVPIJ95yRwOHtICBvCXInX9@vger.kernel.org, AJvYcCWx0oMvEfTxGlQlyi/V13tB0Q/mxH+myM44DPqm/y2FDgaLhjRb+O/JzHKGzL3y+D9/8CSTYhFW8lwYFZawfIW8pkKC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LKjLtGdyzy+ylq66BFf4RXhto0amYlhysI4Cm00f8EVTeuXq
	OLNRqKPK7RN5hng31K61Cx6j1rdSCd50PGJrsdycqCWGQ7z/5unJKs1o6Ofy53MSaLfVgpmm6or
	whWLj4ESbVxQc5McYNM/cTSDLJIBliA==
X-Gm-Gg: ASbGncs9aMHAN2+Gbcs8NKXDXRdnH9gOYUtP6lyKP2FSE6+VzVhG3UojZFCXzepDNp1
	wag1PytiyWT49cbAy7Rvdaoigig0L8nJKU0zJjeoaC2Mz+GKTwxsaEN2Yi3OUCo+yLNGga9ATMD
	TrYtJ7Pwwxg/0IRDmY6COcq2D5RvOMDYtX/ONi+CBrYw==
X-Google-Smtp-Source: AGHT+IHCZzGjTavCgvFZJbtDylmQp6lG9Am8pI7hIZW3Rb7OaCLyfwjztA1ZZTDyeuUL0Bz+NSawjVr1IQ2/WmrIRbY=
X-Received: by 2002:a17:90b:3a4c:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-2febaa861e5mr9974167a91.0.1740783637906; Fri, 28 Feb 2025
 15:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224140151.667679-1-jolsa@kernel.org> <20250224140151.667679-13-jolsa@kernel.org>
 <CAEf4BzbE1dhqZWpLYhZFo7cuuK04t9iM+1ykHA5_PbM_xdb1PQ@mail.gmail.com> <Z8I-24x1FHoBOQ6N@krava>
In-Reply-To: <Z8I-24x1FHoBOQ6N@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 15:00:22 -0800
X-Gm-Features: AQ5f1JqgN5HmxRtK6cL_Zvb14-opbmgzbrTrfTWS2Ioc8_Fym4WMhzEykRUHF20
Message-ID: <CAEf4BzbxLMB8RJWWZjtg6NkumHHZA=vhWZfHqZBf90O=aJVC+A@mail.gmail.com>
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

On Fri, Feb 28, 2025 at 2:55=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Feb 28, 2025 at 10:55:24AM -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 24, 2025 at 6:04=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Putting together all the previously added pieces to support optimized
> > > uprobes on top of 5-byte nop instruction.
> > >
> > > The current uprobe execution goes through following:
> > >   - installs breakpoint instruction over original instruction
> > >   - exception handler hit and calls related uprobe consumers
> > >   - and either simulates original instruction or does out of line sin=
gle step
> > >     execution of it
> > >   - returns to user space
> > >
> > > The optimized uprobe path
> > >
> > >   - checks the original instruction is 5-byte nop (plus other checks)
> > >   - adds (or uses existing) user space trampoline and overwrites orig=
inal
> > >     instruction (5-byte nop) with call to user space trampoline
> > >   - the user space trampoline executes uprobe syscall that calls rela=
ted uprobe
> > >     consumers
> > >   - trampoline returns back to next instruction
> > >
> > > This approach won't speed up all uprobes as it's limited to using nop=
5 as
> > > original instruction, but we could use nop5 as USDT probe instruction=
 (which
> > > uses single byte nop ATM) and speed up the USDT probes.
> > >
> > > This patch overloads related arch functions in uprobe_write_opcode an=
d
> > > set_orig_insn so they can install call instruction if needed.
> > >
> > > The arch_uprobe_optimize triggers the uprobe optimization and is call=
ed after
> > > first uprobe hit. I originally had it called on uprobe installation b=
ut then
> > > it clashed with elf loader, because the user space trampoline was add=
ed in a
> > > place where loader might need to put elf segments, so I decided to do=
 it after
> > > first uprobe hit when loading is done.
> > >
> > > We do not unmap and release uprobe trampoline when it's no longer nee=
ded,
> > > because there's no easy way to make sure none of the threads is still
> > > inside the trampoline. But we do not waste memory, because there's ju=
st
> > > single page for all the uprobe trampoline mappings.
> > >
> > > We do waste frmae on page mapping for every 4GB by keeping the uprobe
> > > trampoline page mapped, but that seems ok.
> > >
> > > Attaching the speed up from benchs/run_bench_uprobes.sh script:
> > >
> > > current:
> > >         usermode-count :  818.836 =C2=B1 2.842M/s
> > >         syscall-count  :    8.917 =C2=B1 0.003M/s
> > >         uprobe-nop     :    3.056 =C2=B1 0.013M/s
> > >         uprobe-push    :    2.903 =C2=B1 0.002M/s
> > >         uprobe-ret     :    1.533 =C2=B1 0.001M/s
> > > -->     uprobe-nop5    :    1.492 =C2=B1 0.000M/s
> > >         uretprobe-nop  :    1.783 =C2=B1 0.000M/s
> > >         uretprobe-push :    1.672 =C2=B1 0.001M/s
> > >         uretprobe-ret  :    1.067 =C2=B1 0.002M/s
> > > -->     uretprobe-nop5 :    1.052 =C2=B1 0.000M/s
> > >
> > > after the change:
> > >
> > >         usermode-count :  818.386 =C2=B1 1.886M/s
> > >         syscall-count  :    8.923 =C2=B1 0.003M/s
> > >         uprobe-nop     :    3.086 =C2=B1 0.005M/s
> > >         uprobe-push    :    2.751 =C2=B1 0.001M/s
> > >         uprobe-ret     :    1.481 =C2=B1 0.000M/s
> > > -->     uprobe-nop5    :    4.016 =C2=B1 0.002M/s
> > >         uretprobe-nop  :    1.712 =C2=B1 0.008M/s
> > >         uretprobe-push :    1.616 =C2=B1 0.001M/s
> > >         uretprobe-ret  :    1.052 =C2=B1 0.000M/s
> > > -->     uretprobe-nop5 :    2.015 =C2=B1 0.000M/s
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/x86/include/asm/uprobes.h |   6 ++
> > >  arch/x86/kernel/uprobes.c      | 191 +++++++++++++++++++++++++++++++=
+-
> > >  include/linux/uprobes.h        |   6 +-
> > >  kernel/events/uprobes.c        |  16 ++-
> > >  4 files changed, 209 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/up=
robes.h
> > > index 678fb546f0a7..7d4df920bb59 100644
> > > --- a/arch/x86/include/asm/uprobes.h
> > > +++ b/arch/x86/include/asm/uprobes.h
> > > @@ -20,6 +20,10 @@ typedef u8 uprobe_opcode_t;
> > >  #define UPROBE_SWBP_INSN               0xcc
> > >  #define UPROBE_SWBP_INSN_SIZE             1
> > >
> > > +enum {
> > > +       ARCH_UPROBE_FLAG_CAN_OPTIMIZE   =3D 0,
> > > +};
> > > +
> > >  struct uprobe_xol_ops;
> > >
> > >  struct arch_uprobe {
> > > @@ -45,6 +49,8 @@ struct arch_uprobe {
> > >                         u8      ilen;
> > >                 }                       push;
> > >         };
> > > +
> > > +       unsigned long flags;
> > >  };
> > >
> > >  struct arch_uprobe_task {
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index e8aebbda83bc..73ddff823904 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -18,6 +18,7 @@
> > >  #include <asm/processor.h>
> > >  #include <asm/insn.h>
> > >  #include <asm/mmu_context.h>
> > > +#include <asm/nops.h>
> > >
> > >  /* Post-execution fixups. */
> > >
> > > @@ -768,7 +769,7 @@ static struct uprobe_trampoline *create_uprobe_tr=
ampoline(unsigned long vaddr)
> > >         return NULL;
> > >  }
> > >
> > > -static __maybe_unused struct uprobe_trampoline *uprobe_trampoline_ge=
t(unsigned long vaddr)
> > > +static struct uprobe_trampoline *uprobe_trampoline_get(unsigned long=
 vaddr)
> > >  {
> > >         struct uprobes_state *state =3D &current->mm->uprobes_state;
> > >         struct uprobe_trampoline *tramp =3D NULL;
> > > @@ -794,7 +795,7 @@ static void destroy_uprobe_trampoline(struct upro=
be_trampoline *tramp)
> > >         kfree(tramp);
> > >  }
> > >
> > > -static __maybe_unused void uprobe_trampoline_put(struct uprobe_tramp=
oline *tramp)
> > > +static void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
> > >  {
> > >         if (tramp =3D=3D NULL)
> > >                 return;
> > > @@ -807,6 +808,7 @@ struct mm_uprobe {
> > >         struct rb_node rb_node;
> > >         unsigned long auprobe;
> > >         unsigned long vaddr;
> > > +       bool optimized;
> > >  };
> > >
> >
> > I'm trying to understand if this RB-tree based mm_uprobe is strictly
> > necessary. Is it? Sure we keep optimized flag, but that's more for
> > defensive checks, no? Is there any other reason we need this separate
> > look up data structure?
>
> so the call instruction update is done in 2 locked steps:
>  - first we write breakpoint as part of normal uprobe registration
>  - then uprobe is hit, we overwrite breakpoint with call instruction
>
> in between we could race with another thread that could either unregister=
 the
> uprobe or try to optimize the uprobe as well
>
> I think we either need to keep the state of the uprobe per process (mm_st=
ruct),
> or we would need to read the probed instruction each time when we need to=
 make
> decision based on what state are we at (nop5,breakpoint,call)

This decision is only done in "slow path", right? Only when
registering/unregistering. And those operations are done under lock.
So reading those 5 bytes every time we register/unregister seems
completely acceptable, rather than now *also* having a per-mm uprobe
lookup tree.

>
> jirka

