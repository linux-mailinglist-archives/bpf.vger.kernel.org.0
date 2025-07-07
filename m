Return-Path: <bpf+bounces-62554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5EAFBBE4
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A7F16D1DF
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3A2673AF;
	Mon,  7 Jul 2025 19:50:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BA13A244;
	Mon,  7 Jul 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917799; cv=none; b=W3dvxY2sp6NlG+tpkHES+6IGpaPw23L/EDXN0Mtl5zC/lk/Lu9xjO8BfgdJCoXMx2t3PVhPCzeq3pD56WVGHLTZ7dYi6stRHMN7/zdJfXBvMo/LyujHarghrsFiRKjmthIWX6OzvSloVcwcVXw1WY0DNjk++iz4s+qghn94Cozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917799; c=relaxed/simple;
	bh=C/pxVwNNcO2P81TrbKVfUEX/hAn4awsUloccI8+e050=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUvt+kXLC4/1edT6/biAkjXSbvrSJ7jSfhI4opxOiFfCVwH/xXoMe89DJUcYgEUgfvIXhGJOrkpcetMGBpZ8iu+thjDF9H/bgaR5JkEEy/g5UeJFVZLPabTHF9CLvUAmxaHV4wA6ZBjHyd9UlIQs7KblYRJc7wIauYH5iD9BSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id BBABA128655;
	Mon,  7 Jul 2025 19:42:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 5AB922000E;
	Mon,  7 Jul 2025 19:42:46 +0000 (UTC)
Date: Mon, 7 Jul 2025 15:42:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>
Subject: Re: [PATCH v12 01/14] unwind_user: Add user space unwinding API
Message-ID: <20250707154245.7eeeb448@batman.local.home>
In-Reply-To: <12c620ea-4bee-4019-8143-8ecbaeeafc11@efficios.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005450.721228270@goodmis.org>
	<12c620ea-4bee-4019-8143-8ecbaeeafc11@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uffcqguk36b5rtzjb97yrcmziuh1i78n
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5AB922000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+hZRXtt2n9xM25ZjI5RbURs4uzubwh+r8=
X-HE-Tag: 1751917366-491360
X-HE-Meta: U2FsdGVkX1+TlfiLJboUxWFVhq/aBl2bQgU922t12rSyi1JWsFcrAHFLerzbTnq0xq41SHga/xi2kKB4hiRLNrK7Sr/df8bn4Ok62X/V3VK/V3SswAQzMX9VCDljJDlt7APU+uY5E1je+9lfT+EYlIA4gPiazZCNjkMqgqs0aHjqNHR9km2DNUlKiZna5qWTOEtyUxQ2vMYb86+abAM+c1AsOtBnALmMrkH0DfjCFVvUMNArbVac5C55LarMjElCob+NOedjbvXxRkqbN3v6NiL2gdG8qQWXdxCGbT6cDbbjTcUvnFsDoSCTTgP+Cp9IUDWchw8XOXUjEDadYhZZbyb72eQ9VbN+QrFcopOe0qhoKDnLwNsyka8qd3KG6kFL

On Fri, 4 Jul 2025 14:20:54 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > None of the structures introduced will be exposed to user space tooling.  
> 
> Would it be possible to make those unwind APIs EXPORT_SYMBOL_GPL
> so they are available for GPL kernel modules ?

I'm OK with that, but others tend to complain about EXPORT_SYMBOL_GPL
for functions not used by modules in the kernel. But I personally feel
that LTTng should get an exception for that rule ;-)

-- Steve

