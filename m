Return-Path: <bpf+bounces-35153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2766938023
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8B8B21837
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E25821A;
	Sat, 20 Jul 2024 09:15:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0074F1F8
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721466905; cv=none; b=Yct4vuJkg9ES3gm8vlGajCnCd0nclaCBGLzbDDsC4XGcK9l7MvF3jetCqwxqxySuK0+mmr908a6Lywo2+oRGVIpv6DUgU074cJW7Y0QvglojbhYwcYRke8SK5cFcwKPKc1Pnak5PQDIQ2D8SXz47tz5PRpV/M9tF7Z1P9Dn0dU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721466905; c=relaxed/simple;
	bh=ODLI+X9xS97FO4XT1UaElBARAbVdOL/w5b1NhR6HgOA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c1dryjmW0CkT2g22sMGkXM1MzPqhiWxOZ0EiInYaAKUXokpHyzKWFJbjT/nuQoLfi9ZWBtFR7ap4wqJZ8wH1mfAmQVm1NNQa81vjmR0Npcd5ADyoXgyHzeGHDUgPjfoDYEgqHM1duhPGIqkIbYvmRZ9aMEJj8lf51HqP11CBCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7fc9fc043eeso410977739f.3
        for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 02:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721466903; x=1722071703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/xW/bfcnBDYLDu6G0bKJTsPYwdeU3e7DSeAVPwwSKE=;
        b=oxrs9hIxNUUPHx9wZRkzPDu8LfFzx+buxdt/p/aK7+97IRFcRQ8w0eVwmD42JYUoF7
         bGWdbbZGhlHBINMvtS661eJAOsVX3GKuqQ0xxWFW5ulImEybAyIsJK+hnXv1ecj2vdY1
         0ToOVMk9kSLmtEpYO66Nh5eBeei3qyB313xZ422SMkXCYXjR2OC6O96yAfq7oDFKKO/e
         umuBcotUFPahFKFfGWgo1aSuO4Ds8HvHJEw8wBhXYgDPD4BX8zIxEebA4/RMA9fO9dR5
         wVCDr7z5Y52jgAvaa4g4UEIcC4YLrYUaKMciKLGif5fg0sTLJRAYFgqhqohRcHwelbwS
         5oEw==
X-Forwarded-Encrypted: i=1; AJvYcCUKqZIQOn9BN6QzEuaHa5btZg5oo0QK2aqZPf8ZFAp6rOwuVJVpG+Z8a4BtuX4JgINX6PM2ZFY/eg3FoO5/fhHK02pt
X-Gm-Message-State: AOJu0YyjpxqFMq2DMSlC2InMcxt4SsilvsuHK3+0v75Za9gWJLZvUkqj
	iOi4IXsVxU2AJaGE33F/xkcgtVceF9h35veSGKm34sfontwPFKpszAfRZ5PCoZb+0VgvC3m9ZV+
	199z2bkDKpNyP2437aepN2OMtTVjLTE3/hZq4mVTVE6f66yf8tVJP3N4=
X-Google-Smtp-Source: AGHT+IE/QzbDjURoyGylAbqTzkWRv3Z1WWdorDeizpZ2ulTCu+E5V2jt9Lj2vHun3OTt+jKz10+fNjIh2OqQhl0Y58S8XH5KA8L+
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2114:b0:4c0:9380:a260 with SMTP id
 8926c6da1cb9f-4c23ff457dbmr83224173.3.1721466903216; Sat, 20 Jul 2024
 02:15:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 02:15:03 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004257c7061daa3f20@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, hawk@kernel.org, 
	jasowang@redhat.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit fecef4cd42c689a200bdd39e6fffa71475904bc1
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Jul 4 14:48:15 2024 +0000

    tun: Assign missing bpf_net_context.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ddc995980000
start commit:   720261cfc732 Merge tag 'bcachefs-2024-07-18.2' of https://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ddc995980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ddc995980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ca6cd6f392cb76
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1791eb49980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118cf7a5980000

Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

