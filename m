Return-Path: <bpf+bounces-53840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55976A5C9DF
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAB1189167A
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E52261566;
	Tue, 11 Mar 2025 15:56:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED85260363
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708567; cv=none; b=ZmQFuJRtpEzkWHm7iXboqeOwrP0wrTJTV6Lbvp+fKywDbYnCJKMX0Ji581I4Oanl55CGPNwttiW8kSSB/PZrUuJGqGOxViZg5QpnSztP4zCvzckZlWchVyb960o90ToAsKcNhHLAm1pIUDzqbQAQMdps7jFi0gkKpdTPGb4Wuqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708567; c=relaxed/simple;
	bh=sc10Pl/zyyF8BPF2JK1mZI7HV2hkrXbUl05fR/5+oFc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RZuDUGCi7zK98ck1dxLcR2zMlYpzf0PrTZoVJb8/8zBAo1ob0PK8tswHZ3xAxYTNHfjalYqQiI92UKlEw2oSxK8UcvAgenizsBRpKAk+4BmIBoSu1ujgEMaAohmeZmQeP9owEDXBSc96CjcoOgw98Ze0QVfbQgBp7M3APJ5j8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d434c328dbso94647515ab.3
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 08:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708565; x=1742313365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRrgZHOV3bUp6D7hSoq5Vx4W3eVh7jENoQ0JRVmYyRo=;
        b=ivlCqCK27IiY4oWBRTfOuqwQ1/Fal3q+FVLonCAxyKsr8YDsF05YhKvk3bvAIdf43q
         1S8Wf5PF58PhJt0f3exudFEjskYBOXnh3Fyo3PWby7EGYx91OO1aw1kZQfPZEQuCP1Ak
         GamgSEufshy/W+bTLm6HVnbD6f+agwX8ELgUlnWt0gYMtfRiHaUEqKaUujPNdM5Y8t4/
         bWjZwVmEWRI/j5rDycxbrzUovp1FCKAUgY3r+jjK7m9S8wMY/oHf/DbsCGrjmZVvaw3o
         z86Pr70rSFebW8AHEdO2GCVpTP0g6WRNEybzID5/9WwintZdKm3No86O6WN8poEzN/m7
         A8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUEaOXWuI2nreV128d8h4kgHT+1z/GJmfoZxD0gOQ35n4OvZ7ql6Qc/BzTXrKs5UyS7+zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuz41bpOfEOHB9knWt4TT2YQa/0Qv1SZsLvzdbVhBTzPfdxmk
	OlAvpF8KsrfUm54auU4zusofgCVIkkwRGztkK56IJwLoSbYssV7gxBIWvd4mJFeyoeHT2Z9zE/0
	Mej24zZObzAxy5Y7hTMoFhQZai0eEEm8bnL95tUkrnad091OH+mQOtQA=
X-Google-Smtp-Source: AGHT+IHxXFdrlN/sWn5qmnyi6aWSNe1Tfz8GvTH5kIuQ4yiObhgacWvV92BKVdx3Qc4jr17Dky5O7qoBZ1EQgvO7cpheIb/kTS5Z
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:3d4:244b:db20 with SMTP id
 e9e14a558f8ab-3d4419296b0mr188445365ab.16.1741708565295; Tue, 11 Mar 2025
 08:56:05 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:56:05 -0700
In-Reply-To: <000000000000ba5cfd0609d55c40@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d05d15.050a0220.1939a6.001a.GAE@google.com>
Subject: Re: [syzbot] [tipc?] [nfs?] INFO: rcu detected stall in sys_unshare (9)
From: syzbot <syzbot+872bccd9a68c6ba47718@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, bristot@kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, jmaloy@redhat.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, juri.lelli@redhat.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, vineeth@bitbyteword.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176de7a8580000
start commit:   45ec2f5f6ed3 Merge tag 'mtd/fixes-for-6.8-rc7' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b890ca180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154fbfe2180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/rt: Remove default bandwidth control

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

