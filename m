Return-Path: <bpf+bounces-13359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC37D8ADE
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7713282831
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8693D99D;
	Thu, 26 Oct 2023 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNcwDV44"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588341741;
	Thu, 26 Oct 2023 21:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4EBC433C7;
	Thu, 26 Oct 2023 21:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698356880;
	bh=ew1HKKt5nbfRzGpkcLlKh0lA/TCUwgQ5yYRD1O9MA5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNcwDV44NZ+u5yga+M+B0DI42A+Bk65sQP8BUXJzHGmRfgpBwr3UpVEy7Sb5Z4W2R
	 lDeSUzKFPkMVE0ZFEOqIVE0zayYhCRQyFkQBXaeBJxUNf9RpORLz76sZU7ckReM3U5
	 AbU9CyaqI/WKMZUMYJQY4jxFq7FqPHjOUcQZoxc3mCPnwjoBvc5LenQixAlu2L7E5L
	 lj4hmUMLJkO0mrzZuTxqAFK3WD9NbXyNQTEwzJnTfjK6Bv+fASEuNMs6TgmTPsxeHm
	 8ouXDzn5ftmpzydYsELMJ/FyS2Q+rmkfYHevyWY3qn9ey4yCPt6o6Np6etJbOXexoV
	 sMyC68cbIXqiw==
Date: Thu, 26 Oct 2023 14:47:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: add skcipher API support to TC/XDP
 programs
Message-ID: <20231026144759.5ce20f4c@kernel.org>
In-Reply-To: <20231026015938.276743-1-vadfed@meta.com>
References: <20231026015938.276743-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 18:59:37 -0700 Vadim Fedorenko wrote:
> Add crypto API support to BPF to be able to decrypt or encrypt packets
> in TC/XDP BPF programs. Only symmetric key ciphers are supported for
> now. Special care should be taken for initialization part of crypto algo
> because crypto_alloc_sync_skcipher() doesn't work with preemtion
> disabled, it can be run only in sleepable BPF program. Also async crypto
> is not supported because of the very same issue - TC/XDP BPF programs
> are not sleepable.

Do CC crypto@ for the next version, please.

> +/**
> + * struct bpf_crypto_skcipher_ctx - refcounted BPF sync skcipher context structure
> + * @tfm:	The pointer to crypto_sync_skcipher struct.
> + * @rcu:	The RCU head used to free the crypto context with RCU safety.
> + * @usage:	Object reference counter. When the refcount goes to 0, the
> + *		memory is released back to the BPF allocator, which provides
> + *		RCU safety.
> + */
> +

spurious newline?

> +struct bpf_crypto_skcipher_ctx {

> +/**
> + * bpf_crypto_skcipher_ctx_acquire() - Acquire a reference to a BPF crypto context.

The contexts are refcounted and can be placed in maps?
Does anything prevent them from being used simultaneously 
by difference CPUs?

> +	case BPF_DYNPTR_TYPE_SKB:
> +		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));

dynptr takes care of checking if skb can be written to?

