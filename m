Return-Path: <bpf+bounces-26129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A886289B524
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 03:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FAB281446
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88FEBB;
	Mon,  8 Apr 2024 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiR9iJNZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463915A8;
	Mon,  8 Apr 2024 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538811; cv=none; b=YsTg0DiIDjzlodRpBlWgMw4SxP+VEuJ4rBJ4pCN5/Ak5lARju2+fXciutDYrHT/obM2zWe8vStPW0c5xiRa9Hejs4aPdaXg0xOIyClvMlLkTrlQwgseoVrrLE6aQDUJokyRzm9haJdFMdALF/5aAv8DeRuZO5yyof2IiJkLMhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538811; c=relaxed/simple;
	bh=VD/qYrsfbh/pUkYe6JhlzTgZknAD7e9ybrZ34O9LYiM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g8zldsVZkiIJmXElRQy68dprwO0coLp26lLautugA2C9j4wNjgc+wUHtDORmuL7wV3PDtfphNMezBKEkeD7l9cFJCJYxyRHvFYt43mRCDXNuzDdISe2xvSL4UM2P8GOKiXYgawnU7u1mzTcI4I9WwjPOUwZu8P/zg32BBIT3mVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiR9iJNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70943C433C7;
	Mon,  8 Apr 2024 01:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712538810;
	bh=VD/qYrsfbh/pUkYe6JhlzTgZknAD7e9ybrZ34O9LYiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uiR9iJNZXNHlKR0UA2r3nq3UlSNcOCA3WjfWqIQrQZRN+O1+lqdFKMGBUk1xquJVG
	 N/733YhCvOoj4+rbrfdaa9DZ/GAByrI+Uq7M2SL3PPDjnFIR7g8GtzHh7SuTQLTi16
	 tCYA1LgOvXHwszfbPdHAgjeCVvrN4sUS5rCHcn/II9F9edxwI9WNn8vGmhhvPENiIW
	 OTYMwYx7HHtfZRsxRKmP239hy457Z1VQ7OQaKuQrigb3z3N38Hx53c4l5K2MH6y3pG
	 nv0aI3VOPDbIFxUVRW2RAlRVVJRDdhALEn2hidT8lJlk2PlpW7it/OHD+eiM7Gr4Xi
	 vOlI+iUe7EEkA==
Date: Mon, 8 Apr 2024 10:13:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, mhiramat@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, andrii@kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next] rethook: Remove warning messages printed for
 finding return address of a frame.
Message-Id: <20240408101326.2392a79de4bfe1e677faeff0@kernel.org>
In-Reply-To: <1bbd6200-bb06-f8d2-c22a-39245425b6b1@iogearbox.net>
References: <20240401191621.758056-1-thinker.li@gmail.com>
	<CAEf4BzbbneDHp=sD4+5RmuK=U9vg8Uo_M6XEXdKWrZ_MkjFocw@mail.gmail.com>
	<1bbd6200-bb06-f8d2-c22a-39245425b6b1@iogearbox.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Apr 2024 16:36:25 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> On 4/2/24 6:58 PM, Andrii Nakryiko wrote:
> > On Mon, Apr 1, 2024 at 12:16 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
> >>
> >> rethook_find_ret_addr() prints a warning message and returns 0 when the
> >> target task is running and not the "current" task to prevent returning an
> >> incorrect return address. However, this check is incomplete as the target
> >> task can still transition to the running state when finding the return
> >> address, although it is safe with RCU.

Could you tell me more about this last part? This change just remove
WARN_ON_ONCE() which warns that the user tries to unwind stack of a running
task. This means the task can change the stack in parallel if the task is
running on other CPU.
Does the BPF stop the task? or do you have any RCU magic to copy the stack?

> >>
> >> The issue we encounter is that the kernel frequently prints warning
> >> messages when BPF profiling programs call to bpf_get_task_stack() on
> >> running tasks.

Hmm, WARN_ON_ONCE should print it once, not frequently.

> >>
> >> The callers should be aware and willing to take the risk of receiving an
> >> incorrect return address from a task that is currently running other than
> >> the "current" one. A warning is not needed here as the callers are intent
> >> on it.
> >>
> >> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >> ---
> >>   kernel/trace/rethook.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> >> index fa03094e9e69..4297a132a7ae 100644
> >> --- a/kernel/trace/rethook.c
> >> +++ b/kernel/trace/rethook.c
> >> @@ -248,7 +248,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
> >>          if (WARN_ON_ONCE(!cur))
> >>                  return 0;
> >>
> >> -       if (WARN_ON_ONCE(tsk != current && task_is_running(tsk)))
> >> +       if (tsk != current && task_is_running(tsk))
> >>                  return 0;
> >>
> > 
> > This should probably go through Masami's tree, but the change makes
> > sense to me, given this is an expected condition.
> > 
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Masami, I assume you'll pick this up?

OK, anyway it will just return 0 if this situation happens, and caller will
get the trampoline address instead of correct return address in this case.
I think it does not do any unsafe things. So I agree removing it.
But I think the explanation is a bit confusing.

Thank you,

> 
> Thanks,
> Daniel


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

