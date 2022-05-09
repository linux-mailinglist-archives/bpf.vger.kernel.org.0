Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35646520725
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 23:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiEIV6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 17:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiEIV4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 17:56:30 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB8B2D3F5C
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 14:50:10 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k14-20020a0566022a4e00b0065ae0c238aeso4069593iov.1
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 14:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s2rmpyNyFEujAf+EJYBoIEjX5MtLaffn8+X0o9N5fgE=;
        b=2+N7ptOjJhzuga3oyytQNEJRjyZu73FeF1KpCDvmpQUvOMYCon8J2En7CS9ECXMs2r
         xMb8BYzAUUh5IKpjuM+Fn/1FXHGbSrd7yPeXmA89SIDQnzHKNspThKtyDjI8GJUT5bcG
         nOxE+mpqTJ3UvHgMkwBOuhvn3Mg6LtUqHuzbtpAqxCeT4cLSGDDNM1T18WgSu9OqtQIb
         dKR66njCBC1SthH+lxFgumtHebS9edSLCBODNKi8K8gWgL05VoMHZbn7910qrZmAi9qK
         7IpxBylvoh1fvo8s4ql2NKuIe5zV4QcxbjMdvA/C6NNskna1Y3UB9wL0ra0RIem4kNbz
         GvWQ==
X-Gm-Message-State: AOAM530hx3WXC/H2BrsK7zwiZ9pdzLItoBMvxBVVRJw6/Tpuin2u/yO0
        Pa9ZuYMDquc1xN+zeBUlSvchNK3hNweQFIBxVhelv2TZ13YX
X-Google-Smtp-Source: ABdhPJwBVtl04Ej8XUy6iLjBCkDUNPExpqGoo3a5jGV8ypU3eIqqfYkoQPwIMtXgmETBrBFu7BHvBe/1eA2T9oXxg64g8WR0pnz3
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:2cf:21fa:cce6 with SMTP id
 d11-20020a056e02214b00b002cf21facce6mr7280704ilv.160.1652133010262; Mon, 09
 May 2022 14:50:10 -0700 (PDT)
Date:   Mon, 09 May 2022 14:50:10 -0700
In-Reply-To: <00000000000029572505de968021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032d06e05de9b3136@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in bio_poll
From:   syzbot <syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, axboe@kernel.dk,
        bpf@vger.kernel.org, daniel@iogearbox.net, hch@lst.de,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit 0f38d76646157357fcfa02f50575ea044830c494
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Oct 12 10:40:45 2021 +0000

    blk-mq: cleanup blk_mq_submit_bio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12506f7ef00000
start commit:   c5eb0a61238d Linux 5.18-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11506f7ef00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16506f7ef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78013caa620443d6
dashboard link: https://syzkaller.appspot.com/bug?extid=99938118dfd9e1b0741a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484cbc1f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c7026cf00000

Reported-by: syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com
Fixes: 0f38d7664615 ("blk-mq: cleanup blk_mq_submit_bio")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
