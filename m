Return-Path: <bpf+bounces-63427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507AB07524
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEFC1896A89
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1CE2F2712;
	Wed, 16 Jul 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kCV0QIWi"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249FB2F0043
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666898; cv=none; b=E5XbtW/y/HRIPqED0Tp+5LMbedivroozL61piX2YKmB7TSB+HGj/qYl294jqNShhgVFEl7t3ZuOSPDdPFCg/fwXH4DWzXLiAwlxUBGmpb36GaF9pMe9fkZNTKKcoirxdeCrmfIqD3XQvMpxpIgnIre/4Zu5rddyt+ITldDZ+6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666898; c=relaxed/simple;
	bh=5MLzakPnK7x1wR/xUJvUAIyxiAo8Nz3QyiHKXJQC+ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfiQiSnN5nv6bN6V138cRqp3HjmSsN3FaCyZykuhJFNOdUoaS8GQuBbQ2IrhZP5hZLh8OegLQa9OcfhjaoiqGv2X2HNwXdnoXm5tBL2xRV7lZ8JsbmhxAUBo3owGt0w84dVBjQqfAsER6wKWJLriz0fvXBmPIDdGaW0ueN3i7Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kCV0QIWi; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752666892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MLzakPnK7x1wR/xUJvUAIyxiAo8Nz3QyiHKXJQC+ng=;
	b=kCV0QIWi6mbXGDOyzDE1puMWGwAAhdSowsRx8oxSr0ZTZl/gfPGyM/3JBWm2lXrEc6kD6v
	EZidyBjcG5t3unZmTzNDO3ZwnKCaym38JNJuKTBooM/wgCiVO/QddpFF87PVKmmmsGunp1
	PaV20lPSwAhAmHDWYWJx7DyDw0dr7bE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
 rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 14/18] libbpf: add btf type hash lookup support
Date: Wed, 16 Jul 2025 19:53:50 +0800
Message-ID: <3339133.5fSG56mABF@7940hx>
In-Reply-To:
 <CAEf4BzZCPcq0eo=1SN-r=k5QF1XE5hihEYHYYdi37aiV7VXwVQ@mail.gmail.com>
References:
 <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <22e15dd2-8564-4e71-ab77-8b436870850d@linux.dev>
 <CAEf4BzZCPcq0eo=1SN-r=k5QF1XE5hihEYHYYdi37aiV7VXwVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wednesday, July 16, 2025 1:20 AM Andrii Nakryiko <andrii.nakryiko@gmail.=
com> write:
> On Mon, Jul 14, 2025 at 9:41=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> >
> > On 7/15/25 06:07, Andrii Nakryiko wrote:
> > > On Thu, Jul 3, 2025 at 5:22=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >> For now, the libbpf find the btf type id by loop all the btf types a=
nd
> > >> compare its name, which is inefficient if we have many functions to
> > >> lookup.
> > >>
> > >> We add the "use_hash" to the function args of find_kernel_btf_id() to
> > >> indicate if we should lookup the btf type id by hash. The hash table=
 will
> > >> be initialized if it has not yet.
> > > Or we could build hashtable-based index outside of struct btf for a
> > > specific use case, because there is no one perfect hashtable-based
> > > indexing that can be done generically (e.g., just by name, or
> > > name+kind, or kind+name, or some more complicated lookup key) and
> > > cover all potential use cases. I'd prefer not to get into a problem of
> > > defining and building indexes and leave it to callers (even if the
> > > caller is other part of libbpf itself).
> >
> >
> > I think that works. We can define a global hash table in libbpf.c,
> > and add all the btf type to it. I'll redesign this part, and make it
> > separate with the btf.
>=20
> No global things, please. It can be held per-bpf_object, or even
> constructed on demand during attachment and then freed. No need for
> anything global.

Okay, the per-bpf_object is a good idea, and I'll try to implement
it this way.

Thanks!
Menglong Dong






