Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C104A8244
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 11:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiBCKZM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 05:25:12 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:40865 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiBCKZM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 05:25:12 -0500
Received: by mail-il1-f200.google.com with SMTP id h8-20020a92c088000000b002bc03432559so1386765ile.7
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 02:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Rxhq5+VXSIrIwj7a/GsrEywPOO2yQbABshUuuSgeFDs=;
        b=4Ss4/rWzY96UCKrbZKEO9TWyzBEZVR3JEo9THOJ2B+ddst2mM2HjGinqtNmpskQh2M
         mpZ7b+0dYEJ0WP278ucTFjONGqzmm65Eq3QPMubPK7YxZDrNBdMK5P5VxneJ38pCyB9v
         +UvItHM4acIuG4bFG5qeHUhuUp0uIAooEFJJnkzPcnBENYFz3neYOvwq8+qemWvG9KHv
         GQJ5GqyDsLI2pGixeOvApVNUAjjX/CXMNRdSvmYoaEw3ns2JzEqHgPEYPM9bwcdYJ652
         bMYpkh2lVpPHMW4dYJNU++Y/D0s1RGcrLbsmI9cCnyJUZdbp2CaImDHhF6YDxZZS3d7P
         4c2g==
X-Gm-Message-State: AOAM530ak7a8scMv9TlhBgsei+oEgJVZKKdMu++Bv7kCDVxuwYG+/Zt/
        N4F9q0EmwucWaQFDeI4h/5dLz/j7XNWWIk9j+lfqh3eKE9jr
X-Google-Smtp-Source: ABdhPJwciDKQal6Z8tQiBUOtqqjZ9Z10+I25ua2fg40YZSw5o6TjWWvTvcWi43d589ZwucSUE+At081HdhPPiDtRhfgxGm6Iv0ds
MIME-Version: 1.0
X-Received: by 2002:a6b:f218:: with SMTP id q24mr17682264ioh.55.1643883911669;
 Thu, 03 Feb 2022 02:25:11 -0800 (PST)
Date:   Thu, 03 Feb 2022 02:25:11 -0800
In-Reply-To: <00000000000079a24b05d714d69f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b6eaa05d71a8c06@google.com>
Subject: Re: [syzbot] general protection fault in btf_decl_tag_resolve
From:   syzbot <syzbot+53619be9444215e785ed@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit b5ea834dde6b6e7f75e51d5f66dac8cd7c97b5ef
Author: Yonghong Song <yhs@fb.com>
Date:   Tue Sep 14 22:30:15 2021 +0000

    bpf: Support for new btf kind BTF_KIND_TAG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12183484700000
start commit:   b7892f7d5cb2 tools: Ignore errors from `which' when search..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11183484700000
console output: https://syzkaller.appspot.com/x/log.txt?x=16183484700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5044676c290190f2
dashboard link: https://syzkaller.appspot.com/bug?extid=53619be9444215e785ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16454914700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ceb884700000

Reported-by: syzbot+53619be9444215e785ed@syzkaller.appspotmail.com
Fixes: b5ea834dde6b ("bpf: Support for new btf kind BTF_KIND_TAG")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
