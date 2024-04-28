Return-Path: <bpf+bounces-28052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B018B4EC4
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 01:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F2B20E64
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 23:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2570182AF;
	Sun, 28 Apr 2024 23:23:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825D1426C
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714346594; cv=none; b=mKk17hDXmo2g+QOaysY3JG3JsHNMU9R6ksq3hbLIfYuCb/TkrbcW7n07ObLp6BmwTeys3QEkydJjpSeTmR7U03iNCnV1rmBneSsM3Z+vkWFGXegXJw9wjj+SC9ECHsUePBz106cVmmX8oDK+4izaGm0V3qQHTuCrdGJfP77IerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714346594; c=relaxed/simple;
	bh=f5SHVKCd1yLoB3LpdWW54rLqKvQnFndtp0BSi77PSMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LebEwaFshdoIBnf5XnnirnK5rfx+pIq/feY/iyUEvqrrp1gz2BqrhFXSXsDhG4EHWRn2wV4Z9ZqhFtufVRSZFagqOBvNfD20cWj029Exsa0ptpydCfcCGTMy0d5R1igbpfgAdVlXetlnjc21/RCcmOPVRojVOO8eckB8OsTUeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.20])
	by sina.com (172.16.235.24) with ESMTP
	id 662EDA5200003786; Sun, 29 Apr 2024 07:23:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 69199445089247
X-SMAIL-UIID: 471609B53FAC4BECA5769360A9C487B0-20240429-072300-1
From: Hillf Danton <hdanton@sina.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
Date: Mon, 29 Apr 2024 07:23:02 +0800
Message-Id: <20240428232302.4035-1-hdanton@sina.com>
In-Reply-To: <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Apr 2024 13:01:19 -0700 Linus Torvalds wrote:
> On Sat, 27 Apr 2024 at 16:13, Hillf Danton <hdanton@sina.com> wrote:
> >
> > > -> #0 (&sighand->siglock){....}-{2:2}:
> > >        check_prev_add kernel/locking/lockdep.c:3134 [inline]
> > >        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> > >        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
> > >        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> > >        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
> > >        force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
> > >        force_sig_fault_to_task kernel/signal.c:1733 [inline]
> > >        force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
> > >        __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
> > >        handle_page_fault arch/x86/mm/fault.c:1505 [inline]
> >
> > Given page fault with runqueue locked, bpf makes trouble instead of
> > helping anything in this case.
> 
> That's not the odd thing here.
> 
> Look, the callchain is:
> 
> > >        exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
> > >        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> > >        rep_movs_alternative+0x22/0x70 arch/x86/lib/copy_user_64.S:48
> > >        copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
> > >        raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
> > >        __copy_from_user_inatomic include/linux/uaccess.h:87 [inline]
> > >        copy_from_user_nofault+0xbc/0x150 mm/maccess.c:125
> 
> IOW, this is all doing a copy from user with page faults disabled, and
> it shouldn't have caused a signal to be sent, so the whole
> __bad_area_nosemaphore -> force_sig_fault path is bad.
> 
So is game like copying from/putting to user with runqueue locked
at the first place.

Plus as per another syzbot report [1], bpf could make trouble with
workqueue pool locked.

[1] https://lore.kernel.org/lkml/00000000000051348606171f61a1@google.com/

