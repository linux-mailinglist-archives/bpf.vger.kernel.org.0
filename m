Return-Path: <bpf+bounces-77045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C1CCDAE4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE29930054A8
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF033A6F5;
	Thu, 18 Dec 2025 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YwgZKJDA"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFACB23D7E3;
	Thu, 18 Dec 2025 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093190; cv=none; b=J8jES5E75O/mk7Ml31Nx/7crSGxYHWEJ8rjY8mvcKSDNj8D/LrbP4+8RCNedlxIDSkpWH9a33qwuXoJ96aKEa4W9T1YyiaaVvi8ebaT2gLiZDNOxDJkjh2wqAkB6gOx5Q8lw9ydxxjWCQqxTl+19goWNVaWstUUZBoAEz2bGDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093190; c=relaxed/simple;
	bh=LAtNYEGxuLllj1y2htSF42nFPqyLzUxXVeuDgAiNbu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a6AAJImSI8NAEadf2oMDSvlDQ9RHH8xVy2NDWxDYyvsapv6TB7ZvMORVibOHid+yvfibQa7ZO4cpzBkc3QX3Q/sobxdU+kxSOUWXIq9u0W9WDEAk5EXGNPBCI6La5V9W2I6gTHzNLVlKV1YyIU9YsF7YW7KbrSKDD/nviPb+t2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YwgZKJDA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 060B62012446;
	Thu, 18 Dec 2025 13:26:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 060B62012446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766093186;
	bh=gyjPTOJwCEMIQbaQzrFflt+1ISwpXtDpYWfuEbvXRXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YwgZKJDAJYBbyPsenApgLWxwGhZUw03YNYaByi1jH1fiFDeFEoTTUzTNSaIQ6albD
	 LNZHWDQgPsD8XbFgYHeuZ6ZKnMo8kJPKvcKf/08ijR3oIaWLjJUQ1yOlg4UE/fHYL2
	 NmzY72xE88B9oMl8+eTZuOugV+7YOsjao3w+DPkE=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BC?=
 =?utf-8?Q?nther?= Noack <gnoack@google.com>, "Dr.
 David Alan Gilbert" <linux@treblig.org>, Andrew Morton
 <akpm@linux-foundation.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, David Howells
 <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC 08/11] security: Hornet LSM
In-Reply-To: <CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcFOqOsCxmuL+ig@mail.gmail.com>
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
 <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
 <CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcFOqOsCxmuL+ig@mail.gmail.com>
Date: Thu, 18 Dec 2025 13:26:23 -0800
Message-ID: <87qzsrh474.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Dec 10, 2025 at 6:14=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>> +++ b/security/hornet/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config SECURITY_HORNET
>> +       bool "Hornet support"
>> +       depends on SECURITY
>> +       default n
>
> So you're disallowing this new LSM to be a module?
> That doesn't smell good.
>
>> +static int hornet_verify_hashes(struct hornet_maps *maps,
>> +                               struct hornet_parse_context *ctx)
>> +{
>> +       int map_fd;
>> +       u32 i;
>> +       struct bpf_map *map;
>> +       int err =3D 0;
>> +       unsigned char hash[SHA256_DIGEST_SIZE];
>> +
>> +       for (i =3D 0; i < ctx->hash_count; i++) {
>> +               if (ctx->skips[i])
>> +                       continue;
>> +
>> +               err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
>> +                                             ctx->indexes[i] * sizeof(m=
ap_fd),
>> +                                             sizeof(map_fd));
>
> As was pointed out several times earlier this is an obvious TOCTOU bug.
> An attacker can change this map_fd between LSM checks and later verifier =
use.
> All the "security" checks further are useless.

Thank you, Alexei, for pointing that out. I=E2=80=99ll ensure it=E2=80=99s =
addressed in
the next iteration.

>
>> +               if (err < 0)
>> +                       return LSM_INT_VERDICT_BADSIG;
>> +
>> +               CLASS(fd, f)(map_fd);
>> +               if (fd_empty(f))
>> +                       return LSM_INT_VERDICT_BADSIG;
>> +               if (unlikely(fd_file(f)->f_op !=3D &bpf_map_fops))
>
> Ohh. So this is why this LSM has to be built-in.
> bpf_map_fops is bpf internal detail. It's not going to be exported.
> You cannot open code __bpf_map_get() and get away with it.
>
>> +                       return LSM_INT_VERDICT_BADSIG;
>> +
>> +               if (!map->frozen)
>> +                       return LSM_INT_VERDICT_BADSIG;
>> +
>> +               map =3D fd_file(f)->private_data;
>> +               map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
>
> This too. It's absolutely not ok for LSM to mess with bpf internal state.
>
> The whole LSM is one awful hack.
> The diff stat doesn't touch anything in the kernel/bpf/
> yet you're messing with bpf internals.
>
> Clearly, you guys want to merge this garbage through LSM tree.
> Make sure to keep my Nack when you send it during the merge window.

Sure thing. I'll include your Nacked-by: in future versions.


-blaise

