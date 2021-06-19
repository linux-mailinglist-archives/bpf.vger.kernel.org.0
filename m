Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600003ADAF4
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 18:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhFSQ4U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Jun 2021 12:56:20 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45803 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhFSQ4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Jun 2021 12:56:18 -0400
Received: by mail-il1-f198.google.com with SMTP id s18-20020a92cbd20000b02901bb78581beaso4660159ilq.12
        for <bpf@vger.kernel.org>; Sat, 19 Jun 2021 09:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QqIncrQU8u3oTCnB+Mpzxl6+UwwC6+HMM9p8ltzPHS8=;
        b=Lvekr3hE5uWmchedg+ZTweSSYXkWp5sTNBfWK4i6qxqJfOPltoU/LpgNO83VQ1W0MP
         NFrWidQNgAqFLVWlo0XpoEB7jljUhEb/L6zRhR8v220sVGejzUsS+hETOrAl5S8qZ762
         34HJzJlRNKaCGxO+rIEQSnvbZ09U4q/7fCO/69Pn3xHG14pVeIOefdddM0TX73xAZMh3
         Oj39eoc5sgq9qPS/6BII02a9BPn+OSuOO9mSR+o2ZHarFn2/eR+xmXALqYIRRBumEu8u
         m71xdP2vMlqXZLaS8ywyVzDlxoVG1dwLPB95rPQDwrXFegvgTc/gjhMzAfcaNLVE2L6I
         znEQ==
X-Gm-Message-State: AOAM530ujao6C1IxBXrh3pCxYs+c57uU1/cnIIhtpEOtd8TgsHji97Aa
        Tmrk6pSig9bLjVBMbwG18ASUF03r01iOI0+pXhZezY9Un2G8
X-Google-Smtp-Source: ABdhPJx/AfnH2IlS/TiDpgCKO8HJ1dF/+Qf9wLPerlasfa7aKwjtTw6wDoV8Sg0G1dCQZ9I9Y1q/4o9tQB4bG00bf9WeDJQtc5Ow
MIME-Version: 1.0
X-Received: by 2002:a02:94af:: with SMTP id x44mr8962347jah.79.1624121646170;
 Sat, 19 Jun 2021 09:54:06 -0700 (PDT)
Date:   Sat, 19 Jun 2021 09:54:06 -0700
In-Reply-To: <000000000000f034fc05c2da6617@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cac82d05c5214992@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in check_all_holdout_tasks_trace
From:   syzbot <syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        axboe@kernel.dk, bpf@vger.kernel.org, christian@brauner.io,
        coreteam@netfilter.org, daniel@iogearbox.net, davem@davemloft.net,
        dsahern@kernel.org, dvyukov@google.com, fw@strlen.de,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        john.fastabend@gmail.com, josh@joshtriplett.org,
        kadlec@netfilter.org, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        paulmck@kernel.org, peterz@infradead.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, shakeelb@google.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yanfei.xu@windriver.com,
        yhs@fb.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit f9006acc8dfe59e25aa75729728ac57a8d84fc32
Author: Florian Westphal <fw@strlen.de>
Date:   Wed Apr 21 07:51:08 2021 +0000

    netfilter: arp_tables: pass table pointer via nf_hook_ops

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10dceae8300000
start commit:   0c38740c selftests/bpf: Fix ringbuf test fetching map FD
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12dceae8300000
console output: https://syzkaller.appspot.com/x/log.txt?x=14dceae8300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6380da8984033f1
dashboard link: https://syzkaller.appspot.com/bug?extid=7b2b13f4943374609532
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1264c2d7d00000

Reported-by: syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com
Fixes: f9006acc8dfe ("netfilter: arp_tables: pass table pointer via nf_hook_ops")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
