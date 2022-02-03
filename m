Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D784A8F88
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 22:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353285AbiBCVGK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 16:06:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:47770 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351439AbiBCVGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 16:06:09 -0500
Received: by mail-io1-f71.google.com with SMTP id 193-20020a6b01ca000000b00612778c712aso2821456iob.14
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 13:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uBmyzhLL0AacmJiOO0ygo8pOFo4TfHCiGIA5EQdvXeE=;
        b=Xf+qhGTa00Xwel7Jp2nStn/VVcMBttNRXxiGXAIzoh0j4WP1SJDbNOtORBiT28pAIj
         hT0yHRLZ99Tx/OkXYuRSmdkLOk1GWnTjfeFn2VoOnmwTPkpn2Ci7357ld5Mgg6N14IQO
         NFXImG2S1i5VmzS+mvJAkYB7R62EYxybd23uVRmTzWouZILpnP2oyUpVPN8jXC6NN3lY
         ypP9aCUjVkVPijdyX3OTtfXr583IDsKiR8cvvLPtc4BeB4e17gTAnlxyzlSbVa0jTYvu
         rYjrqzi+YJvgW9NEb0C+xYvlMQ3rjXnZqvh0WI6s8lToJODNhYVQQ5ViWCBOE6G7Z59h
         Aj1w==
X-Gm-Message-State: AOAM533E+kNvYTQhJn/14R7yn2CzqSz0E28COX5CUDOJPY5o88HBHHGc
        p5P+q5ZhsGOE42Pc1qzPn5lfdATXeaanFaDRs1cgP0txTWFd
X-Google-Smtp-Source: ABdhPJz7/ZbgejMhaE9OEyjG/6HURwiA2GryVh/9fg+CbYb99M8adUZngW39faXgneuMNTyLw+8Sk7QFCH8alyCPJh/ctQrEX+6V
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3295:: with SMTP id f21mr16186925jav.193.1643922369206;
 Thu, 03 Feb 2022 13:06:09 -0800 (PST)
Date:   Thu, 03 Feb 2022 13:06:09 -0800
In-Reply-To: <0000000000008c32e305d6d8e802@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dade8505d72380c9@google.com>
Subject: Re: [syzbot] general protection fault in submit_bio_checks
From:   syzbot <syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, axboe@kernel.dk,
        bpf@vger.kernel.org, daniel@iogearbox.net, hch@lst.de,
        john.fastabend@gmail.com, kafai@fb.com, kch@nvidia.com,
        kpsingh@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit a7c50c940477bae89fb2b4f51bd969a2d95d7512
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jan 24 09:11:07 2022 +0000

    block: pass a block_device and opf to bio_reset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b4f1cc700000
start commit:   2d3d8c7643a5 Add linux-next specific files for 20220203
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b4f1cc700000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b4f1cc700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27a9abf2c11167c7
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3f18414c37b42dcc94
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14635480700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eb2d14700000

Reported-by: syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com
Fixes: a7c50c940477 ("block: pass a block_device and opf to bio_reset")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
