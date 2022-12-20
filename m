Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E7D651C7B
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 09:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiLTInc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 03:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiLTIn1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 03:43:27 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6033C178B7
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 00:43:26 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id s2-20020a056e02216200b0030bc3be69e5so1070503ilv.20
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 00:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77qvNoQqle0MfKLDQMi01YZLkngrkg9aZffzgWoC0vY=;
        b=WEq3wSTu277IlUiuiVE+ENFKRjowMk51mB+/ECTtdNUzA4R0XiUYVpFg/3MsaxRo1O
         MoYbVcARAyL3qRuyQqGBqKrPDPOFcBYWTtjRStanpd0k7amATqy5GtuLKzLkVx5+DJXX
         fdp6qkAFLnD+48yXa8ZkpH1g2zDjHjqlyAchqnBvnAivcO9koIfB4xTl1lCdJNDeHtsK
         VELMHfu9094UlGAwdRI7ULWv28ztq3M7NbCZtm/8YMX52q0ofMkt/h6+t4S7GGyxKlS+
         Y3516Y3H32Yay0aP525QR5JH/qkOrNuYTdgsn8LaeiVaQRA7ybNcxYw2Y6aYiTKZ2bYy
         PFrw==
X-Gm-Message-State: ANoB5pn+lzXVgB6tNmDWI2YXB9qWIEI4MPm5v/U5q+TbGetP706QHlv6
        fXsWydF369MoG06B78B15x6l79FpezjO/03n6KVlVAjXOFOW
X-Google-Smtp-Source: AA0mqf4KHT2PjH0rudr1knR4xY3Cueu+ZSBoGTVC3IgyDsnWzkduYtWlNbZNuj+1lcG9wQRkygZ76sBT0PKeMjXcG8DlWn7Oafxq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:303:129a:8157 with SMTP id
 s10-20020a056e02216a00b00303129a8157mr28409262ilv.38.1671525805458; Tue, 20
 Dec 2022 00:43:25 -0800 (PST)
Date:   Tue, 20 Dec 2022 00:43:25 -0800
In-Reply-To: <Y6Fxfw5fhHhQYaSd@hirez.programming.kicks-ass.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de0f0b05f03e6d9b@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5791 } 2673 jiffies s: 2805 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=121ea2e8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e91ad4b5f69c47
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d4ad4f880000

