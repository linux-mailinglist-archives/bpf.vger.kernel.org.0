Return-Path: <bpf+bounces-76765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3A6CC523D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0313302AACE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C12729BD88;
	Tue, 16 Dec 2025 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a+Ubi4Lf"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078749659;
	Tue, 16 Dec 2025 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918905; cv=none; b=BANJGTt9fKqxRey8+9gWItkziawuDREtNK3r61PSzIHDXmWyvMBjRNTIDYKVpJEs8vM0rcnklydOnaS6SWipi1RdtK3euMmhAXpZ65FBt5vBz/QhF9ciB6MFAQHg1BmFWSxNGAvzffn5Gku+/MNKN/pOJe6tYFT/VVx2w0JBd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918905; c=relaxed/simple;
	bh=/5cokEzKklEDHGu8qEDp3nOrQjhC/g4806yhyBz/anU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rj6gxVKF53PELY1+yopiIhDZ0mm5SNp0oQFBb2OfXbPrdBp9H089IoAhpJtN+cKmvCrgLtuygB17iXgA+rVZLJ6a0EI8mj7UCUQJDnmaqU1oJ+9GQqdN9aU+3CrEc7zXqEzZVfJACcL5fHifI1yWJJ8LP7WSkH9K4bZnvIGiojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a+Ubi4Lf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 52956200D63F;
	Tue, 16 Dec 2025 13:01:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 52956200D63F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765918898;
	bh=b4bM1mzCuioiwdRyaykLz5ir0VxowK6k3HdskL/e97o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a+Ubi4LfyL6vJmTQuztcARSgkMy9pFW9BxZ/3r4YQB8JbXH1Zw4PoBCb/YVzDa7Ye
	 fEgOeFgR6Mc8Hi++hUTSxk0tA3IPgjfwlFlx3hDcQJZOpGEty7nZq6hrzzRnZ4vUjy
	 hS1kVVh43nwg/3Z+dWMV5jujMZc/ZLtv5TlQ4C28=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Fan Wu <wufan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BC?=
 =?utf-8?Q?nther?= Noack <gnoack@google.com>, "Dr.
 David Alan Gilbert" <linux@treblig.org>, Andrew Morton
 <akpm@linux-foundation.org>, James.Bottomley@hansenpartnership.com,
 dhowells@redhat.com, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC 08/11] security: Hornet LSM
In-Reply-To: <CAKtyLkHNA_fyyK2WZrpA6o1nOzY6dOt+pfhFjDR-1H9UJOceAw@mail.gmail.com>
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
 <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
 <CAKtyLkHNA_fyyK2WZrpA6o1nOzY6dOt+pfhFjDR-1H9UJOceAw@mail.gmail.com>
Date: Tue, 16 Dec 2025 13:01:35 -0800
Message-ID: <87345ai1jk.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fan Wu <wufan@kernel.org> writes:

> On Wed, Dec 10, 2025 at 6:18=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> This adds the Hornet Linux Security Module which provides enhanced
>> signature verification and data validation for eBPF programs. This
>> allows users to continue to maintain an invariant that all code
>> running inside of the kernel has actually been signed and verified, by
>> the kernel.
>>
>> This effort builds upon the currently excepted upstream solution. It
>> further hardens it by providing deterministic, in-kernel checking of
>> map hashes to solidify auditing along with preventing TOCTOU attacks
>> against lskel map hashes.
>>
>> Target map hashes are passed in via PKCS#7 signed attributes. Hornet
>> determines the extent which the eBFP program is signed and defers to
>> other LSMs for policy decisions.
>>
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
> ...
>> +
>> +int hornet_next_map(void *context, size_t hdrlen,
>> +                    unsigned char tag,
>> +                    const void *value, size_t vlen)
>> +{
>> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_contex=
t *)value;
>
> I think you wanted to cast context instead?
>
>> +
>> +       ctx->hash_count++;
>> +       return 0;
>> +}
>> +
>> +
>> +int hornet_map_index(void *context, size_t hdrlen,
>> +                    unsigned char tag,
>> +                    const void *value, size_t vlen)
>> +{
>> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_contex=
t *)value;
>
> Same above.
>
>> +
>> +       ctx->hashes[ctx->hash_count] =3D *(int *)value;
>> +       return 0;
>> +}
>> +
>> +int hornet_map_hash(void *context, size_t hdrlen,
>> +                   unsigned char tag,
>> +                   const void *value, size_t vlen)
>> +
>> +{
>> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_contex=
t *)value;
>
> Same above.
>
> -Fan
>

Thanks Fan. Will get that fixed up.

-blaise

>> +
>> +       if (vlen !=3D SHA256_DIGEST_SIZE && vlen !=3D 0)
>> +               return -EINVAL;
>> +
>> +       if (vlen !=3D 0) {
>> +               ctx->skips[ctx->hash_count] =3D false;
>> +               memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE=
], value, vlen);
>> +       } else
>> +               ctx->skips[ctx->hash_count] =3D true;
>> +
>> +       return 0;
>> +}
>> +

