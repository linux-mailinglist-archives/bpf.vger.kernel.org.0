Return-Path: <bpf+bounces-54882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FCAA7534B
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 00:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B31894B16
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF4E1F5826;
	Fri, 28 Mar 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSZXgSYV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8FB1EF37E;
	Fri, 28 Mar 2025 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743204414; cv=none; b=kYlY1kxs+T+PiWFx2uiVeOp9J/IjGpgsXXS21FqVIbR5ehUarhfBrZUP0jcaFPffE16169uL5RMT4cXuXECLN/folzOFuvTNTbdOEzerl7BvB7iIOik5Ok379fs2PTT6djycfHDDz7W85/7mRBVix9vElySxFvP4Bih1Xov2w9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743204414; c=relaxed/simple;
	bh=UpbGqH8VnuEqztXT7Wqaj0S0+Ybf4L7KVUBUnd5oI7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeGdQE657MoNqZSQ5k8tByGzYdLoMF0IAMmmlKH2WHdiBEIQDwuBlkmfjGbqQqGNXvR0m92N3bJUFtPvUAzjJ4qlPfiKZm1Wz+LnbbWGNRbKsZN/TITTAx/6brZuJrtawEv9v1pLUYYnLIJ3wdXHeCYRxq+Wf11kxhISycnIGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSZXgSYV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22580c9ee0aso59554375ad.2;
        Fri, 28 Mar 2025 16:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743204412; x=1743809212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFVxM5/AFD8071zR9wcbweFP3U/YhpdYqA1RhXQbuGA=;
        b=kSZXgSYVeoCRDOFeoDsrebEf8lSyOBvmZ4IDQhY7WzhZirMPillS3ufSyLpnnjz4ls
         QhrYQNJz/iZ7r6ky11qP1CbSvjJIANkRagXpXngmxd5/SHFxfYlTg01FhXk/Cu2JSx/E
         9w2DyR7GBn49jZereHEAF7mCtEA37Q+ERLP0ufT4TjZHZ5hOrz3o7lQRD5KaGouapnNl
         3c7Y4XjU1mefab/SR9ePLUtZ8Dn8eEZyYS3NjwXWy9TPg3b6K9RqnY5kWrPROUlX/8Eq
         BDMGuM2uL4iV7yk/kr/zuk6SCQuSZn1CyUmUsJpxR0sWENFv5XWGkVmyQjPVEatEgZ3M
         s9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743204412; x=1743809212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFVxM5/AFD8071zR9wcbweFP3U/YhpdYqA1RhXQbuGA=;
        b=neLZcTujoGzdw5dH6/nFz7iA30YyuDuFLMt7dKlLEeLspsTMPBTaQdXZndLPbeYi8l
         ZmP50m560yPSKsZ29sccYi4nA9Y9t5y/kCHI1ffVL+fCW26YTVn7FDqYO6+Q+kdkeBgf
         bA8yyKbhdNUbimHAY7x9A7iPe8N+wn6lncTpfwgHarNBsD0jpNvmhrUFBASFCmehMZ7e
         TTjmq6eNlKcjFDtqthAsBwXD4sGGdfbAjKgM+l8eASP4Yy3ePa+rBSZS0w55WnvP+a5L
         b+b7dRhEvS1eNES+DmmuCvEhub73KdR7sFlFznwrTIO1kRqwj5PK5ZAzc8Mo5wngMu7M
         2L8g==
X-Forwarded-Encrypted: i=1; AJvYcCWc1IeS4w4ydaMRzVBckC5Hp4K4EiD7B17aPXHwLXY4rw5bRewL95HUM8tLImWsEVgQ/K6Uq0QAyd/Phwnl@vger.kernel.org, AJvYcCXYUSFz3UVmFq8RVCN6L6L61aa8BsK+2+rmBlBf3I3R0KxMcjXmEknkJGcKrgMt+Ru8M7920N4p@vger.kernel.org, AJvYcCXb5eY+IjSOx/knzeXk7Odv+cmY62tDV5cu7icz7wggnxee+bW3UeqnSn9fMhsj5I5/gW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2qONmWggOe/GPpQWsw6Wj3B8TFUJFB3lQ7ri7qDjVXceMeiT
	y57cmZHw9KryHPJL4SFFYIA1QZRrKyzbUVNyIr5UuKEFsVlL0zw=
X-Gm-Gg: ASbGncvGpvsbqlWKp26/hYAoR2Gbh+bVWsrrzcg1Gg8201Icc23XQpdxBeaOWw1+iup
	eQzlGMDmtqyWMdt4RYYSJ+sqhbaETfgh43iNdIcgpS3tQyG6flQ3128xNm46WBj6Uyn6QF5lvD2
	KLNpW6O1rA3htMvVmyI4THwBJF0ihX4DexnozpVb+4SeU6Js6a41hLZkOlL9xrtbhFNKaHHq3fA
	eQDgIwtoh2TcIFWQjRB95fP/AScEw7PXau0Gsam/9YKPOFDjXptK2yV+i9yqa6I/OdLLx4XVqlF
	Fn+gbUx//8dPEv4EMuITSJl2WvdIcUw/zyTqymhAexeL
X-Google-Smtp-Source: AGHT+IFoiqjkZBuLt3a/3dPYy+hCYTG4B/7HbPK6GoIi9TFX6gkfFt6D8S3aMJOFg0zxKzzM1P3+6w==
X-Received: by 2002:a17:903:1106:b0:215:b75f:a1cb with SMTP id d9443c01a7336-2292f9448a5mr15531045ad.9.1743204411609;
        Fri, 28 Mar 2025 16:26:51 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1f69desm24290395ad.253.2025.03.28.16.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 16:26:51 -0700 (PDT)
Date: Fri, 28 Mar 2025 16:26:50 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in dev_xdp_install
Message-ID: <Z-cwOkotpxeSxirT@mini-arch>
References: <67e6b3e8.050a0220.2f068f.0079.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67e6b3e8.050a0220.2f068f.0079.GAE@google.com>

On 03/28, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17989bb0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d48017cf0c2458bf
> dashboard link: https://syzkaller.appspot.com/bug?extid=08936936fe8132f91f1a
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0795c9a2c8ce/disk-1a9239bb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dfe4e652ed32/vmlinux-1a9239bb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/34deb7756b26/bzImage-1a9239bb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 8456 at ./include/net/netdev_lock.h:54 netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
> WARNING: CPU: 1 PID: 8456 at ./include/net/netdev_lock.h:54 dev_xdp_install+0x610/0x9b0 net/core/dev.c:9911
> Modules linked in:
> CPU: 1 UID: 0 PID: 8456 Comm: syz.5.847 Not tainted 6.14.0-syzkaller-05877-g1a9239bb4253 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
> RIP: 0010:dev_xdp_install+0x610/0x9b0 net/core/dev.c:9911
> Code: 8d bc 24 28 0d 00 00 be ff ff ff ff e8 69 c5 26 02 31 ff 89 c5 89 c6 e8 0e af 81 f8 85 ed 0f 85 59 fb ff ff e8 d1 b3 81 f8 90 <0f> 0b 90 e9 4b fb ff ff e8 c3 b3 81 f8 49 8d bc 24 28 0d 00 00 be
> RSP: 0018:ffffc9001f13f950 EFLAGS: 00010287
> RAX: 000000000000023c RBX: ffff888059e8ccbd RCX: ffffc9000da1b000
> RDX: 0000000000080000 RSI: ffffffff89395ebf RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888059e8c000
> R13: ffffffff870484d0 R14: ffffc9000ec3f000 R15: 0000000000000001
> FS:  00007f6e99bf66c0(0000) GS:ffff888124b41000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c2f3eb0 CR3: 000000007f4ec000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  dev_xdp_attach+0x6d1/0x16a0 net/core/dev.c:10094
>  dev_xdp_attach_link net/core/dev.c:10113 [inline]
>  bpf_xdp_link_attach+0x2c5/0x680 net/core/dev.c:10287
>  link_create kernel/bpf/syscall.c:5379 [inline]
>  __sys_bpf+0x1bc7/0x4c80 kernel/bpf/syscall.c:5865
>  __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5900
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6e9bd8d169

#syz test

diff --git a/net/core/dev.c b/net/core/dev.c
index 87cba93fa59f..534eda336f8d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10336,7 +10336,9 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
+	netdev_lock_ops(dev);
 	err = dev_xdp_attach_link(dev, &extack, link);
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 
 	if (err) {

