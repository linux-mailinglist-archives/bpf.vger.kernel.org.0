Return-Path: <bpf+bounces-33760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF55F92581F
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4321C25D6E
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8525155335;
	Wed,  3 Jul 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2eGCKto"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7313D617;
	Wed,  3 Jul 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001617; cv=none; b=ev520zxpNXUFXX6F/OFLv2rxRY7lYPdu6/X8IDfZwKwTBuzZnz/TLmVhnzNSu07uQFGpoMsJf8U0Zy8A63VhYmE2JGYYqAaySpDe9gfoq5NRibd+OW/8F/J0jsTyzvabnlMTBIckd3cco/n1Cc/vRLagM0mVs8UFtJtth1xJVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001617; c=relaxed/simple;
	bh=okDao69329YcauwOPK0+HP+id5wKEXp0URtqd9Uf/E8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TShDJpcSW4WOUaMNvQFK1dsRtD6YNiqPpIchGhYcGtRi5doaDUkZcOrFX64WF/y4b9+Wyyd2SaWfhT+m8kp5Bi8GBipmUEABR7+7mQhrfPRUwkwt2tyAY1w7ptvLByS1TSKnm1QQu4NELBwYY87LFSz24PpwSCiKR5SSJ5mqono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2eGCKto; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f8395a530dso24908075ad.0;
        Wed, 03 Jul 2024 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720001615; x=1720606415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om57aerLc1GBJVuc8TmyvVTTiPV8FJU0GvSoBwHW8mA=;
        b=M2eGCKtoQpDyOPF9rGRG/udcIrZdMeGmEJY+SZ3/78VCJOFF5aKpeoloBwlzjGMgTL
         P839mhk8ge9pS4j/dudvADwDTeLngSOMfK6YBQEihpan2Kv94bbNVd8B1CcrSUJlQx1a
         PlgmUOsS5C1zIfuwWKkVxRi52SS5Ki2kl6hPgVi/6H+ZpbcHvcxf6UfA34BTIV2EOefm
         /HB1UWBwBXsGuFYpNwdJLufmc2HZYkwy3I0havvxIDZrTRbQpU9bkCIwscz0YqqN3oon
         zIfvyosO2Z4q0eaJgXmNeMsnJY5EfzD3JGW+fnSoiBKLS7GQuUMmwBMLpMxELX+3fOUN
         IRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001615; x=1720606415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om57aerLc1GBJVuc8TmyvVTTiPV8FJU0GvSoBwHW8mA=;
        b=eAH/BpxZ63G0FVBMGeb0GbeLHYy7f8arjp9XCmy9JzY/sPKpLjLs66MHTIhXxmM/GT
         Np4cxkSNLeg16X3hZXwkaLikutGrjzZRxjbadKSCoYz8wauuFMTV60T7iUHgXgUYFNKc
         URCJZam2uYVccfSOc5Id7i5LBQy9OH3nTTjsbAz9S0+uUxGp0r4l1vhWfNSd+nUJ5usz
         CKdUznLDPyrClsu8chpMG/C0XQZ+pq9s11y92tmNVZ/GB0QWv/l2mZXRy+Duv0aH6TeU
         MSB8i6EjVm4ZNDTDMPsrRZJISY1tIyt7ELM/d7iudJIF4wwG7Req8VcrnFmnoIGjQT8u
         fQtg==
X-Forwarded-Encrypted: i=1; AJvYcCUk0GTUq77Wf4ycJPX3Ioe096QhgQPYr/rKHcvUyoCvN+MuEjJeru+VYgjFSTKgKtoQVmhlWmmdQ1RJrIX7vOf4l3I2wf7dzHL2hGo7SSkxhU1O9Kt6783fEKPiy41qxNUnGZUt/LBp
X-Gm-Message-State: AOJu0Yy5zzyiv/lWba2JitvfL0Rr69cqbUREQfEzAEQSPJafQEr0dOht
	/+z8rJMxu61/ZiGn+50YxFSdXG2HpekT+UqlCD8t2ESxHWDXhiSZ
X-Google-Smtp-Source: AGHT+IH7jhQWjUlq1nRYJj8XG2V/0G7LdSdqBJp110X88sN6Jplo3lip5EJklsMscLNNWe7rrld7mg==
X-Received: by 2002:a17:902:ec88:b0:1fa:aa62:8b46 with SMTP id d9443c01a7336-1fadbc8c13bmr86725905ad.19.1720001614982;
        Wed, 03 Jul 2024 03:13:34 -0700 (PDT)
Received: from devnote2 (113x37x226x201.ap113.ftth.ucom.ne.jp. [113.37.226.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb01f6f02asm25936165ad.279.2024.07.03.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:13:34 -0700 (PDT)
Date: Wed, 3 Jul 2024 19:13:30 +0900
From: Masami Hiramatsu <masami.hiramatsu@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
 mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
 paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 05/12] uprobes: move offset and ref_ctr_offset into
 uprobe_consumer
Message-Id: <20240703191330.0f2c26f574eaef6d7831c18b@gmail.com>
In-Reply-To: <20240703081315.GN11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
	<20240701223935.3783951-6-andrii@kernel.org>
	<20240703081315.GN11386@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 10:13:15 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 01, 2024 at 03:39:28PM -0700, Andrii Nakryiko wrote:
> > Simplify uprobe registration/unregistration interfaces by making offset
> > and ref_ctr_offset part of uprobe_consumer "interface". In practice, all
> > existing users already store these fields somewhere in uprobe_consumer's
> > containing structure, so this doesn't pose any problem. We just move
> > some fields around.
> > 
> > On the other hand, this simplifies uprobe_register() and
> > uprobe_unregister() API by having only struct uprobe_consumer as one
> > thing representing attachment/detachment entity. This makes batched
> > versions of uprobe_register() and uprobe_unregister() simpler.
> > 
> > This also makes uprobe_register_refctr() unnecessary, so remove it and
> > simplify consumers.
> > 
> > No functional changes intended.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/uprobes.h                       | 18 +++----
> >  kernel/events/uprobes.c                       | 19 ++-----
> >  kernel/trace/bpf_trace.c                      | 21 +++-----
> >  kernel/trace/trace_uprobe.c                   | 53 ++++++++-----------
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 22 ++++----
> >  5 files changed, 55 insertions(+), 78 deletions(-)
> > 
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index b503fafb7fb3..a75ba37ce3c8 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -42,6 +42,11 @@ struct uprobe_consumer {
> >  				enum uprobe_filter_ctx ctx,
> >  				struct mm_struct *mm);
> >  
> > +	/* associated file offset of this probe */
> > +	loff_t offset;
> > +	/* associated refctr file offset of this probe, or zero */
> > +	loff_t ref_ctr_offset;
> > +	/* for internal uprobe infra use, consumers shouldn't touch fields below */
> >  	struct uprobe_consumer *next;
> >  };
> >  
> > @@ -110,10 +115,9 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
> >  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
> >  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> >  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> > -extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> > -extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> > +extern int uprobe_register(struct inode *inode, struct uprobe_consumer *uc);
> >  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
> > -extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> > +extern void uprobe_unregister(struct inode *inode, struct uprobe_consumer *uc);
> 
> It seems very weird and unnatural to split inode and offset like this.
> The whole offset thing only makes sense within the context of an inode.

Hm, so would you mean we should have inode inside the uprobe_consumer?
If so, I think it is reasonable.

Thank you,

> 
> So yeah, lets not do this.


-- 
Masami Hiramatsu

