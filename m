Return-Path: <bpf+bounces-76678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B25CC0BFD
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 04:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C6F73006E08
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A32C11C5;
	Tue, 16 Dec 2025 03:49:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675921E0BB
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765856947; cv=none; b=QRxuLFMDgiGJBRW4I/iJocpSOq5fCrfXU9fKhrcnxA6ZNU+LEb52p3OE09y6dM8Q1Iluqy3DbS+PqrMuvlRmdexU2kurckC4/p98SqUzaKwOABK4dhhGU41F08gIEb/RA7SJwany0r1+RiMT5nl/bkoDL9ePrx4jEX3GRrPHXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765856947; c=relaxed/simple;
	bh=Unutd6wCkiNh4RacUyjP326EvR/Ys1jEQu6+sKGiWAg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZP6xNVpG77/68xIKX5ZEOXIPg1Z+g5sXFFJlpaGodr/4eAgCIKtv22zcahxgWEJGpK6m52qXfOI4FjakF66DDc7CA+XcTGFJFcO4HeAtfHE1tbVNq2uvWKTPjlDnOxbFfXr74aF6zIxGOH8mWaXR54OlQ0SKUUzAEuRbZjw6AuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c79200d1a4so7499226a34.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 19:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765856943; x=1766461743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA7NZRyjwv7hEiqYjxI52dnHRVbVd/ftI8bUbW0TUwQ=;
        b=ozDLZpALB1TLtAQRXmmHzNoISVMwG6U2T4wSM5JPfrH+4BwOJmeHUU82ohXYNEPijr
         FXmon2JZHN2WxHiIRTh/U893F2cbWfdMOpTrg5N2+XY4UxQDsP4vkArB1E6kuhtn1Byk
         yS6ZVQY3c9A7DuWlPFtpaq2nQ97F5hFwFbHl1VTft1s4tdeW2WXVxgPgnGih8n7ExdVD
         p4ZOHJTL6dFa2onvy1ZHgH2fCREYpYMYPe4ICJZLCR6FXoYLcD+Qp1P4Jk6Smj/l7Y3l
         iYaaALIFrefq09+ifNw6gGg8p6q+clZaHLDHCadjp08f/tefAgUIpUOff0abG/0BNo0i
         IAmg==
X-Forwarded-Encrypted: i=1; AJvYcCW7B1XdsGn4l++y0zOrwF8wi81reWZZUWajX6N9+9+YKGwwhzX1NX3ldvFbnt6+4//fg2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0MWhcsu4IFcqLR7/qBzkjQgdIRymRn/UyezFI20mTftiA+ny
	eDRzHUOYXtyVSKF9d7U8fznJpvD08yQNCvrKy0qUPuzYXpH9tcGluvnXwa/8UqikLbItOSFp4ge
	9Hx37l2giwl4ph118wbi9o0zi6KOSer/lntrsQa0EWg18mQs8NnVUM2twyVU=
X-Google-Smtp-Source: AGHT+IFa3E9j4szhRq4TjaO4AExrxT/b7DDledAz5tQ3PDW6L+l1D/C6ucPqDcs4X3BVKRZBrKXJtp55A0s0736sTiygqQP1UvT6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178e:b0:659:a130:dfdf with SMTP id
 006d021491bc7-65b37e856a8mr7438243eaf.8.1765856943606; Mon, 15 Dec 2025
 19:49:03 -0800 (PST)
Date: Mon, 15 Dec 2025 19:49:03 -0800
In-Reply-To: <20251216031018.1615363-1-donglaipang@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6940d6af.a70a0220.33cd7b.0130.GAE@google.com>
Subject: Re: [syzbot] [net?] [bpf?] general protection fault in
 bq_flush_to_queue (2)
From: syzbot <syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, donglaipang@126.com, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
Tested-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com

Tested on:

commit:         8f0b4cce Linux 6.19-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137ab91a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412fc3ec22077a03
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3391f44313b3983e91
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10be172c580000

Note: testing is done by a robot and is best-effort only.

