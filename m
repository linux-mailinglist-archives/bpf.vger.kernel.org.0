Return-Path: <bpf+bounces-76917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE20CC98D6
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC3F303A8E0
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183730E822;
	Wed, 17 Dec 2025 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lauv7OOo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE42D59FA;
	Wed, 17 Dec 2025 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005746; cv=none; b=IZhb6LubTGfi948LrmmQSU4WzeYOrCA/uc4u0PwmSugO5Od2HlkPn8JNCtd8YMNs/R4eORUjk9KFHVqc0moPzs9Mto+BrbkH3OhzATP5EBXtFPRbil7PA0pS0Ll++A2czo537wF+GTBqSIYTP21Ei/n0I1v3vEa9wHFJ3/de2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005746; c=relaxed/simple;
	bh=65Edc/sl8R/Lb3Alu4fznYKY0MERFWCt7PMOOQYnL3w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NDcFS0NCkT8Pi2A9idG/MsY0WyKjiH0POz8PlEhNlzyDVVJ4myeKAqNCUodxceAMAnvGXalcT1g8neHsmed1LmcVOwDSnW78tmSIY9iBQv1lCXSuwZ3b482esUpU4A6k/tkcUPXlaWbt14VrqWKFumcQ/de3AM3rrVrdhv2A7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lauv7OOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC81CC4CEF5;
	Wed, 17 Dec 2025 21:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766005745;
	bh=65Edc/sl8R/Lb3Alu4fznYKY0MERFWCt7PMOOQYnL3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lauv7OOoYevEd1rSt8yWk4PF8KdSzAIVORjTyixleLDjd1LnWua5S+CugVbWdvnZL
	 xnTFjT3eK7q2mCZp3ETdjO+TvNkzOoASnVsgP6Ln8vouCY9QPftgIGURn+MznGj8Lc
	 PXH43Olo/9yaiEmnVrREb9TGrED4PXDo9R8+0vrA=
Date: Wed, 17 Dec 2025 13:09:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, Aaron
 Tomlin <atomlin@atomlin.com>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kallsyms: Prevent invalid access when showing
 module buildid
Message-Id: <20251217130904.33163c243172324a5308efe9@linux-foundation.org>
In-Reply-To: <20251128135920.217303-1-pmladek@suse.com>
References: <20251128135920.217303-1-pmladek@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 14:59:13 +0100 Petr Mladek <pmladek@suse.com> wrote:

> This patchset is cleaning up kallsyms code related to module buildid.
> It is fixing an invalid access when printing backtraces, see [v1] for
> more details:
> 
> ...
>
> [v1] https://lore.kernel.org/r/20251105142319.1139183-1-pmladek@suse.com
> [v2] https://lore.kernel.org/r/20251112142003.182062-1-pmladek@suse.com
> 

It's best to avoid sending people off to the WWW to understand a
patchset - better that the git history be self-contained.  So when
staging this for mm.git I scooped the relevant material from [1] and
added it to your cover letter, as below.  Looks OK?


From: Petr Mladek <pmladek@suse.com>
Subject: kallsyms: clean up @namebuf initialization in kallsyms_lookup_buildid()
Date: Fri, 28 Nov 2025 14:59:14 +0100

Patch series "kallsyms: Prevent invalid access when showing module
buildid", v3.

We have seen nested crashes in __sprint_symbol(), see below.  They seem to
be caused by an invalid pointer to "buildid".  This patchset cleans up
kallsyms code related to module buildid and fixes this invalid access when
printing backtraces.

I made an audit of __sprint_symbol() and found several situations
when the buildid might be wrong:

  + bpf_address_lookup() does not set @modbuildid

  + ftrace_mod_address_lookup() does not set @modbuildid

  + __sprint_symbol() does not take rcu_read_lock and
    the related struct module might get removed before
    mod->build_id is printed.

This patchset solves these problems:

  + 1st, 2nd patches are preparatory
  + 3rd, 4th, 6th patches fix the above problems
  + 5th patch cleans up a suspicious initialization code.

This is the backtrace, we have seen. But it is not really important.
The problems fixed by the patchset are obvious:

  crash64> bt [62/2029]
  PID: 136151 TASK: ffff9f6c981d4000 CPU: 367 COMMAND: "btrfs"
  #0 [ffffbdb687635c28] machine_kexec at ffffffffb4c845b3
  #1 [ffffbdb687635c80] __crash_kexec at ffffffffb4d86a6a
  #2 [ffffbdb687635d08] hex_string at ffffffffb51b3b61
  #3 [ffffbdb687635d40] crash_kexec at ffffffffb4d87964
  #4 [ffffbdb687635d50] oops_end at ffffffffb4c41fc8
  #5 [ffffbdb687635d70] do_trap at ffffffffb4c3e49a
  #6 [ffffbdb687635db8] do_error_trap at ffffffffb4c3e6a4
  #7 [ffffbdb687635df8] exc_stack_segment at ffffffffb5666b33
  #8 [ffffbdb687635e20] asm_exc_stack_segment at ffffffffb5800cf9
  ...


This patch (of 7)

The function kallsyms_lookup_buildid() initializes the given @namebuf by
clearing the first and the last byte.  It is not clear why.

The 1st byte makes sense because some callers ignore the return code and
expect that the buffer contains a valid string, for example:

  - function_stat_show()
    - kallsyms_lookup()
      - kallsyms_lookup_buildid()

The initialization of the last byte does not make much sense because it
can later be overwritten.  Fortunately, it seems that all called functions
behave correctly:

  -  kallsyms_expand_symbol() explicitly adds the trailing '\0'
     at the end of the function.

  - All *__address_lookup() functions either use the safe strscpy()
    or they do not touch the buffer at all.

Document the reason for clearing the first byte.  And remove the useless
initialization of the last byte.

Link: https://lkml.kernel.org/r/20251128135920.217303-2-pmladek@suse.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkman <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Marc Rutland <mark.rutland@arm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/kallsyms.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/kallsyms.c~kallsyms-clean-up-namebuf-initialization-in-kallsyms_lookup_buildid
+++ a/kernel/kallsyms.c
@@ -355,7 +355,12 @@ static int kallsyms_lookup_buildid(unsig
 {
 	int ret;
 
-	namebuf[KSYM_NAME_LEN - 1] = 0;
+	/*
+	 * kallsyms_lookus() returns pointer to namebuf on success and
+	 * NULL on error. But some callers ignore the return value.
+	 * Instead they expect @namebuf filled either with valid
+	 * or empty string.
+	 */
 	namebuf[0] = 0;
 
 	if (is_ksym_addr(addr)) {
_


