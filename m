Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6B6B11EF
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfILPRD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 11:17:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:32928 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732983AbfILPRD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 11:17:03 -0400
Received: by mail-io1-f71.google.com with SMTP id 5so33433920ion.0
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 08:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RPiyZVry3vcCdktPjsrAehjjz4bpmZ6S8izbMfh4+Qw=;
        b=Dq1rBd7a0DfhKkRm7mf6GV0YVcDc7pOZrIawJbsovzpaY+xwAk1XN8qMFsRmBYKNnx
         MOgzVoa+SeyRIuN6rwTzuDc4Ke7uX3uxXlNeNONOU/PR3byrwZjDPDBvtvry8ZYcpvf8
         8LHQEW9RwqX/tevL9bQ6FvmIE+Q4JsfIetC3NZgd9iOMHvY2ZEIoPxjpIvNZN0BmxW1r
         +Ra4IRrSYzOeEOakWZyze3xttSWgFG4rQM6KM9IIUUb8KglZ9ubRWRPbQ1iEOhdzrF+N
         UZAWwg7vijJmyTKmYziJistHqcwTj+YXulaOmTaLk1GTlryUHz6woEw4H+tYTAsongwP
         KATQ==
X-Gm-Message-State: APjAAAUNKqkpZcKcxpBvvFuAb7RtuD/LRfdS1a+DR/faRbXj3UipKxLW
        JHUuewANA3O2J68YO+mnwHeKBukKQh1zGwVJzweNgikw70oT
X-Google-Smtp-Source: APXvYqzSR03YPSVhMgY8omiNzjtKp/LsOhihqJynqTinJuXFm9yeiEQpDpPKj8OnPE+PaoUQpZvFmlFn8e22sLT7FtGXZct/f2eo
MIME-Version: 1.0
X-Received: by 2002:a02:aa84:: with SMTP id u4mr23912052jai.14.1568301421376;
 Thu, 12 Sep 2019 08:17:01 -0700 (PDT)
Date:   Thu, 12 Sep 2019 08:17:01 -0700
In-Reply-To: <CAKK_rchVQCYmjPSxk9MszV9BtF8y04-j2dpjV0Jg3c+nrRNEWQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f3a3a05925ca177@google.com>
Subject: Re: memory leak in ppp_write
From:   syzbot <syzbot+d9c8bf24e56416d7ce2c@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, jeliantsurux@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, paulus@samba.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+d9c8bf24e56416d7ce2c@syzkaller.appspotmail.com

Tested on:

commit:         6525771f Merge tag 'arc-5.3-rc7' of git://git.kernel.org/p..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6131eafb9408877
dashboard link: https://syzkaller.appspot.com/bug?extid=d9c8bf24e56416d7ce2c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12610ef1600000

Note: testing is done by a robot and is best-effort only.
