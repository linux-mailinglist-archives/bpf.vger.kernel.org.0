Return-Path: <bpf+bounces-54587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14028A6D16B
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 23:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F63A7A32BF
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 22:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398421C6FFE;
	Sun, 23 Mar 2025 22:24:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F113635E
	for <bpf@vger.kernel.org>; Sun, 23 Mar 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742768668; cv=none; b=MVKdY0xxdQDiOZK2Zec4cH53I/9JakT3xa9oMmbHEUbi8FoodgKWbJgMALN9AEnVDpFMjBRYZ3Sv2BLVVXnbdE7+pkIOLn1TMguID1eiBEB3P3yuh/fKK1M0m/ZHldiVlseNaAe3Lr0MsTmQvflxlOBUYiMV7i43wagiOkmZFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742768668; c=relaxed/simple;
	bh=BEBfxi84Sx+LWiMfPgSqol8/dVxJ/6WfZFAZV5OkNrQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ieHvsWIIsX03YTXMK9wOzicNccpovSROGGt1fDOfatHNK/eD6d62rihdyOoMTkTh+EbmomCQeDe7JzbgtqImio+6XLYvt5483JYF45p2eIt23VPzZauEGxDkHbmkFMZx7787KxUAGjLiA+CP7afFKYg8lMSY0B1E0mlnFXxBcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d443811ed2so67639825ab.3
        for <bpf@vger.kernel.org>; Sun, 23 Mar 2025 15:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742768666; x=1743373466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8SHUbNy7Bs1Yo8x58aYTf5+tCG6xrViHLpd6oKIB/g=;
        b=jBQIdiXIu9qzGqdm1wJrP8a/+oqmuFH5S4VhJ553sGPwnMgQ3D5YtzQGp44VEnjeN8
         bNdKeRix4pw4xPpfEH6t5liAPoD4cKYO70sDf+CnQEvCHzKmTtTWFUJH6u04EjFtkMUl
         JEoNlyK5bJ0zkn6rEwuTn4m39diiRejzxrsNUVo2/carLSNey3pBNuXdCw22BvIqBt4V
         ko46TyHdQH2PKO2bUdK2e+dh0N0qhTdKtRt5L0Tvph3E5VHxirEuI427zQYF4+dRGeyL
         ozzVb9meJIIgjpK5f7hYmJmKZYe0q2iFvW/dUMYGAbdsuBkOa9/6h4QBpyM3GgXbR/Jr
         pyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLRw+1fluZ0Yid5LH8drs8CufIWgBx68MNxp3cU7JhKuVpq8NNRY03XKURvseWJFmIUKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBTGP9I1m3W82ZSlrXMOUnV4ZMChYD5TgoS7joc+CvJAgrQAo
	0HPTNl46zj6M5GOgwDEtdv9hMIo1htSPezExGWjrXswnEWeYIgMkGLJCpwLndWuuYH0pgRFB65Z
	zSP4NphEpra+BthiHpf1SlBZSvgYwodlsUFfSEs4EAzdegYUMcJR5b90=
X-Google-Smtp-Source: AGHT+IEgk/+ut+LYjpCks0O3waQ8ZdvGtupC8gp6xuLrneppz6wBtvnkxpFJkf05t9LxA9VFwehOxxV6AhzrcIsTwOL87A0ojOCY
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:3d3:eeec:8a07 with SMTP id
 e9e14a558f8ab-3d59613e5f2mr122306025ab.6.1742768666459; Sun, 23 Mar 2025
 15:24:26 -0700 (PDT)
Date: Sun, 23 Mar 2025 15:24:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e08a1a.050a0220.a7ebc.0004.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Mar 2025)
From: syzbot <syzbot+list3422dac14361a02f01d5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 1 new issues were detected and 1 were fixed.
In total, 29 issues are still open and 282 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21440   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  2281    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<3>  2116    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<4>  242     Yes   INFO: rcu detected stall in sys_clone (8)
                   https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<5>  178     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<6>  78      Yes   possible deadlock in queue_stack_map_push_elem
                   https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
<7>  68      No    INFO: rcu detected stall in sys_sendmmsg (7)
                   https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
<8>  56      Yes   possible deadlock in __stack_map_get
                   https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89
<9>  40      Yes   INFO: rcu detected stall in ip_list_rcv (6)
                   https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd
<10> 31      Yes   BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
                   https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

