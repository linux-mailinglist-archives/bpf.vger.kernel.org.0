Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38D4471F6A
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 03:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhLMCqK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Dec 2021 21:46:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50049 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhLMCqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Dec 2021 21:46:09 -0500
Received: by mail-io1-f70.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso4064317iov.16
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 18:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2NuGDG85AfS9y7yRsPV78T4aS8gdf/qTEMMTGPv30Uo=;
        b=0729xe9EbE5BEzpMf1GPWhvd5B70M11Qtaw3+s8CaQq6qqVz9cmvWm89VGViHtviUo
         NzT7TqtFV+B6uP3AoXbXKAU9bdBydrsMsn5GyzV1wtsZt/LoQF2icsIzXtlwY2KYw8X9
         YC/qphf8GLK3osNKWkfb8AwXMqdp3JfpuXYMuWzEAbkSj1vw1hRgDZJdXX4MVWcyzutH
         JYPkM3LNHWyj4c/Ca3Sz53ZHZCxTz/hwKk2Z1hTfjsCutuswFjQdBo0Z4qieUieaxma6
         PGVED9kaD7t1Qs6HyE1ahDfTZoVp5x3x9PFxfkrv6SJr/12c79+RGwIIndx1o7oGrfbF
         Yw9g==
X-Gm-Message-State: AOAM532uoIB9G+eNpFKflF9qxr5T4eONTUOPHOlrkSQbEOxWhL0hQWiz
        4B0sP8wL5+gREb7mrlM7cIZucdnmJX+Ad0sG8SPa4IfWrfWN
X-Google-Smtp-Source: ABdhPJxmIIniwyRI+oGKfh384pqZnwOTrq/uMCOdu+0TQNm3dbrB4E/IT0pkWUrcZ6DzAviv5fB5LypbSmb2oXE+b+tp75tbjAS/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:: with SMTP id f10mr29103329ilu.281.1639363568731;
 Sun, 12 Dec 2021 18:46:08 -0800 (PST)
Date:   Sun, 12 Dec 2021 18:46:08 -0800
In-Reply-To: <00000000000033acbf05d1a969aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c0bbf05d2fe1382@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in bpf
From:   syzbot <syzbot+cecf5b7071a0dfb76530@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jiri@nvidia.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, leonro@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit 22849b5ea5952d853547cc5e0651f34a246b2a4f
Author: Leon Romanovsky <leonro@nvidia.com>
Date:   Thu Oct 21 14:16:14 2021 +0000

    devlink: Remove not-executed trap policer notifications

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1465b449b00000
start commit:   ee60e626d536 netdevsim: don't overwrite read only ethtool ..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1665b449b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1265b449b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=cecf5b7071a0dfb76530
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a14b55b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13375f75b00000

Reported-by: syzbot+cecf5b7071a0dfb76530@syzkaller.appspotmail.com
Fixes: 22849b5ea595 ("devlink: Remove not-executed trap policer notifications")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
