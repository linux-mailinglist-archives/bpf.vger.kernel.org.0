Return-Path: <bpf+bounces-11278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDBC7B6B0E
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A5C96281830
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76430F8F;
	Tue,  3 Oct 2023 14:07:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426B1548D
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 14:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F8DC433C7;
	Tue,  3 Oct 2023 14:07:49 +0000 (UTC)
Date: Tue, 3 Oct 2023 10:08:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints
 (v3)
Message-ID: <20231003100854.7285d2a9@gandalf.local.home>
In-Reply-To: <5d0771e9-332c-42cd-acf3-53d46bb691f3@paulmck-laptop>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
	<20231002202531.3160-2-mathieu.desnoyers@efficios.com>
	<20231002191023.6175294d@gandalf.local.home>
	<97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
	<20231002211936.5948253e@gandalf.local.home>
	<5d0771e9-332c-42cd-acf3-53d46bb691f3@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 06:44:50 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > That way it is clear what uses what, as I read the original paragraph a
> > couple of times and could have sworn that rcu_read_lock_trace() required
> > tasks to not block.  
> 
> That would work for me.  Would you like to send a patch, or would you
> rather we made the adjustments?

Which ever.

-- Steve

