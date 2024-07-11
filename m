Return-Path: <bpf+bounces-34609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B23092F2E2
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 01:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFBC1C2162E
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366F1A0711;
	Thu, 11 Jul 2024 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df3jB+S1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC519EEA1;
	Thu, 11 Jul 2024 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742345; cv=none; b=Vu3KK8cVnDBXgCghXI2WJjXu2qAnfXE7dKh8JjYCukvcyfR53KuPcI0WuYcVBOAeDX7pqf1Ba2lSM1UP60WXzVF3yfIHtskwHTQLC6D0UPFCP0UY+D+gc4mHi+GxLyPvXlAwYd/AMVogt8IKcfwh267c0hY0h2ulddDpAHPL/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742345; c=relaxed/simple;
	bh=jI0uNcry8t+1nyBi0zSF4vK3Pl/McEJtidzu+dcB4is=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tmY9WEmmW2Ib22wrwkRSLks8s79TLQ9kDiDB880zb8uPR9lh0gPBX6XodECCmsKNVFEBVrgg/NJlC8bj3VF0rq7d05xFhneHtAdxeim79hUc4F5CMnm2YTIMFFZjVA+NVQmWJUoyLeFbDk74fWmAS+g9m1TNJCm1ZIW2pNfa2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df3jB+S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8086EC32782;
	Thu, 11 Jul 2024 23:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720742345;
	bh=jI0uNcry8t+1nyBi0zSF4vK3Pl/McEJtidzu+dcB4is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Df3jB+S1ZkE+4Pheqzz32FNA4pYESihgna20uAr1IUAHPAQe7aKzIxmJFnZKYOqMc
	 9KWwc88X1q2UXbdbkmSKECtZBnG7rBKTy8Rulvo8qYnXJrkxEGPt5TaE9P+8K711Cu
	 hpRccwzIQlA0DpS0HZfp2ibxmKYRRT8EQOBqKFjKkaYNvEP0PbuFPjm2ggJ9Pa7gzG
	 ATQgsx6NuO17vKB+aD1DEQisrLNPDGbK3DjGYO4FyUdTUpU2hKsisFhCmydjNRsQlb
	 NlNvHSqceuPVpGNhXxXEYhs0CCa/yASwjNlSrgnmkVca5CUL9a0rNdefoCnuTcuICL
	 F56epgP5VhPhQ==
Date: Fri, 12 Jul 2024 08:59:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri
 Olsa <olsajiri@gmail.com>, mingo@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, oleg@redhat.com, clm@meta.com,
 paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-Id: <20240712085900.94069c2fad2c4bc15cd34951@kernel.org>
In-Reply-To: <20240711134703.715e6361@gandalf.local.home>
References: <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
	<20240709090304.GG27299@noisy.programming.kicks-ass.net>
	<Zo0KX1P8L3Yt4Z8j@krava>
	<20240709101634.GJ27299@noisy.programming.kicks-ass.net>
	<20240710071046.e032ee74903065bddba9a814@kernel.org>
	<20240710101003.GV27299@noisy.programming.kicks-ass.net>
	<20240710235616.5a9142faf152572db62d185c@kernel.org>
	<CAEf4BzZGHGxsqNWSBu3B79ZNEM6EruiqSD4vT-O=_RzsBeKP0w@mail.gmail.com>
	<20240711085118.GH4587@noisy.programming.kicks-ass.net>
	<20240712001718.e00caa0a3cb410dc19f169c2@kernel.org>
	<20240711152238.GB3285@noisy.programming.kicks-ass.net>
	<20240711134703.715e6361@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 13:47:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 11 Jul 2024 17:22:38 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > +UPROBES
> > > +M:	Masami Hiramatsu <mhiramat@kernel.org>
> > > +M:	Oleg Nesterov <oleg@redhat.com>
> > > +M:	Peter Zijlstra <peterz@infradead.org>
> > > +L:	linux-kernel@vger.kernel.org
> > > +L:	linux-trace-kernel@vger.kernel.org
> > > +S:	Maintained
> > > +Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
> > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> > > +F:	include/linux/uprobes.h
> > > +F:	kernel/events/uprobes.c  
> > 
> > Maybe no Q/T. Neither Oleg nor me have write access to that git tree.

Aah right...

> > 
> > Also, I think you want:
> > 
> > F: arch/*/kernel/uprobes.c 
> > F: arch/*/kernel/probes/uprobes.c 
> > F: arch/*/include/asm/uprobes.h

OK, I confirmed it covers all arch.

> > This is just to ensure get_maintainers.sh gets our email addresses for
> > all uprobes stuff.
> 
> Agreed. As those files can go through other trees, it's best not to add
> linux-trace.git nor patchwork to MAINTAINERS file. It's just there to make
> sure the proper people are Cc'd.

OK, let me update it.

Thank you!

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

