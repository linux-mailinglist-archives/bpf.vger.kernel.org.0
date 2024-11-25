Return-Path: <bpf+bounces-45560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C889D7A52
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 04:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8631F281A85
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 03:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5965F2207A;
	Mon, 25 Nov 2024 03:23:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D610F9;
	Mon, 25 Nov 2024 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732504980; cv=none; b=A3QrIde31hXAOlmwBMtyVopeOnsfevyi3e9aW+vPfC0e0+DOFJxWf6u19/MKzzi1u6EvSvXzN4X4YHOVWN5uoVdIYG46heWh5x9IGqcaQExTyLzK1Fmqu+CWfmuvCejWREwXxlk19R3oL3Ryoek6FdvkftPKZe/q09cVLameJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732504980; c=relaxed/simple;
	bh=9fRDbozviN/6Vsp+9XVM0S7ukIiU1g3LN0VTDbGakP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca913wSN2yDJRK1NC8nV4EZyVo6LhJT6Bzfzup9A36chlhWDytK97TPz2bmN9m8afcWoNobJvpL4p8jyIMfnia8Czut5Sns1svAm08ndGLzpX+E4Ic+uPVGe9Q9f3zAJeXZENSCYEece9eC63SLcF1RirG8RkOk8PtrNjhCfjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71547C4CECC;
	Mon, 25 Nov 2024 03:22:56 +0000 (UTC)
Date: Sun, 24 Nov 2024 22:22:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Michael
 Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from
 __DO_TRACE()
Message-ID: <20241124222254.22235538@rorschach.local.home>
In-Reply-To: <0ed11f00-d885-482a-8c82-37f9ffdb2968@efficios.com>
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
	<20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
	<CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
	<0ed11f00-d885-482a-8c82-37f9ffdb2968@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 20:50:12 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Steven, do you want me to update the series with this change or
> should I leave the scoped_guard() as is considering the ongoing
> testing in linux-next ? We can always keep this minor change
> (scoped_guard -> guard) for a follow up patch.

Yeah, just send a patch on top. I haven't pushed to linux-next yet
though, because I found that it conflicts with my rust pull request
and I'm testing the merge of the two at the moment.

-- Steve

