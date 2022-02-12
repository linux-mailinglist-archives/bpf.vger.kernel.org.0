Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206134B32DB
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 04:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiBLDYS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 22:24:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiBLDYS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 22:24:18 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAF12CC99
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 19:24:15 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id p65-20020a6bbf44000000b00604c0757591so7723070iof.6
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 19:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HIaZdliGeUGHxPX/pnldMtfHMd66z97/0dotF/EKdqA=;
        b=gKVsdomHVujhAqxwdW59ZTMO5+z34ax685YZQozM0LQPGX8CdxYte1DxN2CNq+IpZy
         o4BDIXP+Xn3LEtOLsKapbiLhm39DR5NmRL0P+HggrY+Agvhl4tKCN4gRIuE2PQk8e8lE
         ot1HjZUrmTqRaT7LhAax9fhQDKa2tAnAqDcVqUk1KBB+AEqwmzqE/7MaHgtbiQLM3AEa
         RChOMT/0vGTQkMrHqYt7tfAAC7eaCm3XhIqG/UmaCY6CdQJbuyZYdbj1xH2sbNqQXxgD
         XRxZyJuc9JU3cFccNJIWtHwV5Z6q8WsyosU6BhIzOuKX9pUm6wzeQIUnkPeqGw4g1szV
         cjEQ==
X-Gm-Message-State: AOAM533JgUxu6kq+J+3ZN4wb5Zr7wWk6X5hI7bY4axGOt7gXIk6aUMtp
        Xxg0qokLkk3DLezERdEoIOevHHFXXYwKK/kvh3VC6lFN5wIn
X-Google-Smtp-Source: ABdhPJxCfK7Iy7cDY5K320ofBfU6awjoOFIusgr1bupoMTBw316F8wBt29XqX3iJC5RJtJdQr8Xai18AjbafKuofTwhgsZBaceQV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:: with SMTP id t10mr2564156ilu.65.1644636255275;
 Fri, 11 Feb 2022 19:24:15 -0800 (PST)
Date:   Fri, 11 Feb 2022 19:24:15 -0800
In-Reply-To: <000000000000c560bd05ad3c5187@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7d07705d7c9b7a4@google.com>
Subject: Re: [syzbot] WARNING in rtnl_dellink
From:   syzbot <syzbot+b3b5c64f4880403edd36@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, harshit.m.mogalapalli@oracle.com, hawk@kernel.org,
        jiri@mellanox.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yajun.deng@linux.dev, yhs@fb.com
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

commit f123cffdd8fe8ea6c7fded4b88516a42798797d0
Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date:   Mon Nov 29 17:53:27 2021 +0000

    net: netlink: af_netlink: Prevent empty skb by adding a check on len.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107b5472700000
start commit:   cd02217a5d81 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=b3b5c64f4880403edd36
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116f8172900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1145d1b1900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: netlink: af_netlink: Prevent empty skb by adding a check on len.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
