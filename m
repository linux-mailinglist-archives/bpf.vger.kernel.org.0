Return-Path: <bpf+bounces-45424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797769D5616
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319C91F240C5
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4481DDC39;
	Thu, 21 Nov 2024 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBWrolMq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6881BD4EB
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230779; cv=none; b=giLMalhFTNrcR6KNgRy0bLERA3l42KPYo9u5UnmQgpmUV1F/8sIvP/yasIlGjnoWTLAJyBq3C9ik0lb3hARN9xNyCfqw1eAy5esrAtXQZBCIBKL7Oc4YxCPsDQFzIt+PI6DbNsAmQVEl3VP1UPkbIVpBbc4KZcbL0joNs/QMHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230779; c=relaxed/simple;
	bh=rVkuvt4goniYvY6b74F8TKCckXG+vfD12+QT5RBNvao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7aLQH7gtD50WPJK8IiPo1oEf0a+fEhMtHPwUvxkOBDONcjYZwtEKSABs09NmsVjnqfUEGPocqrsEOVOmYOWCXHwaaPX7RT62KN908CGUz2zB0CD7TOskEr/cwf+B/7Ff2jLoqiER4Y7YynPNXGiZ/X23pzVAWCf+fzvCRMjtik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBWrolMq; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5cfddc94c83so1855945a12.3
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732230776; x=1732835576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gdl8LMDTR9iUIRIqjiTXF76cMWPo04Phy8LzHxP5YL4=;
        b=GBWrolMq0Ed9MMnadcWpEuStUofOdAl7h5chCrUXfutcGIxew2+FIyBnQfaAC/dXwt
         Mbj1FM4/Q0H4Cr1Ui9cM35h5LJsox4KtViBc+abgsn3Y8G1Buh5Kiqi0Q0ClJVWfE+CE
         oKLdqWcw4bhHTkNkQkxg7FG+lnNa+ZIee/bn1r23IRCvWETiUPOI3PPhRnOg9MeaJ6PN
         VM6sTrpsZq4g1TH13OJrfj+fzti7hk1pSPuuJ8xYA+/Bud4xqI437BpdTxKmspePUmYv
         Tr8K564MU0YE/DeUXtAyEdMNduIPHTfWAn38aothmaCJdNf4NQoYWaWU6WYllbA/gNIY
         aVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732230776; x=1732835576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gdl8LMDTR9iUIRIqjiTXF76cMWPo04Phy8LzHxP5YL4=;
        b=uIxn39XXLaiuAD90a6ayLjrdJu3N5YcWJhOf+oAoBVE+2SCGD1VXveB16NM37/Pc4f
         q3PWOazxh7FLtGMvRXLLNN7LhB4ddzhEhQhRWWPsk0gh5AKQ8nn5S3GQd8yS9xakLVMl
         oYgQwwV8t0omdmsHJNCJ3aMmkmsJ5/nbMqymcgJgZtDrNg5ECf18QsRN3uFW6ZInc4aB
         ipgIMSYuiTeVR03Je/1GQhC81pPbluWgdh9Gw2rk+8umvRg+6nwRLhnt26Pj0lNffBvZ
         JYZUh347s4jxE06WYY2dIxonIOhQjsZQ8OIiHOcD8IxjGT+J0cq+rwQVZPN/S65anhvw
         XJEw==
X-Gm-Message-State: AOJu0YyLLTWALkUj5qr5YKU+qqL70gt0VApiFDFYF60xVFRsUn1XqN3C
	VC1vLBU8L9BDDWTJs7mXQequZ1X9f0agc8WT6ciNai08nk9i8jNlmPlElHTlpTRsHDOxr22Ejg/
	mn5swUTg+TaL9pRXUARXlqhQq77c=
X-Gm-Gg: ASbGncuOTB0zYo/c375sCNY6ANyN/2Z1H6Jibu1wsN1+JHQLRKZqAzIUQe57kxeqaR5
	NY1cE4uK9QmhWKj+6VPNYI6M044oH9RqTGg==
X-Google-Smtp-Source: AGHT+IFhVkZ2LzGKXQuJcGtRSZ5ZhzlPHxbhpLR872WNJB35fMiv7+PMZUkAftBwtr4HfpQ2PSjNauGyrUT2VB4tM4w=
X-Received: by 2002:a05:6402:27c8:b0:5cf:657b:bf0 with SMTP id
 4fb4d7f45d1cf-5d0207c1530mr280869a12.29.1732230775867; Thu, 21 Nov 2024
 15:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-6-memxor@gmail.com>
 <c49e756f6e4ef492a68b7cd3b856240282963f8e.camel@gmail.com>
 <CAP01T75FEfodis5YLie5kBPG4FSyyinSAa0m+ZP8H+_PhseWRQ@mail.gmail.com> <46250fef76c4b78eb283c724f27fcf4e275d4839.camel@gmail.com>
In-Reply-To: <46250fef76c4b78eb283c724f27fcf4e275d4839.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 22 Nov 2024 00:12:19 +0100
Message-ID: <CAP01T76QF3HqCPaB8LhG+b6UuDJrXPdqzsSgZgSG=DXVAwKDpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Introduce support for bpf_local_irq_{save,restore}
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 00:08, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-11-21 at 23:06 +0100, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > > > +/* Keep unsinged long in prototype so that kfunc is usable when emitted to
> > > > + * vmlinux.h in BPF programs directly, but since unsigned long may potentially
> > > > + * be 4 byte, always cast to u64 when reading/writing from this pointer as it
> > > > + * always points to an 8-byte memory region in BPF stack.
> > > > + */
> > > > +__bpf_kfunc void bpf_local_irq_save(unsigned long *flags__irq_flag)
> > >
> > > Nit: 'unsigned long long' is guaranteed to be at-least 64 bit.
> > >      What would go wrong if 'u64' is used here?
> >
> > It goes like this:
> > If I make this unsigned long long * or u64 *, the kfunc emitted to
> > vmlinux.h expects a pointer of that type.
> > Typically, kernel code is always passing unsigned long flags to these
> > functions, and that's what people are used to.
> > Given for --target=bpf unsigned long * is always a 8-byte value, I
> > just did this, so that in kernels that are 32-bit,
> > we don't end up relying on unsigned long still being 8 when
> > fetching/storing flags on BPF stack.
>
> So, the goal is to enable the following pattern:
>
>   unsigned long flags;
>   bpf_local_irq_save(&flags);
>
> Right?
>
> For a 32-bit system 'flags' would be 4 bytes long.
> Consider the following example:
>
>   unsigned long flags; // assume 'flags' and 'foo'
>   int foo;             // are allocated sequentially.
>
>   bpf_local_irq_save(&flags);
>
> I think that in such case '*ptr = flags;' would overwrite foo.

In the kernel or userspace, yes, but I'm assuming unsigned long will
always be 64-bit for target=BPF.
Would that be incorrect? This pattern will only happen within BPF programs.

>
> [...]
>
> > > > +{
> > > > +     u64 *ptr = (u64 *)flags__irq_flag;
> > > > +     unsigned long flags;
> > > > +
> > > > +     local_irq_save(flags);
> > > > +     *ptr = flags;
> > > > +}
>

