Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7B6E65A2
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjDRNPq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDRNPp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 09:15:45 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AE5125B7
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 06:15:43 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-760d7046e89so349242239f.3
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 06:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823742; x=1684415742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1E/CPVb6H8VyxRsyGiJWxP2UWi3TCzv8QPJdKDcVdk=;
        b=KZXGXPOU2DZE9avtKOlvC2ns5WNssKwicm4zG6vohl+2+PieU0nC722NwteL7tSAeX
         O0JJtAucAR1wRojyHBXqN1p8bRlbS9TcW0+/yvZwaH6quePe8uZYUaUYweSjg7anBmW9
         lat/5hqI6MP7/vqmAumxZLAa038WMx+bSI9wjvErQBVPPBFvq1jWHMseKOuAHTJg0s2z
         58Av5OVb3uXSUsDH1Yk6NCMG0xv9j/sTrn7n/VHnY3XerJMy43q0FTYJYy/cQapmXx1A
         35CU7MXHd0JdNzLy2z2FFSShxM1wQR/J6sQxk6F4JP8tU/8kpFtC29cpzl8bwcreSX6i
         PRpw==
X-Gm-Message-State: AAQBX9eX5lwX561c9zd6mzJ7WAMEWUKHXXZDMbbSY2vzMMJOQIcx0AnI
        526idDehI0sKNvTW60DOT2XyGztqE4WEMTaeNpMH5UozQnkD
X-Google-Smtp-Source: AKy350bK6tUhkGWRadBcmLmWjSYESdTvhu9DQiBCzqdhfvo2xBb+dNdo/jaDbYIhm0DIoA9zM8Nu0yWO3Dtt07JP+fFHyoJAXZqA
MIME-Version: 1.0
X-Received: by 2002:a02:29c9:0:b0:40f:9ac9:50f2 with SMTP id
 p192-20020a0229c9000000b0040f9ac950f2mr1559935jap.3.1681823742813; Tue, 18
 Apr 2023 06:15:42 -0700 (PDT)
Date:   Tue, 18 Apr 2023 06:15:42 -0700
In-Reply-To: <000000000000ea7a5c05f051fd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3f07505f99c1a97@google.com>
Subject: Re: [syzbot] riscv/fixes boot error: WARNING in __apply_to_page_range (2)
From:   syzbot <syzbot+5702f46b5b22bdb38b7e@syzkaller.appspotmail.com>
To:     alex@ghiti.fr, andrii@kernel.org, aou@eecs.berkeley.edu,
        ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, dvyukov@google.com, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        luke.r.nels@gmail.com, martin.lau@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, xi.wang@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This bug is marked as fixed by commit:
riscv: Rework kasan population functions

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=5702f46b5b22bdb38b7e

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos
