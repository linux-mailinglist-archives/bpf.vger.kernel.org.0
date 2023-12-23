Return-Path: <bpf+bounces-18649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F00F81D4B0
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 15:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AD71F224FF
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7A6DF60;
	Sat, 23 Dec 2023 14:41:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775912E53;
	Sat, 23 Dec 2023 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3BNEfJRU010825;
	Sat, 23 Dec 2023 23:41:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sat, 23 Dec 2023 23:41:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3BNEfIsK010821
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 23 Dec 2023 23:41:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <57ee28a2-e626-4319-b3a3-cdca01499b13@I-love.SAKURA.ne.jp>
Date: Sat, 23 Dec 2023 23:41:17 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
Content-Language: en-US
To: Alfred Piccioni <alpic@google.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, bpf <bpf@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906102557.3432236-1-alpic@google.com>
 <20231219090909.2827497-1-alpic@google.com>
 <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding BPF.

On 2023/12/19 18:10, Alfred Piccioni wrote:
>> I didn't do an audit but does anything need to be updated for the BPF
>> LSM or does it auto-magically pick up new hooks?
> 
> I'm unsure. I looked through the BPF LSM and I can't see any way it's
> picking up the file_ioctl hook to begin with. It appears to me
> skimming through the code that it automagically picks it up, but I'm
> not willing to bet the kernel on it.

If BPF LSM silently picks up security_file_ioctl_compat() hook, I worry
that some existing BPF programs which check ioctl() using BPF LSM fail to
understand that such BPF programs need to be updated.

We basically don't care about out-of-tree kernel code. But does that rule
apply to BPF programs? Since BPF programs are out-of-tree, are BPF programs
which depend on BPF LSM considered as "we don't care about" rule?
Or is breakage of existing BPF programs considered as a regression?
(Note that this patch is CC:ed for stable kernels.)

Maybe BPF LSM should at least emit warning if the loaded BPF program defined
security_file_ioctl() hook and did not define security_file_ioctl_compat() hook?

We could use a struct where undefined hooks needs to be manually filled with
a dummy pointer, so that we can catch erroneously undefined hooks (detected by
being automatically filled with a NULL pointer) at load time?


