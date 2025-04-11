Return-Path: <bpf+bounces-55780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065EFA86580
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250B81BA8600
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEF225DAE6;
	Fri, 11 Apr 2025 18:30:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0B25D546;
	Fri, 11 Apr 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396210; cv=none; b=jTGTAqL1vDaUPxSCuI6yLmn1qQsc/l3vGDeAwch+h5g9HdI4xcMlNfqipjaXCZEaN1P4lWYNlOyq0AvxbmkLbto20IvR/d+yPBtJa7gKNJxdfNNy0x80EU1CrMVGzOM9HATYzhfmqOSkdQ0Hpvc8TFovEPm/oFNeGouj9rm/qa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396210; c=relaxed/simple;
	bh=ArKeCzMECIeznxe92yZD6S9MVYQS+ypYFcv2rPdukvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcbQIBXssvg50dbLaFhijV+4uzzauxM7WtdkUdW5DyH5asWMe/kaWkSzwaTZ6Yzd5ToSRV3yBxJly4bjPoyupu8HKM54FmZSP/LpqED79nMEtH4cDQ4nQD0VfzZyPNdWi3rDN2raGhWMWbvqHWZgC/F88iby+tEIoDcDH2v1KPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700D9C4CEE2;
	Fri, 11 Apr 2025 18:30:08 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:31:32 -0400
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
Message-ID: <20250411143132.56096f76@gandalf.local.home>
In-Reply-To: <20250411142427.3abfb3c3@gandalf.local.home>
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
	<20250411142427.3abfb3c3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 14:24:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Yeah, if I bodge ftracetest to be a bash script then the test runs fine
> > so it'll be a bashism.  We're running the tests in a Debian rootfs so
> > /bin/sh will be dash.  
> 
> Interesting, as one of the ftracetests checks for bashisms:
> 
>   test.d/selftest/bashisms.tc
> 
> Did it not catch something?

Hmm, I just tested this, and it fails on my box too (I test on a debian VM).

It fails with and without setting it to bash. I'll take a look too.

-- Steve

