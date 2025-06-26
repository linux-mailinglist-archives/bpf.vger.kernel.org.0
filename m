Return-Path: <bpf+bounces-61656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B86AE98C4
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 10:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796C1169FFB
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0B293C60;
	Thu, 26 Jun 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COogAbYA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB31D7984;
	Thu, 26 Jun 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927486; cv=none; b=OhEHqe3WQGv7eSyqNhbWpulacT7CEToIU7dr3Ynbpf4WYpcYa4D1AOUdeQBP3FBw5A+N1wQ8s/5BFL0skeKwbNWA6Cw7B+ARu8IOgFkZlC4wjuqM5VnU2UdTRDx0ZWlOLuv3xYYQ9K35NGM2WEcb/fRzqjHG6Z1ubwPo50xNXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927486; c=relaxed/simple;
	bh=uAXSdXjQipbrsNfVlUOfcL0GpyFAcGYbbv/Bob1z4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPqVMwGXMI03cx1japsjui7tLv8B+S+giZZ2FSOB8y/BhjEj7mYU9J5JvTQVELJxgFZcF5fzTPUTrAhe7zNqoIthwPBxHEv3jCRzH3pSYFqLTGE54VkJ6qfxE4yPBFsyJEDcxyLapPjEo9k1DIcyFe0ezjwruGuckl57s8SX/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COogAbYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C821C4CEEB;
	Thu, 26 Jun 2025 08:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927485;
	bh=uAXSdXjQipbrsNfVlUOfcL0GpyFAcGYbbv/Bob1z4qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COogAbYAy9397O1PrC7YUkMkoesxoUsxAdFhtr9RDGwfz9Ryq6PTxa+SnV0SOYx0N
	 MSUpZnn9WaBFeRpM9xiClm53mjORDI+53/JO+WNy4sAyi4WLXTFdPKSBkBKtWyM15T
	 910/yRzT4Ru1qumJNhQrAoZ54jj3YS1dG+g7mTvm/grX4w0fGDwR+A9Nl5aH6ypra+
	 M4mlyoChYl7yPYKBIJ/akY1E+H4ReAjQdzIpvahhzz9Iwdct7z2ntkzI3re3Ndq1+j
	 S7sySRWPSXCsoFRL824QGgXUerK5oW7C8C42NXx7a+bKZpjZy7OUYVskTWVv+Fl0gJ
	 ibx1KGTC0wDKg==
Date: Thu, 26 Jun 2025 10:44:40 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 13/14] perf/x86: Rename and move get_segment_base()
 and make it global
Message-ID: <aF0IeDBaAfRypu1W@gmail.com>
References: <20250625225600.555017347@goodmis.org>
 <20250625225717.016385736@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625225717.016385736@goodmis.org>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> get_segment_base() will be used by the unwind_user code, so make it
> global and rename it to segment_base_address() so it doesn't conflict with
> a KVM function of the same name.

So if you make an x86-internal helper function global, please prefix it 
with x86_ or so:

	unsigned long x86_get_segment_base(unsigned int segment)

Keeping the _get name also keeps it within the nomenclature of the 
general segment descriptor API family:

	get_desc_base()
	set_desc_base()
	get_desc_limit()
	set_desc_limit()
  [x86_]get_segment_base()

> Also add a lockdep_assert_irqs_disabled() to make sure it's always 
> called with interrupts disabled.

Please make this a separate patch, this change gets hidden in the noise 
of the function movement and renaming otherwise, plus it also makes the 
title false and misleading:

   perf/x86: Rename and move get_segment_base() and make it global

Thanks,

	Ingo

