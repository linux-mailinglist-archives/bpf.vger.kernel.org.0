Return-Path: <bpf+bounces-40479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93226989373
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 09:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AC4285DB6
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 07:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76FB13B2B0;
	Sun, 29 Sep 2024 07:25:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B352F9B
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594704; cv=none; b=DTvmL4ym23dGusXVobPJ0R9g/61c2o/xKmDVeVVbS1IODBOy+QYfrYF7glRbRDyQtotUd2y0Hi+s4K+UyWJ2OorPB8uvHkCT447LVaEm4LEEFSfPJpmQ2pG/GkGNSRC9YZnWosdi0iV51lcuzjs51yrVKL/JHLaTVZQbxjxb+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594704; c=relaxed/simple;
	bh=QUQFLsgcakmOxqNIX/ly7cXSo4bace+PZlvi10aC2bo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fTZJa8A3ursiJAUX7XSh7j5mbrectSK7hwHJsyB9toHDSER2D5THw9qFosOBpLHLcnbhJs7HBzM6Mae5je/wSSav2ET68DGrxlbp5zPlODyAUg5X/ofPybj49xHHr39u2nqtlXevoB5wuHFpl/ibqHX7eutQLFi2TCPGnanu1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3481b26d6so18374025ab.2
        for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 00:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594702; x=1728199502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiNNBzBiCFuCTjOXv7t2eBGAGAquTt6DCpiBL4q1mkY=;
        b=Bwd2nc+UPmcMNM+6RYAJzFgFuOlrrkXdtrohUmMsQdpHdwPyH3VRr7/3HjxeIyylBI
         4d3iKuPLs1sgAQxVjfZDhrI3Rs+jCkWaftB1XxYirkeoQnFnP61b2N2hGXagyl0T34bF
         0qmKxcNnuTw1F9/0GKFZw3SiyoTN6s0pavV4wFGYGscvK/ORaSBjr6A/zWt1SxGmH3uZ
         cv67rapZRw20ocpp4IEPIMFcSj3EZLELNbic/NoyHfawCZplyhNl+CEruB+2t8V7FpAx
         3fMeDC7FZtIB2jjC2s/Xm/nNg/ZnZSJ0yvsRZ7JOhFHQ4Rh9vzTc+znDWnbFPxAjDfIg
         IeLg==
X-Forwarded-Encrypted: i=1; AJvYcCUBnKKYrqs2Lzv7ONMbjdR/xo5CaPemHWKs1j/D8V1kAEC0RTSBN00b/4xLbYhgaGg2TWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1dPUp1uUlGP9M74cZ4Xd2cgiFvKEXgiD3agOpfhmouTfniub
	dNV+3jonYTBIVT5zLrew+TAu7LRNvSJGgHEzjNhdtZTGsrgFBD8X4BDH8FMd9CcCDA+Z6LTXxtY
	2e0uow6zntTBiquj0bfrxuxgoFWMURVHGkjzp1HHpH4UvV1eHvCbMjoM=
X-Google-Smtp-Source: AGHT+IGsVR0t+nezjz6+3pfe6BUp37rUtReguQpi53jhig1iod5w55MHl/Xa3NwmTZ7SLsC3SAYBD2PdWw2EVHSR5Yo91lGDCLvk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:3a2:74f8:675d with SMTP id
 e9e14a558f8ab-3a3451b01c6mr78897085ab.20.1727594702296; Sun, 29 Sep 2024
 00:25:02 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:25:02 -0700
In-Reply-To: <66f62bf3.050a0220.38ace9.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f900ce.050a0220.aab67.000f.GAE@google.com>
Subject: Re: [syzbot] [bpf?] BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
From: syzbot <syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com>
To: andrii@kernel.org, asml.silence@gmail.com, ast@kernel.org, axboe@kernel.dk, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mingo@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	riel@redhat.com, sdf@fomichev.me, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, wander@redhat.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 893cdaaa3977be6afb3a7f756fbfd7be83f68d8c
Author: Wander Lairson Costa <wander@redhat.com>
Date:   Wed Jun 14 12:23:22 2023 +0000

    sched: avoid false lockdep splat in put_task_struct()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a00127980000
start commit:   abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a00127980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a00127980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ee7107980000

Reported-by: syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com
Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

