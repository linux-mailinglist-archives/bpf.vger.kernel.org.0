Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A148F54958B
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353977AbiFMLbL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354409AbiFML32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 07:29:28 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E1CE1A
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 03:44:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w21-20020a5d9cd5000000b00669e6796a8aso1106611iow.7
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 03:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fEZcgfMVZzqJc7ybxib8fa3FVpwuXcVDtcH0dPsG3A0=;
        b=Puz34NoN2ampriFi1KNZqNA4+KmJy/aaRzcNF4kEee19Yb7kizXZiLEu97CLk8yAG8
         xqX41mmihiHp3DiV3AVpsbFvGeRyGeNFAbQopTnjQSorCTLvQkR58vn9lvfGKTugVW3O
         LXM8CCm4VY/q82pfEWE5hiXiRw5/7Ejh5P7b7EGaI4Xp++UMOLS0hoGlP/5/B0Q05fvI
         mh90r8fThtqs1B6T1Enlekg0lkAL1i5+QvB/X1mQncKX+TuEtvtG/6YXjPCqGL2w8K6N
         OVczjEVrVop8r88au9Ac8vzra/GYZndeA9TPC1HF1j11MXJpNoJ3khphdFWm+11MuGwH
         TvNA==
X-Gm-Message-State: AOAM533AkFOjoTkdUJO2N5vLZQI9VZxBUXo6icmN+KRzp3M8Jm7lnAaq
        N3cNeLGBv2nrBQPoBgaQ3VaRU/mp/vNBpTEYbP4uOzxqQ1Xk
X-Google-Smtp-Source: ABdhPJzYGM8wyFXxpBqce+DRay56fuykYJTlm3Z97gco3gXVLKQDBQe+LJkoivDQ05RRSo2Ln1SRxrgMrCK2ym0icmTglewkd24E
MIME-Version: 1.0
X-Received: by 2002:a05:6638:438c:b0:331:adac:a274 with SMTP id
 bo12-20020a056638438c00b00331adaca274mr23027146jab.192.1655117047472; Mon, 13
 Jun 2022 03:44:07 -0700 (PDT)
Date:   Mon, 13 Jun 2022 03:44:07 -0700
In-Reply-To: <000000000000e2fc3f05e141f930@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad299205e151f7d3@google.com>
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
From:   syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brauner@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        ebiederm@xmission.com, frederic@kernel.org, hawk@kernel.org,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        john.fastabend@gmail.com, josh@joshtriplett.org, kafai@fb.com,
        keescook@chromium.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        netdev@vger.kernel.org, pabeni@redhat.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
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

commit 09f110d4a1597185a5ed177da8573eec997b7227
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue May 17 18:30:32 2022 +0000

    rcu-tasks: Track blocked RCU Tasks Trace readers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170f6ee7f00000
start commit:   6d0c80680317 Add linux-next specific files for 20220610
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148f6ee7f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=108f6ee7f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177b6230080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148207bff00000

Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
Fixes: 09f110d4a159 ("rcu-tasks: Track blocked RCU Tasks Trace readers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
