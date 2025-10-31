Return-Path: <bpf+bounces-73092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3E5C22E3B
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 02:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85AA84EE267
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5924A078;
	Fri, 31 Oct 2025 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Rk8bZw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17882571D8;
	Fri, 31 Oct 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874645; cv=none; b=X9jLIm6WEw1y+NAAnNJTfrVHORwCj+InT6cdTZl1qws/yQ+0qWCc/VfzahWjZUQtCjZAgT0tgWL6Fr5MBJLYZYFUHi/8aBk7mqNgrhLF3MjYXP0D9t9AvI3roN9DaRkI3pmmjWbt/cLUCPwaswP6BSFpn3VRXwO+MLNpdWdTQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874645; c=relaxed/simple;
	bh=U8YTuGdh18iR8KmdYXdav4TUIVWnv9Aoas40Um4CdjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIzVElnHQYE5EBR+e4FALMqrbPP+rUVpIEApVUEBW7X0U34hcwVokQ2v6FTCync8/cXW0LK9XcxCGYrL+kjukVEoIfx3Rg0mhWu/+GD1vX0mtCQqicLI4WSqftmNPDxEBk+ZF4fULw2iSiRAgEWMqyFNPFv2N1n+f5UsUaMZ658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8Rk8bZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149E1C4CEFD;
	Fri, 31 Oct 2025 01:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761874644;
	bh=U8YTuGdh18iR8KmdYXdav4TUIVWnv9Aoas40Um4CdjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8Rk8bZwPIPnM4mrNa5IDzAlTq2nuLPVZjcalnn9lX8z4FxP9+pXNOWhhdOfaO4F7
	 2xn+3trSiwclg0pwceq+tLQ8gjr18MG4RSVErXcj2m+1ALmJv0kbn5/4qDN89FcXOR
	 owNziqo8HlV2DTFXjlCkQt3vWHK2RU8afnfg1MIb3dIjdFq4jjBl08o0I2st5+OQRR
	 xr+K9coBMerx5Ki2fsFGhiaMw8Qorf7pR5UCawsOG7npC9BiSZ7ti8VeFL/Fegamki
	 7+rLN57QfcoHGkdAqCCFv1lKRDTOaapepB1XDkIvgZHKSPZ70DAkV4HYQqMQKp3zn6
	 K95pq7AjyQTbA==
Date: Thu, 30 Oct 2025 18:37:21 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bot+bpf-ci@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org, 
	song@kernel.org, peterz@infradead.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com, songliubraving@fb.com, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <ktinqbxzim73avzfldtpva4ipj65z5iyi4vyzrqjkay4xucqnl@2bd2qvpsai3c>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
 <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>
 <aP_0eh7TH2f_ykhz@krava>
 <xnx66p7w3qstst4ixj356dnzexrpsjy52tfwthp5kytv5yagcf@4ngtq5rrgqzj>
 <aQG_calHM0E7ou67@krava>
 <aQPdE7_yPO8HOwMC@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQPdE7_yPO8HOwMC@krava>

On Thu, Oct 30, 2025 at 10:48:03PM +0100, Jiri Olsa wrote:
> On Wed, Oct 29, 2025 at 08:17:05AM +0100, Jiri Olsa wrote:
> > On Tue, Oct 28, 2025 at 08:39:33PM -0700, Josh Poimboeuf wrote:
> > > On Mon, Oct 27, 2025 at 11:38:50PM +0100, Jiri Olsa wrote:
> > > > On Mon, Oct 27, 2025 at 01:19:52PM -0700, Josh Poimboeuf wrote:
> > > > > On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > > > > > Does this revert re-introduce the BPF selftest failure that was fixed in
> > > > > > 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> > > > > > still exists in the kernel tree.
> > > > > 
> > > > > I have the same question.  And note there may be subtle differences
> > > > > between the frame pointer and ORC unwinders.  The testcase would need to
> > > > > pass for both.
> > > > 
> > > > as I wrote in the other email that test does not check ips directly,
> > > > it just compare stacks taken from bpf_get_stackid and bpf_get_stack
> > > > helpers.. so it passes for both orc and frame pointer unwinder
> > > 
> > > Ok.  So the original fix wasn't actually a fix at all?  It would be good
> > > to understand that and mention it in the commit log.  Otherwise it's not
> > > clear why it's ok to revert a fix with no real explanation.
> > 
> > I think it was a fix when it was pushed 6 years ago, but some
> > unwind change along that time made it redundant, I'll try to
> > find what the change was
> 
> hum I can't tell what changed since v5.2 (kernel version when [1] landed)
> that reverted the behaviour which the [1] commit was fixing
> 
> I did the test for both orc and framepointer unwind with and without the
> fix (revert of [1]) and except for the initial entry it does not seem to
> change the rest of the unwind ... though I'd expect orc unwind to have
> more entries
> 
> please check results below
> 
> any idea? thanks,
> jirka

The "missing" ORC entries are probably fine, they're likely caused by
the compiler generating more tail calls with FP disabled.

-- 
Josh

