Return-Path: <bpf+bounces-47604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214E99FC3D5
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 07:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CFA163C6B
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AC1494B2;
	Wed, 25 Dec 2024 06:55:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9835A7B8
	for <bpf@vger.kernel.org>; Wed, 25 Dec 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735109705; cv=none; b=O4PqFWp0Ky9o5Q+LLOLlZPL85t6rJGzFAiSl1/E4ZSt1qW3vHamzWAVhNrFK1fT5NbeZ7fPp2f/iohV+YF4HvqS8Kmk0pVvF6WcE4sGzVZQ/UPpQStW0dZ06s+vw01uydYJm+tJZWsGxapeF6/rZVX9dk+QGe/aJZXwKo7iCsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735109705; c=relaxed/simple;
	bh=vCtH0xKpkMLyYyOdDBDic+pLd6WKYQiYK6ZqajPoAa4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QawNQszNzSBfL9TR81d7fEjX8ARZ22oC0OWFdgxgQ8GUmx7l/SqPGmGBGSMtOS9NnKFi6iZpNBds41+8tiLGNBTYb6iZ8OHsROTr4PTgVs8hRRNwPjFki7A44t4RkxMEjoRKPY4tyIjRiazGjChbBkhfNDXZVkkdx9zp813lsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3abe7375ba6so104982675ab.3
        for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 22:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735109703; x=1735714503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta082uJJhcNZbV4mjW5xLMJwbMmb81o4pqVkiCohDVw=;
        b=mlm8EAQfDvFgYTlsck5G+1Lu0i13uQZPjCas8FQ1nzJNUxFjcMaxM6Uyu7qah3TTI6
         6jrckrw+BvUwxC64QSIEb3EfdNyr1P1u9lEeIsn86dxYcJyfbprFeDP4cyrtINMpgG8p
         w812zL6+cYSS1wy5hkiNWWTFWExqy4m68b3Q7z/O1fzHHGhXw32FvV7QFC7y+2GeaNrZ
         ODTOS8icpoUpJjFxDg7g3Fe/O4UfOgLmw9W4ZD7bx6DdjnsLrt52VoaWDPfVTukIaJbu
         0hMqpX5uzzpSqDxp1YTgM9DUqJXAXOYmhJFcNRUrpZ5HSXCppGHMFWXQa66+6rtz7R/+
         EnHg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+Ub+k83TDhYHXAd3TZqPUV/gjvAul/bsa2W5GCSI59VwL7KjWYfUy6bVWCYwKsVI7GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNZHvkh3gAX98zUMgkG1f8nxuFY4u31rFtbXHu90C6TNe4rS0
	MCYVfP07IgGuG2ODfQ5ezduO5mXusRVFhJW27wPRdeeC1i4yXS1rGSSnNoAfCypJoP80QF9eusn
	R9R8s8Ru/R9qDH5+iMiqKvdYW5LJHO4p0/LHNzbNKsvd4BE2SZ8gbrsc=
X-Google-Smtp-Source: AGHT+IGo/mB++g9H0Iiix3YzJTvrTK6q3jZQ68x3nvhK+kwg0PaPNtGL6q+kyKROY1b4wvaDfpyggNUdRK7wtTg93xxG8D6obP0W
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e9:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3c2d2d5164bmr159902725ab.13.1735109702902; Tue, 24 Dec 2024
 22:55:02 -0800 (PST)
Date: Tue, 24 Dec 2024 22:55:02 -0800
In-Reply-To: <000000000000e7765006072e9591@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676bac46.050a0220.2f3838.02c0.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in task_fork_fair
From: syzbot <syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, 
	daniel@iogearbox.net, elic@nvidia.com, haoluo@google.com, 
	jakub@cloudflare.com, jasowang@redhat.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, parav@nvidia.com, rostedt@goodmis.org, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ff91059932401894e6c86341915615c5eb0eca48
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Tue Apr 2 10:46:21 2024 +0000

    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e922f8580000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128b2d33180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe01eb180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

