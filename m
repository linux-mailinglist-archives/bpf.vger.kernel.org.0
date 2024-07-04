Return-Path: <bpf+bounces-33891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE5927786
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3251C23134
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60451ABC25;
	Thu,  4 Jul 2024 13:56:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C251AED2F;
	Thu,  4 Jul 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101401; cv=none; b=RS1YjyZsZmZZA6HRt8JzMI175okRURubdzEAxnMT6NHDpCJYSdjbPrDHL7tBDVEMyTbFrf+etsiqUATH5/FI9MW3fM7RKc3CIt09EZGY3e/hF0tV2mE5tmcyb9usVwUEhzdy7MA2L7epv98Nxq79ID+zm9KzPYcU3637+OxfLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101401; c=relaxed/simple;
	bh=VsItbA+2tCk5jvnBDCPCGCM7fjfdCiKMICq/1XcljAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZ/ERz8k08tkL/pW+2ycvisErsIjQ/B25KePODENdO27aQb07pqf+OBWlPqB/h/9KRBT/xHspCI5cQKGsRgT8bcuZQLXp8qAJohHr/CHdPhL4K3JZp5FZ1087VE0IRr1XBbIYAcMh7AITfUym3xQX+v2s+SijJ7WUEw/rYjyjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B45C3277B;
	Thu,  4 Jul 2024 13:56:39 +0000 (UTC)
Date: Thu, 4 Jul 2024 09:56:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
 bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240704095637.0dbf9483@rorschach.local.home>
In-Reply-To: <20240704091559.GS11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
	<CAEf4BzaZhi+_MZ0M4Pz-1qmej6rrJeLO9x1+nR5QH9pnQXzwdw@mail.gmail.com>
	<20240704091559.GS11386@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 11:15:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Now, RCU Tasks Trace were specifically designed for least overhead
> > hotpath (reader side) performance, at the expense of slowing down much
> > rarer writers. My microbenchmarking does show at least 5% difference.
> > Both flavors can handle sleepable uprobes waiting for page faults.
> > Tasks Trace flavor is already used for tracing in the BPF realm,
> > including for sleepable uprobes and works well. It's not going away.  
> 
> I need to look into this new RCU flavour and why it exists -- for
> example, why can't SRCU be improved to gain the same benefits. This is
> what we've always done, improve SRCU.

I don't know about this use case, but for the trampoline use case SRCU
doesn't work as it requires calling a srcu_read_lock() which isn't
possible when you need to take that lock from all function calls just
before it jumps to the ftrace trampoline. That is, it needs to be taken
before "call fentry".

I'm just stating this to provide the reason why we needed that flavor
of RCU.

-- Steve

