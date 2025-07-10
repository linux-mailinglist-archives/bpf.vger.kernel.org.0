Return-Path: <bpf+bounces-62904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EF9AFFE97
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 11:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921E41BC5A91
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF82D59F2;
	Thu, 10 Jul 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNulD8l8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9A1E505;
	Thu, 10 Jul 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141475; cv=none; b=Nmunq82PgMraQgWRvrN4NAEK/69BSEnJPniIbGpFVpRbdkV6obWbdPqe96Cz7Lb40pWq5o/OB8xalr7slq0LVu5niCJnnPDKytWqKNkcY7N9Bv0JH7IcqEDmVHHTX1ZnJ8nJre5j2K7369KFszgS/stRC/iS1CZXEXhDPA8K5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141475; c=relaxed/simple;
	bh=B5Te1MOfraVVrSpjVQqFSGNLCQuc3hLW//SrxwQmFCI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=cAIHhW2y63JaOf304BAbwwSE9iQhn9jgC/DvAW7qbdJ3/8lw3yW7NIBcqmsoEz5xheD9vO5wdF5VNT9jaUwYW43nQIsUeKzJld97YWjvCXWm0bKi3is60g3NynUyADQbCnekCBfSSxBKQEDN59YKqkoc//ZPZ3unSfYPPHKLyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNulD8l8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D741BC4CEE3;
	Thu, 10 Jul 2025 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141475;
	bh=B5Te1MOfraVVrSpjVQqFSGNLCQuc3hLW//SrxwQmFCI=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=vNulD8l8X0acklVEmHYF6S8BVnK+45pS2sUQfSezAQwOQ7uZUtMKG0RIvwIuOwqVN
	 CiszKPKYAXRasB/EQD8VLrBkthqNMWby/2oKdjxD5gv3C2g97D/FDWbfFXA+cOmhsv
	 V9CdxRiVg110RYC6k55Kue7ZF7Jw8UKm5vV1eYgg6YOUTzYpAz86ImrNbywCl5VUkx
	 JybQaalrWBLrVRURMZpZn74AZEnRHX61sNITP9ygx/c6s3btRxcqBOBFQCx72C0eHG
	 AkJQlrzblaVCzMwsY0KqRuc1wbybmnyeB4ESYj/5yyiQJ+PB5XKQdGH7qHIS9aWhv9
	 XRKR6B3glJhWA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 11:57:50 +0200
Message-Id: <DB8ABBBNMMVB.1QWW942P0MRJP@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
 <CAADnVQ+bikqCO7D+5_rAtiJXv3F6xn=0_hgGH5CkoTPpdi8j6Q@mail.gmail.com>
 <14b08e7c-c2e8-435c-a1dd-bd51cfb42060@kernel.org>
 <CAADnVQ+qCNfm3aucBrkXRXrUjjYeYQb09Oobx+pgOXNDny4s8w@mail.gmail.com>
 <DB7WW886UVAJ.I58517CYL8G7@kernel.org>
 <CAADnVQ+iZbKzx8bje=CLO=OnpmGHmQHpDNC=UjWYfN59bWoN3A@mail.gmail.com>
In-Reply-To: <CAADnVQ+iZbKzx8bje=CLO=OnpmGHmQHpDNC=UjWYfN59bWoN3A@mail.gmail.com>

On Thu Jul 10, 2025 at 2:39 AM CEST, Alexei Starovoitov wrote:
> On Wed, Jul 9, 2025 at 4:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>>
>> On Thu Jul 10, 2025 at 1:14 AM CEST, Alexei Starovoitov wrote:
>> > On Wed, Jul 9, 2025 at 3:57=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
>> >>
>> >> On 7/10/25 12:53 AM, Alexei Starovoitov wrote:
>> >> > On Wed, Jul 9, 2025 at 10:25=E2=80=AFAM Vitaly Wool <vitaly.wool@ko=
nsulko.se> wrote:
>> >> >>
>> >> >>
>> >> >> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>> >> >> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsi=
gned long align,
>> >> >> +                                gfp_t flags, int node)
>> >> >>   {
>> >> >
>> >> > imo this is a silly pattern to rename functions because they
>> >> > got new arguments.
>> >> > The names of the args are clear enough "align" and "node".
>> >> > I see no point in adding the same suffixes to a function name.
>> >> > In the future this function will receive another argument and
>> >> > the function would be renamed again?!
>> >> > "_noprof" suffix makes sense, since it's there for alloc_hooks,
>> >> > but "_node_align_" is unnecessary.
>> >>
>> >> Do you have an alternative proposal given that we also have vrealloc(=
) and
>> >> vrealloc_node()?
>> >
>> > vrealloc_node()?! There is no such thing in the tree.
>> > There are various k[zm]alloc_node() which are artifacts of the past
>> > when NUMA just appeared and people cared about CONFIG_NUMA vs not.
>> > Nowadays NUMA is everywhere and any new code must support NUMA
>> > from the start. Hence no point in carrying old baggage and obsolete na=
mes.
>>
>> This patch adds it; do you suggest to redefine vrealloc_noprof() to take=
 align
>> and nid? If we don't mind being inconsistent with krealloc_noprof() and
>> kvrealloc_noprof() that's fine I guess.
>>
>> FWIW, I prefer consistency.
>
> What inconsistency are you talking about? That
> krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
> and
> vrealloc_noprof(const void *p, size_t size, unsigned long align,
>                 gfp_t flags, int node)
> have different number of arguments?!
>
> See:
> alloc_pages_noprof(gfp_t gfp, unsigned int order);
> __alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
>                 nodemask_t *nodemask);
>
> Adding double underscore to keep all existing callers of
> vrealloc_noprof() without changes and do:
>
> vrealloc_noprof(const void *p, size_t size, gfp_t flags);
> __vrealloc_noprof(const void *p, size_t size, unsigned long align,
> gfp_t flags, int node);
>
> is fine and consistent with how things were done in the past,
> but adding "_node_align_" to the function name and code churn to all
> callsites is a cargo cult.

As Vitaly mentioned in a different reply, this would be inconsistent with t=
he
'k' and 'kv' variants, which have the suffix '_node'.

Anyways, in general I don't think that adding underscores for functions tha=
t
basically do the same thing but are getting more specialized is a great pat=
tern
for things that are not strictly limited to a narrow context.

Please note, I'm not saying we should encode additional arguments in the na=
me
either. I think it really depends on the actual case.

In this case, it seems to make sense to me that there is e.g. kmalloc() and
kmalloc_node().

For a caller that's much more useful, i.e. I want classic kmalloc(), but wa=
nt to
set the node, hence kmalloc_node(). Calling it __kmalloc() instead seems a =
bit
random.

Or do you only refer to the *_noprof() variants, which are not exported to
users? But even then, underscores still don't seem very expressive.

I'm not maintaining this code though, so just take it FWIW. :)

