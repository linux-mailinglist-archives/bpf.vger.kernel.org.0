Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5196DC2C2
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408101AbfJRK1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 06:27:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41363 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404894AbfJRK1C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 06:27:02 -0400
Received: by mail-io1-f71.google.com with SMTP id m25so7857148ioo.8
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 03:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4JoPCUxM0SmhsnlFHKFjSP4adziJaRApk9VYV5+Ut5c=;
        b=dK3TU/K8cHSztn9dACifZHOgyRLA/H1yPRBCj07Y9NgKK5uACs3jbNtiIGaU97c4/7
         xqt4phJ2fCXNaqXC+PBS4W6ycpDLynfDp8ClAXGYyeLzUdhGfguZdDtl8LtV+4mlFdcl
         CiVAXEjO0tryzlDHxNLACdW5W1MQ5dDclvr0KzcIWx/moAcFbKEBagmg4O4iAuTTpCKN
         oVJbXkpSBes1pdH8cR0l6XEQdyqMI6VZTev1I/0DzMLxFK5W177F5Ozkx1n+HbX9uC30
         +NmQE9n7rvuBwsZa719swKOTwLvedqzH4ntUHavcNgfDbMzr22YzUeYUn2COcOiAblKG
         QT8A==
X-Gm-Message-State: APjAAAW9igIBj2QkpC8522WJnatSJ1OAqCf9BAD4xYkmKtr4x6IDhBoS
        2WY3iVKsAgKSOtGvnmgiwruFpk8Lpqk5lcic2mQx6rjPLnTj
X-Google-Smtp-Source: APXvYqwLOMpW6VAezBgHBiWGwlAKQuAIHa3svUkCYFs+Ik2sdZOXklZJzjUj6Elt89PUXjwILVjKRboMtHG/HjPXYU5BCTXlvWNy
MIME-Version: 1.0
X-Received: by 2002:a92:d784:: with SMTP id d4mr9462227iln.110.1571394421258;
 Fri, 18 Oct 2019 03:27:01 -0700 (PDT)
Date:   Fri, 18 Oct 2019 03:27:01 -0700
In-Reply-To: <000000000000410cbb059528d6f7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048021005952cc62b@google.com>
Subject: Re: BUG: unable to handle kernel paging request in is_bpf_text_address
From:   syzbot <syzbot+710043c5d1d5b5013bc7@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com,
        joe@wand.net.nz, joeypabalinas@gmail.com, john.fastabend@gmail.com,
        kafai@fb.com, linux-kernel@vger.kernel.org,
        mauricio.vasquez@polito.it, netdev@vger.kernel.org,
        quentin.monnet@netronome.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 6c4fc209fcf9d27efbaa48368773e4d2bfbd59aa
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Sat Dec 15 23:49:47 2018 +0000

     bpf: remove useless version check for prog load

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14306908e00000
start commit:   283ea345 coccinelle: api/devm_platform_ioremap_resource: r..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16306908e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12306908e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0a8b0a0736a2ac1
dashboard link: https://syzkaller.appspot.com/bug?extid=710043c5d1d5b5013bc7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142676bb600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a2cebb600000

Reported-by: syzbot+710043c5d1d5b5013bc7@syzkaller.appspotmail.com
Fixes: 6c4fc209fcf9 ("bpf: remove useless version check for prog load")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
