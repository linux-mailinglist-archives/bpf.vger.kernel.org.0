Return-Path: <bpf+bounces-41309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EDB995B95
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E00FB23F3D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C62185B9;
	Tue,  8 Oct 2024 23:22:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF821790D;
	Tue,  8 Oct 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429729; cv=none; b=f+P02G3H4OIS2WtuQ0U9k/0P/VwMg4vn8TOJxPwW0YLboR0WalpKN1mLGgAK0NLZrEitkuv+acJxZBTkX7+cuTkvsPlvDRrWU3U5E8DKnCIp4pCwIyXSy8G0ycs072fbhWwyh5Cktwb/hKlrfnqlZlmrjHTbvXHOsO5VTEMc8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429729; c=relaxed/simple;
	bh=M17y1x5HeRr4kMb7v+yysZWgKrhGPxIMYtLJSRBYAn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsA1hQlXnxionYmmCPgAMvqhNxoiEOp2VP5LFM2l3G1QX8jUFo/VmMbLxYcXPV2tsF4fRiEIhelgCGWAkjE8/9VvAK/XbhlQLh28SosoMAvte6gFtm2hf5n8atP0o1WxkPcAhdYZmwRl4+Co+9Uc5NYcY9suCKfADJLsz+2CV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E9BC4CEC7;
	Tue,  8 Oct 2024 23:22:07 +0000 (UTC)
Date: Tue, 8 Oct 2024 19:22:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>
Subject: Re: [PATCH v3 4/8] tracing/bpf: guard syscall probe with
 preempt_notrace
Message-ID: <20241008192210.6e15bf32@gandalf.local.home>
In-Reply-To: <20241004145818.1726671-5-mathieu.desnoyers@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
	<20241004145818.1726671-5-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 10:58:14 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> +#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)			\
> +static notrace void							\
> +__bpf_trace_##call(void *__data, proto)					\
> +{									\
> +	guard(preempt_notrace)();					\
> +	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
> +}
> +

Same here for using guard over just adding preempt_disable/enable_notrace().

-- Steve

