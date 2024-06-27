Return-Path: <bpf+bounces-33211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC0919BBA
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 02:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A0CB21146
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 00:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18FD6FC6;
	Thu, 27 Jun 2024 00:22:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E986AB9
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719447755; cv=none; b=tG8ASbLtW9RUnyhFwAV0WSC9+cBWbIjHOGsz/Cd1tdyRolxjgUCon2yzvtTIdzZE4AVpc9AnnTHEwBxfvQbISUVxHU+h52cgNWr5kOJLqDZZm7eV2ClAxlImMpsHl4tuIK4OLgcYPEHk5jlNoQDiOtH6s5gFXFTWJqNhm93JnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719447755; c=relaxed/simple;
	bh=BbklAlU+pIrGt91RZmhRhDoHreDax3IFF3UsG0UJDKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZNsq6SemmVSR8JChThudOTXZ+oouHjBuXghnUAgENSbT+0+ECcgFoNr3Au05dOYl6HzbFGth8FsrAtMHDVmbRvOdC+vrzXadPrx6oJyd8MrwMPnXdMKVvxww3+x/2PQK0Jvah3ca0rzTobsQuD2uyRSLPRxXXFE7Mu7jSWYJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45R0Lc71035807;
	Thu, 27 Jun 2024 09:21:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Thu, 27 Jun 2024 09:21:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45R0LcSQ035803
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Jun 2024 09:21:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <290aac9b-0664-404d-a457-292d69f9b22b@I-love.SAKURA.ne.jp>
Date: Thu, 27 Jun 2024 09:21:38 +0900
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
 <6264da10-b6a0-40b8-ac26-c044b7f7529c@I-love.SAKURA.ne.jp>
 <20240626200906.37326e17@rorschach.local.home>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240626200906.37326e17@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/27 9:09, Steven Rostedt wrote:
> On Thu, 27 Jun 2024 08:08:57 +0900
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
>> How do you respond to Petr Mladek's comment
>>
>>   Yeah, converting printk() into printk_deferred() or using
>>   printk_deferred_enter() around particular code paths is a whac-a-mole
>>   game.
>>
>> at https://lkml.kernel.org/r/ZnvVQ5cs9F0b7paI@pathway.suse.cz ?
> 
> I agree with that. And your solution is no different than whack-a-mole.
> It's just that you used a bigger hammer to wack the mole.

What change do you propose?

https://syzkaller.appspot.com/text?tag=Patch&x=121c92fe180000 ?


