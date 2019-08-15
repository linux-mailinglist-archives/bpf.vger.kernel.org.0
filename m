Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4878B8F2C7
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfHOSGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 14:06:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41431 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfHOSGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 14:06:01 -0400
Received: by mail-io1-f71.google.com with SMTP id r6so417187iog.8
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 11:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6O8fj8Cxesz95GcJ9dIMRrMkW2S+HMSqZq3eO7hi+58=;
        b=rJS+RAu49CXjoechsJniXGGJWiOvUFX6J8OG/iiogp2Rg5uR9ogXSWKP4t4yJ3Mcez
         KgoP008e4YmgT9nCDKJK9gD9XlEe3SKBGFMFSZqfqqajsdI/vhY0YkrlEUaf4c9NP6FW
         TY07AWFoQw9Hc0Nuv0JOL4ivBAfVUzjUy2rKgY9VL7iVe+o1/bpvTZDgy2rHW9h2xNvC
         U2QuT+vCCmrw1f4/7EO9ntTnJA6vaqc/PV3hShtHXsKM7J8/pUMEEFRh1HvdCRKQs4uq
         7MMhWJmbtTmHFUSVfIJaYJhgLT2z0aaDjp4RSWcpM+KCYNp3UN4UpWGAG6xwFS2jyFz0
         Jwtg==
X-Gm-Message-State: APjAAAW6eb1mnc3WTmYAbIKvNWyp8Kj+ne0e1vWQ63tpF82OOUZbqmSa
        A3jzxDovmRuD8gNjACTxiSogOSOfNZAJ+PnSeQ36v8+j9CQr
X-Google-Smtp-Source: APXvYqy5AXhfLngIaYgaBxvvQokDgu6mxb5nb/n1uzcS934nnva7+99gALTUcVp1YZPMTW8pM5S3MBUS6LmViOkPPydAWfs2qe0V
MIME-Version: 1.0
X-Received: by 2002:a5e:8209:: with SMTP id l9mr3454621iom.303.1565892360493;
 Thu, 15 Aug 2019 11:06:00 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:06:00 -0700
In-Reply-To: <000000000000523ea3059025b11d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e75f1805902bb919@google.com>
Subject: Re: INFO: task hung in tls_sw_release_resources_tx
From:   syzbot <syzbot+6a9ff159672dfbb41c95@syzkaller.appspotmail.com>
To:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, hdanton@sina.com,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        kafai@fb.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 130b392c6cd6b2aed1b7eb32253d4920babb4891
Author: Dave Watson <davejwatson@fb.com>
Date:   Wed Jan 30 21:58:31 2019 +0000

     net: tls: Add tls 1.3 support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118e8dee600000
start commit:   6d5afe20 sctp: fix memleak in sctp_send_reset_streams
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=138e8dee600000
console output: https://syzkaller.appspot.com/x/log.txt?x=158e8dee600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=6a9ff159672dfbb41c95
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cb0502600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d5dc22600000

Reported-by: syzbot+6a9ff159672dfbb41c95@syzkaller.appspotmail.com
Fixes: 130b392c6cd6 ("net: tls: Add tls 1.3 support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
