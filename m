Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3C595EB8
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiHPPEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 11:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiHPPEc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 11:04:32 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F418FD47
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 08:01:59 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10ee900cce0so11915572fac.5
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1ugMil36Xtwd1/JKqCHKq4YVp/gm6cZn6rXrNAhsLYg=;
        b=YonhW7ZsvSSq1LlU1473zmh9bn8mDEW3u3IBe61E0fEG6iCtfKHZ61zAZ9ZaQI+yvU
         W+uVY2FriHHxRqPHB1StJ7rHgZYPYHvmIW1PMemedTOOycvqaMNzEdpim3vX8vKmlGsD
         3vQn1Za+7NBq9+e1Xz1DSVkKlIdplv+E5zhbCksYOQ+/tO4tN4e3sHq4Co/D61htJyed
         TArsJUh1fr0Ixfqxczvz+pYCu/+iVUOI1z8ZJ//eR5zOXnSnSd7ETu2K6X8+sxdRONBF
         44eaS+/X5OgA6XllGhpd5gah5I0HB637F6aI8EB2OqViU1w6n1Q1A7OBcxRmB7u/D6JT
         f0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1ugMil36Xtwd1/JKqCHKq4YVp/gm6cZn6rXrNAhsLYg=;
        b=zKg2mpeZ3VILz4Rqg5hDWleHqNM4WsGzg6yN+50nXRIBB155VZ0O5Y0d6tmWc4BXgT
         NuWfdktaMGgFEBiqLIPimSoODB74dkQziY95IwgW8mMIyBoBiokqy7bvyxeej+sug8kB
         5p8CeHOw8rOh0xuseYdDMg47PKy9nAeRfup1Eli0LP3cC+hPiZ4WiZlPNNQNvQ3tpUpg
         wTWsn/MGM38QVLVbIrFjQIngDHv6U/Fm5KMZoqORlLLwjRuqK+CgkH7ITYuDzJqRbunK
         7YvSqFm0UVTQzfuN9UgtdKyURxPHpGCxVwDmUoKBl4TRuimrv9VbXyEsG8RFG4JJqotH
         S0qA==
X-Gm-Message-State: ACgBeo00V+9tj8/IJYbdS2XLFO7+7gh82/JiMmJORaGmlXKBTRFWA77i
        K1jDWG45PgN6b6XkstB+gfdEZy0VEvtkXFaCkKZqMnnEsQ==
X-Google-Smtp-Source: AA6agR47lZNuu4bYrC/2xpGEcKzszPSh01aBKHkSmrxNtTp8FF+IfEotviWQNwGdbw0s4mwvXylXOvGRgb9GIueL0YM=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr13535837oao.41.1660662119002; Tue, 16
 Aug 2022 08:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002c46ec05e6572415@google.com>
In-Reply-To: <0000000000002c46ec05e6572415@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Aug 2022 11:01:48 -0400
Message-ID: <CAHC9VhQmtggv-P9RoG9mHp8JJMUB-qTWNiKVh8q4ygmdi-x2rA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in sock_has_perm
To:     syzbot <syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com>
Cc:     anton@enomsg.org, bpf@vger.kernel.org, ccross@android.com,
        eparis@parisplace.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com,
        tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 4:00 AM syzbot
<syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16021dfd080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f2886ebe3c7b3459
> dashboard link: https://syzkaller.appspot.com/bug?extid=2f2c6bea25b08dc06f86
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in sock_has_perm+0x258/0x280 security/selinux/hooks.c:4532
> Read of size 8 at addr ffff88807630e480 by task syz-executor.0/8123
>
> CPU: 1 PID: 8123 Comm: syz-executor.0 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description.constprop.0.cold+0xeb/0x467 mm/kasan/report.c:313
>  print_report mm/kasan/report.c:429 [inline]
>  kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
>  sock_has_perm+0x258/0x280 security/selinux/hooks.c:4532
>  selinux_socket_setsockopt+0x3e/0x80 security/selinux/hooks.c:4913
>  security_socket_setsockopt+0x50/0xb0 security/security.c:2249
>  __sys_setsockopt+0x107/0x6a0 net/socket.c:2233
>  __do_sys_setsockopt net/socket.c:2266 [inline]
>  __se_sys_setsockopt net/socket.c:2263 [inline]
>  __x64_sys_setsockopt+0xba/0x150 net/socket.c:2263
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f96c7289279
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f96c842f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 00007f96c739c050 RCX: 00007f96c7289279
> RDX: 0000000000000007 RSI: 0000000000000103 RDI: 0000000000000004
> RBP: 00007f96c72e3189 R08: 0000000000000004 R09: 0000000000000000
> R10: 0000000020000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe7030593f R14: 00007f96c842f300 R15: 0000000000022000
>  </TASK>

SELinux hasn't changed anything in this area for a while, and looking
over everything again just now it still looks sane to me.  I suspect
there is something else going on with respect to socket lifetimes and
SELinux just happens to be the one that catches the use-after-free
first.

-- 
paul-moore.com
