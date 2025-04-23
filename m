Return-Path: <bpf+bounces-56543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D9A99AAB
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4856189E37D
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5638223DEF;
	Wed, 23 Apr 2025 21:25:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07C1FF7C5;
	Wed, 23 Apr 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443530; cv=none; b=uFWjWcfguI6cxA8nYj4KVOG+1bBp51v4aWaWdtx5GBNLJgDSJYAI/O3aq/8D31ngjEuNNwwPK2WidIACsiJsohPRnWON6ByBnJg808X9ufE1SalpH8LJd69D8GJTzJr3BtLAfwH0QZ9MqhHyKgDfmYtRXoTH37M1GvfIvlURBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443530; c=relaxed/simple;
	bh=YA9fRtMx0CtQBSoGXUceH7h7bqZQ34EQKJSo9jkgyD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJ4qoBL/lhQicJ8OdVlnIai3BRKpfPm+HfSJOdPNfkWtC1ndx8TDCDXY8b3dAwDBoSND7BILi+pZ3ER3q1QRZ7nIxBU0y1cdzy/tOotUA/ZZxbW82RVkl6zuQ2iaKFfmUU8R9+miR7NIUrPvdIPM4EzCSIrS83JPlERxFmrc+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58353C4CEE2;
	Wed, 23 Apr 2025 21:25:28 +0000 (UTC)
Date: Wed, 23 Apr 2025 17:27:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, David Ahern <dsahern@kernel.org>,
 Juri Lelli <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [RFC][PATCH] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
Message-ID: <20250423172721.54499dc4@gandalf.local.home>
In-Reply-To: <CAEf4Bzbwoxsv-oAZoKyFDptWYxHRO2SwAEAmDD+Kym9e5oC_Rg@mail.gmail.com>
References: <20250418110104.12af6883@gandalf.local.home>
	<CAEf4BzZfoCV=irWiy1MCY0fkhsJWxq8UGTYCW9Y3pQQP35eBLQ@mail.gmail.com>
	<20250423145308.5f808ada@gandalf.local.home>
	<CAEf4Bzbwoxsv-oAZoKyFDptWYxHRO2SwAEAmDD+Kym9e5oC_Rg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 14:21:24 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> BPF by itself doesn't have any API to list tracepoints, so in that
> sense, no, BPF doesn't expose *the list* of those tracepoints. But the
> same can be said about kprobes or normal tracepoints. But it is
> allowed to attempt to attach to those tracepoints by just specifying
> their name as a string.
> 
> I guess I'm confused about what "accessing only from code within the
> kernel" means. In my mind BPF isn't really "code within the kernel",
> but we are getting into the philosophical area now :) I just wanted to
> point out that this is consumable/attachable with BPF just like any
> other tracepoint, so it's not just kernel/module code that can attach
> to them.

To continue the philosophical debate ;-) I'll argue that a BPF program runs
inside the kernel just like a module would. Hence, a BPF program is in
kernel space. In fact, from what I understand, that's the entire point of
BPF. To run in kernel space!

-- Steve

