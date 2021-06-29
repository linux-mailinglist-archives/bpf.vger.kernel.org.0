Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9B3B740E
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhF2OSc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 10:18:32 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:37769 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhF2OSc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 10:18:32 -0400
Received: by mail-il1-f200.google.com with SMTP id o18-20020a92d3920000b02901ee901c30f3so4621423ilo.4
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 07:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Kg5nOcsBqEKYMddrauP1mweIcVDvq/YayRMorfAz0/k=;
        b=XCr8FwvFAh8Tbz2V9yKYn4MJ545DpQMPzWLfPemr1Uisw0Rw6E4TPsKl11n6SucUBr
         +BQvJITwAKzYwsYVwnID77mVoHMzrkrwhrDOXfdoyT2IOjTwLX+Fkqm+fSgxHNG9cCWK
         /kPG7leXQmnJyoB3SW95lCQUwiANXiLGZDOrv5V4PcPbdSNqDn8K06hCz554tr1FvtkU
         dAjVwOehjgQFVrWLyIULT7BQSwBivrOzuPpxVTTbakKsgdhge/hr1BeXm0SR50D60OMw
         mE0tLzouGxNDuwciRq+nj1D9AZTSpquVTVkmOGeAcMDDjYzRFl7nszEpboUQmqPr7zcm
         kaOA==
X-Gm-Message-State: AOAM531mzSLM7XZUma1SdVKdmh9XjmAxJYgdqH07drk6+UMY8XI7Vqjj
        vvKYLZh1OlWX0ENbUNGoqXfN9PQfR8nHin2+q5PUp4iykYsq
X-Google-Smtp-Source: ABdhPJzJJf9qa4qerHgm/jHnJPF8RRfdFjLMgduFLh5UyYNe4icnAd2Po5OJYIXgHcUJm5omlKixZQuHnfviK/tbAWnI/76uJhaY
MIME-Version: 1.0
X-Received: by 2002:a05:6602:140e:: with SMTP id t14mr4119513iov.42.1624976165142;
 Tue, 29 Jun 2021 07:16:05 -0700 (PDT)
Date:   Tue, 29 Jun 2021 07:16:05 -0700
In-Reply-To: <20210629095543.391ac606@oasis.local.home>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001785c005c5e83fac@google.com>
Subject: Re: [syzbot] WARNING in tracepoint_add_func
From:   syzbot <syzbot+721aa903751db87aa244@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, mingo@kernel.org,
        netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+721aa903751db87aa244@syzkaller.appspotmail.com

Tested on:

commit:         c54b245d Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b55ee8fdb0113c34
dashboard link: https://syzkaller.appspot.com/bug?extid=721aa903751db87aa244
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17938e5fd00000

Note: testing is done by a robot and is best-effort only.
