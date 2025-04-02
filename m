Return-Path: <bpf+bounces-55160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA943A79099
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 16:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EBB3A71E7
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2E923AE7E;
	Wed,  2 Apr 2025 13:57:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51F367;
	Wed,  2 Apr 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602269; cv=none; b=LZilSmoST0qTzW6oIYO0CrimZkDlasrbpdcENATCiHL1NDixuxGMNFdcqBTRuoe3bL0hA0t3q3m702nlAuNxNMlIzSrbvmENbw7QAj9hRrtS1p44nUhzkayqMC1ElZ/4/eIJFHNe1qRi1Vuw/Dk9M8+xskCPTZDX+wIN2Xp4+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602269; c=relaxed/simple;
	bh=gw+yZ1EmcAbmQtjWuOkq30chzTyn1/moTvDIAjO11q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+awXa0qSoZgsFHPWJ6T5j7Q09f569kY1wrojRqqRyL83DNKLB9Dg16uFVb/pzpKHeFTnghWRYBVhQ8KJrT03dq2NFoyxKhI6IgqsW25F9hmyk14ZdOfvNK3fR8PpYFWqFXJ56rCFm9hOAxgd3afJvKzEX7mstTGfvSIOAt8kQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFEBC4CEDD;
	Wed,  2 Apr 2025 13:57:47 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:58:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, oleg@redhat.com,
 brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <20250402095850.1f617dd4@gandalf.local.home>
In-Reply-To: <Z-zlRSo6G1xWcd7I@tiehlicka>
References: <20250401184021.2591443-1-andrii@kernel.org>
	<20250401173249.42d43a28@gandalf.local.home>
	<CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com>
	<Z-zlRSo6G1xWcd7I@tiehlicka>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 09:20:37 +0200
Michal Hocko <mhocko@suse.com> wrote:

> Is it important to tell the difference between thread and the
> whole process group exiting?
> 
> Please keep in mind that even group exit doesn't really imply the mm is
> going away (clone allows CLONE_VM without CLONE_SIGNAL - i.e. mm could
> be shared outside of thread group).

The main reason I'm OK with just updating the sched_process_exit()
tracepoint is because it is in an arbitrary location. The process is
exiting, but because the tracepoint is basically in the middle of the
routine, it doesn't really give us any information about the actual exit.

This tracepoint does give us if a task is exiting from an mm. You are
correct, it doesn't tell us if the mm is going away. If that is the
purpose, then here should be a tracepoint in the exit_mm() code or perhaps
even in the mput() function.

-- Steve

