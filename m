Return-Path: <bpf+bounces-10708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03AA7AC7A3
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BCA371C208C7
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952AF110D;
	Sun, 24 Sep 2023 10:59:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AB63F
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 10:59:19 +0000 (UTC)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B36101
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 03:59:18 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1bf2e81ce63so9892872fac.1
        for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 03:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553157; x=1696157957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlk+O3J+o0kkp1OKytTuo5mn2nF+ogupL5uOl8zcGuA=;
        b=HwUn58wSjDUL32wjRRSS1BfLcvNuFge114NZ5q9pnBrPRk1jQmHvZifuFmhVEtHEKK
         +pgmrv7dHxwL49f20qRp7exSVT1nZGVh8xUYBf2qFB5P2dZ9IlCYt3HK5hjrzTlsJW+i
         mr/RMZIeio5CsTiCLK5vzaKw0bhY8OqB51SAm6Ek9DyoIwELzjUjA3yv+FyAjfn/Tw3V
         WUdYs9j5TSSK40PCpx7Ff3s7k6Vd50d8KQdTpTRpv4m0zjTmq9ET9TDzerE9tEE8wZIl
         H70tp3YhKcl3loufU7v6UQ7ZQCs5YHKXIot1ZfTAO7gD8PFTSOc1A+AJuGxCvfE2BZ0e
         FCIQ==
X-Gm-Message-State: AOJu0Yy8kT8VVF/zRX8tvNTYm8KnUqp9ZrRDPurw1y2JXw0PQAXH3OB8
	YHLduP9lLjEhU6RSBmcAMCTvm6bn5WoXEt7UNhK1cKsUIf0qdB8=
X-Google-Smtp-Source: AGHT+IGp8vx1D9jMEB/i7wblpIR1qbSKkkYzRnZBs6mxLXQ6LjSZuwUrXWRzpxMUsQ4CTqUu0G4qMtnatkOXoDUjowcVzPeX9afh
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9a93:b0:1d6:a9da:847 with SMTP id
 hp19-20020a0568709a9300b001d6a9da0847mr2947177oab.0.1695553157625; Sun, 24
 Sep 2023 03:59:17 -0700 (PDT)
Date: Sun, 24 Sep 2023 03:59:17 -0700
In-Reply-To: <0000000000000c439a05daa527cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a87e66060618bb7e@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in gc_worker (3)
From: syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, coreteam@netfilter.org, davem@davemloft.net, 
	dvyukov@google.com, edumazet@google.com, fw@strlen.de, gautamramk@gmail.com, 
	hdanton@sina.com, jhs@mojatatu.com, jiri@resnulli.us, kadlec@netfilter.org, 
	kuba@kernel.org, lesliemonis@gmail.com, linux-kernel@vger.kernel.org, 
	mohitbhasi1998@gmail.com, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	paulmck@kernel.org, sdp.sachin@gmail.com, syzkaller-bugs@googlegroups.com, 
	tahiliani@nitk.edu.in, tglx@linutronix.de, vsaicharan1998@gmail.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit ec97ecf1ebe485a17cd8395a5f35e6b80b57665a
Author: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
Date:   Wed Jan 22 18:22:33 2020 +0000

    net: sched: add Flow Queue PIE packet scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c5748e680000
start commit:   d4a7ce642100 igc: Fix Kernel Panic during ndo_tx_timeout c..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17c5748e680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13c5748e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1504b511a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bf931a80000

Reported-by: syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

