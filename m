Return-Path: <bpf+bounces-76268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63327CAC44C
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 08:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 785E43064AEB
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B5324706;
	Mon,  8 Dec 2025 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqmx9LYB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9A17993;
	Mon,  8 Dec 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175460; cv=none; b=ga1I5xOaeDG8OBr4TL6zCHsOpO1mjFCjcQ7bPMolJjKV6veIP7cnScEuawuikF0695GnVxYTY0SPst8MM3SrO3gCptDWHaaBuZEBht/CqERa+icMNXPFDmfr+dGfkYG9M4t2P9JtE6QgSc0lKNixfADWrc2TpfbM+kWDbec3HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175460; c=relaxed/simple;
	bh=4GdyjoLd+v/0POJebk1mSYx8Z1lRT8zDP249wCWe7z4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CeKV9ib7N7mKRWQaVooDp5G2O/ko+Xt+YlAaguA0T+1NTWfDVT2Sz7cLTl9OF9h/obt3eGXge10h9B0sb9Uhq8bhPs/ZWpWmQM83IB4wLJO9t2fTsE8teG6dAwmbmEyqXR6MJo+JdcPKLlIVgznPINLRhvmsQeG33WGzYEsTxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqmx9LYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C064C113D0;
	Mon,  8 Dec 2025 06:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175459;
	bh=4GdyjoLd+v/0POJebk1mSYx8Z1lRT8zDP249wCWe7z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rqmx9LYBtVBjDUnSqgRFCHQMOR6f/LmagP9aF13iTigJHbWc4e5ej5Mwgn7SONwFX
	 tk2E9qQiWjTAhYSo/hzPx65J/c/RfUYZPSMYmPI2AF5AqYwMgKF7nSx2FFRhzBzXo9
	 xZ3UukKulwTRntYr5NGDI8snjjWuWCZ8gxOyvZcddf/iSzs0QRQE80nK4cYCIxhV7x
	 eYThoHYW7TP4KE/nYbJHYF8oKSOu7gs7WEksQK+cgxFmRurOWADzgtDKRVx0YqiYai
	 6hYqskHnQ9/BHdLNpeH2nKpww1vG4lUXT5HE2GuLsXaQEV5B4avGUf0IviLKgPioHC
	 hGedUn1Ljhhlw==
Date: Mon, 8 Dec 2025 15:30:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH 0/8] uprobe/x86: Add support to optimize prologue
Message-Id: <20251208153056.3a4e9cd3511ccf00dc12e265@kernel.org>
In-Reply-To: <aSSgGu8X04XoYN8D@redhat.com>
References: <20251117124057.687384-1-jolsa@kernel.org>
	<aSSgGu8X04XoYN8D@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 19:12:42 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 11/17, Jiri Olsa wrote:
> >
> > This patchset adds support to optimize uprobe on top of instruction
> > that could be emulated and also adds support to emulate particular
> > versions of mov and sub instructions to cover some of the user space
> > functions prologues, like:
> >
> >   pushq %rbp
> >   movq  %rsp,%rbp
> >   subq  $0xb0,%rsp
> 
> ...
> 
> > There's an additional issue that single instruction replacement does
> > not have and it's the possibility of the user space code to jump in the
> > middle of those 5 bytes. I think it's unlikely to happen at the function
> > prologue, but uprobe could be placed anywhere. I'm not sure how to
> > mitigate this other than having some enable/disable switch or config
> > option, which is unfortunate.
> 
> plus this breaks single-stepping... Although perhaps we don't really care.

Yeah, and I think we can stop optimization if post_handler is set.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

