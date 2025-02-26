Return-Path: <bpf+bounces-52686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8355CA46ADD
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D06188B20D
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2C23A564;
	Wed, 26 Feb 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i1DdCjY7"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D32236A66;
	Wed, 26 Feb 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597707; cv=none; b=upirvRH93dTC1yXiNnrNUHk6D3j5NLw5Sn6Rev7zsR93hYB2dHErcu0OoDmuPqT2rorNFvGET9hKCESNzX7/BoVglV0gKFqFDijUZ5nRMKbZnpgx1ZwwILPwNGfttsbtHG1C4BFxgVWWpmXFXeQ2+qD1xcEMmgwrhekZzvlK5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597707; c=relaxed/simple;
	bh=9voOCpIr5KsR2MrzPyH2v0+Hl+LD4VAcKc3oOdHexTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bERe8gWXMOILJ/kL73AIX7ZA0e5ZsZgVCl5evAQBNNHUeWJLx6Ht8veB/210fzCtR3En5F6aU2SNbMJ8b69QztQ7aUZbhKqxMyPERt38gD4AH7jVlc2rmYVGPG4vIeL5xxXgvhrVYBf+511DxKW4y1NG1RJwX6NOUXMGf9jaA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i1DdCjY7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id F37A72107AAB;
	Wed, 26 Feb 2025 11:21:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F37A72107AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740597700;
	bh=9voOCpIr5KsR2MrzPyH2v0+Hl+LD4VAcKc3oOdHexTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i1DdCjY7F0rctTcaMxKIxXXmBJZYfZpU2ARs6hjfPwxgl/oOBWgQ8ZkwhMtwb7dAt
	 kvdQLVVWHY+r3NlVA73slr8Gx16VJbEED1agkRJwxq9pcC4t78BnizML2qgpxUw9uJ
	 8pwpJebUVF+/3SH4DjtuCeb/QpvlHUD7V/CmQ/2g=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Song Liu
 <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, LSM List
 <linux-security-module@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 selinux@vger.kernel.org
Subject: Re: [PATCH 1/1] security: Propagate universal pointer data in bpf
 hooks
In-Reply-To: <CAADnVQJWMBRspP-srQwe8_B1smGG1hs3kVbpeiuYo-0mLWAnUA@mail.gmail.com>
References: <20250226003055.1654837-1-bboscaccy@linux.microsoft.com>
 <20250226003055.1654837-2-bboscaccy@linux.microsoft.com>
 <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
 <CAADnVQJWMBRspP-srQwe8_B1smGG1hs3kVbpeiuYo-0mLWAnUA@mail.gmail.com>
Date: Wed, 26 Feb 2025 11:21:30 -0800
Message-ID: <87plj4jyv9.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Feb 25, 2025 at 11:06=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>>
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
>>
>> Question: Do we need a full bpfptr_t for these hooks, or just a boolean
>> "is_kernel or not"?
>
> +1
> Just passing the bool should do.
> Passing uattr is a footgun. Last thing we need is to open up TOCTOU conce=
rns.

Sounds good to me, I'll rework it to use a bool instead.

-blaise

