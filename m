Return-Path: <bpf+bounces-65065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6EEB1B64A
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0840D1697BA
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A627147B;
	Tue,  5 Aug 2025 14:23:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2B221F32
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403787; cv=none; b=VrHOW1NjEjEYZOpd9S85RfYfMC+SsJPFjHukyeiSGoTVK6+xl2m+dCitzG1rttGqnw5pkwbulWnC8O2F7sHWtWNjCwH0Z34+x4a2uozIjclKKtBX8wrxntLcBHFD+LCMfNX8qaR8c/ODgO9bdZcq1GjP15YAaUKoXL329bJ+nuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403787; c=relaxed/simple;
	bh=lRLFhYlTOULrEjNTkeQAfSvEE/+5UMaGvn9j/sV9j/g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TNSaDVZkQRDjlHxZqjx7hUk72J1p6k41bMJAAZCKhQ4Cp4U1yqPHMlClQ+AfATaA4KSLrz3ZB/L3kXu7prZBeelrM+PWUVarYpSJ1DlYZfEQRAowQT66j+qbjX5cBRKoOHHCLenEafzAsT6SiJNdR/cu/DK2Y1f93Is1U/6mbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e51580706eso10178915ab.1
        for <bpf@vger.kernel.org>; Tue, 05 Aug 2025 07:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403785; x=1755008585;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG4U7RWWNVsnG2zFiDlE4qMZubkY1bnQ70IOtehE1qo=;
        b=WvBzzyiXGR187LldtjMt+rM7xGFozLjJEEMi89g8YBC/gLIzp9tjx0zFMI8VACsGTI
         YFYhHWVbHTg+6Q/Dc+S62B0Op2akPiPi6n3XSuqkw72a9UnGJImXbJ6n/okw/AkoJ4bE
         3sRs9KgS7or70K1TStbS3VPt7Rb9Bf6Mfhwx209kcwpYktTzYewOyKdSPfSH7VPlgRlp
         b2gT6LpNdn6Lvm4pl0/FAITNLxRgO2tK/FGP/3iRTML5UIKsY1tjEBJc93eEz+2SfRGf
         3BJzvbKjjJBM9VrBq76UN7FolTmYwHZhmlvCVmEOchDQJU9lsFTGH77eHhs+/fJjnwC0
         vzSg==
X-Forwarded-Encrypted: i=1; AJvYcCVwuJIu2iY73GpSEiwGOYR69NtA79DCYB2ZX0wPCXwbDnH6HoUsma5mi3rZjcYJr8Sm4MY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QL7UGTgN7mu0vCxQ4DJ9ZhM0DZLnx8f3gKSSwidVMA/6Gc3T
	NS4MmmaNV2GL1E24n1Rs/rjUEgpvIeMzVF1Eel94ZLYNJ4dCkRBbBFFHppZ3Crkd4TLNTa1fjDW
	QRChMYmBUZE7wdt+rl/uTYXH/leOohbkp6rttp8R326U3i2blyBb6vvOrVOE=
X-Google-Smtp-Source: AGHT+IEbRYZm2LLvcCLwlMdJjxE91C4YS9SagSUrJU2HUZ6rtB8N9ksL1xhgtVy0F37zOW8VdwNqGcqNMc8H9Okbr2sZC7w12DmD
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:3e3:d52b:dc56 with SMTP id
 e9e14a558f8ab-3e416117892mr253709025ab.6.1754403785531; Tue, 05 Aug 2025
 07:23:05 -0700 (PDT)
Date: Tue, 05 Aug 2025 07:23:05 -0700
In-Reply-To: <aJIMvndTxgUzLC9F@krava>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689213c9.050a0220.7f033.0026.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in do_misc_fixups
From: syzbot <syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, olsajiri@gmail.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
Tested-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com

Tested on:

commit:         5998f2bc Merge tag 'exfat-for-6.17-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17da86a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=853dee08ee43cbe9
dashboard link: https://syzkaller.appspot.com/bug?extid=a9ed3d9132939852d0df
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1365c2f0580000

Note: testing is done by a robot and is best-effort only.

