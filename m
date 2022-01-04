Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1744849DD
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 22:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiADVaJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 16:30:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46723 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiADVaI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 16:30:08 -0500
Received: by mail-io1-f72.google.com with SMTP id e2-20020a6bb502000000b00601c16cb405so20859391iof.13
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 13:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e6I0sXk0inEAmUtslAEVQcGILPxuytb3N8HHWOakOdw=;
        b=71kCAqwHX8DzrsUjBgqOuo6olJOpPrHZeaoz+UENlnqHRXLUe2MZngdVOeiOFIQXkG
         bWLnZcekrxRJwsZjBK8UXsR7gKRPiGOQ/eYIuKgWc1Al9H0zGLMvVRLe73UEFlJD7woM
         YwM42Z/bypKJaOsF0ii8uXxNAgSSEJ8E4qFqnFAc0A/FnlDM5yAmQ0TLYAzHPh2WIwIV
         h260KygShAF5U3c4FOK2u5erpDrA3esyrct/m+jASLOVKiJrtcMFPgQ61WivHNHktT0f
         nZ8cELn1upH4DwIf7cweC6iTpW0CoedQBE/JLKtZg1caXvHBbuXWtB6XPOP5MBSubD61
         97CQ==
X-Gm-Message-State: AOAM531tOsd6igptxyf2K56zuc2Ifb3aPThV2x5Z54/8j5ejGc+BwrO+
        qdP5oxytUYScDw+dhqkqr4WpxMfXq7bLYjU0YxISaA3bzMaI
X-Google-Smtp-Source: ABdhPJxHxHS62rmxnySIB7LL5Hkxm0+ir1wzDfJwCxZ28ZsFukFgZ860i+kkpdeJ7KV3ozFNrZMdmc6jxoOkzia9Rlykuj55yTwN
MIME-Version: 1.0
X-Received: by 2002:a02:b603:: with SMTP id h3mr24957080jam.233.1641331808274;
 Tue, 04 Jan 2022 13:30:08 -0800 (PST)
Date:   Tue, 04 Jan 2022 13:30:08 -0800
In-Reply-To: <61d4b9354cf9b_4679220874@john.notmuch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064109905d4c8577b@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in bpf_prog_put
From:   syzbot <syzbot+bb73e71cf4b8fd376a4f@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        lmb@cloudflare.com, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bb73e71cf4b8fd376a4f@syzkaller.appspotmail.com

Tested on:

commit:         e63a0234 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=29c60dfdc879c48e
dashboard link: https://syzkaller.appspot.com/bug?extid=bb73e71cf4b8fd376a4f
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c1d0adb00000

Note: testing is done by a robot and is best-effort only.
