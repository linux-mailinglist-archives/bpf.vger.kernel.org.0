Return-Path: <bpf+bounces-33198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F4919B0C
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 01:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EADFB2110C
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6B71940A1;
	Wed, 26 Jun 2024 23:09:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FE17F500
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443389; cv=none; b=fB3TwMTlhs2dcbN1IFEMoTrlKvMevxXwSRoXAyR+A47xNm0+0SKSKDNbf7aHuH8Y7QpeEGHX4xEzrxWbHYgJ7yTa+fLd2l5HZbwhjdFyCRCvQqpcsgrkx9Qm1zMS5NKXG0hMwFMni4u8uRf7vXgei5EJDphCy3e2gUsoAZ5hauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443389; c=relaxed/simple;
	bh=78xo+efF4CZjagPQ5TJUPAB7R0czPzoOO772zThKsh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8Q03UZLVMmR7aekLRiACifS2kADNWt8A8kIrFpYNO1mE47SlHE0V3cpzeVX+ykDhwGTBODIhdPg32u3nvP8lNL6unTFvJVcNwxJYrYfb2bdYvZ4P5OPev//xVH4tELtYnPgv3UeA2vv5DeAKjJ7yyUgXX0z0t5a8IDZSpTYCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45QN8xnS021378;
	Thu, 27 Jun 2024 08:09:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Thu, 27 Jun 2024 08:08:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45QN8xaB021374
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Jun 2024 08:08:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6264da10-b6a0-40b8-ac26-c044b7f7529c@I-love.SAKURA.ne.jp>
Date: Thu, 27 Jun 2024 08:08:57 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
 <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de>
 <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
 <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
 <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
 <CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
 <744c9c43-9e4f-4069-9773-067036237bff@I-love.SAKURA.ne.jp>
 <20240626122748.065a903b@rorschach.local.home>
 <f6c23073-dc0d-4b3f-b37d-1edb82737b5b@I-love.SAKURA.ne.jp>
 <20240626183311.05eaf091@rorschach.local.home>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240626183311.05eaf091@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/27 7:33, Steven Rostedt wrote:
> So you are saying that because a BPF hook can attach to a tracepoint
> that is called with rq locks held, it should always disable preemption
> and call printk_deferred_enter(), because it *might* hit an error path
> that will call printk?? In other words, how the BPF hook is used
> determines if the rq lock is held or not when it is called.

Yes.

> 
> I can use that same argument for should_fail_ex(). Because how it is
> used determines if the rq lock is held or not when it is called. And it
> is the function that actually calls printk().

Strictly speaking, KASAN/KMSAN/KCSAN etc. *might* call printk() at any location.
In that aspect, just wrapping individual function that explicitly calls printk()
might not be sufficient. We will need to widen section for deferring printk(),
but we don't want to needlessly call migrate_disable()/preempt_disable()/
printk_deferred_enter() due to performance reason. We need to find a balanced
location for calling migrate_disable()/preempt_disable()/printk_deferred_enter().
I consider __bpf_prog_run() as a balanced location.

> 
> Sorry, but it makes no sense to put the burden of the
> printk_deferred_enter() on the BPF hook logic. It should sit solely
> with the code that actually calls printk().

How do you respond to Petr Mladek's comment

  Yeah, converting printk() into printk_deferred() or using
  printk_deferred_enter() around particular code paths is a whac-a-mole
  game.

at https://lkml.kernel.org/r/ZnvVQ5cs9F0b7paI@pathway.suse.cz ?


