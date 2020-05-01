Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42471C18B4
	for <lists+bpf@lfdr.de>; Fri,  1 May 2020 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgEAOtG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 May 2020 10:49:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:44345 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgEAOtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 May 2020 10:49:04 -0400
Received: by mail-il1-f198.google.com with SMTP id c4so5004640ilf.11
        for <bpf@vger.kernel.org>; Fri, 01 May 2020 07:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Jh5jVpDHfQplZhcaNyu6KjtSKvR1Mtv8UVWG8cYmvgs=;
        b=lSbqEjszQPR/smPnbINBp7lzS9JTFw97G2BMMpQEPHEo0x0SHZBoNvXmMREqj1ovjA
         KvDhzpRvjXGSS/Xyoap5xMe3yF5msIykw8IJ+/R74reEWfAqi48w8GJizYXpGeIugFqf
         N2NciUJi4y+wsqkP1uQtCpnXPUYRV7g9w06UlqfR/0UYhGKLV/kWQNkxynREGi4cn30Z
         N5KZnCeYGjDKfkNcm15vn93C8tTChDg1pvEYrFeWKy5h3KCFwziEUX4pSvG+7oPb1Ypt
         Ml6s+C3OpnyBvUmvnzgKwZ0Ygt1GGp6bIJ2kzkwvfrkxFOKi07o13YQKzwsWWK6cyBcv
         iU1g==
X-Gm-Message-State: AGi0Pua8PU5Vfi9VAheCdjmr0GQvzIE9nXLE+XsOl6c3JZ1zl/4ocmYS
        5lQAbx/PqpXgdUwQMKuQnysEaqJIahnOb8aOIzkDI+5Z0Al7
X-Google-Smtp-Source: APiQypLK1R32YygzKw6o+zrjKt0GIokFgX8oowRX0+5I/s/40LhWT/hwtwkehxiJ47ijw4bdIgcKya/AdAIK2f7+ZiLlGEbjeIlX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dc3:: with SMTP id l3mr3777413ilj.149.1588344543764;
 Fri, 01 May 2020 07:49:03 -0700 (PDT)
Date:   Fri, 01 May 2020 07:49:03 -0700
In-Reply-To: <00000000000052913105a4943655@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fe61505a49748ee@google.com>
Subject: Re: KASAN: use-after-free Read in inet_diag_bc_sk
From:   syzbot <syzbot+13bef047dbfffa5cd1af@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net,
        john.fastabend@gmail.com, kafai@fb.com, khlebnikov@yandex-team.ru,
        kpsingh@chromium.org, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org, zeil@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit b1f3e43dbfacfcd95296b0f80f84b186add9ef54
Author: Dmitry Yakunin <zeil@yandex-team.ru>
Date:   Thu Apr 30 15:51:15 2020 +0000

    inet_diag: add support for cgroup filter

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106b15f8100000
start commit:   37ecb5b8 hinic: Use kmemdup instead of kzalloc and memcpy
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=126b15f8100000
console output: https://syzkaller.appspot.com/x/log.txt?x=146b15f8100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1494ce3fbc02154
dashboard link: https://syzkaller.appspot.com/bug?extid=13bef047dbfffa5cd1af
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12296e60100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150c6f02100000

Reported-by: syzbot+13bef047dbfffa5cd1af@syzkaller.appspotmail.com
Fixes: b1f3e43dbfac ("inet_diag: add support for cgroup filter")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
