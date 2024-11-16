Return-Path: <bpf+bounces-45035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984609D0113
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583C82868E9
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF41AED3F;
	Sat, 16 Nov 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVqARUZY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89091AC450;
	Sat, 16 Nov 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793498; cv=none; b=pIs1cl7Q3SSL9uE49McTNwUheuYlYShJBffH+xQwQxxqF9p7oxDQ69tBv1AD+9090SyTGzHAa5r9sTYhCILdwLc7SHQg0p0A3lvO0ugs5tgicaOk1M6A9awdlLaowCpfTeL9t4nPDqBzVT3pPOt3z70oYUtF4uMqJvZ4dvpD3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793498; c=relaxed/simple;
	bh=sOx2Ag0ScF8wh6TtmKiWfjtR9qFeYTMPg62TLje5hG8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxRlt1nmjL2PCnQ9hzaPzzKtYmsQzVqoMkb0kaYTFnlIDVFL8lTfoEnT1H6p6sJ7iudjvLYD70RsDMREjXOJimnrQsvuG22u6OT9axpLxNqI82wSS4I61fcMEsjtB/A4Z/1x2avJmz+YP078UZ/eSSR61sCBcQZp3I2EkKUh1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVqARUZY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfabc686c8so796982a12.0;
        Sat, 16 Nov 2024 13:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793495; x=1732398295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvxeYy13y2KqrurgQrjcUr3Ij+2mb9+VDwgtgoU+jXU=;
        b=kVqARUZYF5qTgBIRHeMpQtZIjJLmN/a7fBn6GZ3hHgUkgf2asblgBbXvb5gT1k05dy
         gtpJxQLWWAonHkgLnx+Hmi4NWC93YFOf4bWWfq5MUAOJqyoBoGW4lpc/Y77oziYwXFsR
         b4PF8akfii6Ahf/iJE8LyR/EDnipM4+qq0l5iKA2F+QfqVjG6/XVVq5vo6ZdhZ4gIQTZ
         r6MOH1DD21Fr08P01XFDMPjxZkUmLA6I7QqLlsJ9GgFnpO59VoyoUqxxcyqizkorT5Uo
         HkwZqcKRUUPcJUw5Een5isMaklPbjTw9JxO3zySzWcgaG0YfJprrvndbPnvx3ZEwVOnU
         FrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793495; x=1732398295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvxeYy13y2KqrurgQrjcUr3Ij+2mb9+VDwgtgoU+jXU=;
        b=IdMq4jAgmbk3YmsGTvE13Q5lpnvPRv5ThA6KZlOuT42rEmBJhTfrk3UeiUM6j8NfEm
         QAKuRCzLMprdphSR2ooONcHE2OOIV4BF5c3dtz/wLx0QT9X67vBpbo566JZNyd8XWIUo
         /I270XG6ruwpZ9b+sYV6zxPnmepu9KIdJi4J+KmKdhpiaxKIIpREowShMBAWbEHADofN
         6HADL5pUrTZeH0KApGS6VCkGCZhA9gsfqFsmXF+NEQl+7vBDqqKLwAj08e6CCAt+JKvX
         05EhxDH6qixdw97EITatW1GjE7sTfQo7N/6syOTuxQjA3isiBFD+5Vxjjh6SGtnb/D3J
         /e6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3hbXlSasy9n/Q4lm11dxt/p8cVm7Mi/P0VlIdBsEwK6Xh4JtyWaNAGlflNcLhPo5JCHb0XRr4eL3u+LA6y82VR1WU@vger.kernel.org, AJvYcCVMOaDhPWwKquExb5GeDoKXkKYTCbrPfkEscdxaT9oBFRQPe9zG8xAjxcjSGOR2mT05uwV2FMxo3oY1GDXB@vger.kernel.org, AJvYcCWToU1b8m/Nb5upw+0N1YTBBhWG4WDPz6LMsL6TRxsk+6dxpWuj69J8HQehaNSYb7ahBCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7JiOxyg2Ttp8FUeSosPl0zAz0BVhMZmC4CBYomqkJn4Mo4vN
	IJbxN5zJYJLBu2ZpbNDdxjf+d8C9SUSUnIGHzxqW8E4TOg/6nqMa
X-Google-Smtp-Source: AGHT+IFTdILf4UHjnranbaprGYH2Kv3R3ibtgHBCwc+0MjAOehWBsJTzA54DJtm2+4ZsdmJaId5K3Q==
X-Received: by 2002:a05:6402:26c4:b0:5cf:b9a0:399c with SMTP id 4fb4d7f45d1cf-5cfb9a03a11mr685277a12.31.1731793494859;
        Sat, 16 Nov 2024 13:44:54 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79ba2cccsm2962592a12.34.2024.11.16.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 13:44:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Nov 2024 22:44:51 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 07/11] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <ZzkSUwQio_HaY5Ka@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-8-jolsa@kernel.org>
 <CAEf4BzYH8YvNLjBPB5sBQ-gz3GkvCVBbU1JCxqpHoVb9Zq51Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYH8YvNLjBPB5sBQ-gz3GkvCVBbU1JCxqpHoVb9Zq51Gw@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:44:20PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 5, 2024 at 5:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Putting together all the previously added pieces to support optimized
> > uprobes on top of 5-byte nop instruction.
> >
> > The current uprobe execution goes through following:
> >   - installs breakpoint instruction over original instruction
> >   - exception handler hit and calls related uprobe consumers
> >   - and either simulates original instruction or does out of line single step
> >     execution of it
> >   - returns to user space
> >
> > The optimized uprobe path
> >
> >   - checks the original instruction is 5-byte nop (plus other checks)
> >   - adds (or uses existing) user space trampoline and overwrites original
> >     instruction (5-byte nop) with call to user space trampoline
> >   - the user space trampoline executes uprobe syscall that calls related uprobe
> >     consumers
> >   - trampoline returns back to next instruction
> >
> > This approach won't speed up all uprobes as it's limited to using nop5 as
> > original instruction, but we could use nop5 as USDT probe instruction (which
> > uses single byte nop ATM) and speed up the USDT probes.
> 
> As discussed offline, it's not as simple as just replacing nop1 with
> nop5 in USDT definition due to performance considerations on old
> kernels (nop5 isn't fast as far as uprobe is concerned), but I think
> we'll be able to accommodate transparent "nop1 or nop5" behavior in
> user space, we'll just need a careful backwards compatible extension
> to USDT definition.
> 
> BTW, do you plan to send an optimization for nop5 to avoid
> single-stepping them? Ideally we'd just handle any-sized nop, so we
> don't have to do this "nop1 or nop5" acrobatics in the future.

I'll prepare that, but I'd like to check on the alternative calls
you suggested first

> 
> >
> > This patch overloads related arch functions in uprobe_write_opcode and
> > set_orig_insn so they can install call instruction if needed.
> >
> > The arch_uprobe_optimize triggers the uprobe optimization and is called after
> > first uprobe hit. I originally had it called on uprobe installation but then
> > it clashed with elf loader, because the user space trampoline was added in a
> > place where loader might need to put elf segments, so I decided to do it after
> > first uprobe hit when loading is done.
> 
> fun... ideally we wouldn't do this lazily, I just came up with another
> possible idea, but let's keep all this discussion to another thread
> with Peter
> 
> >
> > TODO release uprobe trampoline when it's no longer needed.. we might need to
> > stop all cpus to make sure no user space thread is in the trampoline.. or we
> > might just keep it, because there's just one 4GB memory region?
> 
> 4KB not 4GB, right? Yeah, probably leaving it until process exists is
> totally fine.

yep, ok

SNIP

> > +#include <asm/nops.h>
> >
> >  /* Post-execution fixups. */
> >
> > @@ -877,6 +878,33 @@ static const struct uprobe_xol_ops push_xol_ops = {
> >         .emulate  = push_emulate_op,
> >  };
> >
> > +static int is_nop5_insns(uprobe_opcode_t *insn)
> 
> insns -> insn?
> 
> > +{
> > +       return !memcmp(insn, x86_nops[5], 5);
> > +}
> > +
> > +static int is_call_insns(uprobe_opcode_t *insn)
> 
> ditto, insn, singular?

ok

SNIP

> > +int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> > +                             uprobe_opcode_t *new_opcode, void *opt)
> > +{
> > +       if (opt) {
> > +               uprobe_opcode_t old_opcode[5];
> > +               bool is_call;
> > +
> > +               uprobe_copy_from_page(page, vaddr, (uprobe_opcode_t *) &old_opcode, 5);
> > +               is_call = is_call_insns((uprobe_opcode_t *) &old_opcode);
> > +
> > +               if (is_call_insns(new_opcode)) {
> > +                       if (is_call)            /* register: already installed? */
> 
> probably should check that the destination of the call instruction is
> what we expect?

ok

SNIP

> > +bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
> > +{
> > +       unsigned long delta;
> > +
> > +       /* call instructions size */
> > +       vaddr += 5;
> > +       delta = vaddr < vtramp ? vtramp - vaddr : vaddr - vtramp;
> > +       return delta < 0xffffffff;
> 
> isn't immediate a sign extended 32-bit value (that is, int)? wouldn't
> this work and be correct:
> 
> long delta = (long)(vaddr + 5 - vtramp);
> return delta >= INT_MIN && delta <= INT_MAX;
> 
> ?

ah, right.. should be sign value :-\ thanks

jirka

