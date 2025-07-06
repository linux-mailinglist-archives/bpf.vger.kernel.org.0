Return-Path: <bpf+bounces-62477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3BAFA801
	for <lists+bpf@lfdr.de>; Sun,  6 Jul 2025 23:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFB73AB41F
	for <lists+bpf@lfdr.de>; Sun,  6 Jul 2025 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC31EA7C4;
	Sun,  6 Jul 2025 21:47:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D41DB34B
	for <bpf@vger.kernel.org>; Sun,  6 Jul 2025 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838428; cv=none; b=B5YmRGPWyVR7IQB1ixwyiRhwzSjehkh2DcP8f5ybkZDYltY1DfWr97jpSJxgCRSZmZqj04QZoL5kHeL6jAy34Gsz4qXTK6AzadD2tKAf5bNBnU21qfQXbVCwGduWNepJwnnuTMKJlBUdkCG0krR+WEbFhQ5fPGdeP0iykY1ofE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838428; c=relaxed/simple;
	bh=wfC6pb06LVhsTYsLYsVaUHcm+Hi+5WQlNyegKa6NJXs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BviarsWmrzt+45O2LhSnZlYBZ9BMrUSZgktVlXIGvayrm7rEi5C2kwqn0m1mIUuZFfZzGYkVOBt9O4TlIaRVUBY+emAUQG4es+KGkpmyxA6eyZZV9J5r7LXZjWfCAWF1hC4jOUhwH5sfO2QgeKrsafJesfHrRdsG6k48FvOj+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2d907c23so10795195ab.3
        for <bpf@vger.kernel.org>; Sun, 06 Jul 2025 14:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838426; x=1752443226;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixkLOm92PB3kA5hKonBVF6NTsAkdtIPeB+mFKWDyXEc=;
        b=gl2RRTWsOli2dvGT/8KuU0HRrCtKV0MCt9eVxSmgoJ34GI8lrTaxi41Dd4fvcl+9Mm
         3tBOE7GUXSAoAYCheg4gicwF9Q/2f85hAJRdvQxzf8qg9AaXI1i7aHDQKxQ7rrrUHiqZ
         QC0PFeVN4BdFLHGmCoOg3uSJVHwWoZXukyVmXrczp5qcOw8uIvLa1urfEwJMxnrPS/Ax
         gcq5ukOTTTrNUOjnkfIRtLkEyiXc1EV41RFm8SGBQasxvULpz6BPDaYCPhXmO/05ZaUU
         BANG7JBty9E3VKIhnTbONzp/Q/HLKGpuH0B4z24um160aMGER0kRotR3K90lzi3XbVSx
         v4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCW/OQzMPOzJOCpdqoo3XEkfG0fdN3HYhC9UIwoZgJwGvC2D3ACzwCogsJ2qUr4R0NhFDCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pGZkw7N41X6VPQHIGBBUQUvVwF/0GQbbIXbMTHT1Y4kwM/XE
	ecqdOQ2aNxf/8BhP7pK8tizY399Ugu78Cefx+RmBkxbd2pZ+gtoy3OKC8eh0Uf6mYkIKuvLZx/u
	+///LdHIQ4wXia/a7V+ylCqFaMp5zNtEcg5H1YJSyZ1kBoTiACnlRodFiND4=
X-Google-Smtp-Source: AGHT+IGOvkaWcRRlxGfeWW9ngMLdfdp6SsnKx5xXDRjn7fDFzE0uyggFtu2AuBaGZuhI/U9YHWkMoTdeW4CSvVR5hl8Svwo0ehVr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c3:b0:3df:2fda:e30b with SMTP id
 e9e14a558f8ab-3e13ef15bebmr70223205ab.21.1751838426600; Sun, 06 Jul 2025
 14:47:06 -0700 (PDT)
Date: Sun, 06 Jul 2025 14:47:06 -0700
In-Reply-To: <682dd10b.a00a0220.29bc26.028e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686aeeda.a00a0220.c7b3.0066.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_check (4)
From: syzbot <syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	paul.chaignon@gmail.com, puranjay@kernel.org, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17014bd4580000
start commit:   cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14814bd4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10814bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=0ef84a7bdf5301d4cbec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109df88c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11705770580000

Reported-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

