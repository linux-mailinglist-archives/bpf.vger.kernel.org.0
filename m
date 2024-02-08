Return-Path: <bpf+bounces-21547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF384EACD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C9D1C218C9
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 21:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E084F5EB;
	Thu,  8 Feb 2024 21:48:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067F4F21E
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428913; cv=none; b=E8n/Ca1ZzYVIOIIMMFUBzxok2m+8M60ohLOrv7SDZdjEObXfHONZiA1ANEzBb7RG9dH8j0GNsSc05jTinxdFkDGW5RlW552WiFBwfG1olIfmVRCjmTuBFvofTNtVvdgMI31BLitup0O6WTQf+TRcR+e3trTi18MDm0m1c/E9Ws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428913; c=relaxed/simple;
	bh=x5X/SpXcWWm2drcgwtU8g/8NQadRYVVVLQ/7tbIX2x8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rxhSviuxdmUGfBPlGIqi+Q52MBzJEPOL9r9Cq5f8crLJhh4+EWamOI8VW2Mmz7qXn3rOrlwA4anLTFS+m9ahd7dRHoS57zo86cGyzLGDwsEGJBV68IpCtAvhP2sHlXY0a+/CXQBh12dxu0au1873m84+Ropa4xNzky2AFnH5sgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-360c3346ecbso1724495ab.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 13:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707428911; x=1708033711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcy+RP+3gbw7fm5zCL72DPRbjcLix4B+pCNRB7ycwkg=;
        b=q3XslRPNZpOpaFH9859wsfb8R+kwm2uOSdAd9f4iksmYg2jAr8jDavo/8T2OOv6YRl
         zCCdBp7btInqE/ScOPE4LvZXH+R0Ufxt9DnnkJQvyh7beTlCDMucG071G78+Vs624cqm
         W0e64Xn4g2bApHtQkXicPpQYB5f/Z6NZOyvVa3gaGhPVgk4okb83r6/zMV9IXu2wi6oq
         VCyNuGo9r4NE3kVN3OJTb89VBXVQDkd6Gs2Yy6LnpNpJKkbViFmb2nQaRKUMIkybBlwd
         zWWBcSUJd9x58ja3TMTpPIEON3Yn4zeh3j/oWrpwDqgxXkPccWtI3U5lKdbx8JLAWGAm
         69Hw==
X-Forwarded-Encrypted: i=1; AJvYcCV4dXLGvl896NxnY6NHH9n+Q3v8dYUYogiZeFalzqwWOFhfHX5hnW/BYURZaN7mV+M4g2ATWWu4Na8Ff+i96zaIzPtw
X-Gm-Message-State: AOJu0YzzChDIs4KOiap/lbITtOknTi/lZ61h01In8MWBjHNcy7VYBZ4b
	g8Z6kjB5xP1dqtsYu2H7vrhb7UeJk4FbNbdmMG6Ej+owRWFzcjKVBfvG+klp+abtmu5uAmu+T2y
	Nh+pcUpdIauNKSpweiQ4+4F8Hw205TkJuiUsEcFmafDZq4FShHeY/L4M=
X-Google-Smtp-Source: AGHT+IFtte76dKULRywQHjdaJAxVanDStW7HCAN6er85mHH1lSIM/J8p9GOwTK8goVs8+X1JMOEuYkNw0BKCgSWTuzSleIkfJafB
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:363:c1c5:79da with SMTP id
 j25-20020a056e02219900b00363c1c579damr43586ila.4.1707428911094; Thu, 08 Feb
 2024 13:48:31 -0800 (PST)
Date: Thu, 08 Feb 2024 13:48:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9aa8e0610e5c55c@google.com>
Subject: [syzbot] Monthly bpf report (Feb 2024)
From: syzbot <syzbot+listb6955cf0d43f0daabf0c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 0 new issues were detected and 1 were fixed.
In total, 9 issues are still open and 205 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 164     No    KMSAN: uninit-value in bpf_prog_run_generic_xdp
                  https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<2> 34      Yes   BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg
                  https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
<3> 5       Yes   BUG: unable to handle kernel NULL pointer dereference in sk_psock_verdict_data_ready
                  https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

