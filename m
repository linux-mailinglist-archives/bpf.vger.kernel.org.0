Return-Path: <bpf+bounces-67798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DBCB49AC3
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499EA4E0F31
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2E2D7DE8;
	Mon,  8 Sep 2025 20:12:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9D2D7DDA
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362326; cv=none; b=Yjk74absf5/EcZZjj2n+cA7EFFSCMfcU+6X7u+cMfCnavgul9UaMqmADgxwWZKCPjJ7B5RRz1RUGwS9Yo++Nl859GLEleIyqBZNVJczCmlFBwD5iwvUfL5TOJCrcwWQnMoP5+NSBMDN+JjWZ7RsgpyQAlDIV2j0LXrmVc54/7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362326; c=relaxed/simple;
	bh=WSIoRV+4dq+La932BdB3eUBY+0kr7L5QrWYY7oF+82w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D27eIKVmo8qF63ZBM2MB8JA7w6wOV8Ca/5oY4D6c2uwE9hovzny/Ijd28WtQlqTTzvid1K0i1P+xhZsrK5S9bbKS7lgBvYFJpoLdcjWapjnBvm1tdkTynFfvz4OI2jxDQ7WXhANBXYHdr858qvY5XJ0HxRZEA2VciJidZvj0nxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88731310ba4so1330127439f.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 13:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757362324; x=1757967124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUVU0Ff8fQ+u+hL7Q5pC0b/mSJVhOT9pIEPHC3xJKiA=;
        b=VsfY7U8QMAzQQc85sRzRr8ug67EEUBoqu6pdhn0Ub1iCO5vT1KvhRFPfaGA4OZTY9W
         C89NnnW2dLP7dWsG9PAaGsmU/Za+KMqKXDnSeyRDWE4g2r8VWmPaog2wOcIzX0vf/i8v
         BFv9TZNI+CUXne5fo5xFEf+PyEcHFRZcFDLefHT8oayGaQQJrexua/Xa401WaJaf1yh2
         OgfO7gSw3ZAsM2Mxm9GNm//v3ZOE1jHL+mhQLj0vTvJMJ2qtVPSJTQAUdBMYAO4JMugk
         XR+970SKsriEb9xfz8Gsy+PLztp2biicUqC9ql7hcxmV/3hzGlXSzmEZqZUiM7BPk1AG
         TD6w==
X-Forwarded-Encrypted: i=1; AJvYcCUxS9V4Kjf5P/XHRE22xvH1ZdXUcqpTd1pIUIbUb1oFChcizdgH31EOI+T1GgKbORrEPcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkzfy5kpy+RVqFCpD9UPXyLZdfn1xjs8GUHy/sTjRSPuZhL0L
	DXt2FAlCgLbcidI5/HgKIfHzVu4VKdJ3TDWw6qiuVZaVvIG0fwgHTTO5VgY/fc9bxbp/M0FNMDM
	BDLftL1IjNaPrOx1MUMGpgAAFKQNweMaDeh0gbTvSdORGFwkbN8YrTvw2TlI=
X-Google-Smtp-Source: AGHT+IGVhC7g/XMpsLDsz/IZxR5D5A09ltN1f439U0eM0rM9IOQ0kdLoc8NU3w/85NGnunzKaEklMRswAVaqru7LxbNnoA0qcBEA
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a61:b0:3ec:248b:8760 with SMTP id
 e9e14a558f8ab-3fd94a13fc3mr140050635ab.18.1757362323770; Mon, 08 Sep 2025
 13:12:03 -0700 (PDT)
Date: Mon, 08 Sep 2025 13:12:03 -0700
In-Reply-To: <683428c8.a70a0220.29d4a0.0802.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf3893.050a0220.192772.0885.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in corrupted (3)
From: syzbot <syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, charmitro@posteo.net, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	haoluo@google.com, horms@kernel.org, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	yangfeng@kylinos.cn, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7f12c33850482521c961c5c15a50ebe9b9a88d1e
Author: Charalampos Mitrodimas <charmitro@posteo.net>
Date:   Wed Jun 11 17:20:43 2025 +0000

    net, bpf: Fix RCU usage in task_cls_state() for BPF programs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13745562580000
start commit:   079e5c56a5c4 bpf: Fix error return value in bpf_copy_from_..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c517d2f439239
dashboard link: https://syzkaller.appspot.com/bug?extid=9767c7ed68b95cfa69e6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114915f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15566170580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net, bpf: Fix RCU usage in task_cls_state() for BPF programs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

