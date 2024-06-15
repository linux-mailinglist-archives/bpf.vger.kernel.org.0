Return-Path: <bpf+bounces-32226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C0909903
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 18:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBE7283110
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 16:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1152E62C;
	Sat, 15 Jun 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4TPJlGX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE269479;
	Sat, 15 Jun 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718468356; cv=none; b=QKwoPNYTBhbcREyj4j9N8eLLI+9SdhgVPz7Qre+i2wkm7r7jzbspBR5YhJ3YMkOZldMdaGDQJ4N63MuGO/CxZC/LlRGLL670SBe2aCwRcwQiLf0jJTY+vhUYJvWv8aM4dsz4HBrbZmDnQwdAX81XM0xG60lEn5hRhXgraBKYAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718468356; c=relaxed/simple;
	bh=CCQHT7qL3hTXSW7GsRCm5NhpUoN64iEeI1XErSqpBDY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Zbp/MG1wQ5Ef6xsHxHjaPC89BYRNtLdo0IxYeTY6yfMNHnwb2qT7IEqIJKdBzCHpUqKynHUT8VL2XdEKKQqxXPcCFuJ3PGUSDxt/wPhR3LCmY/RedqCJh0iZev6RaL4PcEfj176jtuCxMJBLpVP5CnvNQNxoZcK7E5Wja6fF4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4TPJlGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1920FC116B1;
	Sat, 15 Jun 2024 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718468356;
	bh=CCQHT7qL3hTXSW7GsRCm5NhpUoN64iEeI1XErSqpBDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4TPJlGXQ0D0gvdEqCgdd6lqPHItb/bWNzOJFGiFobFZsuUwmc6HV+Jk1/0B4bN2r
	 hgTfAOzgkcDjA8j0ZNTJae9bvZOffO/e46kgcJdsTTfbSrOMDtvMMskFPwrPTQO84H
	 lEqjvZybNNByanLsCW0lgQy8KANBowsllZ4GoLk3r9BL2ao/9xy6hvQFpi4Y4LExXk
	 5D4s/6STqJAJpEQwzcTF5QQkXlrjsElxRvvXDBDbjOLluL7Y0+j8dAcIgMtIVZHUEA
	 sZRrIOXMT3k03Pew78ggwF6s+l7QozjZGbUfqAjzryx56eWK2GPTBZg2VBmohCW+1e
	 E8hzfd+bXt6OQ==
Date: Sun, 16 Jun 2024 01:19:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] bpf/selftests: Fix __NR_uretprobe in uprobe_syscall
 test
Message-Id: <20240616011911.009492d917999c380320fd1b@kernel.org>
In-Reply-To: <20240616001920.0662473b0c3211e1dbd4b6f5@kernel.org>
References: <20240614101509.764664-1-jolsa@kernel.org>
	<20240616001920.0662473b0c3211e1dbd4b6f5@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Jun 2024 00:19:20 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 14 Jun 2024 12:15:09 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Fixing the __NR_uretprobe number in uprobe_syscall test,
> > because it changed due to merge conflict.
> > 
> 
> Ah, it is not enough, since Stephen's change is just a temporary fix on
> next tree. OK, Let me update it.

Hm, I thought I need to change all NR_uretprobe, but it makes NR_syscalls
list sparse. This may need to be solved on linus tree in merge window,
or I should merge (or rebase on) vfs-brauner tree before sending
probes/for-next.

Steve, do you have any idea? we talked about conflict on next tree[0].

[0] https://lore.kernel.org/all/20240613114243.2a50059b@canb.auug.org.au/

Thanks,

> 
> Thanks,
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index c8517c8f5313..bd8c75b620c2 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
> >  }
> >  
> >  #ifndef __NR_uretprobe
> > -#define __NR_uretprobe 463
> > +#define __NR_uretprobe 467
> >  #endif
> >  
> >  __naked unsigned long uretprobe_syscall_call_1(void)
> > -- 
> > 2.45.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

