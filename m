Return-Path: <bpf+bounces-47841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B6BA0091D
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 13:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCA07A1129
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267BA1F9F70;
	Fri,  3 Jan 2025 12:14:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46F63CF;
	Fri,  3 Jan 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906454; cv=none; b=E2xim3EiErZnOJq34ez807a2bzpxwhM7TJUy/PifttPTmyGOxb5QaLLOCv/7g5wOfouNaIOqHJacfTl2/94K4ZvgmypgbWEBUBqwvMwe5eiVkiE5fMaUi3d4ng2Wf4fCRRRZR8gxI/nCiN26FHHYKgTnZokqRglQFGvCEzZK1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906454; c=relaxed/simple;
	bh=cI2zLIFCPmAFzEvQeWv9aNKBYCzB1vHyJNTIeOQGQ0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uthVTwl7QBgpCVY9hdaB3q8fyBR7J0eOQnj1o5T46AeSdT7KCFynIUXUYDJu/FMXstyGV2S0CWu2C5TqpD53vXhlXSap4cyU1lj3l/G1CZikXNhn92Ez5QjNfLooMPvn9MRVRVBIoN+avFwr3hVgrEpbcrrTdOR9k6Kk80XOvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E49AC4CECE;
	Fri,  3 Jan 2025 12:14:11 +0000 (UTC)
Date: Fri, 3 Jan 2025 07:14:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, bpf
 <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly
 <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <20250103071409.47db1479@batman.local.home>
In-Reply-To: <20250103114140.GF22934@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
	<20250102190105.506164167@goodmis.org>
	<Z3fFkHCPl_68hN4H@krava>
	<20250103114140.GF22934@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 12:41:40 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

>  
> > not sure why that fits the condition above for removal  
> 
> Check your build, if update_socket_protocol() is no longer in the symbol
> table for your vmlinux.o then the linker deleted the symbol and things
> work as advertised.
> 
> If its still there, these patches have a wobbly.

There is a wobbly. I guess I eliminated all weak functions even if they
were still used :-p

Jiri, can you add this on top?

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 506172898fd8..ebcd687a9f0e 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -523,7 +523,7 @@ static int parse_symbols(const char *fname)
 		uint64_t size;
 
 		/* Only care about functions */
-		if (type != 't' && type != 'T')
+		if (type != 't' && type != 'T' && type != 'W')
 			continue;
 
 		addr = strtoull(addr_str, NULL, 16);


-- Steve

