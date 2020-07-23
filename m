Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D022B41B
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 19:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGWRGG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 13:06:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:55143 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGWRGF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 13:06:05 -0400
Received: by mail-il1-f200.google.com with SMTP id d18so3880749ill.21
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 10:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5CYbMZ9E5A0Mz6J623Xu55BU2Et7NhlNxD6HpaP2/I8=;
        b=iIYqKfTz8NSMnCCTHrO2fSHTN0YG3Gxg/YIm1bgKgTEC32EaEG1rzghMYpTsJcPrKz
         NZGGtwfRfm6KKUUvVTMGdACh8x4YhPAxiNrduzmiUgTbnliZsFqGxKqpgTQCArKPgHDw
         bcj24OfcOhs/VDCKqDMnDJqctEBWDESj1P3t++HfSULe32aOtZcCsA+M3FszQnL3ds52
         hBbTmWQU3wMnBIlEeAVbF6NDtJ9nR6zwozPizW/OetNStvVBdBqYLa5IvlS6Ofx5DOTC
         heik7QzJsTr5HD3UK5SZya+CSuws1kKDscL5ULOeEndPQpaoJfSBIFMA3MpK/wB5XtL8
         jOzA==
X-Gm-Message-State: AOAM530ffT5KlVm7rVetccRFkUlLHTYO/HqYxcASNcq7CynaWKIJo49y
        YRgX+HIf6p02bzbvM6jHNsFYSmEkTjQoAV9N3NivaGHb0LDM
X-Google-Smtp-Source: ABdhPJxO1HAnLT9DnS+ErjhGrIxE4rnBK+8uSCWAMhvotTHMVQYSX/Tja0D8v90nwLa656ScMblR2RAfY/8cBGRHlC5Im1fJq9o5
MIME-Version: 1.0
X-Received: by 2002:a92:3407:: with SMTP id b7mr5752526ila.66.1595523964723;
 Thu, 23 Jul 2020 10:06:04 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:06:04 -0700
In-Reply-To: <000000000000b1b74105a91bf53d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025ed9705ab1edf54@google.com>
Subject: Re: KASAN: use-after-free Read in macvlan_dev_get_iflink
From:   syzbot <syzbot+95eec132c4bd9b1d8430@syzkaller.appspotmail.com>
To:     andriin@fb.com, ap420073@gmail.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit 1a33e10e4a95cb109ff1145098175df3113313ef
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun May 3 05:22:19 2020 +0000

    net: partially revert dynamic lockdep key changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17663aef100000
start commit:   1590a2e1 Merge tag 'acpi-5.8-rc3' of git://git.kernel.org/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14e63aef100000
console output: https://syzkaller.appspot.com/x/log.txt?x=10e63aef100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c907630cbdbe5
dashboard link: https://syzkaller.appspot.com/bug?extid=95eec132c4bd9b1d8430
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1559e6e5100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aadd29100000

Reported-by: syzbot+95eec132c4bd9b1d8430@syzkaller.appspotmail.com
Fixes: 1a33e10e4a95 ("net: partially revert dynamic lockdep key changes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
