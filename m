Return-Path: <bpf+bounces-55777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B944A86571
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50C31BC0DE5
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45425A350;
	Fri, 11 Apr 2025 18:23:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43D25A32E;
	Fri, 11 Apr 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395784; cv=none; b=GuoSibJMyXDxh1PFlP4HSEtHJGRcDcdc2QcoO6dyRFG0Ra655xQ1N+RmClyq/rCCxiKXkCKUlcCTMsViAmWatGOCWLTc2jUhzv7/sGqOGI3oFPP555/oDxAGXPsroOfcRSIWNykzNN8j7YfSRB/xPwnVeZZ7VxZ75wnEoHkUGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395784; c=relaxed/simple;
	bh=vSkNkAc8pgn9J8PbBDKIic5ELkhfNhanohfnaa3s6UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lf16KJq+CsS3EOgke1/rocEAYJNDYuhIC7g2lE0MffRORnrB7D0YRB2ur0kxheEE48eNiRVdPA2wX42K5T7bmIXgsCQuer4dmS50ccublb3weYxTbsecP5PvUNKPRyWawXZMQeMqVPEthYJmyGmegD1dyGYi9WambA3tQtcOrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC76C4CEE9;
	Fri, 11 Apr 2025 18:23:02 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:24:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250411142427.3abfb3c3@gandalf.local.home>
In-Reply-To: <9dafc156-1272-4039-a9c0-3448a1bd6d1f@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
	<20250410131745.04c126eb@gandalf.local.home>
	<c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
	<20250411124552.36564a07@gandalf.local.home>
	<2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
	<20250411131254.3e6155ea@gandalf.local.home>
	<350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk>
	<9dafc156-1272-4039-a9c0-3448a1bd6d1f@sirena.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 19:16:29 +0100
Mark Brown <broonie@kernel.org> wrote:

> > which smells a bit of a shell incompatibility issue.  I'll try to find
> > time to have a look.  
> 
> Yeah, if I bodge ftracetest to be a bash script then the test runs fine
> so it'll be a bashism.  We're running the tests in a Debian rootfs so
> /bin/sh will be dash.

Interesting, as one of the ftracetests checks for bashisms:

  test.d/selftest/bashisms.tc

Did it not catch something?

-- Steve

