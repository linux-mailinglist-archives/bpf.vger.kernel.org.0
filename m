Return-Path: <bpf+bounces-52098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F2A3E49E
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 20:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C654E19C3E6C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 19:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624512638AF;
	Thu, 20 Feb 2025 19:03:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60340213E8E
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078206; cv=none; b=uxduUau241WgXE6TSkemUae66QQRjd12Ftk2hJFTItaAqpm6zXAE7k2te58mj8fhw79e2nYM+2aL5+QIxt+qUHGdJ1IluhntVUjjIuxcNa4YB5QBq8u7RM+NfV4w29U3XVIJNzaZkeTuZCoufKY7nGkjJaN4UMvAQXAf5OkwXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078206; c=relaxed/simple;
	bh=lQjy5Tbt7SOKgHum3uUoO2fOLJDZZlD6bMZGv7JUG2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t1jviKMlAJBrDlYUgZ3lH071EDgWUpePITucOrhCbv5B6G7XhNl0KMbTXiWLYs/r7P7qfWTJl4a3ZhmWRJY52p3FbyN8Vl/0p2MURQyYpkoYUt0HFxTFzB9+aEv4VHnnGQhIfAcYMrPn9xeJippcXM3PLpiAdNGTkqL9zXrQUL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b70f5723so25242005ab.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 11:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078203; x=1740683003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHPONpBhaL8KVkMvvXywPynT8Hy32yQffO5v7e4WWk4=;
        b=Rn0J12JtRYdDtdRoQg/3FBw7cmK/Rc69NVhY9WQSsrpRZ6CmegjYbsfllNLaY5zmXx
         OCI5mg3V9Vm252IP1Nid+NbtL9LG2MqY8mK+TvbMSVZo9/fZ0RFSUO1ORNga1bKC2OlE
         zGlrVnzYE2BTqm6fj/AWKh7Bs4R/DZTGoI2p/SNPL8+st+csuJyUhcrOf2qi44Vbc/MJ
         PDKUUhEnEpB8WpYEMjmpYegkDR7z5ZFGUbBV88lf6gF2gN4G4+AgSnzGNDWRl3qzWrAN
         t0SE2yZrn4N3AfVTPaWabAXtymIKCxPSc2B7QIvvNpF9qtsH5GTRiBQRk3B9y358+dfY
         q8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCW1U84f9F7bKoSwyw6FhSQup24vBxbbnR4IcrSaiMxVYY11UoDI1caBqBWspd2lWOxrmSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9aZR63CJk99aRX7G721LXhPfHu96ZcvZ1DAr1c7ZLuhxObLI
	WBsUwDnuHtS05vI9gmXt6Ahq6bFzr7YY2EiFA3z+AJ1pE9YQr9yVO+leg5PttgOXc8bbJWIzPjA
	02e0vEdoNwuUuVzlOCV5AcEs55KVIBWFYVcNAUkVI78Et9odnYaxFXWQ=
X-Google-Smtp-Source: AGHT+IFbeB0rKTkfnKixOR1ULdMQGD+e+nLetXnqw/agrnFULWn8S5n3wmktH/6G2fxeWduuFbPVi7GW8Ihc//NVyD8BAsxI/4cN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:310c:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d2cae4cefemr2978485ab.3.1740078203645; Thu, 20 Feb 2025
 11:03:23 -0800 (PST)
Date: Thu, 20 Feb 2025 11:03:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b77c7b.050a0220.14d86d.02f6.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Feb 2025)
From: syzbot <syzbot+list291bd82fd4f9cf97dab3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 0 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 280 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21436   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  2116    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<3>  1993    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<4>  232     Yes   INFO: rcu detected stall in sys_clone (8)
                   https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<5>  177     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<6>  71      Yes   possible deadlock in queue_stack_map_push_elem
                   https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
<7>  52      Yes   possible deadlock in __stack_map_get
                   https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89
<8>  32      Yes   INFO: rcu detected stall in sys_unshare (9)
                   https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
<9>  23      Yes   BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
                   https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160
<10> 16      Yes   INFO: rcu detected stall in task_numa_work (2)
                   https://syzkaller.appspot.com/bug?extid=06d48cbf3e767907cec2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

