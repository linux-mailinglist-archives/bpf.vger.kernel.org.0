Return-Path: <bpf+bounces-66260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCEB308F4
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 00:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E5AE74CB
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 22:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC122EAD19;
	Thu, 21 Aug 2025 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1En0Hh0O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAD7262F
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814461; cv=none; b=DB8rhOcqoYeWIcUWnzJRbXsUnlUcQ4+F5eCQ/FrdYMexzBsG4TpVwIJty5L4KOTpIDwaAAasyvy5UKuW47eFOEg2RXuxF0eX0//dhLaVC4YChAvpZHmgb+qD/XPzrQ1LB7+pnXEssu0piMJqfmRTt3CP/SOKaAZjNyLkOANgRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814461; c=relaxed/simple;
	bh=oR2JIdU1gkpeGXilTnqiWmTLoi8iE9B5lqJ5qRYWtYI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TH7Ph7tUz95plw+JIuVBOj0G6VD/2KsV01YqPYhQ7uuPj70seISPNk8WIH+/ardiG9I6T1hQsMpEsYsQw73vN0m2e5gKIe/zFvGMzhzESAPjyjSz4m0VWQ/W82RWBb8is2RHz0BmOXF1A+MblVDLVOzZchWqSQrXW326SrddtHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1En0Hh0O; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c169a9720so1810a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814458; x=1756419258; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U9uB6AcszMzN7I+fmrxMM+imJUjDe0MZ814kfq0L1KU=;
        b=1En0Hh0OonJbdgzWh9po92Cnc/k0PaUswzMrFm9kA3zS6yY3ypVCFDAWapJBmW3/9+
         4u9PkIpIzpTS0KZtwktwwv0otzcBHO9GLZfFV4HmJZGw5PrufYPeqPSb+LwzbMT1bbsr
         0rH62RyHuVYKpPANEVr8i9EUs/sjW57A6WF+cLj7OiNZElz15agiyW3OZnQMjv9WzpCx
         T+feHOKwjQa4wdBa8H1LhN6RrQydN1w41/g9/1GkbXbUyaUSzkXnaOxJ4j137P3CRe6J
         vC9RwqJdn1RGOFvCH+KZTvXOCE3885fFe3vliBuC+YrlbeGKblXEzBv8lAVmllLxIf9C
         IK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814458; x=1756419258;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9uB6AcszMzN7I+fmrxMM+imJUjDe0MZ814kfq0L1KU=;
        b=MTJY5Wi6TwYvKz0kA+WhzSva7Lt0UKKuA7lF9ilQUJ+O8a9pR6nv349CP9dobcUvzB
         /+XiW1lvc1a+p1nKoB9WVsPnpsa5WmbimqeZVhaIUJcQcEX3wjRtgCjZOXR/y4fZk+6X
         AANOnQRN1Dq/MyQK+I4BfOrnSlXBvbiNVELr7uj5ucHVJm9NtZ0Ut/Ypg/RrS+2mCstP
         34yAwiktfA5dhxPgDoPT/IrDrzVNMHjMlXOb0qzdXPZl+t7o00GVZO8AtCVxY93t4rwZ
         XRk60FV4rqCU3Zy6oaD5PfI1f/uHGP1RWx0F+JGC0x+e+1DYKzKaM14n7ilu6iPsIy31
         Zlxg==
X-Gm-Message-State: AOJu0YwHDc0o27JLmv1azkAK99zaCYZPwJHoeb/DL9gyh1vCxX4Yqa5l
	wBCfqJx3T+adrgajscDlvSncqZRNLzq/c36WUz2efwyv79ym93pzryXjPpv4hVku7RPq5oxaChM
	Nw96Dcaub7tnyY2dKM0YDIT9aTpetYipUcVYdEkp2z73pQKDbk5vqZD3x
X-Gm-Gg: ASbGncuuJEAD6P4V5WhbSLuOzbwBG/OwcDUJxpP5bNxDj6tWKIhSjlS9R+yDFczxqj1
	foUvkyihJS7PNG62MpzULEmEZZ2QUIjyqfs7v0NKNlYd/PVriD0Hq+pAzLTpNOsuQ/tXIpsyYN4
	RxuXGOmQ8vtad9vzLVx7gEdanXuGzQdfcH9i74WV1Xqr8qudH3+rnkOy8RknyJh8ChZDDXlACjO
	vt0d8raQwXKw6Rw/HfsKAS3OmaqWmmrGqAQzsOUWs6aO00PEWdLIw==
X-Google-Smtp-Source: AGHT+IGBpG1UkZEUFq3Lz+rEyxoN/VsYs6MRR7JRbYIBUdi4xVLmQJ++KqCN6e4tLCBL63MqlokKJP1JmggWnn4dnI4=
X-Received: by 2002:a05:6402:5242:b0:61a:1922:32ac with SMTP id
 4fb4d7f45d1cf-61c1a22b76fmr38503a12.0.1755814457731; Thu, 21 Aug 2025
 15:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 21 Aug 2025 15:14:04 -0700
X-Gm-Features: Ac12FXzmt5FElQX6c6PfgIj23RpMqcZBdWBX8tdjTMpmZrYsk-Ho91DVOsWjcuE
Message-ID: <CANP3RGdfdAuWDexxT8_mt9WP2w4B39i-qo4GLBkQyn2+B7ED2A@mail.gmail.com>
Subject: 6.12.30 x86_64 BPF_LSM doesn't work without (?) fentry/mcount config options
To: bpf <bpf@vger.kernel.org>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, 
	Stanislav Fomichev <sdf@google.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

This is on an Android 6.12 GKI kernel for cuttlefish VM, but the
Android-ness probably shouldn't matter.

$ cat config.bad | grep BPF_LSM
CONFIG_BPF_LSM=y

Trying to attach bpf_lsm_bpf_prog_load hook fails with -EBUSY (always).

So I decided to enable function graph with retval tracing to track
down the source of EBUSY... and it started reliably working.

$ diff config.bad config.works | egrep '^[<>]' | sort
< 6.12.30-android16-5-g5c72e9fabab7-ab13770814
< # CONFIG_ENABLE_DEFAULT_TRACERS is not set
< # CONFIG_FUNCTION_TRACER is not set

> 6.12.30-android16-5-maybe-dirty
> # CONFIG_FPROBE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
> # CONFIG_FUNCTION_PROFILER is not set
> # CONFIG_HID_BPF is not set
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> # CONFIG_LIVEPATCH is not set
> # CONFIG_PSTORE_FTRACE is not set
> CONFIG_BUILDTIME_MCOUNT_SORT=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y
> CONFIG_FUNCTION_GRAPH_RETVAL=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_KPROBES_ON_FTRACE=y
> CONFIG_TASKS_RUDE_RCU=y

The above config diff makes it work (ie. it no longer fails with EBUSY).

I'm not sure which exact option fixes things
(I can test if someone has a more specific guess)

However, I've tracked it down via extensive printk debugging to a pair
of 'bugs'.

(a) there is no 5-byte nop in bpf_lsm hooks in the bad config
(confirmed via disassembly).
this can be fixed (worked around) via:

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 3bc61628ab25..f38744df79c8 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -21,7 +21,8 @@
  * function where a BPF program can be attached.
  */
 #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
-noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
+noinline __attribute__((patchable_function_entry(5))) \
+RET bpf_lsm_##NAME(__VA_ARGS__) \
 {                                              \
        return DEFAULT;                         \
 }

[this is likely wrong for non-x86_64, and probably should be
conditional on something, and may be clang specific...]

AFAICT the existence of a bpf_lsm hook makes no sense without the nop in it.
So this is imho a kernel bug.

(b) this results in a *different* (but valid) 5 byte nop then the
kernel expects (confirmed by disassembly).

0f 1f 44 00 08
vs
0f 1f 44 00 00

It looks to be a compiler (clang I believe) vs tooling (objdump or
kernel itself?) type of problem.
[MCOUNT_USE_OBJTOOL makes me think the compiler is being instructed to
add mcounts that are then replaced with nops, possibly at build time
via objtool????]

Anyway, this can be fixed via:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ccb2f7703c33..e782acbe6ada 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -575,7 +575,8 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
 static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
                                void *old_addr, void *new_addr)
 {
-       const u8 *nop_insn = x86_nops[5];
+       const u8 nop5alt[5] = { 0x0f,0x1f,0x44,0x00,0x08 };
+       const u8 *nop_insn = nop5alt;
        u8 old_insn[X86_PATCH_SIZE];
        u8 new_insn[X86_PATCH_SIZE];
        u8 *prog;

Any thoughts on how to fix this more correctly?

I'm guessing:
(a) the bpf lsm hooks should be tagged with some 'traceable' macro,
which should be arch-specific and empty once mcount/fentry or
something are enabled.
(b) I'm guessing the x86 poke function needs to accept multiple forms
of 5 byte pokes.

But I'm not really sure what would be acceptable here in terms of
*how* to actually implement this.

--
Maciej Zenczykowski, Kernel Networking Developer @ Google

