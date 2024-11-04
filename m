Return-Path: <bpf+bounces-43866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387E29BAAD4
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 03:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C870B1F21D14
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4016C687;
	Mon,  4 Nov 2024 02:29:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9352F76
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687346; cv=none; b=iApYfNyhbTUDUMIisc7m/CYxUZuHj+F9pXtI0xThYeX5BCVjiXOBwnX/aLDaJLFUQmQdneyePUWFzpeyqSyntoc8zz1yjmmbVnf1w4XDAV0P2ir9t7ONpGz59AlCdvpFixoP0ADEqDpjEzPX65rohA6GMGOMnOnliuycLIFVJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687346; c=relaxed/simple;
	bh=gNwFf6iiaIorcTcYBVfjA8vphuKqxAih7Jktl7OYBPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RG1DQfy4BtCadHw1WX2WyQIMxDB7mmdAWw7K5rB5lFrIa9JjHW6qn1Pkdc666BL6VHByqv1L1joYd9oNHKCxl9vSZS/5jK8q6D31nGfDpCvJM0+QzUW9hsVvrLAd7NUlx7pezBq2E0D04bayTKHnDo6/2hW6pYbduxc0o1DP5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so51568335ab.2
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 18:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730687344; x=1731292144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kIJcY+bZlhPtz14UFFslZ5AL1aCNsQ2X/ataYQ5n/Y=;
        b=EvTgh8MvmmxtTZGqshfKzyd8sjoFPkddej5HCcKvqP0rxi0CVCwAcZAUJDR4A5/ODg
         vx0dZvpezZihTbEzLagIkU6kCQrN2mgPUjnfwsoq76XxnwL1gqrfcbYAp+8Rxrmptbsk
         IDMT0Uh1NLS73ZTZX1OKb5eWSc56vja/r4+7DEH2+aOW7sRBTiyj8iIEZsZlXTau1PLP
         dVpYcrq4ttfIZOIa6WYWutub7EkmU3/HsXeXXWt5kFCcBCMJWN/LnSXrQX8fqSt+ER2I
         O8rsT2PhP+gjeMl2YZ9fhKPwvwBxz2UsdHRIwII0OuAxVVXxsZkXg81M5bufVZqhKBp9
         rgRA==
X-Forwarded-Encrypted: i=1; AJvYcCWfJvRcUlApRqH2qyku6eMEyJeSdVFTPx+vgNQWJtgqK0yG7IPK/Tn1EHVi5C8TVFW7bBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNm6xCR/sCs1kZSwX/nSnlsOypbkxr/tLhWImosYtPO/wUj2pi
	TrQF5zY5vResRTw327BEMLaaevq1mdGCLfxdHoi74w/MMFTcHq+9Htt6pJrgKBQQ4ffEwgvqZT6
	CJXDPFSLoZEP5qsFsyMRAAkWslnMPXxrEelZ0wS4PMGIniPw9+McZTao=
X-Google-Smtp-Source: AGHT+IFgG5tFqR3kE+12iet3a5ZIvV3jfp0ny9MNGbZg0Bp3oS/ZBaSHALXZj3g22FqKLLRYvMLq0hJieO8KAgf6NiwA7GqKqrfq
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:dd06:0:b0:3a6:ac17:13e0 with SMTP id
 e9e14a558f8ab-3a6ac171705mr93992295ab.14.1730687344309; Sun, 03 Nov 2024
 18:29:04 -0800 (PST)
Date: Sun, 03 Nov 2024 18:29:04 -0800
In-Reply-To: <67251dc5.050a0220.529b6.015c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67283170.050a0220.3c8d68.0ad6.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
From: syzbot <syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	boqun.feng@gmail.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eadavis@qq.com, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, longman@redhat.com, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 560af5dc839eef08a273908f390cfefefb82aa04
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Oct 9 15:45:03 2024 +0000

    lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122a4740580000
start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112a4740580000
console output: https://syzkaller.appspot.com/x/log.txt?x=162a4740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=d2adb332fe371b0595e3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174432a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ffe55f980000

Reported-by: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com
Fixes: 560af5dc839e ("lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

