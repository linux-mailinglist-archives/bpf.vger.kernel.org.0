Return-Path: <bpf+bounces-34821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BE93137E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B108A1C22538
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC918C193;
	Mon, 15 Jul 2024 11:52:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD518A958
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044347; cv=none; b=YkFoAO9RTDhLHSN/lIPJskWmdF+mO4uH6F2wTskpArsBjclLXWUNbRoSRoqz19Zz5XrjbaWypAXEGHTPmT61EhTYSu14zkbdpX3VyeiErn0vWjwwxgBGY1NfuItnUd9WArGmZhXgWtUtadvagQWlzFfH0WgAG1CCm3eR4YkcMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044347; c=relaxed/simple;
	bh=diIkvLPLDk621MQUgXDoYLDnPu5UDhuEInfuGBiLta0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iai3Gzu5HFQWu43aMgq681xDZfKXlEtUiBARmbguIfOOGHxl6BmtAnv6Jg5YEAG1k2n180nYH4A9ooyvlJ+xYo+6ueYP+oAuGlVcqFCTaBPScQO848KXzkB5GDf18jprZ0IdwDgmFOYlycp2SMcRohRKQwyxpMv0srKjzk9E98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81257dec573so133993839f.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 04:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721044344; x=1721649144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akbEEO5eDMgzVWGCcvmROY2hRDgzwS14XNZ5oBf1+cg=;
        b=GQdfvCYgdpvPEwj2CMDDlxmzl10p4/zGv9FfNyzLZ7lP2W/jxxn/7olSKAOkiFo2Cg
         QmFY4QXJwbbQ8Ie5GY7kvVWhoGDd7qRdM+oaWvzmlS8j5LDF4bbIlt7w2Zhv6BL40TBZ
         RCaI1AAp67YTYYRmlgCxTV2YQaEnYkzj5J8m39GbbzBL5kNh48VSJqcCEcKuRhxyA4vG
         hv4pV9p2kBE/4Sqs9W8OqALzVdHVJSMf1z5D6LP8FZKQUXYm6IV5hTwzyPK3vpx1CNC0
         sZXIPbKWi5/RPK63cEp0NQysHdJPcVDPfKz89txY/bGCqlTBFR6E6VntjkTKgBG99RiL
         IdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrYx85HYnGSzUw47ilAv6yBTaXzACXDbcvtysKwP0c64qiBgAP9z+Bi02HWaKVqPBrOGq5iSGKDy4J7X+ioETn+Ta2
X-Gm-Message-State: AOJu0Ywxc8LqcWSw/DyeI+ZlQujwTcgT9ocStd6trE1k3r8KmVjl+M8r
	BWFvn8qOf52MCoiArMtQTypNYsx8WIiz2jgVrG3OiBS6Jn12Gsu5j3Rr6QrFchaByAhwKeGdpsR
	2QWqehhc74w74dnuJKLiLQgYk417Zjl/zi7O4p/n3uImWqEW0mlfnato=
X-Google-Smtp-Source: AGHT+IGbO8E7xzqfGGCF4bOhniymNQ6wQMjLxQgwbzBzed/SnyWB802ButKIujMhzYIKYVew/98ZKs8CLCbAdG91B/tufBuj89U3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2486:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4c0b2999752mr1398314173.2.1721044344440; Mon, 15 Jul 2024
 04:52:24 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:52:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb15b9061d47dc76@google.com>
Subject: [syzbot] Monthly bpf report (Jul 2024)
From: syzbot <syzbot+list0338b242d2eaf79f8dd5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 5 new issues were detected and 2 were fixed.
In total, 52 issues are still open and 256 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  18263   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  10705   Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<3>  8741    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<4>  1396    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<5>  966     Yes   WARNING in format_decode (3)
                   https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<6>  803     Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<7>  144     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<8>  110     Yes   WARNING in __xdp_reg_mem_model
                   https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
<9>  108     Yes   BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg
                   https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
<10> 84      No    possible deadlock in trie_update_elem
                   https://syzkaller.appspot.com/bug?extid=ea624e536fee669a05cf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

