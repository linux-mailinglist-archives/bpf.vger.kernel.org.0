Return-Path: <bpf+bounces-47359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D2C9F8737
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BBF7A03E5
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 21:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D61C07F4;
	Thu, 19 Dec 2024 21:40:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440161B4237
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644426; cv=none; b=K76e2mV+gNzVvnQYdxQODdWsyalaj+0rTGUg95k718P6SkRLVtWqJS33HPpOBjiI4VYtaF7eV40qhmumcMbZcj8ppeXnFOtPSf7H3kaRJl4hetLOCZyPfZ1lV6j6EPFY3lHJxT9dXojm9TXFqUukfBU6vkw2FcTfj/pR/BO7l54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644426; c=relaxed/simple;
	bh=tlPQ6jk73FVbnwEyew4I2Rz3ta1EpU+dBKSFL1iAIeY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OKvWwaoEKS5KZz4IoquETs2z1xf0pCBIOiOmnaWd3RmLZ367m5VJTSHOSsyRjj7BmIR+onIiVrw7DVFq1nG6Ep5QKBR1gCUxfAA5DZ2FZutRL5g2PQ3xE1D3RueX8R/vUZPwgQtGnA1tBq8z8XKd3eUQM1M+u5haDXCxp3mwEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a814406be9so22172165ab.1
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 13:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734644424; x=1735249224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UahJp0F0PzB0a4TVG9iDL+Q7fTP19o9BWG6lsar/2lc=;
        b=c1lqupwex+mxHeAojWMKQgsTGRWugCfT0C8AdGlXNm0PksWtyU2CEPyM5y8stXhBa4
         1SJvStqwaGHAkFojsY3r74Jc/ZDyV+v44aLQ1x3+ADMX8S+9SqxKEvgLxS9s7d/6jsT5
         i2ETpWB/C64xEZU6QSzU/X+g+2sUOzr4mneOpS2djcmC7LltXKiiiRVokOld/32BO3n8
         DA+GYv5bK1Ys/mLMs97o5HTzpRp0Pbtc25cybd3UC8SK9qVo5OE1WKl7qLM7hE8MqMfm
         qm5PtzzYP7RuXOSOBEqt/OT5rJM8jy2tq2g0Jop674n9iqtyFmFtGEtOdNC/w36MespA
         P86w==
X-Forwarded-Encrypted: i=1; AJvYcCXfiH4XE7t3wJfEF+JJWewX9sSrKOV+Kh9s+5IpjrioXLTWI60ADRfCnjiFOipGaWXjV2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7v+LoMVjjcmwgDcx/3E0hxhrQE8HmWbPMKtbSJFJaJjBBOeb
	2I9fOK16I1O82MYgXxaD3fOY4j325WmSBzY8G1CUk6+bfiwmrnNRWPOgGcdeQCA0RodP5sHMvqE
	srs1DhkU39q3272p6pS1eiHdq7otRzWt/pJdXLF/O3gw0sVpdNPFAbqE=
X-Google-Smtp-Source: AGHT+IHUp0tpG46g+bOUGtgfs4ba4xrjstzzDDfxMzkepkGsvmYVFVWTpqDKkFdcmyBmiH28RYXw6PQrXDyNsME9QTnRzXJ+i1Er
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa7:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3c2d257fa37mr5814095ab.10.1734644424520; Thu, 19 Dec 2024
 13:40:24 -0800 (PST)
Date: Thu, 19 Dec 2024 13:40:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676492c8.050a0220.1dcc64.003a.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Dec 2024)
From: syzbot <syzbot+list632c08477db437fb3a68@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 3 new issues were detected and 3 were fixed.
In total, 42 issues are still open and 279 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  23132   Yes   WARNING: locking bug in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=b506de56cbbb63148c33
<2>  21422   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<3>  2116    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<4>  1710    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<5>  1352    Yes   WARNING in format_decode (3)
                   https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<6>  311     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<7>  182     Yes   INFO: rcu detected stall in sys_clone (8)
                   https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<8>  173     Yes   UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
                   https://syzkaller.appspot.com/bug?extid=d2a2c639d03ac200a4f1
<9>  166     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<10> 92      Yes   WARNING in bpf_get_stack_raw_tp
                   https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

