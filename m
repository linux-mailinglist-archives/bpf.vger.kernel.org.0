Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB13221BB6
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 07:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgGPFAH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 01:00:07 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33996 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPFAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 01:00:06 -0400
Received: by mail-il1-f197.google.com with SMTP id y3so2909702ily.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 22:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cE1hhRVuLf2gZer2Ucpnx9HKI06D31CoZ/RNlVo8Pe0=;
        b=svGNeVsIAqDLdm4LFAle/y606NwLKGYyrUWST9JyNn+05XK55vR2JO4bGB9IYvAtPk
         J2q4V0ag2D0la4iuxyg7hbxmuK4GFMQ5aYsfVa5ImJIsg1thPa6vzGRWfYpo9JW6hM43
         usprPw2sgzs2iKw0tZ3O0RaUU9ILcw99JvaokaS38wbWhD0loClzxvNYSXWt7oMoRxh2
         2Eb3qcJhtOqI+MpPJv2TQfNM8hsIuYj/VRvqyVWpo9f1bUQekL13k9lnGA3GRuWGOBBH
         khCmCFjNx6g9j6JWIFfbNk6WCDXLXxnmEF8rClKl/t8ot78/Akmzw4DScIOX7drikpto
         vIqw==
X-Gm-Message-State: AOAM531RIMJ0dA7AuXaaxYdw/MNz2fzazn+6CLEVTDk7uKd69TfFPIKJ
        8lZXfersKSD5sgcSfvmWoQXW+K6Ax7bRepE7qTUgh3eoc3ZN
X-Google-Smtp-Source: ABdhPJwrtEU1PwKJDwMkynoxse8GDaDxlNH/e4aaSkK3f5Z72MwWHALTn6uAryXSscOV5ZuIi1/gjdhbEGKyVnlXGRdUASMWb0gi
MIME-Version: 1.0
X-Received: by 2002:a6b:7c02:: with SMTP id m2mr2790747iok.49.1594875605629;
 Wed, 15 Jul 2020 22:00:05 -0700 (PDT)
Date:   Wed, 15 Jul 2020 22:00:05 -0700
In-Reply-To: <00000000000029663005aa23cff4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef406d05aa87e9ba@google.com>
Subject: Re: WARNING in submit_bio_checks
From:   syzbot <syzbot+4c50ac32e5b10e4133e1@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, axboe@kernel.dk,
        bkkarthik@pesu.pes.edu, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, ebiggers@kernel.org, hch@infradead.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit 449325b52b7a6208f65ed67d3484fd7b7184477b
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Tue May 22 02:22:29 2018 +0000

    umh: introduce fork_usermode_blob() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fc4b00900000
start commit:   9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fc4b00900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fc4b00900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=4c50ac32e5b10e4133e1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1111fb6d100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1218fa1f100000

Reported-by: syzbot+4c50ac32e5b10e4133e1@syzkaller.appspotmail.com
Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
