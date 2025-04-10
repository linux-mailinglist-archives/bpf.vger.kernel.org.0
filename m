Return-Path: <bpf+bounces-55656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0D6A843C0
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C020617EF2D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BCB285414;
	Thu, 10 Apr 2025 12:53:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62700283CBA
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289585; cv=none; b=AvP0luzMXtK4mAX+Fa0TAL0owRzFFYmqJOhjA6OFg3P1qsyLGakai7W7xEqUmcJeKNlMsXAHxYyC77rnHhMvFLWkaW4Xck3KpJsM+oQkVqhJj6nGLCklWw6WrG+h/xbLV17SOpci0G+sdAqXiUhwU13DUjwpilsp1Yn9fSfwigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289585; c=relaxed/simple;
	bh=vDEmMGrUTM8yYCrPqwhQCEL4t02ezZbeVW8VUbU3L6A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PSKanLkZM3KWUt5e8ifw6r4yyxsSdEaA4yuIalT9gVZCx14sWHVzLPBzLz/cR0ijmPyUrLeaM12QYATG/vHXx8MQTnysWnLkpX3FXylfmyNZ3LoMVPBkqkYpHhBHrYeM/flGin8aHTwvkg4jRsM4fPxDjXnPeYer/8WiUZ68SHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d5da4fd944so16767445ab.2
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 05:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744289583; x=1744894383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwjKGeyplOihDN5WsNx76P9DgKNh/A9aQGFHVxRsKGg=;
        b=QOoMbHbMKS3dO5f2RqnOnWOLo9oDdSf5cR2D3sySA8W0oSoUP/kXG5pAveVet7A4nm
         6Ov4c2svoCep2w+zlyPjCBMdn9mUyOIQUXDY5fRPt8Sl0cclpk29itkFMGULioOcMwGr
         1IQ2xiscwY6xpHXIoTmh7lgkh4EokwnkbLDbRq1NPYg+FZl+4PJICKqqII0bJhTq2S3z
         ATOss4AlemFGhrjDCMlE6Zdpar+AohSrS2r6FzFhAMbuLSLZ12vz272eK+lF/2jspUPX
         OJcrLn7O4l5wT6vHV+0hfIiZ0yCEUSyN5Iy8FRB1bCT6N6Kr6HvJUFu+yhF9BLhLlQuZ
         72Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXGG3GhWt/K9COYzoT5o+00tjyN9u6dcy4/SXjvj6jdmcyXQChnkfm0vzGvnJgrpSfPnJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2oK8UZDmBZNuxsHX/vLjzef04Bu25D1A00/EOL+QT5uLKB/v
	tSqXDY1ojKtEThMBrqT98ROiF6yO9/EWEurzMqnJHoPlWRkZQ7SX9Aax7LEKTzh+sbX7u419WiX
	0WLOj3t/jGbxEbjXvK6bBmyBoaHmXYZ7XZTFkO1/djlIMzWpSz1pBfYU=
X-Google-Smtp-Source: AGHT+IGKKvMad2D5Pe7llo9yGvnZqkSWQ75yF6Q9NeHzwi5dN9/T+3XSEVg7DE3sdhjQgF2SnCDod5Ae6v+BONjR4ZkMlLmcJfpQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2588:b0:3d4:2306:a875 with SMTP id
 e9e14a558f8ab-3d7e46f8e1dmr32898695ab.8.1744289583571; Thu, 10 Apr 2025
 05:53:03 -0700 (PDT)
Date: Thu, 10 Apr 2025 05:53:03 -0700
In-Reply-To: <20250410123831.1164580-1-memxor@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f7bf2f.050a0220.355867.0001.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
From: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         e403941b bpf: Convert ringbuf.c to rqspinlock
git tree:       https://github.com/kkdwivedi/linux.git res-lock-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f46c04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea2b297a0891c87e
dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

