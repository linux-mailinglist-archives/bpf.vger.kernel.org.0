Return-Path: <bpf+bounces-70791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166B2BD02BA
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 15:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FB23B88A2
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763C275871;
	Sun, 12 Oct 2025 13:29:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB22566F2
	for <bpf@vger.kernel.org>; Sun, 12 Oct 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760275744; cv=none; b=arS/iD8af7WG/H4SwEGXuMAF9RQA6RVzNP8lLc9Ldr5Wgh3Y3I6lhZh4AnM95QPzh28SJVrSs7TmwQEcd0cKH1UQoPo9aBXlVunLPkCM4SgM7v6ji/utMndWRUYk+dH9fFiGbH8NSCOJsrGzKL83zUYMzdqMkAH89pIdZKMbKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760275744; c=relaxed/simple;
	bh=irl4flsspEWqN2JbuaaethEiXG2Hm1MSnwEfJJSjN38=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZAwMY75dshx7bLWs8QPBvIHt99y1H8FJAMNG8N6r3YVM5GdPNzm6yr+HwijE5nMtdgWuypeoiOH2KVXaOfxRTMquEZD/6IgQSIYjLhaM7Dtdfj7CFYEgZjrcuLmhKvpprCjuBWzdv9gILpfeCz+vBIMNXbK1PYnhw9tiULooxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-429278a11f7so100808255ab.1
        for <bpf@vger.kernel.org>; Sun, 12 Oct 2025 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760275742; x=1760880542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYngBb1Az4lSjC0yPY2rNk2hNyxaE8GGPWbiAnbBpFU=;
        b=ErCYXOfMa1nI0G8H66hpTaMN3mrvBO2GLOGcCV7zM8r59u3x+VbhC7I5k+cYJo+FAj
         33Des40lf1OOA1HgiYB/HxH33PIPECmaqDPNqFdKvZnMbm/UoKSYReGE22nYj6er1weU
         kV6N+XiuIjB17Wp4k6KnZRFfVpvgxLLiPETaABWOyqPp3vNhRx2Qlrch5/kX/99VXOtJ
         XhZ3P46IrRldG6O4SPtXjQSaoPAN3C8PeYxh2d20XV2HyClDpUm5Wr+UvXBoEj/wsHhU
         XSZ+mjP4/CNeFGZskOXy+D42FcRPawHJDZYQCA1O1SnezelagljQPb6fJS3swPuXaeOR
         7PUg==
X-Gm-Message-State: AOJu0Yz8UZMCiOxE/1xvmBddTRB/vIEFXhK8Pv0Pskj0gdn5BPqX4NSZ
	magZgTzXCo6TlQ62CNKk9GqbcOble0TKKeXAdM9bnFMMJq6ilNqhyvCykX6YgW0dy96LHLYm7/Z
	PYNPaPOL3bM760O9qTcUrMqtR5S4An9Y5tayhC5T2Ovtk9Y3WQBPJMpyofhE=
X-Google-Smtp-Source: AGHT+IEJIqNbrGsfblcj3SYtGHu8r6eHFjXqm+qPTuTO7lF+OSeoTjD3z2vlKvgCnXOaf4G93JSCp5DPqRwnYuhOzXtq9nrduW0k
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-42f873d62c7mr206252075ab.18.1760275742364; Sun, 12 Oct 2025
 06:29:02 -0700 (PDT)
Date: Sun, 12 Oct 2025 06:29:02 -0700
In-Reply-To: <20251012130418.49730-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebad1e.050a0220.ac43.000a.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/stackmap.c
patch: **** unexpected end of file in patch



Tested on:

commit:         67029a49 Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14465b34580000


