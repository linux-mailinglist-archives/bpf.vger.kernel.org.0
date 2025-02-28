Return-Path: <bpf+bounces-52933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D0A4A691
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D74174907
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE01DE8A0;
	Fri, 28 Feb 2025 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGl+4Npj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB123F37F;
	Fri, 28 Feb 2025 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784708; cv=none; b=d1JkEcvAChzLmpJFOxCumpkPGFhtbusCk5Ed6BjnTn+4LVxQQkpGLX6LjZjw3dFH+AUAwm0OPFTpsqR+GyhIeWoV+aEu1+/6hgibsf6xyQT08d9WMPimst9hHTHYTWTeMNsyoEO9okfm4Q5hkUSwX+3511WqsjnWKIUundUwh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784708; c=relaxed/simple;
	bh=+BMXF9BBc0Ge1Y2INp/F+Rk0FdDnlJNYvpBu27ojcf8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIzrbXKUQO+l5Cy8BvUOHUYmm0ho3/3msUh0B4WbPP1Xou1se2EPj+QWZTrND7osd22Si2IKtIk31NGHH+YlZaE81sGKEk7n/F/Wm4Gl6xiTnroqYi3kN0SwqF37+4lDK7fSogNZkir0ddPouRYGVxY1aVAN3ZWs1Gjt2QXVYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGl+4Npj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439a4dec9d5so28134945e9.0;
        Fri, 28 Feb 2025 15:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740784705; x=1741389505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJ1hJrZ+M0WzXNIpCGzfvE3p3WTOK6YAFfB/BVpfB5Q=;
        b=IGl+4NpjutODkb318mse1MG2JqCyx+NdJ/cGJyD5eugXxHfpUvJhDfO3vJgv391dRv
         D7QoxCZhZJdYFhI7Qu7NTjdPK/ZZhvtg/V3IUGJ8goH4maSadL5r9aihuGfR6yB/HvR6
         0sSiSy4BbZYQ9dwr+QmiLT+axm49mVQlWALjjv0yHNip2rk46RwNCowSuN6lpEn5+hZR
         KJnPgyl5RbFrU5MR++wbH6eF7OVcVuBuLbLGNx12L4mwE3x/klJZ/CR3ofuOcx9GJly8
         uLb8UtISxn/jzmOxrE3rIN+whT4gkVjnA0mlUE2X+K4To8VmrB/BPFKvXmjEoSRX0Os6
         Hlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784705; x=1741389505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ1hJrZ+M0WzXNIpCGzfvE3p3WTOK6YAFfB/BVpfB5Q=;
        b=si+VIwqh00emadyI7GiYfo6TyWPwAOUx4GNGaQvkDKrTcocDT8Il7JaPOYvFCUfGf+
         o79NHr1dpN0siFIzaEe1Nxe09fkeCmoHgbqhBgFdT7H/1a6lnUj+NrB6M8S9r/t1sJ7n
         7YhgackloIt9cPNUacOyv0DdSopkp1bMTg4NVOn8HWEz19YxYyvO4dQutct+JDiM7qgX
         5Ow61E9GhwstceeBBYD8TYT3+UzXQI2tibNAPnp98P9aEi2LZRURHL9VWgJNfO0tG7tH
         WFW054oseh3F6Wd9uz+iw7FrOA6DHV8x2ZCUQl4OaTFipMglYCfNGXAFVsgX3X9nxdv8
         TIJA==
X-Forwarded-Encrypted: i=1; AJvYcCVCfs7PY1Snpzhj8V1pMYiwRcpU4I80DVJHTSuB15qALb9gSvc49kKtcLm+PsGqDDQCR5k=@vger.kernel.org, AJvYcCW93JpdeX/v/glRJxEjrlG1CAo0tmwELbTQuMbIHPYm3cxFAoEuN/q7LIV67H5oCropsqVNI9FWFCSruBIq@vger.kernel.org, AJvYcCXC+Z+11m4LbRdfXvYdX4xsSTKiOXZmnlIZuRgLsDXLiZHpPVFxEcQo6qmKqLzVQTI//X4f7cih+TbgXWGVUmAbfS3b@vger.kernel.org
X-Gm-Message-State: AOJu0YzswOL7udzkBPYNHBJcPnAHeY4xlroT5Kot10MzS4tBEFh8F8Li
	9HHIfheG5bzzTUgHjnOAEAqzh1SKagSVDlUbW7M18Jf/c/E37VGb
X-Gm-Gg: ASbGncusEjJ/0lXsAI0Z+hFS0oLhFEARBI2yU5aWUDyVtGG8HfXC1uAzgCoa/7IL5W3
	wVtRmmYgSd9ZnVJ3SyGeT4IudyjiUpgnQkajKlhzroB6pKvAgYCy5uDi+j2J1Rys1dOLfwIUOaB
	bG17OFQncyr47N8kaMBsn4ggxokb4YxB/c2jVIRchvgBXINwDrDyk76kOd5bdlhUE1bDlijmshC
	x3BH15cECkzWthQFP5n/Acr5cRRETYumescsG90AqlvA0jkIXQiinJ+XfKz+Dl/SrCOgWeRydbb
	pbpdOtB9IZkkwEH/dGZYq/U1MogJJYvOw0QUOgsuQ3OKHLK97p4=
X-Google-Smtp-Source: AGHT+IEzlON1WdKbTm2j2bH/vMONmhDuE+LjjHOaFd8Jkv3sZdwKFAxklyr8k11MsS5p7zZ1nZqLHw==
X-Received: by 2002:a05:600c:1c8c:b0:439:9f97:7d5b with SMTP id 5b1f17b1804b1-43ba674cb46mr50344425e9.23.1740784705054;
        Fri, 28 Feb 2025 15:18:25 -0800 (PST)
Received: from krava (85-193-35-41.rib.o2.cz. [85.193.35.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bf64sm69954855e9.39.2025.02.28.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:18:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 1 Mar 2025 00:18:21 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv2 12/18] uprobes/x86: Add support to optimize uprobes
Message-ID: <Z8JEPdAHkkEL4x7k@krava>
References: <20250224140151.667679-1-jolsa@kernel.org>
 <20250224140151.667679-13-jolsa@kernel.org>
 <CAEf4BzbE1dhqZWpLYhZFo7cuuK04t9iM+1ykHA5_PbM_xdb1PQ@mail.gmail.com>
 <Z8I-24x1FHoBOQ6N@krava>
 <CAEf4BzbxLMB8RJWWZjtg6NkumHHZA=vhWZfHqZBf90O=aJVC+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbxLMB8RJWWZjtg6NkumHHZA=vhWZfHqZBf90O=aJVC+A@mail.gmail.com>

On Fri, Feb 28, 2025 at 03:00:22PM -0800, Andrii Nakryiko wrote:
> On Fri, Feb 28, 2025 at 2:55 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Feb 28, 2025 at 10:55:24AM -0800, Andrii Nakryiko wrote:
> > > On Mon, Feb 24, 2025 at 6:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Putting together all the previously added pieces to support optimized
> > > > uprobes on top of 5-byte nop instruction.
> > > >
> > > > The current uprobe execution goes through following:
> > > >   - installs breakpoint instruction over original instruction
> > > >   - exception handler hit and calls related uprobe consumers
> > > >   - and either simulates original instruction or does out of line single step
> > > >     execution of it
> > > >   - returns to user space
> > > >
> > > > The optimized uprobe path
> > > >
> > > >   - checks the original instruction is 5-byte nop (plus other checks)
> > > >   - adds (or uses existing) user space trampoline and overwrites original
> > > >     instruction (5-byte nop) with call to user space trampoline
> > > >   - the user space trampoline executes uprobe syscall that calls related uprobe
> > > >     consumers
> > > >   - trampoline returns back to next instruction
> > > >
> > > > This approach won't speed up all uprobes as it's limited to using nop5 as
> > > > original instruction, but we could use nop5 as USDT probe instruction (which
> > > > uses single byte nop ATM) and speed up the USDT probes.
> > > >
> > > > This patch overloads related arch functions in uprobe_write_opcode and
> > > > set_orig_insn so they can install call instruction if needed.
> > > >
> > > > The arch_uprobe_optimize triggers the uprobe optimization and is called after
> > > > first uprobe hit. I originally had it called on uprobe installation but then
> > > > it clashed with elf loader, because the user space trampoline was added in a
> > > > place where loader might need to put elf segments, so I decided to do it after
> > > > first uprobe hit when loading is done.
> > > >
> > > > We do not unmap and release uprobe trampoline when it's no longer needed,
> > > > because there's no easy way to make sure none of the threads is still
> > > > inside the trampoline. But we do not waste memory, because there's just
> > > > single page for all the uprobe trampoline mappings.
> > > >
> > > > We do waste frmae on page mapping for every 4GB by keeping the uprobe
> > > > trampoline page mapped, but that seems ok.
> > > >
> > > > Attaching the speed up from benchs/run_bench_uprobes.sh script:
> > > >
> > > > current:
> > > >         usermode-count :  818.836 ± 2.842M/s
> > > >         syscall-count  :    8.917 ± 0.003M/s
> > > >         uprobe-nop     :    3.056 ± 0.013M/s
> > > >         uprobe-push    :    2.903 ± 0.002M/s
> > > >         uprobe-ret     :    1.533 ± 0.001M/s
> > > > -->     uprobe-nop5    :    1.492 ± 0.000M/s
> > > >         uretprobe-nop  :    1.783 ± 0.000M/s
> > > >         uretprobe-push :    1.672 ± 0.001M/s
> > > >         uretprobe-ret  :    1.067 ± 0.002M/s
> > > > -->     uretprobe-nop5 :    1.052 ± 0.000M/s
> > > >
> > > > after the change:
> > > >
> > > >         usermode-count :  818.386 ± 1.886M/s
> > > >         syscall-count  :    8.923 ± 0.003M/s
> > > >         uprobe-nop     :    3.086 ± 0.005M/s
> > > >         uprobe-push    :    2.751 ± 0.001M/s
> > > >         uprobe-ret     :    1.481 ± 0.000M/s
> > > > -->     uprobe-nop5    :    4.016 ± 0.002M/s
> > > >         uretprobe-nop  :    1.712 ± 0.008M/s
> > > >         uretprobe-push :    1.616 ± 0.001M/s
> > > >         uretprobe-ret  :    1.052 ± 0.000M/s
> > > > -->     uretprobe-nop5 :    2.015 ± 0.000M/s
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  arch/x86/include/asm/uprobes.h |   6 ++
> > > >  arch/x86/kernel/uprobes.c      | 191 ++++++++++++++++++++++++++++++++-
> > > >  include/linux/uprobes.h        |   6 +-
> > > >  kernel/events/uprobes.c        |  16 ++-
> > > >  4 files changed, 209 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
> > > > index 678fb546f0a7..7d4df920bb59 100644
> > > > --- a/arch/x86/include/asm/uprobes.h
> > > > +++ b/arch/x86/include/asm/uprobes.h
> > > > @@ -20,6 +20,10 @@ typedef u8 uprobe_opcode_t;
> > > >  #define UPROBE_SWBP_INSN               0xcc
> > > >  #define UPROBE_SWBP_INSN_SIZE             1
> > > >
> > > > +enum {
> > > > +       ARCH_UPROBE_FLAG_CAN_OPTIMIZE   = 0,
> > > > +};
> > > > +
> > > >  struct uprobe_xol_ops;
> > > >
> > > >  struct arch_uprobe {
> > > > @@ -45,6 +49,8 @@ struct arch_uprobe {
> > > >                         u8      ilen;
> > > >                 }                       push;
> > > >         };
> > > > +
> > > > +       unsigned long flags;
> > > >  };
> > > >
> > > >  struct arch_uprobe_task {
> > > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > > index e8aebbda83bc..73ddff823904 100644
> > > > --- a/arch/x86/kernel/uprobes.c
> > > > +++ b/arch/x86/kernel/uprobes.c
> > > > @@ -18,6 +18,7 @@
> > > >  #include <asm/processor.h>
> > > >  #include <asm/insn.h>
> > > >  #include <asm/mmu_context.h>
> > > > +#include <asm/nops.h>
> > > >
> > > >  /* Post-execution fixups. */
> > > >
> > > > @@ -768,7 +769,7 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> > > >         return NULL;
> > > >  }
> > > >
> > > > -static __maybe_unused struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
> > > > +static struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
> > > >  {
> > > >         struct uprobes_state *state = &current->mm->uprobes_state;
> > > >         struct uprobe_trampoline *tramp = NULL;
> > > > @@ -794,7 +795,7 @@ static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> > > >         kfree(tramp);
> > > >  }
> > > >
> > > > -static __maybe_unused void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
> > > > +static void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
> > > >  {
> > > >         if (tramp == NULL)
> > > >                 return;
> > > > @@ -807,6 +808,7 @@ struct mm_uprobe {
> > > >         struct rb_node rb_node;
> > > >         unsigned long auprobe;
> > > >         unsigned long vaddr;
> > > > +       bool optimized;
> > > >  };
> > > >
> > >
> > > I'm trying to understand if this RB-tree based mm_uprobe is strictly
> > > necessary. Is it? Sure we keep optimized flag, but that's more for
> > > defensive checks, no? Is there any other reason we need this separate
> > > look up data structure?
> >
> > so the call instruction update is done in 2 locked steps:
> >  - first we write breakpoint as part of normal uprobe registration
> >  - then uprobe is hit, we overwrite breakpoint with call instruction
> >
> > in between we could race with another thread that could either unregister the
> > uprobe or try to optimize the uprobe as well
> >
> > I think we either need to keep the state of the uprobe per process (mm_struct),
> > or we would need to read the probed instruction each time when we need to make
> > decision based on what state are we at (nop5,breakpoint,call)
> 
> This decision is only done in "slow path", right? Only when
> registering/unregistering. And those operations are done under lock.
> So reading those 5 bytes every time we register/unregister seems
> completely acceptable, rather than now *also* having a per-mm uprobe
> lookup tree.

true.. I was also thinking about having another flag in that tree for
when we fail to optimize the uprobe for other reason than it being on
page alignment.. without such flag we'd need to read the 5 bytes each
time we hit that uprobe .. but that might be rare case

jirka

