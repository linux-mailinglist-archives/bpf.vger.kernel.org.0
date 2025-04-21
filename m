Return-Path: <bpf+bounces-56310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF36DA9521B
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B843B391A
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49E266B4B;
	Mon, 21 Apr 2025 13:56:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9A261372;
	Mon, 21 Apr 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243791; cv=none; b=qH3UCHbasHrbWE2pD0db9EJ82Gxaz+B3D24pyoPmx0dm1RAEdQEDPmARMcTXdBj05tzjTlLwv9CIx+Xg7UCmYfw2u7KDTSaeN44caQpEw9UVAko5jHJi7JtI4MHjzX4tPcnLDvKqHwcXD8HjBT84Upa3PUjLjGvbQp41oH+kNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243791; c=relaxed/simple;
	bh=lWVnBGd2GWJpmsSY9G04fw5DXUAJg0i7cR1tyQegw3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8t0Hh7OapXB71vuTJNTgjupxH11X7D6KuEWNhTyhX2s75H5jxA3foTLtFJB1Shy+YgGKR7dh1FDU6jsxbjryv6wcUwnU6Zj/kN3g4AN9YIHZjk/3ErsrWRT+fyVN2Hp4JZMLLM5izYpcTCLlPzFw7Kvqzv9Hd391jhxnmWu68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3056EC4CEE4;
	Mon, 21 Apr 2025 13:56:29 +0000 (UTC)
Date: Mon, 21 Apr 2025 09:58:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, David Ahern <dsahern@kernel.org>,
 Juri Lelli <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Gabriele
 Monaco <gmonaco@redhat.com>
Subject: Re: [RFC][PATCH] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
Message-ID: <20250421095817.49c433b7@gandalf.local.home>
In-Reply-To: <aAY9pcvYHkYKFwZ5@krava>
References: <20250418110104.12af6883@gandalf.local.home>
	<aAY9pcvYHkYKFwZ5@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 14:44:21 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> hi,
> do we need the change also for DECLARE_TRACE_WRITABLE?

Probably ;-)

> I needed change below for bpf selftest kmod

Thanks, I'll fold this in.

I'll make a more formal patch if nobody has any objections.

-- Steve

