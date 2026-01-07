Return-Path: <bpf+bounces-78064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62274CFC6AB
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 08:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A10830596AE
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5128506C;
	Wed,  7 Jan 2026 07:29:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DC283FCE
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770966; cv=none; b=gTD6xope/YfLm71IeHLpAdC0VKxTupeMzv8k3njR8lsnSkmeyMkrLr1somNxZ6BKJdxSh5cYjtxjLaLNdfBajMP+IYhHkGWEoolh/MexsCTuMfxiIx6FvAPSZAX6jdAkwkYEOuuBWtk21GmKqinIcmNhQBYHpyjxmTeOhExjZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770966; c=relaxed/simple;
	bh=oXZ/VxxFvoRTH/Hdlj7ntLkVgYqF1VkD+JkzH4H0f0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rqtRiiPua/D5WXgU1aAfM7pFjGxt25a9EVMt84d3wLQK8sQVazih/juGKwiIP/ddUMp+sBKtHvwgWlObaTxXOgSRSNd4q++CjiLhLWg6Pobme+75y7N2Sr8oF/f52YNi5mA0YfPVvvJX7pbcppbk2wLbgdW53RDhhdmZ3Qfq6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-3f578b8136fso3344223fac.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 23:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767770964; x=1768375764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBNQlFSpOWikq2upNZ347sFpZ5DDCPFQ27sxi/uRBv0=;
        b=X+8Lom6eYUHATlwEKHwJ1Kw6OUFR0E99suUzGlwTzJttkpoxduENo13Kzf3FHg5ZVk
         F2D6n3j46dSUjX7txGQLkXDV1Rm93kipXyWf2atSeGWWPqUDY2lqtXn52YeWJ6qeB/ew
         taX5TXMsjqXje8l7LdDsjkjQkY7AaqqvqGQUQOHWOY8zwEkb2oifuaqcv6UoIJcyi8aL
         qb/882gpzHzr8En6E3bvaw7aSPRIyvA0PLTxJj0ctpuGDTVj3gvXERA02+Xs+UY9TJrH
         3pZlE9HoUElwOY8aCONts1mW5p32uFXaeE+m3frTUoiJR7iHAqZKBWcbD3k3I1tkjeE+
         K5GA==
X-Forwarded-Encrypted: i=1; AJvYcCVIKibxMqoJVWH10Ro0T2KTxPSs3igqEcoBRboL1AVFlbpX6w7H6kw6woKWTfZkhBWjMQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7htzPo/U4hx330RIoUYcG9fiv3IhnwO4I0gCQHJDfzJ6m84V
	JhORqAy6nHgQuoQnD45HQMniubbgnRoXsTCSFfIPmbOLtgHEQr8+/4iBUnnjRjObmuIWhHjJhyQ
	I0uqZ8tTY/IbA5Un4veQTR+15tAuxOAeWjJrk7w/VnmzZbaxWGWdNmtFugok=
X-Google-Smtp-Source: AGHT+IEoiGwPv4xtw8wzEKNctXlrYznqAJM+9nMBEr3S4l2wo0fjXBm7iQcvvCs2AVhMJVbsuUurNfoyL6XpRzgwDKbkrvjWvOXk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a9:b0:659:9a49:8f9c with SMTP id
 006d021491bc7-65f54f08b59mr652901eaf.21.1767770963918; Tue, 06 Jan 2026
 23:29:23 -0800 (PST)
Date: Tue, 06 Jan 2026 23:29:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e0b53.050a0220.1c677c.0358.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Jan 2026)
From: syzbot <syzbot+listb163e051df01405c9eff@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 6 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 316 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 12832   Yes   WARNING in reg_bounds_sanity_check (2)
                  https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
<2> 101     No    INFO: task hung in dev_map_free (3)
                  https://syzkaller.appspot.com/bug?extid=9bb2e1829da8582dcffa
<3> 34      No    KMSAN: uninit-value in handle_bug
                  https://syzkaller.appspot.com/bug?extid=ba80855313e6fa65717a
<4> 29      No    KCSAN: data-race in __htab_map_lookup_elem / bpf_lru_pop_free
                  https://syzkaller.appspot.com/bug?extid=ad4661d6ca888ce7fe11
<5> 21      Yes   inconsistent lock state in bpf_lru_push_free
                  https://syzkaller.appspot.com/bug?extid=c69a0a2c816716f1e0d5
<6> 4       Yes   INFO: rcu detected stall in task_work_add
                  https://syzkaller.appspot.com/bug?extid=f2cf09711ff194bc2c22
<7> 3       Yes   KMSAN: uninit-value in bpf_prog_test_run_skb
                  https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

