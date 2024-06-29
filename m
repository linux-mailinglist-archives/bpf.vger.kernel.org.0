Return-Path: <bpf+bounces-33442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E682F91CFAA
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839DF1F21BA8
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002C12FF88;
	Sat, 29 Jun 2024 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcvHQ6Ja"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4EE374FA;
	Sat, 29 Jun 2024 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719703817; cv=none; b=S4PDP8Js5BjO9sIhTocJq4Q5aBCgfN5Tif+92gTgMpI7KsfuDNm1D109wLgu6EFIywGP1lDpFEp4Pe84h8NLct4Yjq3dV+qd9pfQ8ZX5i4uUHoiPUH0tNKOzDLynPWNRw9v9Hlp+X+103zhfY0bmGbVEtxgC377VElUwhRrWIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719703817; c=relaxed/simple;
	bh=BxVbkFkNCRgnICzgALLTUBsQGL6A6EdkoAO//1PoZnQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a+bdn1FUxIt8biHTFyExs7DQYmXsJNfHAcstdWHloz50zXYf1G80e2eDAc+yQEvi+u8emyPlRrN4POaC+HKB8kZjHvzJmsMqcXugIwyt06MDcHpJmTpCDfhFGearM7OJqBvHgfTYvSxTGl4S+ZdRVZ1ggNaIkoKHb6V0hH0fDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcvHQ6Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D2FC2BBFC;
	Sat, 29 Jun 2024 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719703817;
	bh=BxVbkFkNCRgnICzgALLTUBsQGL6A6EdkoAO//1PoZnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcvHQ6JaDlU++dDmDvAhjFqAgwytvFDMRNMLS69Ng4Wv7fxXSWLgDtR2gDDVu30A6
	 5d0EG47n/GE1Z8s1ZEO5PFc2awNQ7U+hZTVT/5P7hQm4kEhFnMDTnAV4scRIq0O2rF
	 ikFt+cX9E8K5n1BXH/Pxw8FU5MSHYnAaeio2j2BbvcuSkbk9NKbLClrEgtye0ngqWY
	 VJeUqdC11oSHftNRtqMebpgvNs8RmIe5GTDXZTyj99bJGEPZe2sgdaVoETbT+uKsa6
	 XBUp2dns+0hzo7U+6B8dp3jB65DCZPZGZJKLX2tXdsx6XstjEfGu8/1L5EdwdziwfA
	 yFUPISYqvsvjw==
Date: Sun, 30 Jun 2024 08:30:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org,
 mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
 paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister
 APIs
Message-Id: <20240630083010.99ff77488ec62b38bcfeaa29@kernel.org>
In-Reply-To: <CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
References: <20240625002144.3485799-1-andrii@kernel.org>
	<20240625002144.3485799-7-andrii@kernel.org>
	<20240627220449.0d2a12e24731e4764540f8aa@kernel.org>
	<CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
	<20240628152846.ddf192c426fc6ce155044da0@kernel.org>
	<CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 09:34:26 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Jun 27, 2024 at 11:28 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 27 Jun 2024 09:47:10 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > On Thu, Jun 27, 2024 at 6:04 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Mon, 24 Jun 2024 17:21:38 -0700
> > > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > > -static int __uprobe_register(struct inode *inode, loff_t offset,
> > > > > -                          loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> > > > > +int uprobe_register_batch(struct inode *inode, int cnt,
> > > > > +                       uprobe_consumer_fn get_uprobe_consumer, void *ctx)
> > > >
> > > > Is this interface just for avoiding memory allocation? Can't we just
> > > > allocate a temporary array of *uprobe_consumer instead?
> > >
> > > Yes, exactly, to avoid the need for allocating another array that
> > > would just contain pointers to uprobe_consumer. Consumers would never
> > > just have an array of `struct uprobe_consumer *`, because
> > > uprobe_consumer struct is embedded in some other struct, so the array
> > > interface isn't the most convenient.
> >
> > OK, I understand it.
> >
> > >
> > > If you feel strongly, I can do an array, but this necessitates
> > > allocating an extra array *and keeping it* for the entire duration of
> > > BPF multi-uprobe link (attachment) existence, so it feels like a
> > > waste. This is because we don't want to do anything that can fail in
> > > the detachment logic (so no temporary array allocation there).
> >
> > No need to change it, that sounds reasonable.
> >
> 
> Great, thanks.
> 
> > >
> > > Anyways, let me know how you feel about keeping this callback.
> >
> > IMHO, maybe the interface function is better to change to
> > `uprobe_consumer *next_uprobe_consumer(void **data)`. If caller
> > side uses a linked list of structure, index access will need to
> > follow the list every time.
> 
> This would be problematic. Note how we call get_uprobe_consumer(i,
> ctx) with i going from 0 to N in multiple independent loops. So if we
> are only allowed to ask for the next consumer, then
> uprobe_register_batch and uprobe_unregister_batch would need to build
> its own internal index and remember ith instance. Which again means
> more allocations and possibly failing uprobe_unregister_batch(), which
> isn't great.

No, I think we can use a cursor variable as;

int uprobe_register_batch(struct inode *inode,
                 uprobe_consumer_fn get_uprobe_consumer, void *ctx)
{
	void *cur = ctx;

	while ((uc = get_uprobe_consumer(&cur)) != NULL) {
		...
	} 

	cur = ctx;
	while ((uc = get_uprobe_consumer(&cur)) != NULL) {
		...
	} 
}

This can also remove the cnt.

Thank you,

> 
> For now this API works well, I propose to keep it as is. For linked
> list case consumers would need to allocate one extra array or pay the
> price of O(N) search (which might be ok, depending on how many uprobes
> are being attached). But we don't have such consumers right now,
> thankfully.
> 
> >
> > Thank you,
> >
> >
> > >
> > > >
> > > > Thank you,
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

