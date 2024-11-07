Return-Path: <bpf+bounces-44296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621439C1090
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937181C220BC
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61B2194B5;
	Thu,  7 Nov 2024 21:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED112194BC
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013205; cv=none; b=cVnTmRAQCgnfrX97jHKP6+8b2C9xEwGldweL1FW/bJ++3BOYV96+AID2ezMyet8DzErQUc8li3/EGt9rOdSrflRWzL6sS7a27P0gwJLqegaynBiwjjh5sAX2kfYgW0TQEl4W4XWDrsKJ2kdOA5gxj3a0YKiAZCooD4oZcos4SuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013205; c=relaxed/simple;
	bh=evuAZfwARYeCSa2cm2Nesuv6RzOCU1uIBVESmfQXmVQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=URKp7KqFF7WytuQjYnn4fY9lX1Y5vz0yXi9rGZ0LO7yW5pWbqELYd/VDdz9dmzAXmy1eyT6ETSbHUTHfaCRF0CnjX+xtQSyetj/vqf1dbP3iTskW23JEIwl+u+ab8da1BHoFA7gfcQ5bXCYwc1N83EHVoVzarEOOfisti/dsWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so15998545ab.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 13:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013203; x=1731618003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTrEnJ1xflwqCs7uDGssRRRQgcKDE9FD9zPoC4Iw7Y4=;
        b=OEcK6Hcz5Hn54tWzaUJAWwfo26G/Z46ctX3e7+b9psUwynAslakrwR3IpLdoCzDRKn
         czYBnPF+6CPkO2H8yzk7QGpN95mME7raiWH8shKF+NSivFiG6R3uPoDxSyr5RCcIs0aM
         wSYywCWoZdFYfGukZUpeMYdg3BtHQCwDQbP4QBazi+nVTHxlI5W1iuAM09nquU4Kazgn
         u3ZnnbIPN+Jsug5izfT6AETiXYVG3S5CmAKGItRx/u/PCJceS0Yb0fhQFUmh4/NRHrKW
         wLDBAxaE/VBVasjgmMVUEoHK4YeDuo6yaQ/4Wm9trZIqoPF7y/BH19Q/H+B5j7Bd2zNm
         zmEA==
X-Forwarded-Encrypted: i=1; AJvYcCVQcM219JsoU/uzcU1iQ1ZoUOU23XVOaIQcuvOYoNwTd7nR/zk1/++VDi8UlS0q3QwhRnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsp8XR1tgqGyGeExPbb63Lh1N1UAI3NNTdmQ8egUst6rrXKiF
	C/VOu0DXagkZakiZUOaqD1cnA3kq0rEKInzt4POPO8r6cW4neBkvHfg7o41goBHaWzBSlEE1KJM
	hGU53Gu3xnOwASA7wEl0RG1BMq8X9ge5wcxNoDoj4FhU2PAIrUHJOGVk=
X-Google-Smtp-Source: AGHT+IGrBL1U6cNT6RMq6kbV3aJN0roXyvrWF8AuSTpL3ICCq+J0m2t4mi8QINXdiS9OI26x/DXouMPb0CEyyz0ge6nm1QVBqTqi
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d96:b0:3a4:db10:742d with SMTP id
 e9e14a558f8ab-3a6f19900cemr6935535ab.3.1731013202847; Thu, 07 Nov 2024
 13:00:02 -0800 (PST)
Date: Thu, 07 Nov 2024 13:00:02 -0800
In-Reply-To: <6723db4a.050a0220.35b515.0168.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d2a52.050a0220.15a23d.01a1.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in trie_delete_elem
From: syzbot <syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, frederic@kernel.org, 
	haoluo@google.com, houtao@huaweicloud.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, peterz@infradead.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 4febce44cfebcb490b196d5d10ae9f403ca4c956
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Oct 1 08:42:03 2024 +0000

    posix-timers: Cure si_sys_private race

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129f2d87980000
start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169f2d87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=b506de56cbbb63148c33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1387655f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ac5540580000

Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Fixes: 4febce44cfeb ("posix-timers: Cure si_sys_private race")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

