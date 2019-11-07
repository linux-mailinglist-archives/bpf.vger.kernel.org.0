Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDCF3013
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbfKGNmM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 08:42:12 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:40694 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389237AbfKGNmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:12 -0500
Received: by mail-il1-f200.google.com with SMTP id x17so2655540ill.7
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 05:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ts1/QN7SlZAv8FzCyonCkAig7h5V9G7HkY3ov7xjs3M=;
        b=Um+BjDKyn8DGVgq//WcB2/xanikAkN2sdlO6Kuzk30GIj0JYaSbCrYYusBLPiQCa3o
         qLsiNIc3o147QoIJvb9Pq42DhcWrNsj8bWyMUoii6ZGcdDN4ncdW1Rx+w808DIb1v8+v
         8/5VOB9ktUa5LvF3UhZ/HNNrgkIM9uLMdxPeg2RW1fhh3iqN4y4nzoBg1VGlCKTc5wks
         pt8eC6rSNPSEmbN8tfwrV9r4ZVf2bYi/D8fuZv4TCsPz0e910vQSpnHhCQHkwAn2Tv5y
         SiaWQ4oUmJczHUu6dZJxZ/Um7qTAJDwq4Ev42heVdrVIYRvMadiNbIE/y0zTTWS3VK3N
         86XQ==
X-Gm-Message-State: APjAAAW6r7Qd651JwCAOJmNj+FQYl/1wOkGQX5by9ICK2OdifvdA26Ox
        RKDnIJzDDdHOqbawUnxZWWZIwrMS0eyaZBWKJXPVFtDUhb1N
X-Google-Smtp-Source: APXvYqz/g3akW+HYZOqq00GOcwk4TIgPuwUmUsNZ8JleeVUWjArlNV1JzK0GZVOa198jjNQXsMlAh0R+qyRRrxrnABjAL9dYZK4H
MIME-Version: 1.0
X-Received: by 2002:a5d:9f02:: with SMTP id q2mr3553203iot.3.1573134129497;
 Thu, 07 Nov 2019 05:42:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:09 -0800
In-Reply-To: <00000000000006602605752ffa1a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f90bb30596c1d438@google.com>
Subject: Re: general protection fault in tcp_cleanup_ulp
From:   syzbot <syzbot+0b3ccd4f62dac2cf3a7d@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, john.fastabend@gmail.com,
        kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 5607fff303636d48b88414c6be353d9fed700af2
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Tue Sep 18 16:01:44 2018 +0000

     bpf: sockmap only allow ESTABLISHED sock state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fdc73c600000
start commit:   28619527 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=0b3ccd4f62dac2cf3a7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13537269400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: bpf: sockmap only allow ESTABLISHED sock state

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
