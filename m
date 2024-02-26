Return-Path: <bpf+bounces-22741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E07868353
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 22:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536281C25E33
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 21:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA2131E44;
	Mon, 26 Feb 2024 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqB74OTx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FEA13173B;
	Mon, 26 Feb 2024 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984160; cv=none; b=fcZMh+wN0Vawd5o8vVt8WPWbF+UIF+SP6Cr/4pKJp2/RxETZeFTqO5NagAnJ1Tcp2nbt/kUG1et5ZkyRPq5h33YygrX+Ou99bq4SbUc6ld/aZgiY72mKsphakehs53wgnp9Mrmw+9CO5GVSbmLa6O2jdzP66IXnituXjyMWULAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984160; c=relaxed/simple;
	bh=xxNT92wHxxTAF343Ur3NkxIivonccbypJ8Cd9wEfuUM=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sPYzp0XNewO3/B7QOpdHNH8hipFBuhG6HbxS3pz1ytppVpZjCbfwZSYOGgb2IVJ0EjEfsOHDWi6l7g0sjfhKWv5xBcoj4ml9sHaPELEm+ZScv6s5wectmJsLRRQBeBi3+f6jRgonzg8QbwV87ImlwekJMdXwd88ufpgI6GtzIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqB74OTx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so16606145ad.1;
        Mon, 26 Feb 2024 13:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708984158; x=1709588958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMKd9+17BOHgFCqJAjklcy+fs0vsFDPhHNPoIQN+MOo=;
        b=jqB74OTxM1Nealj9b3w3HGNkXGQNg1xfq2NFhNrkX05qE6SSqPgaK9jQpENrZO54lV
         3JZgNkMyDypoflGhPHp4J2g21iF7Kwd1ov43EuaE1SpCKYKv9WG9hyi9+KbYaF7JIZ8E
         q+WZrOApp3bZokz7HnuOzx76KpGkNpFip/wZhs7ISLmoaMVBxRy08XSr2anfITsmF6H3
         HzYPlFHBG5RrNfeeOX1jjkf06GN3/eh6/CSZMZijkHVG8KL2hg3tsgqcPMMwt9+Nv1W6
         eaP/frHN6iQJOBWrYe519dlrUOj34EEqsf4ym4sUUH3tPVvJwoEBleU8+cbMqBGD402O
         gfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984158; x=1709588958;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMKd9+17BOHgFCqJAjklcy+fs0vsFDPhHNPoIQN+MOo=;
        b=SfXGjUoDfzpen78tICWjmFFHyxXOxKnHhAGuzYQZlEus9sQjRFnnmNJaNVglwARkC8
         tMl468H7GURWi1jjeSUSj2Ms7TuxCCKs66Ll8eJjAtWHG3hi7sdU/z63kO2kZK/87ppr
         BglsVD8MPosbCDnxqKX14kLJHGNDCFWg+tjCeKDcxqxtaUEJDjV4tVBLtlouZbuhyDni
         lHKfsu8Wq369XyQ1J7FaoZDGXgj6GIKkVAdoq8I2Hyqw7bd7w7pJCW0n/bjtRXDp2W44
         WDKmnrWLyvF12s0V/2iINq3oSRf9TevJLm22e3LHYMqaOXXX2LVST5S1JJYWFDsh0qNd
         U+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCU19oMivmAw8yrCzkmdIMLyVycWJc+vFcjW15DLo2KPFQqtxrTU6bwQGsUzNTRJI1a2RP/vdceWHRWlFrYW0uR+UGFtUHZGbElAX3k05PyTY89yOkboPzfRChTRn1FuYcRq9onqEgJXeiv4YKn8aZjziGnSnywG0D8k
X-Gm-Message-State: AOJu0YzsCj5yKB8jh/hUmXlU6eq6qTp1N5uCyGlY4nJNJI/SUuhzr58j
	zhacnI/SQ5rW1gW17vgc6m5puxX7hu5aLNUOXrwjssHKzzKV7rN7
X-Google-Smtp-Source: AGHT+IHKGlYbPWjr9qm/ZY+QN4AiZsr/p8apNkvY5o73JWDZ/VvT3yqY4AhsDiSOFU9kl+41votkBA==
X-Received: by 2002:a17:902:ec8b:b0:1dc:11f:d946 with SMTP id x11-20020a170902ec8b00b001dc011fd946mr9687389plg.8.1708984157528;
        Mon, 26 Feb 2024 13:49:17 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902ed0100b001db717ed294sm149725pld.120.2024.02.26.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:49:16 -0800 (PST)
Date: Mon, 26 Feb 2024 13:49:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: syzbot <syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com>, 
 andrii@kernel.org, 
 ast@kernel.org, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 haoluo@google.com, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 jolsa@kernel.org, 
 kpsingh@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 martin.lau@linux.dev, 
 netdev@vger.kernel.org, 
 sdf@google.com, 
 song@kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 yonghong.song@linux.dev
Message-ID: <65dd075bc6cbd_20e0a20892@john.notmuch>
In-Reply-To: <0000000000001d1939061240cbd7@google.com>
References: <000000000000ed666a0611af6818@google.com>
 <0000000000001d1939061240cbd7@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in dev_map_hash_update_elem
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    70ff1fe626a1 Merge tag 'docs-6.8-fixes3' of git://git.lwn...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1762045c180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4cf52b43f46d820d
> dashboard link: https://syzkaller.appspot.com/bug?extid=8cd36f6b65f3cafd400a
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110cf122180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142f6d8c180000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-70ff1fe6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bc398db9fd8c/vmlinux-70ff1fe6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6d3f8b72a671/zImage-70ff1fe6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
> 

I'll take a look this week if no one beats me to it. Looks like there is
a reproducer so should be able to sort it out.

