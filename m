Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E735725
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 08:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFEGrC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 02:47:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42895 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFEGrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 02:47:01 -0400
Received: by mail-io1-f71.google.com with SMTP id v187so18273027ioe.9
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2019 23:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0DTPebv5NG8S97eb6NYfGtH6s2XhZbJcgpOSN9G3WRc=;
        b=gD5amuvX+bwn1zeRkVPDTJo1e9dbJqCkEQ5vjYcAxVgLyHC1Be4tM8N1sCPYRoc7+i
         Yn79St/VWCcHzuIBa/7vTgbECWpUIiL/ek+6pPPB4yQEL1AYuzXy0NTaZn9B7rRRbac3
         tgUiDbX6avgUgl76Cv+Gjpwduy5AKbWJJJtbhBLRS5pMQ2YWJZR/N4yIbrOUlCFmm0JB
         mcH9Eg0b6p1FmcRgtHPal4KKV6pCqJuUFvi8cWmtvhBxmPpFe1Shn0i1H1lMoCKQNo1r
         QvTbo0bapafi7YqHaKTwaRilpg5GUQ3SC2jGQnIMQz5idqViz/o7dOVyTyrs/I5M9GUO
         AukA==
X-Gm-Message-State: APjAAAVjLQu0BOkm8J00TO3NhY3ckTNQy3iCcC93eWRJKzCEu+HuIg47
        muF6pbO7VA8PuUGqrryrjLJUNLiVDYWG28JBIWLPt/Sd3pLb
X-Google-Smtp-Source: APXvYqxcRwKznu5s/WF30ioOt1OAX+adyD0fCRP3X69hk9R87NnszpPYpCAzlAXH7mBu0a2hct/HG73f5mTEx1ANoDYrvg/aI0Iv
MIME-Version: 1.0
X-Received: by 2002:a24:2b8f:: with SMTP id h137mr7710740ita.162.1559717221001;
 Tue, 04 Jun 2019 23:47:01 -0700 (PDT)
Date:   Tue, 04 Jun 2019 23:47:00 -0700
In-Reply-To: <00000000000097025d058a7fd785@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e878a9058a8df684@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in css_task_iter_advance
From:   syzbot <syzbot+9343b7623bc03dc680c1@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
        daniel@iogearbox.net, hannes@cmpxchg.org, kafai@fb.com,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        netdev@vger.kernel.org, oleg@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit b636fd38dc40113f853337a7d2a6885ad23b8811
Author: Tejun Heo <tj@kernel.org>
Date:   Fri May 31 17:38:58 2019 +0000

     cgroup: Implement css_task_iter_skip()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1256fcd2a00000
start commit:   56b697c6 Add linux-next specific files for 20190604
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1156fcd2a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1656fcd2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=9343b7623bc03dc680c1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102ab292a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f0e27ca00000

Reported-by: syzbot+9343b7623bc03dc680c1@syzkaller.appspotmail.com
Fixes: b636fd38dc40 ("cgroup: Implement css_task_iter_skip()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
