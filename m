Return-Path: <bpf+bounces-62883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B49AFF98A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E49B40615
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 06:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BCA2874F4;
	Thu, 10 Jul 2025 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="j38hk03L";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="25EqmBEl"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8211226D11
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128199; cv=none; b=gJ+aGqQm3qh0vNWVVyu49+ywIgGKoBM/XsQpblDRSVkgXMseiup8c7j4Xq7l/uKTY8WsC1yEkkUPmgU8Ac96uoqyh350WlsSy19Ih3KCuMBONQd0u1rkw7JhgAEvblyM6SqC76Zcl1BGzA48mhDew4Az3VFjVE9t2ueTu1Sr+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128199; c=relaxed/simple;
	bh=H8ClmTjjEb9bsVONNg4zE004ClDGd+aXBH4tHScxEms=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YFF88L8yYb7R25fNdFlzN96thWZVEUvPAE2paXArfyI+Flj9d3HMyUDU5mnjLkGeaF3UQzysjGwN90k9uU6jr2LhWqTvYYsTPQPqISoYwX6nHXdO870bVzPIEtoSRf2wnCXtDVCaaRWuQibmiOLQsh8Op444dolqBvHnrjMhHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=j38hk03L; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=25EqmBEl; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752128194; x=1752732994;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=bbG2eOYm0nVPoiyoh0kqZFxhcAwfAfhJmOsqqTLYURg=;
	b=j38hk03LBQ49WWec0sDiZUsKSxLsQrfrEaZMs1r573dhGXIx+sVrsXxu/HgQlR7k0yJSRB4ON1Ice
	 tG0FJEY2wjQbCIUE4gv4IohxNaKPGMHh+F/2lzjaBJKHS0mg4Kn7Mj9HQ53w3Zur6DelJBbQXiTI+U
	 BQRIvFJEnohGKdB5mrpRP6EgiC+LMzfOgLUlEaNlBkCAd9cujAPvnz8yjNg7+0Zn2g1JxNxWqyfIW3
	 oN0jo/sjn6fZjtmkBaLvQOZTBqheYe/wI4NN2w2BLVGqj74qypbRrmwR54e0wlcpIZqoKdxrm8c+5x
	 zJfPhXRb//Kze4IWNZpY7y7Rr1hujUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752128194; x=1752732994;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=bbG2eOYm0nVPoiyoh0kqZFxhcAwfAfhJmOsqqTLYURg=;
	b=25EqmBEl3UcQ3f9/U1QLHscuEdIF/PGEea91SZXE194mrLPt5Tl4+oxQwNJYCjyaqeBF95E9WOm64
	 lcFHs7eAg==
X-HalOne-ID: 6c6be782-5d55-11f0-8215-f7376af24660
Received: from smtpclient.apple (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay6.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 6c6be782-5d55-11f0-8215-f7376af24660;
	Thu, 10 Jul 2025 06:16:34 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in
 vrealloc
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <CAADnVQ+iZbKzx8bje=CLO=OnpmGHmQHpDNC=UjWYfN59bWoN3A@mail.gmail.com>
Date: Thu, 10 Jul 2025 08:16:23 +0200
Cc: Danilo Krummrich <dakr@kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org,
 bpf <bpf@vger.kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F14B44F-6073-4F12-875A-9E07EFC16E20@konsulko.se>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
 <CAADnVQ+bikqCO7D+5_rAtiJXv3F6xn=0_hgGH5CkoTPpdi8j6Q@mail.gmail.com>
 <14b08e7c-c2e8-435c-a1dd-bd51cfb42060@kernel.org>
 <CAADnVQ+qCNfm3aucBrkXRXrUjjYeYQb09Oobx+pgOXNDny4s8w@mail.gmail.com>
 <DB7WW886UVAJ.I58517CYL8G7@kernel.org>
 <CAADnVQ+iZbKzx8bje=CLO=OnpmGHmQHpDNC=UjWYfN59bWoN3A@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jul 10, 2025, at 2:39=E2=80=AFAM, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Wed, Jul 9, 2025 at 4:26=E2=80=AFPM Danilo Krummrich =
<dakr@kernel.org> wrote:
>>=20
>> On Thu Jul 10, 2025 at 1:14 AM CEST, Alexei Starovoitov wrote:
>>> On Wed, Jul 9, 2025 at 3:57=E2=80=AFPM Danilo Krummrich =
<dakr@kernel.org> wrote:
>>>>=20
>>>> On 7/10/25 12:53 AM, Alexei Starovoitov wrote:
>>>>> On Wed, Jul 9, 2025 at 10:25=E2=80=AFAM Vitaly Wool =
<vitaly.wool@konsulko.se> wrote:
>>>>>>=20
>>>>>>=20
>>>>>> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>>>>>> +void *vrealloc_node_align_noprof(const void *p, size_t size, =
unsigned long align,
>>>>>> +                                gfp_t flags, int node)
>>>>>>  {
>>>>>=20
>>>>> imo this is a silly pattern to rename functions because they
>>>>> got new arguments.
>>>>> The names of the args are clear enough "align" and "node".
>>>>> I see no point in adding the same suffixes to a function name.
>>>>> In the future this function will receive another argument and
>>>>> the function would be renamed again?!
>>>>> "_noprof" suffix makes sense, since it's there for alloc_hooks,
>>>>> but "_node_align_" is unnecessary.
>>>>=20
>>>> Do you have an alternative proposal given that we also have =
vrealloc() and
>>>> vrealloc_node()?
>>>=20
>>> vrealloc_node()?! There is no such thing in the tree.
>>> There are various k[zm]alloc_node() which are artifacts of the past
>>> when NUMA just appeared and people cared about CONFIG_NUMA vs not.
>>> Nowadays NUMA is everywhere and any new code must support NUMA
>>> from the start. Hence no point in carrying old baggage and obsolete =
names.
>>=20
>> This patch adds it; do you suggest to redefine vrealloc_noprof() to =
take align
>> and nid? If we don't mind being inconsistent with krealloc_noprof() =
and
>> kvrealloc_noprof() that's fine I guess.
>>=20
>> FWIW, I prefer consistency.
>=20
> What inconsistency are you talking about? That
> krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
> and
> vrealloc_noprof(const void *p, size_t size, unsigned long align,
>                gfp_t flags, int node)
> have different number of arguments?!
>=20
> See:
> alloc_pages_noprof(gfp_t gfp, unsigned int order);
> __alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
>                nodemask_t *nodemask);
>=20
> Adding double underscore to keep all existing callers of
> vrealloc_noprof() without changes and do:
>=20
> vrealloc_noprof(const void *p, size_t size, gfp_t flags);
> __vrealloc_noprof(const void *p, size_t size, unsigned long align,
> gfp_t flags, int node);
>=20
> is fine and consistent with how things were done in the past,
> but adding "_node_align_" to the function name and code churn to all
> callsites is a cargo cult.
>=20

I see your point but your approach is currently only applicable to =
vmalloc and it will not work for slub because the latter already has =
__kmalloc_node, __kvmalloc_node etc. and we want to keep at least some =
naming consistency between k[v]* and v* functions.

This whole patchset is only intended to add the capability to set node =
and properly handle alignment requests in Rust allocators, and is thus =
well aligned with your idea that the new code must support NUMA (which I =
do share). I would suggest that we get this in as it is, and then I can =
take the burden of straightening out the naming which will inevitably =
lead to many modifications in other parts of the kernel. The latter I am =
fine with, too, but not in this series.

~Vitaly=

