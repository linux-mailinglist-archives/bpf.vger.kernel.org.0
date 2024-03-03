Return-Path: <bpf+bounces-23277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BAA86F65E
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 18:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FCD1C20EA4
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E24076402;
	Sun,  3 Mar 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXl6LzQq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70241A8F
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709486381; cv=none; b=R7iIOT+3nNHgEQVd5NvpiEWveoEtoj8ehkLa2eC7jAcjFaa0gj9JXX4V6e6QZrDce6jCBUB8iBqrwQ2aCPBxSYh+HxfZpiSazN8PaEoH98YJ7T5n6Zh/TthV9SiPfnHF/qjhhrhx3Hy/3sOfHeGNF2JpNJnqsT9z0ZvBuV+flaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709486381; c=relaxed/simple;
	bh=UlPtf4H/LI86gK6SxfrYgxndPEHu4jkSxfnjxgykQqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcZBX6PAlwP7RzTYWfq5bCjg5VfkFk0JwVGl7YxlwSKTy2wcoAhl9OJQY0YNwxH+TA93E5cHRIJC59Gn1+D9+xClKS2bQh3lDGSjNQCmZFoKO+QEfidibRVBoorL2t20oiZ9zaa+Ss5s0s3jii+Et4nP8NM0oN/ML8bgQvlfd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXl6LzQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837FFC433C7;
	Sun,  3 Mar 2024 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709486381;
	bh=UlPtf4H/LI86gK6SxfrYgxndPEHu4jkSxfnjxgykQqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PXl6LzQqcrq7n638BkjNjKq2ImFtpQcW5LR5yXO7Gc+kjoOjHDhUfTQWzP/DYXvZN
	 OfcpFXqgLxtMMtslPyr2/nRx0QS8Tva0ovgeuUnRUMnJVAzH/SNrh2Y9bFMB3D/z5N
	 WVufy5ptQ5A60wBi9P4hVpvBkQwd33PBAkfYbWWCKi7FeVwhIkg9uAwzr9qQmLTfmh
	 /TOq4CVS27iOErr93LxwoSwvfKQHbG5KTqlQ/iYpYZaquzgmNL5Z3lMepYrb3DVLZT
	 IHLl6ENnhhBuMfMKHVoZZRz2NrRi/gw1YJA5NuQBwABSXdNJCAcE3PyEgGvLeOINKr
	 8upuM8sDGFqaQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Shahab Vahedi <list+bpf@vahedi.org>, bpf@vger.kernel.org
Cc: Shahab Vahedi <shahab@synopsys.com>, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH bpf-next v1] ARC: Add eBPF JIT support
In-Reply-To: <20240213131946.32068-1-list+bpf@vahedi.org>
References: <20240213131946.32068-1-list+bpf@vahedi.org>
Date: Sun, 03 Mar 2024 18:18:48 +0100
Message-ID: <87ttlnqlmv.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shahab,

Shahab Vahedi <list+bpf@vahedi.org> writes:

> From: Shahab Vahedi <shahab@synopsys.com>
>
> This will add eBPF JIT support to the 32-bit ARCv2 processors. The
> implementation is qualified by running the BPF tests on a Synopsys HSDK
> board with "ARC HS38 v2.1c at 500 MHz" as the 4-core CPU.

Cool!

I did quick review, mosty focusing on style, and not function. Some
general input/Qs:

What's the easiest way to test test this w/o ARC HW? Is there a qemu
port avaiable?

I don't know much about ARC -- Is v2 compatible with v3?

I'm curious about the missing support; tailcall/atomic/division/extable
support. Would it require a lot of work to add that support in the
inital change set?

There are a lot of checkpatch/kernel style issues. Run, e.g.,
"checkpatch --strict -g HEAD" and you'll get a bunch of issues. Most of
them are just basic style issues. Please try to fix most of them for the
next rev.

You should add yourself to the MAINTAINERS file.

Please try to avoid static inline in the C-files. The compiler usually
knows better.


[...]

> diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
> new file mode 100644
> index 000000000000..730a715d324e
> --- /dev/null
> +++ b/arch/arc/net/bpf_jit_core.c
> @@ -0,0 +1,1425 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The back-end-agnostic part of Just-In-Time compiler for eBPF bytecode.
> + *
> + * Copyright (c) 2024 Synopsys Inc.
> + * Author: Shahab Vahedi <shahab@synopsys.com>
> + */
> +#include <asm/bug.h>
> +#include "bpf_jit.h"
> +
> +/* Sane initial values for the globals */
> +bool emit =3D true;
> +bool zext_thyself =3D true;

Hmm, this is racy. Can we move this into the jit context? Also, is
zext_thyself even used?

> +
> +/*
> + * Check for the return value. A pattern used oftenly in this file.
> + * There must be a "ret" variable of type "int" in the scope.
> + */
> +#define CHECK_RET(cmd)			\
> +	do {				\
> +		ret =3D (cmd);		\
> +		if (ret < 0)		\
> +			return ret;	\
> +	} while (0)
> +

Nit/personal taste, but I prefer not having these kind of macros. I
think it makes it harder to read the code.

> +#ifdef ARC_BPF_JIT_DEBUG
> +/* Dumps bytes in /var/log/messages at KERN_INFO level (4). */
> +static void dump_bytes(const u8 *buf, u32 len, const char *header)
> +{
> +	u8 line[64];
> +	size_t i, j;
> +
> +	pr_info("-----------------[ %s ]-----------------\n", header);
> +
> +	for (i =3D 0, j =3D 0; i < len; i++) {
> +		/* Last input byte? */
> +		if (i =3D=3D len-1) {
> +			j +=3D scnprintf(line+j, 64-j, "0x%02x", buf[i]);
> +			pr_info("%s\n", line);
> +			break;
> +		}
> +		/* End of line? */
> +		else if (i % 8 =3D=3D 7) {
> +			j +=3D scnprintf(line+j, 64-j, "0x%02x", buf[i]);
> +			pr_info("%s\n", line);
> +			j =3D 0;
> +		} else {
> +			j +=3D scnprintf(line+j, 64-j, "0x%02x, ", buf[i]);
> +		}
> +	}
> +}
> +#endif /* ARC_BPF_JIT_DEBUG */
> +
> +/********************* JIT context ***********************/
> +
> +/*
> + * buf:		Translated instructions end up here.
> + * len:		The length of whole block in bytes.
> + * index:	The offset at which the _next_ instruction may be put.
> + */
> +struct jit_buffer {
> +	u8	*buf;
> +	u32	len;
> +	u32	index;
> +};
> +
> +/*
> + * This is a subset of "struct jit_context" that its information is deem=
ed
> + * necessary for the next extra pass to come.
> + *
> + * bpf_header:	Needed to finally lock the region.
> + * bpf2insn:	Used to find the translation for instructions of interest.
> + *
> + * Things like "jit.buf" and "jit.len" can be retrieved respectively from
> + * "prog->bpf_func" and "prog->jited_len".
> + */
> +struct arc_jit_data {
> +	struct bpf_binary_header *bpf_header;
> +	u32                      *bpf2insn;
> +};
> +
> +/*
> + * The JIT pertinent context that is used by different functions.
> + *
> + * prog:		The current eBPF program being handled.
> + * orig_prog:		The original eBPF program before any possible change.
> + * jit:			The JIT buffer and its length.
> + * bpf_header:		The JITed program header. "jit.buf" points inside it.
> + * bpf2insn:		Maps BPF insn indices to their counterparts in jit.buf.
> + * bpf2insn_valid:	Indicates if "bpf2ins" is populated with the mappings.
> + * jit_data:		A piece of memory to transfer data to the next pass.
> + * arc_regs_clobbered:	Each bit status determines if that arc reg is clo=
bbered.
> + * save_blink:		Whether ARC's "blink" register needs to be saved.
> + * frame_size:		Derived from "prog->aux->stack_depth".
> + * epilogue_offset:	Used by early "return"s in the code to jump here.
> + * need_extra_pass:	A forecast if an "extra_pass" will occur.
> + * is_extra_pass:	Indicates if the current pass is an extra pass.
> + * user_bpf_prog:	True, if VM opcodes come from a real program.
> + * blinded:		True if "constant blinding" step returned a new "prog".
> + * success:		Indicates if the whole JIT went OK.
> + */
> +struct jit_context {
> +	struct bpf_prog			*prog;
> +	struct bpf_prog			*orig_prog;
> +	struct jit_buffer		jit;
> +	struct bpf_binary_header	*bpf_header;
> +	u32				*bpf2insn;
> +	bool				bpf2insn_valid;
> +	struct arc_jit_data		*jit_data;
> +	u32				arc_regs_clobbered;
> +	bool				save_blink;
> +	u16				frame_size;
> +	u32				epilogue_offset;
> +	bool				need_extra_pass;
> +	bool				is_extra_pass;
> +	bool				user_bpf_prog;
> +	bool				blinded;
> +	bool				success;
> +};
> +
> +/*
> + * If we're in ARC_BPF_JIT_DEBUG mode and the debug level is right, dump=
 the
> + * input BPF stream. "bpf_jit_dump()" is not fully suited for this purpo=
se.

Care to elaborate a bit more on ARC_BPF_JIT_DEBUG. This smells of
duplicated funtionality with bpf_jit_dump(), and the BUG()s are scary.

> + */
> +static void vm_dump(const struct bpf_prog *prog)
> +{
> +#ifdef ARC_BPF_JIT_DEBUG
> +	if (bpf_jit_enable > 1)
> +		dump_bytes((u8 *) prog->insns, 8*prog->len, " VM  ");
> +#endif
> +}
> +
> +/*
> + * If the right level of debug is set, dump the bytes. There are 2 varia=
nts
> + * of this function:
> + *
> + * 1. Use the standard bpf_jit_dump() which is meant only for JITed code.
> + * 2. Use the dump_bytes() to match its "vm_dump()" instance.
> + */
> +static void jit_dump(const struct jit_context *ctx)
> +{
> +#ifdef ARC_BPF_JIT_DEBUG
> +	u8 header[8];
> +#endif
> +	const int pass =3D ctx->is_extra_pass ? 2 : 1;
> +
> +	if (bpf_jit_enable <=3D 1 || !ctx->prog->jited)
> +		return;
> +
> +#ifdef ARC_BPF_JIT_DEBUG
> +	scnprintf(header, sizeof(header), "JIT:%d", pass);
> +	dump_bytes(ctx->jit.buf, ctx->jit.len, header);
> +	pr_info("\n");
> +#else
> +	bpf_jit_dump(ctx->prog->len, ctx->jit.len, pass, ctx->jit.buf);
> +#endif
> +}
> +
> +/* Initialise the context so there's no garbage. */
> +static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *prog)
> +{
> +	ctx->orig_prog =3D prog;
> +
> +	/* If constant blinding was requested but failed, scram. */
> +	ctx->prog =3D bpf_jit_blind_constants(prog);
> +	if (IS_ERR(ctx->prog))
> +		return PTR_ERR(ctx->prog);
> +	ctx->blinded =3D (ctx->prog =3D=3D ctx->orig_prog ? false : true);
> +
> +	ctx->jit.buf            =3D NULL;
> +	ctx->jit.len            =3D 0;
> +	ctx->jit.index          =3D 0;
> +	ctx->bpf_header         =3D NULL;
> +	ctx->bpf2insn           =3D NULL;
> +	ctx->bpf2insn_valid     =3D false;
> +	ctx->jit_data           =3D NULL;
> +	ctx->arc_regs_clobbered =3D 0;
> +	ctx->save_blink         =3D false;
> +	ctx->frame_size         =3D 0;
> +	ctx->epilogue_offset    =3D 0;
> +	ctx->need_extra_pass    =3D false;
> +	ctx->is_extra_pass	=3D ctx->prog->jited;
> +	ctx->user_bpf_prog	=3D ctx->prog->is_func;
> +	ctx->success            =3D false;

I'd just make sure that ctx is zeroed, and init the non-zero members here.


Bj=C3=B6rn

