Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E2652793
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 21:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiLTULX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 15:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiLTULV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 15:11:21 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E631ADA1
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 12:11:20 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h9-20020a92c269000000b00303494c4f3eso8908637ild.15
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 12:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTGxOoFEAUghGzFyM7fPV9A+UgVOuiHkhe1LVr5m9JQ=;
        b=SlhvScx5cY2Rn6ICgt9Dxz7Q+dD+jHeX2wY+amK+MaIl66MlAljGiElVDBYJ0iVj+5
         yQspsjO+QWl4R8OalHcM9PMTdPmLh+y2t5msT7uzBfChLLOBheJqcszXeHnYe5biPpZ2
         5yoCSuWFDzBiDPKCLjeO9ADfTKtQo+NoXfOu32r6r4gPmZy02qTJE0fT+f4v6XZMAqCE
         M/6uoxI4FoqnYbscrLhWRVh/QMqDOzoj6lYWdDOiRecg7denjQiXNKVzxdhtxag2y8AQ
         KApfFuRoxZJ4V8MfNPKOMmnd5R1Ld4d3g6akc6OcHtcOvUDJweEBEd8b4NC7nFt/AkMb
         bunQ==
X-Gm-Message-State: ANoB5pkGVDrcHO6mCceI9o9pWkE46Q8vd9XyBinQtRyrCjvYZMZ69xQq
        0kn609QqKut69/lr1qyqC4Ud/FJBF3U4LO3ywqLL17j1WDt2
X-Google-Smtp-Source: AA0mqf4i0Ckoew9uRuzELYUyCfvzuZI01Rm6xGBgj3U1BT1umfj764r5idt8+EJldNILxx7aK3iV5V6C6nNs2kJxxd1hLESgZGKn
MIME-Version: 1.0
X-Received: by 2002:a5e:870c:0:b0:6e2:cf0a:4f02 with SMTP id
 y12-20020a5e870c000000b006e2cf0a4f02mr4185685ioj.167.1671567080024; Tue, 20
 Dec 2022 12:11:20 -0800 (PST)
Date:   Tue, 20 Dec 2022 12:11:20 -0800
In-Reply-To: <Y6ITdVe2DPTioPvc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005f23a05f0480a43@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in copy_array
From:   syzbot <syzbot+b1e1f7feb407b56d0355@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/kasan/kasan_test.c
Hunk #1 FAILED at 783.
1 out of 1 hunk FAILED
checking file mm/slab_common.c
Hunk #1 succeeded at 1335 (offset 2 lines).
Hunk #2 succeeded at 1407 (offset 2 lines).
Hunk #3 succeeded at 1415 with fuzz 1 (offset -12 lines).
Hunk #4 succeeded at 1435 (offset -12 lines).



Tested on:

commit:         c35bd4e4 Add linux-next specific files for 20221124
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=b1e1f7feb407b56d0355
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17af7bf0480000

