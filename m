Return-Path: <bpf+bounces-33333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155DB91B704
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 08:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02081F239BF
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A855E58;
	Fri, 28 Jun 2024 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLjXV3Vn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EB55893;
	Fri, 28 Jun 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556130; cv=none; b=T4IztQLyGpYiEpmlYl9qQ9v9AzNp7apgl7932jczgcfGpW2KIqxyyoR3gTHbANOTZKOi1lnWu2pfZmpZUd4vTg1JWJ1IlWy2ylYoUOgMaIUzYm7bZmfWlLm6A/6lZKtLoOrj4vsEqhep2W/O0VgLvTsqxv7SyVb3RcFJUQQqFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556130; c=relaxed/simple;
	bh=yu7OApd9rpVLjGuCR396PEC7tCtaG8vSTpdjfmji5SA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KfWvSMcNwlSfouEN+FztaNg+bQ26yJvrBAkueUnzsgajR/0Iw8ad1eHJC58dnzBcrC3YGTur+0NpuH+GKcURoiWdIhsThwzvzLcEvD08hzX6SjuAWxBFUqfoX6LLswqoDMXSCuQCFuScTWLXMvKwLuXo4tQOmJbIzjCWZYwqlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLjXV3Vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B21AC2BD10;
	Fri, 28 Jun 2024 06:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719556130;
	bh=yu7OApd9rpVLjGuCR396PEC7tCtaG8vSTpdjfmji5SA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OLjXV3Vny3bjMmmSo7GZiPrRrOzl4uKdrKDvSoYwfCDrSYbU4AIKVV+dNGSnxpnit
	 zwbWS0aHWCLgvnOpVWdDQ48kujDblDLq0Zsa8S++GzHoxcqbQFQ4ucXc/WCvetopvH
	 BICuGX14KdoNm+wbPtO4IVa1P8Y13VFTaw4yOPa/WlxtStc6MazR95RU13gOnTGsTR
	 +2fIJ1molz47a35C7Yqeq7K2GbalSAl1gb7Im1hR1DeAcbf9bemx7L9vnQ7EOF+InX
	 CKoJ1JdaGSKQhxXvbRuaJ6+lXjvrJnxYsP9OTZrLj2YTnUs8al8tRNQyGgRKcu+QTi
	 U4dtcnkZZU2Lw==
Date: Fri, 28 Jun 2024 15:28:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org,
 mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
 paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister
 APIs
Message-Id: <20240628152846.ddf192c426fc6ce155044da0@kernel.org>
In-Reply-To: <CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
References: <20240625002144.3485799-1-andrii@kernel.org>
	<20240625002144.3485799-7-andrii@kernel.org>
	<20240627220449.0d2a12e24731e4764540f8aa@kernel.org>
	<CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 27 Jun 2024 09:47:10 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Jun 27, 2024 at 6:04 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon, 24 Jun 2024 17:21:38 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > -static int __uprobe_register(struct inode *inode, loff_t offset,
> > > -                          loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> > > +int uprobe_register_batch(struct inode *inode, int cnt,
> > > +                       uprobe_consumer_fn get_uprobe_consumer, void *ctx)
> >
> > Is this interface just for avoiding memory allocation? Can't we just
> > allocate a temporary array of *uprobe_consumer instead?
> 
> Yes, exactly, to avoid the need for allocating another array that
> would just contain pointers to uprobe_consumer. Consumers would never
> just have an array of `struct uprobe_consumer *`, because
> uprobe_consumer struct is embedded in some other struct, so the array
> interface isn't the most convenient.

OK, I understand it.

> 
> If you feel strongly, I can do an array, but this necessitates
> allocating an extra array *and keeping it* for the entire duration of
> BPF multi-uprobe link (attachment) existence, so it feels like a
> waste. This is because we don't want to do anything that can fail in
> the detachment logic (so no temporary array allocation there).

No need to change it, that sounds reasonable.

> 
> Anyways, let me know how you feel about keeping this callback.

IMHO, maybe the interface function is better to change to
`uprobe_consumer *next_uprobe_consumer(void **data)`. If caller
side uses a linked list of structure, index access will need to
follow the list every time.

Thank you,


> 
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

