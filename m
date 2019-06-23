Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4423A4FAFC
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2019 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFWJrB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jun 2019 05:47:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37518 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFWJrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Jun 2019 05:47:01 -0400
Received: by mail-io1-f70.google.com with SMTP id j18so17804989ioj.4
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2019 02:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=//qCEHHwsKmQKJGq2sElU6h7rWpgyd394JCVN/Ky63Y=;
        b=PHAb3SgI6ScH+vll/hqZsnEfOWst5tVG05sJ/z4u2G6v8fOGKWXlpN0l7OZGJpNYHw
         cCemLSkxWeOaxcGGfVAWftG56QVKDSM5Y5/J8//OHKulJpoFKOv/MKePCm8HGI3lQ/LS
         sLomV811463xcYbLdNkH79yOwd9L+KHkCUhji35XgjsPBqyQtOxCXM0PleaaJ3LUf9bm
         J8vdPbyx6WJI2Ugi7JfcwufSK/m09aqW7etz1PtQk8T6HxW4+3FSVohiCC2EctDaYfjZ
         pXvlV4q85rYy8Ktxrj4dnbO/0TFHyIKPHLDqhJFSfnPJn3Ebrfdv+IzyscI7wu0t5HG5
         8uqQ==
X-Gm-Message-State: APjAAAUE5DGKOcTbmLRqqBz8HtzX0cfRi3qGek43WQ+qncbfc+G2/Kk/
        uYRd2RhL5d9VrG6FAlA3lJykuSR8I3a3rH8j2tAS+vTVCfX0
X-Google-Smtp-Source: APXvYqyGiLQ70dP6eFGnQ63Jed2MzJ0lmOsmDLwDerlbWSICxM7PikGk1Wtt/hUYnDo1CxkwarJk5FqD8R5xYTNQF8/oFlSwbHR+
MIME-Version: 1.0
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr26057928iog.77.1561283220587;
 Sun, 23 Jun 2019 02:47:00 -0700 (PDT)
Date:   Sun, 23 Jun 2019 02:47:00 -0700
In-Reply-To: <00000000000090ae7a058bc12946@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1cb06058bfa9371@google.com>
Subject: Re: WARNING in debug_check_no_obj_freed
From:   syzbot <syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andriy.shevchenko@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        dmitry.torokhov@gmail.com, f.fainelli@gmail.com,
        idosch@mellanox.com, jeffrey.t.kirsher@intel.com,
        jiri@mellanox.com, kafai@fb.com, kgraul@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        ubraun@linux.ibm.com, wanghai26@huawei.com, yhs@fb.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 99182beed858a1bde22f60046602b9b223225f73
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Tue Apr 2 21:17:19 2019 +0000

     Merge branch 'bpf-selftest-clang-fixes'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12faf81aa00000
start commit:   bed3c0d8 Merge tag 'for-5.2-rc5-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11faf81aa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16faf81aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=b972214bb803a343f4fe
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fcf0b2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22ad6a00000

Reported-by: syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com
Fixes: 99182beed858 ("Merge branch 'bpf-selftest-clang-fixes'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
