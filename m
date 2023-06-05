Return-Path: <bpf+bounces-1845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE647722CDD
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 18:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEB21C20C8B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D018F5A;
	Mon,  5 Jun 2023 16:42:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D230749A
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 16:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D98DC433A1;
	Mon,  5 Jun 2023 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685983353;
	bh=n5juZxlzx1EtJLsbnquMhCy7aHrstqC/yTfSW67S+qE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UpY/yHckYTINMFEyQt6nBEmx9F7m6ycqDkJdttfmJAbgLcViQH28Y9tMcMWVTFPAy
	 gH89M6JNIONss9O3XXW/RSFvbQ3EsGJ+cF77HVfkiF7EmNBjP3XrA4ayIeGirBVjmo
	 BPEFRlbByKV8KeEYCancTar+bWG9taqG5Wdm0nA2pug6HqHUJrSeg3mF6olPIMez/O
	 OfShD4g2xTNOI59TCkXiMPDYnyRC3QJXSRDQM7yDYL7zozoQWX0CxS9fIqeqfb7dTT
	 UVHE6Tf9RLTvsc43LTJDKAGKVuPdrKlFBbVdDzJSrnL8EuEBeW/G9noZFYPXCfFJgp
	 S7spY20NHOI+g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso42970361fa.1;
        Mon, 05 Jun 2023 09:42:33 -0700 (PDT)
X-Gm-Message-State: AC+VfDxci713zmOZ4qT/xN447GNXnIwwwUqiINjWbLfs90U8a0bPXTdB
	m6ZSgZFM/kgGngCRklH2+oCGIYJHOt9L9vqbeC4=
X-Google-Smtp-Source: ACHHUZ4+IUD6+wCdoUvmip2g5FCLhoLnY4OOKMh2gI4u81vQapPFI1fPQigx/MPY6XWxpncRJN8+QwMYpOWbxpl1QxM=
X-Received: by 2002:a2e:a442:0:b0:2ad:dd7e:6651 with SMTP id
 v2-20020a2ea442000000b002addd7e6651mr4970194ljn.43.1685983351477; Mon, 05 Jun
 2023 09:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com> <20230605074024.1055863-3-puranjay12@gmail.com>
In-Reply-To: <20230605074024.1055863-3-puranjay12@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 5 Jun 2023 09:42:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5-+eBuNGFes3i5-A4vA_f3woLwL_WbUcg6gNXssyi_Xg@mail.gmail.com>
Message-ID: <CAPhsuW5-+eBuNGFes3i5-A4vA_f3woLwL_WbUcg6gNXssyi_Xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] arm64: patching: Add aarch64_insn_copy()
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
> This will be used by BPF JIT compiler to dump JITed binary to a RX huge
> page, and thus allow multiple BPF programs sharing the a huge (2MB)
> page.
>
> The bpf_prog_pack allocator that implements the above feature allocates
> a RX/RW buffer pair. The JITed code is written to the RW buffer and then
> this function will be used to copy the code from RW to RX buffer.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Acked-by: Song Liu <song@kernel.org>

With a nit below.

> ---
>  arch/arm64/include/asm/patching.h |  1 +
>  arch/arm64/kernel/patching.c      | 39 +++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/p=
atching.h
> index 68908b82b168..dba9eb392bf1 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>  int aarch64_insn_write(void *addr, u32 insn);
>
>  int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +void *aarch64_insn_copy(void *addr, const void *opcode, size_t len);
>
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index b4835f6d594b..48c710f6a1ff 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -105,6 +105,45 @@ noinstr int aarch64_insn_write_literal_u64(void *add=
r, u64 val)
>         return ret;
>  }
>
> +/**
> + * aarch64_insn_copy - Copy instructions into (an unused part of) RX mem=
ory
> + * @addr: address to modify
> + * @opcode: source of the copy
> + * @len: length to copy
> + *
> + * Useful for JITs to dump new code blocks into unused regions of RX mem=
ory.
> + */

nit:
I understand "addr" and "opcode" are used by x86 text_poke_copy(). But mayb=
e
we should call them "dst" and "src" or "to" and "from" or something similar=
?

Thanks,
Song

> +noinstr void *aarch64_insn_copy(void *addr, const void *opcode, size_t l=
en)
> +{
> +       unsigned long flags;
> +       size_t patched =3D 0;
> +       size_t size;
> +       void *waddr;
> +       void *dst;
> +       int ret;
> +
> +       raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +       while (patched < len) {
> +               dst =3D addr + patched;
> +               size =3D min_t(size_t, PAGE_SIZE - offset_in_page(dst),
> +                            len - patched);
> +
> +               waddr =3D patch_map(dst, FIX_TEXT_POKE0);
> +               ret =3D copy_to_kernel_nofault(waddr, opcode + patched, s=
ize);
> +               patch_unmap(FIX_TEXT_POKE0);
> +
> +               if (ret < 0) {
> +                       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +                       return NULL;
> +               }
> +               patched +=3D size;
> +       }
> +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +       return addr;
> +}
> +
>  int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>  {
>         u32 *tp =3D addr;
> --
> 2.39.2
>

