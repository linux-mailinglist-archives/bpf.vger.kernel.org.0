Return-Path: <bpf+bounces-12943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A77D2332
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 15:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A44A2814DB
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B6101D4;
	Sun, 22 Oct 2023 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23E29AF
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:34:40 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A59DC;
	Sun, 22 Oct 2023 06:34:38 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39MDYOVY016439;
	Sun, 22 Oct 2023 22:34:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 22 Oct 2023 22:34:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39MDYNUN016436
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 22 Oct 2023 22:34:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c588ca5d-c343-4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp>
Date: Sun, 22 Oct 2023 22:34:20 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <f249c8f0-e053-066b-edc5-59a1a00a0868@I-love.SAKURA.ne.jp>
 <CACYkzJ7kzXGcjRdyaOWCaigPWcKXU7_KW_bFg9ptrnwAeJ2AgQ@mail.gmail.com>
 <d060365e-7c87-451e-a92a-edb4904e77a7@I-love.SAKURA.ne.jp>
 <CACYkzJ7S00K8f-H7EdDz3CFyxbfoQ1zQXDj7oWpY3dkDjFb0LA@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ7S00K8f-H7EdDz3CFyxbfoQ1zQXDj7oWpY3dkDjFb0LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/10/22 0:20, KP Singh wrote:
>> Since printk() is not callable, most of functions which TOMOYO/AKARI/CaitSith-like
>> programs use seem to be not callable.
> 
> It seems like you are trying to 1:1 re-implement an existing LSM's
> code base in BPF,

Yes, that is the goal. Since you said

  "Until I hear the real limitations of using BPF, it's a NAK from me."

at https://lkml.kernel.org/r/CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com ,
I want to know whether it is possible to re-implement TOMOYO LSM as an eBPF program.

If it is possible to re-implement TOMOYO LSM as an eBPF program, my desire to
allow appending LKM-based LSMs after boot will be significantly reduced, which
in turn will become my ACK to "security: Count the LSMs enabled at compile time"
in your "Reduce overhead of LSMs with static calls" proposal.

>                   that's surely not going to work. You need to think
> about the use-case / policy you are trying to implement and then write
> the code in BPF independently. Please share concrete examples of the
> policy you want to implement and we try to help you. Asking for
> features where you want a 1:1 parity with kernel code without concrete
> policy use-cases is not going to enable us to help you.

The code which I want to re-implement using eBPF is all of security/tomoyo/ directory.



>> I couldn't build tools/testing/selftests/bpf/progs/lsm.c with printk() added.
>> Sending to /sys/kernel/debug/tracing/trace_pipe via bpf_printk() is not enough for
>> reporting critical/urgent problems. Synchronous operation is important.
> 
> you cannot call any function from within BPF. If you need to call
> something they need to be exported as a kfunc (you need to send
> patches on the mailing list for it). This is because we want to ensure
> that BPF programs can be verified.

TOMOYO needs to be able to call d_absolute_path() in order to calculate
requested pathname, call call_usermodehelper(UMH_WAIT_PROC) in order to load
policy upon activation, call get_mm_exe_file() in order to know the pathname
of executable, get_user_pages_remote() in order to examine argv/envp passed to
execve() system call etc. etc. in addition to performing complicated comparison
including loop like https://elixir.bootlin.com/linux/v6.6-rc6/source/security/tomoyo/group.c#L120 .

If any of above requirements cannot be satisfied in eBPF, that will become
the real limitations of using BPF.



>> I was finally able to build and load tools/testing/selftests/bpf/progs/lsm.c and
>> tools/testing/selftests/bpf/prog_tests/test_lsm.c , and I found fatal limitation
> 
> Programs can also be pinned on /sys/bpf similar to maps, this allows
> them to persist even after the loading program goes away.
> 
> Here's an example of a pinned program:
> 
> https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/flow_dissector_load.c#L39
> 
>> that the program registered is terminated when the file descriptor which refers to
>> tools/testing/selftests/bpf/lsm.bpf.o is closed (due to e.g. process termination).
>> That is, eBPF programs are not reliable/robust enough to implement TOMOYO/AKARI/
>> CaitSith-like programs. Re-registering when the file descriptor is closed is racy
> 
> Not needed as programs can be pinned too.
> 

That's good but not enough. We will need to forbid unlink/umount because detach_program()
says "/* To unpin, it is necessary and sufficient to just remove this dir */". Hooking
security_inode_unlink()/security_sb_umount() and return an error if the requested file was
the eBPF version of TOMOYO (or maps etc. related to the eBPF version of TOMOYO) or the
requested filesystem was sysfs might be able to forbid "unpin" operation... That would be
the next step to check if re-implementing all of security/tomoyo/ directory using eBPF
is possible...


