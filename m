Return-Path: <bpf+bounces-12899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3197D1D70
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 16:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE83282245
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139EA10795;
	Sat, 21 Oct 2023 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D0DF45
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 14:20:25 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE97D6E;
	Sat, 21 Oct 2023 07:20:06 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39LEJiZP015140;
	Sat, 21 Oct 2023 23:19:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 21 Oct 2023 23:19:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39LEJh73015137
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Oct 2023 23:19:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d060365e-7c87-451e-a92a-edb4904e77a7@I-love.SAKURA.ne.jp>
Date: Sat, 21 Oct 2023 23:19:43 +0900
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
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ7kzXGcjRdyaOWCaigPWcKXU7_KW_bFg9ptrnwAeJ2AgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/10/04 0:09, KP Singh wrote:
>> What I expected is "allocate memory where amount is determined at runtime" (e.g. alloc(), realloc()).
> 
> One can use dynamically sized allocations on the ring buffer with
> dynamic pointers:
> 
> http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-dynptr.pdf
> 
> Furthermore, there are some use cases that seemingly need dynamic
> memory allocation but not really. e.g. there was a need to audit
> command line arguments and while it seems dynamic and one can chunk
> the allocation to finite sizes, put these on a ring buffer and process
> the chunks.
> 
> It would be nice to see more details of where the dynamic allocation
> is needed. Security blobs are allocated dynamically but have a fixed
> size.

Dynamic allocation is not for security blobs. Dynamic allocation is for
holding requested pathnames (short-lived allocation), holding audit logs
(FIFO allocation), holding/appending access control rules (long-lived
allocation).



>> Some of core requirements for implementing TOMOYO/AKARI/CaitSith-like programs
>> using BPF will be:
>>
>>   The program registered cannot be stopped/removed by the root user.
>>   This is made possible by either building the program into vmlinux or loading
>>   the program as a LKM without module_exit() callback. Is it possible to guaranee
>>   that a BPF program cannot be stopped/removed by user's operations?
> 
> Yes, there is a security_bpf hook where a BPF MAC policy can be
> implemented and other LSMs do that already.
> 
>>
>>   The program registered cannot be terminated by safety mechanisms (e.g. excessive
>>   CPU time consumption). Are there mechanisms in BPF that wouldn't have terminated
>>   a program if the program were implemented as a LKM rather than a BPF program?
>>
> 
> The kernel does not terminate BPF LSM programs, once a BPF program is
> loaded and attached to the LSM hook, it's JITed into a native code.
> From there onwards, as far as the kernel is concerned it's just like
> any other kernel function.

I was finally able to build and load tools/testing/selftests/bpf/progs/lsm.c and
tools/testing/selftests/bpf/prog_tests/test_lsm.c , and I found fatal limitation
that the program registered is terminated when the file descriptor which refers to
tools/testing/selftests/bpf/lsm.bpf.o is closed (due to e.g. process termination).
That is, eBPF programs are not reliable/robust enough to implement TOMOYO/AKARI/
CaitSith-like programs. Re-registering when the file descriptor is closed is racy
because some critical operations might fail to be traced/checked by the LSM hooks.

Also, I think that automatic cleanup upon closing the file descriptor implies that
allocating resources (or getting reference counts) that are not managed by the BPF
(e.g. files under /sys/kernel/securitytomoyo/ directory) is not permitted. That's
very bad.

> 
>>
>>   Amount of memory needed for managing data is not known at compile time. Thus, I need
>>   kmalloc()-like memory allocation mechanism rather than allocating from some pool, and
>>   manage chunk of memory regions using linked list. Does BPF have kmalloc()-like memory
>>   allocation mechanism that allows allocating up to 32KB (8 pages if PAGE_SIZE=4096).
>>
> 
> You use the ring buffer as a large pool and use dynamic pointers to
> carve chunks out of it, if truly dynamic memory is needed.

TOMOYO/AKARI/CaitSith-like programs do need dynamic memory allocation, as max amount of
memory varies from less than 1MB to more than 10MB. Preallocation is too much wasteful.



> 
>> And maybe somewhere documented question:
>>
>>   What kernel functions can a BPF program call / what kernel data can a BPF program access?
> 
> BPF programs can access kernel data dynamically (accesses relocated at
> load time without needing a recompile) There are lot of good details
> in:
> 
> https://nakryiko.com/posts/bpf-core-reference-guide/
> 
> 
>>   The tools/testing/selftests/bpf/progs/test_d_path.c suggests that a BPF program can call
>>   d_path() defined in fs/d_path.c . But is that because d_path() is marked as EXPORT_SYMBOL() ?
>>   Or can a BPF program call almost all functions (like SystemTap script can insert hooks into
>>   almost all functions)? Even functions / data in LKM can be accessed by a BPF program?
>>
> 
> It's not all kernel functions, but there is a wide range of helpers
> and kfuncs (examples in tools/testing/selftests/bpf) and if there is
> something missing, we will help you.

I couldn't build tools/testing/selftests/bpf/progs/lsm.c with printk() added.
Sending to /sys/kernel/debug/tracing/trace_pipe via bpf_printk() is not enough for
reporting critical/urgent problems. Synchronous operation is important.

Since printk() is not callable, most of functions which TOMOYO/AKARI/CaitSith-like
programs use seem to be not callable.


