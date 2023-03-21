Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1264C6C3263
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 14:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCUNOm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCUNOl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 09:14:41 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3939820058
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 06:14:39 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d6-20020a92d786000000b00316f1737173so7915070iln.16
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 06:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404478;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1E/CPVb6H8VyxRsyGiJWxP2UWi3TCzv8QPJdKDcVdk=;
        b=pVD2GNme4ckRWwRDGIJWIsFHK5s+uscpACwLhHkgHJw6e45InVHTIygVOGFcGF7Trb
         22xNie8bT4z2DtZY8q4puWjQ/XH3EoVKatgf7jz10zt96y22hRbYghH9KrcXKJWjaDRj
         WuEvuencrfw/Ic4MabOO9e96XppT/H7a3i41K2il5boyJS8AL/kdMPUCMxLtYSfJCfU0
         zbE92p8wagB+0rP+v/CQJuJRNsD0NFdaFuHYfhQDtFC2IyP060/b2ycPLe4KqEdI/GTp
         S+W/oOL0DOYU9aZ1SDPv1ntMlpPfiS4M1C49bL+qQsXnRJEfSTbQ/AYwNG8YHerxAiQU
         FJEQ==
X-Gm-Message-State: AO0yUKXolR8g6iltSfrYQxyvAhFUQBUpDjxmYxRRCls+jpDi3hE45Ce6
        k/zm8x37fbsDXSYT3zQCxb+GDienibhmEstpd6tx/lwSmDTq
X-Google-Smtp-Source: AK7set/s6ej3JV3Xsl6KlLwe5mBRC4+3HQxIGvDZNFwhkHinh5peA+vo1p3wVHAfY3eJ5A7/xT9ehxiKPiehGXUDwIA3ROPqBwGS
MIME-Version: 1.0
X-Received: by 2002:a6b:8d46:0:b0:752:f038:6322 with SMTP id
 p67-20020a6b8d46000000b00752f0386322mr846819iod.0.1679404478524; Tue, 21 Mar
 2023 06:14:38 -0700 (PDT)
Date:   Tue, 21 Mar 2023 06:14:38 -0700
In-Reply-To: <000000000000ea7a5c05f051fd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006071aa05f768d333@google.com>
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
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
