Return-Path: <bpf+bounces-35164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7BB9380BA
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90A51F215DC
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568054CB23;
	Sat, 20 Jul 2024 10:31:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF45FB9B
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721471491; cv=none; b=kzfDubfrykaN1TQePSbEQNPexrNdAx/Fupo1Bm2p5eC8j3GbbBZrXP160Rg7H5OrI4J1wdMr+LcFHGCv60Bu53s/PFF4jKeUmbcuE3UTSqXWbdlmSdskwS/cU6JUsJ2WMS+SqAPvlvYuFGdCOCdTwl+hYCdfGk/AWXureNw20Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721471491; c=relaxed/simple;
	bh=ZP6OOWbF7mpjRAPFyMhEs7+dz9eq9abWtqD4IWCEcYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7/5JEF8G9zha8Vg3UK0NG5XvJ9YqDPJdVqQ3IPfj5jQ8LAfChqzWP+jmeJclx58bXD0qlQ3BXf7ZMLuKQop56Q2JpMFXc1Mtpxbjv9kCMo5/dfBEmRjuFJfHwWtAWz6CYeP/DVHR+5UFSRaW8Yd7Y64ZRO5IYAc+qwa+5GDLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46KAUnSQ013652;
	Sat, 20 Jul 2024 19:30:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 20 Jul 2024 19:30:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46KAUmeX013646
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Jul 2024 19:30:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9d26b25e-d0bf-426c-bd5a-aec5746dc848@I-love.SAKURA.ne.jp>
Date: Sat, 20 Jul 2024 19:30:50 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/3] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
        bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
        andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
        renauld@google.com, revest@chromium.org, song@kernel.org
References: <20240710000500.208154-1-kpsingh@kernel.org>
 <20240710000500.208154-4-kpsingh@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240710000500.208154-4-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/10 9:05, KP Singh wrote:
> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:
> 
> security_file_ioctl:
>    0xff...0320 <+0>:	endbr64
>    0xff...0324 <+4>:	push   %rbp
>    0xff...0325 <+5>:	push   %r15
>    0xff...0327 <+7>:	push   %r14
>    0xff...0329 <+9>:	push   %rbx
>    0xff...032a <+10>:	mov    %rdx,%rbx
>    0xff...032d <+13>:	mov    %esi,%ebp
>    0xff...032f <+15>:	mov    %rdi,%r14
>    0xff...0332 <+18>:	mov    $0xff...7030,%r15
>    0xff...0339 <+25>:	mov    (%r15),%r15
>    0xff...033c <+28>:	test   %r15,%r15
>    0xff...033f <+31>:	je     0xff...0358 <security_file_ioctl+56>
>    0xff...0341 <+33>:	mov    0x18(%r15),%r11
>    0xff...0345 <+37>:	mov    %r14,%rdi
>    0xff...0348 <+40>:	mov    %ebp,%esi
>    0xff...034a <+42>:	mov    %rbx,%rdx
> 
>    0xff...034d <+45>:	call   0xff...2e0 <__x86_indirect_thunk_array+352>
>    			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>     Indirect calls that use retpolines leading to overhead, not just due
>     to extra instruction but also branch misses.
> 
>    0xff...0352 <+50>:	test   %eax,%eax
>    0xff...0354 <+52>:	je     0xff...0339 <security_file_ioctl+25>
>    0xff...0356 <+54>:	jmp    0xff...035a <security_file_ioctl+58>
>    0xff...0358 <+56>:	xor    %eax,%eax
>    0xff...035a <+58>:	pop    %rbx
>    0xff...035b <+59>:	pop    %r14
>    0xff...035d <+61>:	pop    %r15
>    0xff...035f <+63>:	pop    %rbp
>    0xff...0360 <+64>:	jmp    0xff...47c4 <__x86_return_thunk>
> 
> The indirect calls are not really needed as one knows the addresses of
> enabled LSM callbacks at boot time and only the order can possibly
> change at boot time with the lsm= kernel command line parameter.
> 
> An array of static calls is defined per LSM hook and the static calls
> are updated at boot time once the order has been determined.
> 
> A static key guards whether an LSM static call is enabled or not,
> without this static key, for LSM hooks that return an int, the presence
> of the hook that returns a default value can create side-effects which
> has resulted in bugs [1].
> 
> With the hook now exposed as a static call, one can see that the
> retpolines are no longer there and the LSM callbacks are invoked
> directly:
> 
> security_file_ioctl:
>    0xff...0ca0 <+0>:	endbr64
>    0xff...0ca4 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xff...0ca9 <+9>:	push   %rbp
>    0xff...0caa <+10>:	push   %r14
>    0xff...0cac <+12>:	push   %rbx
>    0xff...0cad <+13>:	mov    %rdx,%rbx
>    0xff...0cb0 <+16>:	mov    %esi,%ebp
>    0xff...0cb2 <+18>:	mov    %rdi,%r14
>    0xff...0cb5 <+21>:	jmp    0xff...0cc7 <security_file_ioctl+39>
>   			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Static key enabled for SELinux
> 
>    0xffffffff818f0cb7 <+23>:	jmp    0xff...0cde <security_file_ioctl+62>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    Static key enabled for BPF LSM. This is something that is changed to
>    default to false to avoid the existing side effect issues of BPF LSM
>    [1] in a subsequent patch.
> 
>    0xff...0cb9 <+25>:	xor    %eax,%eax
>    0xff...0cbb <+27>:	xchg   %ax,%ax
>    0xff...0cbd <+29>:	pop    %rbx
>    0xff...0cbe <+30>:	pop    %r14
>    0xff...0cc0 <+32>:	pop    %rbp
>    0xff...0cc1 <+33>:	cs jmp 0xff...0000 <__x86_return_thunk>
>    0xff...0cc7 <+39>:	endbr64
>    0xff...0ccb <+43>:	mov    %r14,%rdi
>    0xff...0cce <+46>:	mov    %ebp,%esi
>    0xff...0cd0 <+48>:	mov    %rbx,%rdx
>    0xff...0cd3 <+51>:	call   0xff...3230 <selinux_file_ioctl>
>    			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Direct call to SELinux.
> 
>    0xff...0cd8 <+56>:	test   %eax,%eax
>    0xff...0cda <+58>:	jne    0xff...0cbd <security_file_ioctl+29>
>    0xff...0cdc <+60>:	jmp    0xff...0cb7 <security_file_ioctl+23>
>    0xff...0cde <+62>:	endbr64
>    0xff...0ce2 <+66>:	mov    %r14,%rdi
>    0xff...0ce5 <+69>:	mov    %ebp,%esi
>    0xff...0ce7 <+71>:	mov    %rbx,%rdx
>    0xff...0cea <+74>:	call   0xff...e220 <bpf_lsm_file_ioctl>
>    			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Direct call to BPF LSM.
> 
>    0xff...0cef <+79>:	test   %eax,%eax
>    0xff...0cf1 <+81>:	jne    0xff...0cbd <security_file_ioctl+29>
>    0xff...0cf3 <+83>:	jmp    0xff...0cb9 <security_file_ioctl+25>
>    0xff...0cf5 <+85>:	endbr64
>    0xff...0cf9 <+89>:	mov    %r14,%rdi
>    0xff...0cfc <+92>:	mov    %ebp,%esi
>    0xff...0cfe <+94>:	mov    %rbx,%rdx
>    0xff...0d01 <+97>:	pop    %rbx
>    0xff...0d02 <+98>:	pop    %r14
>    0xff...0d04 <+100>:	pop    %rbp
>    0xff...0d05 <+101>:	ret
>    0xff...0d06 <+102>:	int3
>    0xff...0d07 <+103>:	int3
>    0xff...0d08 <+104>:	int3
>    0xff...0d09 <+105>:	int3
> 
> While this patch uses static_branch_unlikely indicating that an LSM hook
> is likely to be not present. In most cases this is still a better choice
> as even when an LSM with one hook is added, empty slots are created for
> all LSM hooks (especially when many LSMs that do not initialize most
> hooks are present on the system).
> 
> There are some hooks that don't use the call_int_hook or
> call_void_hook. These hooks are updated to use a new macro called
> lsm_for_each_hook where the lsm_callback is directly invoked as an
> indirect call.
> 
> Below are results of the relevant Unixbench system benchmarks with BPF LSM
> and SELinux enabled with default policies enabled with and without these
> patches.
> 
> Benchmark                                               Delta(%): (+ is better)
> ===============================================================================
> Execl Throughput                                             +1.9356
> File Write 1024 bufsize 2000 maxblocks                       +6.5953
> Pipe Throughput                                              +9.5499
> Pipe-based Context Switching                                 +3.0209
> Process Creation                                             +2.3246
> Shell Scripts (1 concurrent)                                 +1.4975
> System Call Overhead                                         +2.7815
> System Benchmarks Index Score (Partial Only):                +3.4859
> 
> In the best case, some syscalls like eventfd_create benefitted to about ~10%.
> 
> [1] https://lore.kernel.org/linux-security-module/20220609234601.2026362-1-kpsingh@kernel.org/
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

I'm not against about use of static calls.
But I nack this series because of wrong assumption that ignores reality.

Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>


