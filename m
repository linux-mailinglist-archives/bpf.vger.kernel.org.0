Return-Path: <bpf+bounces-41313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE9E995BB3
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105EB1F25791
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2E521791F;
	Tue,  8 Oct 2024 23:33:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045A13C9DE;
	Tue,  8 Oct 2024 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430405; cv=none; b=u+RPICdkq8+gkYseKrvMFs56k/pleVhYs911dR7UVoaAfGCLciOPwcWiNe87kwOT9U9g8YqlZRbth+fgLqmh44A+qCV5NikDmoc61+SdhHN7uZ1Bq1aOwx5L9h87huwG207xIPbl5RnOJNfIKjDNMkA1p7IWTXSOq/LeFlh7KIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430405; c=relaxed/simple;
	bh=dKVDfFAr0b0MtvkBJcDzwoo6jTmZ7IoYhnfqUJiQ+BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4HkoPsivlzMgcyGSMfz87G8zdPeRAw+n3nfw8RnpyNFu/UwK97TKh2kpb3P5G59bPo+Pj0lWd6j2q8hWBExWtO8aC/Ty9+vf+CeqrbTUjqtnVdXkxZTQDZAyUw+yiIt5kXsgYDuikrSKz9tfiiOkVg0X0thfpcCNZGIHEkzB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575A0C4CEC7;
	Tue,  8 Oct 2024 23:33:23 +0000 (UTC)
Date: Tue, 8 Oct 2024 19:33:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] tracing: Allow system call tracepoints to handle
 page faults
Message-ID: <20241008193326.5ec7fb10@gandalf.local.home>
In-Reply-To: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 10:58:10 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Wire up the system call tracepoints with Tasks Trace RCU to allow
> the ftrace, perf, and eBPF tracers to handle page faults.

Hi Mathieu,

Looks good besides the little nits I mentioned.

Could you fix them up and rebase on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

  branch: trace/core

The biggest difference is that I added Josh's patch to not use the obsolete
static_key_false() anymore. I fixed up your patch before applying it by
basically just doing a:

  s/static_key_false/static_branch_unlikely/

And then removing the extra tabs at the end. That allowed it to apply
without more tweaks.

If you can send a v4 with those updates, I'll apply it and start testing it.

-- Steve

