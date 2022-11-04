Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D121B61A4E0
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 23:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKDWwe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 18:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiKDWwP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 18:52:15 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3F43855
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 15:50:23 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o13-20020a056e0214cd00b00300a27f9424so4791927ilk.10
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 15:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQUV465XYKy6BEOy3Swc3M1CyT3Q1DkqUbMYNjsBM7w=;
        b=YfgI0OaPvl+4QVBrQ5oXfer0yeLfaoFU01LrGtZUxlBvXIBUzPyJ5E0Uv47JvYoRfx
         Kn0dXzz+Vd29JtZaouAAR/hAxvjyFyqvZr/64mwpT6kG9l8hlw0EHI4N42ESaA09Pcb5
         wvOkkrrSgyU6e3XpljeRfvtzMadRiKod+ZKNqoXQK6Qy/rLrtrGNR0RgyyDnj/POmr6V
         cGzPwrFwVYxbhVtMPUHBodqy5DuKJGhXvQqhJdAxeCFsmb+Rfa87fE6wXVc/gXLIzVt3
         vzeveRubiuBXSZaiRRSZ+KJv0I+sYbRSURtQZqPYo1FwnG7C+qdtr/sPuOInPytvftrZ
         0ZBg==
X-Gm-Message-State: ACrzQf3Fx0ufCG8752vU/gvaLA42pkuSIhtTu1LRXODI4AHW34xYOyUc
        HuX1U6lHS50irSbteNkbVa/D0TDT10pnccHNE8Ti15+nOpyy
X-Google-Smtp-Source: AMsMyM5nTnIogJYJ095mPEs92Yep38gpfi+2iOs4VSUyK/pRUwAakFTI8laAK2zkHMNKd64/tVLlrFqFcjq22AiZc4BVcdLyhALO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2107:b0:375:ddb:54c0 with SMTP id
 n7-20020a056638210700b003750ddb54c0mr21194896jaj.244.1667602223078; Fri, 04
 Nov 2022 15:50:23 -0700 (PDT)
Date:   Fri, 04 Nov 2022 15:50:23 -0700
In-Reply-To: <0000000000009da4c705dcb87735@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002227cf05ecace68c@google.com>
Subject: Re: [syzbot] WARNING in check_map_prog_compatibility
From:   syzbot <syzbot+e3f8d4df1e1981a97abb@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.lau@linux.dev, memxor@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, yhs@fb.com
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

commit 34dd3bad1a6f1dc7d18ee8dd53f1d31bffd2aee8
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Fri Sep 2 21:10:47 2022 +0000

    bpf: Relax the requirement to use preallocated hash maps in tracing progs.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1599d319880000
start commit:   200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b664fba5e66c4bf
dashboard link: https://syzkaller.appspot.com/bug?extid=e3f8d4df1e1981a97abb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165415a7080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1716f705080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Relax the requirement to use preallocated hash maps in tracing progs.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
