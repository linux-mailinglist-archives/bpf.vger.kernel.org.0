Return-Path: <bpf+bounces-8749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383B789715
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6E228188E
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C13EDDD8;
	Sat, 26 Aug 2023 14:02:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8ABCA58
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 14:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3A7C433C7;
	Sat, 26 Aug 2023 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693058570;
	bh=RZHkYur0kpYvgVYND39F8EDHpz0KGEHIwqM0/355IUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CYK6t/9miqMJe5VMd7UiNWV2OFKCownnT6Ig+7Q+o6MTvHzQbkt3fZ9WB6gvA9xA7
	 OuC0j56OJRCUCgDjaMocRfXzo1gKz5OEychsYWDvjjLDfOuckjMs3GuGrfau7vRIOV
	 1N1+4pj+EOEY0cHOsRxfaSVJsCF+eZgr89hy28O/WmTseKLJlQY8hH2FPBbvhrB4aD
	 gfexUXDZfDnS+eAwuDv+bY5ZeBJCG9OCjdpexk63QxMwlsBqlfP2x94UsIaepmG/29
	 ek3eVKbCVYNEl/zihNgr2P+RQKkFlAfE1tuN9nnVuV4x1Czf2WRtlZ+BAyrWUO+DJW
	 6iIPDxHnHScXQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
 conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next v2 2/3] riscv: implement a memset like function
 for text
In-Reply-To: <20230824133135.1176709-3-puranjay12@gmail.com>
References: <20230824133135.1176709-1-puranjay12@gmail.com>
 <20230824133135.1176709-3-puranjay12@gmail.com>
Date: Sat, 26 Aug 2023 16:02:47 +0200
Message-ID: <871qfprjeg.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> The BPF JIT needs to write invalid instructions to RX regions of memory
> to invalidate removed BPF programs. This needs a function like memset()
> that can work with RX memory.
>
> Implement patch_text_set_nosync() which is similar to text_poke_set() of
> x86.

Some additional nits, in addition to the other comments (Song, kernel
test bot, Lehui).

> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/riscv/include/asm/patch.h |  1 +
>  arch/riscv/kernel/patch.c      | 74 ++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patc=
h.h
> index 63c98833d510..aa5c1830ea43 100644
> --- a/arch/riscv/include/asm/patch.h
> +++ b/arch/riscv/include/asm/patch.h
> @@ -7,6 +7,7 @@
>  #define _ASM_RISCV_PATCH_H
>=20=20
>  int patch_text_nosync(void *addr, const void *insns, size_t len);
> +int patch_text_set_nosync(void *addr, const int c, size_t len);
>  int patch_text(void *addr, u32 *insns, int ninsns);
>=20=20
>  extern int riscv_patch_in_stop_machine;
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 465b2eebbc37..24d49999ac1a 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -13,6 +13,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/ftrace.h>
>  #include <asm/patch.h>
> +#include <asm/string.h>
>=20=20
>  struct patch_insn {
>  	void *addr;
> @@ -53,6 +54,34 @@ static void patch_unmap(int fixmap)
>  }
>  NOKPROBE_SYMBOL(patch_unmap);
>=20=20
> +static int __patch_insn_set(void *addr, const int c, size_t len)

Drop the "const" from "const int c" everywhere in this patch, and let's
just use u8 instead of int. We don't need to carry the old memset()
legacy argumentts! We're more modern than that! ;-)


Bj=C3=B6rn

