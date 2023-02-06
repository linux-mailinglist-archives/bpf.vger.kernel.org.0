Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB24868C7A8
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 21:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBFUbT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 15:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjBFUbT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 15:31:19 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E029E2F
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 12:31:18 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id e16-20020a6b5010000000b00719041c51ebso7729745iob.12
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 12:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcUfKfT8kk091mUeNDNyNXV+W/bZwlZUrmiavyzWKVE=;
        b=rzay4xvEDy30ZHjc/88pDPn32r7wxJuJqe5unMDKMcSmFKu7gattLdzFozq/RReJ/U
         lUUVu06JO8Ttjin4OE/O0TOcTaRyfGzzSUjsMr6ARlW0835pNX7cty9gKnJP8+Rjv4bQ
         Hv5z2ib+KHOy7fnHRzef7yAhqjKC+8q6/78UxLi0fZ2lHsWPmpCyaYaRtn4mDyhlzxAR
         6B2EPUjSFJye4Gd4oUHHTQUFrAsBpJRldBrY5zLBlPNt0J8AhMree8xNjftpv61dTkJc
         Ohi+Isl4Vw43qC6TNYzjfs7V8A+7u0aQvs4TVQbDP/ZQlG7IA7Bkvc4JLvoEaex/E9NZ
         GmgQ==
X-Gm-Message-State: AO0yUKXMbIYiFrdx58l3g9SPcWNDb7jyQYl03CWwFfjezkJdCjadlaly
        CGUzl6qfE5M5UD9emJstZwzZ1Ub81XF1BkhPZf7EPgYKH8UF
X-Google-Smtp-Source: AK7set/lIX/2jgf1OGRtFFrJw0DWyiffr52+TS2tT4qR8HmxfNuUDQY4i9GdUbMVWehVVSEfF9bkQInUujE4DKrS6Qceu8NmbEmm
MIME-Version: 1.0
X-Received: by 2002:a02:cccb:0:b0:3b1:acaf:d5b2 with SMTP id
 k11-20020a02cccb000000b003b1acafd5b2mr168551jaq.98.1675715477927; Mon, 06 Feb
 2023 12:31:17 -0800 (PST)
Date:   Mon, 06 Feb 2023 12:31:17 -0800
In-Reply-To: <000000000000269f9a05f02be9d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce7ebf05f40de992@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in copy_verifier_state
From:   syzbot <syzbot+59af7bf76d795311da8c@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        keescook@chromium.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.lau@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, v4bel@theori.io,
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

syzbot suspects this issue was fixed by commit:

commit 45435d8da71f9f3e6860e6e6ea9667b6ec17ec64
Author: Kees Cook <keescook@chromium.org>
Date:   Fri Dec 23 18:28:44 2022 +0000

    bpf: Always use maximal size for copy_array()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c62f23480000
start commit:   041fae9c105a Merge tag 'f2fs-for-6.2-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2f3d9d232a3cac5
dashboard link: https://syzkaller.appspot.com/bug?extid=59af7bf76d795311da8c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1650d477880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1305f993880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Always use maximal size for copy_array()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
