Return-Path: <bpf+bounces-33110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10EC917508
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 01:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF72281820
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7804F17F37B;
	Tue, 25 Jun 2024 23:53:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C214A60C
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359629; cv=none; b=INc2bB03lCXt9hrJX0t2xd40qhMcK+DzvANf+2/gaOGSfn/svcT7TNZrdXF4wCsWbnSZlU58ngcbUlMtAE3xv7enVGCeQLOQqBaH3lSnftGOUO881mJllCtTbpbPYu8VQgE3cyMW53o2aypiPalXPFQ2HyMR0OBWVpjHwWt+4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359629; c=relaxed/simple;
	bh=iB5QRjtuQ6mJqsok61/OsRl1N7IKTq6JfkXxXQuyPxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oou9URi8DKcO6AabYq2/VxeDZc+5uxw7WNA8iTBwY9GZVklEQO8IfPJ2aiCcKc2bYhnOT2d6/dRRoh177B75JdZD+RKL6XjN3zkCNHmI/7YjV+I4+A2D4Tadxif2qKwE1mw52wGDRZc4CJ7ID18KOLGG5uj75Q8CC8gSv9MekrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45PNqiwG048799;
	Wed, 26 Jun 2024 08:52:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Wed, 26 Jun 2024 08:52:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45PNqhZ0048793
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Jun 2024 08:52:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
Date: Wed, 26 Jun 2024 08:52:44 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
 <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de>
 <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
 <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/26 4:32, Alexei Starovoitov wrote:
>>>>> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>>>>> syzbot is reporting circular locking dependency inside __bpf_prog_run(),
>>>>>> for fault injection calls printk() despite rq lock is already held.
> 
> If you want to add printk_deferred_enter() it
> probably should be in should_fail_ex(). Not here.
> We will not be wrapping all bpf progs this way.

should_fail_ex() is just an instance.
Three months ago you said "bpf never calls printk()" at
https://lkml.kernel.org/r/CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com ,
but bpf does indirectly call printk() due to debug functionality.

We will be able to stop wrapping with printk_deferred_enter() after the printk
rework completes ( https://lkml.kernel.org/r/ZXBCB2Gv1O-1-T6f@alley ). But we
can't predict how long we need to wait for all console drivers to get converted.

Until the printk rework completes, it is responsibility of the caller to guard
whatever possible printk() with rq lock already held. If you think that only
individual function that may call printk() (e.g. should_fail_ex()) should be
wrapped, just saying "We will not be wrapping all bpf progs this way" does not
help, for we need to scatter migrate_{disable,enable}() overhead as well as
printk_deferred_{enter,exit}() to individual function despite majority of callers
do not call e.g. should_fail_ex() with rq lock already held. Only who needs to
call e.g. should_fail_ex() with rq lock already held should pay the cost. In this
case, the one who should pay the cost is tracing hooks that are called with rq
lock already held. I don't think that it is reasonable to add overhead to all
users because tracing hooks might not be enabled or bpf program might not call
e.g. should_fail_ex().

If you have a method that we can predict whether e.g. should_fail_ex() is called,
you can wrap only bpf progs that call e.g. should_fail_ex(). But it is your role
to maintain list of functions that might trigger printk(). I think that you don't
want such burden (as well as all users don't want burden/overhead of adding
migrate_{disable,enable}() only for the sake of bpf subsystem).


