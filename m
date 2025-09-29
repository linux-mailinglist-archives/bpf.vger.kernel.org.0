Return-Path: <bpf+bounces-69969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB80BAA47A
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60AD7A30EB
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB79231A30;
	Mon, 29 Sep 2025 18:23:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9C22D9ED
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170185; cv=none; b=Kg28Mwz++OQp6QaACJw5bGslesxrpc0R02fYibjp4Ij7AmR6guHjkFIHVjIj40ClEmmtXLwr4/XWcRfmOCEL49KumlMhMQHdpbc3SlpLSp7yUJZxU9vTYwAi+IcYUX2uxZ4Nx2DyihwzyHjQDA8jwBEkBsCVLu6iopX5xXa6wtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170185; c=relaxed/simple;
	bh=3KZAsrzTTWqi+8dHxXx0RD7GNMeEQiSWFagohsu82wU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nqK8wiN92ZYOnPHYnCWyKc8WNfqQDREe6bT9plnJfQS39tVwdhjz71eurhdryXYdDsosQ5ZZeQxUL2vsbqQIrU+HCILF9Ntj8Q5en4NlhXFdLoWl1NmS14ZMRFhFUcj4D/zfr7FtC2nE03zgNOUlhr0XzEC1m4BupQ4ddXXLy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4294d3057ffso34322555ab.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 11:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759170183; x=1759774983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHGfRCy971BidLIGKmXNRjtiMIrtdrzx8FQpVLEgzT8=;
        b=KtH6gejYxV07+oGgmRNLgVtXGM74+840onXIkbFdo3IcDklyQa5cqQyX586zg14bTq
         bOXXLc9q1n0TJNQPHxNN7wm4NuhwoGv7L9h9ZXpX7F0XYwVhatQSkCoD4KRhs01GBlmM
         MYOayjAAQIf+AR+Xvjq3rXaFZhYU+OfcZdVIaBrzJdW1zsceesKzct93mIlnWvA2S9Qh
         R+htsWx8fJEfwiqohcVlQW7qLl8znja2wxApXn0ill21+Zuhf2nsJzzqfUzkqWHic42A
         vYLfSJMxDZmZ/SuuwLr4WHty/rdxxyCW93/+d7gzmMy5fuygabtxzYUmMgwJB8YGm81l
         VOKg==
X-Forwarded-Encrypted: i=1; AJvYcCWkbGM7scIsEl3u2E8QuNdLrzDlJ3e+RCQBQqNH+/DqFZdwP67rXS3cw/QgbBwUxYzaghQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3y7Pz0X5cGgkkh80n0SayYVKpcCZCVl6QMA0I1b4gcnnOTJki
	vziEAd/YTr4PwRB7JFbxKR8zxmKBVczmDA6gkBa0pm08q9neMUccD4BgU54A74MJSlMLWhxqQSJ
	B2mRkMWImFsd1Rx0SkkvQgZ+Ek1i14xxBITnD8JXoJdJicJ/bONjdtr8lcaQ=
X-Google-Smtp-Source: AGHT+IEI6GWyUAY++Re/Hf+5q7A+r6rFLnMX/8VZGzS5V/xgJ4OyHU70zkpChbDOVPRp20zNQIUuDHydsiMlfe724N2/IC9up05N
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:425:8857:6e3c with SMTP id
 e9e14a558f8ab-425955f47f9mr264351775ab.11.1759170183211; Mon, 29 Sep 2025
 11:23:03 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:23:03 -0700
In-Reply-To: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dace87.050a0220.1696c6.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in print_reg_state
From: syzbot <syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kafai.wan@hotmail.com, kafai.wan@linux.dev, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, listout@listout.xyz, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit aced132599b3c8884c050218d4c48eef203678f6
Author: Song Liu <song@kernel.org>
Date:   Wed Jun 25 16:40:24 2025 +0000

    bpf: Add range tracking for BPF_NEG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13931ae2580000
start commit:   bf40f4b87761 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10531ae2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17931ae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16010942580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12caeae2580000

Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

