Return-Path: <bpf+bounces-54092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF98A626A7
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 06:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D2816D79B
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 05:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A9194A67;
	Sat, 15 Mar 2025 05:38:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718318B475
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742017092; cv=none; b=GUjJYD8f9FxyK0A3tkgy/I7HFUmyur6/rjPC7PMqLrUNgE1Dqh2Q98kSbVyLpWyZhZz8vp/wDeVG/MTFaw7TuJgdO7PSFs7Hd1bQ+9yhl20KI2F/YNb/i9XoULbBrpXTmnmva5UEy6rxHqV62ntYkyg3ky+/2tpYTX5BdFag3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742017092; c=relaxed/simple;
	bh=ZDiXjUknHETMzrlYn1zgWu+v7UPrqES23shmZOMFSYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uPw5x6AwbFhET9ow61hGiAJc3cyxvFZlJXu9wuQaxJgd/dbDhJsDTS7Fvu7xMK7Y1Ki1iVfZFdgXxEjOPiSZHTUp+u97wLusVcSFMhzBtSw263a07s25DfZk0Fb6Z30xsbxEW2Wo08sL29tPztPz5bC8K+BBD/ZkgwiBhl9uEG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85dcaf42b61so274941739f.3
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 22:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742017088; x=1742621888;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jri1wgrpQV6ijagZsM9y5nNBdN2313llFI5vyTbWILA=;
        b=bl84WwBs/4NrVWKR24re/cKxaAYfs7ERDuyG4epI+XY5YHbBpB4xdfvV3FHvp2kUBl
         5K1lQQuYa9fvOjBHoB/EPJPm4dFF1CVhauG4GVNwL996xiHKZYEASJAcp/ItD4m4anvU
         slOaUXt4B2ctslMhxfGwy14TruwFK+SOK1dnIDSoBiNfZfMUf9u5FoL7pqRK3EmOVsEb
         s+wGfsapKPcwhhVzas4vIZV77E5Qu8D17HJKpRjJ3DEKHyEyqeT3qmxRmnjTM5MRk91s
         q6fmqIeDrE5Zf27xUE+ILKMdPwU/u8tH9HGANHsl9BY2FCsrwDM8G+5kBevHWcUwK4uo
         jecQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcGPMO1r5AyWPJbGKMYEDpg0ywYGvlRvrKowUDc0EovmoPL71e1n38y6mff0vmueJXx50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/FYAFvSb5+19xdwJd7ngKv49fiSQzwSWlfa+1sNKU82lfsKF
	Zr9IjzKbpCPJYy2isOVwZClLePAc8M8/ENnKEF61zXcPr88yBHRW96r3Lb/SfBm6Gda0I9gfZLj
	gJehGoAfA+4akB8X+aL7PvuSt0BV1u6rYonz+GXD721RSz9cp97ZYyi4=
X-Google-Smtp-Source: AGHT+IFQ+XxRMp/jrAZMgPnZUJ5trjdXbQ0Y0KQeY63eEi4hA6eS3lbN90dOhbP8hV87Q1ta+3ekOz3dCXUnIFG3nJBSxi1Vh+6V
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3312:b0:3d4:3aba:e5ce with SMTP id
 e9e14a558f8ab-3d483a906ffmr53679835ab.20.1742017088726; Fri, 14 Mar 2025
 22:38:08 -0700 (PDT)
Date: Fri, 14 Mar 2025 22:38:08 -0700
In-Reply-To: <20250315051051.1532-1-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d51240.050a0220.14e108.0050.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/verifier.c
patch: **** unexpected end of file in patch



Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ff2e54580000


