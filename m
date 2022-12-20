Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FBA6527E4
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 21:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiLTUaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 15:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiLTUa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 15:30:27 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB201CFC9
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 12:30:26 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id z200-20020a6bc9d1000000b006e003aecf04so6038802iof.16
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 12:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lO+onbVv6bZVIEl7Kh8E9HbEaMf0DW2YgnQtYSE8Pw=;
        b=FnguJRQ0vAAc4gvJUIQ4ZwZ2M6JHQixve5uJNSkmx4EyfjtTT9RHZeUVBejxmteSog
         Vp0Om33teiNiwBazjaLYO+F29aEjZP+EPVJT1AwrKzUPR9xt4bt6d5M8iYEv9ybd2b+o
         jO673A4rw1KOKbrbD2ObUDRRRNGcftOmClpTAjaO/lUNWlaAQ3sUiY1bCQmcliv3BSLZ
         FHteQuYKT4+OpbUTaTcKELiIzZ2bN8i/4Kp/ZX+6MjhvMA6O5KnH6ZZkAZvhD152w+oF
         Vf6XIOpBiKluFMmf2L3nh4XQ7+lZWwDZPAsAnPTd9ZU8Ze8d4KYidaAXKwJzMBpEGkX0
         Onng==
X-Gm-Message-State: ANoB5pk++V3Ui3xN2QieTXqSP1q9bayAVtGTtZnaytMWHM6U2fmVNKpT
        /7W0dDMcCwvT2lHixMe8qFzGv1NhltSTcifyD+x1yWL+sFQF
X-Google-Smtp-Source: AA0mqf6oL6u1g0efHMd1fRNYolfsD82ctmu3LGNm613o4B0KDZY2tz7ouwZSsZtmP4f8F01iKWsLk1o6RVRsGcZKn06LeI7DITCC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4d2:b0:304:d061:6cb9 with SMTP id
 f18-20020a056e0204d200b00304d0616cb9mr2099951ils.168.1671568225461; Tue, 20
 Dec 2022 12:30:25 -0800 (PST)
Date:   Tue, 20 Dec 2022 12:30:25 -0800
In-Reply-To: <Y6ITpE770+kZ63vp@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bee2205f0484e1d@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in copy_verifier_state
From:   syzbot <syzbot+59af7bf76d795311da8c@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, trix@redhat.com,
        yhs@fb.com
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+59af7bf76d795311da8c@syzkaller.appspotmail.com

Tested on:

commit:         041fae9c Merge tag 'f2fs-for-6.2-rc1' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc914f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2f3d9d232a3cac5
dashboard link: https://syzkaller.appspot.com/bug?extid=59af7bf76d795311da8c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10cacf77880000

Note: testing is done by a robot and is best-effort only.
