Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CDD6A8972
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 20:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCBTVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 14:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCBTVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 14:21:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7963B651;
        Thu,  2 Mar 2023 11:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB629B815A3;
        Thu,  2 Mar 2023 19:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752F5C433EF;
        Thu,  2 Mar 2023 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677784891;
        bh=wEIup45xv46tCRSDoT+bWcG5ZslyCy1gPpPIWJles6g=;
        h=Date:From:To:Cc:Subject:From;
        b=ZJJLibcPdXVV8j4kxM4q/YuySbVqkUgb8aw/8kVB5ZI8JnYNEimJkesKpae5FV6OY
         Af55a4s/DQ2YzTlEbOyUjoUUtG7GdevlfGdyr5Z2ZGA9ZIdETJjFDf4j2PHiWLeMgM
         6Xtgon0TEheXZCM6sWUzfo5tGX2I12iXfVdo8+EFwFJakcb3P0lWhdoCkXPpvTYYiu
         VJJ9UUHTGlZ1BKhrP3aDZRcCV+D1SdawOy/OMoq+Q/DchajSFOjYU735DCPd3N0LRi
         RrK/mg/RRrPCKj51xWBEH9b3kjngWLJ93mZjy/VExmyQOId7XxOwD6kBTWgF99uwJA
         XC8gR6WY76/Zw==
Date:   Thu, 2 Mar 2023 11:21:30 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: splat in ikheaders_read (bpftrace)
Message-ID: <20230302112130.6e402a98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kees!

Running tests on net (Linus's tree as of Monday) I get this splat
trying to attach bpftrace to a tracepoint:

[ 2468.945793] kernel BUG at lib/string_helpers.c:1027!
[ 2468.946602] invalid opcode: 0000 [#8] SMP KASAN
[ 2468.947416] CPU: 1 PID: 1094 Comm: tar Tainted: G      D            6.2.0-12879-g040b4d2ce1ad #646
[ 2468.948547] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
[ 2468.949683] RIP: 0010:fortify_panic+0xf/0x20
[ 2468.950291] Code: 85 ff 75 d3 bb ea ff ff ff 89 d8 5b 5d 41 5c 41 5d 41 5e c3 0f 1f 80 00 00 00 00 48 89 fe 48 c7 c7 c0 dd 6b a6 e8 01 73 90 ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 54 55 53 48
[ 2468.952438] RSP: 0018:ffff888011c77d10 EFLAGS: 00010246
[ 2468.953125] RAX: 0000000000000022 RBX: ffff8880129fd400 RCX: ffffffffa528008e
[ 2468.954022] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88806d33338c
[ 2468.954935] RBP: ffff888011c77e00 R08: 0000000000000001 R09: ffff888011c77b67
[ 2468.955788] R10: ffffed100238ef6c R11: 7970636d656d6564 R12: ffff888011c77db0
[ 2468.956719] R13: ffff888011d5e000 R14: ffffffffa5716ef0 R15: ffff8880129fd558
[ 2468.957678] FS:  00007fd375e3d280(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
[ 2468.958729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2468.959482] CR2: 000055b2b8ad81c8 CR3: 000000000f07e006 CR4: 0000000000370ee0
[ 2468.960318] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2468.961109] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2468.961930] Call Trace:
[ 2468.962300]  <TASK>
[ 2468.962611]  ikheaders_read+0x45/0x50 [kheaders]
[ 2468.963178]  kernfs_fop_read_iter+0x1a4/0x2f0
[ 2468.963724]  vfs_read+0x39f/0x4b0
[ 2468.964127]  ? kernel_read+0xc0/0xc0
[ 2468.964563]  ? build_open_flags+0x230/0x230
[ 2468.965041]  ? __fget_light+0xd7/0xf0
[ 2468.965521]  ksys_read+0xc7/0x160
[ 2468.965905]  ? __ia32_sys_pwrite64+0x140/0x140
[ 2468.966385]  do_syscall_64+0x34/0x80
[ 2468.966834]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 2468.967490] RIP: 0033:0x7fd375d01852
[ 2468.968903] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 9a d0 0b 00 e8 55 f6 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
