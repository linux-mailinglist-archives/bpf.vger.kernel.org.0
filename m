Return-Path: <bpf+bounces-30118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE698CB087
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855871F22B55
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C7131BDD;
	Tue, 21 May 2024 14:31:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A0131BD3;
	Tue, 21 May 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301866; cv=none; b=byhO8WKxfF84She+wM9VucFaQbNBtoIRQbyJo+Gi6sbpZjs/VU1R1CBYd0IrziQPzn9dPe2jp0eCVupIYmV7/XdIAL/CYUzgS04vk+TWZ2evMA3hJcVbpZOdHYOdT5HCNzSI6a+VTy++k8RR6k2j1PIzY8WTangu5FpaMbpye6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301866; c=relaxed/simple;
	bh=3lDDUrOjVCtG0U2Uql/f9korWE0kx+Vl6201u/dTqtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUDatUdscC4cPfcZzpk+UEBKZlRYBPqpAh13Bj1Zdfv5tkA67UOMwdRva3hWTzYcf2KBDobkibZqTeT92ziDTyVYbMhBd8ddzX42DUMkidF11RdfM/4g7seE/hf0xwjAtt1zpMSih6RI+Xjz9zfikvQ8ELjgjBzaEV8Xyx/2jKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so874023066b.0;
        Tue, 21 May 2024 07:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716301863; x=1716906663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXNL2+dmhPtXa1nU4mFWOb6y7z207mbWeg1zt84oRH0=;
        b=HdGFF6Ep3ucF8zQ5/ojGoCxYtWo1W7UoFrmZai1iWEtujtxvZG0n/9MIoJ7ugICrrN
         IuxLJ95O0lRzHBXUykJexYqjs3Znv+O8bMdwrWS2N/EH51WhM4rpcwNGoAH2c/yXTpnH
         fZv9Dk85VDGOHHdljCu/UWWJhtnGfh/p71yDBDTJjJu5tl6NNtVD39bYOCmugOu8xpjn
         8e7s6CpwkXN+A8Y7R/3zabC+7sM+xH6BvgIlQ7vsh1TPfKAnMXGu8CqtECcZxNrHx90j
         mrDksFh39bOWtZ0g2+uVrBnwc/Dpi08gOmTYVdbidAm4NKX54z8KwofMHcbImPlcmNxO
         booA==
X-Forwarded-Encrypted: i=1; AJvYcCWjAGahy3F+ISsOBbWgLokL7Qcts+CPMN+bKgm9gkainnHrTdbMFYVCblgbLZ9SsoiUX2sFizTQzUmd/mF1/6jzn9gV
X-Gm-Message-State: AOJu0Ywwnz+x0YupQOHHpFE4f7+5F2KFfNJZmtdOm7WDSv768jpo4zM1
	pQGZbXVVVtRz9twfxOJyDriCR8jvvqATpEafZUoHMoIeXFrHjZ/k
X-Google-Smtp-Source: AGHT+IEBifjKnlSnLw01leD/HUpygwLKHdnIzNg/giNMtlk+W2hyeKWuhfRrCeQwx/FolYvSjR5u8g==
X-Received: by 2002:a17:906:f5a2:b0:a5f:d17d:cddf with SMTP id a640c23a62f3a-a5fd17dce72mr580772466b.44.1716301862761;
        Tue, 21 May 2024 07:31:02 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b179casm1610057766b.203.2024.05.21.07.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:31:02 -0700 (PDT)
Date: Tue, 21 May 2024 07:31:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org, oleg@redhat.com,
	jolsa@kernel.org
Subject: Re: [PATCH] uprobes: prevent mutex_lock() under rcu_read_lock()
Message-ID: <ZkywJEJPoy0aZnjg@gmail.com>
References: <20240521053017.3708530-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521053017.3708530-1-andrii@kernel.org>

On Mon, May 20, 2024 at 10:30:17PM -0700, Andrii Nakryiko wrote:
> Recent changes made uprobe_cpu_buffer preparation lazy, and moved it
> deeper into __uprobe_trace_func(). This is problematic because
> __uprobe_trace_func() is called inside rcu_read_lock()/rcu_read_unlock()
> block, which then calls prepare_uprobe_buffer() -> uprobe_buffer_get() ->
> mutex_lock(&ucb->mutex), leading to a splat about using mutex under
> non-sleepable RCU:
> 
>   BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
>    in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 98231, name: stress-ng-sigq
>    preempt_count: 0, expected: 0
>    RCU nest depth: 1, expected: 0
>    ...
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x3d/0xe0
>     __might_resched+0x24c/0x270
>     ? prepare_uprobe_buffer+0xd5/0x1d0
>     __mutex_lock+0x41/0x820
>     ? ___perf_sw_event+0x206/0x290
>     ? __perf_event_task_sched_in+0x54/0x660
>     ? __perf_event_task_sched_in+0x54/0x660
>     prepare_uprobe_buffer+0xd5/0x1d0
>     __uprobe_trace_func+0x4a/0x140
>     uprobe_dispatcher+0x135/0x280
>     ? uprobe_dispatcher+0x94/0x280
>     uprobe_notify_resume+0x650/0xec0
>     ? atomic_notifier_call_chain+0x21/0x110
>     ? atomic_notifier_call_chain+0xf8/0x110
>     irqentry_exit_to_user_mode+0xe2/0x1e0
>     asm_exc_int3+0x35/0x40
>    RIP: 0033:0x7f7e1d4da390
>    Code: 33 04 00 0f 1f 80 00 00 00 00 f3 0f 1e fa b9 01 00 00 00 e9 b2 fc ff ff 66 90 f3 0f 1e fa 31 c9 e9 a5 fc ff ff 0f 1f 44 00 00 <cc> 0f 1e fa b8 27 00 00 00 0f 05 c3 0f 1f 40 00 f3 0f 1e fa b8 6e
>    RSP: 002b:00007ffd2abc3608 EFLAGS: 00000246
>    RAX: 0000000000000000 RBX: 0000000076d325f1 RCX: 0000000000000000
>    RDX: 0000000076d325f1 RSI: 000000000000000a RDI: 00007ffd2abc3690
>    RBP: 000000000000000a R08: 00017fb700000000 R09: 00017fb700000000
>    R10: 00017fb700000000 R11: 0000000000000246 R12: 0000000000017ff2
>    R13: 00007ffd2abc3610 R14: 0000000000000000 R15: 00007ffd2abc3780
>     </TASK>
> 
> Luckily, it's easy to fix by moving prepare_uprobe_buffer() to be called
> slightly earlier: into uprobe_trace_func() and uretprobe_trace_func(), outside
> of RCU locked section. This still keeps this buffer preparation lazy and helps
> avoid the overhead when it's not needed. E.g., if there is only BPF uprobe
> handler installed on a given uprobe, buffer won't be initialized.
> 
> Note, the other user of prepare_uprobe_buffer(), __uprobe_perf_func(), is not
> affected, as it doesn't prepare buffer under RCU read lock.
> 
> Fixes: 1b8f85defbc8 ("uprobes: prepare uprobe args buffer lazily")
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Tested-by: Breno Leitao <leitao@debian.org>

