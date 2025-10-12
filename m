Return-Path: <bpf+bounces-70793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5BBBD0367
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91E83B6D6D
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E328504D;
	Sun, 12 Oct 2025 14:22:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988A28469A
	for <bpf@vger.kernel.org>; Sun, 12 Oct 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278929; cv=none; b=GZVN7mUtKpDlMbRadIRI9LgHspHvZlFBOCTV10NhlnmDLpITMAnZertPsF5xoeI0xo0V/ZdgXAaCVbd3JSzCtKvHCMaJMghPBPP70XCUPB8OK4rxI8/6B6xIiqv+SODM2qgJAa3OveSUmy/QMqnJI0cBduB2+EdPvFW5nl5miJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278929; c=relaxed/simple;
	bh=9pESG64miPasLo7bV0CQgEu8LhHCXPWVa/VPYfrhM1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lNCHUlin81NWRjDLUEbde4YIDLXG1z8cBJCVY2la2KigsBIuZw+f7EdkI2M3GUDxn/U9tR3P2d9CMgfY4lXSnl6zVGMV92eYZ7re1EIe6D7sDvVcm4IKuQ93MsTktXizBbqeQ5D84RTJ5+Srun7DHE2GTosPzwK5tyq+aPoOpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42d7e4abc61so124934135ab.3
        for <bpf@vger.kernel.org>; Sun, 12 Oct 2025 07:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278925; x=1760883725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0rSnZy6IeqJJ4+YGSwK6X2T8neJu8Zh87YZ79NTSbY=;
        b=LN0ALWQMkgrRHdPIdxG5V1x6/zl/7OKJR4usJXif1DlhtBZ7jiaVnKnDe/hIYrflgJ
         QFQ7vk5GGy4D1SnWtru6YUCq/Ra4+6a0eqA671b56yuYNcI81J+c8fjefA2Ux0xwMb+a
         AmLvULScxsGlvypjkIYV/SbTnXWcuWwzYA7xVhaF/X+wmLvD9qYlTeekYG7dbYdXhirH
         4s/rydm7SPxYsW+zfotqKHl6KXfo4vEktyuitHzvyvb5Howc2ZmpBGpEphvHjKx/6BsH
         Z5pBaiOOw0XGqVLVvoBolzW1tIis2r/XiuAA47X+SwQV/Blr5/C8zUHRnkAHQu2xY1A6
         WFZA==
X-Gm-Message-State: AOJu0YwR9q9055LhjwqJxbZTpEBcx5EZH2UAupU/MMQUWDzd5OGGygCd
	pf8L4JjheZNz93092Ijxs/yaUtD+xgFYDktYn1IE+/XZqOVT9mPSrILXo8u0d4371vVQZibDDEZ
	Wlbni1+Z4ncRiIo//+Z4QHpElJBCQzMd46MctLrv8F0DN+Y0sbcVmGHeAIfo=
X-Google-Smtp-Source: AGHT+IEOWVreDJCAhWA6Zb9zMGM0Ep8ZtoYXbNbJhScWAxb5UUqEZQDZ24kOeejx3drWf4EUBDskyIE9dfZCe8SyAQ+ioqPyW0JO
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-42f873d62c7mr207144655ab.18.1760278925708; Sun, 12 Oct 2025
 07:22:05 -0700 (PDT)
Date: Sun, 12 Oct 2025 07:22:05 -0700
In-Reply-To: <20251012135649.59492-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebb98d.050a0220.91a22.01d9.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com

Tested on:

commit:         67029a49 Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=16848c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=308983f9c02338e8
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175d3304580000

Note: testing is done by a robot and is best-effort only.

