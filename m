Return-Path: <bpf+bounces-66760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9BB38FC2
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1962B4605E7
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FF16132F;
	Thu, 28 Aug 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2wNQ+DD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57930CDA0
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340893; cv=none; b=TPqGJijNg5+lmpl8BQq1e3gXIjkZSnFeUfW9jzAb/AyFX0YPrVxrEXoBq/8s85EKk5AePdvApL/KSMSilHu3Tp1w2VrPhxjveKt5Z6nLPH3yDri0ZY6z4MsEUeiHyY+untW0tLtdkRNiOs1imjx27ZvdGqbwJUAVkSSqhMz9Hgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340893; c=relaxed/simple;
	bh=e6BVmwpeKy0B7deePUV4HKeeWeN00yuX81j8HqWK6Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCQBBHP2PdZ3k4aT88qvzpKzMHgNPer3ZXBBhLytqmZP8vCbxdh7iKqRs22z0D03ppzspDPgD4vWo6CaLdIUxNHeLtzR+/FT1okXmDNHIcw1G6kM0tz8U/o/DDin1Yqm5iFOWE4OGgXBXnqP3+y7gJFGVW/quqMGvtWZja1wWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2wNQ+DD; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afebb6d3f2bso49765466b.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756340890; x=1756945690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rEI434mnrlYpReZ+rC2PUbb5NU5vJo6QGuQoziKP2Q=;
        b=e2wNQ+DD2r1aBw2gEcvp/7PLjYuX/BZiyKQCqs/uZsUTx1Z3XKxtAoMBrPA7Av8q/K
         Q5a8wAQOLcciFyRJmHrHYAc1/uDl59NthKcUIqcWoUrg4GJRem6/tnW+ZWyN3YQY95dW
         Lw5ZTYbqlk7cWfY/DUEDNIP4w51Of6QDsoxdpFi0UpI0t/W0IkPs2ZPz9Eka35DbaMEj
         d8FJkA7TnseXvfHPLGdOXHfwtT7PDF4r21p+KHIN1juf0tJyKGdLMBvysSQ0/kwjrC1c
         1lZVNUC9BzaxMUUahvT+ioqt26kjV25arivzo4ryY8fz9d17G+UJwjfx1uBXg88BC4Nq
         t5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340890; x=1756945690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rEI434mnrlYpReZ+rC2PUbb5NU5vJo6QGuQoziKP2Q=;
        b=NUsn+TFStySZ2ra9VTxZPj+B4W7cwHZOr1OgA/y8+64Ol16WsQ84FWFvTDSvL5KMwj
         eb6+4w1DSRMmk9mTQLUnRw9Z7Rk85RgDrjDslIynMkr7uHMJ7W2g/OWS65PjmG9VKd5R
         21YnCl8nbZtyAxznhrCp5XOsh+7qg/9/mXGA32KWV00yk5KQQFSPrZ0rj6DnsAGQmCaa
         kRQz68qlkrbCYFSMNyu90+/dIOM6Ky+sHUer+q4fUv/1r4IlOAB2VQ4GKp+4rL5OLspq
         DixOPj8QFJjsA/dGSv244S1H+b5soEjzssGEeryI/FLqK2U/GGgmY2v1urKpSnNori6C
         0GUw==
X-Forwarded-Encrypted: i=1; AJvYcCXd9bcSGZG5aJAJadY/nfaZXerWAWoalgzvXzb7NfwkQnjQ3p0dAWKgx3KxAKOKNYqfHzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8F1SvTI7DUrRlS+RshexkCXxdza/9eFxW1IZAAQ+5QAtTSWa
	xDh12Tu7ASCoMJsFlHSi8qzt5kGlADFCgW5KX6RfYiVo/VeImylXbP1nqPKUk3MeUFcqU9E2mXW
	ksehLHQ0GXHjEZyqtqWGz1YonnIMH+Ns=
X-Gm-Gg: ASbGnctNaKWfWD6xSSu4HF5TJQVK2bWIQ2UylDdUjqROT+zS3fWAvsJWbjSlfBQdLRK
	m+BLBwT+IgO6n/0bV7pLKPI4KXMRdh4QpMd5Yqj6FmLKHAlv6xT/tqTigOgiXyaOqlxV9oUGlVO
	kLS2GDEQzoO6h5sAnX52lou4PCebbb95WgHFiSQ6iLh6eTF1ffV+j9brMg6OcyM2r4KcA//Zaqq
	XjvTnP4IsN82ndbH1sx7xcdpJ1TzlB8dZUNE4ulvZVftuzipQs=
X-Google-Smtp-Source: AGHT+IE2IxAJuwV+wwwbyxvfcLUaxdPT5wDxUZLyy9b1IJVRdWitIayM6f4C6A73IKteuiS+X3QfpRoQ6RuIFl0OhT4=
X-Received: by 2002:a17:907:3daa:b0:afe:ca26:547b with SMTP id
 a640c23a62f3a-afeca265a09mr332623766b.35.1756340889890; Wed, 27 Aug 2025
 17:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org> <20250827153728.28115-3-puranjay@kernel.org>
 <CAP01T75ajCxNOPLyJzpAb9bnOJLyKFNDAgXqnEQZpGdXOp6CFw@mail.gmail.com>
In-Reply-To: <CAP01T75ajCxNOPLyJzpAb9bnOJLyKFNDAgXqnEQZpGdXOp6CFw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Aug 2025 02:27:33 +0200
X-Gm-Features: Ac12FXxdi07ulYYwR7HpG8LbVTkzvq3D8w2Lit7teyhdjdhjGAWQawLZbtRrcCI
Message-ID: <CAP01T74Z8rxYDpJuaoO_PrCL4Qt9AN60-54KUfNQwVo=UQq5ZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 02:22, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 27 Aug 2025 at 17:37, Puranjay Mohan <puranjay@kernel.org> wrote:
> >
> > Begin reporting arena page faults and the faulting address to BPF
> > program's stderr, this patch adds support in the arm64 and x86-64 JITs,
> > support for other archs can be added later.
> >
> > The fault handlers receive the 32 bit address in the arena region so
> > the upper 32 bits of user_vm_start is added to it before printing the
> > address. This is what the user would expect to see as this is what is
> > printed by bpf_printk() is you pass it an address returned by
> > bpf_arena_alloc_pages();
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  [...]
> >
> >  bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
> >  {
> > -       u32 reg = x->fixup >> 8;
> > +       u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
> > +       u32 insn_len = FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
> > +       bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
> > +       bool is_write = (reg == DONT_CLEAR);
> > +       unsigned long addr;
> > +       s16 off;
> > +       u32 arena_reg;
> >
> >         /* jump over faulting load and clear dest register */
> >         if (reg != DONT_CLEAR)
> >                 *(unsigned long *)((void *)regs + reg) = 0;
> > -       regs->ip += x->fixup & 0xff;
> > +       regs->ip += insn_len;
> > +
> > +       if (is_arena) {
> > +               arena_reg = FIELD_GET(FIXUP_ARENA_REG_MASK, x->fixup);
> > +               off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
> > +               addr = *(unsigned long *)((void *)regs + arena_reg) + off;
>
> Same question. I faintly remember I spent a few hours when I
> implemented this, wondering why the reported address was always zeroed
> out for x86 before realizing they can be the same.
> It would be good to add a test for this condition.
> And also, to work around this, the address needs to be captured before
> the destination register is cleared.

To be clear, to have such a test, you'd want to write it in inline
assembly to make sure compiler shenanigans don't screw up things.

>
> > [...]

