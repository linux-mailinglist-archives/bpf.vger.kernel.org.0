Return-Path: <bpf+bounces-55391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090C5A7DBE5
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 13:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC53A9AB5
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7923A9BF;
	Mon,  7 Apr 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWKELj1k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD723816E;
	Mon,  7 Apr 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024052; cv=none; b=XdYr9rm0vIbbaC5xC0tcHySApY3nrCzKQhBWX94b3po/GfBS2BCcBbElczus+livuvpnfOdW9NQIOWA/t0B6fx1TViQ4lo1MCka+yE1smv1sK+1A3GhCkZJtcNre1rF3CTInYSLpAWLm1UEm9H48+YOFu76q89YfQEzrxVxzwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024052; c=relaxed/simple;
	bh=gjo63tKMCTCcGg8o5CTwSpqOnATcOXhk2IMUg/eLUUo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc4TZSNqAz+dqQxoWW7HGAnmuNI0eCNTf8A/XkUZC2DBIpaGpPgNq9fqPLAfmXcGnNqtg91DufmALM7L5X8AU1JmXH8GStNdNgPVj4QyPJDuVY8XT8suSw9MZ6MBdgxsOctIZYmHMbJbjqSDB3czHr7+zhAnSIqOjCpU20fhoYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWKELj1k; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4727753f8f.0;
        Mon, 07 Apr 2025 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024049; x=1744628849; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1T30QOzzY3WaQM5PR4AuF89U6egGVcvOhnK2sGKiWtw=;
        b=WWKELj1kGDud/qGmNtuWmN9/V425ZCnFMtbgEycDmyWsA0gysViyfiAcD1jaBbW2j/
         vL2cLNMt5X4wve7lU+jShSDa1P5vJDPwrTSlgWA8pFvhL4A6Q8ExVWY+huPWjKgcCaTq
         8W64bSx/1TwvPTqyrpxKlKI9wB1slmqF7KzLY4yN9ov6JXA0xTGkg98RRnpjT2ukpeXe
         8Mm3VD+GCwPItdFzAY3/0G2hSKB9GpzJG6Rg0I4Czh/xF4aviy/5t9GCz15yzfSzlxou
         PvPPqlCKonZjM6isenIiLtwiL6iVQzhK76FMz2vnkQvMkRuuK9LR1MVBBWipXaQHJ7UB
         7Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024049; x=1744628849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T30QOzzY3WaQM5PR4AuF89U6egGVcvOhnK2sGKiWtw=;
        b=q/b/polObjjgYOfJz3NMC9gfqXiYCdnTwW+S27HKA7+3LvkJ7A7jA96x0NkIU7+fNr
         BdprFP57RyD08eDvF+cThii7gXCWFuOwCmUhsIQCW2er6z7V3tSMwIkSPt8M+56vBmRR
         VfSj+blgj8980WiInfQ6GHh6cjfRFEtNgHR/pmUSQK15yjdB39/J9E7XbJOy02fpk6e/
         3c2zQWAfm40Y2GPFXkRvnj7Yqhcr4r2TO8HFGKs9kmmSyqANfck7HyLs3vJeyJsvK61n
         i/kKKPsZ7GwRIUBsg9yXtBKDK05oJMiJl4J/uKLZNHdq0jUcVwTghWSgWdPcsYM6EKLy
         EHLg==
X-Forwarded-Encrypted: i=1; AJvYcCUFpVsInwKLyq98ckhTKf8NVbjol8Dt8dkEN3AOodZNUkbUQclH0GlwcS/GAH/cim3nzZqcrSl6BSJY3jKR@vger.kernel.org, AJvYcCUrl9UWCoYya476PfWl5JKbOj3vdIK0oAb8plppBZvnYBaO5Si7UGzcbVsviGLVtk5Swh7c3WOHazz7dytI21uHb02N@vger.kernel.org, AJvYcCVO0EPPxEYyndUGo5HoRJzZKZYHDIpTC9jZp8ipS8sFw9/9UjFip00H37b+PSj2PKcnZJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx833jbdCpKkU1uqEYBehoPT8q8ezFW9vY1gg41s+A8LRrqTOJs
	t0tyg5xFrEscn0dMbH+LxT76dy5TbsfyRMVfUKCX3WyYu/IrKh0G
X-Gm-Gg: ASbGncucGmlRp8M3V8MaaqhutBCLERQ+VAAvxPu357Pcxlz93/8Dik+B9ghhk3nwExn
	Bw3EwhwD3yiPy9a+l79Sk3JtE9hkSSG+/z4xKBD7RVMkr95u8g1iWIf5aK2hevl839XLpOXaOv+
	rzgcU3SEJYiEFkRIw29CUlZyKhe3j1XZFfXCxnJscSXei7oiFnnmmd+tIlgTeFikUpWvdp0/4Vx
	dqQ5GWS5yI8jyuLupcPymlXMo/55cnwZu5/EFcQNsOHCke+WcuKboPYiqAiomx74UtFZe22q1C3
	cJ0v4g1aAlhZYlgDXtFOAYg2PLnAM9Y=
X-Google-Smtp-Source: AGHT+IHMGjWmqjUa/vzRicV35lNdDbdUd+LJ5MuJ6uKRB9FwuzLbHJWbHwqMO+HvcaXang5wgyvpzQ==
X-Received: by 2002:a05:6000:1a8a:b0:39c:1f11:bb2 with SMTP id ffacd0b85a97d-39d6fc4e7a1mr5907405f8f.22.1744024049082;
        Mon, 07 Apr 2025 04:07:29 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096923sm11886338f8f.17.2025.04.07.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:07:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Apr 2025 13:07:26 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH RFCv3 10/23] uprobes/x86: Add support to emulate nop5
 instruction
Message-ID: <Z_Ox7ibkULkJ_2Lx@krava>
References: <20250320114200.14377-1-jolsa@kernel.org>
 <20250320114200.14377-11-jolsa@kernel.org>
 <CAEf4BzY8z8r5uGEFjtNVm0L2JBwQ1ZPP2gqgsVqheqBkPiJ-9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY8z8r5uGEFjtNVm0L2JBwQ1ZPP2gqgsVqheqBkPiJ-9g@mail.gmail.com>

On Fri, Apr 04, 2025 at 01:33:11PM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 20, 2025 at 4:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to emulate nop5 as the original uprobe instruction.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> 
> This optimization is independent from the sys_uprobe, right? Maybe
> send it as a stand-alone patch and let's land it sooner?

ok, will send it separately

> Also, how hard would it be to do the same for other nopX instructions?

will check, might be easy

thanks,
jirka

> 
> 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 5ee2cce4c63e..1661e0ab2a3d 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -308,6 +308,11 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
> >         return -ENOTSUPP;
> >  }
> >
> > +static int is_nop5_insn(uprobe_opcode_t *insn)
> > +{
> > +       return !memcmp(insn, x86_nops[5], 5);
> > +}
> > +
> >  #ifdef CONFIG_X86_64
> >
> >  asm (
> > @@ -865,6 +870,11 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
> >         hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
> >                 destroy_uprobe_trampoline(tramp);
> >  }
> > +
> > +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> > +{
> > +       return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
> > +}
> >  #else /* 32-bit: */
> >  /*
> >   * No RIP-relative addressing on 32-bit
> > @@ -878,6 +888,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  {
> >  }
> > +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> > +{
> > +       return false;
> > +}
> >  #endif /* CONFIG_X86_64 */
> >
> >  struct uprobe_xol_ops {
> > @@ -1109,6 +1123,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> >                 break;
> >
> >         case 0x0f:
> > +               if (emulate_nop5_insn(auprobe))
> > +                       goto setup;
> >                 if (insn->opcode.nbytes != 2)
> >                         return -ENOSYS;
> >                 /*
> > --
> > 2.49.0
> >

