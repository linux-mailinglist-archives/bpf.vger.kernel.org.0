Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E256D6284
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 15:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjDDNQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjDDNQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 09:16:16 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F52F3C3E
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 06:15:54 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n9-20020a056e02148900b003263d81730aso9987458ilk.0
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 06:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680614135; x=1683206135;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1E/CPVb6H8VyxRsyGiJWxP2UWi3TCzv8QPJdKDcVdk=;
        b=Ge8A5B/XPjYX8ZZsRMy+qiaIH9sSMrQWJ4ThGIYnAKF9KKsO2hNKZSnYNukCv3guFy
         4Skx2Tvot64IwGUh5PhIV7ayjuwoPYKqZSnTEWa/Ye14qT2hAwBV/pJIDHLIN8saKavv
         orlLVSo04/qQIKTsNTnTTM4MS4YhKxPiC7m6Q1rcnPKyQP8Lw+fX36J03HLo0C3BlPSO
         6wZlWlRyZKfnW3om9EJy0y54NQRx1+So1OJtBWDCu7S7YhtxeHdhTiEhV6A5feFnto4e
         23lG6qj9ultp+BcV4i78rY9AmmDvNgDA5nIr7OysTi74McK1dcAaInLGPcGKFon/8xBP
         M3dA==
X-Gm-Message-State: AAQBX9ePhJ8Zw5gZu+x2A0ZTv+fjkV+wmwwTt/inmDvDfgCv+nMq4h8l
        Q9c1cQRUogSUEi0OqSxckdiIGwHsD6MKcOCRqft9Zgdnqe8F
X-Google-Smtp-Source: AKy350a9HLTipr+raKImLD76mGe3Np9Ljig3Z9sLELiKdBwISbIN4VnWZyemyNCQ7gxBcZbQOpO+Wy2G6itx3Us7y2KbIi/Xr61s
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:325:f785:6a6 with SMTP id
 x13-20020a056e021cad00b00325f78506a6mr1608281ill.6.1680614135456; Tue, 04 Apr
 2023 06:15:35 -0700 (PDT)
Date:   Tue, 04 Apr 2023 06:15:35 -0700
In-Reply-To: <000000000000ea7a5c05f051fd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c6f3b05f88278c5@google.com>
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
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
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
