Return-Path: <bpf+bounces-62472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB7AFA0E8
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C48A1C2126F
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47E242D64;
	Sat,  5 Jul 2025 16:02:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428320AF62
	for <bpf@vger.kernel.org>; Sat,  5 Jul 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751731326; cv=none; b=R1CoqyeJnAbdF3j3jKNqCE8k4bnEAp10OdADZcqBDeYkQueoSGPshDpvxAxkSH2rmmEl9jkzJgNlYrz3vwN2Rysz0PXSGWMFegEpaCSP+YHFPUu1QuZ9Xxl2rqm3ZRqb//1VD3mzwd2M8p25H6wrs0zSM7S/AX8NzwVEwOD+wNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751731326; c=relaxed/simple;
	bh=dMygeV5uoVdCI7txzJ9X0V/8gCPQmtr4XJBXZjoRBX4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qjFhL356hO9nwn/KEbi+Rw669Bf4DuTQBNXj1lU5TPb9K1XyKRk0BngCDikNHi8C1ZLQpXNdFLnQ2Df0EIwqMV6EGjuY7twckFmVSgt5nsc7xR/UhNvsFvZ8+Jab8Smn7eCHdUINDSuvYn+Lc8+pTWQkLr/HXECSEnMDRe+ckp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso156440239f.1
        for <bpf@vger.kernel.org>; Sat, 05 Jul 2025 09:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751731324; x=1752336124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ39e8xu9v6JpQ+2Z+vLYy6QZmlP+uXlVIaEn31Hh7g=;
        b=WXbp5qbCw2j/RzOrTUWRdi/56wucOPzSCEnc1NmAzHADolT9tY6tviKk8Fnp0esSXC
         WwwQXQ/C4nEmPIqaiZEbEiL7tAAJnY/PDOw/qpzJ5NFPUXEu3bH7nZu2tgNBbK7CdiuT
         I31ZR/mKMIEB9/MUOMJwHLYI7tU7AkD+ReIa1oi/vyBJB64TwYt1xa55ParylJfKRsfi
         6wBLOfQ03no7h6RzF+Xfk9Gvg75qrNxzuQCFRdQcuC2zm/bE0ehm5X4OjPrskX7GVqsi
         xC99Pfft9MTp1dgf3O1TMbzCS6q0Ut7EFFNBiMjcyqdYsna2JxZptjHnUKFLs5R17MJz
         0MnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW08VDWjsUQvaXfJ4Ll1z3s9igkIQltNjIxxBbJPHnx+1rdi9pLy5VfzVxUL523Jt7L3y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAxF6VbOy/fxleXS9NIs+KyzWuC2dIkQl5RQS9XV7wjnn3evB
	DXhq/ELqsJQiy06qaT+TsAxPq7RO47HB7QMyfn+D8gjBfC1Ie4ZBDn9W0KcWTlJ/yfsWEbrmBCp
	i/uOI2Q8LWqxS+zPI2GsWctvWmwIVI34DX1l7NX+xputMaXyn4Tr/jaC6GZ0=
X-Google-Smtp-Source: AGHT+IFi8tBZCujWe9RK7k1QOcV+G5qEXxaVcUaY+MeQA3ot4H19x1QqbDxj186yZdLFiJOHIA0EirwQgzraSfb+lrOOnbAkPyxi
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:3dd:f948:8539 with SMTP id
 e9e14a558f8ab-3e136ea4c01mr55847905ab.2.1751731324130; Sat, 05 Jul 2025
 09:02:04 -0700 (PDT)
Date: Sat, 05 Jul 2025 09:02:04 -0700
In-Reply-To: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68694c7c.a00a0220.c7b3.0042.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	paul.chaignon@gmail.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1693cf70580000
start commit:   cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1593cf70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1193cf70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1594e48c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1159388c580000

Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

