Return-Path: <bpf+bounces-72680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A7C18336
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 04:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2DC404D6A
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA072ECD21;
	Wed, 29 Oct 2025 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBRTXfx6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C462D8388;
	Wed, 29 Oct 2025 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761709176; cv=none; b=PzrcTXE29VIpECrZAVym27RqQzJjOvLHzGt4S+lhnhUgmMJKrTHmBoGnHSN3finp2B1tlaUQz7WYVVJ2nFfQoiylofZB791Q4hNAipwMMv+amqd/f/rG0cscVLfLYZek2VW07ppHlAxZCOC31gJxLgS33TFgnt5vyNo3FpPCV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761709176; c=relaxed/simple;
	bh=u/WGFS+n82LAnmVIAvKvyQJNFRrZloP82rdFToBFNHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmq/H5FquBQY+LmQv0lmuZ9yvj7+qmdzFsqG1DstZwNqQJvP6ICFc0tJ5Y8YItOz8DnXcMNnSA8MuXfvABzHDfbWcoid9uG3rihl7lh0eQiqtpP07hVYGLZRxcg2Qsh0RU7Y0cjlioXsKb51jwDb1z1g9Ua/DIDEEPjkFag8pJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBRTXfx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D728BC4CEFB;
	Wed, 29 Oct 2025 03:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761709175;
	bh=u/WGFS+n82LAnmVIAvKvyQJNFRrZloP82rdFToBFNHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBRTXfx6Y526CXCYidiN98F8N6+fHzSgaA1btCQgyPLH9XFyBBzfD9BvCevJHT0HN
	 ylNf5qYe8HnJYPBt/wR1H/KuTC/ZLuCC8GdNV97TlgEEyphiREtAEJ+KR7vF/T6AoG
	 pQvZZ8GiGFvzMHJQ+uSpZgZUi9PEaS4JSKDiNlUXulW7vZhY1/KDU2U0rFazuVyImg
	 5ygj58lL0TAdbA5o4G77F/y0yxjnejHJqSQkH4hp/c+qplcfHUXdR1cN3wtHbDnxxz
	 1xh1jNAxmifL/htjVF7UX9aw8o9y39+KGY5FFCIVZmjeYsB75LZXMbdxuXruuXbLth
	 zKGFNxcMZ7z3g==
Date: Tue, 28 Oct 2025 20:39:33 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bot+bpf-ci@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org, 
	song@kernel.org, peterz@infradead.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com, songliubraving@fb.com, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <xnx66p7w3qstst4ixj356dnzexrpsjy52tfwthp5kytv5yagcf@4ngtq5rrgqzj>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
 <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>
 <aP_0eh7TH2f_ykhz@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aP_0eh7TH2f_ykhz@krava>

On Mon, Oct 27, 2025 at 11:38:50PM +0100, Jiri Olsa wrote:
> On Mon, Oct 27, 2025 at 01:19:52PM -0700, Josh Poimboeuf wrote:
> > On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > > Does this revert re-introduce the BPF selftest failure that was fixed in
> > > 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> > > still exists in the kernel tree.
> > 
> > I have the same question.  And note there may be subtle differences
> > between the frame pointer and ORC unwinders.  The testcase would need to
> > pass for both.
> 
> as I wrote in the other email that test does not check ips directly,
> it just compare stacks taken from bpf_get_stackid and bpf_get_stack
> helpers.. so it passes for both orc and frame pointer unwinder

Ok.  So the original fix wasn't actually a fix at all?  It would be good
to understand that and mention it in the commit log.  Otherwise it's not
clear why it's ok to revert a fix with no real explanation.

-- 
Josh

