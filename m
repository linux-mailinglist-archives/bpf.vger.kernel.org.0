Return-Path: <bpf+bounces-55392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F739A7DBFC
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 13:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26063AE12E
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 11:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4823E25B;
	Mon,  7 Apr 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBNY45Qq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AC23BD19;
	Mon,  7 Apr 2025 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024415; cv=none; b=d8M9ziO4oT3LONLNkxTg5wmUepXBMLNLgizs/yD+yVc2GZhjg04vIu+uf0Sb++KreuEwmbL5i8fZAS5IPAkTV0bf255GnIu0UfJF7kpZaWuJrJGAk1Saa2bhV/MUDgxuOXJw37ZJMV8K/ydj3OayJnAlvHV07t3Ggquf1gHASk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024415; c=relaxed/simple;
	bh=hqgANVsNR8Rt3HtSOF7ZR3LRFnEebeRiMRV4l5khDmw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1OCMHz/PcofD6z2JkSJH48VYDdP9g4q+bePSERdGwVn3SiOuSMqNMLM7Gvc8G08caE+dVEOGl7RK78aumoyC+UPdtjAv/VEstg670vV4KqRBI9Y0Rp4n0qzTCAnwLvC3EXEhigU9MREk94teDjLBFcT+wUcSaM24bPeZwGnUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBNY45Qq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913b539aabso2396961f8f.2;
        Mon, 07 Apr 2025 04:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024412; x=1744629212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1g0K/GbR4huj/3bxod2znKneDlpeVu6+EhjgAuYSpE=;
        b=KBNY45Qq+uYV69oFY6GIbZ7w6al911aKFFAFvCqVuEZc1Slgy8tiAAurlb5LQNCtKs
         W4vNdW3TU2xUQcvBgAC1DPrT2IqlGTLTvgWs+SfKJFE7wh1AUB38GcRqQ7am+ZcXHvUx
         PlOoXhzqJJss98DcdbeF69oM42r/fge+GjILQldZWNzWXggNYAAbSmTVMksIR/1Haj5u
         UQU7XKZix5iIjCraRAOncuXCatxHCNQG4gcthNoV41fiF1CcPsJSgLfnYwvmus6k1xX5
         3G4wMFoS1H4dePGyyTgrxBP+6WOsfvZljKykaT4bT1adVJzjCFY6M2XcS6ocffWtNmNn
         DaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024412; x=1744629212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1g0K/GbR4huj/3bxod2znKneDlpeVu6+EhjgAuYSpE=;
        b=rrczIPJs0uLK7UOIoraueXi/EUdM37lCIWXqPTrSAbk81KDPMLaPFoXpo8rw3XTUeF
         YBc7QzQP+yc+5iyFvYwZx84ACfSIMBNGXdqmMdFrfSC7N9gNXOA0bNUBCKTI05hkqeXM
         ZSnmiMt21zXMPkXT6KKiVLCSLo2JjDSj3594H+Fk6NUCm0abCNb/qfB1NtEJEAAKKCdL
         I1dmPxcImuuA9zD2jHWqQpJwp+ixi8nVjAQ8FF7TTwNwWE3HepNxPOnAGU432bB5CmF9
         JpgZgmX3R8b9lqMQzZ69ne/fVfdj1mfegzDhPL501qdfPD38pVU1za36tqEa8FLQWQu9
         +blw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Uxp2OTI4RKzoTZ97JuO+1cr72Wwtga7Nls7lGvvuQVj3hd+LRrcrFMOEIWkATFPsBfU=@vger.kernel.org, AJvYcCWApkelHUFXgUDSob6vHTs+Oz0zUeDji1ZOBcVvRL2QTXcERoXEE1WGjj3sKFUE/clNox0v5V8mvHfP2t0nA9RsObct@vger.kernel.org, AJvYcCWWT+Z1utajw/F1monpN50kMfnFKpltBJvFy1+MFDnMTSmak7ZrE9HHvZEZEFkPFT3f4Cszc2O+moN7r6JW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9c7BozDyVLXoL1/4lpSTh2brQWzJoDKEG7rslb4iXSzky0si4
	G+wNZmBGWrUrdh3eflnlW8zerfW5SC+QtwNrr91F6pkUyPp9utSd
X-Gm-Gg: ASbGncsEHNu594SgjVorHAFzhhY+//m88kuSOK4RFzqrCFIkFaowbIJQHXz/ogDDEdq
	EKMYvh/PP6LtuLXPmf1J6/MPdpwVG7KEJ04P+CI4JfdEhGph9z2aaxTjoZWviZTHhW23jjbdzV7
	CX8TWHEJcPrd63zK0MlixHlfltjc2avnx2hhpt0+Xz9H3ILy6JpihPCyQOiCN2Ym+eltWPYJyBw
	r2+aGYsY8oYO3XuWiZk86E8v+3mKxNwGOSJ5hYZKa9eNERHrmPBFXkHpbsgHbsd9F+1RPZA4Tda
	Vli/MVmtQ265b4fYKsAjXsUBopBbAAc=
X-Google-Smtp-Source: AGHT+IErbncomhspvsojEzE6U7GRnmxvIko91AwdP/3jXdNmX/MveT7PajENH/43c/tPY7vD7ezSKQ==
X-Received: by 2002:a5d:584c:0:b0:390:fb37:1ca with SMTP id ffacd0b85a97d-39cba93cf5dmr10368476f8f.53.1744024411894;
        Mon, 07 Apr 2025 04:13:31 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a8952sm126204205e9.10.2025.04.07.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:13:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Apr 2025 13:13:29 +0200
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
Subject: Re: [PATCH RFCv3 06/23] uprobes: Add orig argument to uprobe_write
 and uprobe_write_opcode
Message-ID: <Z_OzWey2jLGGk49O@krava>
References: <20250320114200.14377-1-jolsa@kernel.org>
 <20250320114200.14377-7-jolsa@kernel.org>
 <CAEf4Bzba80rRKmcUN-rEu5TtRF9F5ePOUJtNYM1nQDTrKOuaQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzba80rRKmcUN-rEu5TtRF9F5ePOUJtNYM1nQDTrKOuaQg@mail.gmail.com>

On Fri, Apr 04, 2025 at 01:33:02PM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 20, 2025 at 4:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The uprobe_write has special path to restore the original page when
> > we write original instruction back.
> >
> > This happens when uprobe_write detects that we want to write anything
> > else but breakpoint instruction.
> >
> > In following changes we want to use uprobe_write function for multiple
> > updates, so adding new function argument to denote that this is the
> > original instruction update. This way uprobe_write can make appropriate
> > checks and restore the original page when possible.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/arm/probes/uprobes/core.c |  2 +-
> >  include/linux/uprobes.h        |  5 +++--
> >  kernel/events/uprobes.c        | 22 ++++++++++------------
> >  3 files changed, 14 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
> > index f5f790c6e5f8..54a90b565285 100644
> > --- a/arch/arm/probes/uprobes/core.c
> > +++ b/arch/arm/probes/uprobes/core.c
> > @@ -30,7 +30,7 @@ int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >              unsigned long vaddr)
> >  {
> >         return uprobe_write_opcode(auprobe, mm, vaddr,
> > -                  __opcode_to_mem_arm(auprobe->bpinsn));
> > +                  __opcode_to_mem_arm(auprobe->bpinsn), false);
> >  }
> >
> >  bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index c69a05775394..1b6a4e2b5464 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -196,9 +196,10 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
> >  extern bool is_trap_insn(uprobe_opcode_t *insn);
> >  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
> >  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> > -extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> > +extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
> > +                              uprobe_opcode_t, bool);
> 
> add arg names for humans?..

yep, anything for humans.. ;-)

thanks,
jirka

> 
> >  extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
> > -                       uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
> > +                       uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool orig);
> >  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> >  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
> >  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> 
> [...]

