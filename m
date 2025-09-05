Return-Path: <bpf+bounces-67539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6CB451B0
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53A317F38E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810827AC48;
	Fri,  5 Sep 2025 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R4b+CBZZ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F1222594;
	Fri,  5 Sep 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061530; cv=none; b=D2ks8FjOYMp1zzo2MrggSsAJQk3fj/IJoNxOGhyo2N/v2J0wF2QFB8wSYRCfqshm6G0HduqnhE1O7xXkEYZ/NtfOYFqOjigCiS+kmb4dlO0qh6bjaI/kz/NAc4nDV5E4YVhkm/CyFl45/8FtRdPDzmyow7yVdvFgRLuwxoywIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061530; c=relaxed/simple;
	bh=jkLTVGDQyGvp2VGSJ84Q/tzQ9JUtr5HITxCZfTbHdoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APYDPjEUYaTnbU8RCKGXZ71gRzL3pb2dcVcsNRUxmCEyeX0pyuZndg11alMDAG1dBSLlCX4KKDUyfR8hqKEm9yabakOdTtemImzxlGtRZ1N70xDMsGZCm20mMCZ8/pH4MT3w75gTTbNLkxJba6OiCyizOjfAv8S7zIytqOrTLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R4b+CBZZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Om9p5nchqSzMFiVI8uUuwUfI4UaRwvpBhNH4IXNq5Hg=; b=R4b+CBZZ5G4FtZxCDVm1UoPQUo
	v8kkly1N6o0/AOPJPJi0TJ5nUWajzLZOyYrf78kCoF+932Cpdv+JJ4VQxrLdu4TNxPt9IaR0w296U
	nXMQGyQ5T2RtynQVzL2lME7/S8r1r/9ZxHG7APSRZRPYtoZWXyz/da/yg0idzNOzK5enKZkGJsAFh
	TcdGonZKELB7XMFN94kFo6HeXtJ6qwbQG1/J/fSLpHLmOeCpAYMG8MvTfXqDWKksKjIl5e7RDrI9Y
	NQ/a4ybnXuCNqzl+ylEf/k5CX2XyL5RnOwNFfXvKQZKBkw0kF4gfEyOCE7803jHKZEzVcWHY3Rrep
	yYbpn5vQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuRxp-0000000EmVO-3F3o;
	Fri, 05 Sep 2025 08:38:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 552C530034B; Fri, 05 Sep 2025 10:38:33 +0200 (CEST)
Date: Fri, 5 Sep 2025 10:38:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: nop5-optimized USDTs WAS: Re: [PATCHv6 perf/core 09/22]
 uprobes/x86: Add uprobe syscall to speed up uprobe
Message-ID: <20250905083833.GR4068168@noisy.programming.kicks-ass.net>
References: <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava>
 <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
 <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
 <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com>
 <20250904205210.GQ3245006@noisy.programming.kicks-ass.net>
 <CAEf4BzY216jgetzA_TBY7_jSkcw-TGCj64s96ijoi3iAhcyHuw@mail.gmail.com>
 <20250904215617.GR3245006@noisy.programming.kicks-ass.net>
 <20250904215826.GP4068168@noisy.programming.kicks-ass.net>
 <20250905082447.GQ4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905082447.GQ4068168@noisy.programming.kicks-ass.net>

On Fri, Sep 05, 2025 at 10:24:47AM +0200, Peter Zijlstra wrote:
> +bool insn_is_nop(struct insn *insn)
> +{
> +	u8 rex, rex_b = 0, rex_x = 0, rex_r = 0, rex_w = 0;
> +	u8 modrm, modrm_mod, modrm_reg, modrm_rm;
> +	u8 sib = 0, sib_scale, sib_index, sib_base;
> +
> +	if (insn->rex_prefix.nbytes) {
> +		rex = insn->rex_prefix.bytes[0];
> +		rex_w = !!X86_REX_W(rex);
> +		rex_r = !!X86_REX_R(rex);
> +		rex_x = !!X86_REX_X(rex);
> +		rex_b = !!X86_REX_B(rex);
> +	}
> +
> +	if (insn->modrm.nbytes) {
> +		modrm = insn->modrm.bytes[0];
> +		modrm_mod = X86_MODRM_MOD(modrm);
> +		modrm_reg = X86_MODRM_REG(modrm) + 8*rex_r;
> +		modrm_rm  = X86_MODRM_RM(modrm)  + 8*rex_b;
> +	}
> +
> +	if (insn->sib.nbytes) {
> +		sib = insn->sib.bytes[0];
> +		sib_scale = X86_SIB_SCALE(sib);
> +		sib_index = X86_SIB_INDEX(sib) + 8*rex_x;
> +		sib_base  = X86_SIB_BASE(sib)  + 8*rex_b;
> +
> +		modrm_rm = sib_base;
> +	}
> +
> +	switch (insn->opcode.bytes[0]) {
> +	case 0x0f: /* 2nd byte */
> +		break;
> +
> +	case 0x89: /* MOV */
> +		if (modrm_mod != 3) /* register-direct */
> +			return false;
> +
> +		if (insn->x86_64 && !rex_w) /* native size */
> +			return false;
> +
> +		for (int i = 0; i < insn->prefixes.nbytes; i++) {
> +			if (insn->prefixes.bytes[i] == 0x66) /* OSP */
> +				return false;
> +		}
> +
> +		return modrm_reg == modrm_rm; /* MOV %reg, %reg */
> +
> +	case 0x8d: /* LEA */
> +		if (modrm_mod == 0 || modrm_mod == 3) /* register-indirect with disp */
> +			return false;
> +
> +		if (insn->x86_64 && !rex_w) /* native size */
> +			return false;
> +
> +		if (insn->displacement.value != 0)
> +			return false;
> +
> +		if (sib & (sib_scale != 0 || sib_index != 4)) /* (%reg, %eiz, 1) */

Argh, that should obviously be: &&

> +			return false;
> +
> +		for (int i = 0; i < insn->prefixes.nbytes; i++) {
> +			if (insn->prefixes.bytes[i] != 0x3e) /* DS */
> +				return false;
> +		}
> +
> +		return modrm_reg == modrm_rm; /* LEA 0(%reg), %reg */
> +
> +	case 0x90: /* NOP */
> +		for (int i = 0; i < insn->prefixes.nbytes; i++) {
> +			if (insn->prefixes.bytes[i] == 0xf3) /* REP */
> +				return false; /* REP NOP -- PAUSE */
> +		}
> +		return true;
> +
> +	case 0xe9: /* JMP.d32 */
> +	case 0xeb: /* JMP.d8 */
> +		return insn->immediate.value == 0; /* JMP +0 */
> +
> +	default:
> +		return false;
> +	}
> +
> +	switch (insn->opcode.bytes[1]) {
> +	case 0x1f:
> +		return modrm_reg == 0; /* 0f 1f /0 -- NOPL */
> +
> +	default:
> +		return false;
> +	}
> +}

