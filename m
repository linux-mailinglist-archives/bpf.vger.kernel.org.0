Return-Path: <bpf+bounces-58215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93382AB72C6
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 19:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947021BA5234
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9580283FDE;
	Wed, 14 May 2025 17:26:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537A283FD5;
	Wed, 14 May 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243615; cv=none; b=XW6m6KqXWMRr+gxrjrmHRFhRx3aUuLYMgmmorYwird2BWLuMQn5rqrUgWHsS4e17ymD8BQJhf1wKOM3cIVk97hMc6Rv7FZbJt0ez/qtiOGeXrgbBH4/pnzvqbfT9fpF5CW8M3EHpOkiGdz2Aoy3UDC11sHGbLTZFRArUDb/sqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243615; c=relaxed/simple;
	bh=199jrX7qWTGcAfOAt45c9C7A7Jv/ZBzevkT0aPJrFg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttBtsBgrrUPlqALJ64k3NL8fT10fG9m0KDgirw83j3Jvfpsb4LYiGnhXILeS+8Srx2/nTBENlLlETh+3atcjisrChtbXD9MbwwvSaoJayg6b/+WqphoFd7Bu06ViPKsj0DoeD/yNysUgJ050mqguWF8xlbjsaJmpiTZ6NistFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61350C4CEE3;
	Wed, 14 May 2025 17:26:53 +0000 (UTC)
Date: Wed, 14 May 2025 13:27:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrii
 Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250514132720.6b16880c@gandalf.local.home>
In-Reply-To: <20250513223435.636200356@goodmis.org>
References: <20250513223435.636200356@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 18:34:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This has modifications in x86 and I would like it to go through the x86
> tree. Preferably it can go into this merge window so we can focus on getting
> perf and ftrace to work on top of this.

I think it may be best for me to remove the two x86 specific patches, and
rebuild the ftrace work on top of it. For testing, I'll just keep those two
patches in my tree locally, but then I can get this moving for this merge
window.

Next merge window, we can spend more time on getting the perf API working
properly.

-- Steve

