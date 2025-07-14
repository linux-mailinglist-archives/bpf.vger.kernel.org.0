Return-Path: <bpf+bounces-63260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B655B04983
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C18A1A6723B
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9526C391;
	Mon, 14 Jul 2025 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxDteT73"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8477367;
	Mon, 14 Jul 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528553; cv=none; b=e4qHHbxXAX0jBmwy45BC+LxZQNdg35v2Rgqdw/LzpIFZjnZDHjpNks1tqoI+8eN7LZD6DwnV6rnNJkv2wkcZihPcPFjJK7pdDXcBVuS2nMgeP4ZIVe9d7nq5gicG0CrBqbl+kRN9kXlogDtxDpiZzr0t0L0bIMY4R/iogmYTdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528553; c=relaxed/simple;
	bh=XpKK/8fur+DsYK0P/pQQO4b7538OyzPzNHY1zpMzMn0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCEbCuDAWS/kgCpzSGQEUIPUwEl38Tln2G3F8F2B9doM9y/izvFCz6yDJw/JvVClzj11oxCPj6psRhjnXZ7dcShyHdnx+Mp1vhajXJyyPWsltdzbY/zPSJmqOsJjRgw0NH8WdY3XraUTfzG+blPgpxyPqPlWQKnds00+a2iPWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxDteT73; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad572ba1347so672429066b.1;
        Mon, 14 Jul 2025 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752528550; x=1753133350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59w6vA7RG/nmkBkKiWpJuig22WNDNQNVAhw1Day5ZFo=;
        b=cxDteT736CkWctF/Nt7NR7BYdf5TCjDuVr6821QYcPKzZQ5lC2HWEDUTgERXz21eRS
         0gbq6wT1HKVyi9EjvNNdaRwQ3RLLKqL3ezAm5/oD/eWjwE2d+Vi5X6IkIsQUdE5p7BP+
         Up9EFIHiikS3IgXhYCG1nAkAN/p4wv/ZEQBuJmuR0YNAL7usZVS69izuzdF/FSdO1jwM
         2AZ/pH6xeFrupUkgL9D4wmIvki6cKNvEgsPGG4ItVzXBhUdi/IygLe52Gu2AYVyNHEhe
         D+aS7G9m4ovyPgZ2TvnNH/Yn2UPF8oh2bcyKw60NPwc+Fj7Z1HwyNhVvtGkWLw/Wt624
         WvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752528550; x=1753133350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59w6vA7RG/nmkBkKiWpJuig22WNDNQNVAhw1Day5ZFo=;
        b=BWJsBskmGfCCG43r6hLf88zn/Vspw/tUgBpEnWWrYTYfb7/hkn5XAsLfL+PG/jfCyw
         N8VvVVaCr3IKKomWyXU1/QeXlbF2eYkmjjsPhUtcGOtPMvdjRNvMbRcC9Qf8dZ/7jwq8
         VDvYNgOmdkkgIzNTGBi5N9Gy2ADdhNwzcA55eZEUbkr+gZgGzhJhTtSFGVtID/3o6A4A
         +OPtJRtx71jQGbE1+Y+owm/8bPfPcuIx1Rkj76rWEq/h2kyUmekCCwYg55LDc4OAEp7m
         nyrW7JWaN9adjoUISGeTgv3n/7DjEmDq4Aj0Xxt/E2oPoVJ5R7TLSbjT8bdh8ab+HJDU
         6myQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0EykLjhVNYUWIvdmvH35Nkpw7O5LueoSueW+0XBZwN2dM6yzEp2wrrvIFyV9b8BKtbfd8WeirqHWhiDxv0xmPkwwh@vger.kernel.org, AJvYcCXNRGfNLV49tEQzzclc+CPx3TE7clNocUgpach0VDj1tS1EpHi5cerFFMBDx8FUEvUp+oA=@vger.kernel.org, AJvYcCXkm1mXMSArdPoaJZFA3JhRV9Hz/psib6XLAFHe/ostVF6lx7IF2mWTKUPYBDNTGLCCGW5kHyZSj4UBOuom@vger.kernel.org
X-Gm-Message-State: AOJu0YwhH56dZPNy2VWVmih1PYGdS7Pr8mkUKxaxLG2FpQHzcUmWsK4w
	kts0pBE5WdiLP06JWbBQsPAnsTbKhvWg5XOKyY4hUmu5l5xYc/IcS5ob
X-Gm-Gg: ASbGncsamDdkFsexnj27j2sgmuABCu7nmgNS0B+5zZGGwwe066R7qCyk1pIT3bOkJIO
	OG/RkrB4+A8FPj9rbWHCm3SDuNVupsFy7TSfqzmEPItjxwWdImDc141QkmBNgQu9P9/U6UgTyc5
	RvgzA1U7RYDooqfdlgjt+ZNInAYEWihjcrKtfCVhTUyPx7fXx9wnXevO9p3WSy69PdQ4GENyV8n
	v0BEyVB90K1RVps8vJTiNueXV6lvkfVqdSigksu5ACp1Fr+8ve2O3LMe0qVtxRwwFGYpBI4vsnI
	SezGA0478qRnNyci31ME0z3aBXHB6qpiM2MJOXu2Ps4gIPqZgrqU8E5xjd32R84rheXoomJsY/s
	FfBfTa+A8Jw==
X-Google-Smtp-Source: AGHT+IFcHwm8fKfkY03YJ3q0JcGwj5yNyhLFLW4M3hq86IWPxqo5vep8e+EcuVJghXaAoTmbC5NDAg==
X-Received: by 2002:a17:906:d257:b0:ae6:f670:24f2 with SMTP id a640c23a62f3a-ae9acb08fe2mr322560966b.47.1752528549478;
        Mon, 14 Jul 2025 14:29:09 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264608sm890745166b.109.2025.07.14.14.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:29:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Jul 2025 23:29:07 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aHV2o4SXbnRZdQSu@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-11-jolsa@kernel.org>
 <20250714094824.GQ905792@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714094824.GQ905792@noisy.programming.kicks-ass.net>

On Mon, Jul 14, 2025 at 11:48:24AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 11, 2025 at 10:29:18AM +0200, Jiri Olsa wrote:
> > +enum {
> > +	OPT_PART,
> > +	OPT_INSN,
> > +	UNOPT_INT3,
> > +	UNOPT_PART,
> > +};
> > +
> > +struct write_opcode_ctx {
> > +	unsigned long base;
> > +	int update;
> > +};
> > +
> > +static int is_call_insn(uprobe_opcode_t *insn)
> > +{
> > +	return *insn == CALL_INSN_OPCODE;
> > +}
> > +
> > +static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
> > +		       int nbytes, void *data)
> > +{
> > +	struct write_opcode_ctx *ctx = data;
> > +	uprobe_opcode_t old_opcode[5];
> > +
> > +	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
> > +
> > +	switch (ctx->update) {
> > +	case OPT_PART:
> > +	case OPT_INSN:
> > +		if (is_swbp_insn(&old_opcode[0]))
> > +			return 1;
> > +		break;
> > +	case UNOPT_INT3:
> > +		if (is_call_insn(&old_opcode[0]))
> > +			return 1;
> > +		break;
> > +	case UNOPT_PART:
> > +		if (is_swbp_insn(&old_opcode[0]))
> > +			return 1;
> > +		break;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +static int write_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr,
> > +		      uprobe_opcode_t *insn, int nbytes, void *ctx)
> > +{
> > +	return uprobe_write(auprobe, vma, vaddr, insn, nbytes, verify_insn,
> > +			    true /* is_register */, false /* do_update_ref_ctr */, ctx);
> > +}
> > +
> > +static void relative_call(void *dest, long from, long to)
> > +{
> > +	struct __packed __arch_relative_insn {
> > +		u8 op;
> > +		s32 raddr;
> > +	} *insn;
> > +
> > +	insn = (struct __arch_relative_insn *)dest;
> > +	insn->raddr = (s32)(to - (from + 5));
> > +	insn->op = CALL_INSN_OPCODE;
> > +}
> 
> We already have this in asm/text-patching.h, its called
> __text_gen_insn().
> 
> > +
> > +static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > +			 unsigned long vaddr, unsigned long tramp)
> > +{
> > +	struct write_opcode_ctx ctx = {
> > +		.base = vaddr,
> > +	};
> > +	char call[5];
> > +	int err;
> > +
> > +	relative_call(call, vaddr, tramp);
> 
> 	__text_gen_insn(call, CALL_INSN_OPCODE, vaddr, tramp, CALL_INSN_SIZE);

ok, will use that

> 
> > +
> > +	/*
> > +	 * We are in state where breakpoint (int3) is installed on top of first
> > +	 * byte of the nop5 instruction. We will do following steps to overwrite
> > +	 * this to call instruction:
> > +	 *
> > +	 * - sync cores
> > +	 * - write last 4 bytes of the call instruction
> > +	 * - sync cores
> > +	 * - update the call instruction opcode
> 
> The sanctioned text poke sequence has another sync-core at the end.
> Please also do this.

ok

> 
> > +	 */
> > +
> > +	smp_text_poke_sync_each_cpu();
> > +
> > +	ctx.update = OPT_PART;
> > +	err = write_insn(auprobe, vma, vaddr + 1, call + 1, 4, &ctx);
> > +	if (err)
> > +		return err;
> > +
> > +	smp_text_poke_sync_each_cpu();
> > +
> > +	ctx.update = OPT_INSN;
> > +	return write_insn(auprobe, vma, vaddr, call, 1, &ctx);
> > +}
> > +
> > +static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > +			   unsigned long vaddr)
> > +{
> > +	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
> > +	struct write_opcode_ctx ctx = {
> > +		.base = vaddr,
> > +	};
> > +	int err;
> > +
> > +	/*
> > +	 * We need to overwrite call instruction into nop5 instruction with
> > +	 * breakpoint (int3) installed on top of its first byte. We will:
> > +	 *
> > +	 * - overwrite call opcode with breakpoint (int3)
> > +	 * - sync cores
> > +	 * - write last 4 bytes of the nop5 instruction
> > +	 * - sync cores
> > +	 */
> > +
> > +	ctx.update = UNOPT_INT3;
> > +	err = write_insn(auprobe, vma, vaddr, &int3, 1, &ctx);
> > +	if (err)
> > +		return err;
> > +
> > +	smp_text_poke_sync_each_cpu();
> > +
> > +	ctx.update = UNOPT_PART;
> > +	err = write_insn(auprobe, vma, vaddr + 1, (uprobe_opcode_t *) auprobe->insn + 1, 4, &ctx);
> > +
> > +	smp_text_poke_sync_each_cpu();
> > +	return err;
> > +}
> 
> Please unify these two functions; it makes absolutely no sense to have
> two copies of this logic around.

will try to come up with something

thanks,
jirka

