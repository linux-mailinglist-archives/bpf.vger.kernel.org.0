Return-Path: <bpf+bounces-43941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097BD9BBE44
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091351C2145B
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491831CC896;
	Mon,  4 Nov 2024 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BEQ8Mrm5"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C523A6
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750050; cv=none; b=Yc1zuzyPMomav0hbVbbRqvi/CthVYRGJqiEYP69EH7mApKqzWjhBT72b5L+lnvWiQxKKc8MmQzaHDgbZsap9Y99B6zhoRKO1KtcYSd6b0xL6ZSrjD31r1SZa3C9RmUNYtj+C4QDYiCNR6OebnItkv5XI4csq0MBH5PMI+JaxddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750050; c=relaxed/simple;
	bh=kx3hFg6S0sqA5F/gDH9J78CeNl3gEUqTgf7anptx1Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzG+QRO9BWy/g5ActiCQF395icInvoX1JqF+hkV+Rr57hVdm9aPyEdhrBeszFJA+wF6/LRBU4vw6hAuFnoQwpj1qmmvrq40eThLm2P8QAatnKsf8Y6GPH1cBWJebnxNVr3Dfd89W0jjpx3H+2X9r7MTNtyE/SBDM0sRguCIFomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BEQ8Mrm5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/+8h5DgmD2ymtUowHBlB4pjFI1kGj3xwuEB+8ur9QWQ=; b=BEQ8Mrm5+8uxtc6d1sU68kpb+h
	MSU1bbId3W+zcT7SMZr7s6tqcotTbwTTy+/2/op6zK4LFj03Gl60LG97IOa69eIW/gcuQZbuycxKt
	tIzf2k9By/Rcd2GKH+1ELaufsg/wuxnE0QUd3rrcizZxpHfke2m4ihWv9GRQaZvwzOC2JDI/qrgeL
	dzFoKQn1bm9w5R0OhOMdZU1uw7p3zOjUme8bjPQ2yRnXG4ZmEPtexWBkDBulS2pESFjx79ZPnSEtE
	cPB67WcK3/yMFEH5Lrq71slqsiOS8EF1kLxo8PTTNhoYcq74kMW3lz4YFvSdpElCJyNWDcz+1TSQT
	RfIQrTbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8399-0000000BYUc-1Nt8;
	Mon, 04 Nov 2024 19:53:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4A83830042E; Mon,  4 Nov 2024 20:53:54 +0100 (CET)
Date: Mon, 4 Nov 2024 20:53:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Rishabh Iyer <rishabh.iyer@berkeley.edu>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>, x86@kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 2/2] bpf, x86: Skip bounds checking for
 PROBE_MEM with SMAP
Message-ID: <20241104195354.GA31782@noisy.programming.kicks-ass.net>
References: <20241103193512.4076710-1-memxor@gmail.com>
 <20241103193512.4076710-3-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103193512.4076710-3-memxor@gmail.com>

On Sun, Nov 03, 2024 at 11:35:12AM -0800, Kumar Kartikeya Dwivedi wrote:
>  arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..7e3bd589efc3 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1954,8 +1954,8 @@ st:			if (is_imm8(insn->off))
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>  			insn_off = insn->off;
>  
> -			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
> -			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
> +			if ((BPF_MODE(insn->code) == BPF_PROBE_MEM ||
> +			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX) && !cpu_feature_enabled(X86_FEATURE_SMAP)) {
>  				/* Conservatively check that src_reg + insn->off is a kernel address:
>  				 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
>  				 *   and

Well, I can see why you'd want to get rid of that, that's quite
dreadful code you generate there.

Can't you do something like:

  lea off(%src), %r10
  mov %r10, %r11
  inc %r10
  sar $63, %r11
  and %r11, %r10
  dec %r10

  mov (%r10), %rax

I realize that's not exactly pretty either, but no jumps. Not sure
this'll help much if anything with the TDX thing though.

