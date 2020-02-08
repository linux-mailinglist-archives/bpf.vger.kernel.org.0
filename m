Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC41562D4
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2020 05:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBHEGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 23:06:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:38118 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBHEGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 23:06:02 -0500
Received: by mail-io1-f70.google.com with SMTP id x2so1060829iog.5
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 20:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YdmzA7D11PRTJN9WOgeGykpVtC5L5hrmQEgxtcYNPyo=;
        b=cOWAvplG52fQnBT7xQtbDBWXQuFDXKJGtKBnZUi4BpuKwREFfZuhZRqc6rn07wXwMx
         H7Qfsz7DmpuuVptWJOAuWcvpsZIT9OfBvEGknVQp/sTWXC4Lmb45XfiW0bNMrEoARKyE
         uSX2LlZ74jY83r8x5A3QsZ1u9/8d5la+a5kg9YsImuO25vaF+BnG/UhJq3Ckl7ydM0Ks
         wgBQWop7VYCsER/T90WeJgqR8C+JgQAuMfhU6dSlWvGKAwd9PFmbaSGKS4/UPiZQH6M8
         W5f589teuvPPCb5QzMI0hsg7sv3KZFSpX4JzQFJfoOh8OVNtRJeQEOZDUruacC04PLcr
         tZSQ==
X-Gm-Message-State: APjAAAXTs4qURmbYflODT244gq0Biwr2hFudhB1EMSDY9bh8lUFjrZxY
        8ryvozwsDWTuBiCNNojeTmDPRgL1aJzAywBtAjh4F1B26mVy
X-Google-Smtp-Source: APXvYqx6+g7SHOZaaddW/1HIQIDO4JPcYx9LGs3vtbUQW2sQVYO85DabjDjhW9x29TzuvSOjB3EzxFCGFghJ6FpaAZ4nvi+3pD+q
MIME-Version: 1.0
X-Received: by 2002:a6b:92d4:: with SMTP id u203mr1503471iod.288.1581134761739;
 Fri, 07 Feb 2020 20:06:01 -0800 (PST)
Date:   Fri, 07 Feb 2020 20:06:01 -0800
In-Reply-To: <000000000000861441059e047626@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0cac6059e089f5a@google.com>
Subject: Re: INFO: task hung in tls_sw_cancel_work_tx
From:   syzbot <syzbot+ba431dd9afc3a918981a@syzkaller.appspotmail.com>
To:     airlied@linux.ie, andriin@fb.com, ast@kernel.org,
        aviadye@mellanox.com, borisp@mellanox.com, bpf@vger.kernel.org,
        chris@chris-wilson.co.uk, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, dri-devel@lists.freedesktop.org,
        ilyal@mellanox.com, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, john.fastabend@gmail.com,
        joonas.lahtinen@linux.intel.com, kafai@fb.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rodrigo.vivi@intel.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tvrtko.ursulin@intel.com,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit f75f91574617a3c6fbc821c6b156f5777a59d0ed
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Tue May 15 14:31:49 2018 +0000

    drm/i915: Shrink search list for active timelines

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121dc6b5e00000
start commit:   90568ecf Merge tag 'kvm-5.6-2' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=111dc6b5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=161dc6b5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69fa012479f9a62
dashboard link: https://syzkaller.appspot.com/bug?extid=ba431dd9afc3a918981a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1036b6b5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1651f6e9e00000

Reported-by: syzbot+ba431dd9afc3a918981a@syzkaller.appspotmail.com
Fixes: f75f91574617 ("drm/i915: Shrink search list for active timelines")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
