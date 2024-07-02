Return-Path: <bpf+bounces-33590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B02D91EC2C
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C1428358D
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE374A06;
	Tue,  2 Jul 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ1xtqtT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86191BE49;
	Tue,  2 Jul 2024 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882116; cv=none; b=bjDIPGFXrgnEHRz3+cx70ngCuVSEjpxP2UZMewPrL2rD2XGBsLLcKROTDjkw/YBoBIwUo9BAJ82+VoVg6H3QcSmPqWzNKfyK3LAQDcfR19H8aUYLfsgRFBOTtjg+Q2zjnhg/mG6+yby+564obgNKhYhGk18mJg0t5RpauMnQdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882116; c=relaxed/simple;
	bh=tku4nj4P+xC4aggrTr+M8vd5ZYT4Rc+pckRb8grTlmE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sjxvW1IPyF2f/ziknMhN50lIrPcMUQG8wvWjgcEU/9l9o9hx+EkAkfv5WUEbNnhmSFmJ0Xsr8+PO4wLRRUIMvi9SlGPnponXBv0rglRtD3h03XH5g7qkZakd8BjxIy9fITZfmQ4T0RhjXqMAt61ntCzFEIviNt/zzgVmefPE1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ1xtqtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33D2C116B1;
	Tue,  2 Jul 2024 01:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719882116;
	bh=tku4nj4P+xC4aggrTr+M8vd5ZYT4Rc+pckRb8grTlmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pJ1xtqtTQIuYd053sa08n6AEnkbq15d9+9sPZml1imzpxNY/m+sIXxgj4daKr2Ezz
	 Yi3Smial6urzJ/fYjwQcMP8CX15C8f8leqy9GcW3xGeN7mmSuZj3+JoiYwrv8AQgVT
	 jmnm6MUFKXNFb9tzUDH70JeT4ypV+YU2dLWHsYRcxekA2Ts9GVqFDLvh22NwHSq4UH
	 2GCMXpkxfodNzBOV4fMkpHLSe/Y7P89t2QBoNsSJUxx0zUPQ2uwcfOA0l8s+D/4xbk
	 Mv3Fj1mq+83+ohwJ0ciM8C1vc7jp9RXFRBMWGncNi5YcbEfyJmKIUksolHS+GeQ6JE
	 0EAULcrezr0Sg==
Date: Tue, 2 Jul 2024 10:01:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org,
 mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
 paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister
 APIs
Message-Id: <20240702100151.509a9e45c04a9cfed0653e6f@kernel.org>
In-Reply-To: <CAEf4BzbRQjK7nnR2nnw_hgYztPPxaSC6_qFTrdADy3yCki_wEA@mail.gmail.com>
References: <20240625002144.3485799-1-andrii@kernel.org>
	<20240625002144.3485799-7-andrii@kernel.org>
	<20240627220449.0d2a12e24731e4764540f8aa@kernel.org>
	<CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
	<20240628152846.ddf192c426fc6ce155044da0@kernel.org>
	<CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
	<20240630083010.99ff77488ec62b38bcfeaa29@kernel.org>
	<CAEf4BzZh4ShURvqk-QxC5h1NpN0tjWMr1db+__gsCmr-suUNOQ@mail.gmail.com>
	<CAEf4BzbRQjK7nnR2nnw_hgYztPPxaSC6_qFTrdADy3yCki_wEA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 1 Jul 2024 15:15:56 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Jul 1, 2024 at 10:55 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Jun 29, 2024 at 4:30 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Fri, 28 Jun 2024 09:34:26 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > On Thu, Jun 27, 2024 at 11:28 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > >
> > > > > On Thu, 27 Jun 2024 09:47:10 -0700
> > > > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > > On Thu, Jun 27, 2024 at 6:04 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, 24 Jun 2024 17:21:38 -0700
> > > > > > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > > > >
> > > > > > > > -static int __uprobe_register(struct inode *inode, loff_t offset,
> > > > > > > > -                          loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> > > > > > > > +int uprobe_register_batch(struct inode *inode, int cnt,
> > > > > > > > +                       uprobe_consumer_fn get_uprobe_consumer, void *ctx)
> > > > > > >
> > > > > > > Is this interface just for avoiding memory allocation? Can't we just
> > > > > > > allocate a temporary array of *uprobe_consumer instead?
> > > > > >
> > > > > > Yes, exactly, to avoid the need for allocating another array that
> > > > > > would just contain pointers to uprobe_consumer. Consumers would never
> > > > > > just have an array of `struct uprobe_consumer *`, because
> > > > > > uprobe_consumer struct is embedded in some other struct, so the array
> > > > > > interface isn't the most convenient.
> > > > >
> > > > > OK, I understand it.
> > > > >
> > > > > >
> > > > > > If you feel strongly, I can do an array, but this necessitates
> > > > > > allocating an extra array *and keeping it* for the entire duration of
> > > > > > BPF multi-uprobe link (attachment) existence, so it feels like a
> > > > > > waste. This is because we don't want to do anything that can fail in
> > > > > > the detachment logic (so no temporary array allocation there).
> > > > >
> > > > > No need to change it, that sounds reasonable.
> > > > >
> > > >
> > > > Great, thanks.
> > > >
> > > > > >
> > > > > > Anyways, let me know how you feel about keeping this callback.
> > > > >
> > > > > IMHO, maybe the interface function is better to change to
> > > > > `uprobe_consumer *next_uprobe_consumer(void **data)`. If caller
> > > > > side uses a linked list of structure, index access will need to
> > > > > follow the list every time.
> > > >
> > > > This would be problematic. Note how we call get_uprobe_consumer(i,
> > > > ctx) with i going from 0 to N in multiple independent loops. So if we
> > > > are only allowed to ask for the next consumer, then
> > > > uprobe_register_batch and uprobe_unregister_batch would need to build
> > > > its own internal index and remember ith instance. Which again means
> > > > more allocations and possibly failing uprobe_unregister_batch(), which
> > > > isn't great.
> > >
> > > No, I think we can use a cursor variable as;
> > >
> > > int uprobe_register_batch(struct inode *inode,
> > >                  uprobe_consumer_fn get_uprobe_consumer, void *ctx)
> > > {
> > >         void *cur = ctx;
> > >
> > >         while ((uc = get_uprobe_consumer(&cur)) != NULL) {
> > >                 ...
> > >         }
> > >
> > >         cur = ctx;
> > >         while ((uc = get_uprobe_consumer(&cur)) != NULL) {
> > >                 ...
> > >         }
> > > }
> > >
> > > This can also remove the cnt.
> >
> > Ok, if you prefer this I'll switch. It's a bit more cumbersome to use
> > for callers, but we have one right now, and might have another one, so
> > not a big deal.
> >
> 
> Actually, now that I started implementing this, I really-really don't
> like it. In the example above you assume by storing and reusing
> original ctx value you will reset iteration to the very beginning.
> This is not how it works in practice though. Ctx is most probably a
> pointer to some struct somewhere with iteration state (e.g., array of
> all uprobes + current index), and so get_uprobe_consumer() doesn't
> update `void *ctx` itself, it updates the state of that struct.

Yeah, that should be noted so that if the get_uprobe_consumer() is
called with original `ctx` value, it should return the same.
Ah, and I found we need to pass both ctx and pos...

       while ((uc = get_uprobe_consumer(&cur, ctx)) != NULL) {
                 ...
         }

Usually it is enough to pass the cursor as similar to the other
for_each_* macros. For example, struct foo has .list and .uc, then

struct uprobe_consumer *get_uprobe_consumer_foo(void **pos, void *head)
{
	struct foo *foo = *pos;

	if (!foo)
		return NULL;

	*pos = list_next_entry(foo, list);
	if (list_is_head(pos, (head)))
		*pos = NULL;

	return foo->uc;
}

This works something like this.

#define for_each_uprobe_consumer_from_foo(uc, pos, head) \
	list_for_each_entry(pos, head, list) \
		if (uc = uprobe_consumer_from_foo(pos))

or, for array of *uprobe_consumer (array must be end with NULL), 

struct uprobe_consumer *get_uprobe_consumer_array(void **pos, void *head __unused)
{
	struct uprobe_consumer **uc = *pos;

	if (!*uc)
		return NULL;

	*pos = uc + 1;

	return *uc;
}

But this may not be able to support array of uprobe_consumer. Hmm.


> And so there is no easy and clean way to reset this iterator without
> adding another callback or something. At which point it becomes quite
> cumbersome and convoluted.

If you consider that is problematic, I think we can prepare more
iterator like object;

struct uprobe_consumer_iter_ops {
	struct uprobe_consumer *(*start)(struct uprobe_consumer_iter_ops *);
	struct uprobe_consumer *(*next)(struct uprobe_consumer_iter_ops *);
	void *ctx; // or, just embed the data in this structure.
};


> How about this? I'll keep the existing get_uprobe_consumer(idx, ctx)
> contract, which works for the only user right now, BPF multi-uprobes.
> When it's time to add another consumer that works with a linked list,
> we can add another more complicated contract that would do
> iterator-style callbacks. This would be used by linked list users, and
> we can transparently implement existing uprobe_register_batch()
> contract on top of if by implementing a trivial iterator wrapper on
> top of get_uprobe_consumer(idx, ctx) approach.

Agreed, anyway as far as it uses an array of uprobe_consumer, it works.
When we need to register list of the structure, we may be possible to
allocate an array or introduce new function.

Thank you!

> 
> Let's not add unnecessary complications right now given we have a
> clear path forward to add it later, if necessary, without breaking
> anything. I'll send v2 without changes to get_uprobe_consumer() for
> now, hopefully my above plan makes sense to you. Thanks!
> 
> > >
> > > Thank you,
> > >
> > > >
> > > > For now this API works well, I propose to keep it as is. For linked
> > > > list case consumers would need to allocate one extra array or pay the
> > > > price of O(N) search (which might be ok, depending on how many uprobes
> > > > are being attached). But we don't have such consumers right now,
> > > > thankfully.
> > > >
> > > > >
> > > > > Thank you,
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Thank you,
> > > > > > >
> > > > > > > --
> > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

