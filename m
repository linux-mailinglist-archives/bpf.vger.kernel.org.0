Return-Path: <bpf+bounces-39556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E4974772
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 02:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458D61C2535D
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB77C148;
	Wed, 11 Sep 2024 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDHN0VU1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890DBA20;
	Wed, 11 Sep 2024 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015195; cv=none; b=Z2bhubXmCdJAYQb/W2sGZSztbJokjD3HCaO51ABhQLKJCsAw5mX5OaJGuzc70VEe5x8PqwHOCnmhIvWfX+8xMxUixiJNi4jqhuKOmubtt4mExFWQPTjXxUUhjaQGdY0/4RytgLuFQiWn1YmBay3vLHErkF8aXbLI3nh3BloLIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015195; c=relaxed/simple;
	bh=/fBDpPiu3lGHYDzGSOLr2nCGAJ0lbLinn72VPH8yw4U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AXik5JbeSqvMpmjqx6jhHTY1EbGcayrmBWspiC3JQDtcpl/5oBhqgRwXMRJo3yvyWtYdVMqucYGkBoseLVK2nI4sjSEdL2DoWHi5+oKEILMLAfbAeOcrlkn/QFtQuulPRk3b++eHs1PyorX9v9u6dYk6+/dcSJC0/RBWAKxTE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDHN0VU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBE4C4CEC3;
	Wed, 11 Sep 2024 00:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726015195;
	bh=/fBDpPiu3lGHYDzGSOLr2nCGAJ0lbLinn72VPH8yw4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NDHN0VU14VplbHJbatz0aF9iTnC0LJne7hqG/Os83afPXIv/xvjD7G7fqIy31pT1E
	 MGq9Fyilb5XGLAeM+AlG8wjuD9s6KfmLwnqh3qhkGR5h7boQnt3+CeERiIDjwwDuDB
	 1ODWrwjxGxTpW8vAqKphnEuYaAXOGl98YZJ0OTkeuMPLutqojv/ZE7bldUXbefcASD
	 3yeaYSu41uhSTnngfAY6DNzoRZyQiGy1J8phr+B5Ld2b9F15vHcD3+yCzZ5tls1m/m
	 2hhqSjmSG9YMgkMbya6FmdFaCjt4dBXUEEQX/W/mTD0bP3vvzeu5mnao0XFI0+lE4y
	 Q4bd/jxlBxnIw==
Date: Wed, 11 Sep 2024 09:39:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Florent Revest
 <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-Id: <20240911093949.40e65804d0e517a1fa1cba11@kernel.org>
In-Reply-To: <CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
	<20240910145431.20e9d2e5@gandalf.local.home>
	<CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 13:29:57 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> You are probably talking about [0]. But I was asking about [1], i.e.,
> adding HAVE_RETHOOK support to ARM64. Despite all your emotions above,
> can I still get a meaningful answer as for why that wasn't landed and
> what prevents it from landing right now before Masami's 20-patch
> series lands?

As I replied to your last email, Mark discovered that [1] is incorrect.
 From the bpf perspective, it may be fine that struct pt_regs is missing
 some architecture-specific registers, but from an API perspective,
 it is a problem.

Actually kretprobes on arm64 still does not do it correctly, but I also
know most of users does not care. So currently I keep it as it is. But
after fixing this issue on fprobe. I would like to update kretprobe so
that it will use sw-breakpoint to handle it. It will increase the overhead
of kretprobe, but it should be replaced by fprobe at that moment.

Thank you,

> 
>   [0] https://lore.kernel.org/linux-trace-kernel/172398527264.293426.2050093948411376857.stgit@devnote2/
>   [1] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/
> 
> >
> > Again, just letting you know.
> >
> > -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

