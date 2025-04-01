Return-Path: <bpf+bounces-55106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5081A783F6
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 23:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA2716E239
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9393215078;
	Tue,  1 Apr 2025 21:21:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82789214A90
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542485; cv=none; b=KrrhGbNwvwmAoqAEelyYycj4A3T+O5XAhuzdmivqK7og+Ly+rxuZaalnt5GnqR/ckB0e+dTxbmvDmS7a9KH8d0LTblIxJnCzJFyOIJOYBB/+niqHRC9BOurATSI0+Ia9r3H3Xx0ap5oakPLddnok6zfz8mAlgIjsQWLaDqAU0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542485; c=relaxed/simple;
	bh=+zQ8LR6P9ksIvNsFmLDdbJS7XvsSy3v7oeqMrIHAWcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ph7UpqOtBdOqlHBFX7EDwIcLVyByDH+xxOEXUOH8RUDr3rO0tG6CS0GRwj3YpcsXFx0qMSrMIMyH3/OZfKW3sDtFuNqyQTmKbR3b3kZ69BfsrAXZnsEbuh5vPsb7uHKZpon5Vs+/vSuPZ/9LqjqF2UN0LT2w7R5NoYtMQQ6Hsxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D6CC4CEE4;
	Tue,  1 Apr 2025 21:21:24 +0000 (UTC)
Date: Tue, 1 Apr 2025 17:22:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Sebastian Sewior <bigeasy@linutronix.de>, Jiri
 Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250401172225.06b01b22@gandalf.local.home>
In-Reply-To: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 14:04:22 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Looks like write_seqcount_begin(&utask->ri_seqcount);
> use in ri_timer() needs a fix ?

Hmm,

	write_seqcount_begin(&utask->ri_seqcount);

	for_each_ret_instance_rcu(ri, utask->return_instances)
		hprobe_expire(&ri->hprobe, false);

	write_seqcount_end(&utask->ri_seqcount);

How big can that loop be?

Of course, we could just say not to use uprobes on PREEMPT_RT kernels?
Otherwise, they could cause an unspecified latency.

-- Steve

