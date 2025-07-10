Return-Path: <bpf+bounces-62865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40757AFF60F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 02:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB7D1C4259B
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256049620;
	Thu, 10 Jul 2025 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6eke5UL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B088F54;
	Thu, 10 Jul 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108002; cv=none; b=VFkgZornRT9xh9AeajeeqBaMzxI//xDEOCYaFXF47qgGZCIdl9BZtTb+kyLOmE8WTfnrBeZfvfvXprKHLtz4X64K5FoPoF27A0yib/Mb1MWY7TXqKuieeITFLS2iRSz+7tbAXCIyYSO6kit3wzEHvnLtZlncIbT652ffMCft1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108002; c=relaxed/simple;
	bh=5xrWVx1C9s45tbIV36ojtnaAGXS4aJVjxBP/Z8QyPxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXoU83nDfAHgeSlWcYnZ0c3RbOJBG4jWIEpBnTOLGXHZ3i12e6jpo5C94NjnPCcdwA9NU0qLhxRzQcBsRayHFHiX840p2CuEhv6Tc3sZDqWTSBMaVVmlctMISzsdUm3FCTU2jHjJrAZdxATebTYpA41HySDOClSQ2DqTZ5feUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6eke5UL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so300015f8f.1;
        Wed, 09 Jul 2025 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752107999; x=1752712799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+EH9We4Q8uZNtUfBicIKlMK3P33lcOOMogm1wF7Hgw=;
        b=I6eke5ULShzQt77sqJZ5FK65QkG9AkFy2SFVQUDDoU+5875HLhiVnlkRfjbJYq25eH
         O3feeB7uDUniT0tYu3xrpTkB8hkDDupEx59mT+K8Swn607apk/ncj65Fo8YaaHbf6wTc
         FL9t4lxBcGei+mufz7K/yk98LrsLo4bsH7YfZhJPVu9LdxXG6xpWK0AF6X4704bnb6Ar
         5zBosYqJ3gPof1K28sTIAEN302ZP3pCXp0nr0eMF1AJgRcucXQ89CEqI1JK9Uht93+/p
         /Ga4bV+L//dP1j2BUYvJYPf4MDMKcgL8h6BGAb9vwI2bnYwjrRd4GQzr0hUA9WW0PzgM
         g+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752107999; x=1752712799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+EH9We4Q8uZNtUfBicIKlMK3P33lcOOMogm1wF7Hgw=;
        b=jrbAJxmyVR58tI5SOk3P9KwezecqjNz+tVYZC0yx/oLOCB3Sz5EXXp3fVmUgw55Y33
         Kpi/glcngPPHCSxGjapdcC6JtLTV/9bzzjuEDFis2wF4iFhDHO3IF1bDpuEBBH2eGoBV
         r2HgS1tN7KvJmHyMfI/OG9pUh4wm8BKHgYJdtbMknAZjaujYl+4xQRhyGXyTWI4nDDfh
         +5z73wQ/wr1QEvHSkqEiCcB9Xhh5MiSKdG3j96cLC2BOauvF+MMA3HPYJGZDlC/MnqcC
         lrABx9/mz2zPyJm1MJAL279/zCN4m1OHI7mq6Z/OjanlkW5TNF9muS1vpqA6rtX1Bj2g
         SIsA==
X-Forwarded-Encrypted: i=1; AJvYcCV9BZoZ3k2amguNw31gkIY+G2dVgk1wnejNEYMPxp2Czo5tSvjuHbc505SZXkCEqitpMe0=@vger.kernel.org, AJvYcCW4mI0EQ8MgIrhHUkKcHkHrWNhWCnp2TKSTsZO8nZbcOD70Ve7PpIXp7w5kJEqsV+jt4kDmd7cj6whjmUtD@vger.kernel.org, AJvYcCWHQJ1c2Gq+iBYHtMWTPAUend3Tg+LAoW2r+BryMLnltYhYddQC3z3Q2n/fokupnPSgtjrbF10PW7nkL2Nexyk=@vger.kernel.org, AJvYcCWi6VSvNfHAF7rW23noc3xLfXC+9IMqKm/or/QukRIhIo12F7W5ComVlFEOwE+r+gSFi04jtGtywqdvinr+lH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLL80JkVQ09XRkM/FUSletnBIrfYlmi2E9GCIsWT9J0e5GRn7
	Y0e+Ejory48jyV3ZiYGEBw3aLDg7Ibz9T0QsagplRTNx0caD4qvWBm9drHMNi6EK45khhknxnGx
	EC8UvA6azQak7LjDtblSe8pE3sb24O2I=
X-Gm-Gg: ASbGnct4IgfPbofnYGrenc0Bq9PTqQMa5vrG/qmqOyB2i6BVVdWsXDqv2M22Bew4oxV
	niIwG4en2kYrRgEtY+vP2l5MvVq92GcL1WiLgKqLet8Pl+zMHRGqZ8pU9SN8Ks3yz+hUPsnvmJz
	eroZlf+FAwIE1MBV3vGm8PlMYpjmqVDTcvRNVlcoi3FxQtaKLNpUZBenOEkwgUsmFoKUFk/fLE
X-Google-Smtp-Source: AGHT+IGl307g/Cb4M8ys7xRkMqsB4P7qgaJ2qzazbro0cQv4i2hb8605y1TULKlRw0ArBOPaqrTdi/ue/nQVGUiy4P4=
X-Received: by 2002:a5d:64ef:0:b0:3a4:f7e6:284b with SMTP id
 ffacd0b85a97d-3b5e788110cmr2130070f8f.10.1752107998781; Wed, 09 Jul 2025
 17:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se> <CAADnVQ+bikqCO7D+5_rAtiJXv3F6xn=0_hgGH5CkoTPpdi8j6Q@mail.gmail.com>
 <14b08e7c-c2e8-435c-a1dd-bd51cfb42060@kernel.org> <CAADnVQ+qCNfm3aucBrkXRXrUjjYeYQb09Oobx+pgOXNDny4s8w@mail.gmail.com>
 <DB7WW886UVAJ.I58517CYL8G7@kernel.org>
In-Reply-To: <DB7WW886UVAJ.I58517CYL8G7@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Jul 2025 17:39:47 -0700
X-Gm-Features: Ac12FXyQfyO3szxMDVVNHvlOhNb_Gbvf_td5xMFONVF3fAKwKJRT2QZYiRmaY0s
Message-ID: <CAADnVQ+iZbKzx8bje=CLO=OnpmGHmQHpDNC=UjWYfN59bWoN3A@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in vrealloc
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Thu Jul 10, 2025 at 1:14 AM CEST, Alexei Starovoitov wrote:
> > On Wed, Jul 9, 2025 at 3:57=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> >>
> >> On 7/10/25 12:53 AM, Alexei Starovoitov wrote:
> >> > On Wed, Jul 9, 2025 at 10:25=E2=80=AFAM Vitaly Wool <vitaly.wool@kon=
sulko.se> wrote:
> >> >>
> >> >>
> >> >> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> >> >> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsig=
ned long align,
> >> >> +                                gfp_t flags, int node)
> >> >>   {
> >> >
> >> > imo this is a silly pattern to rename functions because they
> >> > got new arguments.
> >> > The names of the args are clear enough "align" and "node".
> >> > I see no point in adding the same suffixes to a function name.
> >> > In the future this function will receive another argument and
> >> > the function would be renamed again?!
> >> > "_noprof" suffix makes sense, since it's there for alloc_hooks,
> >> > but "_node_align_" is unnecessary.
> >>
> >> Do you have an alternative proposal given that we also have vrealloc()=
 and
> >> vrealloc_node()?
> >
> > vrealloc_node()?! There is no such thing in the tree.
> > There are various k[zm]alloc_node() which are artifacts of the past
> > when NUMA just appeared and people cared about CONFIG_NUMA vs not.
> > Nowadays NUMA is everywhere and any new code must support NUMA
> > from the start. Hence no point in carrying old baggage and obsolete nam=
es.
>
> This patch adds it; do you suggest to redefine vrealloc_noprof() to take =
align
> and nid? If we don't mind being inconsistent with krealloc_noprof() and
> kvrealloc_noprof() that's fine I guess.
>
> FWIW, I prefer consistency.

What inconsistency are you talking about? That
krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
and
vrealloc_noprof(const void *p, size_t size, unsigned long align,
                gfp_t flags, int node)
have different number of arguments?!

See:
alloc_pages_noprof(gfp_t gfp, unsigned int order);
__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
                nodemask_t *nodemask);

Adding double underscore to keep all existing callers of
vrealloc_noprof() without changes and do:

vrealloc_noprof(const void *p, size_t size, gfp_t flags);
__vrealloc_noprof(const void *p, size_t size, unsigned long align,
gfp_t flags, int node);

is fine and consistent with how things were done in the past,
but adding "_node_align_" to the function name and code churn to all
callsites is a cargo cult.

