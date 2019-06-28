Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8575A541
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 21:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfF1TjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 15:39:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34942 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1TjB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 15:39:01 -0400
Received: by mail-io1-f72.google.com with SMTP id w17so7761976iom.2
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 12:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6MBa60ZEQW0KfIiP0tSSYs5YVeMvKCMq2VKhW00PUqk=;
        b=Y1GMBrTifqKgeMBwUpObkQ0UxN4eMcpZtRDu3XqvlsmqtMc7Bp/aDjw2Sp3VS7Zxv+
         5lioHAov67sl6NsIY+/mU2UA3jF4MavUwZpkrQMv9sAReDIqL7DkHbuPaqRAf0mSyTYS
         NmKPaRHFMedQSbhPnhsRUJdazBGnYzh2ECeZlrGJVT1UalHZ9fjDvTJIGfgwPF3xfQ1I
         YKU/Cag2+H1kLhizXvLnQcKhnkmZRSF7mgrf4aTesKQtTP1mxNymrJ834c4ttYG8NsYX
         5osQUMxXFRINWKYVnr6ApqSSq0cOol+4iKpwlNGecNIhSZnQGK80lh/wXaxP2cSAE4H0
         Q9nQ==
X-Gm-Message-State: APjAAAWLEBqxSPeqS1EeTXrBYJDT8WZm5rX86hD94D8Bwl2eiFWWUNFP
        QYS0VuS1L6Agm0IQBL9kwiHI4+fOueRFOFQfmxdRQOkdA9Hu
X-Google-Smtp-Source: APXvYqyG9FhR3Hf0uDF4YrYl41IirAkp07VFEYWJqDIdjxISRyPh+xrAnO1HB/EouuP8G7Ie0xNGvLv/dNZy32m373iQYOFow0fw
MIME-Version: 1.0
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr9240612ios.84.1561750741066;
 Fri, 28 Jun 2019 12:39:01 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:39:01 -0700
In-Reply-To: <0000000000001c03bf058baf488a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002628bf058c676e46@google.com>
Subject: Re: BUG: unable to handle kernel paging request in hrtimer_interrupt
From:   syzbot <syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        dvyukov@google.com, hdanton@sina.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14436833a00000
start commit:   29f785ff Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16436833a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12436833a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=037e18398ba8c655a652
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16da8cc9a00000

Reported-by: syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
