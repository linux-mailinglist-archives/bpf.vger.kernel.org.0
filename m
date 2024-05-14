Return-Path: <bpf+bounces-29711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070C8C5A49
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 19:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A87282D9E
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C11802D7;
	Tue, 14 May 2024 17:24:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304DB17F39A
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707445; cv=none; b=CnsuSkajKtLFzxbOuWx8vJG5vaCAyFyspqsC/gMpLXQkL/yvfZ/b60Ro5dItKVYSX5DugIoaAJwn/wevdTnGZBLnqQXl9wvAJllp1Rr2QAjg0mKCp5HXXDXtqENU3g8WaYY/GYcf2VFn/qc6XMUGXJULtD1QsiJ3j0mWncFmFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707445; c=relaxed/simple;
	bh=Nt7kzmwYkg3z/+qBGi8DCs/A+qqr7TXzumkpN8K82Og=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SP5+BcVzg+IesBxsNao5WjjM4Fk5iEqBfbqnynoH49pJjhl5/o6/4g6IGGQD/9WuLpWrbF7T5vM2etLtDmzxhkXLoaJfP3Smq7KzJCwkCO3mvbUvZP79p/R/qhWH0vXneZIKEF5AOeSbV0itOhg7nf7B0BuwHlpKWLNXj2pS7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1c22e7280so537062439f.0
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 10:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707443; x=1716312243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpglLF3GjUgpNPy5ZOgoKguxNCERy2murGYTeXb8VZM=;
        b=kAs7ke+l/gI4DGHn3mf22f/SLIncqSXNjX96iGwiKstsBENtrxE3UO78BZavjLwmek
         PZHM7k9wD7SxMNFl199h+2r9h8ZTNkCGXSYoE3BsrEIWRxr6tHhhbePcjEzYp288eKwH
         krUqY3P8d5Fm2MFZSKAJSaAh3b1HHBVGh45bM301nOnohwTPKwAMyzKU+36E0aLhh2hH
         v5NuA6zgQQ8OydBGhT1d/F0UJ0jq1LCDckHxnmStb+041d+r0yNYev6/SWKIL7WvqNQI
         LNWxsZlyOa8zYfL913Iw2ig8uWXsBZ3snsGFlMvJWOGXrnQJjIpOQ/JyzrldjxGZGI+a
         n5lg==
X-Forwarded-Encrypted: i=1; AJvYcCUU0DfTu4rjsrij4G5Q4vOhFYisX6lSYtdT8iFKqQCvBm3a98bKzqJC5fp1s/N5YYpYe58SMHohtei2ukX2Lb8zNBmQ
X-Gm-Message-State: AOJu0Yz8tklXghR2Ej5nstMkBXnmeDdwHniRwhO0us0udiBuaYR7nphE
	s89cDnhkxkvqeZ5MBztRufUiNfB/cKq1qmeefMPRuQR1dVrtp1c6L/zx4p+VPOol3+vnaDSlyg0
	VUbjxWuR7zH1CqxQDUT06toB+BTYw7rNmPK7iKBkJV4bO9KhF+tg0GEs=
X-Google-Smtp-Source: AGHT+IF7QyGQ0xCvHt8AkBxfvj8CQW8ltH8uSHctPuqZV3eCEXXtjchifDfUzLV819WqaFCCzSoRSIVR71AXYzbJTHGO0yUWEznq
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c11:b0:7de:e1c6:c72b with SMTP id
 ca18e2360f4ac-7e1b51991admr45652839f.1.1715707443527; Tue, 14 May 2024
 10:24:03 -0700 (PDT)
Date: Tue, 14 May 2024 10:24:03 -0700
In-Reply-To: <00000000000091ad3106157b63e6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5cd8f06186d446a@google.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in jhash
From: syzbot <syzbot+6592955f6080eeb2160f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	joannekoong@fb.com, john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9330986c03006ab1d33d243b7cfe598a7a3c1baa
Author: Joanne Koong <joannekoong@fb.com>
Date:   Wed Oct 27 23:45:00 2021 +0000

    bpf: Add bloom filter map implementation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13412248980000
start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c12248980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17412248980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=6592955f6080eeb2160f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c0cad180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11faf09d180000

Reported-by: syzbot+6592955f6080eeb2160f@syzkaller.appspotmail.com
Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

