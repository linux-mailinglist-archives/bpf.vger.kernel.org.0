Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB64A7351
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 15:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiBBOgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 09:36:10 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35483 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbiBBOgK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 09:36:10 -0500
Received: by mail-il1-f198.google.com with SMTP id h8-20020a056e021b8800b002ba614f7c5dso14238943ili.2
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 06:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Eymh4pHURRqeuFwS8adn0p8QhOCEykcqbl9dEc138NY=;
        b=Ayj79FqxVR5ueDpPxWAtJzQXIZEtCYbD2EghdJk+9rMeE+XGL8UH7uzNJuKTlWG3Jh
         M1aqOT3CY5S98KQv9WApU/ntr3UtfNCpPSymj9Dj/PnoUhvL8+f+Ktg76zYqCfo6GWQd
         AogExnlhNzDVfGmVtmfLmSN11JS1eBEK3i/2sKOMv0aBE+KkplEokbZNWbWclubkuJ1R
         HjAeh0iwwyf8TTSEwo9rbvHElonPiD/BepHM8ehtmEOOFkUsNXtZCjQv9C2GzWygDAaV
         bpWAd+iEq0UjVgKz1s3ZhYrJ8iZSLVVNx48Xll9sk4p3LBX14LXFyYGTzZg/HN9iUvRU
         8vwg==
X-Gm-Message-State: AOAM531e6imMhU+eliSMoDRo4/3MkIWXcqpjImAaS7oGOHCph/xIgtGe
        y+xlLDXtQYbszs572cZdLu60oLtR80Z8vwOLoKdMnFL3OLQ4
X-Google-Smtp-Source: ABdhPJwGogskVKanVKmmmO1deCNQWTYAR4unUVwG5nX2dggT73jsD2XxfgJcLs4y20Iwprc8IHZ1DEukzWl+iHfMi84JlWn5xHSa
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e90:: with SMTP id m16mr16733470iow.74.1643812569793;
 Wed, 02 Feb 2022 06:36:09 -0800 (PST)
Date:   Wed, 02 Feb 2022 06:36:09 -0800
In-Reply-To: <0000000000000a9b7d05d6ee565f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cc7f905d709f0f6@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in ringbuf_map_alloc
From:   syzbot <syzbot+5ad567a418794b9b5983@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andreyknvl@google.com,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, elver@google.com,
        glider@google.com, hotforest@gmail.com, houtao1@huawei.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sfr@canb.auug.org.au,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit c34cdf846c1298de1c0f7fbe04820fe96c45068c
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Wed Feb 2 01:04:27 2022 +0000

    kasan, vmalloc: unpoison VM_ALLOC pages after mapping

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128cb900700000
start commit:   6abab1b81b65 Add linux-next specific files for 20220202
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=118cb900700000
console output: https://syzkaller.appspot.com/x/log.txt?x=168cb900700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8d8750556896349
dashboard link: https://syzkaller.appspot.com/bug?extid=5ad567a418794b9b5983
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1450d9f0700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130ef35bb00000

Reported-by: syzbot+5ad567a418794b9b5983@syzkaller.appspotmail.com
Fixes: c34cdf846c12 ("kasan, vmalloc: unpoison VM_ALLOC pages after mapping")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
