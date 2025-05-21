Return-Path: <bpf+bounces-58670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF63ABFD18
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3DC9E0993
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 18:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB5C28F92D;
	Wed, 21 May 2025 18:58:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2D27C157
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853884; cv=none; b=C/3xOIjnt1W7QIpa/M0LRxMbLlzBvJcin/6/CNYsihqz7A8wV+ZxHSHRVOIjY0S893cazKIIJVYmURQ/pAz+py0eggE27ETjPhoqw54JNEeA/L5Fp0Ml8/KII0geDiKoo6OVIrvItLyjoaeCFz3+Hxorah10O88nROf4N1+lVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853884; c=relaxed/simple;
	bh=IIYBLz5y0lJuE+esG9JSDGx+EOrG7hEtCwd5A8t+qoI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FVFVJKjE7fZnOriQoqGeOuLsHBCW1WhS1CfEIFfK9ZgcPS/NGLWe0VjlrPHDyBPAAyxnj/8COFn/oPdlpt12U+mR4+roAeWW5r6CzUcV+jH4RN3hyCbtiuPpS5WqxGd4Y3n5uAgQGaK0i1Xw0BYiONH2w6PSNlvSVVNZsfEHp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85e318dc464so1091790039f.1
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 11:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747853882; x=1748458682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nB/8d55nWyugqS33sarTI4rY6RGp/V0J2j5OKmFWsrE=;
        b=O8u2oA7XJJuinImyZGMPqyc6BSk+tQHh67y7rmK/84sZfTOeXjp+w4DaKuvJAQyWnf
         n2EaPn/fmk2L1Njh/TDUiNuURgRjYASC5KrNMWxPUBhHtkuPj4zj06V5JqZMQpl20+5t
         iOYoUThgJmZ6hv2A8/QXw2AU6wpH+crp+fhHoF/W/2r++DG5Xtik5k3V3blD/t2t2MMW
         +K9i7Itf/K4U5/Mne6l0mwpQVKkPR6eb5ptpriFq6dO9AXLa5VHFgHGzpQuvV7T7otb8
         zDTc0FgTUO+EKwceNrWuQX/VhbyxJoWMied453Hi5wf1ToIQcBz7frKpspWxqUK2zPE2
         8peQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy4pgjpurLiZfuTREfT1oyz9LDr0BTw5iyQfGz79ihdIWuVP1anODoUliREOyIYQ8mZxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyisXSyyUrXpRwLee/p9MFYBUnNUr/XcwMHjqEf189aL5fA2aEd
	FhLjid04IF1QvF6sXDOKH18h/gU7aBi0nBm+qUxeCWqO6NomfY3FOWzWxUnvRTQLgCm15pDIK0i
	p2EBZqco2aKKe6r3O9BwOQRjEnzL2bgrQYO3x44sLSAb8SYOh/9wpXrYhNpc=
X-Google-Smtp-Source: AGHT+IGZXy6uJ5JwUj1EcK76bd07+C3bl4uCX+YCPk9hntjnxboB+d/V0UrafDL2ydl6zRFBIcD1bTTdjsOfrSGgFWGfKdAnJzAd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3887:b0:867:d48:342b with SMTP id
 ca18e2360f4ac-86a2322a7e1mr1570254639f.11.1747853882464; Wed, 21 May 2025
 11:58:02 -0700 (PDT)
Date: Wed, 21 May 2025 11:58:02 -0700
In-Reply-To: <mb61p7c29zugi.fsf@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682e223a.a00a0220.2a3337.0002.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_check (4)
From: syzbot <syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, puranjay@kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com
Tested-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com

Tested on:

commit:         4a95bc12 Merge tag 'rproc-v6.15-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125d60e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f68e7ba43fbfd48
dashboard link: https://syzkaller.appspot.com/bug?extid=0ef84a7bdf5301d4cbec
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152c4ad4580000

Note: testing is done by a robot and is best-effort only.

