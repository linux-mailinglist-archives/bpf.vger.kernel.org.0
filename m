Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891E3401172
	for <lists+bpf@lfdr.de>; Sun,  5 Sep 2021 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhIEUFK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Sep 2021 16:05:10 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48672 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhIEUFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Sep 2021 16:05:10 -0400
Received: by mail-io1-f69.google.com with SMTP id z26-20020a05660200da00b005b86e36a1f4so3662564ioe.15
        for <bpf@vger.kernel.org>; Sun, 05 Sep 2021 13:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=u7MTmHe0EZ9aA9LzZAxZXm6GQj3ww9LG3NsEE4FMIzE=;
        b=XWSwzFqQK//qVCtAsdns+M5cO6PPd+nPS8vaLEDQSog4jWzpZ0NEcpMsmO5A2iNkML
         uadbmp1laA1pbV1bAp7AJUglIr5xSIUAEr66u4i8zE86QpKL7uR/jQ0x7yk3gTBq7o+o
         htCSbLLDLor9W1I6sxiljkrDRYtIugyMibkk9ueYs9bPrAO+caFhUxXpWmboT9xb8VPO
         /9KaQiMChJA88P2dMyLWtIdZidTXthscjzsJVm1yeNhFe44Afr7BnoKjvl5E7O1GXpPn
         5N7PleojxiaoSJ6Kc2E9ZpQCGFTSuFZMpewrXZP+X5bH0BSdIq1SrGF8KHWHGu5NXgAE
         10+Q==
X-Gm-Message-State: AOAM53325ogV5a5XfP+MSkv4LOzlbkISUMtFI64PehUDjqVpkM+3p0/F
        oPqlx4zy+PoTUVrixwHcf92AIOjEI3VDUD/9C1Il1wlaIco1
X-Google-Smtp-Source: ABdhPJw8uxsAVTc7y/O2Nho+1GgIvGWLtmslQzKpOBn86Tsfrhp/WIPdMKxCklB4s2cNvBUTeZJMFKunrHzUglETpZQX+qZo7Qz/
MIME-Version: 1.0
X-Received: by 2002:a6b:7b4b:: with SMTP id m11mr7043393iop.165.1630872246693;
 Sun, 05 Sep 2021 13:04:06 -0700 (PDT)
Date:   Sun, 05 Sep 2021 13:04:06 -0700
In-Reply-To: <0000000000002c756105cb201ef1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f032a605cb450801@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in bpf_check
From:   syzbot <syzbot+f3e749d4c662818ae439@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        daniel@iogearbox.net, davem@davemloft.net, eric.dumazet@gmail.com,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nathan@kernel.org, ndesaulniers@google.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        w@1wt.eu, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit 7661809d493b426e979f39ab512e3adf41fbcc69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 14 16:45:49 2021 +0000

    mm: don't allow oversized kvmalloc() calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13136b83300000
start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10936b83300000
console output: https://syzkaller.appspot.com/x/log.txt?x=17136b83300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c84ed2c3f57ace
dashboard link: https://syzkaller.appspot.com/bug?extid=f3e749d4c662818ae439
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e4cdf5300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ef3b33300000

Reported-by: syzbot+f3e749d4c662818ae439@syzkaller.appspotmail.com
Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
