Return-Path: <bpf+bounces-35882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4F93F46D
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C442282FA3
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D4A14600D;
	Mon, 29 Jul 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djE3hPJq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93C145FF4;
	Mon, 29 Jul 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253657; cv=none; b=GIq+gUgPvgL1L7120vsYPRP9p6YrKwlw6bVq+bv4K1ZsKL4e04HZEk2cXJb23KPAKhUDWD8sCwZDlcXDgKm6zkF6RuTE53ZElaSIyUVHvRIXQ/fJ+kFIs7R8/RZ56nbKtCyM1STew/PBGc5V0aNYckg+QUNxN9ACVDWFJRZdxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253657; c=relaxed/simple;
	bh=HhO3gOtadz5NxqCwWRxbOGXnnJlkpPazryLeQBDq1Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L36gHUwd1zpDO2zLjoKHFRDEVfjTaoYMKayDDX+RpsxjCnQVKppG/nRbGvYalN1++zzjgEFowkUwZXH/bG5MJqZg4/Yr00ySCKz0052vXsVu9ouIvD/QgUOg9/jUqzS+f/70mEg/CwEumO4pIYfesBbgAXSI+0a8/VPkCiTpzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djE3hPJq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ad02501c3so405361066b.2;
        Mon, 29 Jul 2024 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253653; x=1722858453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGhtlitt4jFT4NNOCZG1uHXH4W/p7G3dt9/ZEKOP/QI=;
        b=djE3hPJqwx7yBJ8ZROl4Au3wfja/eyqh9G4ncb02Yyp6a2TZexjucBHa0mXe0aJgzd
         AuKwBPIcFcaGdJQDTgrLcCQg+3XzYiq1CnaEWu5u+WEJdIK5Rp8nhhe+uk8yK1GmRCum
         vKKs1abwV09kW/AYUeVVCWpfH8f0Ds5aJz4SRY8Uky6ZKbi3SeTx9DOMVqsLWPH+lW5O
         F8zqtNxMeSKT3b3sKY4MBmnTCKxj00atMgm+SajFH06bJG7CJY8p6TGZNJeBOHZuf9Rs
         soZ8oHHML7O5PkoY8KzonkptxFKbFFKnPyw51wgBUqPQN9DxW5EwWcEjibv0++w/NuSR
         FQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253653; x=1722858453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGhtlitt4jFT4NNOCZG1uHXH4W/p7G3dt9/ZEKOP/QI=;
        b=VZ1qRsaqpb2fEQOa6ejxLKazLt23b7EWdXz2rGufFEdfEJUr0EU2B56WHQUBzC+Gmg
         ksD5/+8GQoRXsbFVRf7NEXS+I8XzZKhejFWIfL+jceNT1r0rfUXdaRpvOwaXU8Ks/BSY
         cIkFSvxZDjtf624ORPNVWxARE6oVha3N00ZANDL57jcrkuBAiQs5deoEq3JJsYa8rL5y
         LjpFG1W2A5eHhy6byBBhhISNAYfDD6Ub4F30ePkY5JFGWgTtmALjcjr2qdzLsQXQB/EG
         SQjHcNTHHxIwUmhA2lhAyl12UlpRzqOueYbdk5X3NgUABzxb2Ojam7+bGQJsnS5ES3UY
         Fw9w==
X-Forwarded-Encrypted: i=1; AJvYcCWG+oMuGC9namOaQIrNWwL2COluT/4LT8IcIVOu/9ixmIQ6AdatrvOV3QKt96Ks2H0h2X4rDusC6STI8yt5lno9En6z2Fu5hGJMXQegaJg4PvjTFabLc89R7WpS/5qUUg7u5TEKW+t0D5zla1y937cs+ICf3TYnahSis1knkmPZPMy4wbof
X-Gm-Message-State: AOJu0Ywk0lqgkSyv0eEvm9LgK9mfaMgtshCY5rc+e/Lw4b2CY90EF2FX
	jAxMabmhkck66loui8pQGXzF9c9IknmMXz8FHjj8EA2pWfk2Sots
X-Google-Smtp-Source: AGHT+IH2FgCJUz4Jcbhh45I/+8DAJgvJF4slEtF5sI76XM+C65jlS/sgee7/hbSpuIT4YgzaIkyVLQ==
X-Received: by 2002:a17:906:d551:b0:a7a:a3f7:389e with SMTP id a640c23a62f3a-a7d3fdb64c2mr611139766b.6.1722253652618;
        Mon, 29 Jul 2024 04:47:32 -0700 (PDT)
Received: from LPPLJK6X5M3.. ([77.254.224.0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2339fsm499171766b.24.2024.07.29.04.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:47:32 -0700 (PDT)
From: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	qyousef@layalina.io,
	tiozhang@didiglobal.com,
	elver@google.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Subject: [RFC] Printk deadlock in bpf trace called from scheduler context
Date: Mon, 29 Jul 2024 13:46:09 +0200
Message-ID: <20240729114608.1792954-2-radoslaw.zielonek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am currently working on a syzbot-reported bug where bpf
is called from trace_sched_switch. In this scenario, we are still within
the scheduler context, and calling printk can create a deadlock.

I am uncertain about the best approach to fix this issue.
Should we simply forbid such calls, or perhaps we should replace printk
with printk_deferred in the bpf where we are still in scheduler context?

I have created a simple patch to suppress such warnings to test
scheduler context recognition.
Of course, this patch is not intended to be used as a final solution.

Here is an example of lockdeep report:

[   60.261294][ T8343] ======================================================
[   60.261302][ T8343] WARNING: possible circular locking dependency detected
[   60.261310][ T8343] 6.9.0-rc5-00355-g2c8159388952 #19 Not tainted
[   60.261322][ T8343] ------------------------------------------------------
[   60.261330][ T8343] syzbot-repro/8343 is trying to acquire lock:
[   60.261343][ T8343] ffffffff8de0fc38 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x20/0xa0
[   60.261411][ T8343] 
[   60.261411][ T8343] but task is already holding lock:
[   60.261418][ T8343] ffff88813993e658 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x110
[   60.261636][ T8343] 
[   60.261636][ T8343] which lock already depends on the new lock.
[   60.261636][ T8343] 
[   60.261645][ T8343] 
[   60.261645][ T8343] the existing dependency chain (in reverse order) is:
[   60.261652][ T8343] 
[   60.261652][ T8343] -> #2 (&rq->__lock){-.-.}-{2:2}:
[   60.261683][ T8343]        lock_acquire+0x1ad/0x410
[   60.261708][ T8343]        _raw_spin_lock_nested+0x31/0x40
[   60.261753][ T8343]        raw_spin_rq_lock_nested+0x29/0x110
[   60.261776][ T8343]        task_fork_fair+0x61/0x1e0
[   60.261806][ T8343]        sched_cgroup_fork+0x37a/0x410
[   60.261830][ T8343]        copy_process+0x21aa/0x3d70
[   60.261854][ T8343]        kernel_clone+0x228/0x6d0
[   60.261878][ T8343]        user_mode_thread+0x131/0x190
[   60.261903][ T8343]        rest_init+0x23/0x300
[   60.261925][ T8343]        start_kernel+0x48a/0x510
[   60.261951][ T8343]        x86_64_start_reservations+0x2a/0x30
[   60.261976][ T8343]        copy_bootdata+0x0/0xd0
[   60.261997][ T8343]        common_startup_64+0x13e/0x147
[   60.262026][ T8343] 
[   60.262026][ T8343] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[   60.262061][ T8343]        lock_acquire+0x1ad/0x410
[   60.262082][ T8343]        _raw_spin_lock_irqsave+0xd5/0x120
[   60.262110][ T8343]        try_to_wake_up+0x9f/0xae0
[   60.262133][ T8343]        up+0x71/0x90
[   60.262154][ T8343]        console_unlock+0x22e/0x4d0
[   60.262176][ T8343]        vprintk_emit+0x5a1/0x760
[   60.262197][ T8343]        devkmsg_emit+0xda/0x120
[   60.262227][ T8343]        devkmsg_write+0x31b/0x3e0
[   60.262247][ T8343]        do_iter_readv_writev+0x51d/0x740
[   60.262275][ T8343]        vfs_writev+0x390/0xbe0
[   60.262304][ T8343]        do_writev+0x1b0/0x340
[   60.262331][ T8343]        do_syscall_64+0xec/0x210
[   60.262575][ T8343]        entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   60.262607][ T8343] 
[   60.262607][ T8343] -> #0 ((console_sem).lock){-...}-{2:2}:
[   60.263045][ T8343]        validate_chain+0x18f3/0x57a0
[   60.263088][ T8343]        __lock_acquire+0x133b/0x1f60
[   60.263109][ T8343]        lock_acquire+0x1ad/0x410
[   60.263129][ T8343]        _raw_spin_lock_irqsave+0xd5/0x120
[   60.263157][ T8343]        down_trylock+0x20/0xa0
[   60.263197][ T8343]        __down_trylock_console_sem+0x109/0x250
[   60.263223][ T8343]        vprintk_emit+0x27f/0x760
[   60.263243][ T8343]        _printk+0xd5/0x120
[   60.263272][ T8343]        should_fail_ex+0x383/0x4d0
[   60.263293][ T8343]        strncpy_from_user+0x36/0x2d0
[   60.263319][ T8343]        strncpy_from_user_nofault+0x70/0x140
[   60.263351][ T8343]        bpf_probe_read_user_str+0x2a/0x70
[   60.263381][ T8343]        ___bpf_prog_run+0xfab/0xa3e0
[   60.263407][ T8343]        __bpf_prog_run32+0xff/0x150
[   60.263434][ T8343]        bpf_trace_run4+0x25c/0x480
[   60.263454][ T8343]        trace_sched_switch+0x107/0x130
[   60.263478][ T8343]        __schedule+0x7a9/0x1600
[   60.263501][ T8343]        schedule+0x147/0x310
[   60.263521][ T8343]        pipe_wait_readable+0x26c/0x550
[   60.263550][ T8343]        ipipe_prep+0x1b6/0x330
[   60.263570][ T8343]        do_splice+0x210/0x1870
[   60.263601][ T8343]        __se_sys_splice+0x331/0x4a0
[   60.263621][ T8343]        do_syscall_64+0xec/0x210
[   60.263646][ T8343]        entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   60.263678][ T8343] 
[   60.263678][ T8343] other info that might help us debug this:
[   60.263678][ T8343] 
[   60.263685][ T8343] Chain exists of:
[   60.263685][ T8343]   (console_sem).lock --> &p->pi_lock --> &rq->__lock
[   60.263685][ T8343] 
[   60.263722][ T8343]  Possible unsafe locking scenario:
[   60.263722][ T8343] 
[   60.263728][ T8343]        CPU0                    CPU1
[   60.263733][ T8343]        ----                    ----
[   60.263739][ T8343]   lock(&rq->__lock);
[   60.263753][ T8343]                                lock(&p->pi_lock);
[   60.263769][ T8343]                                lock(&rq->__lock);
[   60.263784][ T8343]   lock((console_sem).lock);
[   60.263798][ T8343] 
[   60.263798][ T8343]  *** DEADLOCK ***
[   60.263798][ T8343] 
[   60.263804][ T8343] 2 locks held by syzbot-repro/8343:
[   60.263818][ T8343]  #0: ffff88813993e658 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x110
[   60.263881][ T8343]  #1: ffffffff8df341a0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x16e/0x480
[   60.263941][ T8343] 
[   60.263941][ T8343] stack backtrace:
[   60.263949][ T8343] CPU: 2 PID: 8343 Comm: syzbot-repro Not tainted 6.9.0-rc5-00355-g2c8159388952 #19
[   60.263984][ T8343] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.1 11/11/2019
[   60.263999][ T8343] Call Trace:
[   60.264011][ T8343]  <TASK>
[   60.264021][ T8343]  dump_stack_lvl+0x241/0x360
[   60.264144][ T8343]  ? tcp_gro_dev_warn+0x260/0x260
[   60.264174][ T8343]  ? print_circular_bug+0x12b/0x1a0
[   60.264202][ T8343]  check_noncircular+0x360/0x490
[   60.264228][ T8343]  ? __lock_acquire+0x133b/0x1f60
[   60.264252][ T8343]  ? print_deadlock_bug+0x610/0x610
[   60.264300][ T8343]  ? lockdep_lock+0x121/0x2a0
[   60.264336][ T8343]  ? rcu_is_watching+0x15/0xb0
[   60.264371][ T8343]  ? _find_first_zero_bit+0xe9/0x110
[   60.264404][ T8343]  validate_chain+0x18f3/0x57a0
[   60.264432][ T8343]  ? read_lock_is_recursive+0x20/0x20
[   60.264460][ T8343]  ? prb_first_seq+0x131/0x210
[   60.264492][ T8343]  ? reacquire_held_locks+0x690/0x690
[   60.264516][ T8343]  ? dentry_name+0x73b/0x8b0
[   60.264543][ T8343]  ? this_cpu_in_panic+0x4e/0x80
[   60.264567][ T8343]  ? _prb_read_valid+0xa5a/0xae0
[   60.264599][ T8343]  ? mark_lock+0x9a/0x350
[   60.264621][ T8343]  __lock_acquire+0x133b/0x1f60
[   60.264647][ T8343]  lock_acquire+0x1ad/0x410
[   60.264669][ T8343]  ? down_trylock+0x20/0xa0
[   60.264695][ T8343]  ? prb_final_commit+0x40/0x40
[   60.264724][ T8343]  ? read_lock_is_recursive+0x20/0x20
[   60.264747][ T8343]  ? printk_sprint+0x293/0x300
[   60.264773][ T8343]  ? vprintk_store+0xcdf/0x1110
[   60.264801][ T8343]  _raw_spin_lock_irqsave+0xd5/0x120
[   60.264833][ T8343]  ? down_trylock+0x20/0xa0
[   60.264860][ T8343]  ? _raw_spin_lock+0x40/0x40
[   60.264891][ T8343]  ? __lock_acquire+0x133b/0x1f60
[   60.264915][ T8343]  down_trylock+0x20/0xa0
[   60.264943][ T8343]  __down_trylock_console_sem+0x109/0x250
[   60.264973][ T8343]  ? _printk+0xd5/0x120
[   60.265007][ T8343]  ? console_trylock+0x140/0x140
[   60.265035][ T8343]  ? validate_chain+0x11b/0x57a0
[   60.265060][ T8343]  ? validate_chain+0x11b/0x57a0
[   60.265085][ T8343]  vprintk_emit+0x27f/0x760
[   60.265111][ T8343]  ? printk_sprint+0x300/0x300
[   60.265337][ T8343]  ? noop_count+0x30/0x30
[   60.265370][ T8343]  ? reacquire_held_locks+0x690/0x690
[   60.265397][ T8343]  _printk+0xd5/0x120
[   60.265433][ T8343]  ? reacquire_held_locks+0x690/0x690
[   60.265459][ T8343]  ? panic+0x850/0x850
[   60.265494][ T8343]  ? __lock_acquire+0x133b/0x1f60
[   60.265518][ T8343]  should_fail_ex+0x383/0x4d0
[   60.265547][ T8343]  strncpy_from_user+0x36/0x2d0
[   60.265578][ T8343]  ? mark_lock+0x9a/0x350
[   60.265601][ T8343]  strncpy_from_user_nofault+0x70/0x140
[   60.265637][ T8343]  bpf_probe_read_user_str+0x2a/0x70
[   60.265671][ T8343]  ___bpf_prog_run+0xfab/0xa3e0
[   60.265707][ T8343]  __bpf_prog_run32+0xff/0x150
[   60.265739][ T8343]  ? ___bpf_prog_run+0xa3e0/0xa3e0
[   60.265771][ T8343]  ? __lock_acquire+0x1f60/0x1f60
[   60.265799][ T8343]  ? bpf_trace_run4+0x16e/0x480
[   60.265823][ T8343]  bpf_trace_run4+0x25c/0x480
[   60.265847][ T8343]  ? bpf_trace_run3+0x460/0x460
[   60.265872][ T8343]  ? psi_task_switch+0x39e/0x760
[   60.265899][ T8343]  trace_sched_switch+0x107/0x130
[   60.265927][ T8343]  __schedule+0x7a9/0x1600
[   60.265953][ T8343]  ? schedule+0x8d/0x310
[   60.265981][ T8343]  ? release_firmware_map_entry+0x190/0x190
[   60.266008][ T8343]  ? __lock_acquire+0x1f60/0x1f60
[   60.266031][ T8343]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   60.266065][ T8343]  ? trace_raw_output_contention_end+0xd0/0xd0
[   60.266099][ T8343]  ? schedule+0x8d/0x310
[   60.266123][ T8343]  schedule+0x147/0x310
[   60.266149][ T8343]  pipe_wait_readable+0x26c/0x550
[   60.266185][ T8343]  ? __ia32_sys_pipe+0x40/0x40
[   60.266216][ T8343]  ? wake_bit_function+0x240/0x240
[   60.266254][ T8343]  ipipe_prep+0x1b6/0x330
[   60.266278][ T8343]  do_splice+0x210/0x1870
[   60.266301][ T8343]  ? __lock_acquire+0x1f60/0x1f60
[   60.266326][ T8343]  ? __fget_files+0x28/0x460
[   60.266357][ T8343]  ? wait_for_space+0x2d0/0x2d0
[   60.266381][ T8343]  __se_sys_splice+0x331/0x4a0
[   60.266405][ T8343]  ? __x64_sys_splice+0xf0/0xf0
[   60.266904][ T8343]  ? ktime_get_coarse_real_ts64+0x10b/0x120
[   60.266955][ T8343]  ? __x64_sys_splice+0x21/0xf0
[   60.266979][ T8343]  do_syscall_64+0xec/0x210
[   60.267013][ T8343]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   60.267057][ T8343] RIP: 0033:0x455a9d
[   60.267083][ T8343] Code: c3 e8 77 20 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
[   60.267102][ T8343] RSP: 002b:00007fde015b8808 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
[   60.267127][ T8343] RAX: ffffffffffffffda RBX: 00007fde015b9640 RCX: 0000000000455a9d
[   60.267143][ T8343] RDX: 0000000000000006 RSI: 0000000000000000 RDI: 0000000000000007
[   60.267158][ T8343] RBP: 00007fde015b90c0 R08: 0000000000000019 R09: 0000000000000000
[   60.267175][ T8343] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fde015b9640
[   60.267236][ T8343] R13: 0000000000000010 R14: 000000000041d390 R15: 00007fde01599000
[   60.267257][ T8343]  </TASK>
[   60.669916][ T8343] CPU: 2 PID: 8343 Comm: syzbot-repro Not tainted 6.9.0-rc5-00355-g2c8159388952 #19
[   60.673097][ T8343] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.1 11/11/2019
[   60.675564][ T8343] Call Trace:
[   60.676508][ T8343]  <TASK>
[   60.677326][ T8343]  dump_stack_lvl+0x241/0x360
[   60.678601][ T8343]  ? tcp_gro_dev_warn+0x260/0x260
[   60.680063][ T8343]  ? panic+0x850/0x850
[   60.681196][ T8343]  ? __lock_acquire+0x133b/0x1f60
[   60.682567][ T8343]  should_fail_ex+0x3a2/0x4d0
[   60.683861][ T8343]  strncpy_from_user+0x36/0x2d0
[   60.685212][ T8343]  ? mark_lock+0x9a/0x350
[   60.686400][ T8343]  strncpy_from_user_nofault+0x70/0x140
[   60.687939][ T8343]  bpf_probe_read_user_str+0x2a/0x70
[   60.689367][ T8343]  ___bpf_prog_run+0xfab/0xa3e0
[   60.690704][ T8343]  __bpf_prog_run32+0xff/0x150
[   60.692039][ T8343]  ? ___bpf_prog_run+0xa3e0/0xa3e0
[   60.693433][ T8343]  ? __lock_acquire+0x1f60/0x1f60
[   60.694797][ T8343]  ? bpf_trace_run4+0x16e/0x480
[   60.696215][ T8343]  bpf_trace_run4+0x25c/0x480
[   60.697513][ T8343]  ? bpf_trace_run3+0x460/0x460
[   60.698848][ T8343]  ? psi_task_switch+0x39e/0x760
[   60.700214][ T8343]  trace_sched_switch+0x107/0x130
[   60.701597][ T8343]  __schedule+0x7a9/0x1600
[   60.702825][ T8343]  ? schedule+0x8d/0x310
[   60.704022][ T8343]  ? release_firmware_map_entry+0x190/0x190
[   60.705732][ T8343]  ? __lock_acquire+0x1f60/0x1f60
[   60.707119][ T8343]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   60.708742][ T8343]  ? trace_raw_output_contention_end+0xd0/0xd0
[   60.710414][ T8343]  ? schedule+0x8d/0x310
[   60.711611][ T8343]  schedule+0x147/0x310
[   60.712760][ T8343]  pipe_wait_readable+0x26c/0x550
[   60.714165][ T8343]  ? __ia32_sys_pipe+0x40/0x40
[   60.715516][ T8343]  ? wake_bit_function+0x240/0x240
[   60.716913][ T8343]  ipipe_prep+0x1b6/0x330
[   60.718110][ T8343]  do_splice+0x210/0x1870
[   60.719332][ T8343]  ? __lock_acquire+0x1f60/0x1f60
[   60.720696][ T8343]  ? __fget_files+0x28/0x460
[   60.721973][ T8343]  ? wait_for_space+0x2d0/0x2d0
[   60.723337][ T8343]  __se_sys_splice+0x331/0x4a0
[   60.724643][ T8343]  ? __x64_sys_splice+0xf0/0xf0
[   60.725973][ T8343]  ? ktime_get_coarse_real_ts64+0x10b/0x120
[   60.727592][ T8343]  ? __x64_sys_splice+0x21/0xf0
[   60.728910][ T8343]  do_syscall_64+0xec/0x210
[   60.730168][ T8343]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   60.731826][ T8343] RIP: 0033:0x455a9d
[   60.732894][ T8343] Code: c3 e8 77 20 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
[   60.737996][ T8343] RSP: 002b:00007fde015b8808 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
[   60.740251][ T8343] RAX: ffffffffffffffda RBX: 00007fde015b9640 RCX: 0000000000455a9d
[   60.742350][ T8343] RDX: 0000000000000006 RSI: 0000000000000000 RDI: 0000000000000007
[   60.744495][ T8343] RBP: 00007fde015b90c0 R08: 0000000000000019 R09: 0000000000000000
[   60.746712][ T8343] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fde015b9640
[   60.748850][ T8343] R13: 0000000000000010 R14: 000000000041d390 R15: 00007fde01599000
[   60.750967][ T8343]  </TASK>


---
 include/trace/events/sched.h |  2 ++
 kernel/sched/core.c          |  4 ++++
 kernel/trace/bpf_trace.c     | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9ea4c404bd4e..a5eb2bdd832c 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -10,6 +10,8 @@
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
 
+extern DEFINE_PER_CPU(bool, is_sched_trace_context);
+
 /*
  * Tracepoint for calling kthread_stop, performed to end a kthread:
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ae5ef3013a55..f990b1aa0169 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+DEFINE_PER_CPU(bool, is_sched_trace_context) = false;
+
 #ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
@@ -6523,7 +6525,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
                psi_account_irqtime(rq, prev, next);
                psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
+               this_cpu_write(is_sched_trace_context, true);
                trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
+               this_cpu_write(is_sched_trace_context, false);
 
                /* Also unlocks the rq: */
                rq = context_switch(rq, prev, next, &rf);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..35a9b401d28a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -36,6 +36,8 @@
 #include "trace_probe.h"
 #include "trace.h"
 
+extern DEFINE_PER_CPU(bool, is_sched_trace_context);
+
 #define CREATE_TRACE_POINTS
 #include "bpf_trace.h"
 
@@ -2402,10 +2404,27 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
        run_ctx.bpf_cookie = link->cookie;
        old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
+
+       /*
+        * STOLEN from kfence_report_error
+        * Because we may generate reports in printk-unfriendly parts of the
+        * kernel, such as scheduler code, the use of printk() could deadlock.
+        * Until such time that all printing code here is safe in all parts of
+        * the kernel, accept the risk, and just get our message out (given the
+        * system might already behave unpredictably due to the memory error).
+        * As such, also disable lockdep to hide warnings, and avoid disabling
+        * lockdep for the rest of the kernel.
+        */
+       if (this_cpu_read(is_sched_trace_context))
+               lockdep_off();
+
        rcu_read_lock();
        (void) bpf_prog_run(prog, args);
        rcu_read_unlock();
 
+       if (this_cpu_read(is_sched_trace_context))
+               lockdep_on();
+
        bpf_reset_run_ctx(old_run_ctx);
 out:
        this_cpu_dec(*(prog->active));
-- 
2.43.0



