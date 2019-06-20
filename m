Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C384D08A
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2019 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfFTOjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jun 2019 10:39:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48906 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOjC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jun 2019 10:39:02 -0400
Received: by mail-io1-f70.google.com with SMTP id z19so5497780ioi.15
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2019 07:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pcMSWZKNicDpxHahzslAEA1Gd+yI94665La65rLMOto=;
        b=G075XdKBdXY1rK0Fa9Uc/Y0BUNtuqCFAe/8duA9asUEsb34FAcpcMHAEv7XQwZOM7r
         DrPDYDbfzF3FpDAQS+68Vwcr4roXEQPgMrpLk3ouCIpelnGoKaenwbgrkmxB2wRREaRP
         XZuuloCgTW+IuqVTSRIq6CLy/NCRqfdhkYqShl1DOhrOJwfkk7cI8y7K0suY2xKC+Dew
         vzXMSUsVAA2WnPGb0X60Vx+0esimp+UDxslG/zpwJCiXsNHrMQLuqHIeRguNAQ3xYeKV
         UofkdOQXD+2t/N5DbCVbqPgqgIXegnuIUmw4NVlGUwTH+NLALCrd1tUH9tF6AcTZot8k
         aqJw==
X-Gm-Message-State: APjAAAVwTujfA2AqOOlJcbZ9QTWxDE/XuXljABW4poKmq+mssInGTBES
        VFGR37rBMkfHwX89x8xUArkpI0Ms2Q8KZxATpAOgwLfWhexJ
X-Google-Smtp-Source: APXvYqx+TYIh2vUv0uFyzxELBI4G5xYxTzkRj8btxI6/Q81qlMHz++HJM+3ytmsKnLPIC+Zek+ch3AjsBD++T5mDMbdR5vtbxIMl
MIME-Version: 1.0
X-Received: by 2002:a5d:8c87:: with SMTP id g7mr20051791ion.85.1561041541089;
 Thu, 20 Jun 2019 07:39:01 -0700 (PDT)
Date:   Thu, 20 Jun 2019 07:39:01 -0700
In-Reply-To: <000000000000946842058bc1291d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000894e8f058bc24e2b@google.com>
Subject: Re: WARNING in add_event_to_ctx
From:   syzbot <syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        jbacik@fb.com, jolsa@redhat.com, kafai@fb.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 33ea4b24277b06dbc55d7f5772a46f029600255e
Author: Song Liu <songliubraving@fb.com>
Date:   Wed Dec 6 22:45:16 2017 +0000

     perf/core: Implement the 'perf_uprobe' PMU

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17561aa1a00000
start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14d61aa1a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d61aa1a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=704bfe2c7d156640ad7a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d8b732a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f7a5e6a00000

Reported-by: syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com
Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
