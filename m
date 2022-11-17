Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C210062D406
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 08:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiKQH0Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 02:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiKQH0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 02:26:24 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0014299C
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 23:26:24 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id x21-20020a5d9455000000b006bc1172e639so523182ior.18
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 23:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPPkD9xqKnwp/YGjdMZVDWgGrC9/htEwoZFuymgo5P4=;
        b=vvORew556GJgDZ8FxncS63gswAg7TdknwevZGs1LRbUPx6Pk0dBZx2YBAxdMUtEXRE
         nfMZK9XjGaYu0HiOtTpNwsHRYFkM/f+vyxnKmxz5b1I+uqS3Jhyfi/DRmdRMpnRTN3RB
         BSbTzzyVez8jqG34gATIVDBlT5jhhJIgarpLgI5uSwmE0kI5r08jQy5vh0851ZhppwDT
         Tqkg+ANjVPcQcQzKGeUx3zKeNvxKAnP7Q1BllXzDAjitoOzdgamvlvuNkYxsxvknKI2c
         9+DY7SZK4HMilZrfyQpo48mqVgEUKqPM5WtYDCKEAiQQ0NNVq9SUFc5298AMGpqM1f7g
         ZNcw==
X-Gm-Message-State: ANoB5pkHlD+src6ikPoW6mjYoqo6Iy6phHgLF8ZHq6eFIjILW1AKem9F
        //eDwo6+76IwBMMnHPt4ppzJDisQfZVz/8AApQENBeoZMtdV
X-Google-Smtp-Source: AA0mqf5y/RluP/QBFQd6C1C7ZYqv72TGmOA4tDOZRPmkadLuAmV6rAYdlmAaQg7n8lWosrmirqFP+rTsKvul43RVyp+thnTMwE9F
MIME-Version: 1.0
X-Received: by 2002:a5d:88c3:0:b0:6d6:5fe4:8212 with SMTP id
 i3-20020a5d88c3000000b006d65fe48212mr828952iol.180.1668669983607; Wed, 16 Nov
 2022 23:26:23 -0800 (PST)
Date:   Wed, 16 Nov 2022 23:26:23 -0800
In-Reply-To: <000000000000385cbf05ea3f1862@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ed19b05eda581e7@google.com>
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
From:   syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, brauner@kernel.org,
        gregkh@linuxfoundation.org, kafai@fb.com,
        linux-kernel@vger.kernel.org, lk@c--e.de, martin.lau@linux.dev,
        peterx@redhat.com, shy828301@gmail.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        yosryahmed@google.com, zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c6a7f445a2727a66fe68a7097f42698d8b31ea2c
Author: Yang Shi <shy828301@gmail.com>
Date:   Wed Jul 6 23:59:20 2022 +0000

    mm: khugepaged: don't carry huge page to the next loop for !CONFIG_NUMA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179cadcd880000
start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=534ee3d24c37c411f37f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150adc52880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149d9584880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: khugepaged: don't carry huge page to the next loop for !CONFIG_NUMA

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
