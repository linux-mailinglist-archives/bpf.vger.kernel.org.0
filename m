Return-Path: <bpf+bounces-61042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06EFAE0002
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075523B96E3
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CB26460D;
	Thu, 19 Jun 2025 08:39:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC259CAB;
	Thu, 19 Jun 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322348; cv=none; b=XQfSTTTQJzmYbSLyU8lE5phXoaJe2kfL0hUaZwATI2U1xfW4Mkmyq4OAAgCzi7pHl5HvGkxqCSj3kljl8dUiJidgUukQLYI/uFH+mD8yuyx+eIa0p9v7JHfyokiqDfB+w98SbdB53YXc5VO2uIuZsheOT7d2QpsAW+IJiVOixe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322348; c=relaxed/simple;
	bh=3Huv7ZPDqkEecfnLz3oTSOVlSGhouvQtnTutmfxhBuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW2XzTT9LY+H9YMxkzXre3OdSU21GGutPafNVr5Cv0EYbV6MiY8OIJjtECp7Fnf/o23O2Ui5bTNT1CXv74tsWh96YKhC5XXGQy3EamSGjUFQVrbAREMgg65wk1GpB6R2wiTbL1CJQ3djXSmFmm3Uug+rZowPXiTmTF44Jvory5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A7FE080688;
	Thu, 19 Jun 2025 08:39:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id E66A720028;
	Thu, 19 Jun 2025 08:38:59 +0000 (UTC)
Date: Thu, 19 Jun 2025 04:39:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer
 support
Message-ID: <20250619043905.151d7f63@batman.local.home>
In-Reply-To: <20250619075103.GV1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.261095906@goodmis.org>
	<20250618134758.GK1613376@noisy.programming.kicks-ass.net>
	<20250618111840.24a940f6@gandalf.local.home>
	<20250619075103.GV1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fb9zfdjrcr1djziti1opsxbup7bunpp6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E66A720028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+m7jQXYGP7iliC8RTJexUJZkESXpNRGiw=
X-HE-Tag: 1750322339-171143
X-HE-Meta: U2FsdGVkX1+WUuekhZmNCRTsM6ZfRq8DEQqOHEcVlEKwwjPLNFYw8ANaBzM3AdW9iJoHWvIbuXUSeerxBPiTPkSCu9cdZtSq8BD0VbDJOJhWoaRwMN0Z0gRMRM5YyARVhzWthTunsGQf+f2/x73QWWLztxQW+3CcDXN8tD79SGAmxQEqAgLiv6fIaqA7TRIWOLvHStT00dANm/chZlbLZkBIuZxJvTj1XuB0km4rtYQpKOT8ulWPoxFvbC2Y7ZTFnTaVzQbyJlj/hWjWJPPBh0tyNyL9B08TWUPwOnMw54pLLYapjDqy0SGax97sJt7WB/0GG5fOzuiie2Na7k7lguco2qj4ALrAUrCT3x59BcIezHQxyWftQ6KEcd51n2cUWFYLPPxWXC0zCHhwlwCmy1vbQ3VOP9lYdq6x0GR8pig=

On Thu, 19 Jun 2025 09:51:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > 
> > > The purpose of these arch hooks is so far mysterious. No comments, no
> > > changelog, no nothing.  
> > 
> > I'll add comments.  
> 
> How about you introduce the hooks when they're actually needed instead?

OK. Then I'll move the hooks to the later patch.

-- Steve

