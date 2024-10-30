Return-Path: <bpf+bounces-43594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5082B9B6B1A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 18:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A668B22189
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D446D21503A;
	Wed, 30 Oct 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTMa8Hg5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF2E213141
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309695; cv=none; b=b+EElYUsvIgwVWAhhFPh7qRQbOWjLVpMYFApQ5Qz3l19SwvqCB4g6iiPoQ2Ngi9OqSr4VZZuQMPucGneOZZxxTnTAK+iyMiwiULAfIzUZ969ucWDLxK2uSfFuWW7jYHEzz0Ge2EyR+ziVq46bdQgcP23qLTt2uJvt8cPe8FG9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309695; c=relaxed/simple;
	bh=KPwdkGTY1KUYgUmrxA+/mIIaxXViEZXUHMyic3I0yyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHCrXB9qUEbLJci95Ynf0CSIANlrhtFA/UBn/HXzZ+uN9G0y1URxSvsWc5uULvVc2cBpowHypn0xrtjVA71bMIFZWNvXP+7e8u+Nrl2zJu+pMYiayXfmU9gUX85oZU3EXSiw4b8Bh9KiM+ZDY/Jy2LyQe0gCNs8dH9FKlmzaFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTMa8Hg5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca03687fdso13655ad.0
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730309693; x=1730914493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fr/v7QLkfA0GAiHtkqMpnE9XqLpgUjitvy/yT6GhlnM=;
        b=iTMa8Hg5oLDf0DLFSc/+e11TMk4I5bJxl4/CNKtk35CAsveZdt9l7pax+kJ1rbWV86
         JMH6R22g1ywQAzQfjPDB8kEzR1pmL1lN45Z/1xTpI1poWUsUUbb9v6ku7CeNUrWuVHOA
         AKWTbU65N1VhQUlkfVexW107DHq5Y9iYyiJ3r6fT5Ozjip0pC4kO1MTE3ToeerSmdYlm
         MXbr/gAbe67b5R7Xit7fqwnf9RJRlaZzy3964fkh5NBgtpRfO8ErExwLVEdwVa0atMsR
         Sv1f2/Y1Wuq5UxB7zOK+eh3M66vdBtBeK6voN6Q+N7wLk7hghV9INAc0yzEEe+ezkjZW
         PthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309693; x=1730914493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fr/v7QLkfA0GAiHtkqMpnE9XqLpgUjitvy/yT6GhlnM=;
        b=ta96L+SWZzAkvAIFsRzFnjt6BSJaJrcQKpg2mNc2Y0WT3eZgTSPhXS55xk9b6sQYsM
         7Elv5v+9KgGRL30OtKq++lrWUhUfImwfEEc8BDl1k6N1x6LEC+slBMHaLFbVLgSXdfcA
         E5x2xgGLbDavsBc0HFWEljFgd7J+Mk4k7wzLlP1jywpEcTL9cnnPouKuqhYpUx7uS00E
         Re68bAG15SVX6lq9gWApNwLAYHDhm7Z+H+Icd8Aq5fNZRFwINojGEo3kBXK/N13zSIFk
         lyQZlvAcMnslQ0fl4XoSMJqzlu3Sd36DTOjo6H8NR10Axj+6ih9zdAKp0g6TY0QvNVfH
         z9jg==
X-Forwarded-Encrypted: i=1; AJvYcCU8snOWdQcdL2Zrchc59/kgosaxTEbloQeyMY4H8HWYpqNvH4TqraBqCAzNlXXUre8tFE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdqBgfNf9ULJDI0wIPVOgtWvGPrNTw9myMdZAD2zLVVR7AWKp
	e+4xtqOTS1XWS702bwwshMn1ddLMCSNny51B/rqf0PRjNagI+Z1nvWL1I2pxyY25ASCMe2pkUly
	4+jbWDibDUo1I4aNJ1igxqbvywxONXpygYvi8
X-Gm-Gg: ASbGncvwunYFhmeWxPlbfrmpupXe3BkRbG4Oh2c+bas4YIsmRxTEWGJ9GenYEDDd923
	iFbkxtjIklTtYiOCGpSHO1XL6bWTZ4uU=
X-Google-Smtp-Source: AGHT+IHiChkccGxHJMZreo9hGuLVUjpwn/OoYgiiz/fN8ZHcjSartBNOlzST5nq/rz9XFUUzvGl81y8Ell4XrCKGQ0A=
X-Received: by 2002:a17:902:c947:b0:20c:675d:920f with SMTP id
 d9443c01a7336-210eb033449mr6388835ad.25.1730309692449; Wed, 30 Oct 2024
 10:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnT59wzKxob03OOOfvVh67MQkpWvzvfmzv3D-_bGeM=rJA@mail.gmail.com>
 <20241029002814.505389-1-jrife@google.com> <CAADnVQJeWj2t9XSRxK5NU99GJsOBnropoOOohDNPj7N2xZFGEQ@mail.gmail.com>
In-Reply-To: <CAADnVQJeWj2t9XSRxK5NU99GJsOBnropoOOohDNPj7N2xZFGEQ@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Wed, 30 Oct 2024 10:34:40 -0700
Message-ID: <CADKFtnTUmRe1T92BQ_NB=V7DW13hAKpA40rm+m6DkpTNf5RyFw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"

> > [  687.334265][T16276] allocated by task 16281 on cpu 1 at 683.953385s (3.380878s ago):
> > [  687.335615][T16276]  tracepoint_add_func+0x28a/0xd90
> > [  687.336424][T16276]  tracepoint_probe_register_prio_may_exist+0xa2/0xf0
> > [  687.337416][T16276]  bpf_probe_register+0x186/0x200
> > [  687.338174][T16276]  bpf_raw_tp_link_attach+0x21f/0x540
> > [  687.339233][T16276]  __sys_bpf+0x393/0x4fa0
> > [  687.340042][T16276]  __x64_sys_bpf+0x78/0xc0
> > [  687.340801][T16276]  do_syscall_64+0xcb/0x250
> > [  687.341623][T16276]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> I think the stack trace points out that the patch [1] isn't really fixing it.
> UAF is on access to bpf_link in __traceiter_sys_enter

The stack trace points to the memory in question being allocated by
tracepoint_add_func where allocation and assignment to
__tracepoint_sys_enter->funcs happens. Mathieu's patch addresses
use-after-free on this structure by using call_rcu_tasks_trace inside
release_probes. In contrast, here is what the "allocated by" trace
looks like for UAF on access to bpf_link (copied from the original
KASAN crash report [4]).

> Allocated by task 5681:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4304
>  kmalloc_noprof include/linux/slab.h:901 [inline]
>  kzalloc_noprof include/linux/slab.h:1037 [inline]
>  bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3829
>  bpf_raw_tracepoint_open+0x177/0x1f0 kernel/bpf/syscall.c:3876
>  __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5691
>  __do_sys_bpf kernel/bpf/syscall.c:5756 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5754 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5754
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

This clearly points to where memory for a bpf_link is allocated.

> link = kzalloc(sizeof(*link), GFP_USER);
> if (!link) {
>     err = -ENOMEM;
>     goto out_put_btp;
> }

To add some context, if I apply Mathieu's patch alone then I get no
meaningful test signal when running the reproducer, because the UAF
crash almost always occurs first on accesses to bpf_link or bpf_prog
showing a trace like the second one above. My intent in applying patch
[1] is to mask out these sources of UAF-related crashes on the BPF
side to just focus on what this series addresses. This series should
eventually be tested end-to-end with Andrii's fix for the BPF stuff
that he mentioned last week, but that would rely on this patch series,
tracepoint_is_faultable() in particular, so it's kind of chicken and
egg in terms of testing. In the meantime, [1] provides a bandaid to
allow some degree of test coverage on this patch.

> while your patch [1] and all attempts to "fix" were delaying bpf_prog.
> The issue is not reproducing anymore due to luck.

[1] chains call_rcu_tasks_trace and call_rcu to free both bpf_prog and
bpf_link after unregistering the trace point. This grace period should
be sufficient to prevent UAF on these structures from the syscall TP
handlers which are protected with rcu_read_lock_trace. I've run the
reproducer many times. Without /some/ fix on the BPF side it crashes
reliably within seconds here. Using call_rcu_tasks_trace or chaining
it with call_rcu eliminates UAF on the BPF stuff which eliminates a
couple of variables for local testing.

If you are not convinced, I'm happy to run through other test
scenarios or run the reproducer for much longer.

-Jordan

