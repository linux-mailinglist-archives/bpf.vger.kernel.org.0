Return-Path: <bpf+bounces-76952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0D7CC9F79
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 02:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 866E6301C3F0
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AED24E4A8;
	Thu, 18 Dec 2025 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN55ENsN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0C86331
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766020965; cv=none; b=J0rBIlpZZH5DQ1+2g5wKHDehvNxcNwaFhVUyU1FMqP4gwSh/ueibwMGygRJ7Fv3QWFNT28ZJAF36YsIV2Q5+/Qmvny4wN+rga4y7Pb6/bWyGKRt8iMpYmjFP3VFxqYV75WUv68jN01TGzhYS2Z599dFZUDPtI3RtSSUeNFMAmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766020965; c=relaxed/simple;
	bh=EfOagSKtMPrAituOBjbg9sgoDPP1BxPBt4MiTxip3EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFTl016LuDafAa00Kp6NrTWDD73vqHEZJ+6itEr0gQhfhqyN0BGuCiPHDc3Z6jn4KkOtCBmjMn29zVf5jUuwhlC91FoZvNzn0ilEh8dnf8LSWqHeb058t+FeikYhj/AcSSUWqt4jh2e7tyOalU8nTL7Ynf2T1JbYymcFadZ9aXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN55ENsN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632b0621so578815e9.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 17:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766020962; x=1766625762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUfWSU55e6klqk06RT8DooaLMYJUGtBJoBI7Mktsq84=;
        b=DN55ENsNgF+7YGhsoHuvLt6apieEJ1LPFRaaosUYvut7V/c6wUrYq5vBUgbgfep8dG
         m2u9c+BKzWIczWyN539tepMkIGU3JTE7Sg/cs3Z+chyZd0VqE4roZwxLXBEaHcCyB7Cy
         Y9SyhM9T+2tVykRZC9QCZujcSP6aJbl6nchIve9RCjZnsMAzdAKHBVaQvB8Yes2X4tmb
         8xNB8aqoNJyNgb2BG1DcaF4j4EiCcpAULrWOUXh7Y67ikN0P4lgigb6EmKN2VdFFl6xU
         YDNjlRuIa/5QDTjAxRudbN/ZR6/fRXE5Cfy1AJpKvutZ4xQj494UCfKtlCvMtcK+soJb
         vlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766020962; x=1766625762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pUfWSU55e6klqk06RT8DooaLMYJUGtBJoBI7Mktsq84=;
        b=Pa3YFRUzxyqkaU4uVKO8C8czqS2UAGt0e/8DePkDIzdSQBgPRCX4e8v56h4iPqSU9R
         SszGMlZMiBYHOTmmlyIv+kR0uuH8lR7GCV71icM2Zb9GBReoTabKlWpOZv+BPUv0QJUF
         e+Bs3pXrP9iS0CncOIvN8S515C8r6mySsOEZGiI5aamSDamx5Vq5x2ROi7EVe8821l2Z
         6Rr/JCejDF06D11Wm1b1DXlYwGb6kJribxY8DYDvMP0nXVlGYKE5/R5+jSyR5ZDhr+WT
         0MYMx03kji50WcNnSMXq6qWUKhHYGH+74f8G99Nl0O7BUJYEY0uvJAg/IAukKaxA8F5r
         fa4g==
X-Forwarded-Encrypted: i=1; AJvYcCX9mmEeiqnQuuoMbhh9PNvBvSPR+qXobQSjudYadP3GrkNtXufelHhYwRxmmNYbnWoXYvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICFWylDpmaA0d3QX2ZHVGpts1V1MKiggX9ExM59l65/XF2Ljh
	6Fhfj08fqwhqFbA5/uMmM9wgbb0qwB4kxrx4FD75+C7ctYLea/dXmgNsZcavTpwZV6ujuauLh/u
	e3eCXuPlvNU4h1AFsGuB55bNBqbCp4Jc=
X-Gm-Gg: AY/fxX4lyi30Fvho7sI9AJcyqKFq9Ad7RKWcOsR+n5bT/ejVImwkTindx9WlljFqhTx
	ypa0jgxHHUOQA9Liv8wkL+sqhnrM4EQX7BH9+nq/qB0Vnqgnbc1J1F21r5IcDPDY+TsmTxZeMfu
	hEKuv1ZXqblPKgAHcMddWUyNPRmXZMmVimF0CK1xDv+wI3O+bPuJjrP4/z+xPVfOBRFQn9RyxE7
	+CXXmsNHRr0046zXo96dzL+pPR6gX2ZpbOpT9YGRYwf23kMluxaz085zt9ZZLf/udOv5QlokYdH
	Yi7pdhFObKrjFlgnhcejnJT0CCB998MHqczNkp8=
X-Google-Smtp-Source: AGHT+IHI3Zc9UJLZXFYBDkFjZPO4pblK6riURRpClPTH4+jaz0+GBZQG1W/4BPm+kxxoU98+ZUMSkwR1ds2u6Ik3HAo=
X-Received: by 2002:a05:600d:f:b0:47b:da85:b9f3 with SMTP id
 5b1f17b1804b1-47bda85bcf1mr52495445e9.23.1766020962351; Wed, 17 Dec 2025
 17:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com> <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
In-Reply-To: <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 17:22:31 -0800
X-Gm-Features: AQt7F2rvXmPxXxfmFoBVvyhzz_llncbRbWXwHKjWzs06OF3RTcKub-VfqDonp-0
Message-ID: <CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcFOqOsCxmuL+ig@mail.gmail.com>
Subject: Re: [RFC 08/11] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, David Howells <dhowells@redhat.com>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 6:14=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> +++ b/security/hornet/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SECURITY_HORNET
> +       bool "Hornet support"
> +       depends on SECURITY
> +       default n

So you're disallowing this new LSM to be a module?
That doesn't smell good.

> +static int hornet_verify_hashes(struct hornet_maps *maps,
> +                               struct hornet_parse_context *ctx)
> +{
> +       int map_fd;
> +       u32 i;
> +       struct bpf_map *map;
> +       int err =3D 0;
> +       unsigned char hash[SHA256_DIGEST_SIZE];
> +
> +       for (i =3D 0; i < ctx->hash_count; i++) {
> +               if (ctx->skips[i])
> +                       continue;
> +
> +               err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
> +                                             ctx->indexes[i] * sizeof(ma=
p_fd),
> +                                             sizeof(map_fd));

As was pointed out several times earlier this is an obvious TOCTOU bug.
An attacker can change this map_fd between LSM checks and later verifier us=
e.
All the "security" checks further are useless.

> +               if (err < 0)
> +                       return LSM_INT_VERDICT_BADSIG;
> +
> +               CLASS(fd, f)(map_fd);
> +               if (fd_empty(f))
> +                       return LSM_INT_VERDICT_BADSIG;
> +               if (unlikely(fd_file(f)->f_op !=3D &bpf_map_fops))

Ohh. So this is why this LSM has to be built-in.
bpf_map_fops is bpf internal detail. It's not going to be exported.
You cannot open code __bpf_map_get() and get away with it.

> +                       return LSM_INT_VERDICT_BADSIG;
> +
> +               if (!map->frozen)
> +                       return LSM_INT_VERDICT_BADSIG;
> +
> +               map =3D fd_file(f)->private_data;
> +               map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);

This too. It's absolutely not ok for LSM to mess with bpf internal state.

The whole LSM is one awful hack.
The diff stat doesn't touch anything in the kernel/bpf/
yet you're messing with bpf internals.

Clearly, you guys want to merge this garbage through LSM tree.
Make sure to keep my Nack when you send it during the merge window.

