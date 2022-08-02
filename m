Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEFB588430
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiHBWZS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 18:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiHBWZR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 18:25:17 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BBBA9
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 15:25:13 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2FC18240026
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 00:25:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1659479111; bh=jdJTVBlEZCmjiGBIwKG07JVrulm/Lub01jc5uOXjeiY=;
        h=Date:From:To:Cc:Subject:From;
        b=dRzQULPhh8xUGSBSNuI32VLjojGa/ERGk+32yqVUSBzEmOrBdc72jfUEyaHqrubPz
         fh+gmtK46PEsSZMCbfLIRSyZoKBpfhFX+zr6i9jZ2sXDC5/RmQW4bZedoa3eFoq7pz
         dxjBbngNzQP9ABIcN2t4JTC/3bT/tDBS0KSbWQkY9c4fSyYBsYzEaF3Ot5s+ZtUeo/
         VZdx1HTuOYzqQTF6/+UoHEz2oMKc+eFAcNICGctI5IgLUghfeWbRBB4bF4LB0m9beW
         Pgi5s1Do0RIcd0VQ1lUjF9/ZtrnTQTQAJ3XiojT2bjUVqS69NDSpKyKk0PVaCuLu/s
         4NcD1NUWRDHdA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Ly8gn61Xmz6tpF;
        Wed,  3 Aug 2022 00:25:09 +0200 (CEST)
Date:   Tue,  2 Aug 2022 22:25:06 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [BUG] Possible deadlock in bpf_local_storage_update
Message-ID: <20220802222506.h7uekapwj5tioj5a@muellerd-fedora-MJ0AC3F3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I've seen the following deadlock warning when running the test_progs selftest:

[  127.404118] ============================================
[  127.409306] WARNING: possible recursive locking detected
[  127.414534] 5.19.0-rc8-02055-g43fe6c051c85 #257 Tainted: G           OE
[  127.421172] --------------------------------------------
[  127.426256] test_progs/492 is trying to acquire lock:
[  127.431356] ffff8ffe0d6c4bb8 (&storage->lock){+.-.}-{2:2}, at: __bpf_selem_unlink_storage+0x3a/0x150
[  127.440305]
[  127.440305] but task is already holding lock:
[  127.445872] ffff8ffe0d6c4ab8 (&storage->lock){+.-.}-{2:2}, at: bpf_local_storage_update+0x31e/0x490
[  127.454681]
[  127.454681] other info that might help us debug this:
[  127.461171]  Possible unsafe locking scenario:
[  127.461171]
[  127.467377]        CPU0
[  127.469971]        ----
[  127.472497]   lock(&storage->lock);
[  127.475963]   lock(&storage->lock);
[  127.479391]
[  127.479391]  *** DEADLOCK ***
[  127.479391]
[  127.485434]  May be due to missing lock nesting notation
[  127.485434]
[  127.492118] 3 locks held by test_progs/492:
[  127.496484]  #0: ffffffffbaf94b60 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xe0
[  127.505888]  #1: ffff8ffe0d6c4ab8 (&storage->lock){+.-.}-{2:2}, at: bpf_local_storage_update+0x31e/0x490
[  127.514981]  #2: ffffffffbaf957e0 (rcu_read_lock){....}-{1:2}, at: __bpf_prog_enter+0x0/0x100
[  127.523310]
[  127.523310] stack backtrace:
[  127.527574] CPU: 7 PID: 492 Comm: test_progs Tainted: G           OE     5.19.0-rc8-02055-g43fe6c051c85 #257
[  127.536658] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[  127.547462] Call Trace:
[  127.549977]  <TASK>
[  127.552175]  dump_stack_lvl+0x44/0x5b
[  127.555758]  __lock_acquire.cold.74+0x151/0x2aa
[  127.560217]  lock_acquire+0xc9/0x2f0
[  127.563686]  ? __bpf_selem_unlink_storage+0x3a/0x150
[  127.568524]  ? find_held_lock+0x2d/0xa0
[  127.572378]  _raw_spin_lock_irqsave+0x38/0x60
[  127.576532]  ? __bpf_selem_unlink_storage+0x3a/0x150
[  127.581380]  __bpf_selem_unlink_storage+0x3a/0x150
[  127.586044]  bpf_task_storage_delete+0x53/0xb0
[  127.590385]  bpf_prog_730e33528dbd2937_on_lookup+0x26/0x3d
[  127.595673]  bpf_trampoline_6442505865_0+0x47/0x1000
[  127.600533]  ? bpf_local_storage_update+0x250/0x490
[  127.605253]  bpf_local_storage_lookup+0x5/0x130
[  127.609650]  bpf_local_storage_update+0xf1/0x490
[  127.614175]  bpf_sk_storage_get+0xd3/0x130
[  127.618126]  bpf_prog_b4aaeb10c7178354_socket_bind+0x18e/0x297
[  127.623815]  bpf_trampoline_6442474456_1+0x5c/0x1000
[  127.628591]  bpf_lsm_socket_bind+0x5/0x10
[  127.632476]  security_socket_bind+0x30/0x50
[  127.636755]  __sys_bind+0xba/0xf0
[  127.640113]  ? ktime_get_coarse_real_ts64+0xb9/0xc0
[  127.644910]  ? lockdep_hardirqs_on+0x79/0x100
[  127.649438]  ? ktime_get_coarse_real_ts64+0xb9/0xc0
[  127.654215]  ? syscall_trace_enter.isra.16+0x157/0x200
[  127.659255]  __x64_sys_bind+0x16/0x20
[  127.662894]  do_syscall_64+0x3a/0x90
[  127.666456]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  127.671500] RIP: 0033:0x7fbba4b36ceb
[  127.674982] Code: c3 48 8b 15 77 31 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb c2 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 31 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 8
[  127.692457] RSP: 002b:00007fff4e9c9db8 EFLAGS: 00000206 ORIG_RAX: 0000000000000031
[  127.699666] RAX: ffffffffffffffda RBX: 00007fbba5057000 RCX: 00007fbba4b36ceb
[  127.706448] RDX: 000000000000001c RSI: 00007fff4e9c9e40 RDI: 0000000000000035
[  127.713247] RBP: 00007fff4e9c9e00 R08: 0000000000000010 R09: 0000000000000000
[  127.719938] R10: 0000000000000000 R11: 0000000000000206 R12: 000000000040d3a0
[  127.726790] R13: 00007fff4e9ce330 R14: 0000000000000000 R15: 0000000000000000
[  127.733820]  </TASK>

I am not entirely sure I am reading the call trace correctly (or whether it
really is all that accurate for that matter), but one way I could see a
recursive acquisition is if we first acquire the local_storage lock in
bpf_local_storage_update [0], then we call into bpf_local_storage_lookup in line
439 (with the lock still held), and then attempt to acquire it again in line
268.

The config I used is tools/testing/selftests/bpf/config +
tools/testing/selftests/bpf/config.x86_64. I am at synced to 71930846b36 ("net:
marvell: prestera: uninitialized variable bug").

Thanks,
Daniel

[0] https://elixir.bootlin.com/linux/v5.19-rc8/source/kernel/bpf/bpf_local_storage.c#L426
