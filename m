Return-Path: <bpf+bounces-70834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91799BD59A2
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6B4E8DE3
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEA4299AAA;
	Mon, 13 Oct 2025 17:51:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E72522BE
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377868; cv=none; b=mHePoduk/sMITo4HxNSENmcoUP39/o/17YcLErZpUKs+kLpEJGJfAdIw2vRgbK8vyICtnANhsISU6DIXK4QnIp4dhQy98mgs2YBsfGffT/qCgOAuR6c/Vnnt8ul2fu6he7FG2loKwlGKdr+uk1oaJaAtJjxczYlEUjUum/HSesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377868; c=relaxed/simple;
	bh=ESmH6PDf/y025GTVQd9tAUQWKrM82DPTtOLdH3WIVbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jJ28Qa4Ri365UqcXQyXuMozbgqbPFrpljc9peIehd1Yw6NMeHspokFQcJRvMZng+qaaeWSefIAXiuQYi+VQ5oc+XWRuhrfylY9kIEJaBh2by4xDMcmJ3ROR1nkc9RCi/Xc3f+zA9k797uHGHqxfJR539waOs4aGMGzkzFsMnwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9374627bb7eso1390158939f.1
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 10:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760377865; x=1760982665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpBMfdidBE3O+0BxDMwBE/bLozZX3gjRZnFgwoDa/2w=;
        b=LRA60nMW1Z/IVSTDxnqPA5UqxBGAeIrzCplO7xCNg+Bz5S5EPGcv+bi9L80QduiAxN
         Kzq5OYKou7YYmZOSt4pLyXsBb1XOJ6dtdSUgxL0ZMkATjm7O+tp7ErSWbsJsZoQs24SN
         9monwFEyPiPLUHrumyLE+Iu/Uj5MR6zDQoVOzTYzCa4u7GNlBKWg7tLN+K5aex0M8OGb
         Y7SEhOtw1Y3uoHEvgRJVOrMxd2/GdgnL3/MThX71VQrQfE59HeSqY9FVFKYw4o8lcTfW
         r69rkh7n/1KpoJJMtBcrQb71lfaziXyz5zzmRghAXxg0uim3vldMTuHuQeQWOR53JSwv
         AdSg==
X-Gm-Message-State: AOJu0Yw20XhPiwQdJDwe7Np987aPu0G7GfHWkW9WqA9ubQSkM3pqsGqv
	nIoEH8JJWRPYNU5TB4+WSJHPrL8AxNKHhrN0T88MAuCXR8aAbSlwSPKH7MkAAARFZKpOMVbtihp
	9FKgw4faoG9Ztaf433wh9mot5cvXUnD3QnQsrkd8tZPqUswhNdtfwyfR00EE=
X-Google-Smtp-Source: AGHT+IF0mRRqrrYbDkimSP3HVk6dixhTQT3Lv9MBcrqNeYt5SAiNW0Gr6ZCjlr87h57RmW7I20aL5cO0VXaaf/3qxAKYHl6kXh0n
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:424:7128:a06a with SMTP id
 e9e14a558f8ab-42f87417ff1mr260568725ab.7.1760377865528; Mon, 13 Oct 2025
 10:51:05 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:51:05 -0700
In-Reply-To: <20251013162906.1265465-1-listout@listout.xyz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed3c09.a70a0220.b3ac9.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid
 context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1017867c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fd652f980000

Note: testing is done by a robot and is best-effort only.

