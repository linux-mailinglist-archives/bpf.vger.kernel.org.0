Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B038247C7FD
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 21:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhLUUDL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 15:03:11 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:49699 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhLUUDL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 15:03:11 -0500
Received: by mail-io1-f71.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso9659828iov.16
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 12:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8iSm/uBCJS86MMzYSjFmW+WAPKaAxHZfRlpQj+zoC0w=;
        b=yc9VBuFjcP9v7Dc4Hy3oPqrjmp2CHkxJf91fe1L+f/b85L0HAGJlyth0pu4zmfYm1a
         zN7aXmp2n2rDpvvBu1C+kGQPMktPg22LoX0VmNZsX2w6HnmBAR4vgvgNaqsfOwueWg4b
         srmWg3M3/vy8Bk5nbVCMMlJMJycJKNVaPphBobxHs6sJm+E1hhuxpJ1e8/pOKNRnBF+U
         /5Eb6iwYU5OVM8gc/WUcKNS7SOELgdSdy0xU910ad4yedzeFHgzSZEycJAqZifPtBfJE
         Te4GtMBYf/8XKXB1OGe9rw/AHm9vwqBEOo7hpt7Dn6kDlMOB97WC11BTdFUCGyrrvTof
         uMPw==
X-Gm-Message-State: AOAM531IdzazIBKqiqe/b75+LYipuLC3eoW+wf5zaHqFKrfqNN+Kl5Wp
        W/ustZ7dhbp7fzdMvb8fPg8vag7jUmW2PiYDYZP4Gt8dpBjw
X-Google-Smtp-Source: ABdhPJwBGif4rE5qZfX9H5rQEEUY/wa5xt8kUHMqK4v6JPgw1H7L9BJMJGq439Fy7XcYqKFPEGMYB7MBEEY/tZhlGymGgb4m2tQH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1410:: with SMTP id k16mr3199061jad.253.1640116990561;
 Tue, 21 Dec 2021 12:03:10 -0800 (PST)
Date:   Tue, 21 Dec 2021 12:03:10 -0800
In-Reply-To: <000000000000c54420059e4f08ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cd20305d3ad7e8d@google.com>
Subject: Re: [syzbot] WARNING in dev_change_net_namespace
From:   syzbot <syzbot+830c6dbfc71edc4f0b8f@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com,
        dsahern@kernel.org, ebiederm@xmission.com, edumazet@google.com,
        eric.dumazet@gmail.com, fw@strlen.de,
        harshit.m.mogalapalli@oracle.com, hawk@kernel.org,
        jiri@mellanox.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        marcelo.leitner@gmail.com, mkubecek@suse.cz,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        saiprakash.ranjan@codeaurora.org, songliubraving@fb.com,
        suzuki.poulose@arm.com, syzkaller-bugs@googlegroups.com,
        tonymarislogistics@yandex.com, will@kernel.org,
        yajun.deng@linux.dev, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f123cffdd8fe8ea6c7fded4b88516a42798797d0
Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date:   Mon Nov 29 17:53:27 2021 +0000

    net: netlink: af_netlink: Prevent empty skb by adding a check on len.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168acc95b00000
start commit:   990f227371a4 Merge tag 's390-5.9-2' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=21f0d1d2df6d5fc
dashboard link: https://syzkaller.appspot.com/bug?extid=830c6dbfc71edc4f0b8f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101761e2900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: netlink: af_netlink: Prevent empty skb by adding a check on len.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
