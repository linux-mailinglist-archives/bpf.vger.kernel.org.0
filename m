Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF38C65285C
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLTVZT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 16:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLTVZS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 16:25:18 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D1F7F
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:25:16 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id n8-20020a6b4108000000b006de520dc5c9so6099353ioa.19
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UD6Zy4iu8tJTphAuN9O8d9oBYve9cvkhVc0zvhCPlww=;
        b=s0Hy2lNrmBZ07YPfZYWRMQ53Wq6iklxDFmPe5VNJOZlI/BK8cZH6LuPJlFetfWYx55
         XwwJ3rI+8YLU75/ucr58QP07WlDTcqgsMPmf+HWLePQcVMF8NTr8Ys3TqtS2dDfApfo2
         XpyubsAYTvLDEAJ5H3rLY4x7rTx0g+LGWspbyJmra1wtOzgFjnGxHZD7ey6RRd1rxINp
         9MCtMj4cKd0A/O4deb2LfzzVSUtZxtOCu9bd0uTOIwHAtmbpW8Cg7t29X80SURWRUmeN
         CBNWx1XHMX7+BGU/B45H6jHwaGS0744kqOkk+ye03EFnAIrsToPaHPJeh4fDTBbC+XXd
         AnYA==
X-Gm-Message-State: ANoB5pkjbA94EsZHL/YOXOxiLiEqiJAqyBOIsb2XXte0fyb3xTg7VL8n
        F4wdUeC1ESQlLwDyUHv38Hu1GXtpWrva/VMYSiVJ/AbZ4mh+
X-Google-Smtp-Source: AA0mqf4GYPskeXTHmeqVVKmTdLDyfnwWmHssjiT+rtQaHjlaS49X1/u1dvqiy/J/t6I74y0GZbcSJeNmoUf7WzK7aWO6RDQg0lFB
MIME-Version: 1.0
X-Received: by 2002:a92:c84d:0:b0:302:eed9:c605 with SMTP id
 b13-20020a92c84d000000b00302eed9c605mr34795062ilq.49.1671571515572; Tue, 20
 Dec 2022 13:25:15 -0800 (PST)
Date:   Tue, 20 Dec 2022 13:25:15 -0800
In-Reply-To: <Y6Iipad5vz55tl2A@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000670c3f05f049126c@google.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b1e1f7feb407b56d0355@syzkaller.appspotmail.com

Tested on:

commit:         e45fb347 Add linux-next specific files for 20221220
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13c134d7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9445b3c551452920
dashboard link: https://syzkaller.appspot.com/bug?extid=b1e1f7feb407b56d0355
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118c1408480000

Note: testing is done by a robot and is best-effort only.
