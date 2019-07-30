Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591487B23B
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2019 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfG3SoB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jul 2019 14:44:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36993 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbfG3SoB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jul 2019 14:44:01 -0400
Received: by mail-io1-f72.google.com with SMTP id v3so72443570ios.4
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2019 11:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fmJowBjHOviryjb2uUOgQ9a1aEAnn80EMfZUz4dp24E=;
        b=IHwToVAakfcQ8PYShFmCqSj5um3a+NpKXjb20JS7VYKR7uE5i5TaQRI0ZZBomwwaM+
         Bs1jrNAJbhgpREZYHs36c8SPNgrUxka/eC3a8xujE4xcnkt91xDS26vySnL1O+7loQT5
         j+zSLpKOCIjUAS88RXJQyZ3hyjZUCTW/Gl54tIisfIobsE4RbuJmFBxQULlkKomUqxnL
         d5hsUgf+a9pfl/aXdFPEGFuFhb7W++RngDcsgsD/tmLctdCKq11L4NIWVVO7IdBvJM8y
         ncnNQu6Km7++m+RDbhBPUlxpXSfDqdCkZL51T0EqGzEJHWV+sGz0IWyf3oF9xo1twCks
         IpLA==
X-Gm-Message-State: APjAAAWdc4wtsRk0J1BHM0zHxjEtePlNh4JpIblOEvhqbM9xiAy4qa2N
        2Xn7jaVbNbfqxKxByHJW1Ttrb80/k+Ji1zwNI2c8ZlrEeuAZ
X-Google-Smtp-Source: APXvYqzoNj4GkC6AvA/IixrfS8pKQM1y3yNNpmunmeiyXret+F6oMMDeESdIhA7JVKpU0ewJTz8RVY49EHSoE0rHng5ABCf8LyYm
MIME-Version: 1.0
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr43882953ion.239.1564512240868;
 Tue, 30 Jul 2019 11:44:00 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:44:00 -0700
In-Reply-To: <00000000000057102e058e722bba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d23d0058eea64a6@google.com>
Subject: Re: INFO: task hung in perf_event_free_task
From:   syzbot <syzbot+7692cea7450c97fa2a0a@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, eranian@google.com,
        jolsa@redhat.com, kafai@fb.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 1cf8dfe8a661f0462925df943140e9f6d1ea5233
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sat Jul 13 09:21:25 2019 +0000

     perf/core: Fix race between close() and fork()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1523f40c600000
start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1723f40c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1323f40c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7937b718ddac333b
dashboard link: https://syzkaller.appspot.com/bug?extid=7692cea7450c97fa2a0a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e888cc600000

Reported-by: syzbot+7692cea7450c97fa2a0a@syzkaller.appspotmail.com
Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
