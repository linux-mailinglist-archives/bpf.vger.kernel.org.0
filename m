Return-Path: <bpf+bounces-2566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509F72F11A
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 02:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C272812EC
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49946382;
	Wed, 14 Jun 2023 00:43:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D07F
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 00:43:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8219A5
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 17:43:31 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-777acdd242eso808631539f.1
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 17:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686703411; x=1689295411;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2l3o9X4DUl6CHYQ2eJ/wgVXYrcJVZyyGP64Bx5hzSFo=;
        b=QDV0yKzYW9GWuKaF7irFMhwvOBSD/Uhemj2BNrFA4iON3gC/bg1k3eKPJjJwb8Ig9k
         BhobxykYAcueWztlMC9EiekKpK0/q8Y6y4BEVQ5TmBAcmDoWbmqy6vzMgcs4AEeGkxvM
         wj06j5vTf1Ynt8RcUEvtPj51Hxndmv6zXQInkUKYor31B2qjeKNNgNT5mv1u1tRJZpeM
         36DyzT9baEBN7IXpj1o4ji2Jw45maMqiKexSCN1b6s1vhBQZzfNljGDz02+fjhowWKh7
         ianZFMhW/4THzM+bB1EBF/97ydgG0bp93HY5xN8IKnrbf9yEFoMl16WdkJQgYnHtzzcB
         nIDQ==
X-Gm-Message-State: AC+VfDxiUa585gNmMnXHt5YWoRQDEB5zkEeeFr0KqM6vdTC7Gvm43Psx
	aslKzoQQo/F2pI96kwBGxuS1qscfIKoM1p7CmHu/tgxOQ8zN0Y8=
X-Google-Smtp-Source: ACHHUZ7pQAFqGo+YXYn4Pp7UOHTIW0tLIJtZrgi4ompHLJQyjZVznMQSZHBldmo6gwCfDTX3d3k+ot9FDhCnEBBrs5htpNrxlKk2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8a18:0:b0:774:8f36:bb8e with SMTP id
 w24-20020a5d8a18000000b007748f36bb8emr5930497iod.2.1686703410910; Tue, 13 Jun
 2023 17:43:30 -0700 (PDT)
Date: Tue, 13 Jun 2023 17:43:30 -0700
In-Reply-To: <000000000000342a9105fe052726@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a61ffe05fe0c3d08@google.com>
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

syzbot has bisected this issue to:

commit c31a25e1db486f36a0ffe3c849b0a82cda3db7db
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jun 9 10:02:21 2023 +0000

    kcm: Send multiple frags in one sendmsg()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13050c75280000
start commit:   c29e012eae29 selftests: forwarding: Fix layer 2 miss test ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10850c75280000
console output: https://syzkaller.appspot.com/x/log.txt?x=17050c75280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=dd1339599f1840e4cc65
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170f2663280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f1c5e7280000

Reported-by: syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com
Fixes: c31a25e1db48 ("kcm: Send multiple frags in one sendmsg()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

