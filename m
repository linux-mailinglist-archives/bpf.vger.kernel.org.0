Return-Path: <bpf+bounces-33174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A00E918754
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 18:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35758281805
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 16:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6E18F2C1;
	Wed, 26 Jun 2024 16:27:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720418E748;
	Wed, 26 Jun 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419272; cv=none; b=aZKJdtyvsyV58reVrai/Q3pPC0lS1POKR+RT3k8KKtbLTr+O2cOOL3kNFQjEKN4fpWvqstF0+TXxawW/656AwRIWBBz3kji6whhYveomH2hfLX4nyJ6IkRcrp/hbHjcAM49iAgZISu4n4/CyCpJ3dLC56LU58PLfVb+uskzPxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419272; c=relaxed/simple;
	bh=roiUtnPs1fbsAbMpylIIpg5rUzTkeD36yCWtzy3qV58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLWLXm6Muo8PCO9NcyZwM0y9TGuRwaqYMolzcNwLVfTlEFShf8m23xQF6vsPj79sq8CvaEyvIFZ7vj2IdT2sdI7SR9BlyTZI8LK8boLT0AGNQ4C/4GBd+qcWKSydizTM6SQxFd4iu1kN/Uh+Mc8hu5QzcICgAyytrnxBUV7TS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FFFC116B1;
	Wed, 26 Jun 2024 16:27:49 +0000 (UTC)
Date: Wed, 26 Jun 2024 12:27:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, John Ogness
 <john.ogness@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
Message-ID: <20240626122748.065a903b@rorschach.local.home>
In-Reply-To: <744c9c43-9e4f-4069-9773-067036237bff@I-love.SAKURA.ne.jp>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
	<87ed8lxg1c.fsf@jogness.linutronix.de>
	<60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
	<87ikxxxbwd.fsf@jogness.linutronix.de>
	<ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
	<CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
	<7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
	<CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
	<744c9c43-9e4f-4069-9773-067036237bff@I-love.SAKURA.ne.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 09:02:22 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> On 2024/06/26 8:56, Alexei Starovoitov wrote:
> > You are missing the point. The bug has nothing to do with bpf.  
> 
> The bug is caused by calling tracing hooks with rq lock held.
> If tracing hooks do not exist, this bug does not exist.

Could you expand on this. What tracing hooks are called with rq lock
held? You mean the scheduling events?

> 
> > It can happen without any bpf loaded. Exactly the same way.
> > should_fail_usercopy() is called on all user accesses.  
> 
> Not all callers of e.g. should_fail_usercopy() are holding rq lock.

Sorry, but if a function is going to call printk and can be called in
any context that has rq locks held, then it should be doing the printk
deferred and preempt disable logic, and not expect the caller of it to
do that dirty work. Otherwise this will expand out of control.

The same goes with calling spin_lock_irq() vs spin_lock_irqsave(). If a
function is called with interrupts disabled sometimes and sometimes
not, it needs the irqsave() version. We don't make all callers of it
disable interrupts.

-- Steve

