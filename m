Return-Path: <bpf+bounces-48122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A708AA042B0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5683A1CDC
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6B1F190E;
	Tue,  7 Jan 2025 14:37:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8991422D8
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260628; cv=none; b=tmS6Im7ehnR0Ex/OChgI1/KpRLKQYZGKOoQI5fI3deWamj/X1NXXjHVhN9WfedUAV9hKqAGUG0kMr+VuNXK4NBJLJUeqSirDbuSrPAn3u3VXjZfM4JIxbF5IgznkwpZi6ygp6XMtmcuTQqAH+FXH2a7q2rnO0N05a4hVE+CR140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260628; c=relaxed/simple;
	bh=/qNG/k/P+YF//AxCGiJp6BsKDYLJ+unhV40W6k25+Bc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kuTCNK6l9FjrwQ6e0fKdxgG/WRc7qo5DA+THa8gh0rYvv9sg00JCyijneHe7B3wP23FOntujrzepj80UG03IYMk1mckwFRNiAjD8NgDiGUtYleqsaYKtkW904ldQXcJtXtjoHseNWEe7ec3fzkFn6LsLvRtztOXBwp7kSyffp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ac005db65eso154953695ab.3
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 06:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736260624; x=1736865424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2116iHIqWDm9ZK538GLsLvScZAkDxZ1YqfIZyR/Bnkw=;
        b=EJAJONM9dnLL9xYynFmIdI62MGO03kwvWyl2V0VlVswyTjRfFKIqawiNjyW2HHL3+Q
         FYN1x/bneJ+ZShIB8AooykWqmxe84MeU77tuR3Pk8ewCCAQ+75Wi+0H1ZBObGnLvkM5d
         oDLLvUwJ7IwSq5JGp6Vk1aPTDt9pExGen2yQUcINQrsW8m8KhyFU0+BrgxtPYc6OzZoY
         FI7pZn0X+Lwd1PzlUl736FgX+eoTDg9oUUKHJhK7bz+Fg5vu3M3xtHATaVsD+OCrxjdH
         Uvj3apdTFuivudXyXOBF1br6GBc5BKQX0e9aBBqBDQYYfuY9r5jy6ufQSRcoisqpuoxE
         vcXg==
X-Forwarded-Encrypted: i=1; AJvYcCWtLbA7saXNR0/f/+rNzwiGtwSZ3hdsrH7eyARBU/QkE8vS8/8hhMJfwQrJg/bYVMYaics=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5kq5RHyPW/p7qqYAiMv5oUXJmvQSnQgQ2GObeIpQeUJgZoY7
	SBC6XoRmn5IyQlWMKXIMf+tteAblf3LM7TmLGVOE+iWHa1ZwMgEEXJsnWssmj+AYy5TDC6fPVJq
	MMOHjBFkmTIefn/5bOkMFZRFboc4ORNj82TvrqtSvH7Isy59YWB3ClNI=
X-Google-Smtp-Source: AGHT+IE+T8leRFXrDAubhP4Al1QTTauq/hCkIwlmLfTxe5g426XrCTe2f/QUsHT7xTDyIPIs4m5IsmvLCumOQ8biSkRtXKNIFGmB
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:3a7:86ab:be6d with SMTP id
 e9e14a558f8ab-3c2d51516c2mr476505005ab.16.1736260624535; Tue, 07 Jan 2025
 06:37:04 -0800 (PST)
Date: Tue, 07 Jan 2025 06:37:04 -0800
In-Reply-To: <00000000000086d9cb061828a317@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677d3c10.050a0220.a40f5.001f.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in handle_softirqs
From: syzbot <syzbot+afcbef13b9fa6ae41f9a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, bristot@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	haoluo@google.com, hawk@kernel.org, hdanton@sina.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, juri.lelli@redhat.com, 
	kerneljasonxing@gmail.com, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, peterz@infradead.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, vineeth@bitbyteword.org, 
	yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b2f6f8580000
start commit:   ee5b455b0ada Merge tag 'slab-for-6.9-rc7-fixes' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=afcbef13b9fa6ae41f9a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12618698980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105fcb4b180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/rt: Remove default bandwidth control

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

