Return-Path: <bpf+bounces-61435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F2AE70B7
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2409F16543A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790B2E610B;
	Tue, 24 Jun 2025 20:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F545226CF3;
	Tue, 24 Jun 2025 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797024; cv=none; b=jU7msMIuDDzUYAmi3quvohg4GnhKYVbb2G9EdA+WTPTLIMicYAAGKS0gCo97HGTswQH3TqN2/okXBdCZUWnRbOOiSb4/qTv4dZK+yK/d+Eph5VKFlzTeeBpk/C4wQRc7UiaoTlwk/rCTZAq9ZUAkTTCo8E/mZ07m8+H34FIeATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797024; c=relaxed/simple;
	bh=r0BGxRvGGazgNQl+Evi5LdgZpHgbLsYLLsHsiMw8HR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvPsb7g4GPq5KCuvTzpWpNBBPydqQ2NoFz1wBh/fQcZVbRxrdhCY+iuYUFf3vSOPgaEe55w2XSNMh93S8HiNaJH4l/griSqoeIzvR66DoPz497U0cWTeSYEtAKG4B2OwEXRZyIj8yFV4kmuzPxm4DarIVwZIIqMxnFGl6uRuqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4B034BEA0D;
	Tue, 24 Jun 2025 20:30:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 648A820025;
	Tue, 24 Jun 2025 20:30:14 +0000 (UTC)
Date: Tue, 24 Jun 2025 16:30:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 02/14] unwind_user: Add frame pointer support
Message-ID: <20250624163013.06c6c726@batman.local.home>
In-Reply-To: <6f1c21e9-ba0f-4262-8f56-962e0a7d6877@oracle.com>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.092934995@goodmis.org>
	<20250618135201.GM1613376@noisy.programming.kicks-ass.net>
	<20250618110915.754e604f@gandalf.local.home>
	<6f1c21e9-ba0f-4262-8f56-962e0a7d6877@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: htuzsruqx5b9qcc8c8nfrkzx7aru9asq
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 648A820025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX194JVDKxupSlk6ajjbciStKN2QFizai75w=
X-HE-Tag: 1750797014-895506
X-HE-Meta: U2FsdGVkX18kexM3alD+wmiOBkxPT6Y+hN8pFlEMejxx8x0Ua+KW5x7Z0iP2n8wxaDJuOYuHjGrR5J3M0X2cf4Xj5xHrSNAJvIByULlA3iJJu60Qx7aQDqrdwQWArXhbW0TLWMYVsBEPzgEnlv23JR9y6UNA6AGsOdd+IFt8hRK5jC9TsuDS21LV1OFEPnrqM1L1SOorGmSa1vnFPikWoUKKlajpNKFcVcAgbrQCjv8zWOWATDMtJwlHdPK25NX+lREmLuUnngA5mqpYMEabiO4I6cU0mAo1eyTvGu2aDLf5/ZJOZsz9+Y+Njz+LPbD3t32s3WuVHDr/JskgPIW67aRGf3CV2fmN

On Mon, 23 Jun 2025 09:31:17 -0700
Indu Bhagat <indu.bhagat@oracle.com> wrote:

> >> Also, CFA here is Call-Frame-Address and RA Return-Address ?  
> > 
> > I believe so. Do you want me to add a comment?
> >   
> 
> If a comment is added, Canonical Frame Address will be more appropriate.

Thanks Indu,

Updated.

-- Steve

