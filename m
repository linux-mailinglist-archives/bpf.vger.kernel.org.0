Return-Path: <bpf+bounces-17183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E6C80A44B
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 14:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3B0B20C91
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829181C6BF;
	Fri,  8 Dec 2023 13:16:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55D91724
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 05:16:30 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d83f218157so2722161a34.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 05:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702041390; x=1702646190;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1ZnogWDCGCEoUA9e+jdzgHOyFmOK6aq9lqo84rsReo=;
        b=bvy/aBIjG0Q758247XK0XcB+/FcjDAiNVnH+4H8yMYdctnP8wBIq4lyoPbjtgZdVrP
         HGS0zSEHIL3dZKSReVGXAg6fMVd3S3RfVsWz4s/LpaX5zHg8xk7Mw7+jzOVC2/Ec7MGF
         wAjz9cQlla8vmdvgX4PHToCy2KmPSmn3Gf8d6lA6D8bBX6Z2BaJVJ4Lr1OFTWmOUQ1KI
         dHl4P7CiVg4YWHUF1qobOglJZoUodymcoISw1qPPCyBKUWhcoMROOj32eyrPxYJjYivi
         xMGPCYlHgJavqBia6Z6tkQArFUlIgjIy20MN/gjxIvKC6shPTaWBhRfZD0YA0hCy+zXR
         CzlA==
X-Gm-Message-State: AOJu0YxyyPES7O7NGjbT/LG+w+p1qydTVS+r8HaVBTkf9yBnjbPSPCQS
	0C0Lv4CPrbDFEjGx0A+rqeDFzoYUm2upt12/cCzSb9thaDR/
X-Google-Smtp-Source: AGHT+IFm89qWspx5hE1KkOqbc5xL8CVQegKBBnrK/YE6EPOpmiRKLhqfxYTT/RI+RD6RFqa8oV9hi/uPIONbkPgWG85/BxYpnF+a
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:33e7:b0:6d9:e9da:d786 with SMTP id
 i7-20020a05683033e700b006d9e9dad786mr710228otu.3.1702041390080; Fri, 08 Dec
 2023 05:16:30 -0800 (PST)
Date: Fri, 08 Dec 2023 05:16:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072e8c7060bff64cf@google.com>
Subject: [syzbot] Monthly bpf report (Dec 2023)
From: syzbot <syzbot+listfafd4fe0e0bf9b4d93f3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 4 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 199 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 14      Yes   BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg
                  https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
<2> 2       Yes   INFO: rcu detected stall in sys_newfstatat (4)
                  https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c
<3> 1       Yes   INFO: rcu detected stall in sys_unshare (9)
                  https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

