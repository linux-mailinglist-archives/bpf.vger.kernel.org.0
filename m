Return-Path: <bpf+bounces-78414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884AFD0C720
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE418301C09E
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6C33C50B;
	Fri,  9 Jan 2026 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG1Eceij"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB62345752
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997167; cv=none; b=ahUie5b9O17QUtsGBxJbFLaNVBZo2vjafDrwcIWmahXdaVdiDgdET38vYxef2lcI8P3kwZ9FTvkMIJtFRKSk/poRXyWYfEUo0+ggzXHO75ABHNTnRZ04FIRoae2qyFvYIVuuyavGJy4xDQbpHTFxbucVF8jRYAS3OYb0XGJtfYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997167; c=relaxed/simple;
	bh=UGFqmOKdYM5qy9w4k4KZYiwAl5bTXCSNGRzH5EArq28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTOMjT1WERk1bj48YiSzdTCL3xgbiaVRnpS4I/ysDJ8g91qIWzvmC0sjysUb3tnfjyO2Iyd0m49I/sznJPeMK5MVsNsmnRFC3CnBCrPxTiCxdEGE+Ew8iVq6o2J5P9tl+ftFR8WGLxSFvdrTgTE601kWEyvpbYcOF5y3qQO7b6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG1Eceij; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c868b197eso4097875a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997166; x=1768601966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCzEGvczVtorYMKoTVoOD+MnKd0m5bay3bnxcf8yol0=;
        b=aG1EceijiapKYnmUeQaMcJaEXpuZYOwZD8pEZt+sKLMOoTCMjes5GVJ8rG00QgB45n
         OATQDZAuPtVEaSOmvR7FizrIIol0zwvPiTZiRF9hNK6Y+R+UPiXKd4eQFM0PM5kK3Yxu
         t3GZke8jNZYbD+nLN0uQaIw7/tSIBm2/PWewyhVLKJZcvc4D8AYnhxdAK63m7k6KWsVw
         6QGat8bnCz5gJmsu1h6yb5wq97OzLhYQ2EMxwS5SSzQQcGG/nC4X0wl/ngw25vh1MW/x
         c4lwlR//eUj/KhaZG8eRs6o9BAahhkBZ/KKCl8hMfmdZQOm2VpdpWi9MS62eBvN/7o5Q
         mvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997166; x=1768601966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XCzEGvczVtorYMKoTVoOD+MnKd0m5bay3bnxcf8yol0=;
        b=LLa8DaoAgrpRujz7M/wsjJmqCp+VK01+Y2gMPKfXNoUuRUeNQSyLi5ELQqY0gJRa3F
         QlUeafFcne87oH6qNckZzK4GpPpeRdFl21XRw6Ift01LzRN9J4MteKE1/li3xBgZsWGn
         N7+RAF0HT/Ego6r+mrPZK/juaw/N8q4de0qRRJfRObCHl8eTkubR+cLsxV8YeAKMqaso
         NwQYl0Ivwx2RK+PMPqth4UnSN0QJpIOdKBUzAt9dbiNsdMHhEdz6RXFL7e/cdAzl47+w
         IJpma5m1tZfIWDJlq/j56S8YsCQ5TYxlHie11NTrQ/R+VSIx3/Vbgx2j5rN/fW8NumkC
         nqPA==
X-Gm-Message-State: AOJu0YwdIBp/oOhsukHMM7+NF7sJKfyZXB7EXK5XAffSFJ5wDvul25St
	qWXM1Spk1O7oDNw/w+42s0goAlnNbdvUxUtacD9Rtqr0fJ6xKEzFMVLCqqc7xhytuORbi3zYlWR
	jY7rM/colSWG7XYo1KYDqxN5xFKPqc5c=
X-Gm-Gg: AY/fxX6e0KevEsbyA9iG28Yl1++t2wDisxh7WafeVU2ffvxz/JhYWPAY6bNWze+Zmpi
	8pdOSC4XaSTLJ0Q/fTnrN3ncAL4z01ikKjtou6r1kpFnBpveowXaDD2X9BsYqbzQQifABSxebRu
	8DJvRF8ULwCZ1x4edvOD26Lb+PpHl0T6bd6nTU1PX/aOOiYmgXv1Ap1zMPW+3RvvCV2emznFRSX
	7ptc9Ntd0tlkwCKbunP5lcquM4T/+2j2rZ/bIWb3eRnjDscrnrHnIIyL6H+NAJJMhRtEfNz9D7w
	swrx6i9H
X-Google-Smtp-Source: AGHT+IGi2LSyydHwc4W1iEbJG0NjU2W5M4G6kSjfbfeivsT8idd1++UBoTQwYG/0ldIL8yCV3FWi6VHqdYQVT+L7M7w=
X-Received: by 2002:a17:90b:4c46:b0:34c:f92a:ad05 with SMTP id
 98e67ed59e1d1-34f68b9a0ffmr10903258a91.11.1767997165605; Fri, 09 Jan 2026
 14:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 14:19:07 -0800
X-Gm-Features: AQt7F2peot7_m-FxIiWYP6bhMPw-E17ypqh5RVDJoDHrQr2higLmpi0TY1WLfqQ
Message-ID: <CAEf4BzZvMMaGUeDh-m2STNhLzSxhBkW5iwq_vNAF8dqeRQjWaQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async operations
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:49=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce mpmc_cell, a lock-free cell primitive designed to support
> concurrent writes to struct in NMI context (only one writer advances),
> allowing readers to consume consistent snapshot.
>
> Implementation details:
>  Double buffering allows writers run concurrently with readers (read
>  from one cell, write to another)
>
>  The implementation uses a sequence-number-based protocol to enable
>  exclusive writes.
>   * Bit 0 of seq indicates an active writer
>   * Bits 1+ form a generation counter
>   * (seq & 2) >> 1 selects the read cell, write cell is opposite
>   * Writers atomically set bit 0, write to the inactive cell, then
>     increment seq to publish
>   * Readers snapshot seq, read from the active cell, then validate
>     that seq hasn't changed
>
> mpmc_cell expects users to pre-allocate double buffers.
>
> Key properties:
>  * Writers never block (fail if lost the race to another writer)
>  * Readers never block writers (double buffering), but may require
>  retries if write updates the snapshot concurrently.
>
> This will be used by BPF timer and workqueue helpers to defer NMI-unsafe
> operations (like hrtimer_start()) to irq_work effectively allowing BPF
> programs to initiate timers and workqueues from NMI context.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/Makefile    |   2 +-
>  kernel/bpf/mpmc_cell.c |  62 +++++++++++++++++++++++++++
>  kernel/bpf/mpmc_cell.h | 112 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 175 insertions(+), 1 deletion(-)
>

LGTM overall (though I didn't think much about all the acquire/release
semantics)

> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 79cf22860a99ba31a9daf08a29de0f3a162ba89f..753fa63e0c24dc0a332d86c2c=
424894300f2d611 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno-=
gcse
>  endif
>  CFLAGS_core.o +=3D -Wno-override-init $(cflags-nogcse-yy)
>
> -obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o token.o liveness.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o token.o liveness.o mpmc_cell.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o bpf_insn_array.o
> diff --git a/kernel/bpf/mpmc_cell.c b/kernel/bpf/mpmc_cell.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca91b4308c8b552bc81cfefa2=
d975290a64b596d
> --- /dev/null
> +++ b/kernel/bpf/mpmc_cell.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include "mpmc_cell.h"
> +
> +static u32 read_cell_idx(struct bpf_mpmc_cell_ctl *ctl, u32 seq)
> +{
> +       return (seq & 2) >> 1;

unconventional, why not `(seq >> 1) & 1`?

> +}
> +
> +void bpf_mpmc_cell_init(struct bpf_mpmc_cell_ctl *ctl, void *cell1, void=
 *cell2)
> +{
> +       atomic_set(&ctl->seq, 0);
> +       ctl->cell[0] =3D cell1;
> +       ctl->cell[1] =3D cell2;
> +}
> +
> +void *bpf_mpmc_cell_read_begin(struct bpf_mpmc_cell_ctl *ctl, u32 *seq)
> +{
> +       *seq =3D atomic_read_acquire(&ctl->seq);
> +       /* Mask out acive writer bit */

typo: active

> +       *seq &=3D ~1;

instead of this bit manipulation, why not return logical epoch to
user, i.e., (seq >> 1)

> +
> +       return ctl->cell[read_cell_idx(ctl, *seq)];
> +}
> +
> +int bpf_mpmc_cell_read_end(struct bpf_mpmc_cell_ctl *ctl, u32 seq)
> +{
> +       u32 new_seq;
> +
> +       /* Ensure cell reads complete before checking seq */
> +       smp_rmb();
> +
> +       new_seq =3D atomic_read_acquire(&ctl->seq);
> +       new_seq &=3D ~1; /* Ignore active write bit */

as above, new_seq =3D seq >> 1 (this is "epoch", lower bit is for
internal writer coordination, that's implementation detail, not part
of external contract)

> +       /* Check if seq changed between begin and end, if it did, new sna=
pshot is available */
> +       if (new_seq !=3D seq)
> +               return -EAGAIN;
> +
> +       return 0;
> +}
> +
> +void *bpf_mpmc_cell_write_begin(struct bpf_mpmc_cell_ctl *ctl)
> +{
> +       u32 seq;
> +
> +       /*
> +        * Try to set the lowest bit, on success, writer owns cell exclus=
ively,
> +        * other writers fail
> +        */
> +       seq =3D atomic_fetch_or_acquire(1, &ctl->seq);
> +       if (seq & 1) /* Check if another writer is active */
> +               return NULL;
> +
> +       /* Write to opposite to read buffer */
> +       return ctl->cell[read_cell_idx(ctl, seq) ^ 1];
> +}
> +
> +void bpf_mpmc_cell_write_commit(struct bpf_mpmc_cell_ctl *ctl)
> +{
> +       atomic_fetch_add_release(1, &ctl->seq);
> +}

[...]

