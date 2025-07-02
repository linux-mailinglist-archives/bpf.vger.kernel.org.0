Return-Path: <bpf+bounces-62191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42588AF62D8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB9522187
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9572D9EE1;
	Wed,  2 Jul 2025 19:51:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF522578A;
	Wed,  2 Jul 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485894; cv=none; b=bqIkXXtwxxKV7dQq6IqusstDlxxDZsL3ECXCmk0sNw3PBqTeYmRY7S0ezen9KhPEe7yYox1Ziiy9BSJcB/ntlo2I8f89+g9caDIRA8vWvsf9hmhEuX8JQdmUbqcn6cC/+vHpq4A3Yg1d+C6xOJDT2zjy6LaHJC+nSUY2klROfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485894; c=relaxed/simple;
	bh=OIJYa/WkVsqIuc4xmKeaO1mZw9uDZEI2VoVT6bBft7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5QHj48xXSh2T7a8kwdhDfVCTLEpRPeODy9h6V3BsJH3hLkTgSH6MrSEmBeTDXMX1VVZgq1k17mdN3BnVxm5vPQ1jjOF78PQDK520LmgPof79YwTHGmyWO9x+VTHNJs1IVT4lLojV5UyC524bnzXBJvJd7BIwE5qqSu7bxfj8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 7E8C9B9956;
	Wed,  2 Jul 2025 19:51:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id C9AAC20028;
	Wed,  2 Jul 2025 19:51:23 +0000 (UTC)
Date: Wed, 2 Jul 2025 15:51:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250702155122.46db0cdc@batman.local.home>
In-Reply-To: <707898da-a3d4-4cdb-816a-6a2e5a3cb03d@efficios.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.571473750@goodmis.org>
	<20250702163609.GR1613200@noisy.programming.kicks-ass.net>
	<20250702124216.4668826a@batman.local.home>
	<CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
	<20250702132605.6c79c1ec@batman.local.home>
	<20250702134850.254cec76@batman.local.home>
	<CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
	<482f6b76-6086-47da-a3cf-d57106bdcb39@efficios.com>
	<20250702150535.7d2596df@batman.local.home>
	<47a43d27-7eac-4f88-a783-afdd3a97bb11@efficios.com>
	<20250702152111.1bec7214@batman.local.home>
	<707898da-a3d4-4cdb-816a-6a2e5a3cb03d@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cqmzcqjjohqicnqnbjgss5ta3mffdtgy
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C9AAC20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JJcmk2ix58Jq2/aZQpuTaJ66um683H9o=
X-HE-Tag: 1751485883-502323
X-HE-Meta: U2FsdGVkX1+kwPlfD2dtbadZ2lP02OHWc3P9soepbrfCllE4nK3shy5TdDP3lH+NYGo0ds3h5OgNNa18husiBAacype0eRk47cTysK5LuAG7i4dXIM9M4+tOWTJI/woYXzv8bnA/pR4GPi4xNAUtVAjN4Cqnn2RzuP43YlLj0xT88gnABtlZX4PcToYDznQcrZGklpj6r+W/mtqV+i124kVRlDSPTeODySjjgl/tk+7nFx/Q3xGaxgJjLPmKQ5i2RxTwrQthWq/R0cQqowNt1Y8Kc06lSaZ+fYxG2xXYya96as4wcsc3PfV4nhrTLDJLuzIcPaiB6SvHsiPxkBuZEMLxfLUasu/m9TItY8m7Lpuuo/CUmQXOSfS7ukHyls7e

On Wed, 2 Jul 2025 15:43:08 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

>  From my perspective, making trace analysis results reliable is the most
> basic guarantee tooling should provide in order to make it trusted by
> users. So I am tempted to err towards robustness rather than take
> shortcuts because "it does not happen often".

Another solution which I'm thinking of doing for perf is to simply
state: a deferred stack trace does not go to any event before events
were dropped.

That is, even if the stack trace is associated, if events are dropped
before getting out of the kernel, just say, "Sorry, the events before
the dropped events lost its user stack trace".

That may better, as having no data is better than incorrect data.

-- Steve

