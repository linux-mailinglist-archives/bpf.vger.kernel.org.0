Return-Path: <bpf+bounces-14872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98707E8A21
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 11:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332D4280FEF
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A029A125B6;
	Sat, 11 Nov 2023 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAB11CBD
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 10:07:52 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456133AA6
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:07:51 -0800 (PST)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3ABA7no7035784;
	Sat, 11 Nov 2023 19:07:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Sat, 11 Nov 2023 19:07:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3ABA7mvX035781
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 11 Nov 2023 19:07:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <38b318a5-0a16-4cc2-878e-4efa632236f3@I-love.SAKURA.ne.jp>
Date: Sat, 11 Nov 2023 19:07:48 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 0/5] LSM: Officially support appending LSM hooks after
 boot.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This functionality will be used by TOMOYO security module.

In order to officially use an LSM module, that LSM module has to be
built into vmlinux. This limitation has been a big barrier for allowing
distribution kernel users to use LSM modules which the organization who
builds that distribution kernel cannot afford supporting [1]. Therefore,
I've been asking for ability to append LSM hooks from LKM-based LSMs so
that distribution kernel users can use LSMs which the organization who
builds that distribution kernel cannot afford supporting.

In order to unofficially use LSMs which are not built into vmlinux,
I've been maintaining AKARI as an LKM-based LSM which can run on kernels
between 2.6.0 and 6.6. But KP Singh's "Reduce overhead of LSMs with static
calls" proposal will make AKARI more difficult to run because it removes
the linked list. Therefore, reviving ability to officially append LSM
hooks from LKM-based LSMs became an urgent matter.

KP Singh suggested me to implement such LSMs as eBPF programs. But the
result is that eBPF is too restricted to emulate such LSMs [2]. Therefore,
I still need ability to append LSM hooks from LKM-based LSMs.

KP Singh commented

  I think what you can do is send patches for an API for LKM based LSMs
  and have it merged before my series, I will work with the code I have
  and make LKM based LSMs work. If this work gets merged, and your
  use-case is accepted (I think I can speak for at least Kees [if not
  others] too here) we will help you if you get stuck with MAX_LSM_COUNT
  or a dual static call and linked list based approach.

at [3] but I made this series on top of "[PATCH v7 0/5] Reduce overhead
of LSMs with static calls", for I wanted to know how to use static_calls()
and how does appending LSM hooks after boot will look like, with a hope
that LSM hooks that are appended after boot can also use static calls
so that the same structures/macros can be used for both built-in and
loadable LSM modules.

The result seems to be that linked list and static_call() are not
compatible, for a unique symbol name has to be assigned to each static
call. But I felt that we could avoid loop unrolling if we change the
direction from "call all individual callbacks from security/security.c"
to "call next callback at end of current callback if current callback
succeeded and next callback is defined, and security/security.c calls
only the first callback".

Link: https://lkml.kernel.org/r/9b006dfe-450e-4d73-8117-9625d2586dad@I-love.SAKURA.ne.jp [1]
Link: https://lkml.kernel.org/r/c588ca5d-c343-4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp [2]
Link: https://lkml.kernel.org/r/CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com [3]

