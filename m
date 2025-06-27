Return-Path: <bpf+bounces-61733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E50AEAE44
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 06:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427353AAFA8
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 04:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7581DDC04;
	Fri, 27 Jun 2025 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAsE4uBQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116518DB35;
	Fri, 27 Jun 2025 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000291; cv=none; b=DNRaAcNBqogCuAd1KmzmukqH4BFu+9IxPhwXXQJgDGxCqcKPJwlQZe5x8uhp/xTUFWpUOZc0sKwLDQEm6vxsFrHp9TYKDvXYrhz64w016ObdIuEwl0kdtlXrzyeoEqlbJSK4CBGboVflCR+5rPo0WEu5yKVEEJ5fciGKv04Ysx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000291; c=relaxed/simple;
	bh=hh+Pcw6Bm2ZODy21sOTBGqmuusQEsI7aY0o1WB0Nl1c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hbaZolug4bh5M/Lh7yVjoE6WEbJ9QumOFEYopu0yQzHD86vwgW0cXFQA/f7Ne0QiKaKYDp/Hr3RKUl5aMemPfOOj6EI9QJcbCccDToxU2YlrejsYyCP5142xbbwZr2lRMz9hxvJtG116qXd1VwGtaZkico6RKOqroLVEwJmGNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAsE4uBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FDEC4CEE3;
	Fri, 27 Jun 2025 04:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751000291;
	bh=hh+Pcw6Bm2ZODy21sOTBGqmuusQEsI7aY0o1WB0Nl1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MAsE4uBQf9SAwhj9bFX1fXZozhWsCTxbzvleDxq+MTF5eYPJWzDUxYEDKM0R3vZ4S
	 tnbI0Hs3qmWu474Zuv8EyE0L/ws6cADfKbe4fZ+sdG/kSEASjLuAv7eElKd+qrRCoE
	 uYonxwEDCFhUobdkI1iw7+oyn1QiCJvyzCxxJv9gdXIHboqmCjArGQ+AEmTGBPxNH9
	 DguOSfCVnDnGax6XYad+DAZKO6JhuMrSB019kM2StIzoBz2DMRfKFrWLxPIRDam1GU
	 b/C8q0E1zxVXFhnJS/DCpGQi5UIFk1XFlnzB9pXbGLlKBV7F/e7LS+XSSanUCVwXKn
	 xF+fpi08z4TNQ==
Date: Fri, 27 Jun 2025 13:58:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Alan Maguire
 <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 07/22] uprobes: Add do_ref_ctr argument to
 uprobe_write function
Message-Id: <20250627135807.dd97ddf4cb6910df3c56e654@kernel.org>
In-Reply-To: <aFwRjTkluiE-g-Ab@krava>
References: <20250605132350.1488129-1-jolsa@kernel.org>
	<20250605132350.1488129-8-jolsa@kernel.org>
	<20250625154259.4a092f0213739404a0e9b210@kernel.org>
	<aFwRjTkluiE-g-Ab@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 17:11:09 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Wed, Jun 25, 2025 at 03:42:59PM +0900, Masami Hiramatsu wrote:
> > On Thu,  5 Jun 2025 15:23:34 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > Making update_ref_ctr call in uprobe_write conditional based
> > > on do_ref_ctr argument. This way we can use uprobe_write for
> > > instruction update without doing ref_ctr_offset update.
> > > 
> > 
> > Can we just decouple this update from uprobe_write()?
> > If we do this exclusively, I think we can do something like;
> > 
> > lock()
> > update_ref_ctr(uprobe, mm, +1);
> > ...
> > ret = uprobe_write();
> > ...
> > if (ret < 0)
> >   update_ref_ctr(uprobe, mm, -1);
> > unlock()
> > 
> > Thank you,
> 
> it was the intention in the v1 but as Oleg pointed out [1] it won't
> work, because the set_orig_refctr part of this change does not know
> if the refctr should be really updated or not

Ah, uprobe_unregister() can not check the given uprobe failed to
update the code for each mm....

> 
> while inside uprobe_write it happens right after verify callback and
> we make sure to update refctr only if the instruction was updated

OK. But this is very complicated. Eventually I think uprobe should
have a list of mm(or refcnt) to manage whether it is updated the
refcounter.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/20250427141335.GA9350@redhat.com/
> 
> > 
> > 
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/uprobes.h | 2 +-
> > >  kernel/events/uprobes.c | 8 ++++----
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index 518b26756469..5080619560d4 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -200,7 +200,7 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> > >  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t,
> > >  			       bool is_register);
> > >  extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
> > > -			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register);
> > > +			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr);
> > >  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> > >  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
> > >  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 1e5dc3b30707..6795b8d82b9c 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -492,12 +492,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > >  		bool is_register)
> > >  {
> > >  	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
> > > -			    verify_opcode, is_register);
> > > +			    verify_opcode, is_register, true /* do_update_ref_ctr */);
> > >  }
> > >  
> > >  int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > >  		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
> > > -		 uprobe_write_verify_t verify, bool is_register)
> > > +		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr)
> > >  {
> > >  	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
> > >  	struct mm_struct *mm = vma->vm_mm;
> > > @@ -538,7 +538,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > >  	}
> > >  
> > >  	/* We are going to replace instruction, update ref_ctr. */
> > > -	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
> > > +	if (do_update_ref_ctr && !ref_ctr_updated && uprobe->ref_ctr_offset) {
> > >  		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
> > >  		if (ret) {
> > >  			folio_put(folio);
> > > @@ -590,7 +590,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > >  
> > >  out:
> > >  	/* Revert back reference counter if instruction update failed. */
> > > -	if (ret < 0 && ref_ctr_updated)
> > > +	if (do_update_ref_ctr && ret < 0 && ref_ctr_updated)
> > >  		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
> > >  
> > >  	/* try collapse pmd for compound page */
> > > -- 
> > > 2.49.0
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

