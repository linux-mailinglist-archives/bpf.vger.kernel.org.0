Return-Path: <bpf+bounces-31719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21831902547
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3421C21B04
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA60A14AD25;
	Mon, 10 Jun 2024 15:16:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC882483;
	Mon, 10 Jun 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032579; cv=none; b=B4nFFNh0fhfFR1BUHFPKk4bSFroJWGD1mixVQ3v6G/HTHpV71QM2ptdt7un1oDA2JvDHL8ywwW02Sj2dyDEu0BmiFezkdLfz2rRY31OBLO1Ef6kN+GsXOL6Os/99WoUPbSWAAx4jIl7e6g0cOaSGmQYelzjfxyuKXtyOoC0oO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032579; c=relaxed/simple;
	bh=7WETetKobdT3s6/DNAZaGWym4aHxPPI1/kHjkxitoXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4nYVsbhnK1wlq64iPc8zp/5t5qF2F3wf4F3hi5L1BcB8L4Hxli6hx7RwmD+Th2NgcDTHa9TibKMzFdlZ/yQgYU1Fw+/kTzsgp3Z35y1fUemhQKRO5KNWhKqKqxjw+5kMcbiT/XXNriQE5FgIK2/2kKKl9AEDmIXB7FB3hQvx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C33C2BBFC;
	Mon, 10 Jun 2024 15:16:15 +0000 (UTC)
Date: Mon, 10 Jun 2024 11:16:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org, x86@kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv7 bpf-next 0/9] uprobe: uretprobe speed up
Message-ID: <20240610111614.1448e721@rorschach.local.home>
In-Reply-To: <CAEf4Bzbc99bwGcmtCa3iekXSvSrxMQzfnTViT5Y-dn8qbvJy7A@mail.gmail.com>
References: <20240523121149.575616-1-jolsa@kernel.org>
	<CAEf4Bza-+=04GG7Tg4U4pCQ28Oy_2F_5872EPDsX6X3Y=jhEuw@mail.gmail.com>
	<CAEf4Bzbc99bwGcmtCa3iekXSvSrxMQzfnTViT5Y-dn8qbvJy7A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 09:42:45 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Another ping. It's been two weeks since Jiri posted the last revision
> that got no more feedback to be addressed and everyone seems to be
> happy with it.

Sorry, there's been a lot going on.

> 
> This is an important speed up improvement for uprobe infrastructure in
> general and for BPF ecosystem in particular. "Uprobes are slow" is one
> of the top complaints from production BPF users, and sys_uretprobe
> approach is significantly improving the situation for return uprobes
> (aka uretprobes), potentially enabling new use cases that previously
> could have been too expensive to trace in practice and reducing the
> overhead of the existing ones.
> 
> I'd appreciate the engagement from linux-trace maintainers on this
> patch set. Given it's important for BPF and that a big part of the
> patch set is BPF-based selftests, we'd also be happy to route all this
> through the bpf-next tree (which would actually make logistics for us
> much easier, but that's not the main concern). But regardless of the
> tree, it would be nice to make a decision and go forward with it.

I'll be talking with Masami about this later today.

-- Steve

