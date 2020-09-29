Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9427CDBF
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgI2Mqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 08:46:32 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:46203 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgI2MqK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 08:46:10 -0400
Received: by mail-io1-f80.google.com with SMTP id y5so1818379iop.13
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 05:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aIH5+9o/WQ3U3fksD3TLsum6UmaiEhIKEW/H6MhmdWk=;
        b=NCljbF+A0d34UUxg8rJlSMOyOictye/yzj5Af7LksApKhYmo5dWuEN4dIi9uCHyclV
         ZWh+UFGL6AytRwXsVpaoMjwrbsjqZ0TrbIhyvbeGce/R5OZ+X4MTUcCZdJpWxl1/5VXO
         aBGVebGmDmrB4fY7lyDCIicWKpmsBwuNtx6Yl4NYBW2h9M0+EpAwP+KYxRTIaF88MNtc
         h75wmrd0D0RCpBZmrOmGgDJSJ+wAdgJSa6vGG6Pz/UFvQo2eRqSBhOlbY86cv4wbJFOt
         9ILvVzRi/rRWEfOXErwE89gHIEq9M07rKXEMOc3McEHOF0chOdsJJdXmo0Zn8vkVjeDJ
         WxJg==
X-Gm-Message-State: AOAM532lcqwNKF6wY9g3pJYYcq5fSc0Ykv4su4jiP1OrylZ6lJbWN0hE
        f5Eopw+GsvxUXoHm4No1y6RJ+5obab8h6VOeyqmbX+tykHCm
X-Google-Smtp-Source: ABdhPJwXmI8uoWFeVU57vW1YfSovrR/LKjfjYU2pu0Qiw8c9CBL2Er2mOJAkOIOmHv3XCnBwKzhAH9Zj40sRAD6sOGgoDx76gFvA
MIME-Version: 1.0
X-Received: by 2002:a92:360d:: with SMTP id d13mr2524504ila.99.1601383568081;
 Tue, 29 Sep 2020 05:46:08 -0700 (PDT)
Date:   Tue, 29 Sep 2020 05:46:08 -0700
In-Reply-To: <000000000000680f2905afd0649c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b98b5505b0732a29@google.com>
Subject: Re: BUG: unable to handle kernel paging request in bpf_trace_run2
From:   syzbot <syzbot+cc36fd07553c0512f5f7@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, davem@davemloft.net,
        dsahern@gmail.com, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@chromium.org, kuba@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, rostedt@goodmis.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit 58956317c8de52009d1a38a721474c24aef74fe7
Author: David Ahern <dsahern@gmail.com>
Date:   Fri Dec 7 20:24:57 2018 +0000

    neighbor: Improve garbage collection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d31675900000
start commit:   12450081 libbpf: Fix native endian assumption when parsing..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d31675900000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d31675900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ac0d21536db480b
dashboard link: https://syzkaller.appspot.com/bug?extid=cc36fd07553c0512f5f7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1365d2c3900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d5f08d900000

Reported-by: syzbot+cc36fd07553c0512f5f7@syzkaller.appspotmail.com
Fixes: 58956317c8de ("neighbor: Improve garbage collection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
