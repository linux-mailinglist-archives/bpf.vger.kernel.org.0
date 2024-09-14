Return-Path: <bpf+bounces-39880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C60978C83
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 03:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD351F25E1B
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0819450;
	Sat, 14 Sep 2024 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GezlXgcE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720289443
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726279123; cv=none; b=JVS3d7G5j7i8HAKhVvrPOWE3IDpbxGieSNKtnReQJblGpdJ59NLttU5/cTumtS/mnvNsUtzIMLkFAYadHRJ8R70NcHPwQSaQIvzm/FcA3Tnzpp55NT3AurMkx4vjGQNyXwe2M7Kp6y9gwZ+RxXSe2Ycg7huV2HyvuqJ7anNN9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726279123; c=relaxed/simple;
	bh=Svd64MpXLry0HiW64qzIucKhoXuIjv7BDGV9LzUZ2Bs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j8xcqyV8I7I2UhSwwfD7Wdx7iHyV4+1c0t5DVFhbsoYPIpwAaYtARMBJRjrE5msajNe93cbTllAeQFgapVGrzAacx1kQdFr59IDP3YzmWHz4QeETJo7yiRl6X0h4WKnF/5L/eMmzsn2oCetFpKLAoHlrF8viat7+mNqAl8QKpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GezlXgcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1B8C4CEC0;
	Sat, 14 Sep 2024 01:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726279123;
	bh=Svd64MpXLry0HiW64qzIucKhoXuIjv7BDGV9LzUZ2Bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GezlXgcE2QeTCbEoELcFcJLxuj+nk8k2JKAZSBSKqyStv1awn8jzyePIzYqoqaF+r
	 Zsqho6UbmVr+zbTpDWCHI52ZaaCDMPVUmjmZtjeSiJcbmfofmxYdPxD/BV4zc29fUU
	 zjQ75faH7RZEcg5EohfABbCdGmFC9j/WMixlNmxJtkVwm2+jMaJhLUeMD8a+K/ZKaW
	 vlSmXD1BCQFZEhJnnJA7GJpmdYavFVLtWdB9+zzz4A46S65N1hN3dADlQFD6OHoWPA
	 SLdkxo9Lhi4rFISjztwvSoW8PohAw797I/so8HceRrOZp1qf6tiUW5koeEzEiChMSw
	 MKFsM3alv+IjA==
Date: Sat, 14 Sep 2024 10:58:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: kernel-ci@meta.com, bot+bpf-ci@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>, Jiri
 Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240914105838.73130273fdba9b2abad91201@kernel.org>
In-Reply-To: <CAEf4BzbJCnmHyb7X+RNqJGdcq0k8hM-MxjC5Lhtq+APgvdB2XQ@mail.gmail.com>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
	<CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
	<20240913085402.9e5b2c506a8973b099679d04@kernel.org>
	<CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
	<20240913175935.bb0892ab1e6052efc12c6423@kernel.org>
	<CAEf4BzbJCnmHyb7X+RNqJGdcq0k8hM-MxjC5Lhtq+APgvdB2XQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 14:16:47 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> >
> >  - Change bpf_kprobe_multi_addrs_cmp() to call
> >    ftrace_call_adjust() before comparing. This may take a
> >    cost but find actual entry address.
> 
> too expensive, unnecessary runtime overhead

Indeed.

> >
> >  - (Cached method) when making link->addrs, make a link->adj_addrs
> >    array too, where adj_addrs[i] == ftrace_call_adjust(addrs[i]).
> >
> > Let me try the 3rd one. It may consume more memory but the
> > fastest solution.
> 
> I like the third one as well, but I'm not following why we'd need more memory.
> 
> We can store adjusted addresses in existing link->addrs, and we'll
> need to adjust them to originals (potentially expensively) only in
> bpf_kprobe_multi_link_fill_link_info(). But that's not a hot path, so
> it doesn't matter.

OK, that works well, but let me check it has any side effects.

BTW, I worry about what the user expects for `bpf_get_func_ip()`.

 * u64 bpf_get_func_ip(void *ctx)
 * 	Description
 * 		Get address of the traced function (for tracing and kprobe programs).
 *
 * 		When called for kprobe program attached as uprobe it returns
 * 		probe address for both entry and return uprobe.
 *
 * 	Return
 * 		Address of the traced function for kprobe.
 * 		0 for kprobes placed within the function (not at the entry).
 * 		Address of the probe for uprobe and return uprobe.

This seems expecting to get the function address, not ftrace entry
address. If user expects it returns actual function entry address,
we need to change `get_entry_ip()`(*) as the patch I sent.

If they can accept the address a bit shifted from the entry address,
I think we can change link->addrs.

Jiri, and other BPF users, what you expect and what you want to
have? (what the reason to use this API?)

Thank you,

(*) bpf_get_func_ip() seems to read `run_ctx->entry_ip` which is
set by `get_entry_ip(fentry_ip)`.

> 
> >
> > Thank you,
> >
> > >
> > > which is then checked as
> > >
> > > if ((const void *) addr == &bpf_testmod_fentry_test3)
> > >
> > >
> > > With your patches this doesn't match anymore.
> >
> > It actually enables the fprobe on those architectures, so
> > without my series, those test should be skipped.
> 
> Ok, cool, still, let's fix the issue.
> 
> >
> > Thank you,
> >
> > >
> > >
> > > Hopefully the above gives you some pointers, let me know if you run
> > > into any problems.
> > >
> > > >
> > > > Thank you,
> > > >
> > > > >
> > > > > >
> > > > > > Please note: this email is coming from an unmonitored mailbox. If you have
> > > > > > questions or feedback, please reach out to the Meta Kernel CI team at
> > > > > > kernel-ci@meta.com.
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

