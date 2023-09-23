Return-Path: <bpf+bounces-10683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC37E7ABE26
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 08:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CBCDF282322
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 06:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4447211C;
	Sat, 23 Sep 2023 06:57:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C76375
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 06:57:37 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C106199
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 23:57:36 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38N6uxYr061298;
	Sat, 23 Sep 2023 15:56:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sat, 23 Sep 2023 15:56:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38N6ulfZ061268
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 23 Sep 2023 15:56:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
Date: Sat, 23 Sep 2023 15:56:48 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/09/22 23:45, KP Singh wrote:
>> I'm using LKM-based LSM with any version between 2.6.0 and 6.6-rc2, without patching
>> __ro_after_init out. We can load LKM-based LSMs, without patching the original kernel.
> 
> Then __ro_after_init is broken in your tree and you are missing some patches.

This fact applies to vanilla upstream kernel tree; __ro_after_init is not broken and
some patches are not missing. See https://akari.osdn.jp/1.0/chapter-3.html.en for details.



>>>
>>> The performance benefits here outweigh the need for a completely
>>> unsupported use case.
>>
>> LKM-based LSMs are not officially supported since 2.6.24. But people need LKM-based LSMs.
>> It is very sad that the LSM community is trying to lock out out of tree LSMs
>> ( https://lkml.kernel.org/r/ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp ).
>> The LSM interface is a common property for *all* Linux users.
> 
> Again, I don't understand how this locks out out-of-tree LSMs. One can
> go and patch static calls the same way one hacked around by directly
> adding stuff to the security_hook_heads. I am not going to suggest any
> hacks here but there are pretty obvious solutions out there.;

The change that locks out out-of-tree LSMs (regardless of whether that LSM is LKM-based LSM
or not) is a series including "[PATCH v15 01/11] LSM: Identify modules by more than name".

I was not pushing LKM-based LSM because the LSM community wanted to make it possible to
enable arbitrary combinations (e.g. enabling selinux and smack at the same time) before
making it possible to use LKM-based LSMs.

According to https://marc.info/?l=linux-security-module&m=123232076329805 (Jan 2009),
Casey said that "SELinux and Smack should never be stacked in the same kernel.".
I'm personally wondering how many users will enable selinux and smack at the same time.
But in that post, Casey also said "You could revive the notion of loadable modules
while you're at it." while implementing LSM Multiplexer LSM.

According to https://marc.info/?l=linux-security-module&m=133055410107878 (Feb 2012),
Casey said that support for multiple concurrent LSMs should be able to handle
loadable/unloadable LSMs.
The reason for removing unload support was that no in-tree users needed it, and
out of tree use-cases are generally not supported in mainline. That is, when the
LSM interface became static, the LSM community was not seeing the reality.
I don't think that rmmod support for LKM-based LSMs is needed, but I believe that
insmod support for LKM-based LSMs is needed.

According to https://lkml.kernel.org/r/50ABE354.1040407@schaufler-ca.com (Nov 2012),
Casey said that reintroducing LSMs as loadable modules is a work for another day
and a separate battle to fight.

These postings (just picked up from LSM mailing list archives matching keyword "loadable"
and sent from Casey) indicate that the LSM community was not making changes that forever
makes LKM-based LSMs impossible.

Finally, pasting Casey's message (Feb 2016) here (because the archive did not find this post):

  From: Casey Schaufler <casey@schaufler-ca.com>
  Subject: Re: LSM as a kernel module
  Date: Mon, 22 Feb 2016 10:17:26 -0800
  Message-ID: <56CB50B6.6060702@schaufler-ca.com>
  To: Roman Kubiak <r.kubiak@samsung.com>, linux-security-module@vger.kernel.org

  On 2/22/2016 5:37 AM, Roman Kubiak wrote:
  > I just wanted to make sure that it's not possible and is not planned in the future
  > to have LSM modules loaded as .ko kernel modules. Is that true for now and the far/near future ?
  >
  > best regards
  
  Tetsuo Handa is holding out hope for loadable security modules*.
  The work I've been doing on module stacking does not include
  support for loadable modules, but I've committed to not making
  it impossible. There has never really been a major issue with
  loading a security module, although there are a host of minor
  ones. The big problem is unloading the module and cleaning up
  properly.
  
  Near term I believe that you can count on not having to worry
  about dynamically loadable security modules. At some point in
  the future we may have an important use case, but I don't see
  that until before some time in the 20s.
  
  So now I'm curious. What are you up to that would be spoiled
  by loadable security modules?
  
  
  ---
  * The original name for the infrastructure was indeed
    "Loadable Security Modules". The memory management and
    security policy implications resulted in steadily
    diminishing support for any sort of dynamic configuration.
    It wasn't long before "Loadable" became "Linux".

But while I was waiting for "make it possible to enable arbitrary combinations" change,
the LSM community started making changes (such as defining the maximum number of "slots"
or "static calls" based on all LSMs are built into vmlinux) that violate Casey's promise.

As a reminder to tell that I still want to make LKM-based LSM officially supported again,
I'm responding to changes (like this patch) that are based on "any LSM must be built into
vmlinux". Please be careful not to make changes that forever make LKM-based LSMs impossible.



> 
> My recommendation would be to use BPF LSM for any custom MAC policy
> logic. That's the whole goal of the BPF LSM is to safely enable these
> use cases without relying on LSM internals and hacks.

I'm fine if you can reimplement TOMOYO (or AKARI or CaitSith) using BPF LSM.
Since BPF has many limitations, not every custom MAC policy can be implemented using BPF.

The need to insmod LKM-based LSMs will remain because the LSM community will not accept
whatever LSMs (that are publicly available) and the Linux distributors will not build
whatever LSMs (that are publicly available) into their vmlinux.

But "LSM: Identify modules by more than name" is the worst change because that change
locks out any publicly available out of tree LSMs, far away from allowing LKM-based LSMs.


