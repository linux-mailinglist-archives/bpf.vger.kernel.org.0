Return-Path: <bpf+bounces-11354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D70D7B7D6B
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D6D202815BA
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7846311182;
	Wed,  4 Oct 2023 10:40:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421D107AA
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 10:40:39 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38224D7;
	Wed,  4 Oct 2023 03:40:35 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 394AeKWa009257;
	Wed, 4 Oct 2023 19:40:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 04 Oct 2023 19:40:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 394AeBUa009214
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 4 Oct 2023 19:40:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <36776914-189b-3f51-9b56-b4273a625005@I-love.SAKURA.ne.jp>
Date: Wed, 4 Oct 2023 19:40:09 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>,
        bpf <bpf@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
 <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <1b9f0e3f-0ff3-5b2d-19fa-dfa83afab8a6@schaufler-ca.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1b9f0e3f-0ff3-5b2d-19fa-dfa83afab8a6@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/02 0:19, Casey Schaufler wrote:
>> I'm fine if security_loadable_hook_heads() (and related code) cannot be
>> disabled by the kernel configuration.
> 
> CONFIG_SECURITY ensures that you will be unhappy.

I don't care about Linux distributors who chose CONFIG_SECURITY=n in their
kernel configurations. What I'm saying is that security_loadable_hook_heads
(and related code) do not depend on some build-time configuration. Also, I
don't care about Linux distributors who patch their kernel source code in
order to remove security_loadable_hook_heads (and related code) before
building their kernels.

But if a kernel is targeted for specific environment where out-of-tree LKMs
(e.g. storage driver, filesystems) are not required, the person/organization
who builds that kernel can protect that kernel from out-of-tree LKMs
(including LKM-based LSMs) by enforcing module signing functionality.

Also if a kernel is ultimately targeted for specific environment where LKM
support is not required, the person/organization who builds that kernel can
protect that kernel from out-of-tree LKMs (including LKM-based LSMs) by
disabling loadable module functionality.

Linux distributors that I want to run LSMs are generally trying to support
as much users/environments as possible. The combination of enabling loadable
module functionality and not enforcing module signing functionality is a good
balance for that purpose.

> Even setting that aside, it's the developer's job to sell the code to
> the communities involved. I could rant at certain distros for not including
> Smack, but until such time as I've made doing that attractive it really
> doesn't make any sense to do so. You don't think I've spent years on stacking
> because I want to run Android containers on Ubuntu, do you?

Which one ("the LSM community" or "the Linux distributors") do you mean by
"the communities involved" ?

For out-of-tree LKMs (e.g. storage driver, filesystems) that can be loaded as
a loadable kernel module, the provider/developer can directly sell the code to
end users (i.e. they can sell without being accepted by the upstream Linux
community and being enabled by the Linux distributors' kernel configurations).

But for out-of-tree LSMs that cannot be loaded as a loadable kernel module,
the provider/developer currently cannot directly sell the code to end users.

You said

  This makes it sound like LSMs are always developed for corporate use.
  While that is generally true, we should acknowledge that the "sponsor"
  of an LSM could be a corporation/government, a foundation or a hobbyist.
  A large, comprehensive LSM from a billion dollar corporation in support
  of a specific product should require more commitment than a small, targeted
  LSM of general interest from joe@schlobotnit.org. I trust that we would
  have the wisdom to make such a distinction, but I don't think we want to
  scare off developers by making it sound like an LSM is something that only
  a corporation can provide a support plan for.

at https://lkml.kernel.org/r/847729f6-99a6-168e-92a6-b1cff1e6b97f@schaufler-ca.com .

But "it's the developer's job to sell the code to the communities involved" is
too hard for alone developer who can write a code and provide support for that code
but cannot afford doing activities for selling that code (e.g. limited involvement
with communities).

Your "it's the developer's job" comment sounds like "LSMs are always developed by
those corporation/government who has much involvement with communities" which
scares off developers who can't afford doing activities for selling that code.

>>> On a less happy note, you haven't addressed security blobs in any way. You
>>> need to provide a mechanism to allow an LSM to share security blobs with
>>> builtin LSMs and other loadable LSMs.
>> Not all LKM-based LSMs need to use security blobs.
> 
> If you only want to support "minor" LSMs, those that don't use shared blobs,
> the loadable list implementation will suit you just fine. And because you won't
> be using any of the LSM infrastructure that needs the LSM ID, that won't be
> an issue.

Minor LSMs can work without using shared blobs managed by the LSM infrastructure.
AKARI/CaitSith are LKM-based LSMs that do not need to use shared blobs managed by
the LSM infrastructure. TOMOYO does not need an LSM ID value, but you are trying
to make an LSM ID mandatory for using the LSM infrastructure.

> You can make something that will work. Whether you can sell it upstream will
> depend on any number of factors. But working code is always a great start.

Selling a code to the upstream is not sufficient for allowing end users to use
that code.

For https://bugzilla.redhat.com/show_bug.cgi?id=542986 case, the reason that Red Hat
does not enable Smack/TOMOYO/AppArmor is "Smack/TOMOYO/AppArmor are not attractive".

After all, requiring any LSMs to be built-in is an unreasonable barrier compared to
other LKMs (e.g. storage driver, filesystems).


