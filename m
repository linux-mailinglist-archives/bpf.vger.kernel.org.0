Return-Path: <bpf+bounces-22783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F53869EA4
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 19:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52041C24069
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A3146908;
	Tue, 27 Feb 2024 18:10:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFB1E871;
	Tue, 27 Feb 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057416; cv=none; b=nN8UtlW48r3s9sotOS7On70K5pjUHeRySr9QDGKbw7zvwj4tUSvb7uEj89E/+pMPQcxVB67Ow28dG9K9b1elPLV063P8IkutMM1hV2qZy4Nuw7D3cWlbOwmVQuaRzONDpS9gPskGL6ZxzmMD3Vd49diqm1Oe+Qw0eAsdFeQy5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057416; c=relaxed/simple;
	bh=oxoovjm8DFlq/qUX1bqpmY8P2EMYW/EIAHGa3CR5EeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA6/IngZtRkucwVObBTe3hYacFORbG9Fdm9MZa0+Yf3edyY82mFDJSy6ffz8V0xvSx0sP5PVU0+6kS0LQ6Wkxy/4GXC3zH16bh1pYWq7vVmcAuo8cnUWL1lu2ItU3ljdmzTSU6FalmGDdIugHE8fF74czTjofZSwzPp7cNoVHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74751C433C7;
	Tue, 27 Feb 2024 18:10:12 +0000 (UTC)
Date: Tue, 27 Feb 2024 18:10:10 +0000
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
Message-ID: <Zd4lggegV2MeD3jP@arm.com>
References: <20240201125225.72796-1-puranjay12@gmail.com>
 <20240201125225.72796-2-puranjay12@gmail.com>
 <ZdegTX9x2ye-7xIt@arm.com>
 <CAADnVQLGGTshMiQAWwJ9UzrEVDR4Z8yk+ki9pUqKLgcH0DRAjA@mail.gmail.com>
 <Zd4jlPW2H7EvdlfM@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd4jlPW2H7EvdlfM@arm.com>

On Tue, Feb 27, 2024 at 06:01:56PM +0000, Catalin Marinas wrote:
> On Thu, Feb 22, 2024 at 06:04:35PM -0800, Alexei Starovoitov wrote:
> > On Thu, Feb 22, 2024 at 11:28 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > On Thu, Feb 01, 2024 at 12:52:24PM +0000, Puranjay Mohan wrote:
> > > > This will be used by bpf_throw() to unwind till the program marked as
> > > > exception boundary and run the callback with the stack of the main
> > > > program.
> > > >
> > > > This is required for supporting BPF exceptions on ARM64.
> > > >
> > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > > ---
> > > >  arch/arm64/kernel/stacktrace.c | 26 ++++++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> [...]
> > > I guess you want this to be merged via the bpf tree?
> > 
> > We typically take bpf jit patches through bpf-next, since
> > we do cross arch jits refactoring from time to time,
> > but nothing like this is pending for this merge window,
> > so if you want it to go through arm64 tree that's fine with us.
> 
> I don't have any preference. I can add it on top of the other arm64
> patches if there are no dependencies on it from your side.

Actually, it depends on patches in bpf-next AFAICT (it doesn't apply
cleanly on top of vanilla -rc3). So please take the patches through the
bpf tree.

Thanks.

-- 
Catalin

