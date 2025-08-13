Return-Path: <bpf+bounces-65506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E25AB2480F
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619E48802CB
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984222F6572;
	Wed, 13 Aug 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5C+yg3h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4D212556;
	Wed, 13 Aug 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083381; cv=none; b=g6irWu5jpcB3zBuhda7z5lEtZhqUHQUeuZPgel0zpHxREhqrOG63KSqeYE1rcxvPLq4DdCqoetap3jtmH36rvvcF8njKauiKP0K29xMEOt4rsjNu+RYPKz4Pwhkdsui5zf+nJZGJ3TfNQb7f8dkZJBAXXaa3A9OlfZvYehkdkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083381; c=relaxed/simple;
	bh=rZ9W1bq+qLUiygR/ycLnKpU14UlQTINfG3wwx0+idWs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI4Gx+4dF8E/Zf7oK34IaEYp1/zh8LR82O3mN6xJuaYvZyRg9oQnhKGq2+02k5BRC0Xc0oyGVkNkLeb5YXAucos0qQMT7cM+p6YIh5np9JdFUvhDqR2KUb+vf3VRg8O3/c95gVExu28x4vZDahlnkrL+LnpN8RrRaPWMWuLuK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5C+yg3h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b913b7dc01so965352f8f.2;
        Wed, 13 Aug 2025 04:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755083377; x=1755688177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihlo7ylUGW7wZsGWuOHUqv/CYuxjb+ZuvYxiMymfvww=;
        b=X5C+yg3husuySWEdC5damp0XY4l6T1vM8jrippRivh6euuGbDifbgnhwvYJRXSHxFA
         hlWY7rLhCMPrb7dMdrzOYJOiO1Gjd70xcNcK1B62Z5Uu/mVGzPFuRPN6nZ2FCdbBJX6b
         ZNJDx8Bmp8eYaM4krpIT1mtQDw095p0EwMC6nCEdBSomUQje0wk9dB+k2FIxbF5weHri
         qai7sdF+IvDae2XQv4dZO0nu8Sfl/WSpa15LAKo/wVMbZ5wMxt+B/1N+Sd9zL8Fwijxh
         IKbKMpkW6US0hf+sdpJOe002UelfIluOsCc/7JurREvjWpb2oKMVGBJD+uZeUtcTQW0D
         +VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083377; x=1755688177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihlo7ylUGW7wZsGWuOHUqv/CYuxjb+ZuvYxiMymfvww=;
        b=RPvZXco0cnl4NtrZE19IAKj23yua7ThkLoMApYssby7XdkerlEmcWzC13cef4JVDKT
         wW/R2ySeF1XjQLNIvcwFweBohvuJH46YP0YATOS4lchgSxAZAO3K21srGOF3YYbF8N2s
         r28z4Q6Kdr05lB22FOVtPbR78ZM/7vtGTQoBKkfP3L1/3J4IpCY2rQZeDZAkJmCSEf0/
         7tsHLz+fiKmZLa6w0juaJJjOEvmfAE4cViJIiAHquCBjQgmpWzMWAWgG0ArpgwzqCuSB
         RAxRzH9G4wslYN3mfuEXKoUvLY7ZQ6Fe7MBRO8n9xY+9Inp9oUUkPoGfXDKUr5Pdhgjt
         Hr7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0DGJImKSZdNkEdsyOU8fxwn1QfA3M+H/pZrnUULTtownWr0kjqczlBtf4/EbPalsXMoZbUksQuF3m6X2c1n3Lb8b@vger.kernel.org, AJvYcCV2tvdhE49G6Mih6DTF7GUsd2Mo4Mn4fWJ97bRADf0QUmNWD4ERTit8sD9bc7tiCNzY+FyL/0XemuLCY0tZ@vger.kernel.org, AJvYcCX6iTnJqluo5WfEIofGcDgoanmGcbHI3xa0DZGiLXdERoUwdjtFcW/yJr7o72Onfu5pkW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv7kPVQu5/QJyMl/qg+nqEAiLZzoV0relVylvCi918woM7SqJC
	OAhyBBIAx+hZNx9WVcGC2ZRR+dF2EtNqMqLu7p8qKc+zy0CzGEmIDA4d
X-Gm-Gg: ASbGncvjW2V6VZBFA5Z3Az4o7e2QKY30+7MpXcX0YzMu+Y5VjifXXkjbfWF/RQHdipK
	zHHcYfXaP+JQZUI2JodrlOrA+qYg0Kr4CODCN3hWCy6CcDFFQiTCxoXUxYFKtAyj5Gnz3Fl2nA2
	Vq3gyVGzoIRg/0GYBXrIDozB42zxuMUtavVMnlG1lzT5TrgfdvFTY0dD5X80uFwc2DK8hRJeqgF
	Awvwa5ACUxQMJmjWkF4nC+cVUH2GaeCBNk7z0yOJKGgujDl4FvBf2bCHKmp8mQVxyc9eNPLetsl
	yDP324KqJCZ0wuOSoKxZWRRfabBD06gjBJVmuVWmFLhYP9WtuP156F749XybQq6A7oKliG6G
X-Google-Smtp-Source: AGHT+IETSOLlR59YRwctEzPBeHp5gfFmJ1QGN0Lmnm3+uuS6XuM5Uw0ufwMK4okqdZJUlZO4IgB3UA==
X-Received: by 2002:a05:6000:22ca:b0:3b8:fb31:a42d with SMTP id ffacd0b85a97d-3b917e88b83mr1526542f8f.34.1755083376430;
        Wed, 13 Aug 2025 04:09:36 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf970sm47108906f8f.25.2025.08.13.04.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:09:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 13 Aug 2025 13:09:33 +0200
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC 00/10] ftrace,bpf: Use single direct ops for bpf trampolines
Message-ID: <aJxybRed6B1Zx_Th@krava>
References: <aIn_12KHz7ikF2t1@krava>
 <aIyNOd18TRLu8EpY@J2N7QTR9R3>
 <aI6CltnCRbVXwyfm@krava>
 <aJMsWB2Sxb7-66zs@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJMsWB2Sxb7-66zs@J2N7QTR9R3>

On Wed, Aug 06, 2025 at 11:20:08AM +0100, Mark Rutland wrote:
> On Sat, Aug 02, 2025 at 11:26:46PM +0200, Jiri Olsa wrote:
> > On Fri, Aug 01, 2025 at 10:49:56AM +0100, Mark Rutland wrote:
> > > On Wed, Jul 30, 2025 at 01:19:51PM +0200, Jiri Olsa wrote:
> > > > On Tue, Jul 29, 2025 at 06:57:40PM +0100, Mark Rutland wrote:
> > > > > 
> > > > > On Tue, Jul 29, 2025 at 12:28:03PM +0200, Jiri Olsa wrote:
> > > > > > hi,
> > > > > > while poking the multi-tracing interface I ended up with just one
> > > > > > ftrace_ops object to attach all trampolines.
> > > > > > 
> > > > > > This change allows to use less direct API calls during the attachment
> > > > > > changes in the future code, so in effect speeding up the attachment.
> > > > > 
> > > > > How important is that, and what sort of speedup does this result in? I
> > > > > ask due to potential performance hits noted below, and I'm lacking
> > > > > context as to why we want to do this in the first place -- what is this
> > > > > intended to enable/improve?
> > > > 
> > > > so it's all work on PoC stage, the idea is to be able to attach many
> > > > (like 20,30,40k) functions to their trampolines quickly, which at the
> > > > moment is slow because all the involved interfaces work with just single
> > > > function/tracempoline relation
> > > 
> > > Do you know which aspect of that is slow? e.g. is that becuase you have
> > > to update each ftrace_ops independently, and pay the synchronization
> > > overhead per-ops?
> > > 
> > > I ask because it might be possible to do some more batching there, at
> > > least for architectures like arm64 that use the CALL_OPS approach.
> > 
> > IIRC it's the rcu sync in register_ftrace_direct and ftrace_shutdown
> > I'll try to profile that case again, there  might have been changes
> > since the last time we did that
> 
> Do you mean synchronize_rcu_tasks()?
> 
> The call in register_ftrace_direct() was removed in commit:
> 
>   33f137143e651321 ("ftrace: Use asynchronous grace period for register_ftrace_direct()")
> 
> ... but in ftrace_shutdown() we still have a call to synchronize_rcu_tasks(),
> and to synchronize_rcu_tasks_rude().
> 
> The call to synchronize_rcu_tasks() is still necessary, but we might be
> abel to batch that better with API changes.
> 
> I think we might be able to remove the call to
> synchronize_rcu_tasks_rude() on architectures with ARCH_WANTS_NO_INSTR,
> since there shouldn't be any instrumentable functions called with RCU
> not watching. That'd need to be checked.
> 
> [...]
> 
> > > > sorry I probably forgot/missed discussion on this, but doing the fast path like in
> > > > x86_64 is not an option in arm, right?
> > > 
> > > On arm64 we have a fast path, BUT branch range limitations means that we
> > > cannot always branch directly from the instrumented function to the
> > > direct func with a single branch instruction. We use ops->direct_call to
> > > handle that case within a common trampoline, which is significantly
> > > cheaper that iterating over the ops and/or looking up the direct func
> > > from a hash.
> > > 
> > > With CALL_OPS, we place a pointer to the ops immediately before the
> > > instrumented function, and have the instrumented function branch to a
> > > common trampoline which can load that pointer (and can then branch to
> > > any direct func as necessary).
> > > 
> > > The instrumented function looks like:
> > > 
> > > 	# Aligned to 8 bytes
> > > 	func - 8:
> > > 		< pointer to ops >
> > 
> > stupid question.. so there's ftrace_ops pointer stored for each function at
> > 'func - 8` ?  why not store the func's direct trampoline address in there?
> 
> Once reason is that today we don't have trampolines for all ops. Since
> branch range limitations can require bouncing through the common ops,
> it's simpler/better to bounce from that to the regular call than to
> bounce from that to a trampoline which makes the regular call.
> 
> We *could* consider adding trampolines, but that comes with a jump in
> complexity that we originally tried to avoid, and a potential
> performance hit for regular ftrace calls. IIUC that will require similar
> synchronization to what we have today, so it's not clearly a win
> generally.
> 
> I'd like to better understand what the real bottleneck is; AFAICT it's
> the tasks-rcu synchronization, and sharing the hash means that you only
> need to do that once. I think that it should be possible to share that
> synchronization across multiple ops updates with some API changes (e.g.
> something like the batching of text_poke on x86).

yea, so rcu does not seem to be the cause anymore (IIRC that was the
case some time ago) it looks like now the time is spent in the ftrace
internals that iterate and update call sites

the test was loop on attach/detach of fentry program

    31.48%  test_progs       [kernel.kallsyms]                               [k] ftrace_replace_code
    10.98%  test_progs       [kernel.kallsyms]                               [k] __ftrace_hash_update_ipmodify
     6.41%  test_progs       [kernel.kallsyms]                               [k] __ftrace_hash_rec_update
     4.69%  test_progs       [kernel.kallsyms]                               [k] ftrace_check_record
     4.59%  test_progs       [kernel.kallsyms]                               [k] ftrace_lookup_ip
     3.65%  swapper          [kernel.kallsyms]                               [k] acpi_os_read_port
     3.40%  test_progs       [kernel.kallsyms]                               [k] srso_alias_return_thunk
     2.97%  test_progs       [kernel.kallsyms]                               [k] srso_alias_safe_ret
     2.67%  test_progs       [kernel.kallsyms]                               [k] ftrace_rec_iter_record
     2.05%  test_progs       [kernel.kallsyms]                               [k] ftrace_test_record
     1.83%  test_progs       [kernel.kallsyms]                               [k] ftrace_rec_iter_next
     1.76%  test_progs       [kernel.kallsyms]                               [k] smp_call_function_many_cond
     1.05%  rcu_tasks_kthre  [kernel.kallsyms]                               [k] rcu_tasks_pertask
     0.70%  test_progs       [kernel.kallsyms]                               [k] btf_find_by_name_kind
     0.61%  swapper          [kernel.kallsyms]                               [k] srso_alias_safe_ret
     0.55%  swapper          [kernel.kallsyms]                               [k] io_idle

so by sharing the hash we do that (iterate and update functions)
just once

jirka


---
    31.48%  test_progs       [kernel.kallsyms]                               [k] ftrace_replace_code
            |          
            |--11.54%--ftrace_replace_code
            |          ftrace_modify_all_code
            |          |          
            |          |--6.06%--ftrace_shutdown.part.0
            |          |          unregister_ftrace_function
            |          |          unregister_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          bpf_trampoline_unlink_prog
            |          |          bpf_tracing_link_release
            |          |          bpf_link_free
            |          |          bpf_link_release
            |          |          __fput
            |          |          __x64_sys_close
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          __syscall_cancel_arch_end
            |          |          __syscall_cancel
            |          |          __close
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --5.47%--ftrace_startup
            |                     register_ftrace_function_nolock
            |                     register_ftrace_direct
            |                     bpf_trampoline_update
            |                     __bpf_trampoline_link_prog
            |                     bpf_trampoline_link_prog
            |                     bpf_tracing_prog_attach
            |                     bpf_raw_tp_link_attach
            |                     __sys_bpf
            |                     __x64_sys_bpf
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     syscall
            |                     skel_raw_tracepoint_open
            |                     fentry_test_lskel__test1__attach
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
            |--8.81%--ftrace_check_record
            |          ftrace_replace_code
            |          ftrace_modify_all_code
            |          |          
            |          |--4.72%--ftrace_shutdown.part.0
            |          |          unregister_ftrace_function
            |          |          unregister_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          bpf_trampoline_unlink_prog
            |          |          bpf_tracing_link_release
            |          |          bpf_link_free
            |          |          bpf_link_release
            |          |          __fput
            |          |          __x64_sys_close
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          __syscall_cancel_arch_end
            |          |          __syscall_cancel
            |          |          __close
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --4.10%--ftrace_startup
            |                     register_ftrace_function_nolock
            |                     register_ftrace_direct
            |                     bpf_trampoline_update
            |                     __bpf_trampoline_link_prog
            |                     bpf_trampoline_link_prog
            |                     bpf_tracing_prog_attach
            |                     bpf_raw_tp_link_attach
            |                     __sys_bpf
            |                     __x64_sys_bpf
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     syscall
            |                     skel_raw_tracepoint_open
            |                     fentry_test_lskel__test1__attach
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
            |--3.60%--ftrace_rec_iter_record
            |          ftrace_replace_code
            |          ftrace_modify_all_code
            |          |          
            |          |--1.91%--ftrace_shutdown.part.0
            |          |          unregister_ftrace_function
            |          |          unregister_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          bpf_trampoline_unlink_prog
            |          |          bpf_tracing_link_release
            |          |          bpf_link_free
            |          |          bpf_link_release
            |          |          __fput
            |          |          __x64_sys_close
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          __syscall_cancel_arch_end
            |          |          __syscall_cancel
            |          |          __close
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --1.69%--ftrace_startup
            |                     register_ftrace_function_nolock
            |                     register_ftrace_direct
            |                     bpf_trampoline_update
            |                     __bpf_trampoline_link_prog
            |                     bpf_trampoline_link_prog
            |                     bpf_tracing_prog_attach
            |                     bpf_raw_tp_link_attach
            |                     __sys_bpf
            |                     __x64_sys_bpf
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     syscall
            |                     skel_raw_tracepoint_open
            |                     fentry_test_lskel__test1__attach
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
            |--3.50%--ftrace_rec_iter_next
            |          ftrace_replace_code
            |          ftrace_modify_all_code
            |          |          
            |          |--2.08%--ftrace_startup
            |          |          register_ftrace_function_nolock
            |          |          register_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          __bpf_trampoline_link_prog
            |          |          bpf_trampoline_link_prog
            |          |          bpf_tracing_prog_attach
            |          |          bpf_raw_tp_link_attach
            |          |          __sys_bpf
            |          |          __x64_sys_bpf
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          syscall
            |          |          skel_raw_tracepoint_open
            |          |          fentry_test_lskel__test1__attach
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --1.42%--ftrace_shutdown.part.0
            |                     unregister_ftrace_function
            |                     unregister_ftrace_direct
            |                     bpf_trampoline_update
            |                     bpf_trampoline_unlink_prog
            |                     bpf_tracing_link_release
            |                     bpf_link_free
            |                     bpf_link_release
            |                     __fput
            |                     __x64_sys_close
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     __syscall_cancel_arch_end
            |                     __syscall_cancel
            |                     __close
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
            |--2.44%--srso_alias_safe_ret
            |          srso_alias_return_thunk
            |          ftrace_replace_code
            |          ftrace_modify_all_code
            |          |          
            |          |--1.36%--ftrace_shutdown.part.0
            |          |          unregister_ftrace_function
            |          |          unregister_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          bpf_trampoline_unlink_prog
            |          |          bpf_tracing_link_release
            |          |          bpf_link_free
            |          |          bpf_link_release
            |          |          __fput
            |          |          __x64_sys_close
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          __syscall_cancel_arch_end
            |          |          __syscall_cancel
            |          |          __close
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --1.07%--ftrace_startup
            |                     register_ftrace_function_nolock
            |                     register_ftrace_direct
            |                     bpf_trampoline_update
            |                     __bpf_trampoline_link_prog
            |                     bpf_trampoline_link_prog
            |                     bpf_tracing_prog_attach
            |                     bpf_raw_tp_link_attach
            |                     __sys_bpf
            |                     __x64_sys_bpf
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     syscall
            |                     skel_raw_tracepoint_open
            |                     fentry_test_lskel__test1__attach
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
             --1.59%--ftrace_test_record
                       ftrace_replace_code
                       ftrace_modify_all_code
                       |          
                       |--0.87%--ftrace_startup
                       |          register_ftrace_function_nolock
                       |          register_ftrace_direct
                       |          bpf_trampoline_update
                       |          __bpf_trampoline_link_prog
                       |          bpf_trampoline_link_prog
                       |          bpf_tracing_prog_attach
                       |          bpf_raw_tp_link_attach
                       |          __sys_bpf
                       |          __x64_sys_bpf
                       |          do_syscall_64
                       |          entry_SYSCALL_64_after_hwframe
                       |          syscall
                       |          skel_raw_tracepoint_open
                       |          fentry_test_lskel__test1__attach
                       |          fentry_test_common
                       |          fentry_test
                       |          test_fentry_test
                       |          run_one_test
                       |          main
                       |          __libc_start_call_main
                       |          __libc_start_main@@GLIBC_2.34
                       |          _start
                       |          
                        --0.72%--ftrace_shutdown.part.0
                                  unregister_ftrace_function
                                  unregister_ftrace_direct
                                  bpf_trampoline_update
                                  bpf_trampoline_unlink_prog
                                  bpf_tracing_link_release
                                  bpf_link_free
                                  bpf_link_release
                                  __fput
                                  __x64_sys_close
                                  do_syscall_64
                                  entry_SYSCALL_64_after_hwframe
                                  __syscall_cancel_arch_end
                                  __syscall_cancel
                                  __close
                                  fentry_test_common
                                  fentry_test
                                  test_fentry_test
                                  run_one_test
                                  main
                                  __libc_start_call_main
                                  __libc_start_main@@GLIBC_2.34
                                  _start

    10.98%  test_progs       [kernel.kallsyms]                               [k] __ftrace_hash_update_ipmodify
            |          
            |--7.90%--__ftrace_hash_update_ipmodify
            |          |          
            |          |--4.27%--ftrace_shutdown.part.0
            |          |          unregister_ftrace_function
            |          |          unregister_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          bpf_trampoline_unlink_prog
            |          |          bpf_tracing_link_release
            |          |          bpf_link_free
            |          |          bpf_link_release
            |          |          __fput
            |          |          __x64_sys_close
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          __syscall_cancel_arch_end
            |          |          __syscall_cancel
            |          |          __close
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --3.63%--ftrace_startup
            |                     register_ftrace_function_nolock
            |                     register_ftrace_direct
            |                     bpf_trampoline_update
            |                     __bpf_trampoline_link_prog
            |                     bpf_trampoline_link_prog
            |                     bpf_tracing_prog_attach
            |                     bpf_raw_tp_link_attach
            |                     __sys_bpf
            |                     __x64_sys_bpf
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     syscall
            |                     skel_raw_tracepoint_open
            |                     fentry_test_lskel__test1__attach
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
             --3.06%--ftrace_lookup_ip
                       __ftrace_hash_update_ipmodify
                       |          
                       |--1.92%--ftrace_startup
                       |          register_ftrace_function_nolock
                       |          register_ftrace_direct
                       |          bpf_trampoline_update
                       |          __bpf_trampoline_link_prog
                       |          bpf_trampoline_link_prog
                       |          bpf_tracing_prog_attach
                       |          bpf_raw_tp_link_attach
                       |          __sys_bpf
                       |          __x64_sys_bpf
                       |          do_syscall_64
                       |          entry_SYSCALL_64_after_hwframe
                       |          syscall
                       |          skel_raw_tracepoint_open
                       |          fentry_test_lskel__test1__attach
                       |          fentry_test_common
                       |          fentry_test
                       |          test_fentry_test
                       |          run_one_test
                       |          main
                       |          __libc_start_call_main
                       |          __libc_start_main@@GLIBC_2.34
                       |          _start
                       |          
                        --1.14%--ftrace_shutdown.part.0
                                  unregister_ftrace_function
                                  unregister_ftrace_direct
                                  bpf_trampoline_update
                                  bpf_trampoline_unlink_prog
                                  bpf_tracing_link_release
                                  bpf_link_free
                                  bpf_link_release
                                  __fput
                                  __x64_sys_close
                                  do_syscall_64
                                  entry_SYSCALL_64_after_hwframe
                                  __syscall_cancel_arch_end
                                  __syscall_cancel
                                  __close
                                  fentry_test_common
                                  fentry_test
                                  test_fentry_test
                                  run_one_test
                                  main
                                  __libc_start_call_main
                                  __libc_start_main@@GLIBC_2.34
                                  _start

     6.41%  test_progs       [kernel.kallsyms]                               [k] __ftrace_hash_rec_update
            |          
            |--3.37%--__ftrace_hash_rec_update
            |          |          
            |          |--1.90%--ftrace_startup
            |          |          register_ftrace_function_nolock
            |          |          register_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          __bpf_trampoline_link_prog
            |          |          bpf_trampoline_link_prog
            |          |          bpf_tracing_prog_attach
            |          |          bpf_raw_tp_link_attach
            |          |          __sys_bpf
            |          |          __x64_sys_bpf
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          syscall
            |          |          skel_raw_tracepoint_open
            |          |          fentry_test_lskel__test1__attach
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --1.47%--ftrace_shutdown.part.0
            |                     unregister_ftrace_function
            |                     unregister_ftrace_direct
            |                     bpf_trampoline_update
            |                     bpf_trampoline_unlink_prog
            |                     bpf_tracing_link_release
            |                     bpf_link_free
            |                     bpf_link_release
            |                     __fput
            |                     __x64_sys_close
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     __syscall_cancel_arch_end
            |                     __syscall_cancel
            |                     __close
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
            |--2.16%--ftrace_lookup_ip
            |          __ftrace_hash_rec_update
            |          |          
            |          |--1.16%--ftrace_shutdown.part.0
            |          |          unregister_ftrace_function
            |          |          unregister_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          bpf_trampoline_unlink_prog
            |          |          bpf_tracing_link_release
            |          |          bpf_link_free
            |          |          bpf_link_release
            |          |          __fput
            |          |          __x64_sys_close
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          __syscall_cancel_arch_end
            |          |          __syscall_cancel
            |          |          __close
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --0.99%--ftrace_startup
            |                     register_ftrace_function_nolock
            |                     register_ftrace_direct
            |                     bpf_trampoline_update
            |                     __bpf_trampoline_link_prog
            |                     bpf_trampoline_link_prog
            |                     bpf_tracing_prog_attach
            |                     bpf_raw_tp_link_attach
            |                     __sys_bpf
            |                     __x64_sys_bpf
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     syscall
            |                     skel_raw_tracepoint_open
            |                     fentry_test_lskel__test1__attach
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
             --0.88%--srso_alias_safe_ret
                       |          
                        --0.79%--__ftrace_hash_rec_update
                                  |          
                                   --0.52%--ftrace_shutdown.part.0
                                             unregister_ftrace_function
                                             unregister_ftrace_direct
                                             bpf_trampoline_update
                                             bpf_trampoline_unlink_prog
                                             bpf_tracing_link_release
                                             bpf_link_free
                                             bpf_link_release
                                             __fput
                                             __x64_sys_close
                                             do_syscall_64
                                             entry_SYSCALL_64_after_hwframe
                                             __syscall_cancel_arch_end
                                             __syscall_cancel
                                             __close
                                             fentry_test_common
                                             fentry_test
                                             test_fentry_test
                                             run_one_test
                                             main
                                             __libc_start_call_main
                                             __libc_start_main@@GLIBC_2.34
                                             _start

     4.69%  test_progs       [kernel.kallsyms]                               [k] ftrace_check_record
            |          
            |--2.04%--ftrace_check_record
            |          ftrace_replace_code
            |          ftrace_modify_all_code
            |          |          
            |          |--1.06%--ftrace_startup
            |          |          register_ftrace_function_nolock
            |          |          register_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          __bpf_trampoline_link_prog
            |          |          bpf_trampoline_link_prog
            |          |          bpf_tracing_prog_attach
            |          |          bpf_raw_tp_link_attach
            |          |          __sys_bpf
            |          |          __x64_sys_bpf
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          syscall
            |          |          skel_raw_tracepoint_open
            |          |          fentry_test_lskel__test1__attach
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --0.98%--ftrace_shutdown.part.0
            |                     unregister_ftrace_function
            |                     unregister_ftrace_direct
            |                     bpf_trampoline_update
            |                     bpf_trampoline_unlink_prog
            |                     bpf_tracing_link_release
            |                     bpf_link_free
            |                     bpf_link_release
            |                     __fput
            |                     __x64_sys_close
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     __syscall_cancel_arch_end
            |                     __syscall_cancel
            |                     __close
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
             --1.28%--ftrace_replace_code
                       ftrace_modify_all_code
                       |          
                        --0.81%--ftrace_startup
                                  register_ftrace_function_nolock
                                  register_ftrace_direct
                                  bpf_trampoline_update
                                  __bpf_trampoline_link_prog
                                  bpf_trampoline_link_prog
                                  bpf_tracing_prog_attach
                                  bpf_raw_tp_link_attach
                                  __sys_bpf
                                  __x64_sys_bpf
                                  do_syscall_64
                                  entry_SYSCALL_64_after_hwframe
                                  syscall
                                  skel_raw_tracepoint_open
                                  fentry_test_lskel__test1__attach
                                  fentry_test_common
                                  fentry_test
                                  test_fentry_test
                                  run_one_test
                                  main
                                  __libc_start_call_main
                                  __libc_start_main@@GLIBC_2.34
                                  _start

     4.59%  test_progs       [kernel.kallsyms]                               [k] ftrace_lookup_ip
            |          
            |--1.99%--__ftrace_hash_update_ipmodify
            |          |          
            |          |--1.03%--ftrace_shutdown.part.0
            |          |          unregister_ftrace_function
            |          |          unregister_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          bpf_trampoline_unlink_prog
            |          |          bpf_tracing_link_release
            |          |          bpf_link_free
            |          |          bpf_link_release
            |          |          __fput
            |          |          __x64_sys_close
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          __syscall_cancel_arch_end
            |          |          __syscall_cancel
            |          |          __close
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --0.96%--ftrace_startup
            |                     register_ftrace_function_nolock
            |                     register_ftrace_direct
            |                     bpf_trampoline_update
            |                     __bpf_trampoline_link_prog
            |                     bpf_trampoline_link_prog
            |                     bpf_tracing_prog_attach
            |                     bpf_raw_tp_link_attach
            |                     __sys_bpf
            |                     __x64_sys_bpf
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     syscall
            |                     skel_raw_tracepoint_open
            |                     fentry_test_lskel__test1__attach
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
            |--1.67%--ftrace_lookup_ip
            |          |          
            |           --1.19%--__ftrace_hash_update_ipmodify
            |                     |          
            |                     |--0.60%--ftrace_shutdown.part.0
            |                     |          unregister_ftrace_function
            |                     |          unregister_ftrace_direct
            |                     |          bpf_trampoline_update
            |                     |          bpf_trampoline_unlink_prog
            |                     |          bpf_tracing_link_release
            |                     |          bpf_link_free
            |                     |          bpf_link_release
            |                     |          __fput
            |                     |          __x64_sys_close
            |                     |          do_syscall_64
            |                     |          entry_SYSCALL_64_after_hwframe
            |                     |          __syscall_cancel_arch_end
            |                     |          __syscall_cancel
            |                     |          __close
            |                     |          fentry_test_common
            |                     |          fentry_test
            |                     |          test_fentry_test
            |                     |          run_one_test
            |                     |          main
            |                     |          __libc_start_call_main
            |                     |          __libc_start_main@@GLIBC_2.34
            |                     |          _start
            |                     |          
            |                      --0.59%--ftrace_startup
            |                                register_ftrace_function_nolock
            |                                register_ftrace_direct
            |                                bpf_trampoline_update
            |                                __bpf_trampoline_link_prog
            |                                bpf_trampoline_link_prog
            |                                bpf_tracing_prog_attach
            |                                bpf_raw_tp_link_attach
            |                                __sys_bpf
            |                                __x64_sys_bpf
            |                                do_syscall_64
            |                                entry_SYSCALL_64_after_hwframe
            |                                syscall
            |                                skel_raw_tracepoint_open
            |                                fentry_test_lskel__test1__attach
            |                                fentry_test_common
            |                                fentry_test
            |                                test_fentry_test
            |                                run_one_test
            |                                main
            |                                __libc_start_call_main
            |                                __libc_start_main@@GLIBC_2.34
            |                                _start
            |          
             --0.81%--__ftrace_hash_rec_update

     3.65%  swapper          [kernel.kallsyms]                               [k] acpi_os_read_port
            |          
            |--1.03%--acpi_os_read_port
            |          acpi_hw_read_port
            |          acpi_hw_read
            |          acpi_hw_register_read
            |          acpi_read_bit_register
            |          acpi_idle_enter_bm
            |          cpuidle_enter_state
            |          cpuidle_enter
            |          do_idle
            |          cpu_startup_entry
            |          |          
            |           --0.97%--start_secondary
            |                     common_startup_64
            |          
            |--0.82%--srso_alias_safe_ret
            |          
             --0.74%--acpi_hw_read
                       acpi_hw_register_read
                       acpi_read_bit_register
                       acpi_idle_enter_bm
                       cpuidle_enter_state
                       cpuidle_enter
                       do_idle
                       cpu_startup_entry
                       |          
                        --0.74%--start_secondary
                                  common_startup_64

     3.40%  test_progs       [kernel.kallsyms]                               [k] srso_alias_return_thunk
            |          
            |--0.85%--ftrace_replace_code
            |          ftrace_modify_all_code
            |          |          
            |           --0.51%--ftrace_startup
            |                     register_ftrace_function_nolock
            |                     register_ftrace_direct
            |                     bpf_trampoline_update
            |                     __bpf_trampoline_link_prog
            |                     bpf_trampoline_link_prog
            |                     bpf_tracing_prog_attach
            |                     bpf_raw_tp_link_attach
            |                     __sys_bpf
            |                     __x64_sys_bpf
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     syscall
            |                     skel_raw_tracepoint_open
            |                     fentry_test_lskel__test1__attach
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
             --0.64%--ftrace_check_record
                       ftrace_replace_code
                       ftrace_modify_all_code

     2.97%  test_progs       [kernel.kallsyms]                               [k] srso_alias_safe_ret
            |          
            |--0.73%--ftrace_check_record
            |          ftrace_replace_code
            |          ftrace_modify_all_code
            |          
             --0.69%--ftrace_replace_code
                       ftrace_modify_all_code

     2.67%  test_progs       [kernel.kallsyms]                               [k] ftrace_rec_iter_record
            |          
            |--1.19%--ftrace_replace_code
            |          ftrace_modify_all_code
            |          |          
            |          |--0.68%--ftrace_startup
            |          |          register_ftrace_function_nolock
            |          |          register_ftrace_direct
            |          |          bpf_trampoline_update
            |          |          __bpf_trampoline_link_prog
            |          |          bpf_trampoline_link_prog
            |          |          bpf_tracing_prog_attach
            |          |          bpf_raw_tp_link_attach
            |          |          __sys_bpf
            |          |          __x64_sys_bpf
            |          |          do_syscall_64
            |          |          entry_SYSCALL_64_after_hwframe
            |          |          syscall
            |          |          skel_raw_tracepoint_open
            |          |          fentry_test_lskel__test1__attach
            |          |          fentry_test_common
            |          |          fentry_test
            |          |          test_fentry_test
            |          |          run_one_test
            |          |          main
            |          |          __libc_start_call_main
            |          |          __libc_start_main@@GLIBC_2.34
            |          |          _start
            |          |          
            |           --0.51%--ftrace_shutdown.part.0
            |                     unregister_ftrace_function
            |                     unregister_ftrace_direct
            |                     bpf_trampoline_update
            |                     bpf_trampoline_unlink_prog
            |                     bpf_tracing_link_release
            |                     bpf_link_free
            |                     bpf_link_release
            |                     __fput
            |                     __x64_sys_close
            |                     do_syscall_64
            |                     entry_SYSCALL_64_after_hwframe
            |                     __syscall_cancel_arch_end
            |                     __syscall_cancel
            |                     __close
            |                     fentry_test_common
            |                     fentry_test
            |                     test_fentry_test
            |                     run_one_test
            |                     main
            |                     __libc_start_call_main
            |                     __libc_start_main@@GLIBC_2.34
            |                     _start
            |          
             --0.69%--ftrace_check_record
                       ftrace_replace_code
                       ftrace_modify_all_code

     2.05%  test_progs       [kernel.kallsyms]                               [k] ftrace_test_record
            |          
             --0.79%--ftrace_replace_code
                       ftrace_modify_all_code

     1.83%  test_progs       [kernel.kallsyms]                               [k] ftrace_rec_iter_next
            |          
             --0.87%--ftrace_replace_code
                       ftrace_modify_all_code
                       |          
                        --0.51%--ftrace_startup
                                  register_ftrace_function_nolock
                                  register_ftrace_direct
                                  bpf_trampoline_update
                                  __bpf_trampoline_link_prog
                                  bpf_trampoline_link_prog
                                  bpf_tracing_prog_attach
                                  bpf_raw_tp_link_attach
                                  __sys_bpf
                                  __x64_sys_bpf
                                  do_syscall_64
                                  entry_SYSCALL_64_after_hwframe
                                  syscall
                                  skel_raw_tracepoint_open
                                  fentry_test_lskel__test1__attach
                                  fentry_test_common
                                  fentry_test
                                  test_fentry_test
                                  run_one_test
                                  main
                                  __libc_start_call_main
                                  __libc_start_main@@GLIBC_2.34
                                  _start

     1.76%  test_progs       [kernel.kallsyms]                               [k] smp_call_function_many_cond
            |          
             --1.73%--smp_call_function_many_cond
                       on_each_cpu_cond_mask
                       |          
                        --1.57%--smp_text_poke_batch_finish
                                  |          
                                   --1.55%--ftrace_modify_all_code
                                             |          
                                             |--0.91%--ftrace_shutdown.part.0
                                             |          unregister_ftrace_function
                                             |          unregister_ftrace_direct
                                             |          bpf_trampoline_update
                                             |          bpf_trampoline_unlink_prog
                                             |          bpf_tracing_link_release
                                             |          bpf_link_free
                                             |          bpf_link_release
                                             |          __fput
                                             |          __x64_sys_close
                                             |          do_syscall_64
                                             |          entry_SYSCALL_64_after_hwframe
                                             |          __syscall_cancel_arch_end
                                             |          __syscall_cancel
                                             |          __close
                                             |          fentry_test_common
                                             |          fentry_test
                                             |          test_fentry_test
                                             |          run_one_test
                                             |          main
                                             |          __libc_start_call_main
                                             |          __libc_start_main@@GLIBC_2.34
                                             |          _start
                                             |          
                                              --0.64%--ftrace_startup
                                                        register_ftrace_function_nolock
                                                        register_ftrace_direct
                                                        bpf_trampoline_update
                                                        __bpf_trampoline_link_prog
                                                        bpf_trampoline_link_prog
                                                        bpf_tracing_prog_attach
                                                        bpf_raw_tp_link_attach
                                                        __sys_bpf
                                                        __x64_sys_bpf
                                                        do_syscall_64
                                                        entry_SYSCALL_64_after_hwframe
                                                        syscall
                                                        skel_raw_tracepoint_open
                                                        fentry_test_lskel__test1__attach
                                                        fentry_test_common
                                                        fentry_test
                                                        test_fentry_test
                                                        run_one_test
                                                        main
                                                        __libc_start_call_main
                                                        __libc_start_main@@GLIBC_2.34
                                                        _start

     1.05%  rcu_tasks_kthre  [kernel.kallsyms]                               [k] rcu_tasks_pertask
            |          
             --0.65%--rcu_tasks_wait_gp
                       rcu_tasks_one_gp
                       rcu_tasks_kthread
                       kthread
                       ret_from_fork
                       ret_from_fork_asm

     0.70%  test_progs       [kernel.kallsyms]                               [k] btf_find_by_name_kind
            |          
             --0.59%--btf_find_by_name_kind


