Return-Path: <bpf+bounces-77263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F6CD38D8
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 00:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B7F301174C
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5EA2FC037;
	Sat, 20 Dec 2025 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNXrcC1k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7FF26A1CF;
	Sat, 20 Dec 2025 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766273799; cv=none; b=B0GMftQoDA3InSznA9IqKrbKjzlN9UpBzBB/sW+NQPL92jjsR9oHIM0p9KeK0J2LAbY6OfOlCPADSKPkCRdrpHyZf7rB5SPdcWWWtEaJJUwnKyywWpoKIsucWtES4AaPM0NX07WnZ+IY5ku4VoCCf0vcpE7ddipY2DnZZui9G+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766273799; c=relaxed/simple;
	bh=vC5fU+fTzGjQTiDjhCHNJ4VGuHwaJ8Hy/6qGl11E1eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIVwQCLPEUsDMEJcli5u+KRKx40k3ErCY6Y9GYvrt6Ud5lcPuEQ9tZDBChePpWkETqonfPps7GoZ9SDcwAiAA+huZwd4aBL1A8UDdvH827bUqp8jVu79ypQxgSib8v0WktFo0npBndSJByTqJhAUWL4pP7hUSCkiu7PL8HzG5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNXrcC1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB364C4CEF5;
	Sat, 20 Dec 2025 23:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766273799;
	bh=vC5fU+fTzGjQTiDjhCHNJ4VGuHwaJ8Hy/6qGl11E1eo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cNXrcC1kss3cX6lVK2eK8znmHtmpJxAXTFZ8ikOyMW9Mlkadac2rbYd4WhD07yj0u
	 WE79d5mI+We6k/IhuUDkawjtJ1c+VUaABviEFTDUNiM3feXZEfqXjCd0apyEd/vYvh
	 VN0gPgtq+KCNlx+kRPeymqM3CeLS7uwvCe2918FoHfOywqeIFNnPqbCBv3wYHMyQHV
	 WhFnN/XslI5KLXjohwTluhke8vanTYOvvOdUuiAZqulm3FaJHyNySJcWVpK5vkMF4A
	 XijQxAJvN6LpLe8/LJzqWvokPli7zRN72ciD7R57hFdXkNLJdodhcViB9j64MM5nXx
	 9PHmwgxFW4u6Q==
Message-ID: <e1fb9a40-9580-4c6b-8272-2d306a581cd1@kernel.org>
Date: Sat, 20 Dec 2025 16:36:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, linux-crypto@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20251218200910.159349-1-ebiggers@kernel.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251218200910.159349-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 1:09 PM, Eric Biggers wrote:
> diff --git a/include/sha1.h b/include/sha1.h
> new file mode 100644
> index 00000000..4a2ed513
> --- /dev/null
> +++ b/include/sha1.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * SHA-1 message digest algorithm
> + *
> + * Copyright 2025 Google LLC
> + */
> +#ifndef __SHA1_H__
> +#define __SHA1_H__
> +
> +#include <linux/types.h>
> +#include <stddef.h>
> +
> +#define SHA1_DIGEST_SIZE 20
> +#define SHA1_BLOCK_SIZE 64

How come these are not part of the uapi?

I applied this to iproute2-next to get as much soak time as possible.
Anyone using legacy bpf (added Toke in case he knows) in particular
should test with top of tree.

