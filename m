Return-Path: <bpf+bounces-11279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF437B6B7A
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 16:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3C840281851
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B108328AC;
	Tue,  3 Oct 2023 14:28:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEE1A290
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 14:28:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53245AF;
	Tue,  3 Oct 2023 07:28:05 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 393ERivo053873;
	Tue, 3 Oct 2023 23:27:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 03 Oct 2023 23:27:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 393ERhuw053870
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Oct 2023 23:27:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f249c8f0-e053-066b-edc5-59a1a00a0868@I-love.SAKURA.ne.jp>
Date: Tue, 3 Oct 2023 23:27:42 +0900
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
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
 <153e7c39-d2e2-db31-68cd-cb05eb2d46db@I-love.SAKURA.ne.jp>
 <CACYkzJ79fvoQW5uqavdLV=N8zw6uern8m-6cM44YYFDhJF248A@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ79fvoQW5uqavdLV=N8zw6uern8m-6cM44YYFDhJF248A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/01 23:43, KP Singh wrote:
>>> Now, comes the question of whether we need dynamically loaded LSMs, I
>>> am not in favor of this. Please share your limitations of BPF as you
>>> mentioned and what's missing to implement dynamic LSMs. My question
>>> still remains unanswered.
>>>
>>> Until I hear the real limitations of using BPF, it's a NAK from me.
>>
>> Simple questions that TOMOYO/AKARI/CaitSith LSMs depend:
>>
>>   Q1: How can the BPF allow allocating permanent memory (e.g. kmalloc()) that remains
>>       the lifetime of the kernel (e.g. before starting the global init process till
>>       the content of RAM is lost by stopping electric power supply) ?
> 
> This is very much possible using global BPF maps. Maps can be "pinned"
> so that they remain allocated until explicitly freed [or RAM is lost
> by stopping electric power supply"]
> 
> Here's an example of BPF program that allocates maps:
> 
>     https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/test_pinning.c#L26
> 
> and the corresponding userspace code that does the pinning:
> 
>     https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/prog_tests/pinning.c

I know nothing about BPF. But that looks "allocate once" (i.e. almost "static char buf[SIZE]").
What I expected is "allocate memory where amount is determined at runtime" (e.g. alloc(), realloc()).

> 
> Specifically for LSMs, we also added support for security blobs which
> are tied to a particular object and are free with the object, have a
> look at the storage which is allocated in the program:
> 
>    https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/local_storage.c#L79
> 
> Again, code and context on what you want to do will let me help you more here.

I don't have any BPF code.
I have several LKM-based LSMs in https://osdn.net/projects/akari/scm/svn/tree/head/branches/ .

> 
>>
>>   Q2: How can the BPF allow interacting with other process (e.g. inter process communication
>>       using read()/write()) which involves opening some file on the filesystem and sleeping
>>       for arbitrary duration?
> 
> The BPF program runs in the kernel context, so yes all of this is
> possible. IPC can be done with the bpf_ring_buffer / maps and BPF also
> has the ability to send signals. One can poll on the ring buffer on
> events and data from the BPF program and do a lots of things.

OK, BPF allows sleeping operations; that's good.

Some of core requirements for implementing TOMOYO/AKARI/CaitSith-like programs
using BPF will be:

  The program registered cannot be stopped/removed by the root user.
  This is made possible by either building the program into vmlinux or loading
  the program as a LKM without module_exit() callback. Is it possible to guaranee
  that a BPF program cannot be stopped/removed by user's operations?

  The program registered cannot be terminated by safety mechanisms (e.g. excessive
  CPU time consumption). Are there mechanisms in BPF that wouldn't have terminated
  a program if the program were implemented as a LKM rather than a BPF program?

  Ideally, the BPF program is built into vmlinux and is started before the global init
  process starts. (But whether building into vmlinux is possible does not matter here
  because I have trouble building into vmlinux. As a fallback, when we can start matters.)
  When is the earliest timing for starting a BPF program that must remain till stopping
  electric power supply? Is that when /init in a initramfs starts? Is that when init=
  kernel command line option is processed? More later than when init= is processed?

  Amount of memory needed for managing data is not known at compile time. Thus, I need
  kmalloc()-like memory allocation mechanism rather than allocating from some pool, and
  manage chunk of memory regions using linked list. Does BPF have kmalloc()-like memory
  allocation mechanism that allows allocating up to 32KB (8 pages if PAGE_SIZE=4096).

And maybe somewhere documented question:

  What kernel functions can a BPF program call / what kernel data can a BPF program access?
  The tools/testing/selftests/bpf/progs/test_d_path.c suggests that a BPF program can call
  d_path() defined in fs/d_path.c . But is that because d_path() is marked as EXPORT_SYMBOL() ?
  Or can a BPF program call almost all functions (like SystemTap script can insert hooks into
  almost all functions)? Even functions / data in LKM can be accessed by a BPF program?



On 2023/10/02 22:04, KP Singh wrote:
>>> There are still a bunch of details (e.g. shared blobs) that it doesn't
>>> address. On the other hand, your memory management magic doesn't
>>> address those issues either.
>>
>> Security is always trial-and-error. Just give all Linux users chances to continue
>> trial-and-error. You don't need to forbid LKM-based LSMs just because blob management
>> is not addressed. Please open the LSM infrastructure to anyone.
> 
> It already is, the community is already using BPF LSM.
> 
> e.g. https://github.com/linux-lock/bpflock
> 

Thank you for an example. But the project says

  bpflock is not a mandatory access control labeling solution, and it does not
  intent to replace AppArmor, SELinux, and other MAC solutions. bpflock uses a
  simple declarative security profile.

which is different from what I want to know (whether it is realistic to
implement TOMOYO/AKARI/CaitSith-like programs using BPF).


