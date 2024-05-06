Return-Path: <bpf+bounces-28723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231DE8BD69B
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B88282D63
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAF158D7B;
	Mon,  6 May 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IWMB6EWo"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746EEBB
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029511; cv=none; b=nh318+E8zzSqNuuvHVaXkvQdxeizxqjVh6s6hapj8nX0WPdrCg4B5PH9im9lyRcRkPQg523t/jQvyaW9aPjOpu/HC9/zkH+fn0RxLAr2NOoDE7mz0lNGEid8omQXXwm9BmSA7eZzAemR9lSk5fQemRgkCQjLpakcLIdNWnujsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029511; c=relaxed/simple;
	bh=1NSJc03A4NZroirCU9H8CMzH7+blLGtfIep/PPbV5bo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Vny2aSnaBXUdA3v83V50TbQm1CcXcYTm3nvJqHk/UIWmd1PK02tR436I2JAf1EE30/U0FENTurt2Kh10PElQFFHQ93b4XrFHor/9jnTpD18447o385actehBtFEjjML7C3aoGc/+BlUfeqfXzObT3Udgo2cBrcR4dzTvz7NT2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IWMB6EWo; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715029507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NSJc03A4NZroirCU9H8CMzH7+blLGtfIep/PPbV5bo=;
	b=IWMB6EWo+7kE0zqbM4YzEH+F7t/xlK6DuUiAZhAfxz8EotR4Vh3GuehN5Sh1XlRBbkdPJU
	rUhQKMeN3PX2xVe6PO4KGTSr1EIXXuzTe+EHXvddG62T3v6EXQsS2bB9PqEi/HDEJj4vmA
	Sv4wKRc/IUi9jrtwoOmDeGkgjP43wPg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] SLUB: what's next?
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <67304905-57d7-47f5-937b-2c4fb95d13ba@suse.cz>
Date: Mon, 6 May 2024 14:04:54 -0700
Cc: Michal Hocko <mhocko@suse.com>, lsf-pc@lists.linux-foundation.org,
 linux-mm@kvack.org, bpf <bpf@vger.kernel.org>
Message-Id: <3B8114F2-2284-441C-BC26-5AA95D02B7A0@linux.dev>
References: <67304905-57d7-47f5-937b-2c4fb95d13ba@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT


> On May 2, 2024, at 2:26=E2=80=AFAM, Vlastimil Babka <vbabka@suse.cz> wrote=
:
>=20
> =EF=BB=BF
>=20
>> On 5/2/24 09:59, Michal Hocko wrote:
>>> On Tue 30-04-24 17:42:18, Vlastimil Babka wrote:
>>> Hi,
>>>=20
>>> I'd like to propose a session about the next steps for SLUB. This is
>>> different from the BOF about sheaves that Matthew suggested, which would=
 be
>>> not suitable for the whole group due to being not fleshed out enough yet=
.
>>> But the session could be scheduled after the BOF so if we do brainstorm
>>> something promising there, the result could be discussed as part of the f=
ull
>>> session.
>>>=20
>>> Aside from that my preliminary plan is to discuss:
>>>=20
>>> - what was made possible by reducing the slab allocators implementations=
 to
>>> a single one, and what else could be done now with a single implementati=
on
>>>=20
>>> - the work-in-progress work (for now in the context of maple tree) on SL=
UB
>>> per-cpu array caches and preallocation
>>>=20
>>> - what functionality would SLUB need to gain so the extra caching done b=
y
>>> bpf allocator on top wouldn't be necessary? (kernel/bpf/memalloc.c)
>>>=20
>>> - similar wrt lib/objpool.c (did you even noticed it was added? :)
>>>=20
>>> - maybe the mempool functionality could be better integrated as well?
>>>=20
>>> - are there more cases where people have invented layers outside mm and t=
hat
>>> could be integrated with some effort? IIRC io_uring also has some cachin=
g on
>>> top currently...
>>>=20
>>> - better/more efficient memcg integration?

This is definitely an interesting topic, especially in a light of recent sla=
b accounting performance conversations with Linus. Unfortunately I=E2=80=99m=
 not attending in person this year, but happy to join virtually if it=E2=80=99=
s possible.

It=E2=80=99s not yet entirely clear to me if the kmem accounting performance=
 problem exists outside of some micro-benchmarks.

Additionally, Linus proposed to optimize for cases when allocations might be=
 short-living. In the proposed form it would complicate call sites significa=
ntly, but maybe we need some sort of transactional api, e.g.:

memcg_kmem_local_accounting_start();
p1 =3D kmalloc(GFP_ACCOUNT_LOCAL);
p2 =3D kmalloc(GFP_ACCOUNT_LOCAL);
=E2=80=A6
kfree(p1);
memcg_kmem_local_accounting_commit();

In this case all allocations within the transaction will be saved to some te=
mporarily buffer and not fully accounted until memcg_kmem_local_accounting_c=
ommit(). This will make them way faster. But a user should guarantee that th=
ese allocations won=E2=80=99t be freed from any other context until memcg_km=
em_local_accounting_commit().

Thanks!=

