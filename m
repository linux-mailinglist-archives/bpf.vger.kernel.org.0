Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA631EEE5
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 19:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhBRStL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 13:49:11 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:45302 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbhBRSCy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 13:02:54 -0500
Received: by mail-io1-f71.google.com with SMTP id u1so1900124ior.12
        for <bpf@vger.kernel.org>; Thu, 18 Feb 2021 10:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=onGtYJ8oUCUNLFfJZY/KA1YQLdf7XN2ozMSXExjjyWI=;
        b=ERNdi1u9emY+aXOot7/8xCpU0DUB87m7nVdAAhNBif4NkHYEfKo+fN3rRM63IBL1rf
         p7OWsnGhaSpLDhBGw2Y58OW0/x60/XvzGxrTCXQmwo4qdP2wQkfwGtMV9WgmVPAbUI4r
         PoStgjldsosq74s1WaFUYsc5K8S82ryW8+FnCCCKNUWJ+3ewN5s1D1QKcxBbW+di08Ce
         WBEIAcGRsgAMbC0Xjh9mR9uf5YMI7dilSLa3P+/dAIKqs8MaX+XRG4NvIXPOpoHJEHrb
         gAtnSQlM1nn/zbZs8EZjOoRe2WQVPG3JX5wXRqvMQqLii8VFiOsMDYcRYmN4CFSe29uk
         Ea8g==
X-Gm-Message-State: AOAM533TsatZ3hFF+rXpSQRcOdB48AzH2pwrV5V3EW386PbcLOjmrAyY
        oN/mTT9MR4qposMyco5nv1PME26QLfREytyA0GF2HKXf6Nbz
X-Google-Smtp-Source: ABdhPJzrjrVf/do+sjx3V/gbXM8vq8+ORZsXvnAdBWF1stIqNt+D99VOUpRfusMvgQrSJn3Mt6325yuKwP3rkrVVssrpUI0oWu72
MIME-Version: 1.0
X-Received: by 2002:a92:d0d:: with SMTP id 13mr344338iln.36.1613671333222;
 Thu, 18 Feb 2021 10:02:13 -0800 (PST)
Date:   Thu, 18 Feb 2021 10:02:13 -0800
In-Reply-To: <000000000000e6f01f05bb8b9268@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099df5f05bba022a8@google.com>
Subject: Re: possible deadlock in inet_stream_connect
From:   syzbot <syzbot+b0f5178b61ed7f3bbb46@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        fw@strlen.de, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        mathew.j.martineau@linux.intel.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit 40947e13997a1cba4e875893ca6e5d5e61a0689d
Author: Florian Westphal <fw@strlen.de>
Date:   Fri Feb 12 23:59:56 2021 +0000

    mptcp: schedule worker when subflow is closed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=109b88f2d00000
start commit:   9ec5eea5 lib/parman: Delete newline
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=129b88f2d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=149b88f2d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc1ca9e55dc1f9f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0f5178b61ed7f3bbb46
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a6d14d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10caeb02d00000

Reported-by: syzbot+b0f5178b61ed7f3bbb46@syzkaller.appspotmail.com
Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
