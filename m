Return-Path: <bpf+bounces-15865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848687F914C
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 05:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05732281320
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 04:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077E72108;
	Sun, 26 Nov 2023 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB8110
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 20:37:53 -0800 (PST)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3AQ4b9sD001375;
	Sun, 26 Nov 2023 13:37:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 26 Nov 2023 13:37:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3AQ4b83E001370
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Nov 2023 13:37:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d759146e-5d74-4782-931b-adda33b125d4@I-love.SAKURA.ne.jp>
Date: Sun, 26 Nov 2023 13:37:08 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] LSM: Officially support appending LSM hooks
 after boot.
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
 <CAHC9VhRbak9Mij=uKQ-Drod0tQu1+Z+JaahUzH5uj9JUf7ZTuA@mail.gmail.com>
 <7b9e471a-a9df-4ff6-89bf-0fed01fcd5e7@I-love.SAKURA.ne.jp>
 <CAHC9VhRy_sZNSRHMJoULFX2vb=opj1s2hEffaVNJyaHycWF+=w@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRy_sZNSRHMJoULFX2vb=opj1s2hEffaVNJyaHycWF+=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/11/22 13:41, Paul Moore wrote:
> both of these use cases can be solved today by compiling your own kernel.

No. Compiling kernels is not a viable option for regular developers/users.

We (who are kernel developers) tend to think that compiling/replacing a
kernel as a trivial thing. But majority of Linux users do not think so.
The kernel is one of most puzzling programs for Linux users, and most of
Linux users afraid compiling/replacing kernels.

Red Hat's support said that Red Hat does not support a rebuilt RHEL kernel
even if that kernel is rebuilt using the same kernel source and the same
kernel config shipped by Red Hat. Let alone kernels which are rebuilt with
the modified kernel config.

Your "compiling your own kernel" answer is asking me to become a Linux
distributor and to support the whole rebuilt kernels. That will include
management of kernel-debuginfo packages needed for analyzing vmcore, and
also management of userspace packages which depend on the kernel package.

What do you think if you are obligated to support whatever problems just because
you want to allow users to use your code? I'm sure that you will say "I can't".
Your answer cannot be satisfied by a kernel developer who can develop/support
an LSM module but cannot afford supporting problems that are irrelevant to
that LSM module.

Being able to use whatever functionality (not only LSM modules but also
device drivers and filesystem drivers) using pre-built distribution kernels
and pre-built kernel-debuginfo packages is the mandatory baseline.

Of course, the best solution is that whatever LSM modules are built into
distributor's kernels. But since such solution is impossible
( https://bugzilla.redhat.com/show_bug.cgi?id=542986 ), the second best
solution will be that distributor's kernels support only ability to load LSM
modules which that distributor's kernels cannot afford supporting as loadable
kernel modules, and somebody else other than distributor provides support for
LSM modules which that distributor's kernels cannot afford supporting.


