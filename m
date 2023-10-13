Return-Path: <bpf+bounces-12142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404097C8746
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DEB1C21207
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8044618E18;
	Fri, 13 Oct 2023 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929B15E94;
	Fri, 13 Oct 2023 14:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004EC433C7;
	Fri, 13 Oct 2023 14:00:25 +0000 (UTC)
Date: Fri, 13 Oct 2023 10:00:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Artem Savkov <asavkov@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in
 struct syscall_tp_t
Message-ID: <20231013100023.5b0943ec@rorschach.local.home>
In-Reply-To: <ZSjdPqQiPdqa-UTs@wtfbox.lan>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
	<20231012114550.152846-1-asavkov@redhat.com>
	<20231012094444.0967fa79@gandalf.local.home>
	<CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
	<ZSjdPqQiPdqa-UTs@wtfbox.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 08:01:34 +0200
Artem Savkov <asavkov@redhat.com> wrote:

> > But looking at [0] and briefly reading some of the discussions you,
> > Steven, had. I'm just wondering if it would be best to avoid
> > increasing struct trace_entry altogether? It seems like preempt_count
> > is actually a 4-bit field in trace context, so it doesn't seem like we
> > really need to allocate an entire byte for both preempt_count and
> > preempt_lazy_count. Why can't we just combine them and not waste 8
> > extra bytes for each trace event in a ring buffer?
> > 
> >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=b1773eac3f29cbdcdfd16e0339f1a164066e9f71  
> 
> I agree that avoiding increase in struct trace_entry size would be very
> desirable, but I have no knowledge whether rt developers had reasons to
> do it like this.
> 
> Nevertheless I think the issue with verifier running against a wrong
> struct still needs to be addressed.

Correct. My Ack is based on the current way things are done upstream.
It was just that linux-rt showed the issue, where the code was not as
robust as it should have been. To me this was a correctness issue, not
an issue that had to do with how things are done in linux-rt.

As for the changes in linux-rt, they are not upstream yet. I'll have my
comments on that code when that happens.

-- Steve

