Return-Path: <bpf+bounces-62861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC2AFF548
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065F4548086
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB1726B085;
	Wed,  9 Jul 2025 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbW+O/F5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320E262FF5;
	Wed,  9 Jul 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102899; cv=none; b=XCgMcUgVNEOaEgOEUI9EWy2yLlTjm97f0N3bGCoxgs/lrP76daoK25ESvQi39lMvYZTD8I8/RXmjmEguwNo7985AnuKQdIHstx5CpgU4vfTVcWka93jEaL5EbLvsYsNTuOQSY6YL8GzDnVEK1ycunTnMGjSzlUCdJXY6nyV4sIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102899; c=relaxed/simple;
	bh=AQ5yB1DbROpAxt+ad1yBffmzK/df+l/OZCggz4JyXwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRB6nCKVHIwPX7WIR59CY47JiFg1xdIzcY7ZqbdSUgk6eRxmjH7b31MAx++aN8Jy+AjoBNhCiI7Rh8NW+vqnbX3R0pGiXdnGL8acYuLzwcjHz1NDiuR/4JubpMm+LuTpNv9hwuFXLFSpbb6AVLzFzR9QHxcfrWXYDFTf32O0Ot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbW+O/F5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4531e146a24so2018265e9.0;
        Wed, 09 Jul 2025 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752102896; x=1752707696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYJOdamhFPgWOOLsL56Q4wei5GHMmw+MZHBvYTLYgYk=;
        b=WbW+O/F5MEcjq74eFs8kQccJJqAsMYtmL1rDk1L/7way9aBJByd5WyaWkUWDS31Acq
         7p+n7f17PCu1ADgKFiC04h/EPD925WplOdB5ayQ6u3RjfJmmoV5c6/3eqjl8bQhBp7lK
         W57yaRfmTI+0j3i0uI8GLx1mD20BrhhB8mbGa7ymJWiOfdd426e0/RNwOsaQQkHe18+W
         7jjVoHFWRaK74ZnPh0N/C5fOfV0b/eJTlRqhF+CIonQYeGktFr1lg8jG8hbPuSvV3rHR
         HcHq9lFmwmZW0S4xCN0m4oTmRM43DxrIr40FByozwSxAw+P2fZ+LFNgWyckdtJlh/jtI
         CxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102896; x=1752707696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYJOdamhFPgWOOLsL56Q4wei5GHMmw+MZHBvYTLYgYk=;
        b=oLMPk9MmOUJKOvglL5jA19tCXy/189TW+58ULL8i8mOXv7bDZYCMuXlxYTzTr00Q0u
         oqSygjLBbkTcNF64H2cal5O6LKui4wvCVTKupQ7urcWs7KkhWW1K6X2IWHsvQL7vpz9y
         Pxu3vTL0EW9sCMHR3if7tDHvWtxqs7Q7O/vskm0pbastQZUcRC6uGK2Y0ECxrQSr+cJf
         Y7B8KSh43k5FnZGGJSgTwvt04iYBKNMN1z8okcZ7/iIqsG1QiPPh2MLY5pOhfmxubDc1
         XFdmI55DDsQGcczMqtbxeTxJQVfljUVorZyY5in0WH1EImynlMjOF2CylSF3O8lUKyPA
         ri7w==
X-Forwarded-Encrypted: i=1; AJvYcCVG7bR8HS7iFtbsQoQijhmMGut/dd35v3S5Ix1Io/oX3loSbehsIVMppvJt64vS7N4L9EAePY8EW17V4Gxd@vger.kernel.org, AJvYcCVcclFaNYrUfIjh5tL0gRdFOJiaTDmFhd3P3MgrvajDMhTOXyx+IgO4Vs/8xMP/WBdV9B8=@vger.kernel.org, AJvYcCWP6DEIfjTFw/Pav9NCpmazZS7wVhL3M7aBgqe6Nphjv/ZvueCcKSFqTFyOlIgw36EgZRXYG1Zg8OXujjgSPWg=@vger.kernel.org, AJvYcCXlYN96jP37rGAZce6R1BC9WoGbkX0rgdzRicic25lFK5OZP5xZ5H3WShB+h5sRsqz8FrTfQLV/QcCwmYiJ++U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvdEp488QN9+sVPJZU0qEUX8kN7mdNLFmcd9xAAKAcG5C6TnQM
	3Pn3P5jN8l+Fe3aOKJ1ezEOj9r38PP+/gG2jAuq0XZvqesOS7/j+G2rXONRPdHQxHMO/b+LZtWc
	iSNmWvlCuRyvVeNTXwjrzf+AzE6n55jk=
X-Gm-Gg: ASbGncu+Z8A3C4bOf8l527EmosQyOQq/z4HYlGie/qgckOab9ouPVk7kZsj5fw4WjEB
	aGi6dFSbIFWVmyg7pZGGblvWiBHNbbd/KdDXA6ltPFCpxKp9khl7ZUPZZKfVaA97D1WIw0tP2J9
	N5E6d3lJRR0ZW5EL/++EMPO6Wn0akFhF6zgvIYaT7KEGXJ2sxt6/ADgSmEVxDl7wKXKKh1tcCVp
	y9CDqB+Hjs=
X-Google-Smtp-Source: AGHT+IH2U4htcocDaxL/p00xb0f1oc0l7cDxqJ0pRS18MFAp8gYunrtlWXqenpefwu6fXfVI/uyDO3Sv/FaxpvA7yQo=
X-Received: by 2002:a05:6000:24c1:b0:3b3:9ca4:ac8e with SMTP id
 ffacd0b85a97d-3b5e4537ad2mr3933193f8f.44.1752102896415; Wed, 09 Jul 2025
 16:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se> <CAADnVQ+bikqCO7D+5_rAtiJXv3F6xn=0_hgGH5CkoTPpdi8j6Q@mail.gmail.com>
 <14b08e7c-c2e8-435c-a1dd-bd51cfb42060@kernel.org>
In-Reply-To: <14b08e7c-c2e8-435c-a1dd-bd51cfb42060@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Jul 2025 16:14:45 -0700
X-Gm-Features: Ac12FXwMoZpB8rTLNPshgJLrHIXikIq47lGVql6Qo7vJk3Tj5z4cIDxTFaOoom4
Message-ID: <CAADnVQ+qCNfm3aucBrkXRXrUjjYeYQb09Oobx+pgOXNDny4s8w@mail.gmail.com>
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

On Wed, Jul 9, 2025 at 3:57=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On 7/10/25 12:53 AM, Alexei Starovoitov wrote:
> > On Wed, Jul 9, 2025 at 10:25=E2=80=AFAM Vitaly Wool <vitaly.wool@konsul=
ko.se> wrote:
> >>
> >>
> >> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> >> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned=
 long align,
> >> +                                gfp_t flags, int node)
> >>   {
> >
> > imo this is a silly pattern to rename functions because they
> > got new arguments.
> > The names of the args are clear enough "align" and "node".
> > I see no point in adding the same suffixes to a function name.
> > In the future this function will receive another argument and
> > the function would be renamed again?!
> > "_noprof" suffix makes sense, since it's there for alloc_hooks,
> > but "_node_align_" is unnecessary.
>
> Do you have an alternative proposal given that we also have vrealloc() an=
d
> vrealloc_node()?

vrealloc_node()?! There is no such thing in the tree.
There are various k[zm]alloc_node() which are artifacts of the past
when NUMA just appeared and people cared about CONFIG_NUMA vs not.
Nowadays NUMA is everywhere and any new code must support NUMA
from the start. Hence no point in carrying old baggage and obsolete names.

