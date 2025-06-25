Return-Path: <bpf+bounces-61528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA6AE85E4
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70641779F5
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84138265626;
	Wed, 25 Jun 2025 14:14:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3732263F27
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860874; cv=none; b=O4UmcCI6bipoT3dkB196ka0cIxEWOqIxeyT+uhonRRPozub+z1X6COFfcO+3yH2BLa4n/8GH+1XHmVCkNELPBvy9r6/Nms3xR7Uk2C3Z3f8NBKMsbrW06A4UoH5ovJveayHR/SMkggO91VxoiqP5xAB6IP8rGoNtHE4rRwr9zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860874; c=relaxed/simple;
	bh=TwJhoQVTKewqAiecfG3kRNUnDXWKo7e5dMkPkOD0uPc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IiMPM6U1vKk7p4hXoL1Too/vvcamiDHVXwO+ZEjHdktZbHCQULtaJh+8Tj+cgLqiTTWXw7+rfWPrwUODmPPiqZo3xwVgoCHBhZk0u8qCpWW9ubNuYl82u32WUGrBAuDKnx2R1nvKGCEZgKKcTgkq7xwAaYYOBUx3pagUc/cZLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so23045675ab.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 07:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860872; x=1751465672;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVAdq5Xq3i/M/33mG03JeSbgLnvbME+n59OXXHf2FJI=;
        b=ODGNspYaCL6pIU+zr6IKflCtDFeTw4whLk0YhCcihn+TnsbGYppWGnrftAQaF4pZVm
         3XMhxsYJeGV+lAH04kmReQF2c6CcqznvARNVOOtq1akGqfy358U7dQ/+smfwGfZdLg1G
         xO3fhMAoWZouXiR/95W8nmHgwZGeIxz0uduN9I0rQNF5XReUD4SIoUqXc+nlcEdE9Lbp
         TajR5eHx0qZsK3n0ah1K/qsFS56p87WBCF2g+5TZVejcMCgJ42cllhxmSCNuGmslr3x0
         QUHwMv+r0nNCvRPEEt/itUOq4aT8jHemLvex6EJkaaUqH22MN2fJu0bRR04/p5/uHh1O
         HZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCW8VQRX+9kX38M+iNRqvP9b55w77veLxao5O1Ii/YYiz17wHs7xxf7MdXO81JRuSEn0Urk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYBeWHBkOb/CG2DdsMO0ciIPhjSuqfSzO/Zto2cYN5My3KuVa
	0o5lONGt0iUhxbZcCrTR/RKJ5oX429YWzxOvR89zwovd9CPsIZhNcwzFmUCcBmypoS9rLasz0fT
	8OOhNfiHsjNKzq4lag/E0vvjRARyr6YBTzz0lluZAiaCo6K1y9rU/kP2Ct/A=
X-Google-Smtp-Source: AGHT+IFAY8cbF/hrLSvfXwLM3Q/WedY9hHd354EOrKS1CI3bA11yz9a/SmJikGlDR2rNWrnyoxqwq6e2gjjWCu9ETmLS9cysCgaJ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:3dd:ebb4:bcd8 with SMTP id
 e9e14a558f8ab-3df32920042mr36725445ab.9.1750860872003; Wed, 25 Jun 2025
 07:14:32 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:14:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c0447.a00a0220.34b642.00c3.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Jun 2025)
From: syzbot <syzbot+listb92358b4c1405dc20706@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 3 new issues were detected and 2 were fixed.
In total, 25 issues are still open and 294 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 269     Yes   INFO: rcu detected stall in sys_clone (8)
                  https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<2> 13      Yes   general protection fault in bpf_get_local_storage
                  https://syzkaller.appspot.com/bug?extid=e6e8f6618a2d4b35e4e0
<3> 5       Yes   WARNING: kernel/bpf/verifier.c:LINE at do_check, CPU: syz.NUM.NUM/NUM
                  https://syzkaller.appspot.com/bug?extid=dc27c5fb8388e38d2d37

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

