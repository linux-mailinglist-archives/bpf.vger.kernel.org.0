Return-Path: <bpf+bounces-56573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5CDA9A4B2
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 09:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18077AD842
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF918035;
	Thu, 24 Apr 2025 07:48:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19031DF98F
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480909; cv=none; b=OxYpCQ04Z9cMKFUNq1+OJ4Wr86/xLCB88Upy/gzWQk3wVJt/tAzeUJdBFb+HHqXmxFzke1l6qkXwrOxJerDbVIL4hy4zKCUF90Xy60HZ9MeRsrJw2wyauxdOrOWVxQMz90Mg2YQHJuoHYQH/qqy+JaZq/7hncRI+oJ0USPWnZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480909; c=relaxed/simple;
	bh=svru1N4+9HP6clJb4juZ6a1oIPHGLBdHICZaGQvJQOk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y7iNQEYQzpEtYYF+ZCOglRILzAuRBExiMUhA6aV7nuZeFD23pnFhXjbmkVB8U8tnavmQBkjz/BTCS0t3/lz/Lm7z+9gKwziERY83AZb1PtLexGtVbqSIFtNjKo2QjYbWy16L3PsDRmZbBfHRvQGF8uMq2afc/Xs8JaD0UqYq/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b4dc23f03so152570739f.1
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 00:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745480907; x=1746085707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyJl6r6OZz/+a7pHM+1QZtQvrTo3HwL1nTMBQN3lL6Y=;
        b=Co2YEKr606fMsbsNbT+/GKFzLigNP9QWSV7J3UpBkpO5poOe6NBFiGvaTqXG9iAPwy
         SoVqfneKAAyVHASjzfk7GlvBVb4KeTKB7w3UnxffnWJuMt8LnZVcSrGbUHGo4k06nTR+
         OoY9zkz6FXz6tyFQXEI+4Tjk0iLveieWpiItCNJ4ob0WzlV6RNcxQPbyCkPFgAfkzj1J
         j0tpmZirAZesx2B3WKKnELRiRWKc/oJuU+cRCag0liVwzorjtzMdUjwhv0hJnR1WJSi0
         Jq4C3EA/OwfUpan4Oq/jB+4JXSC8PaaSzUIgHKPuzSv5MjJsIIXHjItz2FmdCMyxN4Tw
         iz4A==
X-Forwarded-Encrypted: i=1; AJvYcCUcmJA3CnrwHO/BSUyJX5XiH6V3zwfDAsyGbI8tJlz6YSIxtMX49hVhC/91qpi/NB1HcSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUN4JIkfmqwR0HxPE71e5D+rLLAqFnpyyiX8R4jqf3PdEBC+Hw
	kxvv6eHb1h9iDn46wEIA/TXqjO5BSffzHWQ+SY+WZY9wqDUKbvAO8fwKOD4p+nPun9vYzLoHMiG
	HnY8lgj5Ql2L4v7lc76jSRn/PgrcEdJZpM1S7Sp0Rdnna69sjhZz1Rzc=
X-Google-Smtp-Source: AGHT+IHzUNzXP2deS4l0cUszwq/xaCvriu6jPvej6Sn3tNmutEBPu2Rpfb4hLdnmsWpxJdYOHvj+UF8zZnHuc3Ks6zKomcqZVnPE
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd81:0:b0:3d8:2085:a188 with SMTP id
 e9e14a558f8ab-3d930393d8cmr17194595ab.1.1745480907023; Thu, 24 Apr 2025
 00:48:27 -0700 (PDT)
Date: Thu, 24 Apr 2025 00:48:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6809eccb.050a0220.317436.0047.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Apr 2025)
From: syzbot <syzbot+list764e216efbc06fb2844c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 3 new issues were detected and 5 were fixed.
In total, 25 issues are still open and 290 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2116    Yes   WARNING in bpf_map_lookup_percpu_elem
                  https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<2> 253     Yes   INFO: rcu detected stall in sys_clone (8)
                  https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<3> 11      No    KASAN: slab-use-after-free Read in sk_filter_trim_cap
                  https://syzkaller.appspot.com/bug?extid=b4bc25bfaad44df51f05
<4> 6       No    general protection fault in drain_mem_cache (3)
                  https://syzkaller.appspot.com/bug?extid=18139576507d899c8066
<5> 5       No    KASAN: slab-out-of-bounds Read in bpf_inode_storage_free
                  https://syzkaller.appspot.com/bug?extid=eff9059eb9bb5f59b754

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

