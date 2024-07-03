Return-Path: <bpf+bounces-33816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C74926AC9
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09BF1F24849
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D07193097;
	Wed,  3 Jul 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4kt9TmE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B0187332;
	Wed,  3 Jul 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043283; cv=none; b=lPWesHnHMGOcKNbBuG+n0oQMqXybdkSmJ94/vJ/glJqPZZEmWgbvEOLlLUNH3yE0Y6D+IrFKs730pZjyorcWNcoBZk2/cc5KSshKpKEJKtxNYEt3DaX/MqQZHW/EjUhqjRnPnem+KtYYKoKe/N5D2R92McrhMW09vPiWygErQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043283; c=relaxed/simple;
	bh=DcAjvcrX8q9Gwan+ITxo9Rgeue4bQCM5Lbzae0rQAvs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gxQhyZAhLzRX0eG+So7ySaeqSnCdKk3H9yKqVljpc8UW7gr7xEqeFVSPdFZ46WPdXvw7MJnjHxi3rgdjFkGNQM5fR7RRh3dFco5N6jJcXBZ5z/La97KRUKq9HQv0O+bqGvcPN/1HhmdWWWEu/urGX4E+f+McJ3C9c+rLmh6Vlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4kt9TmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169A2C2BD10;
	Wed,  3 Jul 2024 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720043282;
	bh=DcAjvcrX8q9Gwan+ITxo9Rgeue4bQCM5Lbzae0rQAvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4kt9TmEPrWfnJEJXi5/XL+t7VfQ6JnozapDUo1MacI1hv89ATpWMVgTdDciIj+cQ
	 iT/xJcEu/nU3vqULz5+JIve8qDhHIa7ENLGQCF3kUeQ7VFMdU3zkxYKZDDy+v8/qeI
	 FKg/Rxt6uEZ1VHXVyRpTVYHv0/plYp1iS1ZBpGIlvVbkSh1fAn0/mfkrULTCfQnyIF
	 V5M+P9T+7CNPtn5p9DMKSmhL43+Tlp2LBAPeVGnKrfpYP2lyhrkSf/8/eS9ZyFw3pG
	 b88fAFy9yOpfTnq9uY4nkQUc+EigNHzFUg5QHpDDNEmpOZYj5xI5XXkDggXS2D7+OW
	 v61KRYaMMFONA==
Date: Thu, 4 Jul 2024 06:47:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org,
 mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
 paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 02/12] uprobes: correct mmap_sem locking assumptions
 in uprobe_write_opcode()
Message-Id: <20240704064757.a16df4fdcd4418e794a6cdfa@kernel.org>
In-Reply-To: <CAEf4BzY6k6tomV_Vf51MtmfvrzoNAH8APPuT4=UM3XTzf29P0w@mail.gmail.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
	<20240701223935.3783951-3-andrii@kernel.org>
	<20240703221525.dff79d6c71af3921ca7a7232@kernel.org>
	<CAEf4BzY6k6tomV_Vf51MtmfvrzoNAH8APPuT4=UM3XTzf29P0w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 11:25:35 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Jul 3, 2024 at 6:15 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon,  1 Jul 2024 15:39:25 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > It seems like uprobe_write_opcode() doesn't require writer locked
> > > mmap_sem, any lock (reader or writer) should be sufficient. This was
> > > established in a discussion in [0] and looking through existing code
> > > seems to confirm that there is no need for write-locked mmap_sem.
> > >
> > > Fix the comment to state this clearly.
> > >
> > >   [0] https://lore.kernel.org/linux-trace-kernel/20240625190748.GC14254@redhat.com/
> > >
> > > Fixes: 29dedee0e693 ("uprobes: Add mem_cgroup_charge_anon() into uprobe_write_opcode()")
> >
> > nit: why this has Fixes but [01/12] doesn't?
> >
> > Should I pick both to fixes branch?
> 
> I'd keep both of them in probes/for-next, tbh. They are not literally
> fixing anything, just cleaning up comments. I can drop the Fixes tag
> from this one, if you'd like.

Got it. Usually cleanup patch will not have Fixed tag, so if you don't mind,
please drop it.

Thank you,

> 
> >
> > Thank you,
> >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/events/uprobes.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 081821fd529a..f87049c08ee9 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
> > >   * @vaddr: the virtual address to store the opcode.
> > >   * @opcode: opcode to be written at @vaddr.
> > >   *
> > > - * Called with mm->mmap_lock held for write.
> > > + * Called with mm->mmap_lock held for read or write.
> > >   * Return 0 (success) or a negative errno.
> > >   */
> > >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

