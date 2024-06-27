Return-Path: <bpf+bounces-33256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF7591A82D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1B11C21B9F
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2CA194A49;
	Thu, 27 Jun 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wcj8mTAg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3151946B7;
	Thu, 27 Jun 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495864; cv=none; b=XpFLDg1WLXOAOI9CTBhk+sqU3gimD0oEouLOyRrZd4rPwTLQm8KlRl+v3JG9XK4mQ57qdpKZVSbk/X9ddLjesjqKy35SNrKRd6R5O0jGrMH5Hkh3ca4f6IaPVjmoqkGBlKaVkKKGH82x6lxsOF9W3BpMGRrOSVOGebf8bshf/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495864; c=relaxed/simple;
	bh=Ul6G/nJq1NqsvPPUxn1ztVYbl+D8KaF4w3zcLhTazvM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSRvbGSa43DBr/j4JDUtMj9+hM4tZ5+wUp8v/lYF80gOWCZM0M9HFFDioIa25rmPk9z0/OjwTj2kDI5ApLZievqZmI5QGughYIr4SoiYoRInnPYcq+FlnS/Kxw9FQFJfotMQmiIBnx03ad4PvOzDRGRm9YFk2rKbVJYaqjSImDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wcj8mTAg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso1952528a12.2;
        Thu, 27 Jun 2024 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719495860; x=1720100660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+z2OIiBoWk61ptokEVO+KMQtz628M7t7de8HsxCdEX4=;
        b=Wcj8mTAgGc6TQZWcjqbilt4Mf4AeLGgaXeWU5ID00jyiYQnUpWErswv76FC1rIJero
         rpwGxFvEgHmPB8sRf6+YLgqQ8ffbZ3eo78n4Icp418xNb1rIrMnLFDU2+Iemgt0DmQdL
         SwzASwBX7ujzrTsHiMwb8cYy5xrEM2P74nJxM5/b6S27dWvy38FYPNbz8oaD0KnudTIN
         iLXu45Bf5KS/f5UKzfbHcQZ1sAy4x/h5uwnsGLGVnzCcTefEnptfM8saoKAYRhjsKcSv
         wN+c68AwJtTHoKJuraqq485VhByntuRIhO7B3HA27yK9MqQjE37SPfg6u3XqZuasiD4D
         fheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719495860; x=1720100660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+z2OIiBoWk61ptokEVO+KMQtz628M7t7de8HsxCdEX4=;
        b=sdCNmBVrUKMW9OB/WkmpAWuU1+7cGV3WgFbrEsCRqhmfF82dYHaIYUVDk/KPaLHhBv
         V15qL8D9/fvrxI1vGW+e+btUCl9FaDAWD6m52kZQTbtcEW5JljNFBWKrp1oMa20FP5xG
         /v9BTNEtyT/aDBQRxXhT39ftXDoZD606CMB+4VvhnZOW2XoNqdJ1SpvC6qNI9Xx7Hdfl
         qTPY73/MDI7nAfsLAaN5Rqe37f6kORc2mSx3JtfFH9O2vCmJatcBYJhssfVCX6WrVV7z
         MHc2RfVzaw3/g2w+UNIidzB2yOmCPatwL5mekugZ0UsxE6kUknmJzLZlS5zsXYZRNPN/
         +Uew==
X-Forwarded-Encrypted: i=1; AJvYcCWZJ9DoeuoZrpckpISbt94qxmFBoTi29yzRWrDa4uI5YexcghSksYIn6J/XvDRT6ZxjaZl41gzXiP0Md9SGJHLn5g45RyiY2jp4LTLwTfJ8/BSDs5gdKhBa7MuPp2XJxt3+wGgjz+ARP3g5Ri8sDvt+QHU9cFWnrnRgrz1+nMaIP8iPlQh1
X-Gm-Message-State: AOJu0YzboU5XHdbWXly7L7gGokYU4q1gu5goS8ei3oyPq36l2SRpjRzG
	oOp/PDmgneothZCfqCyQ7gANwDGXMt1EiQNJ1aSzpnLyxz9qVVOB
X-Google-Smtp-Source: AGHT+IEGZJ8GU/lUTDP7HIhY+S/dmDAgLYptgqhK+X5p8UjuwE0YVnPKygAdrtwn11XNkTNIchFk2w==
X-Received: by 2002:a50:f604:0:b0:57c:ad11:e759 with SMTP id 4fb4d7f45d1cf-57d4bdbe905mr11369584a12.28.1719495860340;
        Thu, 27 Jun 2024 06:44:20 -0700 (PDT)
Received: from krava (net-93-147-243-244.cust.vodafonedsl.it. [93.147.243.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d16bae13sm896890a12.43.2024.06.27.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:44:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 27 Jun 2024 15:44:16 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static initializer
Message-ID: <Zn1ssLPeMj-On_uT@krava>
References: <20240618194306.1577022-1-jolsa@kernel.org>
 <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
 <20240620193846.GA7165@redhat.com>
 <CAEf4BzaqgbjPfxKmzF-M7nzGroOwKikA0BM7Tnw7dKzKS+x9ZQ@mail.gmail.com>
 <20240621120149.GB12521@redhat.com>
 <ZnV9hvOP5388YJtw@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnV9hvOP5388YJtw@krava>

On Fri, Jun 21, 2024 at 03:17:58PM +0200, Jiri Olsa wrote:
> On Fri, Jun 21, 2024 at 02:01:50PM +0200, Oleg Nesterov wrote:
> > On 06/20, Andrii Nakryiko wrote:
> > >
> > > On Thu, Jun 20, 2024 at 12:40 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > But I can't understand what does it do, it calls emit_break() and
> > > > git grep -w emit_break finds nothing.
> > > >
> > >
> > > It's DEF_EMIT_REG0I15_FORMAT(break, break_op) in
> > > arch/loongarch/include/asm/inst.h
> > >
> > > A bunch of macro magic, but in the end it produces some constant
> > > value, of course.
> > 
> > I see, thanks!
> > 
> > Then perhaps something like below?
> 
> lgtm, added loong arch list/folks

ping

Oleg, do you want to send formal patch?

thanks,
jirka

> 
> for context:
>   https://lore.kernel.org/bpf/20240614174822.GA1185149@thelio-3990X/
> 
> thanks,
> jirka
> 
> > 
> > Oleg.
> > 
> > 
> > --- x/arch/loongarch/include/asm/uprobes.h
> > +++ x/arch/loongarch/include/asm/uprobes.h
> > @@ -9,7 +9,7 @@ typedef u32 uprobe_opcode_t;
> >  #define MAX_UINSN_BYTES		8
> >  #define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
> >  
> > -#define UPROBE_SWBP_INSN	larch_insn_gen_break(BRK_UPROBE_BP)
> > +#define UPROBE_SWBP_INSN	(uprobe_opcode_t)(BRK_UPROBE_BP | (break_op << 15))
> >  #define UPROBE_SWBP_INSN_SIZE	LOONGARCH_INSN_SIZE
> >  
> >  #define UPROBE_XOLBP_INSN	larch_insn_gen_break(BRK_UPROBE_XOLBP)
> > --- x/arch/loongarch/kernel/uprobes.c
> > +++ x/arch/loongarch/kernel/uprobes.c
> > @@ -7,6 +7,13 @@
> >  
> >  #define UPROBE_TRAP_NR	UINT_MAX
> >  
> > +static __init int __ck_insn(void)
> > +{
> > +	BUG_ON(UPROBE_SWBP_INSN != larch_insn_gen_break(BRK_UPROBE_BP));
> > +	return 0;
> > +}
> > +late_initcall(__ck_insn);
> > +
> >  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
> >  			     struct mm_struct *mm, unsigned long addr)
> >  {
> > 

