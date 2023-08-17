Return-Path: <bpf+bounces-7959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46077EFC8
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 06:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB021C2127C
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 04:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E17A34;
	Thu, 17 Aug 2023 04:19:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B007FE
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 04:19:44 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9C2D5D
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 21:19:42 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26d1f0d9b3fso257407a91.1
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 21:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692245982; x=1692850782;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5174e1lhoEtAOJSx6OzZg8YIf4r3sHHxcBtCy/AqYyo=;
        b=SUPODhJ61pqiAI6KfmTz3b8pZFrB1CythQ6nxqjcOaLufBHgNnWVl3yRgq0t1tmWZE
         kvpBSnN68Gzdmt5F0iQvWZkfCCYje1xPJHPsHWnQccyATL6SAvQbBYx+hw/pgd32t0bT
         AIZRyLgn9QRFZAJStvTgZSJQZ745o4ZhXeSLXbXbV1JTeri1NRN0b+bFyilIYtv4+poU
         +uFVKaeQaC66zheDfQDqNnm8303k7JEiGdNccPCroG6afcNaC3hpiztA+lS6JJrh11c+
         AZerQxFRIQgDvCFT2k9ZVpLEGDc6WVM68wuqFuWvMYekYW5YnutgatI+eksQ+HlIO/eZ
         UcQw==
X-Gm-Message-State: AOJu0YwYCRoMQSWQXWtgwBGzG0DTGOeFJSRpG3r8jUzciPc49o7ps+oi
	yQRPpjOtEQZ2B4jY7YtSOgLq64Tz7+zCy2q1CgCzJP36F9Me
X-Google-Smtp-Source: AGHT+IEZTSdaa9kcYRvTXFZpDfiX5p9rZQWqGwpWUOdqE4TBv2CeMoaYVGf46u3LVELNCiS2dd8ME/kduWdrJuI3NqGAvxNOuL9V
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c901:b0:26b:5182:d042 with SMTP id
 v1-20020a17090ac90100b0026b5182d042mr837650pjt.2.1692245982314; Wed, 16 Aug
 2023 21:19:42 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:19:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a60932060316b8f1@google.com>
Subject: [syzbot] [net?] WARNING in dev_index_reserve
From: syzbot <syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, leonro@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 956db0a13b47df7f3d6d624394e602e8bf9b057e
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Mon Aug 14 20:56:25 2023 +0000

    net: warn about attempts to register negative ifindex

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f68f03a80000
start commit:   950fe35831af Merge branch 'ipv6-expired-routes'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140e8f03a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=100e8f03a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=5ba06978f34abb058571
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be0117a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14950727a80000

Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
Fixes: 956db0a13b47 ("net: warn about attempts to register negative ifindex")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

