Return-Path: <bpf+bounces-39901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A949790CB
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A391C218A2
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E91CF5F1;
	Sat, 14 Sep 2024 12:53:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60021CEE8B
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726318408; cv=none; b=k0VlMYAxtri6zE8fIeZ5Sx0dwFXmOSVh1Pi9it/jKATqs4X5GCO2IIzBgYIlwJaVnXzDKHL4FPQXtCJgSHCG3Q62Jd6K+LZ//SKGOLD7hldCpGwvxawRQDoA96mSBSaSx1Hq6yt45ZzaLcrH4YcLfXpaBT3j4iOO7BrIQ1j+o+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726318408; c=relaxed/simple;
	bh=x1c/B9JEwm9g84doycaGXlC6PcXPJ3MueHEJYFHIOPw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WVNrS9i1orJ4k44WX0++wu6ncmQu0MdmTdbhO/S20kzl1R/X5zovQ4mb8BiGNCI+470npBnLMgvdvHw35pWLWqv3PEKwh9g/C/sF4UNZ9QVNPVqX8b3hsW2WrNTxcDBYXOfariAb5STTIWcrb+yvXLg9oNh+7A4CKg3pWB8dbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso71842985ab.1
        for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 05:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726318406; x=1726923206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0IaeqC0xzTKfLcN35IGn0kAeoUdvSRjq4JfhcPM5Uk=;
        b=VB6IRMHmaCKdg7TlGkdWE8VYSoMOzpsObY9694EsN16nouwdV2hA+3M/8v6lw/GFeM
         PvT+t+QhF/WuYiL3YGPRWhUXAGyLpVY2uxLHpq97Jv7dNZgwFV3TaBl8QvBiL/4/wFvy
         kFaiHxhIOtlifE/OfCaCoZcWZvUKySHoO1Wq3vzuSrBKS3R2d+YGD0IsA/RomFgAH7GA
         I2D+MnaV9WZqRJRdCEbDy6OC732pG4bIUm7lUdqEtGEaf5eYneDi9BV0P9ZXuomWK71w
         MR41/XKY2V7aXPKPSYC94T9pVQimn4JgwHiL8IJokawC5sQJYSqkjs3ewiNICrB5ylzu
         X1CA==
X-Forwarded-Encrypted: i=1; AJvYcCW8+oApHIBE/w+OpRi9zwy8+YHwybrVxePSLraUUctdOinncFHet2Uu6ulZT4C/dQbq1Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEipqfH23eAH1j+BEBRRrh/w612YOxZvlEIr9Yp4AhXnG6CG4
	v10MhsD4veXxVK8S6WdcvJyFng19YyvDcjj4mDTrRo1s/fyehgOUwMsdh1fJfkhed7AlU1sRbNB
	lgOnI28fajODzGj+8JewgspoJGN5Bi/jB/E70+MlHhx0DrNNTFTx+saw=
X-Google-Smtp-Source: AGHT+IHUvMWY5osWpQCXP6DIiRrQsd6q7ToBzRZ7Azunv0aziNlR2h7wY8X0/TeDUwAboqJiREUQZMWa7WIhr5d5ms7mJYrFcrAP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a2:b0:39f:6180:afca with SMTP id
 e9e14a558f8ab-3a08491196bmr122016345ab.13.1726318405792; Sat, 14 Sep 2024
 05:53:25 -0700 (PDT)
Date: Sat, 14 Sep 2024 05:53:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058c9de062213d3ad@google.com>
Subject: [syzbot] Monthly bpf report (Sep 2024)
From: syzbot <syzbot+list124fe6638bb6df321a31@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 7 new issues were detected and 0 were fixed.
In total, 45 issues are still open and 270 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  19833   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  15949   Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<3>  9068    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<4>  1539    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<5>  230     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<6>  155     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<7>  132     No    possible deadlock in trie_update_elem
                   https://syzkaller.appspot.com/bug?extid=ea624e536fee669a05cf
<8>  50      Yes   possible deadlock in queue_stack_map_push_elem
                   https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
<9>  49      Yes   INFO: rcu detected stall in sys_clone (8)
                   https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<10> 44      Yes   possible deadlock in __stack_map_get
                   https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

