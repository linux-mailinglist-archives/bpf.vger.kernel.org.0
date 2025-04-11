Return-Path: <bpf+bounces-55778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370CA86577
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DF94610C2
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E125B678;
	Fri, 11 Apr 2025 18:26:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9F25A647
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395965; cv=none; b=geq8vrLiZ0cg5am4eAqnsDQ5qI6VlzXmy/HUPjVNsckzwyr0bzzrPOyk2O2GOWK6WZqx/e/obIlEmPxswqIhR8O9raKpv3uhQr7XSfBxvUUELMQ3Uxb3fBSKPGj5t5JqMxzwqLm51pFY6713vbDbjtS3cCjU3wPPyOQBwP59pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395965; c=relaxed/simple;
	bh=FbuPgtFhOayFXRCeRx4jaZPr2zr7ESJ0SMJ61nHuDP0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=meoNbDB5CpUbMTFG8kPUP6hSjYVxVoOEQjGTQqfy0ZbWHzhJFxSKyu2DcQ8RB9hOE7O2Kf35fBC+Ti4JzBC+jVsSzhN7zS6nLvcVQXp4+t2sM39EgcVG/jMPB0ZyZX001ONfAAE+BGWXuwj40n1FVQQy3wlCOs5jiuGtrylW+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d43d1df18bso23808325ab.0
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 11:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744395963; x=1745000763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oep1B6SY2KQszl07sbFPKf10Dwezvq6DfuJGojLWC/Q=;
        b=H5XdS6Yr/ktivn3Gzw8nrqrT2PLLAh/Jx2bmViaSq8+ylxCG220HpGu8aLUyPA1qQG
         xlZ3uVL0XT6aKv6B9Iw/1Rv3DguedRHYwpeqp69iRF4ZEIElC0XDDBM60GAa51pjoMSW
         5f2cZh7JjmupENMFJ0xi272xzMVpRxKgiJ5OFwWHchMj0bG0cwoZiJin8ynXDjO/GDho
         c+h0HVsQ6a+Vnp6FqCAoVCONiHE9y9Z/UO5rx8uyaIGnU0/cJPSKe+ddzbkoKfLhvYQO
         GaKuwwZsstw28wPwoDkw1pvcGH+YFgfCZsfXbcP5RWbkt9XIXy4mbIho9r6AI5ac1M0G
         2IOw==
X-Forwarded-Encrypted: i=1; AJvYcCV8WMqX6MPvDO2aUHedwoq0BSlzp1jOBw0X7BbaQzlko4dgvzfuP9p6COBe6UEJW56lwjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytu5lBBT6eWgmqGxUB1XTmfaMzT/Fbd1MDaAq7qnBaaPm/U6R/
	+S1WElXiRgpIQODKxQ/QiOa9hAGrwkt8mfvj6UWqhdFUe+h6DHgNVox2+1oCUEIqE+CTO+OtKmD
	jKaMuOJeVAg2eZ4JM9yBaDygUsF4Z2LcJ3WtV88lMoDKkSzU12KF7Beo=
X-Google-Smtp-Source: AGHT+IEF8NVjcw48tJ2IzsNR2+B21DrKyj5N3+MwQw+yUyD3QPh0wu7ffoDgBXqWyuUk2peJinJNkjCNdJMxdaiJbpaISygUlD6M
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:3cf:bc71:94f5 with SMTP id
 e9e14a558f8ab-3d7ec27b01amr48319985ab.22.1744395963111; Fri, 11 Apr 2025
 11:26:03 -0700 (PDT)
Date: Fri, 11 Apr 2025 11:26:03 -0700
In-Reply-To: <CAP01T74p7xy9riqMYiaZ563p0xd=QUWyPseHkNe_037wAdnu3Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f95ebb.050a0220.2c5fcf.0007.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
From: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@meta.com, kkd@meta.com, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, memxor@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         a650d389 bpf: Convert ringbuf map to rqspinlock
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=17928870580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea2b297a0891c87e
dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

