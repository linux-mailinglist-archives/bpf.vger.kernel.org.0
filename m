Return-Path: <bpf+bounces-61993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A7AF03B5
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C62467A5D3D
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD37F283FCC;
	Tue,  1 Jul 2025 19:24:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731341D07BA;
	Tue,  1 Jul 2025 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397861; cv=none; b=ALP4dV2yMsKINlTttT9gmBYgifJ0Q+qWaup80lW58/c2WCt2iTp+CQ1MzYTqoPVHWDxcZQNLiD1JOTnaApiEtfnEWpBTGTA3ZP67ZZLvAHVZqmp6mXnnN/UnPPvsc8zh3qIBiS503LEQpoKaC9LZqY8cqeiG/oCpf+YIVeq3qew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397861; c=relaxed/simple;
	bh=bbsyQ/dzCNhDdQNt8tsoVa3EfNwDRY37udY0mb8ftvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKm56g1oIUWIkytUntJ5bV2iUiUzknGUI6rmBuRRGdBBHDkIdBw8lX3g0SDM0Ya+MczAXwoZvWcJbPhIDZFdlAPJ8FIxELMKr7mEQPL72OfsvIIDn+0hlqgAhLUPezHVcY/eDSkzVYjmCfCGsiX7pWGt2RjKbLhByiGAF9T62KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 82B7059E61;
	Tue,  1 Jul 2025 19:24:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 13F9120013;
	Tue,  1 Jul 2025 19:24:11 +0000 (UTC)
Date: Tue, 1 Jul 2025 15:24:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, helpdesk@kernel.org
Subject: Re: [PATCH v12 00/11] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250701152449.56c35b8b@gandalf.local.home>
In-Reply-To: <20250701151715.5eb5f8b9@batman.local.home>
References: <20250701180410.755491417@goodmis.org>
	<20250701151715.5eb5f8b9@batman.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 13F9120013
X-Rspamd-Server: rspamout02
X-Stat-Signature: f16epqm7ayjc4nchsiamsnphki9thd7q
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18z9Wt4Xp5tX4kB0WUnKWDnmPRT5fe3b08=
X-HE-Tag: 1751397851-344992
X-HE-Meta: U2FsdGVkX1+NwsUdo3DnvQwvY56yivMEdkcFC19wS01JYX5B6+rBXkacYKW9WTD1whQRVQ2rZb6ZpO8e4ajNARyQNGio91RFmLEPhKx7g1yhMaryC03pFv1kCEWlo6tD00syhZewPQaBw5SEhRJ5x4uV3yIjgkSn/Do5+HG0SqDbgl4RL2EtYe14Ndd0ZSqDAUiVjEg15Rqx9C5HW1SHloHkw0Kfo3QqKU8ZJWSazhriFcO2q5/4wxekSOrh5reCFmG5MGAFh2ZLjeMuk7OLFx1IwvXrHp1aafK+noDohwfW6UpXuvjxYTDqRQhHY9hq06ywwBc8r06XbNtd/zlkiLdiMCCUuCEwHzS/5/JSCE8vm2GP8Sd/zIAuBGJyfMTx

On Tue, 1 Jul 2025 15:17:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, patches 5-11 seemed to be dropped, and I sent out 12 patches of
> the latest sframe work that I can't find anywhere. I think my ISP is
> thinking I'm spamming so it dropped the emails. That's all I can figure.

Hah! After I write this, my patches start showing up! :-p

OK, no resend.

-- Steve

