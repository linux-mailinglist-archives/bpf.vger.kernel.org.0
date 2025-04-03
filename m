Return-Path: <bpf+bounces-55235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2F5A7A609
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1126B1895E3A
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551C32505D1;
	Thu,  3 Apr 2025 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvTZUoOn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A82505B9;
	Thu,  3 Apr 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693123; cv=none; b=p4s4V+0Oda3g4q0Uyqdl1LKXhm8r4wvjldoe6Qr2fYIlrW8ODIMQcPQHXHBMnwU1IfAprcPuw4NBfj0GawAoWiUtxWP54JiY8/WRxYswDKPq/G5xMfBOYMTFYKvgShwbpGYKFoAy1bQL8tKk0pGJNJyhKOUNVHiIIUAFbcTzJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693123; c=relaxed/simple;
	bh=4PjGJTU8qkgoM7vN10UUhIU09ORJAlHt31WGPH0oV68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1KW1b/Lbr052IFZwPHDY4UBeO1MxiYyR/O6djYY3aPcqTlnofHbFhPHWuhixYCJi67wJrfEi0Nj9wPzu498/iuv2IRxpu7DUCXZi/q7+3FDAZGa+EKLVn5pqwSWaAI+jwFu8/e15Pawvdiqx7AxEjia5NWI/VmqFQgyD8+BhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvTZUoOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85B9C4CEE3;
	Thu,  3 Apr 2025 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743693123;
	bh=4PjGJTU8qkgoM7vN10UUhIU09ORJAlHt31WGPH0oV68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvTZUoOnE5l1ap0n0DBllaa5z6elEvQV+v3Kt71iWesqsNHn1ns97C27gvbi4p8lp
	 BgPqxQhun/BAnvSE8lJz88dpmHRFoUYO6bD+/UjD9WkZDw5271MixaFh24xMdroh2T
	 eTFN4njyP0bCNzBwqQH3ivWhqrg5YQ99dfqmYJEUPnYBbH33WFnop9FBW7FjMHw45H
	 jXAyid3zUNiLGEnd3u4FSmoWWwkzetEcHDXaJNmAt6w2kk8Rg1jYUUBf1J+7WcNusf
	 DIOkQ0IaNF22NCMV51pxvnICsk5a/VsOjtSs3q8CjdwlOZAwr4MdOwgvd4UWY9k2Yh
	 iSK2TutNwcvTQ==
Date: Thu, 3 Apr 2025 17:11:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mhocko@kernel.org, oleg@redhat.com, brauner@kernel.org,
	glider@google.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2] exit: move and extend sched_process_exit() tracepoint
Message-ID: <Z-6lPadt51e7jcXd@gmail.com>
References: <20250402180925.90914-1-andrii@kernel.org>
 <Z-6TDh1MUT49lvjk@gmail.com>
 <20250403110615.7a51b793@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403110615.7a51b793@gandalf.local.home>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 3 Apr 2025 15:54:22 +0200
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > This feels really fragile, could you please at least add a comment 
> > that points out that this is basically an extension of 
> > sched_process_template, and that it should remain a subset of it, 
> > or something to that end?
> 
> Is there any dependency on this?
> 
> I don't know of any other dependency to why this was a template other than
> to save memory.

Uhm, to state the obvious: to not replicate the same definitions over 
and over again three times times, for 3 scheduler tracepoints that 
share the record format?

Removing just a single sched_process_template use bloats the source and 
adds in potential fragility:

 2 files changed, 26 insertions(+), 4 deletions(-)

So my request is to please at least add a comment that points the 
reader to the shared record format between sched_process_exit and the 
other two tracepoints.

Thanks,

	Ingo

