Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435002F565C
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 02:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbhANBqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 20:46:37 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197]:42408 "EHLO
        mail-pg1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhANA5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 19:57:42 -0500
Received: by mail-pg1-f197.google.com with SMTP id j37so2554297pgb.9
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 16:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jlFSyFsy03pYVrVR3CcVIDgLJx11fHk/YYGYXYtjZt0=;
        b=rwZdNLkFdna3Gtj0KnHgg/01KdN1mAalze4WOgwRKOcGiPXucy4XXxwKILIdfMRNhi
         Q0mtlr0JS23bXZ8cc4h7XFVaFHPI+cCXHJ8EUa7ergjKfHl2kwdj8H8GPQjJDL1L+AgJ
         phcTDk03wZHVL9NzpbAuHfQht8CREIi2xUa0K8QsVOgvU0z+Uu2reIB6PLXIrR//IRcv
         AKxj3E7eFzHMDoeo+Ft2t6QcEb1wBZx8M0zi912ZVTHNHRA8MKQCBTayB9mXqK80ZsSI
         79FTpfgEw9v4kwie78yOBuCbUEq1Em2vJImAXZU3utlAe+nfBSNwFUwxHYl1HOL2P5bA
         Mb2w==
X-Gm-Message-State: AOAM5330VsqeSaqXMx34qvii2S9o54Ki+lEbQK8UmsldDCDF/gprQVj5
        ckfmZO7nyJXgHTCLsq1P+yTTyGBhrr5ywrSZ0Pqg92Jt63Cf
X-Google-Smtp-Source: ABdhPJy1vepLrK0QdOGj3+JxVkfzwde1SE5dgoHnfXS4WCuUzSYJSlWakQM+9vHXU3TywlsRkPAATkcWJ2PnQeeUhpeBjEvjEIeS
MIME-Version: 1.0
X-Received: by 2002:a6b:784d:: with SMTP id h13mr3621423iop.26.1610585226627;
 Wed, 13 Jan 2021 16:47:06 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:47:06 -0800
In-Reply-To: <20210113114136.4b23f753@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000504e4005b8d198c1@google.com>
Subject: Re: kernel BUG at net/core/dev.c:NUM!
From:   syzbot <syzbot+2393580080a2da190f04@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, f.fainelli@gmail.com, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2393580080a2da190f04@syzkaller.appspotmail.com

Tested on:

commit:         3a30363e net: sit: unregister_netdevice on newlink's error..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git sit-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=bacfc914704718d3
dashboard link: https://syzkaller.appspot.com/bug?extid=2393580080a2da190f04
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
