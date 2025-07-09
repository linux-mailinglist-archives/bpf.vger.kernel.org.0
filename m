Return-Path: <bpf+bounces-62862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E879AFF55E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D045A2759
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34177269885;
	Wed,  9 Jul 2025 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2g1Q+zI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5280E55B;
	Wed,  9 Jul 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103618; cv=none; b=ATnfS/vCSPQtBs6wTdS2WGFNVi8P016N0NTPS8qMHJfedD9lAHARpvUEN1RXV0TRxfdO66gesD2HGSYCvHBxGh6n8Rfdi+pCt16ktC7qe+4cjDfIGUKLpW/cibDNZf59tWNi+1w+I8ujQdesoIDvB2PSvfDPqR9vhcRKrRfO78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103618; c=relaxed/simple;
	bh=IPEkOrMLiuYPZNTOAJdwlYClp6f/Px6JZvPwRaELaS0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZFtgBOjGWKfV/HlciPzMb9BdRoTH8eoRKtyq6MYxq/wRnwsDFtGCL3yAbS2/wR6VI/3lSvacWvgsAU+Pj2/lws4LZkuADwE6HAbZ71DUo3pcWKNhXCxLOw/FIaC17Zzk0DHl4rGZCymJT4i3pZKYeGjlP3OdvPuDwXaAmPz3aiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2g1Q+zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF2DC4CEEF;
	Wed,  9 Jul 2025 23:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752103618;
	bh=IPEkOrMLiuYPZNTOAJdwlYClp6f/Px6JZvPwRaELaS0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=b2g1Q+zIZl/+BRBTP5p6IPueQ9i/noMS14SUk6j/a4rs6rm+xarisc4yVYbX3CvTa
	 b/PTn9nuKDQSjB90es6LVAdiO7XZoLirdDYVav//SYbp6B6rVYx6YiVpRly0bx/1Ee
	 uM6l57S4G/17nCoGXyASois71bPjvogxbE4JSKheGnN8PAd52n2VT5ytybnE7l54fb
	 tiwvzwoa1E9R8juCK7Tqd0Bkx1Sm+i1IHwhvSE+Qhp5GDK0s0/50osQAnF3ZCuWVmW
	 a+4oWt23yWtzwNE6dIGKbL9tdXh9+qNZh3r+Gsxp5ZOBjvZDEeV+iHFPidD2t5BZbv
	 77sm08E8miyGg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 01:26:53 +0200
Message-Id: <DB7WW886UVAJ.I58517CYL8G7@kernel.org>
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in
 vrealloc
Cc: "Vitaly Wool" <vitaly.wool@konsulko.se>, "linux-mm"
 <linux-mm@kvack.org>, "Andrew Morton" <akpm@linux-foundation.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "rust-for-linux" <rust-for-linux@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 <linux-bcachefs@vger.kernel.org>, "bpf" <bpf@vger.kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Jann Horn" <jannh@google.com>, "Pedro
 Falcato" <pfalcato@suse.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
 <CAADnVQ+bikqCO7D+5_rAtiJXv3F6xn=0_hgGH5CkoTPpdi8j6Q@mail.gmail.com>
 <14b08e7c-c2e8-435c-a1dd-bd51cfb42060@kernel.org>
 <CAADnVQ+qCNfm3aucBrkXRXrUjjYeYQb09Oobx+pgOXNDny4s8w@mail.gmail.com>
In-Reply-To: <CAADnVQ+qCNfm3aucBrkXRXrUjjYeYQb09Oobx+pgOXNDny4s8w@mail.gmail.com>

On Thu Jul 10, 2025 at 1:14 AM CEST, Alexei Starovoitov wrote:
> On Wed, Jul 9, 2025 at 3:57=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>>
>> On 7/10/25 12:53 AM, Alexei Starovoitov wrote:
>> > On Wed, Jul 9, 2025 at 10:25=E2=80=AFAM Vitaly Wool <vitaly.wool@konsu=
lko.se> wrote:
>> >>
>> >>
>> >> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>> >> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsigne=
d long align,
>> >> +                                gfp_t flags, int node)
>> >>   {
>> >
>> > imo this is a silly pattern to rename functions because they
>> > got new arguments.
>> > The names of the args are clear enough "align" and "node".
>> > I see no point in adding the same suffixes to a function name.
>> > In the future this function will receive another argument and
>> > the function would be renamed again?!
>> > "_noprof" suffix makes sense, since it's there for alloc_hooks,
>> > but "_node_align_" is unnecessary.
>>
>> Do you have an alternative proposal given that we also have vrealloc() a=
nd
>> vrealloc_node()?
>
> vrealloc_node()?! There is no such thing in the tree.
> There are various k[zm]alloc_node() which are artifacts of the past
> when NUMA just appeared and people cared about CONFIG_NUMA vs not.
> Nowadays NUMA is everywhere and any new code must support NUMA
> from the start. Hence no point in carrying old baggage and obsolete names=
.

This patch adds it; do you suggest to redefine vrealloc_noprof() to take al=
ign
and nid? If we don't mind being inconsistent with krealloc_noprof() and
kvrealloc_noprof() that's fine I guess.

FWIW, I prefer consistency.

