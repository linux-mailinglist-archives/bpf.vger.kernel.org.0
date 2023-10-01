Return-Path: <bpf+bounces-11173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E407B4731
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 13:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 650101C209D2
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D663A4;
	Sun,  1 Oct 2023 11:31:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87C9CA49
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 11:31:22 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B56BBD;
	Sun,  1 Oct 2023 04:31:19 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 391BV6jw071717;
	Sun, 1 Oct 2023 20:31:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sun, 01 Oct 2023 20:31:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 391BV5aw071714
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Oct 2023 20:31:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
Date: Sun, 1 Oct 2023 20:31:05 +0900
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
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/09/28 1:37, Casey Schaufler wrote:
> On 9/27/2023 8:08 AM, Tetsuo Handa wrote:
>> Recently, the LSM community is trying to make drastic changes.
> 
> I'd call them "significant" or "important" rather than "drastic".
> 
>> Crispin Cowan has explained
>>
>>   It is Linus' comments that spurred me to want to start this undertaking.  He
>>   observes that there are many different security approaches, each with their own
>>   advocates.  He doesn't want to arbitrate which of them should be "the" Linux
>>   security approach, and would rather that Linux can support any of them.
>>
>>   That is the purpose of this project:  to allow Linux to support a variety of
>>   security models, so that security developers don't have to have the "my dog's
>>   bigger than your dog" argument, and users can choose the security model that
>>   suits their needs.
>>
>> when the LSM project started [1].
>>
>> However, Casey Schaufler is trying to make users difficult to choose the
>> security model that suits their needs, by requiring LSM ID value which is
>> assigned to only LSM modules that succeeded to become in-tree [2].
> 
> This statement is demonstrably false, and I'm tired of hearing it.

This statement is absolutely true.

Kees Cook said there is no problem if the policy of assigning LSM ID value were

  1) author: "Hello, here is a new LSM I'd like to upstream, here it is. I assigned
              it the next LSM ID."
     maintainer(s): "Okay, sounds good. *review*"

  2) author: "Hello, here is an LSM that has been in active use at $Place,
              and we have $Xxx many userspace applications that we cannot easily
              rebuild. We used LSM ID $Value that is far away from the sequential
              list of LSM IDs, and we'd really prefer to keep that assignment."
    maintainer(s): "Okay, sounds good. *review*"

and I agreed at https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp .

But Paul Moore's response was

  No LSM ID value is guaranteed until it is present in a tagged release
  from Linus' tree, and once a LSM ID is present in a tagged release
  from Linus' tree it should not change.  That's *the* policy.

which means that the policy is not what Kees Cook has said.


>>  struct security_hook_heads security_hook_heads __ro_after_init;
>> +EXPORT_SYMBOL_GPL(security_hook_heads);
> 
> Why disrupt the protection of security_hook_heads? You could easily add
> 
> struct security_hook_heads security_loadable_hook_heads
> EXPORT_SYMBOL_GPL(security_loadable_hook_heads);
> 
> and add the loaded hooks there. A system that does not use loadable
> modules would be unaffected by the ability to load modules.


I'm fine if security_loadable_hook_heads() (and related code) cannot be
disabled by the kernel configuration.

Pasting https://lkml.org/lkml/2007/10/1/192 here again.

  On Mon, 1 Oct 2007, James Morris wrote:
  > 
  > Merging Smack, however, would lock the kernel into the LSM API.  
  > Presently, as SELinux is the only in-tree user, LSM can still be removed.
  
  Hell f*cking NO!
  
  You security people are insane. I'm tired of this "only my version is 
  correct" crap. The whole and only point of LSM was to get away from that.
  
  And anybody who claims that there is "consensus" on SELinux is just in 
  denial.
  
  People are arguing against other peoples security on totally bogus points. 
  First it was AppArmor, now this.
  
  I guess I have to merge AppArmor and SMACK just to get this *disease* off 
  the table. You're acting like a string theorist, claiming that t here is 
  no other viable theory out there. Stop it. It's been going on for too damn 
  long.
  
  			Linus

The situation with LKM-based LSMs is symmetry of that post.
Those who are suspicious about supporting LKM-based LSMs is nothing but

  "Presently, as all in-tree users are built-in, LSM does not need to support LKM-based LSMs."

. That's "only LSM modules which are built into vmlinux are correct" crap.

> On a less happy note, you haven't addressed security blobs in any way. You
> need to provide a mechanism to allow an LSM to share security blobs with
> builtin LSMs and other loadable LSMs.

Not all LKM-based LSMs need to use security blobs. What the LSM infrastructure
needs to do is manage which callback is called (so that undo operation is possible
when something went wrong while traversing the linked list). Everything else can
be managed by individual LSM implementations.


