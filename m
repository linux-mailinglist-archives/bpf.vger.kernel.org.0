Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0280D595F81
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiHPPqK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiHPPpi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 11:45:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9677540
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 08:41:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f20so15435707lfc.10
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ETcTb291U+LQVGzQDxoqXPmvwJRL1DHZCtw/kAWPJKs=;
        b=iMG9agruLuSZJoHKUeKqxb/AV2q+NiGrkld/xQ7F7T8AQpriWl5PjlXoWOfOHpjvxE
         ojHoBeJjeR6hF0d/quBa5gW3Nzgo7KpSqK5X9g6Oal81XMXs3NlaDEziAzorhhPdmXJ2
         u5+ziGLlIk3K9c26xwAOzjEZpFxzoSzO4ITVsZ31RnbVaG71b5HOxOr/u75IAYTx7yzx
         NFFGHrIjF8s3A+psTsr3bFPE3ikRIgVy4vSyS027nvuMGXS6PEjqIZilQjvhjbK1coQs
         OBxo/vIOlbuDBCtk3k+lxOE4WEW7U97jtH0fKeZ4e+1//PjkKMzKEKjVanyAlDT0Vona
         zIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ETcTb291U+LQVGzQDxoqXPmvwJRL1DHZCtw/kAWPJKs=;
        b=DYr5XrG3NxFFk4z5le5mJTTxyBJ5h46A9lBRX/oKDtQI3AX+P8Q7dBCReBSdRcHxoO
         BRWkZvU+K+no3Y2NsfuXh9RP5uXruJP5KApnzLbVKIFyFmEpZq462sZdIjlgz0Vqr+iS
         NJrGPgQG3BBJr7tg01zqlzXVATTAu7xDpvVNtaI+S64mUcmXGdWBTAbtOAkU/Zv20tth
         sD+awWl6OulJqTYUWPT8ZXgRT+N4f+/p0nH8QZmEyPMGClX8H1meRLxq3mCydPpn+rUZ
         nJOlopG0vPO5k/Ef2DJL1hqoeAhgj0cgbL13xn7N+5drjuQxUE7Ftc75gwIbabSlx84s
         soJg==
X-Gm-Message-State: ACgBeo3vSLOdPleHBjnMbwsdf+z0YQIY8lIujRtwjTeP3SlP79YHb/JR
        Ake781Tz79A+9UdhO/XEn9OhEIySa4etoEHnpgwjKQ==
X-Google-Smtp-Source: AA6agR4emIVekADYUUGr+odBqVZs1VV9rhpti9ZtTSlJakfYa8xIKrYnwyLFAfIFQYXKUJSFOCsH/LXoh7+ZxxeFUzk=
X-Received: by 2002:a05:6512:1283:b0:48b:9817:ce2b with SMTP id
 u3-20020a056512128300b0048b9817ce2bmr7021243lfs.417.1660664506516; Tue, 16
 Aug 2022 08:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002c46ec05e6572415@google.com> <CAHC9VhQmtggv-P9RoG9mHp8JJMUB-qTWNiKVh8q4ygmdi-x2rA@mail.gmail.com>
In-Reply-To: <CAHC9VhQmtggv-P9RoG9mHp8JJMUB-qTWNiKVh8q4ygmdi-x2rA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Aug 2022 17:41:34 +0200
Message-ID: <CACT4Y+YmW25fSaRvGOm3Do0LWgR3BqT+-cY8cbsCeYtd-fULqw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in sock_has_perm
To:     Paul Moore <paul@paul-moore.com>
Cc:     syzbot <syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com>,
        anton@enomsg.org, bpf@vger.kernel.org, ccross@android.com,
        eparis@parisplace.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com,
        tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Aug 2022 at 17:02, Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Aug 16, 2022 at 4:00 AM syzbot
> <syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16021dfd080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f2886ebe3c7b3459
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2f2c6bea25b08dc06f86
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in sock_has_perm+0x258/0x280 security/selinux/hooks.c:4532
> > Read of size 8 at addr ffff88807630e480 by task syz-executor.0/8123
> >
> > CPU: 1 PID: 8123 Comm: syz-executor.0 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  print_address_description.constprop.0.cold+0xeb/0x467 mm/kasan/report.c:313
> >  print_report mm/kasan/report.c:429 [inline]
> >  kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
> >  sock_has_perm+0x258/0x280 security/selinux/hooks.c:4532
> >  selinux_socket_setsockopt+0x3e/0x80 security/selinux/hooks.c:4913
> >  security_socket_setsockopt+0x50/0xb0 security/security.c:2249
> >  __sys_setsockopt+0x107/0x6a0 net/socket.c:2233
> >  __do_sys_setsockopt net/socket.c:2266 [inline]
> >  __se_sys_setsockopt net/socket.c:2263 [inline]
> >  __x64_sys_setsockopt+0xba/0x150 net/socket.c:2263
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f96c7289279
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f96c842f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> > RAX: ffffffffffffffda RBX: 00007f96c739c050 RCX: 00007f96c7289279
> > RDX: 0000000000000007 RSI: 0000000000000103 RDI: 0000000000000004
> > RBP: 00007f96c72e3189 R08: 0000000000000004 R09: 0000000000000000
> > R10: 0000000020000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffe7030593f R14: 00007f96c842f300 R15: 0000000000022000
> >  </TASK>
>
> SELinux hasn't changed anything in this area for a while, and looking
> over everything again just now it still looks sane to me.  I suspect
> there is something else going on with respect to socket lifetimes and
> SELinux just happens to be the one that catches the use-after-free
> first.

My completely unfounded guess would be that net/netrom/af_netrom.c
does incorrect socket lifetime management.

Though, that wouldn't explain what Casey mentioned re UDP. But it can
well be 2 separate issues.
