Return-Path: <bpf+bounces-53103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FBAA4C939
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE1B17D379
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7C264634;
	Mon,  3 Mar 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dpP3ry4w"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C723024D;
	Mon,  3 Mar 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020929; cv=none; b=KZiZUeMtt0+enw+0G9md+8pEF3wgS99boaqcmzd4eVcN3t33nePj9RssjU700/FJf10rCT5a/q6EJYkYL4jww7/64ZO5o8OTWh4L6qrqMYJwS8scc7NQg7E8/tf4v81P722A6KL7VF6RVNff+RDCVIBLD8WVNRtCkfNZi6L+MrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020929; c=relaxed/simple;
	bh=s8s99X4A9mICenge2Kot4pYIpEf6LooeZfPPPPswBWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBzbBQx0w8K8EZhEbNfwkA3PuC3UoPU4nz4TRHJvMJSLCueZRnsI3EP5lOXTq5YZlimRDXSo7Q4ylbxi3KTTd4hKoczUG/GhIUre7hg1IdKBYZToFaFDkJYivsVUPC8WI6pNo/SuycBbEH3SMcGq49gd/SN2DNmGsoHKHGQZLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dpP3ry4w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=meSp1W4kNHGyd+88qlhZAmQUNLTT11sQ5+3aYaCOj4Q=; b=dpP3ry4wKDt94DgihnFO+YYQXP
	D4M9HLwKMcZ1dh8OJ465lh8hjlZIC4hPnM0yu+Bo48hJ25+geFXfhb2yh1JjsYv2G86e6y8Q9aA08
	EjLGlZwFQIXS8MWxtg4rTznMRQuyEvPa+WNLe2pvD+BteV4xvApnMYQJAC79Lfq83FC8K1mS128bN
	k9Syjw9M9tEsm1AZBCOn/Wwb3KXYOS3EzdY6uhs54+r5jAjfBJfy5gMkcPRofiRiBUAg2x+X/xWLJ
	kVME0QXIFcySMe3OdN/xZXFu4nYKpWhju6aKjV+25lMMlQM+XB+vJn3aeblxRU6/Kea/FDiBN5mio
	eEfj0fJA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp94B-00000004aZY-0HlI;
	Mon, 03 Mar 2025 16:54:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38C6E3006C0; Mon,  3 Mar 2025 17:54:54 +0100 (CET)
Date: Mon, 3 Mar 2025 17:54:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	jolsa@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	mathieu.desnoyers@efficios.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	samitolvanen@google.com, kees@kernel.org, dongml2@chinatelecom.cn,
	akpm@linux-foundation.org, riel@surriel.com, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
Message-ID: <20250303165454.GB11590@noisy.programming.kicks-ass.net>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303132837.498938-2-dongml2@chinatelecom.cn>

On Mon, Mar 03, 2025 at 09:28:34PM +0800, Menglong Dong wrote:
> For now, the layout of cfi and fineibt is hard coded, and the padding is
> fixed on 16 bytes.
> 
> Factor out FINEIBT_INSN_OFFSET and CFI_INSN_OFFSET. CFI_INSN_OFFSET is
> the offset of cfi, which is the same as FUNCTION_ALIGNMENT when
> CALL_PADDING is enabled. And FINEIBT_INSN_OFFSET is the offset where we
> put the fineibt preamble on, which is 16 for now.
> 
> When the FUNCTION_ALIGNMENT is bigger than 16, we place the fineibt
> preamble on the last 16 bytes of the padding for better performance, which
> means the fineibt preamble don't use the space that cfi uses.
> 
> The FINEIBT_INSN_OFFSET is not used in fineibt_caller_start and
> fineibt_paranoid_start, as it is always "0x10". Note that we need to
> update the offset in fineibt_caller_start and fineibt_paranoid_start if
> FINEIBT_INSN_OFFSET changes.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

I'm confused as to what exactly you mean.

Preamble will have __cfi symbol and some number of NOPs right before
actual symbol like:

__cfi_foo:
  mov $0x12345678, %reg
  nop
  nop
  nop
  ...
foo:

FineIBT must be at foo-16, has nothing to do with performance. This 16
can also be spelled: fineibt_preamble_size.

The total size of the preamble is FUNCTION_PADDING_BYTES + CFI_CLANG*5.

If you increase FUNCTION_PADDING_BYTES by another 5, which is what you
want I think, then we'll have total preamble of 21 bytes; 5 bytes kCFI,
16 bytes nop.

Then kCFI expects hash to be at -20, while FineIBT must be at -16.

This then means there is no unambiguous hole for you to stick your
meta-data thing (whatever that is).

There are two options: make meta data location depend on cfi_mode, or
have __apply_fineibt() rewrite kCFI to also be at -16, so that you can
have -21 for your 5 bytes.

I think I prefer latter.

In any case, I don't think we need *_INSN_OFFSET. At most we need
PREAMBLE_SIZE.

Hmm?

