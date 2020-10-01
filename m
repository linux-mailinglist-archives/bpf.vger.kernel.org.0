Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5C280724
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 20:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgJASqG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 14:46:06 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:54188 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgJASqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 14:46:06 -0400
Received: by mail-il1-f207.google.com with SMTP id v5so5291236ilj.20
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 11:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QPaq3GozfGEmcVEfcZ9p2WifWSbg3p4JEASOWyQUygM=;
        b=hAp2zs2E92nabT8CdAEbH4nVNHPVrs1zUfm7YZse2swpW6uKFwVtkCzVCScl6qS3db
         kOkJ2I6YyHusmf+aLX9i0flysUfd6NUql8wjjNGr8w48rbnwuRLPaWNid6Nh9xR+5kTA
         vMzqWSA4I2tmJ8fFyp9gHW+1lngznfJFlo0dIjq+hf7sSGyvIAlLKFZpXyGUZd3rw7sE
         h5ptZhbm6f4NJUxvGJwqxqhGzEu4BqSP8QZn/e8a2oICXVOysodi87vWfor8U2+ERdGq
         +KXwMK+Km90fm3raBm9/WIFYVRefem897A9A+osOrfCJ1pzNKe7fbpxp6G9RL3cjomag
         INDg==
X-Gm-Message-State: AOAM5332EIJIuAMDf1CuTjk4cW1R1WQrzSQfVJUTetthIv51j+J0V7V0
        pHuDC15dnFiQGBBpEjrXgQBc5mM5JKGfZRYgrY0Bz1Z0D93H
X-Google-Smtp-Source: ABdhPJxZy8JSQ93jW1Afj+8O1MF5YFh8NRykTOGDo1ivTsoY0Wr90IQy946nezTTOaKxADBqzM6N18M0Cfj/CgmkiynfD3dUBzzM
MIME-Version: 1.0
X-Received: by 2002:a6b:7005:: with SMTP id l5mr6586653ioc.10.1601577964783;
 Thu, 01 Oct 2020 11:46:04 -0700 (PDT)
Date:   Thu, 01 Oct 2020 11:46:04 -0700
In-Reply-To: <0000000000008fddd805adc8c56f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abcd5505b0a06d96@google.com>
Subject: Re: general protection fault in rt6_fill_node
From:   syzbot <syzbot+81af6e9b3c4b8bc874f8@syzkaller.appspotmail.com>
To:     John.Linn@xilinx.com, a@unstable.cc, anant.thazhemadam@gmail.com,
        andriin@fb.com, anirudh@xilinx.com, ast@kernel.org,
        b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com,
        hancock@sedsystems.ca, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, michal.simek@xilinx.com,
        netdev@vger.kernel.org, nikolay@cumulusnetworks.com,
        songliubraving@fb.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit eeaac3634ee0e3f35548be35275efeca888e9b23
Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date:   Sat Aug 22 12:06:36 2020 +0000

    net: nexthop: don't allow empty NHA_GROUP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12beed5b900000
start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=81af6e9b3c4b8bc874f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ff8539900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143f3a96900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: nexthop: don't allow empty NHA_GROUP

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
