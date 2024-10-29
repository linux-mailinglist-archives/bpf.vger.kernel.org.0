Return-Path: <bpf+bounces-43347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97C9B3F2A
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6723B22564
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 00:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972A0D529;
	Tue, 29 Oct 2024 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4l2KLp4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333A747F
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161701; cv=none; b=k24KBbpJOUJCBv2di1ZKFEIDxCr3O1fUDjRwd6JUo9ota/fEIygp0rM4a2ziH50YIUahhWwzBN+BwQqepSOv/DaIQ9esi+c9+9Q4GRiFK+3K9iSfqHJ9B738uqzQeGVsdPLUdQiK6cIikkalPh98e12089CNRYm2Isi41X0VfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161701; c=relaxed/simple;
	bh=3pRmnqTLsEe/doU6aZDQ02xka0ZETM9FxsORRJZwZ8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ya9+r6FD8MmJFLnD8ASM3V5sggX07A3pqIdorYlFOm7tkdtZGKB4i1jIP6+1CQy45RshsYyqchxVFVVcFYmhGeAG8Sv1BY7njzu88UE4qxsgTLDqz+DkHBj066HYR5m+RwXByvqOvBN45XWEdHeZ3+Bk5HhibBLYhaiu5FNv9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4l2KLp4B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e5bd595374so4055301a91.0
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 17:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730161697; x=1730766497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWeECpBqqzaciS2PKMzGk9FZECMyaNYozRzugiBa/MQ=;
        b=4l2KLp4BkWTavd0uhSnjwgfJde5alnLsI8JxppBh40Pwn8TxDHXWWIhPqh3n4APpS0
         n3+DPlm1PGiSDy6xGg/5+NkigcuM7P25kcfycsN9DibNF44OWm9lKZ58Bj1NuGAtPxsP
         2Sz6jSBC3vUDwYZchdY+gl+H7qBx9sm+QNzgUyDca/yXJo1kQxf0B7w7Cu2Pknu6Ffep
         jbQPMoPSAvoMiMDla5vcIPDKRI3xqx4w+v6cAdeWY1feBuZxVj6WEjxAeCZNutecSdmw
         z6Yc99x8W5SBKsRi/MvS7QMq42B78xNgJhLuh9Ivcczx0VwXN5FHVWOPWG/ihxkRotO4
         pK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730161697; x=1730766497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWeECpBqqzaciS2PKMzGk9FZECMyaNYozRzugiBa/MQ=;
        b=MwbgetxwMCyRKXR7O8Fq2W3a3QpgJRuvx8mdUUpIT97FQU6WuXJsjid8JOvCIKwJZg
         OIKtY7tXwvuz9PRwLThfpZMvqVo7GjHqB9vTgFiqOC9vgfgN2ligzhA/CdA30kMQ4Hew
         NGfquZCJALAf7bRHANQza0ZJ27a/UVYpmyGKQIgeSMNcVkdNMnI0sz6RIbvVzGEA9DmU
         xR0YJNywDLiVuuqxN5zlsg9/W/SUF0EyebqKwE9NECF6Sl70DWxUmtP61YwXG73mGAZZ
         38nXRB3saC3mM68F9zWenAzjHVWY8fsJYbc4bCBCMcFZKOkTaLdfUd++pVk2AcbYrVq2
         aVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3a8kAAgeCBaJqnMAdjzy8pfdT/PFphmI8T9Np8+FOTAAVUuf5tHKD0hOqG0dHz764IWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlOOZoKnfZ4Lx4SmfiAXzdB9pGnpbtS3JOWpaJTGuprfi7NB/
	wlu+u6DPfqIIbG3eE3qmTWsjXYD8Tn50wfCFUgWqSsC0ch5q13gtFYRLbMkRfHVuTBBLvUAjMg=
	=
X-Google-Smtp-Source: AGHT+IGSskt1IjXl2NmxqvSJ7x/YUaqntgamGXEew6QSBlb0tEBwQJhjmiwieRut/ggaVX9sse6BcZha3w==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a17:90a:9f84:b0:2e2:a810:c3e4 with SMTP id
 98e67ed59e1d1-2e92216f9aamr489a91.4.1730161696799; Mon, 28 Oct 2024 17:28:16
 -0700 (PDT)
Date: Tue, 29 Oct 2024 00:28:14 +0000
In-Reply-To: <CADKFtnT59wzKxob03OOOfvVh67MQkpWvzvfmzv3D-_bGeM=rJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CADKFtnT59wzKxob03OOOfvVh67MQkpWvzvfmzv3D-_bGeM=rJA@mail.gmail.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029002814.505389-1-jrife@google.com>
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
From: Jordan Rife <jrife@google.com>
To: jrife@google.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, 
	andrii.nakryiko@gmail.com, ast@kernel.org, bpf@vger.kernel.org, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	mjeanson@efficios.com, namhyung@kernel.org, paulmck@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"

> I can test this later today. Considering there needs to be a fix on
> the BPF side to fully resolve the use-after-free issue reported by
> syzbot, I may combine your v4 patch with the bandaid fix which chains
> call_rcu->call_rcu_tasks_trace I made earlier while running the
> reproducer locally.

Testing this way, the series LGTM. Here's what I did starting from
linux-next tag next-20241028.

1. Applied my patch from [1] to prevent any failures resulting from the
   as-of-yet unpatched BPF code that uses call_rcu(). This lets us
   focus on the effect's of Mathieu's patch series.
2. Ran the reproducer [3] from the original syzbot report [2] on a
   kernel build /without/ Mathieu's v4 patch to confirm that we hit
   a use-after-free bug resulting from the use of call_rcu() inside
   release_probe().
3. Applied the patch series and rebuilt the kernel.
4. Reran the reproducer on the new kernel build to ensure that we don't
   hit the same use-after-free bug anymore.

[1]: https://lore.kernel.org/bpf/20241023145640.1499722-1-jrife@google.com/
[2]: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/
[3]: https://syzkaller.appspot.com/x/repro.syz?x=153ef887980000

Without Mathieu's Patch
=======================
A crash occurs after a few minutes.

jordan@t14:~/contexts/use-after-free$ ssh \
-p 10022 \
-o UserKnownHostsFile=/dev/null  \
-o StrictHostKeyChecking=no \
-o IdentitiesOnly=yes \
root@127.0.0.1 './syz-execprog  -repeat=0 -procs=5 ./repro.syz.txt'
Warning: Permanently added '[127.0.0.1]:10022' (ED25519) to the list of known hosts.
2024/10/28 23:15:39 parsed 1 programs
2024/10/28 23:15:52 executed programs: 0
2024/10/28 23:15:57 executed programs: 34
2024/10/28 23:16:02 executed programs: 90
2024/10/28 23:16:07 executed programs: 121
2024/10/28 23:16:12 executed programs: 152
2024/10/28 23:16:17 executed programs: 165
2024/10/28 23:16:23 executed programs: 177
2024/10/28 23:16:28 executed programs: 209
2024/10/28 23:16:33 executed programs: 228
2024/10/28 23:16:38 executed programs: 251
2024/10/28 23:16:44 executed programs: 273
2024/10/28 23:16:49 executed programs: 316
2024/10/28 23:16:54 executed programs: 338
2024/10/28 23:16:59 executed programs: 352
2024/10/28 23:17:04 executed programs: 376
2024/10/28 23:17:10 executed programs: 404
2024/10/28 23:17:16 executed programs: 419
2024/10/28 23:17:21 executed programs: 433
2024/10/28 23:17:26 executed programs: 460

[  687.323615][T16276] ==================================================================
[  687.325235][T16276] BUG: KFENCE: use-after-free read in __traceiter_sys_enter+0x30/0x50
[  687.325235][T16276] 
[  687.327193][T16276] Use-after-free read at 0xffff88807ec60028 (in kfence-#47):
[  687.328404][T16276]  __traceiter_sys_enter+0x30/0x50
[  687.329338][T16276]  syscall_trace_enter+0x1ea/0x2b0
[  687.330021][T16276]  do_syscall_64+0x1ec/0x250
[  687.330816][T16276]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  687.331826][T16276] 
[  687.332291][T16276] kfence-#47: 0xffff88807ec60000-0xffff88807ec60057, size=88, cache=kmalloc-96
[  687.332291][T16276] 
[  687.334265][T16276] allocated by task 16281 on cpu 1 at 683.953385s (3.380878s ago):
[  687.335615][T16276]  tracepoint_add_func+0x28a/0xd90
[  687.336424][T16276]  tracepoint_probe_register_prio_may_exist+0xa2/0xf0
[  687.337416][T16276]  bpf_probe_register+0x186/0x200
[  687.338174][T16276]  bpf_raw_tp_link_attach+0x21f/0x540
[  687.339233][T16276]  __sys_bpf+0x393/0x4fa0
[  687.340042][T16276]  __x64_sys_bpf+0x78/0xc0
[  687.340801][T16276]  do_syscall_64+0xcb/0x250
[  687.341623][T16276]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  687.342697][T16276] 
[  687.343147][T16276] freed by task 14317 on cpu 1 at 687.273223s (0.069923s ago):
[  687.344352][T16276]  rcu_core+0x7a2/0x14f0
[  687.344996][T16276]  handle_softirqs+0x1d4/0x870
[  687.345797][T16276]  irq_exit_rcu+0xbb/0x120
[  687.346519][T16276]  sysvec_apic_timer_interrupt+0xa8/0xc0
[  687.347432][T16276]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  687.348574][T16276]  check_preemption_disabled+0x22/0x170
[  687.349904][T16276]  rcu_is_watching+0x12/0xc0
[  687.350849][T16276]  lock_release+0x51e/0x6f0
[  687.351758][T16276]  bpf_trace_run2+0x25a/0x580
[  687.352675][T16276]  __bpf_trace_sys_enter+0x6e/0xa0
[  687.353625][T16276]  syscall_trace_enter+0x1ea/0x2b0
[  687.354570][T16276]  do_syscall_64+0x1ec/0x250
[  687.355447][T16276]  entry_SYSCALL_64_after_hwframe+0x77/0x7f


With Mathieu's Patch
====================
No crash after 10m.

jordan@t14:~/contexts/use-after-free$ ssh \
-p 10022 \
-o UserKnownHostsFile=/dev/null \
-o StrictHostKeyChecking=no \
-o IdentitiesOnly=yes root@127.0.0.1 \
'./syz-execprog  -repeat=0 -procs=5 ./repro.syz.txt'
Warning: Permanently added '[127.0.0.1]:10022' (ED25519) to the list of known hosts.
2024/10/29 00:09:00 parsed 1 programs
2024/10/29 00:09:07 executed programs: 0
2024/10/29 00:09:12 executed programs: 10
2024/10/29 00:09:17 executed programs: 51
2024/10/29 00:09:23 executed programs: 82
2024/10/29 00:09:28 executed programs: 103
2024/10/29 00:09:33 executed programs: 125
2024/10/29 00:09:39 executed programs: 134
2024/10/29 00:09:44 executed programs: 147
...
2024/10/29 00:18:06 executed programs: 2671
2024/10/29 00:18:11 executed programs: 2725
2024/10/29 00:18:17 executed programs: 2743
2024/10/29 00:18:22 executed programs: 2772
2024/10/29 00:18:30 executed programs: 2784
2024/10/29 00:18:35 executed programs: 2816
2024/10/29 00:18:40 executed programs: 2842
2024/10/29 00:18:46 executed programs: 2881
2024/10/29 00:18:52 executed programs: 2923
2024/10/29 00:18:57 executed programs: 2947
2024/10/29 00:19:03 executed programs: 2991
2024/10/29 00:19:09 executed programs: 3013
2024/10/29 00:19:16 executed programs: 3052


Tested-by: Jordan Rife <jrife@google.com>


