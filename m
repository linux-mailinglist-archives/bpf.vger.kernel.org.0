Return-Path: <bpf+bounces-18644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC881D3B7
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 12:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466A7B22D55
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D68F7E;
	Sat, 23 Dec 2023 11:15:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969A8F75
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3BNBFSTP051661
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 20:15:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sat, 23 Dec 2023 20:15:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3BNBFSBK051657
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 20:15:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f53342c8-ac93-46ab-afd3-a72ffeaca617@I-love.SAKURA.ne.jp>
Date: Sat, 23 Dec 2023 20:15:28 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH] security: new security_file_ioctl_compat() hook
References: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
X-Forwarded-Message-Id: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Does anything need to be updated for the BPF LSM or
does it auto-magically pick up new hooks?

-------- Forwarded Message --------
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
In-Reply-To: <20231219090909.2827497-1-alpic@google.com>
From: Alfred Piccioni <alpic@google.com>
Date: Tue, 19 Dec 2023 10:10:38 +0100
Message-ID: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks for taking the time to review! Apologies for the number of
small mistakes.

> s/syscal/syscall/
> Might to consider checking using codespell to catch such things
> although it is imperfect.

Fixed, loaded codespell.

> Paul doesn't like C++-style comments so rewrite using kernel coding
> style for multi-line comments or drop.
> I don't think kernel coding style strictly prohibits use for
> single-line comments and it isn't detected by checkpatch.pl but he has
> previously
> raised this on other patches. I actually like the C++-style comments
> for one-liners especially for comments at the end of a line of code
> but Paul is the maintainer so he gets the final word.

Changed to /**/ style comments. No particular preference on my side
for comment structure, just used to C++/Java style.

> Sorry, missed this the first time but cut-and-paste error above:
> s/GETFLAGS/SETFLAGS/

Egads. Fixed.

> Also, IIRC, Paul prefers putting a pair of parentheses after function
> names to distinguish them, so in the subject line
> and description it should be security_file_ioctl_compat() and
> security_file_ioctl(), and you should put a patch version
> in the [PATCH] prefix e.g. [PATCH v3] to make clear that it is a later
> version, and usually one doesn't capitalize SELinux
> or the leading verb in the subject line (just "selinux: introduce").

Changed title to lower-case, prefixed with security, changed slightly
to fit in summary with new parentheses. Added [PATCH V3] to the
subject.

> Actually, since this spans more than just SELinux, the prefix likely
> needs to reflect that (e.g. security: introduce ...)
> and the patch should go to the linux-security-module mailing list too
> and perhaps linux-fsdevel for the ioctl change.

Added cc 'selinux@vger.kernel.org' and cc
'linux-kernel@vger.kernel.org'. Thanks!

> I didn't do an audit but does anything need to be updated for the BPF
> LSM or does it auto-magically pick up new hooks?

I'm unsure. I looked through the BPF LSM and I can't see any way it's
picking up the file_ioctl hook to begin with. It appears to me
skimming through the code that it automagically picks it up, but I'm
not willing to bet the kernel on it.

Do you know who would be a good person to ask about this to make sure?


