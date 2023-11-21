Return-Path: <bpf+bounces-15520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05BF7F2DE6
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F06282A24
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928F48787;
	Tue, 21 Nov 2023 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79AED58
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 05:04:12 -0800 (PST)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3ALD3V6e011956;
	Tue, 21 Nov 2023 22:03:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 21 Nov 2023 22:03:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3ALD3VRn011949
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 21 Nov 2023 22:03:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7b9e471a-a9df-4ff6-89bf-0fed01fcd5e7@I-love.SAKURA.ne.jp>
Date: Tue, 21 Nov 2023 22:03:31 +0900
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
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRbak9Mij=uKQ-Drod0tQu1+Z+JaahUzH5uj9JUf7ZTuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/11/21 7:52, Paul Moore wrote:
> On Mon, Nov 20, 2023 at 8:28 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> This functionality will be used by TOMOYO security module.
>>
>> In order to officially use an LSM module, that LSM module has to be
>> built into vmlinux. This limitation has been a big barrier for allowing
>> distribution kernel users to use LSM modules which the organization who
>> builds that distribution kernel cannot afford supporting [1]. Therefore,
>> I've been asking for ability to append LSM hooks from LKM-based LSMs so
>> that distribution kernel users can use LSMs which the organization who
>> builds that distribution kernel cannot afford supporting.
> 
> It doesn't really matter for this discussion, but based on my days
> working for a Linux distro company I would be very surprised if a
> commercial distro would support a system running unapproved
> third-party kernel modules.

A commercial distro does not care about problems that are caused by
using kernel modules that are not included in that distro's kernels.

Those who supply kernel modules that are not included in that distro's
kernels (e.g. antivirus software vendors) care about problems that are
caused by using such kernel modules.

Kernel modules for hardware devices that are not included in that distro's
kernels can be appended after boot.

Kernel modules for filesystems that are not included in that distro's
kernels can be appended after boot.

If a commercial distro does not want to allow use of kernel modules that
are not included in that distro's kernels, that distro would enforce module
signature verification rather than disabling loadable module support.
Keeping loadable module support enabled is a balance that is important for
getting wider developers/users.

> 
> We've talked a lot about this core problem and I maintain that it is
> still a disto problem and not something I'm really concerned about
> upstream.

LSM modules that are not built into vmlinux currently cannot be appended
after boot. Such asymmetry is strange and remains a big barrier.

You are not concerned about this asymmetry, but I am very much concerned.
Please give me feedback on not "I don't need it" but "how we can do it".


