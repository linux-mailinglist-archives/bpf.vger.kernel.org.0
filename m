Return-Path: <bpf+bounces-26492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ACB8A08E0
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 08:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766811F215E5
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8255513DBA7;
	Thu, 11 Apr 2024 06:54:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996710A11
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818466; cv=none; b=j9MJRqaeLJ1C/zA3WxC2NN1UjQceZYgv18AHo+XX3SxIWDVU8lVJZSo8MtP1DefII0yOMPwbhLoAQWxOlQqMCeahS2iNmksnJsQsWsw6/TBpk75Z5mhwkSmkF5AQWPWy4pWt8SfRvUPt27tBKeQO87dUkHobX+mUHd0yzguhyNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818466; c=relaxed/simple;
	bh=WaC2eFNw0C6sOuKAOhr7eAhxsl0oOl1NdI19FQqrt/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dycDb8fi0TX0SPIu/Ln+9omDsxnwJncMgCR02NQLuUQefRdxNjJmVV50sgVhUO2C0EketxWIRKBChryqYOzCPYtSLSaBxFm2pAbN/Uc73ut2uQsr5w01/UQzZxaRL/4gHQevAMpFYQ5yf3GhSLu92o6kBy4z5pqOiASJJmGLlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a306f66e0so27688185ab.1
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 23:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712818464; x=1713423264;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wh2SeL86wROsTzai0/QkOnFwllZIKB3IyTZkoogtFuo=;
        b=xMt1GjCoa5LkBHTJpnrsjtA+KqIbUK06ShDxnfbfPN9O/98YqTzgUeQnGWnnUm2KY6
         TYZn2Ef863DuQ8HZHMJf5o0NLRFseTDTGVumPdf/ggdmhEaoEypiTQleXOY2wpEccGE4
         iPDBq2Qd3PkmQibTwtPaJldxdsDU6KZuoXd23wgmgTiCS9erI02gZHkePCELyhcxdmbF
         14JkA+KZecVw2ZSHjQdoOuFWbBLBFLttsk9hRioKingcifRbbHKUK6J9GxHnidSrMc7t
         p5wBbU1/CgcjKB+X8Ej/lkMoxsDS0T8hv18TPGDhwiBwnqEcAGzlxHNviJh8dvDLw4SQ
         ZTfw==
X-Forwarded-Encrypted: i=1; AJvYcCUuVVBcDgmlvzl3rG8kjA8FEI3ltjTakriO7GTJjvKjyMKiPu6ABa9TooqqmV+rSCR0q/ZG9HBkeFQ9kTnYxvnBMZQg
X-Gm-Message-State: AOJu0Yw1e85BBnXuBFAZdcwhhZT2nNYFSdAWu1l2DFdvBCNIdqn/noyl
	sG14kKZtwdU30obje/zIHGFeDApFGMORyArNaSFmfqOqCcBuVlLsfEzTarH/LTNZBtcAXPAG5o9
	jWfpF67L/Hme2s7fwzEn1kqEZmJIa+nJeXrRgmLB236AB8bKhJYutZu8=
X-Google-Smtp-Source: AGHT+IHPGzP3n9fEuDJwbACOXpIYhBr2w+0My2oYAtBtUE06Qva9lF5h3iE3eCd4y91whEkYc52xCyXYNjX2qmRVXH1cgpUSb30h
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1806:b0:369:aa8f:dc95 with SMTP id
 a6-20020a056e02180600b00369aa8fdc95mr348492ilv.3.1712818464046; Wed, 10 Apr
 2024 23:54:24 -0700 (PDT)
Date: Wed, 10 Apr 2024 23:54:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d51190615cca0a7@google.com>
Subject: [syzbot] Monthly bpf report (Apr 2024)
From: syzbot <syzbot+list429d82c8ab7976cd21b4@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 24 new issues were detected and 8 were fixed.
In total, 34 issues are still open and 219 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13092   Yes   WARNING in sock_map_delete_elem
                   https://syzkaller.appspot.com/bug?extid=2f4f478b78801c186d39
<2>  11661   Yes   WARNING in sock_hash_delete_elem
                   https://syzkaller.appspot.com/bug?extid=1c04a1e4ae355870dc7a
<3>  8530    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<4>  6100    Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<5>  4928    Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<6>  1115    No    possible deadlock in __lock_task_sighand (2)
                   https://syzkaller.appspot.com/bug?extid=34267210261c2cbba2da
<7>  731     Yes   possible deadlock in scheduler_tick (3)
                   https://syzkaller.appspot.com/bug?extid=628f63ef3b071e16463e
<8>  414     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<9>  353     Yes   WARNING in format_decode (3)
                   https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<10> 271     No    possible deadlock in sock_hash_delete_elem (2)
                   https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

