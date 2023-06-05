Return-Path: <bpf+bounces-1848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E3722D3B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3421C20C6B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F6DDD0;
	Mon,  5 Jun 2023 17:05:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD36FC3
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 17:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB30C4339C;
	Mon,  5 Jun 2023 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685984714;
	bh=yEpxiQ3fmeL0xXU4oqZwbEUseI3GKuRgp39yNbpnCQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BolcBbiCcHlGyYY2b6/88QhsCF7i9w0kj753eMZt5nBdvBIjsHfDAPDe0Ba9pCGRf
	 F2fUQfzLZTrKazCBgZl2t6P7GHuEqWfOtGdRZ6PJus5wvXAcRXRR0ZNw5zcmCac0mi
	 36FHvdlJ25I5MabmuIDzog2p6NX0yyMIx45lt/nfsPWbFEPB+USg3Fcxo0IoDgQFNP
	 oBaxagNngmnzHEW2jEIhHOn6EC/b5hTP9EqAz7/iOu33m5qoJqWoRp7LryvCNBwwkS
	 TGJsnratZdjA1JFs4PXsywLvk+fAForUrvT9XuUpRgnNeIwnmb7gZCl/QsBVa1sE7R
	 Upsmaghvbu2Zg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso22398731fa.2;
        Mon, 05 Jun 2023 10:05:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDyQJhDpOSBVoLotrchLF9T5lUWAY1wv3FAfXlUO6DGKujvO8KO1
	dlbSPcWVBL5SHzEjsd1ZfCGctWGLQdRm1shEmjk=
X-Google-Smtp-Source: ACHHUZ5a4uJgqYj6XYfDGH+cbQx//PBtbULgCbjcB59kMvuL6TUIBZNr7mZHyTg0SmBldrQE5OAx+nZDYXN+zYRkeR0=
X-Received: by 2002:a2e:8e97:0:b0:2b0:790e:95ab with SMTP id
 z23-20020a2e8e97000000b002b0790e95abmr4837221ljk.31.1685984712145; Mon, 05
 Jun 2023 10:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com> <20230605074024.1055863-4-puranjay12@gmail.com>
In-Reply-To: <20230605074024.1055863-4-puranjay12@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 5 Jun 2023 10:05:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4JVUUzMfNQwTE_uzp3bnO3EAYDikU1Nyx6x-6ROFDNOA@mail.gmail.com>
Message-ID: <CAPhsuW4JVUUzMfNQwTE_uzp3bnO3EAYDikU1Nyx6x-6ROFDNOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, catalin.marinas@arm.com, mark.rutland@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 5, 2023 at 12:40=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
> ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final ROX buffer
> with bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
> JIT as these functions are required by bpf_jit_binary_pack allocator.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 119 +++++++++++++++++++++++++++++-----
>  1 file changed, 102 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 145b540ec34f..ee9414cadea8 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -76,6 +76,7 @@ struct jit_ctx {
>         int *offset;
>         int exentry_idx;
>         __le32 *image;
> +       __le32 *ro_image;

We are using:
image vs. ro_image
rw_header vs. header
rw_image_ptr vs. image_ptr

Shall we be more consistent with rw_ or ro_ prefix?

>         u32 stack_size;
>         int fpb_offset;
>  };
> @@ -205,6 +206,20 @@ static void jit_fill_hole(void *area, unsigned int s=
ize)
>                 *ptr++ =3D cpu_to_le32(AARCH64_BREAK_FAULT);
>  }
>
> +int bpf_arch_text_invalidate(void *dst, size_t len)
> +{
> +       __le32 *ptr;
> +       int ret;
> +
> +       for (ptr =3D dst; len >=3D sizeof(u32); len -=3D sizeof(u32)) {
> +               ret =3D aarch64_insn_patch_text_nosync(ptr++, AARCH64_BRE=
AK_FAULT);

I think one aarch64_insn_patch_text_nosync() per 4 byte is too much overhea=
d.
Shall we add a helper to do this in bigger patches?

Thanks,
Song

> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +

[...]

