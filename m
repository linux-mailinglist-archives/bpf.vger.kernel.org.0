Return-Path: <bpf+bounces-55104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE911A783C9
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 23:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A76B189047E
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089F1EA7C6;
	Tue,  1 Apr 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/sXTBia"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414001E47A3
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743541478; cv=none; b=e7YuHaaVTsej3Y71/tmmDQoCaufyEhWQ8etUtheE/rIYMXPg++/kVGUcm8jy25AL5MS4WcxxpyCLXqgY+s7ss5c+vturFsUYqLFXEVubJJDJCWp1Df/CNtoLAFZuAw82cJo+7Pg6yfJmxanX/FplceXf7ghmrENwrw+iBoZjYKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743541478; c=relaxed/simple;
	bh=DHNZV4WcyzYW9HZiWqjB2JVVLlve4+hk9rIx6AAHQuM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CH0hh1O7FJ898s/SfV40T1N6AioTflHCLOJJN6KkIAm1fZWvQlrmm6WFb7BPiaoJUsrAh3WUtb2dTzh2FGHy1YtPuT9bEG5/c8QvB6yYB8Nh4rhSnMt25Ra7dLPQX0q7mps9W9S8l/ivw5l0iZyKc4VlnA0ijAph3O6CYdLH6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/sXTBia; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913958ebf2so4590510f8f.3
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743541475; x=1744146275; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6KDaHX7UvjvJjHQURHPf5835Sq6TtmtrAt/tEYaTOp4=;
        b=m/sXTBia9oSQ0zHKuTu66E+HPkObkCQ0rWIsgtBBmPcN3woiACfaNr7I8IRVzupfzL
         qgkFMVrgGjSRWptsxeORMuDN6npQy33FaF70St3YdCE5hHRAfagxXxIx6dUZD+Et5Ilk
         MAhLEq8wJoOFC25UBrgAfPFDhv+wPUs4W2AXWc3wuW53QXVZ3kTXgkQ4zXm/M2pXvnd5
         MIh/ARjsX03bYslAZ98bFuLqZwbVZk7zHvSPH2xvzLNUmqrmDGlW8QUX4bpf452yYioh
         etfd/kzykHyfwmco7KaFIXIsEMJepvq6E87knxB1Zf+o+QpiTDNQOGjKyzG3pUdbWiFM
         j36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743541475; x=1744146275;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KDaHX7UvjvJjHQURHPf5835Sq6TtmtrAt/tEYaTOp4=;
        b=DD6892jYu9qTRxOOXvCkGazZlCa7Zn4Hzn9fHQV7NRph3q4JnqzkxLrI9HcceNZSD6
         wMAHsggWFqbK5rrVCOik4AMzySwsxvCRj6DKX37A71SS00HA8z0q0dHwCSa1wlFodhGU
         dyCZ4MlfyKko9J8wLYoKSd9S8JPg36rf6eyNTooaKrDJ2a98+vJrzDC6ckLj8L7/dCUh
         TmfHLsEWpsyRrBDCV6H2MBTPpRvTTcekfWcl3tNoNshHEYGnWvEKImuV5LRxAbiGSCDV
         hsxieV/ItWFhrhSy06123nJ3n/tH+vuub0uJpaKj2dhuRVP6nwYIh8Dg79gFSkS5zr3z
         5/sg==
X-Forwarded-Encrypted: i=1; AJvYcCVlodUOLmYHHlMQq0UCCLRn4NWjkAN5eYzMrZ4P8IDqVFBE0AHmLV5Qke4uBPZtjgo4QP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYH2iFzKjgTIindBqGBdb3AGZXUgNs7LS363350AufWpDlgSNM
	culZ2ra85Vzh2PVnPrYIDJrm16z1N2XRlvFrQTex97VnQ6XQ3e4yWLsnSvV78oWzV7iUaiXdII1
	RbuGD2hu4UMwXcvl4WAxraoowzYE=
X-Gm-Gg: ASbGncs1bMyYi/tzRxRRDr7M3TTRzMdcl0x2xXqZJtSw1St8Ve82vXlrwJUqz1NPeJy
	cxAf93aU1SxLDzhSJBrZciPqhbA3Zp4YzVXS4dLfodejlkfmysqvC90ccA2NrAHwpWsgTBGswRb
	DE1Fmp8p9EpWS5L/WHKKeQcRNbbV5KHX6vrvRUQ1V6MiqQfMT7Yt+0
X-Google-Smtp-Source: AGHT+IGf9a5AL3EGnt2/DqTKJV7hiCGwrul6B/zBO180nvNEi8vP/Lnos4jtAh6b0xnoojVXgOjUhXf5/47zD/lKURk=
X-Received: by 2002:a5d:47c1:0:b0:391:30b9:556a with SMTP id
 ffacd0b85a97d-39c29737feemr30105f8f.7.1743541475425; Tue, 01 Apr 2025
 14:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Apr 2025 14:04:22 -0700
X-Gm-Features: AQ5f1JqqtAwJWdqC0Q2oQCTPRYXeWcX9j-ff7zXL6b2bb54Q-e_fkr6GtYAUD9s
Message-ID: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
Subject: uprobe splat in PREEMP_RT
To: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

caught the following splat running uprobe tests in PREEMPT_RT

[  101.862206] ------------[ cut here ]------------
[  101.862212] WARNING: CPU: 0 PID: 16 at include/linux/seqlock.h:221
ri_timer+0x235/0x320
[  101.862226] Modules linked in:
[  101.862233] CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted
6.14.0-12141-g1d0ec9988088 #22 PREEMPT_RT
[  101.862240] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  101.862243] RIP: 0010:ri_timer+0x235/0x320
[  101.862249] Code: 5d 41 5e 41 5f e9 5b f5 b7 ff 65 f7 05 a8 95 ff
04 ff ff ff 7f 0f 85 ad fe ff ff 65 8b 05 57 cf ff 04 85 c0 0f 84 9e
fe ff ff <0f> 0b e9 97 fe ff ff e8 df 7b b8 ff 84 c0 0f 85 43 fe ff ff
e8 52
[  101.862253] RSP: 0018:ffffc9000010fb80 EFLAGS: 00010202
[  101.862257] RAX: 0000000000000001 RBX: ffffffff819c8889 RCX: 0000000000000001
[  101.862260] RDX: 0000000000000000 RSI: ffffffff819c8889 RDI: ffff8881f6a33910
[  101.862262] RBP: ffff888105a1da18 R08: 000000000000000a R09: 000000000000000a
[  101.862265] R10: ffffc9000010f987 R11: 0000000000000000 R12: 1ffff92000021f78
[  101.862267] R13: 0000000000000000 R14: ffffffff819c8860 R15: 0000000000000000
[  101.862292] FS:  0000000000000000(0000) GS:ffff88827005e000(0000)
knlGS:0000000000000000
[  101.862316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.862319] CR2: 00007fffffffe000 CR3: 0000000109d67004 CR4: 00000000003706f0
[  101.862322] Call Trace:
[  101.862325]  <TASK>
[  101.862333]  ? free_ret_instance+0x180/0x180
[  101.862338]  call_timer_fn+0x14c/0x3c0
[  101.862345]  ? lock_release+0xb6/0x250
[  101.862353]  ? detach_if_pending+0x310/0x310
[  101.862363]  ? _raw_spin_unlock_irq+0x28/0x40
[  101.862371]  ? lockdep_hardirqs_on_prepare+0xa7/0x170
[  101.862380]  __run_timers+0x58a/0x980
[  101.862385]  ? free_ret_instance+0x180/0x180
[  101.862396]  ? timer_shutdown_sync+0x20/0x20
[  101.862402]  ? lock_acquire+0x123/0x2b0
[  101.862408]  ? run_timer_softirq+0x11a/0x220
[  101.862414]  ? do_raw_spin_lock+0x11e/0x240
[  101.862419]  ? spin_bug+0x230/0x230
[  101.862422]  ? rtlock_slowlock_locked+0x50a0/0x50a0
[  101.862433]  run_timer_softirq+0x122/0x220
[  101.862503]  handle_softirqs.isra.0+0x136/0x610
[  101.862518]  run_ktimerd+0x47/0xe0
[  101.862524]  smpboot_thread_fn+0x30f/0x8a0
[  101.862531]  ? schedule+0xe2/0x390
[  101.862537]  ? sort_range+0x20/0x20
[  101.862541]  kthread+0x3ac/0x770
[  101.862547]  ? rt_read_trylock+0x1d0/0x1d0
[  101.862554]  ? kthread_is_per_cpu+0xc0/0xc0
[  101.862560]  ? lock_release+0xb6/0x250
[  101.862570]  ? kthread_is_per_cpu+0xc0/0xc0
[  101.862574]  ret_from_fork+0x31/0x70
[  101.862580]  ? kthread_is_per_cpu+0xc0/0xc0
[  101.862586]  ret_from_fork_asm+0x11/0x20
[  101.862604]  </TASK>
[  101.862606] irq event stamp: 13032
[  101.862608] hardirqs last  enabled at (13034): [<ffffffff8150094a>]
vprintk_store+0x72a/0x850
[  101.862613] hardirqs last disabled at (13035): [<ffffffff8150061d>]
vprintk_store+0x3fd/0x850
[  101.862615] softirqs last  enabled at (12922): [<ffffffff8136e049>]
run_ktimerd+0x69/0xe0
[  101.862618] softirqs last disabled at (12928): [<ffffffff813ef4bf>]
smpboot_thread_fn+0x30f/0x8a0
[  101.862621] ---[ end trace 0000000000000000 ]---

Looks like write_seqcount_begin(&utask->ri_seqcount);
use in ri_timer() needs a fix ?

