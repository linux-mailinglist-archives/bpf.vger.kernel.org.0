Return-Path: <bpf+bounces-70830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1972BBD5711
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F418A1ADA
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA62C0F95;
	Mon, 13 Oct 2025 17:18:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA232BE646;
	Mon, 13 Oct 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375925; cv=none; b=H/POI1duCwpfrrETTe0EvKrV4C245BjUTfEYj4tIUK+v11hWBsuCkKXpIofQue2e1U9jVQhBCNci6droeU25X8+QV0hSqOKD+9xVnHwEWv+hyp7V/3ESoauvW1ALiQ0Lj4IG2gc+HWzqmV4tYF9A2ffsFZ1PtdINHgxJRWfjF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375925; c=relaxed/simple;
	bh=X1ECpOFyAV6pxLT6cbqBwCY6elp/LHZ2ADubx8yLh4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHjMFa109XTJEpFan9QKZnRCok2kvuVPE9ArbNo3wKp5ZAMdqWQFa8uDwsv5Vu6lM5cyXV4Vz5Szh/upFasJ9/bbdwniuPrGHMKIi6OxPBSE/50BMTNxGz1aovcFf2pC33cQ16yqPgw+Hag+NJt7NC8wzBO75oU9gMHmTJP3J0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 4296246FAE;
	Mon, 13 Oct 2025 17:10:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 303662000E;
	Mon, 13 Oct 2025 17:10:52 +0000 (UTC)
Date: Mon, 13 Oct 2025 13:10:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrii
 Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <20251013131055.441e7d08@gandalf.local.home>
In-Reply-To: <aObSyt3qOnS_BMcy@krava>
References: <aObSyt3qOnS_BMcy@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 303662000E
X-Stat-Signature: 8qu63kcghfwuckzaq74dqyeyrbadaigg
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX190lcQLBqeloDwjMn9zAV8H8OE2YWhIsIM=
X-HE-Tag: 1760375452-483043
X-HE-Meta: U2FsdGVkX18DzcttsJhpL+KmwPnzciELiLfsCTYX0iLh50JPY1t3ubF+vvI3Pj+Z0155s4yIvbKzd3wbkReiI2WYMAP3kD4p/ObEXegkHKUVVHrBqOEDTnOcQpHelo0bBSGtKtRgyeJKn+ec6nFhqsP5xaRB/ntLKOY1ABEjkNmW0OLmOg9Bnr4DTTYiQCH+zkwmigjap6ertNurq2tAYDdYHWC5EzIbPKjvduhr6EaYNXQMhhIS971pOUc6v3UD+mxVZt2CzTIEdqnfkeQ2fF8iWFXQ/lP1Q8FuGed8Box+jLTayanrD5hOCk2fR8+ngQGXXgWVMwQX6AxzOUJiUOeR1U1GtO36KHCeFez8dxeMPJdwS7K+1w==

On Wed, 8 Oct 2025 23:08:26 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> hi,
> I'm getting no stacktrace from bpf program attached on kretprobe.multi probe
> (which means on top of return fprobe) on x86.
> 
> I think we need some kind of treatment we do for rethook, AFAICS the ORC unwind
> stops on return_to_handler, because the stack and the function itself are not
> adjusted for unwind_recover_ret_addr call

Hmm, we do have a way to retrieve the actual return caller from a location
for return_to_handler:

  See kernel/trace/fgraph.c: ftrace_graph_get_ret_stack()

Hmm, I think the x86 ORC unwinder needs to use this.

-- Steve


> 
> If it's any help I pushed the bpf/selftest for that in here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=stacktrace_test
> 
> just execute:
>   # test_progs -t stacktrace_map/kretprobe_multi
> 
> thanks,
> jirka


