Return-Path: <bpf+bounces-75464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C412DC855BE
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 068CB4EA872
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA2324B2B;
	Tue, 25 Nov 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOfDQ2zI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9323D29F;
	Tue, 25 Nov 2025 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080308; cv=none; b=RsrXBnhzhS1/Y5mZV+yXth3C+QnqgHJvXkD5+mxA8E3i94PvLeNcAdIsGPC4N2hwni5Bu8xyvZdtW6pSIZttrxdi/q91wx+5BZRT42XAS+mh5iK4R2tv0GDpxIj785WGuYPBYi8k2VmC4qfFw/nsO2K1I+lQdZSz3P7rCQGm/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080308; c=relaxed/simple;
	bh=oPbcVTTzame3aqqLKrW9RY5mARPG0SFH+InJLmThENE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4GsAHw3tKmI0WlAXwrVicaxmqbWGr3dUq1rfKHkI0mvQ78uTPaiqlHkrnnsBr5BlHXcaa/vUlJIm5yUQ9tNL+bygvIpRnBjWZzoCwJgi7wjn8myg+XhVHH9UtOpyvpVvDnlVnUpH2qBFFFknWRQYc3Tk5lnaqYEtyi6Z3ykBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOfDQ2zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC31C4CEF1;
	Tue, 25 Nov 2025 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764080308;
	bh=oPbcVTTzame3aqqLKrW9RY5mARPG0SFH+InJLmThENE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOfDQ2zIj4Kmlt2P9IQw96sCrerj8kG1dKJbMHH2zRcM4XymK2i3pWtmNojt+nh0p
	 MKqWGXKQz/Bp/9+cYvya2ZHKnv2PPenJPM0UHAtZvCxOKVZR9MReoMTleixFuG+9hp
	 lPyuXFfcuvWZybvIyveWMMPkTUNsLNJ96nCjIfe5Owpe0OUcJXB8vCRQ+CHYvrqLca
	 peE5rTILw0shnU18D+SUqrwnMQJoFJcssoxgC+Zve1sJbhywENac25BcParGTd5PLe
	 V/d2P7XV6BUe0ElCUttjZFCz2KIRmgO5jUif+C3mnSvdlfna06/uKXLvc7JX9aRnl6
	 fyspEsSAmsyYA==
Date: Tue, 25 Nov 2025 15:18:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 14/16] srcu: Create an SRCU-fast-updown API
Message-ID: <aSW6sVkqWh2aGxlK@localhost.localdomain>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-14-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105203216.2701005-14-paulmck@kernel.org>

Le Wed, Nov 05, 2025 at 12:32:14PM -0800, Paul E. McKenney a écrit :
> This commit creates an SRCU-fast-updown API, including
> DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
> __init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
> srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
> __srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().
> 
> These are initially identical to their SRCU-fast counterparts, but both
> SRCU-fast and SRCU-fast-updown will be optimized in different directions
> by later commits.  SRCU-fast will lack any sort of srcu_down_read() and
> srcu_up_read() APIs, which will enable extremely efficient NMI safety.
> For its part, SRCU-fast-updown will not be NMI safe, which will enable
> reasonably efficient implementations of srcu_down_read_fast() and
> srcu_up_read_fast().

Doing a last round of reviews before sitting down on a pull request,
I think the changelog in this one should mention what are the expected
uses of SRCU-fast-updown, since the RCU-TASK-TRACE conversion bits aren't
there for this merge window yet.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

