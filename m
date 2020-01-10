Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 431861367AE
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 07:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgAJGuB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 01:50:01 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:47083 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgAJGuB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 01:50:01 -0500
Received: by mail-il1-f198.google.com with SMTP id a2so878595ill.13
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2020 22:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nSBEziQIAgMmreD/bwiDUMfwTZxHkivHwZB8qVu7K9M=;
        b=e3FCdVM6QA++Z56EpZ1PeR7gsKdWLcgXd+QAwITsv9SneGb7o/cP/KqFGfQcgW73qP
         W/97gmLZ1LwOx77lxGZ6OZfzWnOlSGs4eQJXl+SxXmcUtU3CEHktPrPxpfWTci4tY0F0
         q5UncUXKgnXHL9THGcc4AFs2uPJ81/ZdtP8A85O6VxIb8zdzj/FDqvzgHU8G/frxDyul
         jyNLKBNDcY1PtvyN1mHdon7lWuRj/sm6rfh5D+8V/Xr87mlGel1vY0/Z9tRGRM9JpX2d
         B7yLdJz3czBZPtnQRrk0rXiGb+g9Sx8mamhehAqZBBxdkzlEV/R02Nw6LEVOWOGvhljR
         FrSg==
X-Gm-Message-State: APjAAAWA7uWIwFzC8kvUiYLfdcUw8eovthNblWcmavrmgU+fI189uM+W
        OeO+zgDECjA+7d6zwn+fHilyV34Fc7SX9qqMS48ySvg8xEJm
X-Google-Smtp-Source: APXvYqygb++rANaYFZ2skaGuTLPRW7b0m2B1Xr7kXiLH/wZnhkt0oZWvxvj3A3b+HGzLordUY9WM6fV0K7+EMxq+HVsg4swltiWA
MIME-Version: 1.0
X-Received: by 2002:a92:84d1:: with SMTP id y78mr1319946ilk.69.1578639000707;
 Thu, 09 Jan 2020 22:50:00 -0800 (PST)
Date:   Thu, 09 Jan 2020 22:50:00 -0800
In-Reply-To: <000000000000946842058bc1291d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddae64059bc388dc@google.com>
Subject: Re: WARNING in add_event_to_ctx
From:   syzbot <syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, arvid.brodin@alten.se,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, jbacik@fb.com, jolsa@redhat.com, kafai@fb.com,
        kernel-team@fb.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, xiyou.wangcong@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 311633b604063a8a5d3fbc74d0565b42df721f68
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed Jul 10 06:24:54 2019 +0000

     hsr: switch ->dellink() to ->ndo_uninit()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1005033ee00000
start commit:   6fbc7275 Linux 5.2-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bff6583efcfaed3f
dashboard link: https://syzkaller.appspot.com/bug?extid=704bfe2c7d156640ad7a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1016165da00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b27be5a00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: hsr: switch ->dellink() to ->ndo_uninit()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
