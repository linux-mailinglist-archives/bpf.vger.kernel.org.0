Return-Path: <bpf+bounces-36833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639E94DCA9
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 14:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B951F22169
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F3158548;
	Sat, 10 Aug 2024 12:07:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B462941B
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723291625; cv=none; b=jDbbzPzPaixCEXQ4+9plIwmEvZqcbOKGb7J15voVqXNBjo5BGLx+Jo9hPXtdj6qjF2x0mRAg6A0MGi//HfeEYuoXGw8lDyoHmU/TMkumxLm6zZJBghkadxp0Xpe6PQUlO0NszTO9EeUGeuxYV+2oQmF/j76DIDEOQr87Sz0BkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723291625; c=relaxed/simple;
	bh=JMi4VqlR6VLRsS45yK6xehSfzEWKZlPxzkPo4WsyD6E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=daCJXJ1SFmBSLLhGCjl88p+b8s02VqW9KCw6qN8061pfxH7pIx9dXCO1wOCum9uhFqgJfFiPgCt4qVvV5qklh0CcN+qTrOvcOJarYHid0pCrls4n/gOxCaKrVbD79KyLwY3pzmfYpW737n1t++1p9z7vRsqWisuCMPvPzQRYAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b3cd180ffso36195405ab.1
        for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 05:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723291623; x=1723896423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brS7xkekpvIr1jOYZCd0Wlyr5RS+/5cL13gt+qEWR4I=;
        b=bztTevO3oNjSbaWYBLAhQsxOFn4wA05xPuS8jcoFQHVX/mtaK6mB1e8Oi0x1fIg50H
         AhekuWVLPJHZW5iRsno533m62r7gG5iAXx89VzRK8pK9eJFzX0x8W7iTmr+JiHm5RUb7
         epHc/M+CO24ETwrd2WBhJFbr+ROVCKP5JIT2ph3iipYUD8T3/XfQ9/v0777ftNgqLTFt
         Yv5o9JJF6EFU/GZXuJty/wKle9J7WU4KLrog3z1sFgOBIIeNgOK9Kt7OttDIMTi7NEkn
         XBccRv6M6c/WiUYFEfiMy6VmE4ZF3fDS2zkWjySTSJQmSUeFWCnXnHK+uNxs/AD4ZCoX
         pElg==
X-Forwarded-Encrypted: i=1; AJvYcCVN652e9m16x+SANJRuVf2TZ5xCR8zY2VU3U94D0WjH3sPOQREgXwTjklldimGo5yMbf2T20axFXsWKWlkOXT76yhMW
X-Gm-Message-State: AOJu0YxeuELw6Z6xNjHdMfqI5QN3bYqDUL5FUOgJAK4/8eIyM5I0xryk
	nd2m8sQa0Pfi8fEwpInGLm2NSrZZIWbE5x+bSri9ahENFGdu3culeBWVmtA0yjOScvUopoPEXjj
	0HXwvX4blNfWdOu9xb6jJTCw9aRG2FJzilTaAdEt7ff7egwoVLHiPzJU=
X-Google-Smtp-Source: AGHT+IFy+VeqXqzz/19A1XE5ksRo66lpGRBRIcR5gsemJWKDHHV8VcCm7/3BuhZRoKjTALyu3JVCmRt4uDYiNtIkUWqL8gt9FFWm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-39b8134a48amr3691455ab.6.1723291623131; Sat, 10 Aug 2024
 05:07:03 -0700 (PDT)
Date: Sat, 10 Aug 2024 05:07:03 -0700
In-Reply-To: <0000000000005f5a6d061f43aabe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a9b85061f5319be@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux-foundation.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 634f1a7110b439c65fd8a809171c1d2d28bcea6f
Author: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Mon Mar 27 19:11:51 2023 +0000

    vsock: support sockmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d3c97d980000
start commit:   eb3ab13d997a net: ti: icssg_prueth: populate netdev of_node
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1033c97d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d3c97d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=bdb4bd87b5e22058e2a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a1b97d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e7b2f3980000

Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
Fixes: 634f1a7110b4 ("vsock: support sockmap")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

