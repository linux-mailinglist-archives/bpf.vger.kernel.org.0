Return-Path: <bpf+bounces-41019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5E991100
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7671C22F47
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962DC1ADFFF;
	Fri,  4 Oct 2024 20:58:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D215D1;
	Fri,  4 Oct 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075514; cv=none; b=c8K8eXncRFy2mObhUJekA+p+NPCYNiT/T4BVgNoEA2NKEvfdNmct8zp8o9MmaRm7/QhDQYbEq9llO9ds22+isXI38O1mhscFQNj8flTC+9xTEtEVdPHRsgHSn4Sj8oACKXLyRXRdLHuAnbvmh7cimbTrP0D5ziU3gi+GmRrVnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075514; c=relaxed/simple;
	bh=+Ef3UyjsUB+Ar1A7IpIt4SHw+OpwXL1vVhNlffc6fuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaGw2uKtzzg2o+oJkf350z9CsKm4YB9g8W6IyNx1oDzUAN76L/ltGWdV65WvKuQXycPaCloysAIP/FoT0npRfIL0tJMkOI0Rw5rM/fo9f1HXTsvuwqCB4T/CRIOTywiXZCI5YMLkqxsw/wlv08oLCb0yX+RIVT34yUxJwrCsxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C84C4CEC6;
	Fri,  4 Oct 2024 20:58:31 +0000 (UTC)
Date: Fri, 4 Oct 2024 16:59:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song
 <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
 linux-trace-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v1 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
Message-ID: <20241004165927.774e7d35@gandalf.local.home>
In-Reply-To: <CAEf4BzYHXz0UFOOnkAeKDK-yt59cwz-66_4wL-bjmv3zxryftg@mail.gmail.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-3-mathieu.desnoyers@efficios.com>
	<20241003182304.2b04b74a@gandalf.local.home>
	<6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
	<20241003210403.71d4aa67@gandalf.local.home>
	<90ca2fee-cdfb-4d48-ab9e-57d8d2b8b8d8@efficios.com>
	<20241004092619.0be53f90@gandalf.local.home>
	<e547819a-7993-4c80-b358-6719ca420cf8@efficios.com>
	<20241004105211.13ea45da@gandalf.local.home>
	<4f1046e7-7b62-4db3-93d4-815dc8c27185@efficios.com>
	<CAEf4BzYHXz0UFOOnkAeKDK-yt59cwz-66_4wL-bjmv3zxryftg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 13:04:21 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > AFAIU eBPF folks are very eager to start making use of this, so we won't
> > have to wait long.  
> 
> I already gave my ack on BPF parts of this patch set, but I'll
> elaborate a bit more here for the record. There seems to be two things
> that's been discussed.
> 
> First, preempt_disable() vs migrate_disable(). We only need the
> latter, but the former just preserves current behavior and I think
> it's fine, we can follow up with BPF-specific bits later to optimize
> and clean this up further. No big deal.
> 
> Second, whether BPF can utilize sleepable (faultable) tracepoints
> right now with these changes. No, we need a bit more work (again, in
> BPF specific parts) to allow faultable tracepoint attachment for BPF
> programs. But it's a bit nuanced piece of code to get everything
> right, and it's best done by someone more familiar with BPF internals.
> So I wouldn't expect Mathieu to do this either.
> 
> So, tl;dr, I think patches are fine as-is (from BPF perspective), and
> we'd like to see them applied and get to bpf-next for further
> development on top of that.

Thanks Andrii for elaborating.

-- Steve

