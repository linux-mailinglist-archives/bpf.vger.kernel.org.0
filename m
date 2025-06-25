Return-Path: <bpf+bounces-61535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6DAE878A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2971778F9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5826A1A3;
	Wed, 25 Jun 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMyx0lNt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36726A0D0;
	Wed, 25 Jun 2025 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864278; cv=none; b=oYBa35RZkxxhnNmjy6wQAOSPUIV8wxONd1/Jm6aQRUsWZHWDMw1MVBw2PaO2RahmMyFyOnI1F7k/YoCJqVWSYlgq6KyQYKADIWxEekx6Agb4mUl9Afh6lDWqYlJyd1XPqoi2OGQ3j2lCwVOA+ksn8qNCEdGXnPwtwd0qD4bMAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864278; c=relaxed/simple;
	bh=sQWzXMpttU3Q4RdTkLeDK11omHBR555qHYPgdiuh080=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1gNwNnWczsTdtWBjRDjo2TrX5Kf/DwzwMu4QV+IEH32hRMa1ExMOnW89lg/yFWiwdzw6vwML79xONQqEXKGghYi7stekvpN3da8/kv8p/BY+UY/hVwYCjrdGTsVjLOzFukKmO8hnIzYQzI+bkuGq4iKrT0RM3UJwE1Nv2l93dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMyx0lNt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad572ba1347so1082598566b.1;
        Wed, 25 Jun 2025 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750864275; x=1751469075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73ypKXXgUqafYwYORXlEImzIyHG0DLPjWMG5BzkdwL0=;
        b=RMyx0lNt7NrHiF7IsQsWJfs2RykQjbgheqF4xRQwVAwv89ZM86MNPbLpv43RrWrcw3
         etYxHUJN9JKsX4pnhaNCovk0ZQo4tJmGOloNmWuZXqUoDyfKNpjUQFyWZf576pEly5MJ
         fKeGNoAnKAScbXJERIMjc+wsrRn61zRJRMK/C9s1dM7pMkSbv7OFoWW8k2bX80+S3vLL
         Gi0mCSG9A7+0XwsCGfUBy4HtsKADanImyo06LK1uoCxhrsjzqAO52Yphitof5gJdTzyG
         FWzkI7yhPUKw29Pjk0hqVaJjSCSyQj84FO4Qb/w0trRynkyA6EgfjIYYsKRSh3LlD3Xu
         TFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864275; x=1751469075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73ypKXXgUqafYwYORXlEImzIyHG0DLPjWMG5BzkdwL0=;
        b=mA6CPCXAgvWxBFtXAxhAb/T5CYfIE+5wy6Swi8tt7fFRjMR9PV7mlvQDUKG5jPXz66
         iSQ1oV9idJ7S+rF6xSjg5lwXp9EpovRKHt+GxwpxgPYOTbQe5MwA9LaXXxhQBw97G44R
         seTwPRBOo9G2Is6JxIreckBWa70qTZFh2De94wkNxblRo+BRgRJlux0UBlT14q3HSo1A
         zKwYYVwARAl5BK2xwIxeYzmai/OJs1seIBdapGVdBFnW0eW+M9D2qjUudhCyonBJ7KV1
         Eip7uaKPFOt/ZYe6+IpScplCR6YB8AWdCE3JhTrrlSFYDYgSO74nVRxJ4mnUyHnlwtKV
         NFhA==
X-Forwarded-Encrypted: i=1; AJvYcCUSrGiriUY/tM1SUm9VWfs4TTNcGl8SoSGxI18ThyvpXm1KvgDOl1Ys2FXyuUuE5YnxdBJpFbZQNCyP3iRo7Wwt2slQ@vger.kernel.org, AJvYcCW/NK8UKdBcReMvzuN2+UCbd4Tr1QMVR27zLKoW41FiCVjO8anfRp9P271b7OYhxjLS8cXpNG+L/mZAIEzc@vger.kernel.org, AJvYcCXO4pzSi5Q/IZFHOBNoOMtqAGQ/6Fw+WkRnY9ZrwqA8Aovhqp0PLpDeQbjfYVd3yE/Ro7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9ylazOMMYXkOr0qK3Qns1U7c53Rda6QmAKi0vz5d2aP+l1Lk
	ncVzU0jaQIPVhCqLYNJQQICBkBZ2Ew9CTLTjM5jpl7puuzQ8/PklInxV
X-Gm-Gg: ASbGncsfhTzHqmZvSW/k2KjkGA6seOCp6nO3VkzvZvVwQYI+en5Lf+JIdgOEWdv51Zi
	l6R70CtRaMjHTDDu9c+vXJSZzPfE6il/UA1su1IgkjddjW/YaFnbD87TszL5QnWvlKnnh+paxZ8
	G7JSQRlCDNcdqE5ZguYOabOkJtP4bu7PGIrkdvDTCLIVWAZ3FfTjWq8Bq2ZP23E7BkAmTFcxzLE
	81eSC+6+W6EK4uq/LkocHagysAPyNaw1njHpg7DeW5nb7shDRFrzoZOxg97jH3s9/ItJT/ksYPr
	DtI69KkNKFo3s+KDZcD/oafq0jKmJJx+J3qvJ5pcA3Z8vCLJKQ==
X-Google-Smtp-Source: AGHT+IHR73kNjkLY6I6z8/OKPl7imSBMI/aYV5GL05PY9WoiLG/9bgiLimAwHJf6yVTIF1PIfqYUzA==
X-Received: by 2002:a17:907:26c2:b0:ae0:cca0:e6af with SMTP id a640c23a62f3a-ae0cca0ebf1mr95706966b.1.1750864272815;
        Wed, 25 Jun 2025 08:11:12 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0543421e9sm1059851066b.185.2025.06.25.08.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:11:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Jun 2025 17:11:09 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 07/22] uprobes: Add do_ref_ctr argument to
 uprobe_write function
Message-ID: <aFwRjTkluiE-g-Ab@krava>
References: <20250605132350.1488129-1-jolsa@kernel.org>
 <20250605132350.1488129-8-jolsa@kernel.org>
 <20250625154259.4a092f0213739404a0e9b210@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625154259.4a092f0213739404a0e9b210@kernel.org>

On Wed, Jun 25, 2025 at 03:42:59PM +0900, Masami Hiramatsu wrote:
> On Thu,  5 Jun 2025 15:23:34 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Making update_ref_ctr call in uprobe_write conditional based
> > on do_ref_ctr argument. This way we can use uprobe_write for
> > instruction update without doing ref_ctr_offset update.
> > 
> 
> Can we just decouple this update from uprobe_write()?
> If we do this exclusively, I think we can do something like;
> 
> lock()
> update_ref_ctr(uprobe, mm, +1);
> ...
> ret = uprobe_write();
> ...
> if (ret < 0)
>   update_ref_ctr(uprobe, mm, -1);
> unlock()
> 
> Thank you,

it was the intention in the v1 but as Oleg pointed out [1] it won't
work, because the set_orig_refctr part of this change does not know
if the refctr should be really updated or not

while inside uprobe_write it happens right after verify callback and
we make sure to update refctr only if the instruction was updated

thanks,
jirka


[1] https://lore.kernel.org/bpf/20250427141335.GA9350@redhat.com/

> 
> 
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h | 2 +-
> >  kernel/events/uprobes.c | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 518b26756469..5080619560d4 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -200,7 +200,7 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> >  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t,
> >  			       bool is_register);
> >  extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
> > -			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register);
> > +			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr);
> >  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> >  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
> >  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 1e5dc3b30707..6795b8d82b9c 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -492,12 +492,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  		bool is_register)
> >  {
> >  	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
> > -			    verify_opcode, is_register);
> > +			    verify_opcode, is_register, true /* do_update_ref_ctr */);
> >  }
> >  
> >  int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
> > -		 uprobe_write_verify_t verify, bool is_register)
> > +		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr)
> >  {
> >  	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
> >  	struct mm_struct *mm = vma->vm_mm;
> > @@ -538,7 +538,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  	}
> >  
> >  	/* We are going to replace instruction, update ref_ctr. */
> > -	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
> > +	if (do_update_ref_ctr && !ref_ctr_updated && uprobe->ref_ctr_offset) {
> >  		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
> >  		if (ret) {
> >  			folio_put(folio);
> > @@ -590,7 +590,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  
> >  out:
> >  	/* Revert back reference counter if instruction update failed. */
> > -	if (ret < 0 && ref_ctr_updated)
> > +	if (do_update_ref_ctr && ret < 0 && ref_ctr_updated)
> >  		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
> >  
> >  	/* try collapse pmd for compound page */
> > -- 
> > 2.49.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

