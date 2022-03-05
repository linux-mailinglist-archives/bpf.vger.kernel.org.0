Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85724CE292
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 05:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiCEEM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 23:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiCEEMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 23:12:55 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3652158788
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 20:12:06 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y11-20020a056e021beb00b002c3f8984f9eso6821110ilv.10
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 20:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=onw4IedYX5qQ+gs+/33tUPuWqMbo0NqLTtVJkCIiq2g=;
        b=SxOOqcs0NCM1hejF9GCvglfIvOBty47kska4VuEL6G6TXrQo+UaRcrH/N32bx5WqLO
         +Mw9i3IE6DcPm+jlgJwKo5MoC65SvNVYo/Dn7fnO/tN7ij0UZS0Cfo2HHh9xbACbq2DB
         Xl47Us3192xJxGsTtVl1m6exLjXe+APztLuM9aDFwmJ+kCR7s7EjePVL2lb6tfB+sfop
         AvVuHkSrSZcxYTzgBfWElI9T7KImuYudBiEC/veSfSP/K5XYu9jDhQa7zfThwNzlqbES
         Z3QXV0MrtD69FZ3g/SMqzBsS8TBo7rwd0LGB8J9Rp2wL5EGFcJUvv4m71s73qbkesqaG
         t0lA==
X-Gm-Message-State: AOAM531IbBKpxWgS1rpaG0uod6iBsxLErtEpX7koYro+nCf3j3xxG/iB
        dXk6CSEwp9RbitcgcYpwuoP+c/AKltXJg/N8KDibibaVTmWA
X-Google-Smtp-Source: ABdhPJzOBwKReV3RereJZlHH5ZjtC5jwfknmMso75kx0/qkY3OMmwZ+dbVFJ25ESSnLpfhjnoGRcvzf6EVGbNodG6+8WXvw/FBWI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:2c2:c247:b586 with SMTP id
 u15-20020a056e02170f00b002c2c247b586mr1696971ill.155.1646453526316; Fri, 04
 Mar 2022 20:12:06 -0800 (PST)
Date:   Fri, 04 Mar 2022 20:12:06 -0800
In-Reply-To: <00000000000061d7eb05d7057144@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000934ec105d970d589@google.com>
Subject: Re: [syzbot] WARNING in bpf_prog_test_run_xdp
From:   syzbot <syzbot+79fd1ab62b382be6f337@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, boris.ostrovsky@oracle.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jgross@suse.com, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        netdev@vger.kernel.org, roger.pau@citrix.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        toke@redhat.com, yhs@fb.com
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

commit c8980fcb210851138cb34c9a8cb0cf0c09f07bf9
Author: Roger Pau Monne <roger.pau@citrix.com>
Date:   Fri Jan 21 09:01:46 2022 +0000

    xen/x2apic: enable x2apic mode when supported for HVM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b1991a700000
start commit:   000fe940e51f sfc: The size of the RX recycle ring should b..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=e029d3b2ccd4c91a
dashboard link: https://syzkaller.appspot.com/bug?extid=79fd1ab62b382be6f337
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a719cc700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15851cec700000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xen/x2apic: enable x2apic mode when supported for HVM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
