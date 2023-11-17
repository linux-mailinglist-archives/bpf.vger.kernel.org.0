Return-Path: <bpf+bounces-15252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234AC7EF738
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDA31F241E3
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19043AA1;
	Fri, 17 Nov 2023 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7FD10C6
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 09:44:06 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2839a970a56so1005236a91.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 09:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700243045; x=1700847845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBNIQ0OyWnUUYf+IOMPIqQdftw554+6MI/vYVRG86Dc=;
        b=kxhpfe8p8FRyY7/YOHBq4iWaKHB2uT8hDKLYMEKIL+weDJZwypocI9HoehI2fR35RB
         6WteGrxFwCtJn7M8fePZ9rGpm/R4DsdZVom6bQdo3sIHYAybBx7nmpH1hXqc/t2ZQrPA
         7GWSQ2FS5mlzpnj5r33YAyrp9Ak01m8ms/Vdz4ZHbjIRdMi5lbt09Ad4ad0h5tb5znKS
         c2C1CpVIMw4TTkVET/+UWM0SKNVz80YDUyB6gvpVZnvIzAeAZeW0ySSyk2dkOi1HHPDk
         pPRw6txbgboMmuL2OUoe3j/Ogjr7A/4c9ormD5/aaEVC5sXl3DyoacGRdrt1AFx2cly+
         iZ8w==
X-Gm-Message-State: AOJu0YywTo4+JvZ1qpRgaCJbwGKVGQut6m6qW/Om0fxipOfAAKagx9O4
	DnDENr643VYptN2AcwgSbV60fLzLQHTYTogdZxQBW7DPt10c
X-Google-Smtp-Source: AGHT+IEGvinZzZUXWT8Abzqsa0MheB9XXEtJaQ6LA8XenYwwcXM2fxrpX1ls5/LOD52S1ncv/pPluiYNAaA8RLBBOot8+6XLgCqU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:be03:b0:27c:f438:70a4 with SMTP id
 a3-20020a17090abe0300b0027cf43870a4mr26773pjs.5.1700243045768; Fri, 17 Nov
 2023 09:44:05 -0800 (PST)
Date: Fri, 17 Nov 2023 09:44:05 -0800
In-Reply-To: <0000000000009cd5bc060a430d80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c667ce060a5cae75@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in __lock_task_sighand
From: syzbot <syzbot+cf93299f5a30fb4c3829@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, boqun.feng@gmail.com, 
	bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, longman@redhat.com, martin.lau@linux.dev, 
	mhiramat@kernel.org, michael.christie@oracle.com, mingo@redhat.com, 
	mst@redhat.com, oleg@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, wander@redhat.com, will@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2d25a889601d2fbc87ec79b30ea315820f874b78
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sun Sep 17 11:24:21 2023 +0000

    ptrace: Convert ptrace_attach() to use lock guards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144ac400e80000
start commit:   f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164ac400e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=124ac400e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cf93299f5a30fb4c3829
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125ac3c0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c4d797680000

Reported-by: syzbot+cf93299f5a30fb4c3829@syzkaller.appspotmail.com
Fixes: 2d25a889601d ("ptrace: Convert ptrace_attach() to use lock guards")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

