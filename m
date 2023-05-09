Return-Path: <bpf+bounces-247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EF6FC9B6
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 16:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC21C20BBF
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3517FFB;
	Tue,  9 May 2023 14:58:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD887499
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 14:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A0FC4339B;
	Tue,  9 May 2023 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683644317;
	bh=Ffwc6yixBA33c4FR7+/arec40SIAgdtCi0uPwyVdUPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dTjlHcy2vPjOYK+z7CuW6mjbAVHR4pqQC532Cci6uSBkF9uKW6M1znrhUlNDV+WiI
	 RiII5z54WktPe25hk1T7nVFk2StDsneZaUfqUmOQC1nkzY9jqe9Eoz6iAzWUFGZoT4
	 Mf0EvUTFlMia42cvqvhKzI/++N7R6F2HDvBZzCN/Ebwc2Fw71LU8vEzGdPe6xsL83d
	 sSwqHEih+xl6JBaSG1J1Gojvmsfr6SopW2SNEzkgDVZlQ6/87ODrOT2DsYSiJcTorU
	 anz8vfOr2FOyuix0Bl9aVTsJsb0lI0tfZYanuBOrysCsRuvJRxdWqA7WtZELl1bdmJ
	 wSNIjoKMajaCg==
Date: Tue, 9 May 2023 23:58:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 11/11] Documentation: tracing/probes: Add fprobe
 event tracing document
Message-Id: <20230509235832.3499572829aa62b414082693@kernel.org>
In-Reply-To: <20230505112026.6a46bcec@gandalf.local.home>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
	<168299393654.3242086.4099482065080890890.stgit@mhiramat.roam.corp.google.com>
	<20230505112026.6a46bcec@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 May 2023 11:20:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  2 May 2023 11:18:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > + # cat events/fprobes/myprobe/format
> > + name: myprobe
> > + ID: 1313
> > + format:
> > + 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> > + 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> > + 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> > + 	field:int common_pid;	offset:4;	size:4;	signed:1;
> > +
> > + 	field:unsigned long __probe_ip;	offset:8;	size:8;	signed:0;
> > + 	field:u64 count;	offset:16;	size:8;	signed:0;
> > + 	field:u64 pos;	offset:24;	size:8;	signed:0;
> 
> git complained when I pulled this in because there above lines is:
> 
> <space><tab>field...
> 
> Where, the space should be removed.

Ah, OK. I just added a head space for each line... (hmm, checkpatch.pl may not check it?)

I'll fix it.

Thank you!

> 
> -- Steve
> 
> > +
> > + print fmt: "(%lx) count=%Lu pos=0x%Lx", REC->__probe_ip, REC->count, REC->pos


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

