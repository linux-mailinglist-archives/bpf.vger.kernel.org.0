Return-Path: <bpf+bounces-67660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948EB46830
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 03:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18347C6488
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDA1AF0C8;
	Sat,  6 Sep 2025 01:58:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089F196C7C
	for <bpf@vger.kernel.org>; Sat,  6 Sep 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123886; cv=none; b=O3cn87aDFRzTyCxW3TNKUQyz+Xxvk3u1vy/0T9i7v6LOQZFNwo2IWaX+X1lCApPUu36v0bYLExiIqDQWBixMvkvs5kfANAMG3TJ3wIz2W1OuEXAUAE78AUi85w/OZMCQpU6rsweuzHzySKdzoDcOOyIwxBdGxvpR9IRUEknDtDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123886; c=relaxed/simple;
	bh=huAbnfu87JLJJSl4U7UELqiT8AbsdYCfrTKng7zURFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kKs2ehFFN3QEGAE4DgXM0GoZerf79RKs+DYNE6D2BrRpOtYuk9dsNVaaAOnnOFjUn2kP2cqDIZJwZqdX5DgC93nm6BH3SsNsUMbrCjgG2fMgI3OxYmOFQw9eKycVDhMLFChrAWQCo/+nZqKsWUj0nioZkjOCQ9PbV+iBAFkPE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f90a67bd4aso28763845ab.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 18:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757123884; x=1757728684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTXtF8OtfC1LmLHyZ2eP6LGT2rApcz0JyxdPwyLyFDw=;
        b=fy8JzJZg6EBezmxK7lpbbVqqypVdzERdpC4+Yf6s+0PEWYpviPrQCiHqnrd9Wd3LiN
         6nhAoM7LDkdCcArhG29c7lY3NWmZVIDTKeZ9e5VaMl+vOmuV1uu/ZO8tg/7ZL781O7FZ
         sWl2fi3eXaTBf3nJ6Zl07GXDwceH2Iwkqrd8Qop3JQj/ECqyXHnnbe6BQOvxeRYFgbMb
         6vIpMhJUqopz15fFOq6nqZmtHYq20iX9pKXyelHIVBfyW9Ft/MiMozy4UnBgr3T7C2RR
         Mo1n60KT4d6uAwQ4crdPyIITZkR49MYW1zqux7M29HaHN6OM3rAoIzGElPaf0stEbfPM
         jbQA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Zqr1f75J1akq2INdIGKojyNMgq2bojzAz7TqoPrSp4nYH6pzJV7UGabrzHV428QcelY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgFyPpLmPylXjMIC/bP1rMR/9xVy7ywtR+3gWD7rKgdjg7fjg
	JJhSPXPC+KLDa/kbZ5UgIcQR9WHh+SSfEe7eDta8+abLKrau5RKbibpO7e5SVeuPafUnamFgcS5
	cEaNptrZRgiu6P35MKvvX/eXTPfczWz3sXs/9CURVkepbNvvvVwifGbRHjaM=
X-Google-Smtp-Source: AGHT+IEwcyKSBjlQbrJidpoGpux8ea5Full4/ob/ekOyhM8HdkklWUh85hzxTCDARaYSTNzJTOwSapgxSepqIItLaYE0jAkXUxye
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3f6:dc32:df0e with SMTP id
 e9e14a558f8ab-3fd877837cfmr16180435ab.27.1757123884561; Fri, 05 Sep 2025
 18:58:04 -0700 (PDT)
Date: Fri, 05 Sep 2025 18:58:04 -0700
In-Reply-To: <68bacb3e.050a0220.192772.018d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bb952c.a00a0220.eb3d.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, paul.chaignon@gmail.com, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13652962580000
start commit:   d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10e52962580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17652962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17da1962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103a1962580000

Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

