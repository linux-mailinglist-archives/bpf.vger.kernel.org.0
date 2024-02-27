Return-Path: <bpf+bounces-22782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7A869E81
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DA71C233DA
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D471419B3;
	Tue, 27 Feb 2024 18:02:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06114E1DC;
	Tue, 27 Feb 2024 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056922; cv=none; b=jkJd6KtwUkgGKtRwXdd+Gh7UH6NzVAi+x2TvdggDmaYP9ir+7Wt9c6629poPxdHJyDyXPjJxufn1dz0Tqc3utU7xQ4ETJrfAF8w8FdQY6eyIjg0ZDroHs/eOVP6Tgm1CG1w3gHJHqPLwcmoQQXdo+MPlrfuqRN09g2pX3z+32zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056922; c=relaxed/simple;
	bh=gUaJw7navpSvwR7rIR3frdEMxjbCPmRD2IOryPdpKMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX2TFqbtpuaAm7qnMF1c9Ia85T+N9xlVS/d3JXSKR6b6MMSHs2baTlHLykwDotsoqT9ctX6q0mVGQXQ4EbhXE9aPaUOzVTqGkfLqT6yC3Db+uaTgW3+O1rhcQTvOitxkch0kK/oNJCnBDaC/JoL0QlnAAEmBtdkJSbGbpWKqzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2202BC433F1;
	Tue, 27 Feb 2024 18:01:58 +0000 (UTC)
Date: Tue, 27 Feb 2024 18:01:56 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>, Will Deacon <will@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] arm64: stacktrace: Implement
 arch_bpf_stack_walk() for the BPF JIT
Message-ID: <Zd4jlPW2H7EvdlfM@arm.com>
References: <20240201125225.72796-1-puranjay12@gmail.com>
 <20240201125225.72796-2-puranjay12@gmail.com>
 <ZdegTX9x2ye-7xIt@arm.com>
 <CAADnVQLGGTshMiQAWwJ9UzrEVDR4Z8yk+ki9pUqKLgcH0DRAjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLGGTshMiQAWwJ9UzrEVDR4Z8yk+ki9pUqKLgcH0DRAjA@mail.gmail.com>

On Thu, Feb 22, 2024 at 06:04:35PM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 22, 2024 at 11:28 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Feb 01, 2024 at 12:52:24PM +0000, Puranjay Mohan wrote:
> > > This will be used by bpf_throw() to unwind till the program marked as
> > > exception boundary and run the callback with the stack of the main
> > > program.
> > >
> > > This is required for supporting BPF exceptions on ARM64.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > ---
> > >  arch/arm64/kernel/stacktrace.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
[...]
> > I guess you want this to be merged via the bpf tree?
> 
> We typically take bpf jit patches through bpf-next, since
> we do cross arch jits refactoring from time to time,
> but nothing like this is pending for this merge window,
> so if you want it to go through arm64 tree that's fine with us.

I don't have any preference. I can add it on top of the other arm64
patches if there are no dependencies on it from your side.

-- 
Catalin

