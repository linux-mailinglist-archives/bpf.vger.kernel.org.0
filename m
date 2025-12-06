Return-Path: <bpf+bounces-76211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B7CAA35B
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 10:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C622B30C38B6
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1092DEA9E;
	Sat,  6 Dec 2025 09:24:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585058003D
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765013068; cv=none; b=eXVRBuVompZR4DZWf9lFhfO5OK9IRzIQs7hj4TKZh5PxBNfsH5yrdoXNymqoQoN1+CYl6k2exRIM/c/ceVSz0dcE9uFGQTvhGEsnGewn0907HP8sx94c3NTE0c+Z3cq0IbFMuVGFqWi0U7zalKygj3qA8yPeNYooLqaXmqttWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765013068; c=relaxed/simple;
	bh=AEKBpuaV5uH72G57k9JRKoSpvxyQcdZ3XuFzBwNjXPY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IFagSyfdM1vYoqEPBWz5SRPoU5VDW+0l70sU9qEv3I47lqZBpabPDgrhJ+XIH+4GBAA4q0iM7guMmwXfjE8O0oXxLtCodzne5GUmf269sYKn3aQPg/x0wN552eyU9mPsYhWubuVtWWCA4szLQ9DnbnjrSED45Ty5hlOMpMdr0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c702347c6eso2957893a34.1
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 01:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765013065; x=1765617865;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+RE6SAujetHbgZpbZEI2WD1QHyK3SMe3aVtJwBI0pM=;
        b=pNySPPkAlFjUWbVJnGHixE/0bMFQ6RHuxo25YyYg++t9kVMhUDHlplTq5erESZtDG0
         DHEfwsIft0aj8cN5y0bBuCwVie1FH9H6at6GOfysrpaa5PRs9jjchOAS3EG7z//BW5Pc
         lvCS17lDJNVe6O+xD9qruCJ8ATQU7kldTCjyDS5Fvntrhx4XcX2WXj0fMYkWJLXXL4U0
         vaN3E/k5kj+HBXuugcWPEdWAotHWg5E3alaL0bvYFdlcDp6dDWKV5gm0RWmEYfJi9gmF
         F4OHKF211+M0OLorknqLSaxo+NhyPLRZI0t8ldyVzwJ05pTUS66U2tMX8rEEFgEGNOwY
         lkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0pOxmMiyKvOFMyr6B0wXntbEc945T7RRoL75J4nzNHRQNn+YJmRDfVaqju3T8458R1cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFIK6m6YkrEjvNyG4PiBzDOw48Azq7AkC2MDFZyi/P7twLVvyI
	jKKgFxWVy+296pHZUMTQ21vxtdxF3uZAbubqDR/oSX4Bo4prW2QVUjZys5F+svYuyHSKUXV07Pq
	ABSQrgazWxAMViv3tTZegeLVHWg6SRG0vjmVOgBV4PQWoA3Q3wo8h0CGb3ik=
X-Google-Smtp-Source: AGHT+IG2AASWF7pLzeHjKgDZOljWzICEiF82SiyD6q2eIC2ZW+GSvyp8KbL7dIil01nyZW74M/6FLgmeO9Cdyipp0lMVS59MwXGg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e904:0:b0:659:9a49:8e40 with SMTP id
 006d021491bc7-6599a8a2530mr799369eaf.16.1765013065523; Sat, 06 Dec 2025
 01:24:25 -0800 (PST)
Date: Sat, 06 Dec 2025 01:24:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6933f649.a70a0220.38f243.001e.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Dec 2025)
From: syzbot <syzbot+list193c795d14bdc89edfa8@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 4 new issues were detected and 2 were fixed.
In total, 20 issues are still open and 315 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11073   Yes   WARNING in reg_bounds_sanity_check (2)
                  https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
<2> 1597    Yes   WARNING in trace_suspend_resume
                  https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
<3> 24      No    KCSAN: data-race in __htab_map_lookup_elem / bpf_lru_pop_free
                  https://syzkaller.appspot.com/bug?extid=ad4661d6ca888ce7fe11
<4> 4       Yes   INFO: rcu detected stall in task_work_add
                  https://syzkaller.appspot.com/bug?extid=f2cf09711ff194bc2c22
<5> 3       Yes   KASAN: stack-out-of-bounds Write in __bpf_get_stack
                  https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
<6> 1       Yes   possible deadlock in bpf_lru_push_free (2)
                  https://syzkaller.appspot.com/bug?extid=18b26edb69b2e19f3b33

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

