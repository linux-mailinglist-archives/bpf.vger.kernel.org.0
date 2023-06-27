Return-Path: <bpf+bounces-3580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607F7401DF
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 19:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9541C20B1F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840E13086;
	Tue, 27 Jun 2023 17:06:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283013064
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7258DC433C8;
	Tue, 27 Jun 2023 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687885571;
	bh=BwR1nJT+erjmMBlmDftI263VFW/Cra8sC5xlQFXfiUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2vR5AixuMi51aMwfwi+SCwf0V46abwsZ3EvxHE8CPaVxivFrFbgFBe2yLvNic0ag
	 YvIzt6yVhq+o02nNLwqfJ8odu03rOZxRal9z9mwEfvQkPZjka9U13VeYqvKR8aFq1A
	 Nn7kIen/aoKpRKQagrbF9G7hKcC76XcYDLCPc1C2we1U6CLFtAN1WuZBl4FaBWEcWH
	 +E7PQBRiajpmpbJzYRgsnQQZyzl1lEZTs5SRHt9QwuvvNOOaCPNQTdFT9DJ1sJmlti
	 e7fjol0YtOOjUwrqpu2bUw8U0/ibGotyirWKtDUH7CdcBw0mwK4tzLBdUSMEeR/ymS
	 kt7HNYASz/h7Q==
Date: Wed, 28 Jun 2023 02:06:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 "rostedt@goodmis.org >> Steven Rostedt" <rostedt@goodmis.org>, Jiri Olsa
 <olsajiri@gmail.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: Please help, I want kprobe.multi support on arm64, but regs is
 replaced by args
Message-Id: <20230628020606.b67d161c4d4f7e41bd466cd2@kernel.org>
In-Reply-To: <0118f3b5-d13a-57f0-7a7f-41f59666d387@linux.dev>
References: <0118f3b5-d13a-57f0-7a7f-41f59666d387@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jackie,

That is actiall what I'm working on now :)

Here is my previous implementation (but not applicable because now we need to
remove kretprobe trampoline with it.)
https://lore.kernel.org/all/164735287344.1084943.9787335632585653418.stgit@devnote2/

Let me explain my idea. I would like to replace the kretprobe with fprobe
exit handler so that we can intgrate the function return hook with fgraph tracer.
Currently fprobe entry/exit handler uses pt_regs, but I will replace it with
ftrace_regs. And this means rethook has to work with ftrace_regs and it can not
support kretprobes anymore on some arch (HAVE_RETHOOK but
 !HAVE_DYNAMIC_FTRACE_WITH_REGS).

There are many good reasons, like;

- On some arch (e.g. arm64) can not emulate full pt_regs.
- Saving full register on function entry/exit is not efficient.
- Enabling both fgraph tracer and rethook are redundant.

This requires some changes on kprobe users like BPF and SystemTap, so I need to
talk with them about

- Moving onto the fprobe to trace function entry/exit.
- Using ftrace_regs API to access function argument and return value.

Anyway, I'll add CONFIG_DYNAMIC_FTRACE_WITH_REGS dependency to them until
in-kernel stuffs are ready. It ensures ftrace_regs can be converted to
pt_regs.

I also introduced fprobe events, so I will send a series of patches how to do
that (fprobe entry side has been done, working on rethook side).

Thank you,


On Sun, 25 Jun 2023 16:27:44 +0800
Jackie Liu <liu.yun@linux.dev> wrote:

> Hi, Mark Rutland and other developers.
> 
> I am trying to implement the rethook of the arm64 platform, referring to
> the code of other architectures, it can already run normally on the v6.1
> branch, but after commit 26299b3f6ba2 ("ftrace: arm64: move from REGS to
> ARGS"), regs is no longer supported, resulting in CONFIG_FPROBE is also
> not supported (although RETHOOK is implemented). I try to revert the
> patch, and kprobe.multi can be run correctly. Now, what should I do?
> Should I roll back this patch or find a way to run fprobe without regs?
> 
> Any help is welcome.
> 
> --
> Jackie Liu


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

