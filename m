Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8A265157F
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 23:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiLSWYT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 17:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLSWYS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 17:24:18 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523162DF8
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 14:24:17 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l16-20020a056e02067000b0030325bbd570so7333415ilt.0
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 14:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76mJq/l4HZlpTiL5oLX0kKwVOqHktPVtqBnvtIS30Wc=;
        b=LB71c70AOQNfo7W+fyQWE9HdzIAl7PiAk8mMwXL6EufsnXu/3EqfBBOVWhCWF0sHzq
         mZKHSbiqK+PKcM5Dxse8ewosX5zapKvYxf5WRvs/YcQkqo+gllYpafFOyChuUafWBtNI
         2ez8uCqFTzNaHNRYQ/s+nzt+b++o0MvujkeC24yeFkK8F9UkfV6fdZ9jDWChOear+Tka
         +67eZ3bPQB0TO2zX4xWL6YLFUeQB34D5Pcw8zzcj8J3ee4PreWLVksXi/GVfmtac7tlv
         Eu4JAiAIBqdCKIYFa4ttKcOQWVxBY2K9bUoZytm5SATjlhulL6Ls8NcOl0SbMZBBV5xG
         rdIQ==
X-Gm-Message-State: ANoB5plHevjWap0aUioNou7XkYCErDEvfrubpL+kgex6xVXqqe5AhdvQ
        pzyur1DUwkzHXC+sDoGvc4X3nAeAWCtnhOjSlI8gafvvZfvh
X-Google-Smtp-Source: AA0mqf5koWrdgDmYUjh4xKAo1ta9oaVFjF3Be9Dw1NrhXCgSKhjJG/4FuFiOWekR09ThaBrobDJVV94M5L5993+HxdV02lC9kQwo
MIME-Version: 1.0
X-Received: by 2002:a05:6602:42c2:b0:6e0:117f:f0a7 with SMTP id
 ce2-20020a05660242c200b006e0117ff0a7mr9222393iob.127.1671488656681; Mon, 19
 Dec 2022 14:24:16 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:24:16 -0800
In-Reply-To: <Y6DYsN+G3mdKP/Bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0afac05f035c7a0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sdf@google.com,
        syzkaller-bugs@googlegroups.com
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
checking file kernel/events/core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1451cef0480000

