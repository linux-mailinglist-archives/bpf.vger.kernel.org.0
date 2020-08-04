Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760A523B97A
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgHDLVP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgHDLVN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Aug 2020 07:21:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F4EC06174A
        for <bpf@vger.kernel.org>; Tue,  4 Aug 2020 04:21:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c4so4745589otf.12
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2020 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=3a5vLr5k8cxcV0GW3hqVvUTItgt4IHPsyIl6nemaRvg=;
        b=OnLP73igUlLk8v0lSaG+4ibJbko3t/3xPeV1oioM/YQZbh/7OVerXg2TFOJvcbfprf
         We/BXCgzCHdhV3RRIfPXOOpqNzZG7GHeCusQLiUbH8ksLkckV7BAFKRX17ofoLXgWkra
         pKjURyJuZcDwrfb+iNFXqDxRYSPk2ctFDxuCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3a5vLr5k8cxcV0GW3hqVvUTItgt4IHPsyIl6nemaRvg=;
        b=J61MWYaruBy+D8Jsr8+O8ZoxXinnYKQggM95STeZ/aqmZ3PBaDaMATvBA3/XJOTCgs
         8DilXkMWh0APdUDD4XjVvAvR43ONFzn0r9HF5iriGlmiQTh0UuJcw0QVMi1pEe5VOBpA
         xRaEAwaBBxR5L7nRt/dRQel/WplSmcv7/Eif/DKtxyVf60NwgCR0svuZZdPjlS4BAnIf
         3SaHmMlVHcTY8O4TdEDdntb4OEd468mVDvItd/+z1x7Gd7D3nECPKwTc6xfPmiRnVvuJ
         b+us94DOb/aftGYSZ2rUsezWNqkZLBTj1cCEjYByUeewIiBEPBEMJixlsw5apOW4Sdzu
         XrTg==
X-Gm-Message-State: AOAM531cT9ZPwXXaodbWVxc1HHtBtnTJ16D0bHEdswiznYET4BfyqKqQ
        V3jd7bJCO8gijLKAnrl3K8MnCxNXQyM+JaXlBhX8lEuK2pU=
X-Google-Smtp-Source: ABdhPJwlOTn1biI3hrCjXOmuA9TGhOEIvjwNciPMvpYMPrY5tiRvRrCDlxhvwZfsUYlHJwpCZL1xcHK1Utq5DBrsJCw=
X-Received: by 2002:a9d:148:: with SMTP id 66mr16832695otu.132.1596540071901;
 Tue, 04 Aug 2020 04:21:11 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 4 Aug 2020 12:21:01 +0100
Message-ID: <CACAyw99CPB-9bDdvodkYWA6Wwjqov+WkZ-5TZetmfuE3Swe=EQ@mail.gmail.com>
Subject: BUG: Invalid wait context in bpf_sk_storage_free
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi list,

I just got this warning while running test progs on commit
21594c44083c375697d418729c4b2e4522cf9f70 in the #4/22
bpf_sk_storage_map test.

[   38.775254] =============================
[   38.775692] [ BUG: Invalid wait context ]
[   38.776234] 5.8.0-rc6+ #35 Not tainted
[   38.776699] -----------------------------
[   38.777141] test_progs/254 is trying to lock:
[   38.777650] ffff8881197f4450 (&krcp->lock){....}-{3:3}, at:
kfree_call_rcu+0x1a6/0x5b0
[   38.778589] other info that might help us debug this:
[   38.779155] context-{5:5}
[   38.779476] 3 locks held by test_progs/254:
[   38.779944]  #0: ffff88810dc3f020
(&sb->s_type->i_mutex_key#6){+.+.}-{4:4}, at:
__sock_release+0x76/0x280
[   38.780957]  #1: ffffffff83d66840 (rcu_read_lock){....}-{1:3}, at:
bpf_sk_storage_free+0x0/0x2a0
[   38.781878]  #2: ffff88810b6940b8 (&sk_storage->lock){+...}-{2:2},
at: bpf_sk_storage_free+0xa3/0x2a0
[   38.782812] stack backtrace:
[   38.783115] CPU: 1 PID: 254 Comm: test_progs Not tainted 5.8.0-rc6+ #35
[   38.783789] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1 04/01/2014
[   38.784711] Call Trace:
[   38.784976]  dump_stack+0x9e/0xe0
[   38.785429]  __lock_acquire.cold+0x3a6/0x46c
[   38.786025]  ? register_lock_class+0x17a0/0x17a0
[   38.786588]  lock_acquire+0x1be/0x7e0
[   38.787010]  ? kfree_call_rcu+0x1a6/0x5b0
[   38.787421]  ? check_flags+0x60/0x60
[   38.787790]  ? mark_lock+0x12c/0x1470
[   38.788179]  ? check_chain_key+0x215/0x5a0
[   38.788613]  ? print_usage_bug+0x1f0/0x1f0
[   38.789036]  _raw_spin_lock+0x2c/0x70
[   38.789415]  ? kfree_call_rcu+0x1a6/0x5b0
[   38.789829]  kfree_call_rcu+0x1a6/0x5b0
[   38.790239]  __selem_unlink_sk+0x1eb/0x520
[   38.790691]  bpf_sk_storage_free+0x118/0x2a0
[   38.791138]  __sk_destruct+0xd3/0x4d0
[   38.791525]  inet_release+0xf4/0x220
[   38.791939]  __sock_release+0xc0/0x280
[   38.792328]  sock_close+0xf/0x20
[   38.792676]  __fput+0x29b/0x7b0
[   38.793004]  task_work_run+0xcc/0x170
[   38.793429]  __prepare_exit_to_usermode+0x1c6/0x1d0
[   38.793948]  do_syscall_64+0x62/0xa0
[   38.794407]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   38.795004] RIP: 0033:0x7f73410e33d7
[   38.795376] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 f3 fb
ff ff
[   38.797266] RSP: 002b:00007ffc86615fe8 EFLAGS: 00000246 ORIG_RAX:
0000000000000003
[   38.798030] RAX: 0000000000000000 RBX: 00007ffc86616040 RCX: 00007f73410e33d7
[   38.798755] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
[   38.799488] RBP: 000055fa708beb60 R08: 0000000000000007 R09: 000000000000002c
[   38.800241] R10: 000055fa6abd508d R11: 0000000000000246 R12: 000000000000000d
[   38.801007] R13: 00007ffc86616034 R14: 000000000000000c R15: 000055fa708bcb30

Not sure if this is useful or not, a quick search in the mailing list
didn't bring anything up.

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
