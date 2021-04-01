Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC5350D39
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 05:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhDADji (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 23:39:38 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:48667 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhDADjG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 23:39:06 -0400
Received: by mail-il1-f197.google.com with SMTP id g1so2963930ild.15
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 20:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y0jAq5S9GiYMY36r36rGvrhgs2PgZlLJSzcOUpx10aI=;
        b=owkKGRtuSSM3x8JxWNmUINzEEoxwn4pW4hwMMhtxbqVbqLzoVdct0j0U4bIESdo6Zu
         Vo0FP7S6dHQFKRo4ob0ayhuUFZw8WZ8tYQnNjUNu0246nzixzCDCPdi/bRYpTbkdyEL+
         J2jQ9Mc+jUSmmV919BI+jipu6ospTng5gRD6OFBgkDnOFHdz8gxQjJ4osEpED1dc6/xT
         93kRmfg80l4KhrxQeG1opCo70p//0GmtQr/EACBhBb2qdQ7F0SipmHFzt7wy0ETLAiL8
         W27bgVJCRbe9Mr4wmsvActt0pyCxOXxSbFqeme+J8owirIG4+DR+5oP6OQ3dT1WvwiOz
         JRdg==
X-Gm-Message-State: AOAM5312uMUi2QFJwzrqbKBXgayy6X28kpeZbLSFSEWTph5elPW6AQXO
        j+mFYVf262xPHRRvcVfpOLHK57kXiWhBM8w0u3NYzRr5zTsM
X-Google-Smtp-Source: ABdhPJwzE7eMfw19r1VuuSvTtkhe67TPWs/rerGhe9Jm/clMO1VZfFxpEvlHGpoSYRqwFXicx9bTkonPXQ0pNzLMdY1wAwRSdeeF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2603:: with SMTP id m3mr5782480jat.64.1617248345919;
 Wed, 31 Mar 2021 20:39:05 -0700 (PDT)
Date:   Wed, 31 Mar 2021 20:39:05 -0700
In-Reply-To: <00000000000046e0e905afcff205@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c193805bee0f97c@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in bpf_trace_run2
From:   syzbot <syzbot+845923d2172947529b58@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        kaber@trash.net, kadlec@blackhole.kfki.hu, kafai@fb.com,
        kpsingh@chromium.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mathieu.desnoyers@efficios.com, mchehab@kernel.org,
        mchehab@s-opensource.com, mingo@kernel.org, mingo@redhat.com,
        mmullins@mmlx.us, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        peterz@infradead.org, rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit befe6d946551d65cddbd32b9cb0170b0249fd5ed
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed Nov 18 14:34:05 2020 +0000

    tracepoint: Do not fail unregistering a probe due to memory failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123358a1d00000
start commit:   70b97111 bpf: Use hlist_add_head_rcu when linking to local..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e0ca96a9b6ee858
dashboard link: https://syzkaller.appspot.com/bug?extid=845923d2172947529b58
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10193f3b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168c729b900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tracepoint: Do not fail unregistering a probe due to memory failure

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
