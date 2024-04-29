Return-Path: <bpf+bounces-28071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0908B56D6
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 13:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE1D1C216ED
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458E4C615;
	Mon, 29 Apr 2024 11:35:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73F4594A
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390505; cv=none; b=Z4v7MbwN3elEHDmv5Q3UfVNfAdKU9W7lfLvOz559Mw3gvHi9i4VyTDP17gFz+FFq2ZgvwXqKs7ns5GJ0T7q50kjMPCTtFgK/TupoqMq2+FRgnWjRjP0HDxSr6I49uLK5AJlNPPn2dVGnq7lba4w1csApMnbCom9FfiYdZe7Ixkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390505; c=relaxed/simple;
	bh=5t/XWa1xxp1drVwkM6GSsAal/xvZvXJEe4y56QZM4Xo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RTbeqA+Dk28eQwXdEJ5F3ib1sXBrW275p7kw4vDG8/dJGdxjQwq4OpEB3pmP7UClsHVuJH33V7l8vdse6Hwb0B3ZXb9obrPPkdKtSjS4yDrE0NgXrs+WcmbAPqtK6XElO2mQfxFn8NbUbWQ6gEQ1rPRhFJE6GopyY7Yarnwm0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so491076239f.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 04:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390503; x=1714995303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cXQJdFCWylrOntncVLmvxxqgHLe2rkg1CCfhd+D3aU=;
        b=LWQ413JQ660SbrQ5DOLZ5uFX99i7HuE9BAEd3mZ51QnsKJtfdr/v6On+xjDKm+0dZQ
         BT5yhKYdgQreRBwYzOKNuxmlPe4Harpel7/tg5aaPeHxqvJz5+ZdPuEyJeekt4iQuPZL
         AlfqOTYgHeVuqf3nV9bfxUFL2BuogUr+4de8CyGzLLkS04tqFUT1+QVcKjcU8WviL9CX
         g6f2UNija8rY+WG+twWiSNoAgThZjMdlkkH+bjx8i1cAKBy5Lt1EPe2UHQTIDTMQ5rKI
         XA9ETGaRoaY7jmmJTtLpu2Svur5L0DKhtGmOu5sz3MXal6fxDRIJkOr56MsFZZ80c6I2
         +oZA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Cvc/n5oHGTGbPUHNEGDr1x7Vblc7u95+dKV7qWTgZaJ+ZpEIwGkHXIQ2wHGgVMdQMSSR1dKGsIzSgiOL5gUECVcE
X-Gm-Message-State: AOJu0Yz+OdaYs4j7iiChcknZA/+fXNcc4p7ZMOuQc09uDoRf74Ww3I3W
	UJhfkIXPlS6YItlM1k9hi+WJumvKVFihZN7NCywuq0oFqLYvdWXJPuANjKEuUFjHA7UpbwZ5qzQ
	+88HVVybRQEp+mXGYLDRaosAKGBBa010Fpl4n8dLyXHgnuTOhJBqVDfY=
X-Google-Smtp-Source: AGHT+IFsT8TSPTeMi2QnsVakORE4NzYAOCftb2L9YWW8qgT7sHuOuEia2cnr2kNtV1w1lg2ChK96C0kyF7Eo7cNDXZKS+ZvF2Vb8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8792:b0:482:cfdd:daeb with SMTP id
 ix18-20020a056638879200b00482cfdddaebmr436213jab.5.1714390503362; Mon, 29 Apr
 2024 04:35:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 04:35:03 -0700
In-Reply-To: <20240429103928.4166-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5a11906173aa4b2@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
From: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>
To: andrii@kernel.org, bpf@vger.kernel.org, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com

Tested on:

commit:         5eb4573e Merge tag 'soc-fixes-6.9-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14b4957f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=83e7f982ca045ab4405c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13471b80980000

Note: testing is done by a robot and is best-effort only.

