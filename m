Return-Path: <bpf+bounces-34463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71892DA4F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 22:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48101F243F6
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A64A198A3E;
	Wed, 10 Jul 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CExN+IcL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1A198A03
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644080; cv=none; b=EybvyZL6lZ/tSFOjadWt5umHw6m3IuvVMp93AcDQhLX3k4IlrxR/MqP1LTrqTY+Y1tzhVdASi6IFO3tXoiYVneKrzBIiNE+Rsc3BU4ONaQewaJlgwDxm08W7Do/2D/Sg2GvC8s9RLI2FsubPFX+fZXWfjw0py1i0kmgG+DJAIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644080; c=relaxed/simple;
	bh=LsoiaYDzTEhSMIlC2mSQom7YLX7z+Ni7zi460kx+YiE=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=H1FmQ6P/EMyqTpf1I5E3+2hezvlrwW6SulrHvmFZo4Pnf7Ujgv6hEdJBaQd4246hxSgsx0MQ/1kIm/TY7c9lwDNvdRUmjuQFuz9aOEvniOp5plyA8BBx60NPzhX4wYDUIQlMVAxXzlVIp1PfXj14kDQpUOVwGlpsAnT2c670GdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CExN+IcL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-448b366794cso928871cf.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720644077; x=1721248877; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4mdW9+gwOyhLqUdWH6kx7lwiJuy2XBYAaNgyUah3Fw=;
        b=CExN+IcLMyVf2gfO2iCWJNBCuUvUz+nAruPN/4T3ApaflOjL1iau0or156mNOjknFi
         gKq8dP/YpIbW18OZQU9+eSrDJzJCraNrxDuXnOzjvu13FSr0pXmg04emZouJjlhaPqJ0
         waL7EDXwZZHpdUs69rGl0J1Ld4aifhiQ9F3GeiHOOrv2f2cKKePEIFaz5XaTIp3Sz810
         Dli8GHjOGkQCxQrFYQoZBxOaQntAJ7CSFJXl0EpvyS/HrjNV0guM5Z8zoIQJxpe3AkCy
         Z4/MQZHBxG80vkKGMEXFUkbEVerhed1uRbfXdz/5yueKZ2tbDQE09sMf+puemPLGgICG
         WC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720644077; x=1721248877;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4mdW9+gwOyhLqUdWH6kx7lwiJuy2XBYAaNgyUah3Fw=;
        b=T5h3JIXHzURWi/WGlSjrnusBoq4DxaFzkTHVuIEF4F2TfbFBuQHFp5xxz/gHWDn1q8
         550VflvzGa5erc2vEM6umoXKNYgwt5nOxxKTpStEXnONsLLEpX/gQcCUl08bB3pmWaCl
         WR2KAXg0T1UqCf/FRC2x+UHKXsm6umN9Zng/CIcyArawvBw8Ef8QBsiAhHA7y5+piBcE
         iyHAfDXjsgcVjijXFBxLEshepzrNvNcIDCH8BGUFgdnWba+dSjRabZk4kiyR508bz8sP
         /57jQ4RH9Hh8F/SVEg15Yly+lJ2/s3wQ1QZo2INihSqCNwVoIg9q31nUvUq6SQRyy9vo
         QrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWRXdcbN5FYO2QFRY5KOM/RmiR8zR9nCVl/BewMyaZNLjDNWv8bIzHkhulwwXEGJqElSjkDJgaZGyhLVvr66li9gpEM
X-Gm-Message-State: AOJu0Ywe9h49y7FnDgxuU/euDvfjYtTw9cT660hoeeorhsOtyqNbAofB
	FR9tAWgjFT1T4QnXCFFE4S96ne2BEbHwuW8vvV7wh5Mh65V8nQqh6J/pjnCXjw==
X-Google-Smtp-Source: AGHT+IFY1Nq8B7mzCJSItFmAP9NcaTGKgxoetuAbxOWQ3qCTPFzFg71q8pqQIZg7kpupQtFFSRwBHw==
X-Received: by 2002:a05:622a:ce:b0:444:d0da:4a7 with SMTP id d75a77b69052e-447fa880d7amr81509741cf.19.1720644077429;
        Wed, 10 Jul 2024 13:41:17 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3c542sm23370551cf.26.2024.07.10.13.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 13:41:17 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:41:16 -0400
Message-ID: <b23e0868802853a9ab17e17fdc35c678@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net, renauld@google.com, revest@chromium.org, song@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v14 3/3] security: Replace indirect LSM hook calls with  static calls
References: <20240710000500.208154-4-kpsingh@kernel.org>
In-Reply-To: <20240710000500.208154-4-kpsingh@kernel.org>

On Jul  9, 2024 KP Singh <kpsingh@kernel.org> wrote:
> 
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

I don't want to rehash our previous discussions on this topic, but I do
think we either need to simply delete the paragraph above or update it
to indicate that all known side effects involving LSM callback return
values have been addressed.  Removal is likely easier if for no other
reason than we don't have to go back and forth with edits, but I can
understand if you would prefer to have the paragraph in the commit
description, albeit in a revised form.  If you want to go with the
revised paragraph option, you don't need to keep resubmitting the
patchset, once we agree on something I can do the paragraph swap when
I merge the patchset.

Otherwise, this patchset looks okay, but as I mentioned earlier, given
we are at -rc7 this isn't something that I'm comfortable sending up to
Linus during the upcoming merge window.  This is v6.12 material at this
point.

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
> ---
>  include/linux/lsm_hooks.h |  53 ++++++++--
>  security/security.c       | 215 ++++++++++++++++++++++++++------------
>  2 files changed, 195 insertions(+), 73 deletions(-)

--
paul-moore.com

