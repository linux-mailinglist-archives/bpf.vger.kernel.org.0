Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79C54B0975
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 10:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbiBJJ3S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 04:29:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiBJJ3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:05 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24910B3
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 01:29:06 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id q15-20020a92ca4f000000b002be3e7707ffso3591638ilo.4
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 01:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lbZClnawL85i6y/f1XZKEH3U2806L2hF7lFn0+Ro7Ew=;
        b=JULnGOCfhQDDAaTThBeBGpo53DF3ASw9hJ1V5B+lpyC+TbB0qHddCVKbqAnK8Jyx9t
         a63PaLaEViRHRIYwZWO8NuYcp/6hgL1MZBV4jiASiQkeRwKxsl+cf0R3DMF/wi4oJnIW
         fOfYKSFm8NWscgY0udezcuZd6NhUNRrVwrY6UGf8W3Uo3FEXIS2tZ9xIq8UC5pP0FQwg
         rF8tccIgaL+U20xQlKEXanqPK/B51LRYi0AABnXd78JDd2Hc4wpmKOXVhpIH74h6Xooi
         yLgv3ntFDo4KN+v/xywhL6hfPL0XUYqgoiy4bxBa8beLAoU+302oS4SJeeX2xa7zo43m
         weWQ==
X-Gm-Message-State: AOAM530lscHjF15a9D0YnDEAWjs9eO1pdbN//h8YTxBHYfGrDkWBtNiP
        Nhun+JD1qCQwcJKpx9y4SJoVkmO8WoBnU6uwDaK4QOgUJdxZ
X-Google-Smtp-Source: ABdhPJx22vdsd9ZwS5xcJlnZq2r7nAA5BqmnE9xXQOkXPLW5oeCWMIkcNmqMItDy/Lg+pycfhLQYxawcp7pQ1kDwS81fqOWh7+0x
MIME-Version: 1.0
X-Received: by 2002:a02:aa0a:: with SMTP id r10mr3655553jam.246.1644485345948;
 Thu, 10 Feb 2022 01:29:05 -0800 (PST)
Date:   Thu, 10 Feb 2022 01:29:05 -0800
In-Reply-To: <000000000000a16ad7059cbcbe43@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e238bf05d7a69450@google.com>
Subject: Re: [syzbot] WARNING in bpf_warn_invalid_xdp_action
From:   syzbot <syzbot+8ce4113dadc4789fac74@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, dvyukov@google.com,
        eric.dumazet@gmail.com, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, toke@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 2cbad989033bff0256675c38f96f5faab852af4b
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Nov 30 10:08:06 2021 +0000

    bpf: Do not WARN in bpf_warn_invalid_xdp_action()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d50baa700000
start commit:   b3c8e0de473e Merge branch '40GbE' of git://git.kernel.org/..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce4113dadc4789fac74
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113c8a3bb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16eb4307b00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Do not WARN in bpf_warn_invalid_xdp_action()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
