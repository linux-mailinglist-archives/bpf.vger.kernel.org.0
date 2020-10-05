Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF52842A6
	for <lists+bpf@lfdr.de>; Tue,  6 Oct 2020 00:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgJEWq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 18:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgJEWq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 18:46:28 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601937988;
        bh=fsh8Almz6lNAuid9N9lsdYn67WQOxOmLJJ3t0r4ibCA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j4bS3EFxA0iPU+v1h52K2zjONGNHrowqWhfihNHiw5qZsAwNhnDvtjrAYdNI+SR78
         kAJaaipWsn7qGFZ+WMXYMWn7x2TAf4SV9T+E02PUHkJ9hvjRqTYc9yzvuyEcV9f2hi
         lCpJgmv1IYm6tr1+D6VUUUKxGxyvRq/M5mvNjO9Q=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: use raw_spin_trylock() for
 pcpu_freelist_push/pop in NMI
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160193798830.16948.17489142040627481950.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Oct 2020 22:46:28 +0000
References: <20201005165838.3735218-1-songliubraving@fb.com>
In-Reply-To: <20201005165838.3735218-1-songliubraving@fb.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 5 Oct 2020 09:58:38 -0700 you wrote:
> Recent improvements in LOCKDEP highlighted a potential A-A deadlock with
> pcpu_freelist in NMI:
> 
> ./tools/testing/selftests/bpf/test_progs -t stacktrace_build_id_nmi
> 
> [   18.984807] ================================
> [   18.984807] WARNING: inconsistent lock state
> [   18.984808] 5.9.0-rc6-01771-g1466de1330e1 #2967 Not tainted
> [   18.984809] --------------------------------
> [   18.984809] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> [   18.984810] test_progs/1990 [HC2[2]:SC0[0]:HE0:SE1] takes:
> [   18.984810] ffffe8ffffc219c0 (&head->lock){....}-{2:2}, at:
> __pcpu_freelist_pop+0xe3/0x180
> [   18.984813] {INITIAL USE} state was registered at:
> [   18.984814]   lock_acquire+0x175/0x7c0
> [   18.984814]   _raw_spin_lock+0x2c/0x40
> [   18.984815]   __pcpu_freelist_pop+0xe3/0x180
> [   18.984815]   pcpu_freelist_pop+0x31/0x40
> [   18.984816]   htab_map_alloc+0xbbf/0xf40
> [   18.984816]   __do_sys_bpf+0x5aa/0x3ed0
> [   18.984817]   do_syscall_64+0x2d/0x40
> [   18.984818]   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   18.984818] irq event stamp: 12
> [ ... ]
> [   18.984822] other info that might help us debug this:
> [   18.984823]  Possible unsafe locking scenario:
> [   18.984823]
> [   18.984824]        CPU0
> [   18.984824]        ----
> [   18.984824]   lock(&head->lock);
> [   18.984826]   <Interrupt>
> [   18.984826]     lock(&head->lock);
> [   18.984827]
> [   18.984828]  *** DEADLOCK ***
> [   18.984828]
> [   18.984829] 2 locks held by test_progs/1990:
> [ ... ]
> [   18.984838]  <NMI>
> [   18.984838]  dump_stack+0x9a/0xd0
> [   18.984839]  lock_acquire+0x5c9/0x7c0
> [   18.984839]  ? lock_release+0x6f0/0x6f0
> [   18.984840]  ? __pcpu_freelist_pop+0xe3/0x180
> [   18.984840]  _raw_spin_lock+0x2c/0x40
> [   18.984841]  ? __pcpu_freelist_pop+0xe3/0x180
> [   18.984841]  __pcpu_freelist_pop+0xe3/0x180
> [   18.984842]  pcpu_freelist_pop+0x17/0x40
> [   18.984842]  ? lock_release+0x6f0/0x6f0
> [   18.984843]  __bpf_get_stackid+0x534/0xaf0
> [   18.984843]  bpf_prog_1fd9e30e1438d3c5_oncpu+0x73/0x350
> [   18.984844]  bpf_overflow_handler+0x12f/0x3f0
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: use raw_spin_trylock() for pcpu_freelist_push/pop in NMI
    https://git.kernel.org/bpf/bpf-next/c/39d8f0d1026a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


