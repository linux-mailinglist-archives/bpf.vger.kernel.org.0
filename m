Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0777D8F
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2019 05:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfG1DqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Jul 2019 23:46:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44901 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfG1DqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Jul 2019 23:46:01 -0400
Received: by mail-io1-f70.google.com with SMTP id s9so63564575iob.11
        for <bpf@vger.kernel.org>; Sat, 27 Jul 2019 20:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=o2kzyTbMhQL/kAorHcC+7ID+BqHWTQyphajjOBsUUz8=;
        b=MGvUrXLSwPgxzEk0OFOtYti7XCdl0lznXdqxN2t1LHo2Xpp+vAS2Ol+qqgoq72JnnJ
         pHsC9AE2VB/Jdq4CExSnxeRhOUaTik/RCS0kd/Jqw8KrPq83X/WGSxTUO0gIZEWoZ6ag
         Hb0BieRBq+vVAI8bCV9ZhnjNxjvTHmdrjky+nwSXSPyBdkEmMUWoJfIxhLQzR5FtOB8s
         rGubvV1eYlCTYK3RzmoBfyQ+eWVH2Yx0Vb3gL7RQBWjePEmvwX9lfF5lMYZ/QAdNBPuA
         757gj+mM3bmI94RZL1tfr5Wpakw7dCeP8m3WPQRW8Ft9I6YomNiXvXzzAg5LgvQrKe3o
         cUwA==
X-Gm-Message-State: APjAAAVYy1GxGYlx6tfjqqmrE+a444o3w0wiBg3sHdXMe7iP9CEamqH2
        P9T/cFU4cymaPbiMLjNp1ymFQneuwSWvI5B/zXf2hFoQmjjW
X-Google-Smtp-Source: APXvYqxXM+e7HkG1ndOj4S4xy8tLRGbSOz7rHomFcVxe9opbIqsbCOX/jEqUOK4tXAcI7y8l03aMdveo9Zu26OKpCrjDuyQnBW0q
MIME-Version: 1.0
X-Received: by 2002:a02:878a:: with SMTP id t10mr33742269jai.112.1564285560945;
 Sat, 27 Jul 2019 20:46:00 -0700 (PDT)
Date:   Sat, 27 Jul 2019 20:46:00 -0700
In-Reply-To: <0000000000002b4896058e7abf78@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000300996058eb59dd7@google.com>
Subject: Re: general protection fault in tls_trim_both_msgs
From:   syzbot <syzbot+0e0fedcad708d12d3032@syzkaller.appspotmail.com>
To:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        kafai@fb.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 32857cf57f920cdc03b5095f08febec94cf9c36b
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Fri Jul 19 17:29:18 2019 +0000

     net/tls: fix transition through disconnect with close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155064d8600000
start commit:   fde50b96 Add linux-next specific files for 20190726
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=175064d8600000
console output: https://syzkaller.appspot.com/x/log.txt?x=135064d8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b58274564b354c1
dashboard link: https://syzkaller.appspot.com/bug?extid=0e0fedcad708d12d3032
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14779d64600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1587c842600000

Reported-by: syzbot+0e0fedcad708d12d3032@syzkaller.appspotmail.com
Fixes: 32857cf57f92 ("net/tls: fix transition through disconnect with  
close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
