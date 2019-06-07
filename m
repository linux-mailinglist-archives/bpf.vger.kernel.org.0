Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8D3831C
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 05:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFGDZB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 23:25:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:42493 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFGDZB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 23:25:01 -0400
Received: by mail-io1-f72.google.com with SMTP id f22so596770ioj.9
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 20:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e6etfNurQQo9Va6VpYHCA2sien54nXIZ+EIMOWfPhpg=;
        b=UXs2VjTBXSMmltrkKHNQDle8CWXHPBmOJNIFf5O3htD2J1RMj7G/TRsypdtxxDycP0
         npwobxaZTIvTKJNpNL3kofX4Gv2zditDkBnjkurGrkiXgYaFcgTpRI5vQPbpDfGDIrwn
         Vo6Ax2I3ZL9sDJbPggpvOSGW4wNMhtBXEUqbICIpYVWRiirp67gakzKJz9pbGHMtndBp
         RK1f+mpPGZbPby31qjhYOCy+hiTuG15oMSTfmLCJ9NPKxk0doJvL+HQcZR+r+lAQeqCJ
         dGAL4uoNdVElEt26ZgBd7dJtB+mL5YtiqdwoyxCZK3cJeUUYN751BG542K1V2r5/sL6Y
         kguQ==
X-Gm-Message-State: APjAAAU2iu9iwEKt/apKKAHr9rq9mwGHfLdpzArxifteuWlYxOZl41gw
        wD+JFA8ii4dS1zdOQw/B1tRMOS3dwgRF3IggDE81qd+L89uY
X-Google-Smtp-Source: APXvYqye5xa1Ca/EaWr+y6R3z3/VH0PShIIRB83YYxYRr5VL2+2o8N9WKQzv8UUonOlR9ZG4NAHpnj7r5bzEM/0sAQVJZSzGAe01
MIME-Version: 1.0
X-Received: by 2002:a24:f807:: with SMTP id a7mr2825641ith.166.1559877900241;
 Thu, 06 Jun 2019 20:25:00 -0700 (PDT)
Date:   Thu, 06 Jun 2019 20:25:00 -0700
In-Reply-To: <0000000000006b30f30587a5b569@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002314b3058ab3605c@google.com>
Subject: Re: general protection fault in ip6_dst_lookup_tail (2)
From:   syzbot <syzbot+58d8f704b86e4e3fb4d3@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, dvyukov@google.com,
        edumazet@google.com, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit f40b6ae2b612446dc970d7b51eeec47bd1619f82
Author: David Ahern <dsahern@gmail.com>
Date:   Thu May 23 03:27:55 2019 +0000

     ipv6: Move pcpu cached routes to fib6_nh

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c969a6a00000
start commit:   07c3bbdb samples: bpf: print a warning about headers_install
git tree:       bpf-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=102969a6a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c969a6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7b54c66298f8420
dashboard link: https://syzkaller.appspot.com/bug?extid=58d8f704b86e4e3fb4d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117f50e1a00000

Reported-by: syzbot+58d8f704b86e4e3fb4d3@syzkaller.appspotmail.com
Fixes: f40b6ae2b612 ("ipv6: Move pcpu cached routes to fib6_nh")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
