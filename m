Return-Path: <bpf+bounces-78292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DD3D08631
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 11:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F6E3053BE0
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90275333737;
	Fri,  9 Jan 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBTiOfz2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F623C8A0;
	Fri,  9 Jan 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952833; cv=none; b=Ot+FK5tP/zSjA8hfC+u55phYltwZWnd9Lt6tFe90ctustg2LNmC3Lr2ndkLLQ33VpqOG0RTwgu8QoVmXiyslRdb1jqeb+xZ/5c2OzAEjzy8fGHX22MT5vCk0r164OibzrTNQGKgkGz8cG155RASpM1doN2SwpnPKWS8Xn2mGQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952833; c=relaxed/simple;
	bh=KjC61mIOqODHcylutLdggLP0FRktDFpqjmw1rF/3wLQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rHbYPrVgCRNe186PzmeAWjuNrobZHiCW2Z/L7jILZsV2DGSUikYf7dc3NEwagGoCQI1Epcv4T/vucLRatyWWPUHozvbmocWfGPHW7OUa8SNnSn9gDAYF8UueuqBkLewO9Juz5s99+bta99mFew90S+9PCsDIZuFH0GMyEPJncxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBTiOfz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6C6C4CEF1;
	Fri,  9 Jan 2026 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767952832;
	bh=KjC61mIOqODHcylutLdggLP0FRktDFpqjmw1rF/3wLQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cBTiOfz2nKGJ1BiFzFsVSwshzZVGKSQpV0SPoRg78s5JoHxLCetExjJrud9BiaZ6y
	 fZ8BOi8YqreEKSXKXHs4x6c3VPu8p6xMZyCijHidoH1IWzhlELF/w1p2fnMu3TskW5
	 gweOnNcHnqaUddxYgc2nn+BS4JDIu75TorsiR/tN/fzpMOjr+HcBk8QTdLz1Wc6xex
	 Sssd/VJayyIymb5tT8C/e++XBGTqPXtJejxlMf9LdL5JEn9mgQudffkssLmu1oS/7D
	 PodrG/THK7RMBrVe7qVdxH+5ORzoyA0gsoODve4+DorCRETDpWHbfg1KD602c1utnD
	 29AD3ffs4yo3A==
Content-Type: multipart/mixed; boundary="===============8986777221254853529=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c0412b685d29327c8879e4b8a7cbebbe2398ac0d3a7d32284d69e1b9f8048e2@mail.kernel.org>
In-Reply-To: <20260109093454.389295-1-jolsa@kernel.org>
References: <20260109093454.389295-1-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after bpf_prog_run
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,mhiramat@kernel.org,rostedt@goodmis.org,will@kernel.org
Cc: mahe.tardy@gmail.com,peterz@infradead.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,x86@kernel.org,yhs@fb.com,songliubraving@fb.com,andrii@kernel.org,mark.rutland@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  9 Jan 2026 10:00:32 +0000 (UTC)

--===============8986777221254853529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
> index 15627ceea9bc..f9a7c009cdae 100644
> --- a/include/linux/ftrace_regs.h
> +++ b/include/linux/ftrace_regs.h
> @@ -33,6 +33,31 @@ struct ftrace_regs;

[ ... ]

> +#else
> +
> +/*
> + * ftrace_partial_regs_update - update the original ftrace_regs from regs
> + * @fregs: The ftrace_regs to update from @regs
> + * @regs: The partial regs from ftrace_partial_regs() that was updated

[ ... ]

> + */
> +static __always_inline void
> +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
> +	ftrace_regs_set_return_value(fregs, regs_return_value(regs));
                                    ^^^^^

Should the fregs parameter be non-const here? On architectures with
HAVE_ARCH_FTRACE_REGS (arm64, riscv), the setter functions expect a
non-const pointer:

  ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, ...)
  ftrace_regs_set_return_value(struct ftrace_regs *fregs, ...)

Passing the const-qualified fregs to these functions discards the const
qualifier, which may cause compiler warnings with -Werror or undefined
behavior since the setters do modify the ftrace_regs structure.

> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20847954035

--===============8986777221254853529==--

