Return-Path: <bpf+bounces-5166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53484757E88
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8526C1C20CE6
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28182D539;
	Tue, 18 Jul 2023 13:56:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6647C8FA
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 13:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74FCC433C7;
	Tue, 18 Jul 2023 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689688571;
	bh=nnPZWvHoY77kG+SlMvaG8lbC6DoL7efDVhXqdZCs0cM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FaCU7LUNmr/X9YbW9RKlcMSPENlNZ2aELn1oB4f8Y561tZHX90uV5O+hqrXC8U3uM
	 PlOX9wh1S6VfH8Zn3eDDfVSPPeOl7GEtZv22cpSH3TA7Dt6qOasGbtjOJmzwSUekvH
	 ceDAYVf6T11lnyqChkIGSforIJ6lTDBIoQB9sPRzSmtDJyZ1vwDhoNFBybF6XO6A7C
	 NN+NLNgcwVD56081TuoG9F3We5veJ1UrqRhfoNRXBD7+7EebQqcr5IwhDIsxZ0uXHX
	 Q0lkneQl6jC0HZR3+ZrcBmBLLN0L5QCwDjmnpYH14xkJoFBoQ/foxTznXusKc3YryY
	 DsM6N9tkz/vgw==
Date: Tue, 18 Jul 2023 22:56:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230718225606.926222723cdd8c2c37294e41@kernel.org>
In-Reply-To: <20230718194431.5653b1e89841e6abd9742ede@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
	<168960741686.34107.6330273416064011062.stgit@devnote2>
	<CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
	<20230718194431.5653b1e89841e6abd9742ede@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 19:44:31 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > >  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> > >                                                    bool tracepoint)
> > >  {
> > > +       struct btf *btf = traceprobe_get_btf();
> > 
> > I found that traceprobe_get_btf() only returns the vmlinux's btf. But
> > if the function is
> > defined in a kernel module, we should get the module's btf.
> > 
> 
> Good catch! That should be a separated fix (or improvement?)
> I think it's better to use btf_get() and btf_put(), and pass btf via
> traceprobe_parse_context.

Hmm, it seems that there is no exposed API to get the module's btf.
Should I use btf_idr and btf_idr_lock directly to find the corresponding
btf? If there isn't yet, I will add it too.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

