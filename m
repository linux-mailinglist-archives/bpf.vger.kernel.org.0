Return-Path: <bpf+bounces-55786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF955A86646
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 21:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1014A52E7
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67F527EC71;
	Fri, 11 Apr 2025 19:26:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F9233153;
	Fri, 11 Apr 2025 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399571; cv=none; b=NsEayRIdL69jXDjqT22z/t8QAUy70hKDM/EtfbTd5/6BK8XUfbo7W9KWrSsN/eqBHBW7Iu7Pkf2fDVtTgt8m8ceYJFtKYBLQkcw9C251eeY2YjbrKVlblSlDugw2XB+/lMo9uu06SDuqE+/+hqs0vxR3Fe8FwmxkwZ1erY3BbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399571; c=relaxed/simple;
	bh=YZ939yhHOqFYcMbXGdRpeexBmwEjvVNsuJFvajf5xpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeW3cHUmIiI+uboO+V4cFJsOHuClBqIfXJSaCMCZGhPM/NQ9qdV1WfHW/xiMxdKTGjytIdQ3wwpadJlNfwn4gGFuapvGwwBCA9udlLbNd1qH1sJ0AlFq3cf5fVwWebZerK2ChFOwko901+79ohd3s2J5pnmisNAqHqsyEfTuOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45251C4CEE2;
	Fri, 11 Apr 2025 19:26:02 +0000 (UTC)
Date: Fri, 11 Apr 2025 15:27:27 -0400
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
Message-ID: <20250411152727.40272487@gandalf.local.home>
In-Reply-To: <20250411152610.64d555bf@gandalf.local.home>
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
	<20250411143132.56096f76@gandalf.local.home>
	<20250411151358.1d4fd8c7@gandalf.local.home>
	<20250411152610.64d555bf@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 15:26:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Replying to my email as it appears gmail blocked it. Probably due to all
> the escape characters my output had. Resending with that cut out.
> 
> Masami, I was sent a message from gmail that it blocked this from you.
> 
> If you want to see the original email:
> 
>   https://lore.kernel.org/all/20250411151358.1d4fd8c7@gandalf.local.home/
>

Bah! gmail blocked that one too :-p

-- Steve

