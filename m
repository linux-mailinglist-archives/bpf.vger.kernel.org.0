Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9E6C4663
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 10:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCVJ3m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCVJ3h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 05:29:37 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD685943D
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 02:29:19 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id r25-20020a056602235900b0074d472df653so9137784iot.2
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 02:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679477359;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwR4H6MGsoLQxINvSfgEoqaiGeIJXbBfzWUEo9uno3E=;
        b=eDc9RkpMjxFlK92xxOtUzPy/zcGlDhX8mKlLSN5o7Yzz1wItG5+GTK+B+TGtYD6Rit
         yx3WxP60whdi3eHWBeEVqHpLrriXoXkLh8sBysCVktb4iHXxUsgzzcwryf0VVOzRJPHH
         UQl2UeqJwtDfAG5l3uWPG0U4wnaXs+TXvza697sVhN5qqbudeEkI8liV4Ce7iMdnq0Gf
         3X4Bp1iy9uPqz06so4ZzUqEL0mC/bjCd//ZFGDHhR8tq2kZM7P+Hal3xU5RZw9zKefaS
         3thxS4Len1HiVXS2ugIhazTpPDur5VMeSw4m1YQH/SUHbi926w357+Jc6idXbVjBzT+Z
         U82w==
X-Gm-Message-State: AO0yUKUDEHix+d3Nw9WoRVo0TVKFs/egKtdf0kmPd9oSO5GmS48TzKsE
        bKDG9h4CjKsvgTudwliqekrHsdBfsiyvrr6LCzJpdUp4JYTp
X-Google-Smtp-Source: AK7set9wiXXV8HcfSnBA3WXXQuxKz+LajL6b0bCizutG2gEq/GuJ4PDA4gkD8fLcC7wmG0GimCb5oA7lyiAD8rOGbOyncXzfWO0+
MIME-Version: 1.0
X-Received: by 2002:a02:9567:0:b0:3c2:b9ba:72f9 with SMTP id
 y94-20020a029567000000b003c2b9ba72f9mr2581039jah.5.1679477359313; Wed, 22 Mar
 2023 02:29:19 -0700 (PDT)
Date:   Wed, 22 Mar 2023 02:29:19 -0700
In-Reply-To: <0000000000006294c805e106db34@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000690cbc05f779cba8@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in bpf_trace_printk
From:   syzbot <syzbot+c49e17557ddb5725583d@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, boqun.feng@gmail.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        fgheet255t@gmail.com, haoluo@google.com, hawk@kernel.org,
        hdanton@sina.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        longman@redhat.com, martin.lau@linux.dev, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        sdf@google.com, song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 05b24ff9b2cfabfcfd951daaa915a036ab53c9e1
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Fri Sep 16 07:19:14 2022 +0000

    bpf: Prevent bpf program recursion for raw tracepoint probes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a653d6c80000
start commit:   a335366bad13 Merge tag 'gpio-fixes-for-v6.0-rc6' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e66520f224211a2
dashboard link: https://syzkaller.appspot.com/bug?extid=c49e17557ddb5725583d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e27480880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12737fbf080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Prevent bpf program recursion for raw tracepoint probes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
