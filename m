Return-Path: <bpf+bounces-38336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258049637A0
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 03:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C181C234B9
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F40210EE;
	Thu, 29 Aug 2024 01:22:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480749626
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894531; cv=none; b=dUfMVo5ZhtVkS7slEDkWMgwNUzlXXErtx6VvjPjQNmb29EZA6R/yMpuxJAP8ovK+g+PFUQxj8Y68pnaqGbljkGkeCw/psVjVdnXK8cOQbIvaFb9CTLmHgPV8Oi4SC4+t2BVccG9S8UqEWkVItoRsmmyCvL8FtJ9Jg1ch7GGZ+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894531; c=relaxed/simple;
	bh=Hb3X4riTxNkNCGjBLuPrCPRcXoa2jIrWSholPAoh3Io=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WLJEbk7mmWIPIUxwwdy3wsNR3jwXNYWf6nxnIOZmRHb+aJgy4tTzxtY+DQHxmuSS1tBcvSPdq8aZceAiZIBovIwc6WhetrOCvHdslNsOYRvcjHPdBk8YNG/dP+xdGgUxrwa4WT1G3sOK/TGrzJM+pzcrt/anIxIR8vOhJj2fJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d415635e6so864755ab.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 18:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894529; x=1725499329;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb3X4riTxNkNCGjBLuPrCPRcXoa2jIrWSholPAoh3Io=;
        b=UWMwD5oMjFzogz+158Gfy00uYaktbRojKuG3s4J7UVg+mZsdSdFnQzucZShQ70ZrDB
         m/cZWfPbeHec8YbXGYULuxxzNk22HdLK/AtVV30IokL3kTc9Da2pin6kl12Mx2XeXW1e
         lsn6Y4Scjks5EpJWFDMf5L2EQaM9vUqqUoPwv7JVl/WWSsyVz21wXZRzvIdINAEEA/h7
         7HQDdBY8v0G1rylNu8u4QCosH9p0o72jnGMxbZ0MzH1ePqEEMAsihfD8KmZTf9+YgckR
         y7rh9z+HKdfBDI810EPX7YLuIIQ73E5em+dzAIX0L5OTOJK8vYGCV/Apnr8l4/I0/OJi
         1HBw==
X-Forwarded-Encrypted: i=1; AJvYcCXZcfKkJg9HzaBtSZSjqwbFEBnd490tUVYvk5mviOLPbVQ3k6PqU2rx9IgZDZyec/tHj70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkchzVKa1WWR20FIEgC44SYzYRgoNweJu1HsCO1chfBsf/Gx2
	yzTI/mc+h6PKxpfQK6VF7Sl+LZ4qTBaUDvzlsEkUmgQOmoVXIDQX4ALlhanCZ6TTUTo2Mujxe0F
	Ny7VsHcWav+wRvAdZrK29LFtyc2d/xpIzlK7zaY1dkJLqgCWpoAC7BjU=
X-Google-Smtp-Source: AGHT+IFuqjOISk8w82jhntsUK1kdIQ32umdyDv525CyNKmwfwqscygSKVMvYLjNnBCgMph+dwaZLSDjgD9zEgt8rkikWy9dSB82i
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a88:b0:39d:1144:e784 with SMTP id
 e9e14a558f8ab-39f37861981mr1047755ab.4.1724894529487; Wed, 28 Aug 2024
 18:22:09 -0700 (PDT)
Date: Wed, 28 Aug 2024 18:22:09 -0700
In-Reply-To: <000000000000ac237d06179e3237@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b496c00620c84d64@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in htab_map_alloc (2)
From: syzbot <syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	houtao@huaweicloud.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=061f58eec3bde7ee8ffa

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

