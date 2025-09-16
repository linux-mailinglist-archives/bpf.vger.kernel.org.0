Return-Path: <bpf+bounces-68466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FCB58C7A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 05:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146E93A3492
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 03:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9A2367C4;
	Tue, 16 Sep 2025 03:50:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3326126C02
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757994605; cv=none; b=egsCSmWabUFH6z89kNg5OtOTbgbJGswmLXpuf/HYaord61F1pM9Mul464JvsApySh21oDRA2GQHrZhiD7RmT532joKo78HqXF6d2bLEJXLjWnvJLtHpVSqGqIyxlISXk7k79YBXmdGlJcYlkxAnVHF5cL0QDsf76bAKuPySdMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757994605; c=relaxed/simple;
	bh=JSnfukqOADN2kn80OmWHnaFMqLRrNoKQAIVsV1FUMV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ppooFc4Pcn+VtZU/J86OS1PT+Rbo76GIeYFGS2ixSGLq6/oOY8sbFOgtQtqKNnPnJaH0e039QKUm0Eovib2FcbvWTbmlKi6JuatFzGKKlSSPleuiN4rYgTBRrUikkird7c0LzZqGPXqKGGlKxQdkK7uvHrn8GJ5bXCo+UdfYSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4111411b387so45205165ab.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757994603; x=1758599403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iuioZyvb9LZ0SUGtSeUjaLTUycNk5X2ZJgIMk86y1o=;
        b=fzuIeJmLcvsTPHHZB5khV8dMrKzXxrRTZGlUY0BjtqyswV3LZ+EM5h+XI2OGu7mT9G
         GsOec2NzcvUruG+eYx0VrhhMoDCyMX+T0A+RqvN7F/YU1nhLh8GIo4kKkUwQVN0GEWqB
         QV34lHRPf6PB0Cibr7YYKg70kAiC3ajgic2cgkuHpuwxjVhdE4foiqCt4miYaUGaRfQu
         WTSg/REE4v9cAeynYoRXh0y3KwUHDDqG6gaD/tAuAs6eI0EatFxDYfpEcavR6jjp7ltX
         ZfFUPF/6muikAjFjubzYAr1vDG11f3fAfASDeG1rh62ocRqkioYFw5oKidRM+o9mELwM
         NlmA==
X-Forwarded-Encrypted: i=1; AJvYcCViIko5bfJE6JHqm9M9twTc9CNnlwGZJfL8h4pc1FgW5FYP43RUoTvHiV0N6TuUVdouiqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypI5sfMnKjPPafo5nqygEV4S97whApl7i0GjjjOM1srnLWRXu3
	jm7Qpb4DBLQPilEnoHxbMUhlm9+XVeTNWU1ys79lhwV+e7rqDBNEDCC8LCPyO3hrZYirGP5v74E
	5Qxi82ZFN95v6h/Gf8vlSpVFJvaS1roS2clkDJutOUYApj9wBe0sMYHboJ74=
X-Google-Smtp-Source: AGHT+IH1Kj0pLDfdIXpjFMSEPpxwQh6SDcGPn2Imk407BqvlOLykHVEi+Jw3QKtMfl4Iqb8F/s9N2NxMiOS7ueMSjHSucVZ+VSfN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4503:b0:424:f57:ef58 with SMTP id
 e9e14a558f8ab-4240f57ef63mr14534085ab.3.1757994603113; Mon, 15 Sep 2025
 20:50:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:50:03 -0700
In-Reply-To: <68c85b0d.050a0220.2ff435.03a5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8de6b.050a0220.3c6139.0d26.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in do_check (2)
From: syzbot <syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, luis.gerhorst@fau.de, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit dadb59104c6441f54d0c42bba3e4bd11e25fc6d9
Author: Luis Gerhorst <luis.gerhorst@fau.de>
Date:   Sat Jul 5 19:09:07 2025 +0000

    bpf: Fix aux usage after do_check_insn()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13850534580000
start commit:   f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10450534580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17850534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=e1fa4a4a9361f2f3bbd6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1355f934580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12170e42580000

Reported-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
Fixes: dadb59104c64 ("bpf: Fix aux usage after do_check_insn()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

