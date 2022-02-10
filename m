Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9964B060D
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 07:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiBJGIG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 01:08:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiBJGIF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 01:08:05 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCAC1A5
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 22:08:07 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso3259444ilu.19
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 22:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hxxPMFG7Sy5R8OTw+DHD+CiI9MhDe02HH/eavpKJlVI=;
        b=a4KZxX35uM+iRT2VjhW/sTIRIysDEwYQQc90PbyZHWevTLmr4G6+ZJMLAmhpotTRdd
         L/vYuICg+m/jlvDy//ngzhRmJqzaLZTPg+RGxs5BGQEduZut5LcUPb1DHZhqBZ2Z8jsj
         CuI5frZCMyJSVUIEo9Is6OJ59R5HjBEpKawsKe04ISI2qKLh7yUJlcLpRXlsuzRvFLD6
         IjiTRePqxZBvW2r6lOFUwHrbhkSumuqs15Bx5qgyhJgI7HGKNUmcO491DaAeZ68eTBhM
         0tPPSTAXABiUeVOxhkMNHbGy31poA1QDGxPQnbBJ2b5HHuyX7x+n7ljnrFS8ZKeR24jK
         +SlQ==
X-Gm-Message-State: AOAM533ju35fy/TOOtBDxiDURgxaeQ8hMLYedPWvJRvNmwa0pU/EiXYw
        FsDGCmjsJgovXdi8D6bs7maPPfGEHYGwArIIeGiTB+l+uG6R
X-Google-Smtp-Source: ABdhPJxoAleQUKXdKQfyFJ/lU/DvKG+eN88p4ZFdGI/Tl2jq2ibPHrnZmPgShLp0DuHR0xD1pBw8UCAuxjN2bbrZc03Lii2YDBgU
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd2:: with SMTP id j18mr3118329iow.92.1644473287137;
 Wed, 09 Feb 2022 22:08:07 -0800 (PST)
Date:   Wed, 09 Feb 2022 22:08:07 -0800
In-Reply-To: <000000000000a3571605d27817b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f60ef05d7a3c6ad@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in xdp_umem_create (2)
From:   syzbot <syzbot+11421fbbff99b989670e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        bjorn.topel@gmail.com, bjorn.topel@intel.com, bjorn@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        fgheet255t@gmail.com, hawk@kernel.org, john.fastabend@gmail.com,
        jonathan.lemon@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        magnus.karlsson@intel.com, mudongliangabcd@gmail.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        w@1wt.eu, yhs@fb.com
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

syzbot has bisected this issue to:

commit 7661809d493b426e979f39ab512e3adf41fbcc69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 14 16:45:49 2021 +0000

    mm: don't allow oversized kvmalloc() calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13bc74c2700000
start commit:   f4bc5bbb5fef Merge tag 'nfsd-5.17-2' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=107c74c2700000
console output: https://syzkaller.appspot.com/x/log.txt?x=17bc74c2700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5707221760c00a20
dashboard link: https://syzkaller.appspot.com/bug?extid=11421fbbff99b989670e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e514a4700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fcdf8a700000

Reported-by: syzbot+11421fbbff99b989670e@syzkaller.appspotmail.com
Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
