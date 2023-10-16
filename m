Return-Path: <bpf+bounces-12308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2641B7CAE38
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61CF281794
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2742E64C;
	Mon, 16 Oct 2023 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52792B779;
	Mon, 16 Oct 2023 15:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06237C433C7;
	Mon, 16 Oct 2023 15:52:07 +0000 (UTC)
Date: Mon, 16 Oct 2023 11:53:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in
 struct syscall_tp_t
Message-ID: <20231016115342.30b3d357@gandalf.local.home>
In-Reply-To: <CAEf4Bza0ma+oRHYkHfQwmLPzJobRpq6-u2gog_uMNAHs0-KYiQ@mail.gmail.com>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
	<20231012114550.152846-1-asavkov@redhat.com>
	<20231012094444.0967fa79@gandalf.local.home>
	<CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
	<ZSjdPqQiPdqa-UTs@wtfbox.lan>
	<20231013100023.5b0943ec@rorschach.local.home>
	<CAEf4Bza0ma+oRHYkHfQwmLPzJobRpq6-u2gog_uMNAHs0-KYiQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 12:43:18 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:


> > Correct. My Ack is based on the current way things are done upstream.
> > It was just that linux-rt showed the issue, where the code was not as
> > robust as it should have been. To me this was a correctness issue, not
> > an issue that had to do with how things are done in linux-rt.  
> 
> I think we should at least add some BUILD_BUG_ON() that validates
> offsets in syscall_tp_t matches the ones in syscall_trace_enter and
> syscall_trace_exit, to fail more loudly if there is any mismatch in
> the future. WDYT?

If you want to, feel free to send a patch.

> 
> >
> > As for the changes in linux-rt, they are not upstream yet. I'll have my
> > comments on that code when that happens.  
> 
> Ah, ok, cool. I'd appreciate you cc'ing bpf@vger.kernel.org in that
> discussion, thank you!

If I remember ;-)

-- Steve

