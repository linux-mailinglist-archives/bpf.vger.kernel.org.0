Return-Path: <bpf+bounces-11171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847CB7B4707
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 12:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6FA232828F1
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E34B1642E;
	Sun,  1 Oct 2023 10:52:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05139CA66
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 10:52:50 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B64C2
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 03:52:46 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 391Apomt063248;
	Sun, 1 Oct 2023 19:51:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sun, 01 Oct 2023 19:51:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 391Apo5n063244
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Oct 2023 19:51:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAKURA.ne.jp>
Date: Sun, 1 Oct 2023 19:51:49 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Content-Language: en-US
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
 <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
 <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
 <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
 <CACYkzJ4AGRcqLPqWY65OC778EPaUwTBpyOMfiVBXa4EmnHTXGQ@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ4AGRcqLPqWY65OC778EPaUwTBpyOMfiVBXa4EmnHTXGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/09/25 20:22, KP Singh wrote:
>> It is Casey's commitment that the LSM infrastructure will not forbid LKM-based LSMs.
>> We will start allowing LKM-based LSMs. But it is not clear how we can make it possible to
>> allow LKM-based LSMs.
> 
> I think this needs to be discussed if and when we allow LKM based LSMs.

It is *now* (i.e. before your proposal is accepted) that we need to discuss.

> One needs to know MAX_LSM_COUNT at compile time (not via kernel
> command line), I really suggest you try out your suggestions before
> posting them. I had explained this to you earlier, you still chose to
> ignore and keep suggesting stuff that does not work.

Your proposal needs to know MAX_LSM_COUNT at compile time, that's why
we need to discuss now.

> We will see when this happens. I don't think it's a difficult problem
> and there are many ways to implement this:
> 
> * Add a new slot(s) for modular LSMs (One can add up to N fast modular LSMs)
> * Fallback to a linked list for modular LSMs, that's not a complexity.
> There are serious performance gains and I think it's a fair trade-off.
> This isn't even complex.

That won't help at all. You became so blind because what you want to use (i.e.
SELinux and BPF) are already supported by Linux distributors. The reason I'm
insisting on supporting LKM-based LSMs is that Linux distributors cannot afford
supporting minor LSMs.

Dave Chinner said

  Downstream distros support all sorts of out of tree filesystems loaded
  via kernel modules

at https://lkml.kernel.org/r/ZQo94mCzV7hOrVkh@dread.disaster.area , and e.g.
antivirus software vendors use out of tree filesystems loaded via kernel
modules (because neither the upstream kernel community nor the Linux distributors
can afford supporting out of tree filesystems used by antivirus software vendors).

If Linux distributors decide "we don't allow loading out of tree filesystems
via kernel modules because we can't support", that's the end of the world for
such filesystems.

What I'm saying is nothing but s/filesystem/LSM/g .
If Linux distributors decide "we don't allow loading out of tree LSMs
via kernel modules because we can't support", that's the end of the world for
LKM-based LSMs.

The mechanism which makes LKM-based LSMs possible must not be disabled by
the person/organization who builds the vmlinux.

You might still say that "You can build your vmlinux and distribute it", but
that is also impossible in practice. Some device drivers are meant to be loaded
for Linux distribution's prebuilt kernels. Also, debuginfo package is needed for
analyzing vmcore. Building vmlinux and distributing it is not practical without
becoming a well-known Linux distributors enough to get out-of-tree device drivers
being prebuilt (such as Red Hat).

Again, you are so blind.

> Now, this patch and the patch that makes security_hook_heads
> __ro_after_init by removing CONFIG_SECURITY_HOOKS_WRITABLE breaks your
> hack.

Like I demonstrated at https://lkml.kernel.org/r/cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp ,
removing CONFIG_SECURITY_HOOKS_WRITABLE does not break my hack.


