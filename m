Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8019759E
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 09:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgC3HZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 03:25:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:36085 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgC3HZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 03:25:05 -0400
Received: by mail-io1-f71.google.com with SMTP id s66so15415081iod.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 00:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TZJbpgebPbX3Q4FeLfNCFQJD77ggPTwgpCJg6I/5kLk=;
        b=hPQoWtP26JO3E6/nBCK56G1TVliLfV6cso6wAyuPUPLkUwJvCvCHjkuadQZksF0+++
         ZlnYPH5Y/JSgeFvbCD/bh+Ecn/0tKtEtsCRKSFas7NU0AA2UNwO8qxeokT+fjs4YCF1+
         IzLZxqV67h8agTuQA1Z3BCHhzzhKefjt4Lcdqy84rL1HbH16GE18tdPFQPXXNNweKtW8
         PbiTCQsECzwqRuOBRH2IkYl0mDHkrk72SxVsVWPma2LGDvtZI0uoDZAzIHDKL3rMBFdn
         wgY4sXTEI0wdAGBdQO0b7512nmkrzMJ1Me5DbIw5W4AN6mU0uZD2zA0c7mvsQTwBtu2n
         RUcQ==
X-Gm-Message-State: ANhLgQ3PPNyQ/C+H4d/v6I8JMtcA4RoChrHwInCeZZ+3DjhpQKoUfiEO
        9S8aD3N6ZqMzT3CVC9RyxcNUFWmOzBWJUt7mWRAbKCXDj4Eg
X-Google-Smtp-Source: ADFU+vtBbBt6BuinPFFJY8ewnoDn/U9q2ryhLsaXg+psdNxruEaMqWJqvCEaD1smqkJhUjifXxvNwbU5if/xCAxan2Tj9cQry9q1
MIME-Version: 1.0
X-Received: by 2002:a6b:e316:: with SMTP id u22mr9378632ioc.1.1585553103320;
 Mon, 30 Mar 2020 00:25:03 -0700 (PDT)
Date:   Mon, 30 Mar 2020 00:25:03 -0700
In-Reply-To: <000000000000aa9a23059f62246a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007effb905a20d5904@google.com>
Subject: Re: WARNING in sk_stream_kill_queues (4)
From:   syzbot <syzbot+fbe81b56f7df4c0fb21b@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, aviadye@mellanox.com,
        borisp@mellanox.com, bpf@vger.kernel.org, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, edumazet@google.com,
        jbaron@akamai.com, john.fastabend@gmail.com, kafai@fb.com,
        kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ncardwell@google.com, netdev@vger.kernel.org, shuah@kernel.org,
        soheil@google.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit b6f6118901d1e867ac9177bbff3b00b185bd4fdc
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Feb 25 19:52:29 2020 +0000

    ipv6: restrict IPV6_ADDRFORM operation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1177dc25e00000
start commit:   f8788d86 Linux 5.6-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe81b56f7df4c0fb21b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fd92c3e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11679a81e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: ipv6: restrict IPV6_ADDRFORM operation

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
