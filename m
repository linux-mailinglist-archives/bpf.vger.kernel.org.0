Return-Path: <bpf+bounces-2608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12030730BA9
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 01:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0B428144B
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BD3168BE;
	Wed, 14 Jun 2023 23:41:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D28156FB
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 23:41:29 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7741BDB
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 16:41:28 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so876595539f.1
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 16:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686786088; x=1689378088;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFtV4cQuNDH9Gt0RVe/wpR64rx6fAfMaazIbTuOUSMc=;
        b=K9jFaSJbgObTau8cMVgzNTZ1+8BwC9CSNM2o8nFSVAzT69SBc8Bxg/xjKp2zG/pf9U
         vQzj2cZ8ghPdjfr9hAaG9ziB646HorA4iJuMfKf9d5PYLqk4bQhBVE4cNJONn5V5EBt6
         inroLCb4B5bXB4rHqlOq8/iOnYvE2/lwNc0y8kZg7EPKauWtk4UI3ETjffhYRL0QfKyh
         KQS4HXWJ3yRl7xpUZYmVCVcNtqAPjjJSR9MwAVIpor8BRIJdnLtoW4yJm/YNXVjqFTAa
         7MCEw1ZIssfWngbCWxSOcsQPJgcXWupbD3g1IbibAcv+LN+PRYD65Sw7GD9UYW3ovtlu
         ayEw==
X-Gm-Message-State: AC+VfDyhY1sH+QeXHibDMK2NXcEgPeVNocZz5W5enm9z3IYD9JTKpu0G
	jLX25ZQLJ5g0cAvKU+EqY/qRqgtv4DKb+LGAg4cjWhnIV0E6UbM=
X-Google-Smtp-Source: ACHHUZ5R8Upobb3nECqWppkB7qfYRqhRYjMPYVdGioYN5rCnpienfmVURjPO7S3pJ0WrfkIgeIKNr8qml+QDD04Ke4DPOfsWY7V1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:2305:0:b0:423:1273:ae33 with SMTP id
 u5-20020a022305000000b004231273ae33mr286508jau.1.1686786088089; Wed, 14 Jun
 2023 16:41:28 -0700 (PDT)
Date: Wed, 14 Jun 2023 16:41:28 -0700
In-Reply-To: <1665043.1686763322@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097c36305fe1f7dc9@google.com>
Subject: Re: [syzbot] [net?] WARNING in unreserve_psock
From: syzbot <syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com

Tested on:

commit:         fa0e21fa rtnetlink: extend RTEXT_FILTER_SKIP_STATS to ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=17677753280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=dd1339599f1840e4cc65
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1299c5e7280000

Note: testing is done by a robot and is best-effort only.

