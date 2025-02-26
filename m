Return-Path: <bpf+bounces-52695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C1A46B43
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE93C1888FA7
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10649253326;
	Wed, 26 Feb 2025 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YkO3EX0R"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E9F2505C5;
	Wed, 26 Feb 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598818; cv=none; b=WIkrBeJmwBa8glVXO0BFNaRmjXMipbjvM7dsieP3AqdfhJdRRr/UGlrXW8CczfoIH0Kbrs64KLvi3vJ2kiQi1sHnyK7y2VXF6+q1Z/zrCvfVKY2LGX6m93pZm0ox40UK+xFAFBMsOuQoTHi2NmHS1wZTIsVwn0zeiqw9GLEQ8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598818; c=relaxed/simple;
	bh=IUheWlSSUJ/8vMzGkjBK+S3uf36PkLWD7up/x3PrCag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CVXXdmUtSgjhM+nnsPVvCTVE99HP3Cx41bkadTWP1xL4uMvp+Q4qE5o5I5EsRCl1PShUI4FhuljzXQAyFw597Eo8Cn9uLyyQk/1SJrzWn9CQwmfAUb8TmzFLskBBOir8LPYPMq3YGz/LsHaxX6uD5+Q3AovV+SCBOB29TXLYzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YkO3EX0R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8826C2107AAB;
	Wed, 26 Feb 2025 11:40:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8826C2107AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740598816;
	bh=yAUqEIXMpQVqzzO/rrGdO+RRJpFARicVp+JsEMr+UQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YkO3EX0R5EzmxjLKaYYWj0JsXC3WdDaznQqsJZsWLBvVMh9IdTgQSyiQWoHwTt32K
	 bb/rZql6j3R7Nz1hM17MON4RkIg2sC5Nb4mupokc3NeAlEt2cx0+rYWA/Mi4AQ6kt+
	 kQi1oRRMj71nuHEdS7hlGoqf00zxodC6L/m0GTbQ=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 1/1] security: Propagate universal pointer data in bpf
 hooks
In-Reply-To: <CAHC9VhS8ST6ODB2pFJTMK4qu8FdM2J=6qEbB=XGxo2ZAZgo1Aw@mail.gmail.com>
References: <20250226003055.1654837-1-bboscaccy@linux.microsoft.com>
 <20250226003055.1654837-2-bboscaccy@linux.microsoft.com>
 <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
 <CAHC9VhS8ST6ODB2pFJTMK4qu8FdM2J=6qEbB=XGxo2ZAZgo1Aw@mail.gmail.com>
Date: Wed, 26 Feb 2025 11:40:08 -0800
Message-ID: <87mse8jy07.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Feb 26, 2025 at 2:06=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>> On Tue, Feb 25, 2025 at 4:31=E2=80=AFPM Blaise Boscaccy
>> <bboscaccy@linux.microsoft.com> wrote:
>> >
>> > Certain bpf syscall subcommands are available for usage from both
>> > userspace and the kernel. LSM modules or eBPF gatekeeper programs may
>> > need to take a different course of action depending on whether or not
>> > a BPF syscall originated from the kernel or userspace.
>> >
>> > Additionally, some of the bpf_attr struct fields contain pointers to
>> > arbitrary memory. Currently the functionality to determine whether or
>> > not a pointer refers to kernel memory or userspace memory is exposed
>> > to the bpf verifier, but that information is missing from various LSM
>> > hooks.
>> >
>> > Here we augment the LSM hooks to provide this data, by simply passing
>> > the corresponding universal pointer in any hook that contains already
>> > contains a bpf_attr struct that corresponds to a subcommand that may
>> > be called from the kernel.
>>
>> I think this information is useful for LSM hooks.
>
> I've only looked at it quickly, but so far it seems reasonable.  I'm
> going to take a closer look today.
>
>> Question: Do we need a full bpfptr_t for these hooks, or just a boolean
>> "is_kernel or not"?
>
> I may be misunderstanding the patch, but what if we swapped the
> existing 'union bpf_attr' parameter for a 'bpfptr_t' parameter?  That
> would allow for both kernel and usermode pointers, complete with a
> 'is_kernel' flag; or am I missing something (likely)?
>
> --=20
> paul-moore.com

bpfptr_t is just a typedef for a sockptr_t, which contains a void
pointer and bool, so if we replaced bpf_attr with it, we might lose a
bit of type safety going that route.

In syscall.c a most of the subcommand handlers have a

static int bpf_foo(union bpf_attr *attr, bpfptr_t uattr);

pattern that is used. I was trying to mimic for this patch.

The actual parts where the is_kernel flag gets used currently, is for
pointer chasing/copy stuff, e.g.

make_bpfptr(attr->insns, uattr.is_kernel)
make_bpfptr(attr->license, uattr.is_kernel)
make_bpfptr(attr->fd_array, uattr.is_kernel)

and subcommand structs may contain multiple pointers.

-blaise

