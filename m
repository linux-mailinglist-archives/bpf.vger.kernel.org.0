Return-Path: <bpf+bounces-76542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E61CB9D75
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 22:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040EB3097BA3
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04630FC1F;
	Fri, 12 Dec 2025 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxyI3fbt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBFD3128C0
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573213; cv=none; b=m7XZr+fo7gMSNPTE+4kC52lKP29US/+dwNwApytN9dNsIvcE4ed6i0fDNT3FJExtqZn9KR7ZJjpvY0U8d3h4DgNdXqppGiupWoXBV98StROx1tPZ1cotjFxjXPVkymAtmVdHbXWBOZQIqoXcHQOixsHa0CaNJbym2nzCDWQnQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573213; c=relaxed/simple;
	bh=vNs65okWEnxU+wL46GhNte8Vv/UWHYq06Ri/4oUlbuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O72Rf49G0Dm1YYZMnjwezdg3DuVjZuBMCjuYdBE1PlpDaaD7QPN2J2FeI7vcy9lJq5uBiZBtO+wxsxtIB5Z0VCRxaYy68iT545pz+nLu1SzMndnkZ3axUFxNgyo9l0cTZGBLgYtpJwtcddqS+ZJhw2RJAkMZwRvsZV2jaLQPlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxyI3fbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F2BC19422
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765573213;
	bh=vNs65okWEnxU+wL46GhNte8Vv/UWHYq06Ri/4oUlbuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XxyI3fbtN/NkwJMaGa4OEaGQuCg9RCbaNpO6VV02+NmTYeo73/FYqBbhJVeo33xVC
	 LdLHLjU+uE4F7byqvIouX4ncADc1fE0yg/bvh44nryT4UFG7btZyhSjtttqNaSaXsw
	 AVOK8qYenJcQJQ1g5+F6bzTmb8WiYM1Uew9CuKITpY/3kMixSlLhifsnpNcik+VHcc
	 KOfXa3UaZALJnMaBrIkXAS4a9PoOnDjtsgQ1cw7U05VMTBXrxc9Yo19Xn9L/woNuTD
	 kaL8urNuziFoxMER4CmbcgRsizPzusFW5B0W6+Zv/De17DUQxzxhYnQmy9uanimYKn
	 qBR2e5p6ww/Gw==
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1329160a12.0
        for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 13:00:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIr6TWX4QjKvPW1zO0Q2kXDlYgzc11hUJlqOJJCVvQyCl229M9j4fEtxB7Q6QQhX1V6f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVEilxRXVtzHpT+kOIibm3NAxflLxrJH4ectBNNmWsYMvfD9K
	6yXy1UzIo0/4W2yS2+dNqsH3KlpTe2yRVh+MXJ/0fFIk2pwVtIAroaqab+Nm4fguVz5O95Zsll+
	9s5negXeccbrWrRlroK38jTzbJPbSYa4=
X-Google-Smtp-Source: AGHT+IE4bBRkMr0vNkzoNdrUnNSRAplxnSxqty6fiuQXeF+HUFTDcZKhS2ZCttOuhpHhQzd/umWhLPYmdNJpoMak7xI=
X-Received: by 2002:a05:693c:40d0:b0:2ac:2480:f0ac with SMTP id
 5a478bee46e88-2ac300f6569mr2110073eec.23.1765573212764; Fri, 12 Dec 2025
 13:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com> <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
In-Reply-To: <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Fri, 12 Dec 2025 13:00:01 -0800
X-Gmail-Original-Message-ID: <CAKtyLkHNA_fyyK2WZrpA6o1nOzY6dOt+pfhFjDR-1H9UJOceAw@mail.gmail.com>
X-Gm-Features: AQt7F2qtbDoeZXSD4QDpL4AcGDvbra1mTwhMdF2l-C3EDOB1HTgkos148Fau3ck
Message-ID: <CAKtyLkHNA_fyyK2WZrpA6o1nOzY6dOt+pfhFjDR-1H9UJOceAw@mail.gmail.com>
Subject: Re: [RFC 08/11] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 6:18=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This adds the Hornet Linux Security Module which provides enhanced
> signature verification and data validation for eBPF programs. This
> allows users to continue to maintain an invariant that all code
> running inside of the kernel has actually been signed and verified, by
> the kernel.
>
> This effort builds upon the currently excepted upstream solution. It
> further hardens it by providing deterministic, in-kernel checking of
> map hashes to solidify auditing along with preventing TOCTOU attacks
> against lskel map hashes.
>
> Target map hashes are passed in via PKCS#7 signed attributes. Hornet
> determines the extent which the eBFP program is signed and defers to
> other LSMs for policy decisions.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
...
> +
> +int hornet_next_map(void *context, size_t hdrlen,
> +                    unsigned char tag,
> +                    const void *value, size_t vlen)
> +{
> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_context=
 *)value;

I think you wanted to cast context instead?

> +
> +       ctx->hash_count++;
> +       return 0;
> +}
> +
> +
> +int hornet_map_index(void *context, size_t hdrlen,
> +                    unsigned char tag,
> +                    const void *value, size_t vlen)
> +{
> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_context=
 *)value;

Same above.

> +
> +       ctx->hashes[ctx->hash_count] =3D *(int *)value;
> +       return 0;
> +}
> +
> +int hornet_map_hash(void *context, size_t hdrlen,
> +                   unsigned char tag,
> +                   const void *value, size_t vlen)
> +
> +{
> +       struct hornet_parse_context *ctx =3D (struct hornet_parse_context=
 *)value;

Same above.

-Fan

> +
> +       if (vlen !=3D SHA256_DIGEST_SIZE && vlen !=3D 0)
> +               return -EINVAL;
> +
> +       if (vlen !=3D 0) {
> +               ctx->skips[ctx->hash_count] =3D false;
> +               memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE]=
, value, vlen);
> +       } else
> +               ctx->skips[ctx->hash_count] =3D true;
> +
> +       return 0;
> +}
> +

